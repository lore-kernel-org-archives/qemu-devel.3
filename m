Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C9606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ISyH//KG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gFKdoGmk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKgAR-00068h-DU; Sat, 24 Oct 2026 14:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKgAL-00062P-6R
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:08:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKgAH-0002Jr-Nd
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:08:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExrQf1353442
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oM5kbrrpgv9AAX1DwO6K0M
 7xR1jtRBwC0nrV+OpNBa8=; b=ISyH//KGvLYBK4uWemxoSWHceqHyz5/P9Jiwdq
 bFCxOe0tihFfU2r3ZEtJ3E8clvL32iTag+gysJXP4Op26LUFuaSRPY33nXbh9Vlu
 vxm/nBWEFJSwznwBqwCs8Iyth9G7HlnNXrUeVnp7gZ+Eb09PzNoT/at8c0ixK7Dl
 MwjPs0gsKwIy92hoCE2JAJNFUtDkNtDzAal4AVJY5mD35QUwp7M0CxMElCQM7wX8
 eZaGEkQrewFCUfYaVhiLvrfhener08M6xXncxfdjE3IdYQxf+5A9U5FbB32Q/KfD
 TcgJRcXzb1z4PkPzxU37HZpEmGd9TWUCPk5Hi1L1KTRb4cRQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhdy3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:08:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so6503575eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792865299; x=1793470099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oM5kbrrpgv9AAX1DwO6K0M7xR1jtRBwC0nrV+OpNBa8=;
 b=gFKdoGmkn9GxB9xRmCgN+5zSKCtaHhzFpbRhsMpGFxHw28vyukzW8JcTfIIvIyusY0
 Z8P6py7A0SofF5JsX95wrAmE3QHHo+YeCb7+yy8+WPW7rMV9ssslMhUMd5XFWwHBgLXg
 R0aGt4NnFX8iHETgZ7OAacZTUj1tc0YejS23FhytBlE3PEnD3g2/rlCu9W0CdqQbujIO
 QACU3yA+AL1nbH4amMdk7X8ID47nS5kBwxD0PNmFcWtf/d9AQPJWnTyg5XCxupX/30dk
 sFwPy9YV36QvKWdyBa1eUxpOXFrB17RECeK/qcIS2se24aK21lzS1MGDmHuH+AFhkzSe
 kpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792865299; x=1793470099;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oM5kbrrpgv9AAX1DwO6K0M7xR1jtRBwC0nrV+OpNBa8=;
 b=11E6i8fVth2BvNpAZB+18TUx+SxWloe/YEpU2uLlVJyKAwTiB2EPVMTlLDjQwrK13U
 ogeZQKTsLyvOCl1z4M3+DKh7I0TfK5pWzvMU1MYBRp+Si0K/qRCyQXI2Gtkf22Xqgdux
 OFJRnNoMWQP/tvOP5gfvzgJhq3wzlXGCu2/wmwyMW93G8auaha5Lx5ZdNpqJAsNFMx/E
 YiD3u4GMKeGDunhYnzBTx2FEqOVTDUQPFYQSH+m/1NFXhmwy7/pmi++lIJHC2Rer9QM3
 8nfMD/v9lh4pmhggp+yIRghpqga7AyEG0Wxq6GxlpUaVrBdSLnRFc8evJCTGs2Rc2gLZ
 1lSg==
X-Gm-Message-State: AFq9FYJGXrmZvlo5S6+M9OAYIw5ydbdB5sfGT74dY0ruxOw09g8gFU/e
 9A1dlJLXVRtA8P/shot6mtGOxJsNuhcG6OBjxa9r9OtGSrA8x+rSMASHB1LMq+5Ruuq8QqA9nMG
 ywExhFYBrBwLlhCe0iCEuiDDqFFrXbAmQ4zMR3gu8aGuiJ0+CA6H1CQq4cleUfmLlew==
X-Gm-Gg: AYBFou0A1aBS05FyWk13JqfNktjBQTjCvpcrq6c7skbNz+GmGckNlVA1be5S4ot0+L+
 D941A4j0Y5k4GshsudGmUmOfhganNrZ7gdBQsfBRCmEhVG5QsQrczL6DWyM7w/IJrR6ory4gVyr
 /N+jFT+aRMKpjLIJPescqbYOSbc0p8e27jrE8xLM+k8NUFRTZHQ+9IAi85dSeULdXQYeeC7lreb
 rw1XFMRCmq0EwJXbnaxQwOB6npH77qPPnC3l0a1/6iVHt0mdidaCv++GFTWzVqV/TdFqqcONUa7
 pqP8l3zHYU8BQvnWD844b9vXs2/LviUcvy2ngUEP15k3mVYXXV74sQqDF1VBFy3tTR9KvI2fEcM
 p7GntjDJ9Qn+VKoBj9z+GM5g9BQYObCtnpn29jsefIS9EJmUY
