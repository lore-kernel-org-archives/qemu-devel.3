Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108AAC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VR-0006yl-Mo; Wed, 09 Sep 2026 00:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VQ-0006yI-GS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VO-0003sn-Im
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Mg5RB1274431
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=; b=QU+5POzQOyViNClX
 N80pSwE6I/OP/A2l3kb9UYhdSDA/BnX/3UpDSeNJBdYDDinUJX7TB/gbqJ3pQwmx
 ho9JKNKEFeeEhKd8dtEgSHFZVcZx+h1va3xiqpr5qpHPgHT3YccNt1usZ7BvkmkC
 Su+uszK3oIKwQkFmm8sQO5qwnxHyi3HpTwpkvZLR+Tf34WGEUE0OBGK4vjipaxcf
 v0kry84zOGN6xnbDbq+OKpGhnbjYLTio6qBHPIgG3vBHMNSgh1VQZ8CQRz7FFdij
 e89iDAa3+bfW7DzgeJNpnZa2RQXmxs9WF8v8otAzN6LLHuCKGsV84lQ2VMRp2K8U
 Awvngg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw241y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:48 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-46509ab0149so6406556fac.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926508; x=1789531308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=;
 b=kuKWn0H6FQZRaUV6PxI1WoBVfdlKJIblRA2UJtKUzMQpdpNdMAYfrq+j/g8dosorr9
 kKJ8tkbKlVMU6rQtyJ1nTdXPQNj1nA4Y/nsOedfN6UiPHZJ7UkjP5wLu86ZmMqMch1GD
 2l6lZAyUG1KsOQ7V0ldJrIiEaAbbUQ4NCmDGWsK8yzKqDjVRdBNDoNpHZdFKZv+liadx
 omWD9HNHeAvqWqn1MtITjvHDGS36OoVJUg7Z+U9VB1jnilqqI5c1sFJcORF6tef1i1r/
 LUTBy+0mlsK2AtQJAJkFtJLk/O4gGwT/m3agrDPJYreZFcjgjzE7/crHQtYyDj2x1zhc
 IFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926508; x=1789531308;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eo60+DNsjyuICsw6LBKgEDx72MyCYiY9boywOMHKNAw=;
 b=GTZfNGAIKEPNatmemvoTUoFvfYCryJmquFhEDyCDoGu/HBvAL4Cm+wFCn636F4MQai
 7kGey/MDGubm8+tgsTrjTinixFbZQOTiXyr1PiYuvqaiprFzlXXK4K+bXsM7pzluPX6C
 4a1hw70WOif/j7YWtY4qQrLGi3cHNQifDB98EhVFWnlwikAf3XhZYsaoIhHCktuor8Yo
 9aRbEP2WzAuYS/n3pv4Mv9NuzAnmiU5a95DLW16YAPANP+UlBQxmGVTi/umsBvA1msFe
 mZnJrucaIYgkIbPrfFQP6qhUrL/RiU106m1uV9mcljffKRy3pzDW6YQMK9G0R+Jx1QpH
 +1yw==
X-Gm-Message-State: AFuF++lg7WSgmAoqvzmDR6Bs2tknBmo5GxxCKhN4Uqu12nUT7MpDvvTk
 648p4z/N1OVsqMGHMez8X2apiWTsdo6QyT3M5WJNABnYBSoU8CYzcib9dnOGtk767Xh6L/muGeO
 3v+PD8Fli5Rxs3crnpw42YBaGGh3SX3nSNHj0cRosHJTfG/pUvTfuib69O2q05lb2Bw==
X-Gm-Gg: AYBFou3nyfc88yAZFeiMiE8h7TAG2v/l5hJEYsFabpDHgaMEBQkuyvwb81HWudtUDNd
 64zT9RTM+22PTdCJt/CVfdK4WdBo3DqpIM4QD/SlcUYUohtGKN14Yvy85JypKxRASEGDE8lBsnd
 ge63y7qNcV5ktPNJoz154AGZbjqiZQFxRlk/nz8fWCNnuVBXVUnNx8o+sJvFyuGfUtvqbIBfAog
 uC9+3F153tO+Fe6svlYac8l9VjYzN8fqSAxeHrQFYn3fJRZvRHn8jF7oGGu5MjIOKdxhTR2ONJ4
 KHtn4O2W7FZLBxjVSDkTVhtMqu0zFzKeCDFXee88evwFue0Bnw+ss2dUQIs/Lzc0RPngE5+JBVc
 LYGfLxa3Wtipl21ffpTtWCrnGaCRBOjwCqaC+brxWebEjIeQ8
X-Received: by 2002:a05:6820:4c09:b0:6b7:83c5:fdfa with SMTP id
 006d021491bc7-6b783c60426mr16147017eaf.59.1788926507712; 
 Tue, 08 Sep 2026 21:01:47 -0700 (PDT)
