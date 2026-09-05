Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F414DC79F8B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weM-0001VW-P6; Sat, 05 Sep 2026 16:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weL-0001V3-Ah
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weJ-00062B-OY
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbLFx2985954
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2VJsi27o0+uN77wiLofEZb2qSn/DBQkBxim437eGUpc=; b=dH
 RqhFuneI2quXVDavjGy90JN85WMcgspFYfXShjMEBbgwRUqithWFeAHWrKFy49mv
 IZpwNLQs3AgNYdHsLh1D8eRmEH9swiqh3kuPnG9+VDIzmnNjsTrxiWL/KghGbt2f
 iOWC8L3ArhEkyFtlEfwe7o2hhN9TK5XIlogW1CUiMWC54nUcn3M1bvIiDeta3CxB
 Z5QJ+LAobI/5+0yWYazo3D0u+ZSxROW/p4LIdcdDpvAJfd0LJdmqxdF1QxQOoP3a
 rxlyEu2ccVuCjRFzCrjMz/oluUOVB1yU/HAJZjNgDKpI/0DDwhcb8VwDOyj5Y7A1
 vxq5kQ6C1q3MBP4rNDVg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggba3j52f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:06:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so3999738a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638762; x=1789243562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2VJsi27o0+uN77wiLofEZb2qSn/DBQkBxim437eGUpc=;
 b=PEg9EaQJ6IZrzajhT0WsHkMnviBnvYijBN3jG3Q7AgQVGtIcfOfG/NlrnhlP6Pw9ue
 0x3EenCyLrTJf0DSAjfPW7YPpdfc+R4tZWSOPDB4ODVjGOCyGYb/boCXDu6pFjBz8eKt
 v4G9Y8OtM6BrHhcxZ9Rzl5yPrkyMG6/uj6coXDgDHw3yTnOCIsvmpjFaZbL1D5ERmEAm
 sv4rvwL1Z9Ao73toXBLg6obJMtxuP3eq/wFUC1n7cxLcHKktyvDm5aP/ImKDXdNs5u+k
 tiEaKn9uBZdCFgs4haeeIqJwCjSjuXIob1CJP6sj8HBz1mwkjzMtrQBWGu/KzRoPFAwp
 k2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638762; x=1789243562;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2VJsi27o0+uN77wiLofEZb2qSn/DBQkBxim437eGUpc=;
 b=Bl8wiKm3irHegN3mGDWolFBlHhTh/Ox+z7rGT5kh71yeXpwE1l/u7NNqSPD5/oQ5XG
 9eZPe+0JqFTzITz3nHb5jfoVvg5dTq/4dQKozD4wBoRBBtmbYBASPXpJlAJ3Y3RpXbbw
 ODE6vvlT0X8rOKMn+kD8ZBvBqtOVwMzh2pCfMWiZ04hnVRrOEb1WShvPEFjtaFldPutD
 Gdmz7GtiLTgN6kRHzdAXaHpg2Qi/HqfxDH6k8zJajgjg8myAEeqgiS3yblxoyelreXFX
 kSCGLyKOLuFjzalyoKupnQ2LsAMCFyexfug3KC59zJsPvci4x9Wr4NDiXVTARnil7oku
 nAFA==
X-Gm-Message-State: AFuF++nukE/XvSEJtJ3mqM7Y5HwP0BD8poI1XYQBDCRb5CohYIHWGXiN
 5cwEMJnjyDP9kRHjsm0e8in4PDE27JgSyvHqnWgZSWhQEqywqNRsnUl1FR2h5n+nZ5ZYKEDPJZn
 RgsNrmzMB9AV2be/FRl55YVpfAkEpiFMbrb3sh8aHmqCwNXIKbdPKTCVtXB9HY4a7Bg==
