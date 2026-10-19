Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7E606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V9h2GWsv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LtA4zizE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvui-0000PG-Jj; Mon, 19 Oct 2026 18:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvuh-0000P0-A9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:33:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvue-0003Pj-Iu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:33:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZQWo792189
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 avkw4lU8bd/utLg8dgqo5FawIDnPb8j+Lz4+rLWYkwc=; b=V9h2GWsvHJG+LKXr
 uvtWDwlRLbt3E4qtgAh0+0BDuRKQI/q1UncHE+aDXt+8Alp1R1crpMJpjyrYETmT
 GfCf2FYkNnkBAAo2zSEZcB+dYjQJ/TGGXn5ZKR9f0VxGZRJ0jhRbzHmpe29YyAtz
 3wDJoiOk+T2D8DRSB+pb0HS61QRFAfoZxXzs9kVrItU1qFr6ZgOqByCkvgYRQ4+p
 LFwwVOpjmt5KrEjAQLzN13JDhJyBQZ144mLPmkERGpI4UP47CLjrt9Y4WK86loN/
 gONo6HsU2XAGe7gNWvBTKxozi79XUsfQ0UP2/qLB3H6cwX19/QPkYvCtChXb3Zw3
 2u01Gg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbhbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:32:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso7531165eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449178; x=1793053978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=avkw4lU8bd/utLg8dgqo5FawIDnPb8j+Lz4+rLWYkwc=;
 b=LtA4zizEwcB4EQtLYTuFcB+X9ec5N6fsY0hX1/3UAs430odkysfS9Y7dsqHGvlzSuu
 li5JM/QdLoHqU+hdpkxP8G6royzwWgDtu61Z2nuR1RBJRjXYbkzNrXdnV0/uUeWYfAFe
 SFj3RV79gGkBgq9pH++91OcvocAGzrTg2/pofMuAo3USEAQbxbD8K9tSGltGb8wkOqwy
 gAHfEi0+OSVRjk1t/02pfJgL3N6Gg88LqKao7Oe8MRFtam6LNZ34/r4bhdkmFzmka8LD
 WysBa5S1SKSrahH0vNc+EZG2CnEwSJnHp3nmj5bjQ4XCcUzYmXCwennG628G3EwtSHK1
 vGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449178; x=1793053978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avkw4lU8bd/utLg8dgqo5FawIDnPb8j+Lz4+rLWYkwc=;
 b=qYLt8dfSadMtgSA5LY5ZK4bO8NSZD7Dh86FyWyFaKSmte/TscilAPXZ1eEfgZ8WREv
 rwwX2W3IaCmDqG1qm1ya7+nV1IeM7dU01DOEqUz3CrkqHH+T/cNgxVYw5L9azcHQxrTN
 xbh8kLQGYNgtnZWMmkl2h+U4KEcrfi7B7bZA/w/Z6IQlOpGpUX5W4J7aJof+os1A//+P
 zREPhKRAhY1tmVdm7OfKAYRUyEWYbCoI1KPMaxTlyYWZMsoOPUCMYq5uMDjoCPfc6lDc
 rHrnT4aQ/0iTP9HJ4epLXb9kqIRLRcfDrlRf/ngI84zMurecXse3NXFbj9KpTQ8/CIjd
 DENw==
X-Gm-Message-State: AFq9FYIMQKeXGaFA3X0wmsdPuqNvFziZ9mGiUHJjBLGUWtUdL04mny1X
 oKGuYv2HPWzRV4PW1jB9zjy8djFepZZyA1ooU6slo3Iw7vO6H02p7ckOVesvsCUwH1fii/Y4lG1
 PliqZbsJPPP8SfitUOoYk5Y3+basQ4ag1yjOjhvzmL/cWaTic9tBwTPGilvFWc2tVyg==
X-Gm-Gg: AYBFou3w/XOedEeDFoQhLEFlcp32UfnBfIXjBvBM+DHQuPIchOiIJAEuHpPjVj8exsG
 JEqpKI4VceyHGszE6YytkHmkaL1GAyNQDRW3j/HDz8h095jXF4E6V11uqRNsoqeatfuHWJQzuQh
 i2hrIPx035DDKMOGxKGEkrYRUFYvYu5bc0eBTPOjdDFD5cvz7Tqf+u8UoJjzUwecbiAwj7Kmz/4
 HKbVen2TeSX6Fqn3hL/wUEpX/ETgXvPLufU3562ddFKfaviR5fQIyVTT3TYJZrObavrOUSF/eM2
 oPfJEJ3y5zyi9eCLgQK0/FOsg0DbM/fq8N2sQlPk9M1qvBPJT875rY77VfRqxvcTdfpwyIBL3h+
 mKl4UzYssspxlhPHE2BJBqCOcqBqrF9q2d4MzM9Pj308yNRo=
X-Received: by 2002:a05:701b:4584:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-18514634414mr11901371c88.39.1792449178483; 
 Mon, 19 Oct 2026 15:32:58 -0700 (PDT)
