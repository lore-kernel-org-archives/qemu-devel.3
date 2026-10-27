Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF02606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gV4BMD78;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgWoOjOw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiJY-0007eA-2Q; Tue, 27 Oct 2026 10:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJI-0007KJ-3H
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJF-00063v-JB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo5mf2881633
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=gV4BMD78EmlSGcx8
 J4v3YwowLTN/Eme1cpERKsjeg4thiKsJePpJ1fn02GuyuU71SRORrxLF2jpJkCVE
 pFLHwgw+1ZqUP8rwKHGA1tYpm50QV8x0yzdC15TVMCzZZdEQVGZYzQVf603FbGSL
 kBV27YUNeRezYA9byTmMLbN0zQoqD6/ElOJtZ2QMgxxnvLBV/vZtI1s43BrKWB5Q
 5kXuvZrC5q1F4mMsyfWsPPhHKd8csLN+FrRrV7/Pf05OBoTvBDTKhR5lWwYU7Tpd
 gTSDDsR9I7LXm9Q1lVwJIfWsrYVpNKrCMD0w4ixpjuVFdvT+cL1CK1EmCGI5sGXA
 /eimGg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtasth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd68bf391e1so2685330a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111872; x=1793716672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=ZgWoOjOwlxnBTlYDYeJXKixZrth65p2pG30gp5nPI79lYl6ehsbwyVRPX1iBkcyKG4
 pT71s4ZsU3OTofyf96Q4N5n68CN9DQVrt2WyqKjbC9dFVQBcNrmg7uwbBGt+rd1dA2p4
 Xz6RKaN6W+Xya0wNwaiYl9JnbZwHXTpsqT12T53bBqTEaJUVKc8vAtC13KIJW7TK8q4U
 ciL7GTiMpqnkTjZ9rDiKVtLrJTtvn99QX9AiFCYJsYx49iu9IzFVAv9JC4Mlxo6pdfdi
 SxVn75ZeocOqhr8wp4iVzapSeMyNbqWQMpk3JVHTeQ2fuHN0EUbg+IV1C2tWy58iq+P6
 VPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111872; x=1793716672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=VcJdiuX715LniB+VAElA5xdyaOsUGnNUaRKkGLJVmpOLnQ6p46kcjGZ+RO/JjPnvy1
 MZVVtfFCWUJ/zbrIz+88r/Ch/0rCH8jiaO4tWcsugGz5MuKPgC3tIpwuqHVHpiepWFWc
 wuXxHZRhyQDVhEDvE9EX6WfTggYcfoLqMkrQbTBhfPh3tXWXtn5qYYQVeRle90qrr+m+
 skixinpw2oFc4nf5nmlYfFb3hwL0BXFpLCSGpYlDg3Zud3ywbAiHN/U71iPs0pvgYwhg
 +Gy64MFskOmbMxDK2HPlm2AoR3UEmUgrNdqU71CHGCdhkRxDZqIbvzLfQ9xfG3o2EX+Q
 TNMA==
X-Gm-Message-State: AFq9FYKO33obwhNcI2ScEzpfhErZdqxpVyg34y6CFy5PGgB/Wi2TVCwz
 6Ps8uywn5tEgr84QAB3z3HkszrHOg7u9AoE0awSfKByaaaZYM+Ba6y3CgJQwDdvum/NWJpb08Dp
 S15+2VoNH0nAImOW9ERbUW2DnO7c3AOa3kkGWw7NDfgyUYylz7tuHt80UDpJhj5643Q==