X-Received: by 2002:a05:6820:4c09:b0:6b7:83c5:fdfa with SMTP id
 006d021491bc7-6b783c60426mr16146986eaf.59.1788926507144; 
 Tue, 08 Sep 2026 21:01:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 4/9] target/hexagon: add Y2_tlbpp as unimplemented
Date: Tue,  8 Sep 2026 21:01:32 -0700
Message-Id: <20260909040137.3414132-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 0C9zrkaAKXO2nTnWQb9Hx97Vhfif7ScT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX+DhOBeT0lPRJ
 iXrmmKTMbR6f06qR8wWPcE+iHGRaeKxaKdgzZl7Q0kSY3d9TB1azVoOxW9SkTXoKsYqShvCQbI5
 aBQ3CF5O9j4PN7jGdWvbjIn/2v/C/Yk=
X-Proofpoint-GUID: 0C9zrkaAKXO2nTnWQb9Hx97Vhfif7ScT
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa0da2c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=lfClExg8J67ehGbBbBgA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX6r+IBzKq2W0O
 0SDCFDn84Usvs011RlIfusBJvHwS+emdDuB4E44JoKyLvS7CvY5rXXAazQYBuUlaHJIGpWlop/x
 U9PJJp4bqu25E5gb1+Ss14k5XJMMLwy4EE5Fh1nIvgOubmyQowgB/aGPwuqljzO3cqjzgKw+XDW
 mwGEd7T9uY13sIZpSkf76x8669g+pFfOlvY2DYMLccBwKk8JIvV9WfG4meIKU5bgaDQnt1DRH8X
 x9/lEH/t1v83kzEH2jS3FolS0PVssOxh/dxIjibLUzlza368Vwh/70lYzEpokq+ZitGbShp2TwQ
 HAhlRRNpN/MNBWp975k3KTnZ3G49UDRNZN0qUOedOBnIcY1tDh8n02euWEh6jaYY4Fz7sGGf/dO
 vlvpB7yMaHbXxQTNyN9Qn7rn9duMftqdh9Rby8qWfWupw7K/Bz8uKLGT6zIub55CvA7vWgjEBCK
 08SVlc7Ff2dXAvdjMQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