X-Received: by 2002:a05:701b:4584:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-18514634414mr11901263c88.39.1792449176081; 
 Mon, 19 Oct 2026 15:32:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm48294319c88.11.2026.10.19.15.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:32:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] target/hexagon: assert qfloat shift
Date: Mon, 19 Oct 2026 15:32:52 -0700
Message-Id: <20261019223253.3243067-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
References: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: lQ4Lyy5MbGsMjaUUCn7N6a4TN1glVfww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfXwxowl8+OdyrE
 okGPmmK1k/igwGAD+LTrvIXwK3n0XLUaWHYFLGA8IBpzlsqRPtXVAx3ce6ubKhBVjVh/2zHemso
 a7Ek4a1qmzQ1y4LxKRaKhXMeF8XqhEhfC1Tf+zy8hyWsS5opyIHeBtpaOOPcQumNyWLL0TT+3K3
 4JcbuF40eV+XPoCksb0M0mToodOsKIw11W3iV3ymbDVJbblTojb+IIFC+8HLnDItVvu1f9pR9f4
 R0XZ72UffIXuw1WZxvO/FzowsQ69rhbXpbBBtM4MJ3Isy5ybSVWXlT+lXQBHFq8lc4ffGpRgyBE
 Nq1K3TTM5WQuOCvZMCG4YPlv8A2f5kqewPvDN9NuUBa21KQobl692SLNYCiZ63CJz4knqUDKHOV
 sSEaND7dkXv8paRUq5FYC2ENAaJtEUqCyYCX2Zvlt0RFNmzYIoD+wKZ0w4mVjE1YUSX6HhH2Dd4
 Ybuz+zjFnEp2HiMNuwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX+VH5+i5CrHO0
 19nOvE16TmfIJkpJ4JwnIMEknS8KXgqMzlpuNtpW+2icUnzIWZXnA4s4hiS3eFq0OuU+QCjv0ji
 dksNvKUrH+1wXYbEtXCi6FGMhgYvQJM=
X-Proofpoint-GUID: lQ4Lyy5MbGsMjaUUCn7N6a4TN1glVfww
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad69a9b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7yAfEa69Y000KskGGPkA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190089
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIG1pZHBvaW50IHJvdW5kaW5nIHRocmVzaG9sZHMgc2hpZnQgYnkgInNoaWZ0IC0gMyIsIHdo
aWNoIENvdmVyaXR5IGZsYWdnZWQKYXMgcG90ZW50aWFsIHVuZGVmaW5lZCBiZWhhdmlvci4KClRo
ZSBsZWdhY3kgYWRkIGFuZCBtdWx0aXBseSBwYXRocyBzZWxlY3QgZXhwIHN1Y2ggdGhhdCB0aGUg
bm9ybWFsaXplZCByZXN1bHQKaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGl0LiBXaXRoIHRoZSBs
YXJnZXN0IGxlZ2FjeSBmcmFjdGlvbiB3aWR0aCBvZiAyMyBiaXRzLApzaGlmdCBpcyBhdCBsZWFz
dCA0MS4gIFdlIGNhbiBzYWZlbHkgYXNzZXJ0IHRoaXMgaGVyZS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQV9XSi1QWUNmaWl1NDR1VFFpRG9jNThfOUt5
M3VFZC05ZzE0blBnRFBUX19nQG1haWwuZ21haWwuY29tLwpGaXhlczogMjYzM2RhMWUxMjdmICgi
dGFyZ2V0L2hleGFnb246IGFkZCB0aGUgUUZsb2F0IGxvZ2ljIikKUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjg4MjQwClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMgfCA1ICsr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3Fm
bG9hdC5jCmluZGV4IDQxY2M4MjdhYTg3Li4zNDViZGRjZDM2NCAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9hdC5jCisrKyBiL3RhcmdldC9oZXhhZ29uL21tdmVjL2h2
eF9xZmxvYXQuYwpAQCAtNzIxLDYgKzcyMSwxMSBAQCBzdGF0aWMgaW50NjRfdCBsZWdhY3lfcm91
bmRfbihGbG9hdFBhcnRzNjQgcGFydHMsIGludCBleHAsIGludCBmcmFjLCBpbnQgYWRqLAogICAg
IH0KIAogICAgIGlmIChtaWRwb2ludCkgeworICAgICAgICAvKgorICAgICAgICAgKiBUaGUgbGVn
YWN5IGFkZC9tdWx0aXBseSByZXN1bHQgaXMgYXQgbW9zdCBvbmUgYml0IGFib3ZlIGV4cCwKKyAg
ICAgICAgICogbWFraW5nIHNoaWZ0IGF0IGxlYXN0IDQxLgorICAgICAgICAgKi8KKyAgICAgICAg
Z19hc3NlcnQoc2hpZnQgPj0gNDEpOwogICAgICAgICB0aHJlc2hvbGQgPSBVSU5UNjRfQygzKSA8
PCAoc2hpZnQgLSAzKTsKICAgICAgICAgaWYgKGxvdyA8PSB0aHJlc2hvbGQpIHsKICAgICAgICAg
ICAgIHJldHVybiBiYXNlICsgMTsKLS0gCjIuMzQuMQoK

