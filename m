Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C854606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QR18PnqJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=araebLiO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD3J-0003uP-Og; Wed, 28 Oct 2026 19:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMD3I-0003tw-6v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:27:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMD3G-0003ze-Nk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:27:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA8dr2062608
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tlIB31pgVaPxExlxnQ/deLFHchWkMk1VpbR+FqPcl2I=; b=QR18PnqJfNPbAX3i
 tFE3avjOjepiiqknoFc78EbRLYjsPDxl+My6vFzW6a3U6j+IKk9x9zNNZIQyV4Hv
 7h1WVoubV1NgNw+dD/eP52SpWsUlWwwVD7HL8dlUJ0idZ6bR3vMyzFtOUcslOuKt
 Arcytxr+Le/1uy+OMk2b2S4oskbgidYZjM2GuSELTXFs/8mGOmiKMyQ/bsh2Ivdq
 M4GTwi630U4LAtmoonk6HF7tS2kmScnIVr5NzBF2mUrPqVZBJD4RBARsPrzCK5aS
 0iQXXtOAQ+bEc+0rVtJUVCh9gdvM2/gomUC/W8jwDFGl42SfBMwUPe3FNzcRIwdb
 t5LZUg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp976t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:27:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so2195429eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793230044; x=1793834844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tlIB31pgVaPxExlxnQ/deLFHchWkMk1VpbR+FqPcl2I=;
 b=araebLiOXvQ2XR6/ZUsvfv3L93MubpoKyz//Zg73kIQNfjx8IBh8IRc20P1MyhRFiH
 t0H6sPFIZokNxzHqOueG2uxGu6t8CtgUesX+Q11j+Nduih0rghtYL3Jp21S9z1GhAWj5
 VN1mYV6Ht18hpatqe5YpfzoAcN2L0ZZ5CqwFHU2r2Do/9eeZyWvvDnLNFtR3XHgAQsuj
 sd64NaFfJO1IS0NX3hace5ztNKKi2NSqBPvuZ1lkacyO4gRRjIGbr7acMg22eAaWNGwm
 Wl2nzAdMnPfHhLSPOaYXXoB8LMsglmyvweg+dWCKZYckEeSuPq2CbDyQ3YSrm5Vo/fKD
 bi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793230044; x=1793834844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tlIB31pgVaPxExlxnQ/deLFHchWkMk1VpbR+FqPcl2I=;
 b=paBEsP5YZq8dBzQH2U2BxjZFLFVGY4XjBfIPIxijZUujonuRLStsOuzp3GSQSFg+MM
 k1fQHMteBgKy0t2NxEJOBhKJ00cjFqsDk0oGt5GiX4KWLUJeHleYk0diBfENEfIWDg7q
 jYTDCtus5dVZ3H1+VBCmqAIrdFfZl2ohgmx3NSuhvFVGu3E6bcIE/w6a5WjLy+95TbNK
 OgletfEwnhUbUZa/FLBJc2K5/MhIvorqdYPhxKQylg8lZ6PtxaFGioXjnwMB9jufMTUI
 LondiAl3ZuBUruJzLgiEs7A6yPYDG3n63pD1OHohVNrSa62Kv667JSIfsnVD4WlX34m8
 11Iw==
X-Gm-Message-State: AFq9FYIKLnd2fFndTMKAQbk8NAyWVC+itnjnAh0Pxe2fIOVaKEgrRn7k
 Cs6cmd7Fp2KVh66X/z2Ia20EIZHcO1trus1BVHwRNYsRCwhQ+nYox43S01/vwWaIL2qhqRft1KQ
 zNwL7kL8Y1bijsmPzCBizStZdNsn/RbbWHMHUd+Mkg/MmtWeK9LPLD7v8RN6Yl/0gEw==
X-Gm-Gg: AYBFou3SQqxK87nbmO4Y9bPXF5a4FcyDET+YB85O00XMLqrHD2GD22rslA8DAGZHfbh
 q/BpefuL0Qdv3qOJmqT+w65jkDnK+2glJHvk3jlhtrUN1hlTBzdbmuPd/msArebPfp7IgjQqFZX
 2AAyUVFJZQU05o6l4uevaR0tBR8qARwDsFJpe8N1LmW4B4LPqTic19UtjlBQ+mHpQmegWTnJVu8
 qehHwe/yz4RINRiohRrAi/I/QLgVCQxktEV23oriJ+XzBcvwDoSI9xkbM1MxFbpmkWIYq6OEMdW
 NZSIWNJKKkoHBkyK7HoXcP0sA49v1/TlmBUo8gWlpyoxKKR4Cba0vjrLIjY6NCTfkYgkrdBMJcx
 t06Q1S/0km+THUV0ns/SDnn0plXb5cWI7AX6OkmHp9DGo0d/F2cbd61oWZFvjrh+ItU6T1qJNAq
 OIeJQBQRKL7GY35D+/1yymOA==