WTJfdGxicHAgaXMgbW9zdGx5IGFzc29jaWF0ZWQgd2l0aCB0aGUgbm90LXlldC1pbXBsZW1lbnRl
ZCBETUEKZW5naW5lLiAgTGV0J3MgZGVjb2RlIGl0IGFzIHVuaW1wbCBmb3Igbm93LgoKUmV2aWV3
ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAgICAgIHwgMyArKysKIHRhcmdldC9oZXhh
Z29uL2F0dHJpYnNfZGVmLmguaW5jICAgICAgfCAxICsKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZf
aW5mby5jLmluYyAgICAgfCAyICsrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZiAgIHwgMiArKwog
NSBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9zeXNfbWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKaW5kZXggYTQ5
YzcyNzE1ZGMuLjJlMTNiYTAwYzhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9zeXNfbWFj
cm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCkBAIC0xNzcsNiArMTc3LDkg
QEAKICAgICAgICAgICAgICAgICAgICAgIGZUTEJfTk9OUE9XMldSQVAoZlRMQl9JRFhNQVNLKElO
REVYKSkpCiAjZGVmaW5lIGZUTEJQKFRMQkhJKSBcCiAgICAgaGV4X3RsYl9sb29rdXAoZW52LCAo
KFRMQkhJKSA+PiAxMiksICgoVExCSEkpIDw8IDEyKSkKKyNkZWZpbmUgZlRMQlBQKFRMQkhJKSAo
eyBcCisgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJ0bGJwcCBpcyBub3QgaW1wbGVtZW50
ZWRcbiIpOyBcCisgICAgMDsgfSkKICNkZWZpbmUgaWljX2ZsdXNoX2NhY2hlKHApCiAKICNkZWZp
bmUgZklOX0RFQlVHX01PREUoVE5VTSkgKHsgXApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
YXR0cmlic19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwppbmRl
eCA4YjRlYjI3ZDY4Mi4uNWE5OGVhMzMxMzkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0
dHJpYnNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBA
IC0yNSw2ICsyNSw3IEBAIERFRl9BVFRSSUIoTkFfTlQsICJOb24tQWxsb2NhdGluZyBOb24tVGVt
cG9yYWwgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCiAKIERFRl9BVFRSSUIoUFJJViwgIk5vdCBhdmFp
bGFibGUgaW4gdXNlciBvciBndWVzdCBtb2RlIiwgIiIsICIiKQogREVGX0FUVFJJQihHVUVTVCwg
Ik5vdCBhdmFpbGFibGUgaW4gdXNlciBtb2RlIiwgIiIsICIiKQorREVGX0FUVFJJQihUTEJQUF9J
TlNOLCAiRXh0ZW5kZWQgKDY0LWJpdCBWQSkgVExCIHByb2JlIGluc3RydWN0aW9uIiwgIiIsICIi
KQogCiBERUZfQVRUUklCKEZQT1AsICJGbG9hdGluZyBQb2ludCBPcGVyYXRpb24iLCAiIiwgIiIp
CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyBiL3Rhcmdl
dC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYwppbmRleCA0OGJkYzUyYmZkYi4uNjhiZThjYmFm
YjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYworKysgYi90
YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKQEAgLTY0Miw2ICs2NDIsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHRhZ19yZXZfaW5mbyB0YWdfcmV2X2luZm9bWFhfTEFTVF9PUENPREVd
ID0gewogICAgIFtTMl9zdG9yZXJpX3BpX250XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbWTJfZGNmZXRjaGJvX250XSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAg
ICBbWTJfZGN6ZXJvYV9udF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCisKKyAgICBbWTJfdGxicHBdID0geyAuaW50cm9kdWNlZCA9IEhF
WF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogfTsKIAogI2VuZGlmIC8qIEhF
WEFHT05fVEFHX0FSQ0hfVEFCTEVfSCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1w
b3J0ZWQvZW5jb2RlX3BwLmRlZiBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5k
ZWYKaW5kZXggZmNhOGY4YWViMWEuLjRiMzA3Yjk3YjMwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVk
L2VuY29kZV9wcC5kZWYKQEAgLTg5MCw2ICs4OTAsNyBAQCBERUZfRU5DMzIoWTJfdGxidW5sb2Nr
LElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0tLSAwMTAtLS0tLSIpCiBERUZfRU5DMzIo
WTJfazBsb2NrLCAgIElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0tLSAwMTEtLS0tLSIp
CiBERUZfRU5DMzIoWTJfazB1bmxvY2ssIElDTEFTU19DUiIgMTEwMCAwMDEtLS0tLSBQUC0tLS0t
LSAxMDAtLS0tLSIpCiBERUZfRU5DMzIoWTJfdGxicCwgICAgIElDTEFTU19DUiIgMTEwMCAxMDBz
c3NzcyBQUC0tLS0tLSAtLS1kZGRkZCIpCitERUZfRU5DMzIoWTJfdGxicHAsIjAxMTAxMTAwMDEx
c3Nzc3NQUC0tLS0tLS0tLWRkZGRkIikKIERFRl9FTkMzMihZNV90bGJvYywgICAgSUNMQVNTX0NS
IiAxMTAwIDExMXNzc3NzIFBQLS0tLS0tIC0tLWRkZGRkIikKIERFRl9FTkMzMihZNV90bGJhc2lk
aSwgSUNMQVNTX0NSIiAxMTAwIDEwMXNzc3NzIFBQLS0tLS0tIC0tLS0tLS0tIikKIERFRl9FTkMz
MihZMl90bGJyLCAgICAgSUNMQVNTX0NSIiAxMTAwIDAxMHNzc3NzIFBQLS0tLS0tIC0tLWRkZGRk
IikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmIGIvdGFy
Z2V0L2hleGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYKaW5kZXggNjE4N2FkYTVhYmIuLmE1OGRh
OGY4MjY5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgor
KysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZgpAQCAtMTE4LDYgKzExOCw4
IEBAIFE2SU5TTihZMl90bGJyLCJSZGQzMj10bGJyKFJzMzIpIiwgQVRUUklCUyhBX1BSSVYsQV9O
T1RFX1BSSVYsQV9OT1RFX05PUEFDS0VULEFfCiAKIFE2SU5TTihZMl90bGJwLCJSZDMyPXRsYnAo
UnMzMikiLCBBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJQcm9iZSBUTEIiLCB7UmRWPWZUTEJQKFJzVik7fSkKIAorUTZJTlNO
KFkyX3RsYnBwLCJSZDMyPXRsYnAoUnNzMzIpIiwgQVRUUklCUyhBX1BSSVYsQV9OT1RFX1BSSVYs
QV9OT1RFX05PUEFDS0VULEFfUkVTVFJJQ1RfTk9QQUNLRVQsQV9UTEJQUF9JTlNOKSwgIlByb2Jl
IFRMQjY0Iiwge1JkVj1mVExCUFAoUnNzVik7fSkKKwogUTZJTlNOKFk1X3RsYmFzaWRpLCJ0bGJp
bnZhc2lkKFJzMzIpIixBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixBX05PVEVfTk9QQUNLRVQs
QV9SRVNUUklDVF9OT1BBQ0tFVCksICJJbnZhbGlkYXRlIEFTSUQiLAogewogCWZISURFKGludCBp
OykKLS0gCjIuMzQuMQoK