X-Gm-Gg: AYBFou2hver7NTqjsDyssHSsnot/ZCI8K17v1P3nN3OIwhvg9nUciPZun0gntjmiGIP
 QAdBgZ5VAts+XMXjs+N/wviq1YCCTDuhVrCcj6z5VCkhReoh1Krzq2M7ARXfdXQV6sBfHTUsGAx
 YjA9IksuT8i7bq8ik1AgGzQ73nLEz//NoKBTjNfRL549FYINr+ttsPXLdPMiLtIkdwBHITKaj7j
 OGbXcFafviMh7n7iRr3eCkTFXnkJ6sRHxVk80T7QmIl2L/aoq+cI8cJr4Dmpneb0PO7ygpENO47
 1IBlumVP8wk/G8Hh0AsMtqoICX6y9VYDrRzWk0wgVov3QGalwknEXFwJPoVWyNJkODBhSCIF/r8
 ViyihGxk4IV+93rdsO6w1jEHQRbXMmJg3lEPxCzEgRgOQgEyJ
X-Received: by 2002:a17:90b:28cc:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39b260e13d5mr21577105a91.1.1788638761709; 
 Sat, 05 Sep 2026 13:06:01 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39b260e13d5mr21577038a91.1.1788638761287; 
 Sat, 05 Sep 2026 13:06:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:06:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 5/9] target/hexagon: assert guest register pair alignment
Date: Sat,  5 Sep 2026 13:05:46 -0700
Message-Id: <20260905200550.2009799-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX37K0uNwJDtaZ
 weOWyLsK9dVXZwxwvgfwRXiGtSWCavxZbmcvSnhJ1jUbVQ4xPzssEhUYrgvlFdetzcVrPnR/awE
 73T506wETaAlVABFOIRUGGqTuxiqhADW0THy3x/auQtdHSbDw9DsyTqqfW7Njlopw1wsvlcTk9K
 WrU3Eqaho1Om16gWpd+eHLtkWSkJ7o1QhmCKedw8rfFryevDM+zqADUw+u12ccK6ETdMu1onmma
 RVQ4qPIxWOojqURIy0/B/G0xELVOc9IweYx2f26Xj4aONizYTULGbCM24YLTdbcQoKDgCfupskS
 DoJzrqPH7fEoeBcQBFAyHwWtGu7PJ7H/U8jTxwFEDgsQXJOqU8AKb10c24VZDWNBgqXjMLi22zT
 Df3lzKp9aUO8PiY4CrTnZNggJibu+ByIo2A2aenR2hRpvFdgG25kCAgDs/VqKOFpQOqYGPTsGxo
 2X3GkIbFjbr8Obzu/Sw==
X-Proofpoint-ORIG-GUID: ZlyifUeJwzW43DaZJsqwkG7QU-n98ISf
X-Proofpoint-GUID: ZlyifUeJwzW43DaZJsqwkG7QU-n98ISf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX93NDRZN+kG1k
 s6HDu9SQzBe4vaCkzp6AUP+4u8WpWqmGeAsJoiykf4NmbocMRnydtIFHKXfeJie1VCVBFI5dl9m
 p0wLwa7E2omyy68cgSVWg5rlPZIMljo=
X-Authority-Analysis: v=2.4 cv=Tf2mcxQh c=1 sm=1 tr=0 ts=6a9c762a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xt-mzBTFr2Kth5l1m7AA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050223
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9mN2YzNGE0My1jMWNjLTRk
ZDgtYTg1OS05YWI3MmUxYjAxNWZAb3NzLnF1YWxjb21tLmNvbS8KU3VnZ2VzdGVkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDVkNjRjNTUyM2JiLi43YWQ5OWNl
ZDdhYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE5MjcsNiArMTkyNyw4IEBAIHVpbnQzMl90IEhFTFBF
UihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB1aW50NjRf
dCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBy
ZWcpCiAKIHsKKyAgICBnX2Fzc2VydCgocmVnICYgMSkgPT0gMCk7CisKICAgICBpZiAocmVnID09
IEhFWF9HUkVHX0cwIHx8IHJlZyA9PSBIRVhfR1JFR19HMikgewogICAgICAgICByZXR1cm4gKHVp
bnQ2NF90KShlbnYtPmdyZWdbcmVnXSkgfAogICAgICAgICAgICAgICAgKCgodWludDY0X3QpKGVu
di0+Z3JlZ1tyZWcgKyAxXSkpIDw8IDMyKTsKLS0gCjIuMzQuMQoK