X-Received: by 2002:a05:7301:7009:b0:369:f937:9a7a with SMTP id
 5a478bee46e88-36a2013c690mr5776901eec.34.1793230043603; 
 Wed, 28 Oct 2026 16:27:23 -0700 (PDT)
X-Received: by 2002:a05:7301:7009:b0:369:f937:9a7a with SMTP id
 5a478bee46e88-36a2013c690mr5776867eec.34.1793230042934; 
 Wed, 28 Oct 2026 16:27:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238da3e1sm14020827eec.8.2026.10.28.16.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 16:27:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/1] target/hexagon: implement floating-point exception for
 sysemu
Date: Wed, 28 Oct 2026 16:27:20 -0700
Message-Id: <20261028232720.3331505-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028232720.3331505-1-brian.cain@oss.qualcomm.com>
References: <20261028232720.3331505-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae284dc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=x05RA5dRon49DLOVpUcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: -8220-7wkTbUYOakVVERKutV2ACU4LTu
X-Proofpoint-GUID: -8220-7wkTbUYOakVVERKutV2ACU4LTu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5MyBTYWx0ZWRfX16RGO9313RC4
 oZZ9ff3HCY1+qZ90wvpwhuTzAADFT925zX6wYCLhiTFQ3rgkh6xfi++V9qRarAGHHWcgdyWafyA
 E0xVIqpfB/wvIGGxgMS8G8ldxXDOalo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5MyBTYWx0ZWRfX6eEuxtqnGIY3
 /ocO2SCDA0JJfEDSN/IyRn8hixe+Bv86nZkayq30T73mj7rXCXHh0hJxzmndFFEw43TUb1pPgJQ
 OMbSEHCyHLsFQhUSjXn3gPjEEz5F6yaYuGmNbD2H71RA0K3Nkq+iJIBToCQq00k47LHiWwjcNBT
 YET0Nhg8G/WhGC6ao5D55Z6RbI2G3sW2+vadQEItWqBozMwFKT0Pq3AtqvX+GkIf7MyusyJ6FZ/
 eQ9OKBMDKSZpE1P7rIKU469EL7ldM0JrcZcc4iPAIkZ5C247Lx/pS2bUVK9iz40rAw7vGoVrErY
 lu/araGm872vv8egV6QdUQPEZ24HMuqVW+SpUDnkO45Ib6Wy1dgCD7KUpRKymoXWAR2xSl5xEa1
 59O5sBu6T5AkBGpkJYEKetW9dnwUua2XgMwH7wLFAi9N2bvmpHEQKYTa0vcsLwNLIhKH687jauL
 yRZRa5TIz+ChczRaxGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280093
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

RGVmaW5lIFJBSVNFX0ZQX0VYQ0VQVElPTiB3aXRoIGEgSEVYX0VWRU5UX0ZQVFJBUCBleGNlcHRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vYXJjaC5jIHwgMTMgKysrKysrKysrLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXggM2M0MTcz
NThlMDYuLjVlZTg3YjMyMGI2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAiY3B1
LmgiCiAjaW5jbHVkZSAiZm1hX2VtdS5oIgogI2luY2x1ZGUgImFyY2guaCIKKyNpbmNsdWRlICJp
bnRlcm5hbC5oIgogI2luY2x1ZGUgIm1hY3Jvcy5oIgogCiAjZGVmaW5lIFNGX0JJQVMgICAgICAg
IDEyNwpAQCAtMjEzLDEwICsyMTQsMTQgQEAgdm9pZCBhcmNoX2Zwb3Bfc3RhcnQoQ1BVSGV4YWdv
blN0YXRlICplbnYpCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCiAjZWxzZQotIC8qCi0gICogVG8gYmUgaW1wbGVtZW50ZWQuCi0gICovCi0jZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKKyNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OIFwKKyAgICBkbyB7IFwKKyAgICAgICAg
Q1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOyBcCisgICAgICAgIGNzLT5leGNlcHRpb25faW5k
ZXggPSBIRVhfRVZFTlRfRlBUUkFQOyBcCisgICAgICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9D
QVVTRV9GUFRSQVBfQ0FVU0VfQkFERkxPQVQ7IFwKKyAgICAgICAgZG9fcmFpc2VfZXhjZXB0aW9u
KGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZW52LT5ncHJbSEVYX1JFR19QQ10sIDApOyBcCisgICAgfSB3aGlsZSAoMCkKICNlbmRpZgogCiAj
ZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBNWUUpIFwKLS0gCjIuMzQuMQoK

