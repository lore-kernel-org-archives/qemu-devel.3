Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33826606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ouKWSq3k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ym63LK16
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKg95-0005GF-EG; Sat, 24 Oct 2026 14:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKg93-0005Fq-9q
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:07:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKg91-0002H0-HZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:07:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF03Tw1354175
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1xWDoHI4XIGS56np9/kV1z
 O87Ln6x+whJl8WjnbtHNE=; b=ouKWSq3ky4xNzVJr8g6hNcKQHsxaYMLDNwlLVZ
 fxFatkdlSOmm/247hvGxw5CiDEl4XPtrF1UPkNwc7bv2Sp+6eGuHGaCC+tMyNan+
 rgFJtGU6dfhujDr9wQMia6xyNucSKp9ZGYsI0NBFEmBsfXFyW4TqrJtPKR/2y4lg
 6lBvP8l8LZwk/tnVX8xNBbgghKOy5INoOzq3CYrzX0Xk7fXzWg5MLhoYvYQ5DlmA
 CKDzeFv4XEjh02vtp3mw5BcEjaGT91bnDFtUckX0hmQe4gFjHRTLLi9xDMsZ/LK5
 KlyHlBZ6JCvlRJYV9RPXrbLJMk0DXn5spfVk1m84186ogOYQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhdv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:07:00 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-18eb2616974so6773738c88.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792865220; x=1793470020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1xWDoHI4XIGS56np9/kV1zO87Ln6x+whJl8WjnbtHNE=;
 b=Ym63LK16rUGWpbYh45vDtCC4wpfj6t0b+Mqiws0nF6cu6NqB6SZ9f2OCPpCRMB5lJe
 SGEvVABs3IqBKAt0C86zMfKXzsyHDU5ktqLaw6QxI4er6jHSB9/QSLwhvFSI0w/L4DzZ
 Jyl35jrfm8S93ZP0ORgC/gY0Vc+EHAmqOP1ZiS/0oSZhx82x4DiZ/RDV+dcZZbzqw/c6
 B+S1UJDWmgW1j96C6C3w9/XOMp1YMWjPjA6xrxP71Bxv3VExSm3aDXiXjZiDEpk2BPfg
 Vjg5OmLY4qHme3cR3179fpRO7l3ax21zTo03SvuSqma8SL73b0l59XiJaG3LxMg1n37c
 48KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792865220; x=1793470020;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1xWDoHI4XIGS56np9/kV1zO87Ln6x+whJl8WjnbtHNE=;
 b=2Hg3ObrH29EPVzm99AxkyfZIjtYZF84sKQjgIanJssad9gLiUknNtevZrWwhuNthqn
 a0xqQSKSCShNwqlRx8lOUinaWSHOiTQl9Vy1diQfiAtmrHQpAVlHofDFO8KrM2wKollA
 sLK9Cjd14X9uyL2qgvMMyXbxOP0kwcYwcZu7N3R5pSfHFHlHzQ/h7xiAhi+KgeIlc7BT
 pOjIXjtbNijpE99inOB09H2/CYe6gCwXs+c8QQvVChPcqz64IKLZYmPy7pvrpqyuuGXt
 imfjclPITsokdiKTpMwS8eYaM+YHNzxqtqi3k/UZ470X5iY20m4ILP+rCyndk2ifAiFo
 X1iA==
X-Gm-Message-State: AFq9FYJ9IQzfOmlqbriENC0CKmolUhJtknQPcvkFYG/2tLcoxuVFgkFI
 VtivwcvKXSaXHaIQUKL8ZcfdpmmizXZsNNK58Q9JUAUtyL3Hfz1bnaXOG0cAGXcr25tYvEqqWoF
 O/D/gogFawbZQn2KAC4IFFtJlbMdKc6CwFl+qy5lhz357IaiciX9Zf/EAw/XjnTJYtg==
X-Gm-Gg: AYBFou25bElFG4wbC5ldhK74P91HN8zHN8tp59mVpiixPXQP0AKwMNiy3DJ22lhhKbC
 bi0S0evNyi2vUEvycf62W5/S8nvAFFIsONKu2v/Hj2851Qc5oS/KNb9ZRiUdFJdoQGXxpP56mM6
 dPJjvMTl+SYhCiIKukJ+lIOrwU9P6s+64HlKOoHnUzEvspzJTB6N0+3v3xdl0hDggJLfaGfQmSx
 WpBT7uZfdSn5vEggcA8cHfLMmAs8KVsGl4BTP434RAiLqytvhA9xFJM4NT344HwAhUPrBXC6+bf
 aW3Qc1+Dqxz1pIoVz3aaPR4y3Kp/S9UVUCQlhExfLozfnnfBiKNMMkYXjg2pOpaKktK6aN/5WAs
 v1A9Jvm7Gjm7rra/G3b2O3+KOq9U3agRpgalpg6exgIwB5L4=
