Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54FC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SN9-0005a0-6G; Tue, 01 Sep 2026 13:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN1-0005Xj-LU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SMz-00080H-P6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H6EMc3048057
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=; b=T3DmOK/7xAV1xU5h
 zxM9/79cDeqNDp7HCrnaCcy22To4rOS73URjWP4mCSxuNuetLNsNKBQE/Omubvaa
 tloX9pzJt32Ffmk8xlCqYlKBTkyJd8+xpYOV8gbrmSgKpRKxNFbiAdlWAuX46kKO
 zjbBK/YGsSlpwPI3DD6NEqmmwjUxAli+K5u/X2Lg7aks3zIump8ae3Wxi381aABx
 VB95AFG19ZNVQo5eKGGMeAi5xMXAaWly8EHl3w+U14dOpmWwraha7b3TG+8614Kn
 aOlucWwm1f56htcpjhgiIMTFCn4bRMOxnIx8C59TQbUKqUH/uk1jjCOXB7BIPS5q
 SFtNnA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8fus31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:33:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso110061a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284039; x=1788888839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=;
 b=NTa4zwtk3Zys5gDDlY8TAhDQoGwFvGf3aZnRCwamM/gqbYv+pwl9rlAomKcHj0/Gfc
 WoTF4u0AVl+w1sZWxVHlFJ15Sx2T/tbpkBj1nUuFGEK7SNxIsgeNX51y7TcFdH6pfxYO
 j/DP1NnreqjqcWr+XnKfwUgGY7fxFjAXhN7wAxwAM+N8k4gyDuW66NVAxSQFB7u2JGU3
 5vhynBkvpbD/RBs2PQVIy7gYgQPNTdJu9zgWMn0J9WGS1oP5zpPlVAFHrleOfjOlxoZn
 mK3X/0lK3PcM91/KxUx9OLcoy86BrA1jHkSwLKiDlQ7MhiiNL2oE1iBKM2sDDYFPb6kT
 O2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284039; x=1788888839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uXO3tne317bGrEZCKuTBMVZVrng3uc6zCucp+Ub/ZgE=;
 b=Koa86a17zktDFZQkwHuo7Khm2NwsvBzG//StoEnRQ4mb49Wuh9j07ioCVyzbkST501
 u+txhHxojfWydKz4EMQ5EtwFjTqyo8W4A51l9sB0WxtN7vEkVWrqP7MKIXslfZ6vOB4i
 klmu21MzHLITgA4RQh3N+77Iz1FtEUEAVU4YlqRAs879jm8jXw9Fxhfc4PR9L6FHFspI
 b81cYV5qLpt/HHGSJv13ZyS6q6ZnUuH6+FiZgodq9bRp3MwRGxiFRkBjb/fYGrLF6djf
 3wuPG4/scNUI+yVdX2P8C4RPo1BkZWXqg5TzfLN8HSvHzmkgmse8CEF2WFszqs7Vfg5a
 583w==
X-Gm-Message-State: AFuF++mbZJjvvCliw7ARxdgbuC0Z9A6D2ZkJyKgzTRBYGP1JR2pfJGx6
 a9XERqPKOap54BHle2ocKflYQrkxJZsSgwQv0tf8VmhtbGoewP8MfHwzqDA+2tH90UicBGN4BYv
 6Sr27T9n4vjcDm11H0LyZt0vk46HcE3AtdggRaxX1YhG2Jx8TFTu84rcTJTbNPWh+rw==
X-Gm-Gg: AYBFou3eGuoBNnULRfHnVLepKDzg6Mq7L4LNqvUDeEa+GTCvCoqwQw/AHrzOn6E6JX2
 txbhF3V21z14mNmbfYeo0n0nuyubowQlfu4hJBL9gvVHUQ4IY+FQUo0IhtR2cX30g/BfaPztqQk
 4QkXt+rL8rCOVsVOgg6KNG8/ofkCmJULHnBkxCyQbU0GeYER3DDmKahNra9DxkR3wA7irYaeZUb
 /6gGDnDWDolG9QZsV0MSMWJmytFTKlv2Vxm2/q3/HQLy2tcuxxVBBqaNsgm5eeVLnn755ipAnhe
 XxOzuDk0+PIbdirDLamKIn2FHtsFmicjvyjS/A0T6A6cn5DXAuelenktfpay2ZHgaUorybsTY4o
 Yx7+UZBFNnRN/SKWFOs4FOGlKePqdCh7L/Ybj0ux1FVPXJ0Wt