X-Received: by 2002:a05:7300:a211:b0:369:f038:c9e7 with SMTP id
 5a478bee46e88-369f038d6fcmr1633857eec.4.1792865299113; 
 Sat, 24 Oct 2026 11:08:19 -0700 (PDT)
X-Received: by 2002:a05:7300:a211:b0:369:f038:c9e7 with SMTP id
 5a478bee46e88-369f038d6fcmr1633822eec.4.1792865298480; 
 Sat, 24 Oct 2026 11:08:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369f27d5bf8sm3966963eec.4.2026.10.24.11.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:08:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Hexagon: Add v79, v81 HVX fp/vcvt instructions
Date: Sat, 24 Oct 2026 11:08:14 -0700
Message-Id: <20261024180817.2037169-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfX4ig/5DcfoFOz
 oRxMPD0T+QQdKNpadFJOL7aRlEGNNwDpV/QqL68CfUXPgPv8uKcX+gUg/jhOWC6YT3xk9r2mIRO
 IRLKdolRQs0bz+GePx+Nz+pEmmBYHEs=
X-Proofpoint-ORIG-GUID: HkY_szGs-xdhVLdSEWzEpVs3cG8wJ8yf
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adcf413 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vs3G8eokVA2NTI78HyUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfXwFAX5Smw2iSt
 HrojuJu4hhJqikDLlSk+GWpw9n7DXiD52BTF4LVpCgo8eHrTGjmkmhzBfi3UjMLQxyiSmizcUBw
 I8rBP+E5qqY+hq+DlwLFA7f5niTGVy8IOjgukHtMfDTNxxR4r8076F/HKosgNe6CkNpisck+N83
 VcDmLOrU6RsKSjdwZs/ybTF/SKaL9mm84VGLY+QngJhmxF8KaGF8Lvqkkbv61IgTqLit4mI5xnM
 0NQExsFUULk/dYWMtit3BxJFbsXbnwZNd5xhE8U6YxRw9m4j7JXzz24x3EPR9hrRxHyrWBcnUnm
 7uO//A8zNr6TZO16q7rPEqeG4Karzg3OdISFMB8wBfum4+0A+N9TayxdlL73TGn1sBvQC6l6kFU
 9gOgRJFgwPkVc9mJlJOQKKk2hoVR/0g9muagBbn56tGSMcHqGxJSXydgraMywpSYeTQnfmEc/ND
 vMlrH6IKIV4vAnC5e2Q==
X-Proofpoint-GUID: HkY_szGs-xdhVLdSEWzEpVs3cG8wJ8yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHN1cHBvcnQgZm9yIHNvbWUgbWlzc2luZyBIVlggSUVFRSBmcCBpbnN0cnVjdGlvbnMuCgpJ
biB2MjoKLSBtb3ZlZCB0ZXN0cyBpbnRvIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBjb21taXRzCgp2
MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyMzIyNTgyMC4zMzA5
MDUtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgzKToKICB0YXJn
ZXQvaGV4YWdvbjogYWRkIHY3OSBIVlggdmN2dDIgaW5zdHJ1Y3Rpb25zCiAgdGFyZ2V0L2hleGFn
b246IGFkZCB2NzkgSFZYIEZQOCBpbnN0cnVjdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY4
MSBIVlggRlA4IGFuZCBxZjE2IGNvbnZlcnNpb25zCgogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4
X2llZWVfZnAuaCAgICAgICAgICAgfCAgMzUgKysKIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jv
cy5oICAgICAgICAgICAgICAgIHwgIDIwICsKIHRhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmgg
ICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5j
ICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5j
ICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAg
ICAgICAgIHwgICA3ICstCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5jICAgICAg
ICAgICB8IDE1NiArKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL2NoZWNrX3Jldl9nYXRpbmcuYyAg
ICAgICAgIHwgIDMwICsrCiB0ZXN0cy90Y2cvaGV4YWdvbi9mcF9odnhfdjc5LmMgICAgICAgICAg
ICAgICB8IDQ3OCArKysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxvYXRf
djgxLmMgICAgICAgICAgICAgICB8IDEyMSArKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9p
bmZvLmMuaW5jICAgICAgICAgICAgfCAgMTggKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12
ZWMvZW5jb2RlX2V4dC5kZWYgfCAgMTggKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMv
ZXh0LmlkZWYgICAgICAgfCAxMTcgKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgIHwgICAyICsKIDE0IGZpbGVzIGNoYW5nZWQsIDEwMDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29u
L2ZwX2h2eF92NzkuYwoKLS0gCjIuMzQuMQoK