X-Received: by 2002:a05:701b:4587:b0:184:5f2e:aa52 with SMTP id
 a92af1059eb24-1993499dc8amr3199296c88.16.1792865219917; 
 Sat, 24 Oct 2026 11:06:59 -0700 (PDT)
X-Received: by 2002:a05:701b:4587:b0:184:5f2e:aa52 with SMTP id
 a92af1059eb24-1993499dc8amr3199271c88.16.1792865219430; 
 Sat, 24 Oct 2026 11:06:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2e32479sm8107394c88.21.2026.10.24.11.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:06:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/2] hexagon roms: add H2 firmware
Date: Sat, 24 Oct 2026 11:06:55 -0700
Message-Id: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfX+GfUjwLuN3CS
 pkEpQ6kEYUV0h/sN8semoJRCqWDZFeCWzy6CAyWn9DNLtfejRl/N6yHQ4um3bogOkiIFjWpbjMx
 4XCpCiVBIfOeVtQxu4UO6M9yzOs2BOc=
X-Proofpoint-ORIG-GUID: TLtdZiHkcsElutGvzysH59E6OSi4LxRN
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adcf3c4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8LrcM0jPnV7doXogZd0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfX8+4qC4+IS3oO
 ATXI9jp7CWsKq19UdZefSLru1hx/HLXldf58eXUPWPFtc2JiHKB8GVjqwgWN9eXeTx+1yMvcbN3
 aZZnZ7sdXtd4GWwLoq4q64hD24HjvNSz1wQY6kAOT4bqVTUzGCbX3wESjZv6+0S2y6fgVasH02X
 QSQIZCkszPiWio6VtvYc/7zR/gE9Evvr/h7+E7PkqBIasfSONqoml3VkO7158wCCNQLExh0892W
 zQx8Zd4kBSE6dbB6GIcLhRTj1wEG9ZXtwiNqcQqbu1JqMreUqX0Mvhd78EgH8sxRGv9MOJrzLMx
 65g6ORn0AMWHqFKP9enGPXzD0f/3DaZ3Td/3QfSmIwkaopxeB0POrjlGwMHGDA/tizgIdfrG9Wd
 h6n8hSkxCwvDUn45XCj+cAh2tocongkhnSEdhkDSc2vuXzRqJCIJjefj4qHIrkofhqvN0zkJXQ3
 i5S/juSES91U5HJzniQ==
X-Proofpoint-GUID: TLtdZiHkcsElutGvzysH59E6OSi4LxRN
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