X-Received: by 2002:a17:90b:1811:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-398e86bcf08mr21371445a91.20.1788284038824; 
 Tue, 01 Sep 2026 10:33:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-398e86bcf08mr21371374a91.20.1788284038364; 
 Tue, 01 Sep 2026 10:33:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:33:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 02/11] tests/tcg/hexagon: check priv instructions raise
 SIGILL
Date: Tue,  1 Sep 2026 10:33:44 -0700
Message-Id: <20260901173353.200474-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cK2HTv-ptA5kuxDRUUX8e7eB8cgaKPk5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX89gcjcMNgPU6
 OSmwA+tncgLerlJt1RePpnOptvLpEz+rQlPtIO0ZDGoFfMzFVOQJ3kYb2+lTI0d5KDa5urnv0dX
 HCL4B8yooXnEHC7BoSkj2kU0o7Ze1hY=
X-Proofpoint-ORIG-GUID: cK2HTv-ptA5kuxDRUUX8e7eB8cgaKPk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX+YLRNx2CrLKZ
 ZM4AafgvaqgAOX9gcBKLCo1gsjsizvzd+YJEXKAicJf/ER5y/8877E2i0vhI1ljQcHlo56uiDom
 LnTHJtSO2gpGhZJ/+XRFcKkxuunZgCc1fVmlQYdPIKD+KPxy5cV8SZrl1BFsQvXJ1b/x2azRa5k
 OjGfUTsgEdIUpogJk/GUdSlnSx+TIkdhcyTobXC8a0CYBRE1S7ytK22wM9C+drhdt9ngZXIPlok
 WAvdbt3RbWsM3xVH5L66hXeeCNQNmp0QX/dQwrcEk0HTdGnUkE65rV5yzEnh6KDKyLPHyasqCez
 VVFBYVBl+LgVKIf2qLnCRagi/UyWFQt3AskdfSecGsQvN7lk3mtoPsDCLFbTRn+0fVbCBdqQSh2
 6hsD4B9qPkXy+z1ik6KGFq5UnKdDDvVdFTexTwhr/Jvm3PGdeWTIg+GCkzMylFM3yjOuHSdRNAR
 7dTbyeBFJjGKk0ieM4Q==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a970c88 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=brjt2USROf7zqxP8TNAA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QV9QUklWIGFuZCBBX0dVRVNUIGluc3RydWN0aW9ucyBleGVjdXRlZCBmcm9tIHVzZXIgbW9kZSBy
YWlzZQpIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOIGFuZCBIRVhfQ0FVU0VfUFJJVl9VU0VS
X05PX0dJTlNOLCB3aGljaCBhYm9ydGVkCnFlbXUtaGV4YWdvbiB1bnRpbCB0aGUgcHJlY2VkaW5n
IHBhdGNoLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5j
IHwgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01h
a2VmaWxlLnRhcmdldCAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcHJpdmlsZWdlZC1pbnNuLmMK
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9wcml2aWxlZ2VkLWluc24uYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAwMDAwLi4zMDZkNDU0MmVhNAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9o
ZXhhZ29uL3ByaXZpbGVnZWQtaW5zbi5jCkBAIC0wLDAgKzEsNzkgQEAKKy8qCisgKiBUZXN0IHRo
YXQgcHJpdmlsZWdlZCBhbmQgZ3Vlc3QtbW9kZSBpbnN0cnVjdGlvbnMgcmFpc2UgU0lHSUxMIGlu
IHVzZXIgbW9kZS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywg
SW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgPGFzc2VydC5oPgorI2luY2x1ZGUg
PHNpZ25hbC5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5j
bHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisKK3N0YXRpYyB2b2lkICpyZXN1
bWVfcGM7CisKK3N0YXRpYyB2b2lkIGhhbmRsZV9zaWdpbGwoaW50IHNpZywgc2lnaW5mb190ICpp
bmZvLCB2b2lkICpwdWMpCit7CisgICAgdWNvbnRleHRfdCAqdWMgPSAodWNvbnRleHRfdCAqKXB1
YzsKKworICAgIGlmIChzaWcgIT0gU0lHSUxMKSB7CisgICAgICAgIF9leGl0KEVYSVRfRkFJTFVS
RSk7CisgICAgfQorCisgICAgdWMtPnVjX21jb250ZXh0LnIwID0gU0lHSUxMOworICAgIHVjLT51
Y19tY29udGV4dC5wYyA9ICh1bnNpZ25lZCBsb25nKXJlc3VtZV9wYzsKK30KKworc3RhdGljIGlu
dCB0ZXN0X3ByaXZfaW5zbih2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20gdm9sYXRp
bGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAgICAgICAg
Im1lbXcoJVtwY10pID0gcjFcbiIKKyAgICAgICAgInN0b3AocjApXG4iCisgICAgICAgICIxOlxu
IgorICAgICAgICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZykKKyAg
ICAgICAgOiBbcGNdICJyIigmcmVzdW1lX3BjKQorICAgICAgICA6ICJyMCIsICJyMSIsICJtZW1v
cnkiKTsKKworICAgIHJldHVybiBzaWc7Cit9CisKK3N0YXRpYyBpbnQgdGVzdF9ndWVzdF9pbnNu
KHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIw
ID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3BjXSkgPSBy
MVxuIgorICAgICAgICAicjAgPSBnMFxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2ln
XSA9IHIwXG4iCisgICAgICAgIDogW3NpZ10gIj1yIihzaWcpCisgICAgICAgIDogW3BjXSAiciIo
JnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1
cm4gc2lnOworfQorCitpbnQgbWFpbigpCit7CisgICAgc3RydWN0IHNpZ2FjdGlvbiBhY3Q7CisK
KyAgICBtZW1zZXQoJmFjdCwgMCwgc2l6ZW9mKGFjdCkpOworICAgIGFjdC5zYV9zaWdhY3Rpb24g
PSBoYW5kbGVfc2lnaWxsOworICAgIGFjdC5zYV9mbGFncyA9IFNBX1NJR0lORk87CisgICAgYXNz
ZXJ0KHNpZ2FjdGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOworCisgICAgYXNzZXJ0KHRl
c3RfcHJpdl9pbnNuKCkgPT0gU0lHSUxMKTsKKyAgICBhc3NlcnQodGVzdF9ndWVzdF9pbnNuKCkg
PT0gU0lHSUxMKTsKKworICAgIHB1dHMoIlBBU1MiKTsKKyAgICByZXR1cm4gRVhJVF9TVUNDRVNT
OworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IGIvdGVz
dHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CmluZGV4IDYxYWRmNjM1NmU0Li42NDFmNmJj
MTBlNyAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CisrKyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldApAQCAtNTgsNiArNTgsNyBAQCBIRVhf
VEVTVFMgKz0gaW52YWxpZC1zbG90cwogSEVYX1RFU1RTICs9IHZhbGlkLXNsb3RzCiBIRVhfVEVT
VFMgKz0gaW52YWxpZC1lbmNvZGluZwogSEVYX1RFU1RTICs9IG11bHRpcGxlLXdyaXRlcworSEVY
X1RFU1RTICs9IHByaXZpbGVnZWQtaW5zbgogSEVYX1RFU1RTICs9IHVuYWxpZ25lZF9wYwogSEVY
X1RFU1RTICs9IHVuYWxpZ25lZF9kYXRhCiAKLS0gCjIuMzQuMQoK