X-Gm-Gg: AYBFou2ayne8EJwC9Q6wwEYax/OobPjc2qM8PPrMgcynmTvtb+79ZhGXMcwrN1e1Fv7
 NvmPIaZaWV22GLCaerb3Yq3zlsmL4gB0Nz9iuwHt8HRzSV8QWAW+pt/BE/AnarWF++G//yBgb4o
 +h1fdffzu5wzz3J8JHWbVM9gaspL5QDtRCFTyOV5ZZVPnG6jGP81z6gDK34/q1WPieeB8f+brji
 GVQsDJKKnEAoIwkM+rhFi21i7ye0eZMxSs7SfOXfDf44G+3S9+w8N5gupJf9uJPrlBZTEs7AJ3P
 NjRqXrWwOfm2mhBYUVbcyjK8t+JBKk8i+/bZzq+duzj3Cyheg5UR6pZth4NVJI1Xb+/MERyuIpP
 FErT2ngssNH9EuMNlKmBS+8h//j7alAoh3x+8oZp85CvaiSw=
X-Received: by 2002:a17:90b:35c5:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3adeafb079amr6884143a91.34.1793111871574; 
 Tue, 27 Oct 2026 07:37:51 -0700 (PDT)
X-Received: by 2002:a17:90b:35c5:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3adeafb079amr6884126a91.34.1793111871123; 
 Tue, 27 Oct 2026 07:37:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:37:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v4 11/42] target/hexagon: preserve callr target when Rs is LR
Date: Tue, 27 Oct 2026 07:36:50 -0700
Message-Id: <20261027143721.4125584-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX4ed84nJO+kDY
 98PkKhuvYJgghxmtSydYxm1UgxBJ4KebSraE4rKlQhDfdJU7rTt2AJJ7G60rW0AM5zGJEKpNznW
 pQtd2sEYCAiUklVxhkmxHGrDr/ZJXaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX8f/uIFEjOrZ9
 x2FhNVNySC05JmHsExC9PG1aSMiaRxms+Bu2vF0i/b933hZ7HcDZRYmCCshDrwkaIXFjrJvs1Jk
 mDBDQQ/A3gUwJCmHAt1gf/FEUPDwzg3s/TYtmL2ckSH6vCrSV3b6nBh8NETdfAm6JO5NcrlEyBu
 UuA8KoOvPc5gXgUAcXNq2jlCHWc1zjHxMzqSdRUWn72nPD6NUSDR7DSbm14xXeRSu7q4Ugit8BZ
 OQrHpmN9wIrK4sTkphc18+49RRoFkw1cjthhpuR+KEF2uDg17PDDXdS86NWpuot4dAjSY0eYfkO
 IJu+2ivXOllqYsX9mLqfnZ2lkFnV5sN0rSPVnPA1c4ZjZywa3J8xtYPKihteVs9xwlc45OYT1U+
 2oFwv4WgkPp0L+P4XZawe/6OlDLAB+iQLGjm/NXg/zwvsUAkpxUxhhJqgXHNXxAGUAqifSlwxh2
 xyrrOUE5O8CKgfcDaXg==
X-Proofpoint-ORIG-GUID: DsM6tZEstdAi5LacvWKJ4Bob83si04l6
X-Proofpoint-GUID: DsM6tZEstdAi5LacvWKJ4Bob83si04l6
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0b740 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVs
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IGQyMzRmOTk0ZjQ2Li5m
MWQwNTI5ZDBjOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTEwNTksNiArMTA1OSw4IEBAIHN0YXRpYyB2b2lkIGdl
bl9jYWxsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcGNfb2ZmKQogc3RhdGljIHZvaWQgZ2VuX2Nh
bGxyKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IG5ld19wYykKIHsKICAgICBUQ0d2IGxyID0gZ2V0
X3Jlc3VsdF9ncHIoY3R4LCBIRVhfUkVHX0xSKTsKKworICAgIG5ld19wYyA9IGdlbl91bmFsaWFz
X2dwcl9zcmMobmV3X3BjLCBscik7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGxyLCBjdHgtPm5leHRf
UEMpOwogICAgIGdlbl93cml0ZV9uZXdfcGNfYWRkcihjdHgsIG5ld19wYywgVENHX0NPTkRfQUxX
QVlTLCBOVUxMKTsKIH0KLS0gCjIuMzQuMQoK