SW4gdjI6Ci0gR290IHJpZCBvZiB0aGUgbWFrZSBtYWNyb3MgaW4gZmF2b3Igb2YgZWFzaWVyLXRv
LXJlYWQgdmFyaWFibGUgc3Vic3RpdHV0aW9uLgotIFNwbGl0IGludG8gdHdvIGNvbW1pdHM6IG9u
ZSBmb3IgYmluYXJpZXMsIG9uZSBmb3IgZXZlcnl0aGluZyBlbHNlLgpSZXBseWluZyB0byB0aGUg
dGhyZWFkIGJlY29tZXMgdmVyeSB1bndpZWxkeSB3aXRoIHRoZSBiaW5hcmllcy4KCnYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMDIzMTUyMTE3LjM2Njg2NDEtMS1i
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgyKToKICByb21zOiBhZGQg
SDIgZmlybXdhcmUgc3VwcG9ydAogIHBjLWJpb3M6IGFkZCBIMiBmaXJtd2FyZSBiaW5hcmllcwoK
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiBkb2NzL3N5
c3RlbS9oZXhhZ29uL2Nkc3AucnN0ICAgICAgICAgICAgfCAgNDggKysrKysrKysrKysrKysKIC5n
aXRpZ25vcmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiAuZ2l0bW9kdWxl
cyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogcGMtYmlvcy9SRUFETUUgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsrCiBwYy1iaW9zL2hleGFnb24taHlwZXJ2aXNv
ci1saWNlbnNlLnR4dCAgfCAgMjYgKysrKysrKysKIHBjLWJpb3MvaGV4YWdvbl9ib290ZXJfcWNz
NjQ5MF9jZHNwICAgICB8IEJpbiAwIC0+IDI4NTI5MiBieXRlcwogcGMtYmlvcy9oZXhhZ29uX2Jv
b3Rlcl9zYTg3NzVwX2Nkc3AgICAgIHwgQmluIDAgLT4gMjgxMjI0IGJ5dGVzCiBwYy1iaW9zL2hl
eGFnb25fYm9vdGVyX3NhODc5N3BfbnNwMCAgICAgfCBCaW4gMCAtPiAyODg5MDQgYnl0ZXMKIHBj
LWJpb3MvaGV4YWdvbl9ib290ZXJfc2M4NDgweHBfbnNwMCAgICB8IEJpbiAwIC0+IDI4ODkwOCBi
eXRlcwogcGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl9zbTg5NzVfbnNwICAgICAgIHwgQmluIDAgLT4g
Mjg4OTAwIGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fbG9hZGxpbnV4X3FjczY0OTBfY2RzcCAgfCBC
aW4gMCAtPiAyMDA0MjggYnl0ZXMKIHBjLWJpb3MvaGV4YWdvbl9sb2FkbGludXhfc2E4Nzc1cF9j
ZHNwICB8IEJpbiAwIC0+IDIwMDQ1NiBieXRlcwogcGMtYmlvcy9oZXhhZ29uX2xvYWRsaW51eF9z
YTg3OTdwX25zcDAgIHwgQmluIDAgLT4gMjA4MTM2IGJ5dGVzCiBwYy1iaW9zL2hleGFnb25fbG9h
ZGxpbnV4X3NjODQ4MHhwX25zcDAgfCBCaW4gMCAtPiAyMDgxNDAgYnl0ZXMKIHBjLWJpb3MvaGV4
YWdvbl9sb2FkbGludXhfc204OTc1X25zcCAgICB8IEJpbiAwIC0+IDIwODEzMiBieXRlcwogcGMt
Ymlvcy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgIHwgIDExICsrKysKIHJvbXMvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4MyArKysrKysrKysrKysrKysrKysr
KysrKysKIHJvbXMvaGV4YWdvbi1oeXBlcnZpc29yICAgICAgICAgICAgICAgICB8ICAgMSArCiAx
OSBmaWxlcyBjaGFuZ2VkLCAxODIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHBj
LWJpb3MvaGV4YWdvbi1oeXBlcnZpc29yLWxpY2Vuc2UudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQg
cGMtYmlvcy9oZXhhZ29uX2Jvb3Rlcl9xY3M2NDkwX2Nkc3AKIGNyZWF0ZSBtb2RlIDEwMDY0NCBw
Yy1iaW9zL2hleGFnb25fYm9vdGVyX3NhODc3NXBfY2RzcAogY3JlYXRlIG1vZGUgMTAwNjQ0IHBj
LWJpb3MvaGV4YWdvbl9ib290ZXJfc2E4Nzk3cF9uc3AwCiBjcmVhdGUgbW9kZSAxMDA2NDQgcGMt
Ymlvcy9oZXhhZ29uX2Jvb3Rlcl9zYzg0ODB4cF9uc3AwCiBjcmVhdGUgbW9kZSAxMDA2NDQgcGMt
Ymlvcy9oZXhhZ29uX2Jvb3Rlcl9zbTg5NzVfbnNwCiBjcmVhdGUgbW9kZSAxMDA2NDQgcGMtYmlv
cy9oZXhhZ29uX2xvYWRsaW51eF9xY3M2NDkwX2Nkc3AKIGNyZWF0ZSBtb2RlIDEwMDY0NCBwYy1i
aW9zL2hleGFnb25fbG9hZGxpbnV4X3NhODc3NXBfY2RzcAogY3JlYXRlIG1vZGUgMTAwNjQ0IHBj
LWJpb3MvaGV4YWdvbl9sb2FkbGludXhfc2E4Nzk3cF9uc3AwCiBjcmVhdGUgbW9kZSAxMDA2NDQg
cGMtYmlvcy9oZXhhZ29uX2xvYWRsaW51eF9zYzg0ODB4cF9uc3AwCiBjcmVhdGUgbW9kZSAxMDA2
NDQgcGMtYmlvcy9oZXhhZ29uX2xvYWRsaW51eF9zbTg5NzVfbnNwCiBjcmVhdGUgbW9kZSAxNjAw
MDAgcm9tcy9oZXhhZ29uLWh5cGVydmlzb3IKCi0tIAoyLjM0LjEKCg==

