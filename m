Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15616C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 01:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3OVh-0002tt-T9; Sun, 06 Sep 2026 21:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3OVg-0002tc-6C
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 21:51:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3OVe-0004E3-0X
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 21:50:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6870BZbq3259776
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 01:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RHjZM5DbKnCdbQvMFa5VSG
 LvLCtp3F3QpImSCQupAq4=; b=aoU5fYmhgF7EBF7jMgK8QfUiTqgEms0QlLXz7d
 OHQg5RmCvIYc72MccDxJPledElXThIeokR3puet4sCxYwRLPnbvG56QN4agx7bqD
 TwVKjYCbgysYCYFigGTrzeOm0Xyfjiu2628NwJJiG3sMAK3JMktlThrFFS0GtR2z
 keif2uGrX7/dcAiBu3LrBDNdyd+b3QVIv0wt3NKno+7qehXs7JhaRjgWD0iECaSC
 Kb1teI8VdtqgJABVIz2dFvvwiCOCRCj6GvIb1vLjdCpI/zNqZumGyTNZ8m9eLyFe
 NHXNM9aQaoW/YlF8GpeyBaHbFmoemuQBao6fJsMia+X/wDUA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfwjgc0g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 01:50:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so4840146a91.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788745855; x=1789350655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RHjZM5DbKnCdbQvMFa5VSGLvLCtp3F3QpImSCQupAq4=;
 b=ZhyHHNkXNUXgrqemk81vUUULShvR8okVqYb999Tva9JFntEfdoMHpcGrNjWBQ/Wecs
 gT4YyNnnWjec/9Ttu40rq2sHlip99RZnmqooR2Mr3E1Wcnbh2Jqm8XBwKmbPc+q+Q2Uz
 P0gXeLFhZOWZCdtHxO12pmA1ctsKiJatal/BuHMyaZOiJ63lKthiP6ljgUz2Wm9W4Ft3
 RzD1srUZrFH/vKfTOHV33VZluc118xrViby4fWMxhuzcqFMzEaDLMta6On1MGlYoxEqU
 MjUH09m49cdU5gV+QmHhJetjbOnPNEUvW74/ML9MVLPhmESKETvAfqnvm+W6DEffcqmD
 UngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788745855; x=1789350655;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RHjZM5DbKnCdbQvMFa5VSGLvLCtp3F3QpImSCQupAq4=;
 b=gcaHuBWjd6tjObyxUlhHJVFS1b26E7FZ2NyZ8dBp3SwmHY8sxyl1S6fpZGEEBFJ8X6
 5GtuRr5K+3zlGzEJH27276RvO5bgCxaY6gwnJmlzxKqYXSysaF0Mp4ET3CiTVFwIZRWQ
 Lrj7D6DV/uAwNvFmTb4mypdCXWpWoaThVGfDwkqW9C+EWOfecbT3/nRZRT78L2zWKNhM
 +l9K+kKtStPKoIQJwLaToCQPyKMfPXPaJ2qzV96u3iV0X0oVYd149U7XbtPsQJIgWGEz
 z409rz5NAFQlm6slzw03g26BVGL2fdqvgc+xd2slGPgV5Gv65KmLBAQ720XYa0211Tw0
 Io9A==
X-Gm-Message-State: AFuF++n6JDY+MaeC3bZay/3zWitXU4sJ+RrhonpBDwnbqYgvz51VF8c1
 i/QLAsgRz5mAzOubvVCrZkvgEMsaU+zM0zOPFoRTlNjLro5A/yewr1gvqVq15Qn2jFXSTSq4Vss
 68bT+Rf5TYqGjti4gOe74uyfV7FUk4Es571zyDJ3zd5/otArj42lKrw7gus9sdoPeug==
X-Gm-Gg: AYBFou176w60SOyk7n/ZPLhjisK0I8crEYkxyyU8xsDgf5Uixitfq7GH4k/GLsioc07
 t3zYfcGdJQv0Ou2pRZQXXf+fz1jHNlwrgDnJ3MSdCTFqq4xnwKuE5Cg2jU+IaDd6my6ARFFrFmt
 w6n1BxHT/zTW0GJ6HwshVrE01Fc4nmt/MPUu8C4mV38mvBGwGCmOE4T2bToYt4/C0sctj8J0ajn
 JlY4cJ4l8oQDoJVIGFy5qFsBZAg2AbchkoGZNZCI9gf5B/WB9dNNx68gZoUXKovbKs+KIzPkUpI
 4jETvGvUsmCt2ye7OHRdG6ESRyKex3Yc0nc1uF0732y5bNpalDLeKnUo5ctat/RHWOHOqfEj8b9
 qmcGzbiT0O34FF96bGrMwOkIizuMjlaKKd1tL82jWrcP78eSC
X-Received: by 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id
 98e67ed59e1d1-39b262a3cf7mr32509122a91.24.1788745854645; 
 Sun, 06 Sep 2026 18:50:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id
 98e67ed59e1d1-39b262a3cf7mr32509069a91.24.1788745854109; 
 Sun, 06 Sep 2026 18:50:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3356dc5c04dsm12675014eec.8.2026.09.06.18.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 18:50:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH] linux-user/hexagon: Add HWCAP support
Date: Sun,  6 Sep 2026 18:50:52 -0700
Message-Id: <20260907015052.3948847-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAxNCBTYWx0ZWRfX0glX7zOS4ZM5
 ilM9kwtEn7vdvdwuCYqKV7t5fdBoJumhZWxfIX9aCGvqOSXUHz7mSEFKuUA3BWijexF+nafL+E0
 gHrqtXTnK1iyTHk1MU6l/vzYXKtfT7s=
X-Authority-Analysis: v=2.4 cv=NanWEWD4 c=1 sm=1 tr=0 ts=6a9e187f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-QqBf7Oy_EXO6S6gpoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: G8AFCSp8vTq18WwPrWG0rDeRxwYjf6-Z
X-Proofpoint-ORIG-GUID: G8AFCSp8vTq18WwPrWG0rDeRxwYjf6-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAxNCBTYWx0ZWRfX67XuvFbqGG1o
 efGcddLkdELpb1cWgZCOksYc22kQrTtUsXWRiJ1D2/nsndhpxvZpryOHNP3+pL9mLp9292WuVpC
 w6JBmIoxYhw9trc+6tOdpvojjktWRS2N9L3L5QyJdtIEsTqjAoOlcNMKdJJLL/rhrmKV08CJj+6
 nW/yaFWMJLHYTGmV3U+f2OmwEw5iJICJizHrohObJT/pJIP7bEn4tjDQXUdt3eg6JWH0ixSRjLj
 b+ztumrpy7pt2cRFL79Be3wfktaFkDaRg0QXcmmPwxgOVX+xFqrhzj5jhpGD7ve+rOxJP2dVk0y
 eE2W6A0xtGqCp6yKy4njXD/nZ6eGSIBc/X8vcfHHLgnTNx2nHWRTPYEQLEAKoS0+/nwBf+qxuW2
 TQeOhIqYI3XE2bIdHs3170DwhJNZLrA0liU1D1gx8e+jKZKYxkkU6lTxU54zbyxEQT4YSwFSBI6
 0gd1f4oGX0bRzlw0TBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070014
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

TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaGV4YWdvbi8yMDI2MDkwNzAwMDc1
MS4zODMyOTU0LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9o
ZXhhZ29uL3RhcmdldF9lbGYuaCB8IDI4ICsrKysrKysrKysrKysrKwogbGludXgtdXNlci9oZXhh
Z29uL2VsZmxvYWQuYyAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNl
ci9oZXhhZ29uL3RhcmdldF9lbGYuaCBiL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgK
aW5kZXggZjgxYWUzODk1YTYuLjYwYmQ3NTA0NTE2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vdGFyZ2V0X2VsZi5oCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgK
QEAgLTIxLDQgKzIxLDMyIEBACiAjZGVmaW5lIEVMRl9DTEFTUyAgICAgICAgICAgICAgIEVMRkNM
QVNTMzIKICNkZWZpbmUgRUxGX01BQ0hJTkUgICAgICAgICAgICAgRU1fSEVYQUdPTgogCisjZGVm
aW5lIEhBVkVfRUxGX0hXQ0FQICAgICAgICAgIDEKKworZW51bSB7CisgICAgSFdDQVBfSEVYQUdP
Tl9JU0FfTUFTSyAgICAgICAgICA9IDB4N0YsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjIgICAg
ICAgICAgICA9IDEsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjMgICAgICAgICAgICA9IDIsCisg
ICAgSFdDQVBfSEVYQUdPTl9JU0FfVjQgICAgICAgICAgICA9IDMsCisgICAgSFdDQVBfSEVYQUdP
Tl9JU0FfVjUgICAgICAgICAgICA9IDQsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjU1ICAgICAg
ICAgICA9IDUsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjYwICAgICAgICAgICA9IDYsCisgICAg
SFdDQVBfSEVYQUdPTl9JU0FfVjYyICAgICAgICAgICA9IDcsCisgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjY1ICAgICAgICAgICA9IDgsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjY2ICAgICAgICAg
ICA9IDksCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjY3ICAgICAgICAgICA9IDEwLAorICAgIEhX
Q0FQX0hFWEFHT05fSVNBX1Y2OCAgICAgICAgICAgPSAxMSwKKyAgICBIV0NBUF9IRVhBR09OX0lT
QV9WNjkgICAgICAgICAgID0gMTIsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjcxICAgICAgICAg
ICA9IDEzLAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3MyAgICAgICAgICAgPSAxNCwKKyAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTUsCisgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE2LAorICAgIEhXQ0FQX0hFWEFHT05fSFZYICAgICAgICAgICAg
ICAgPSAxIDw8IDcsCisgICAgSFdDQVBfSEVYQUdPTl9DQUJBQyAgICAgICAgICAgICA9IDEgPDwg
OCwKKyAgICBIV0NBUF9IRVhBR09OX0hWWF9MRU5HVEhfMTI4QiAgID0gMSA8PCA5LAorICAgIEhX
Q0FQX0hFWEFHT05fSFZYX0lFRUVfRlAgICAgICAgPSAxIDw8IDEwLAorICAgIEhXQ0FQX0hFWEFH
T05fQVVESU8gICAgICAgICAgICAgPSAxIDw8IDExLAorICAgIEhXQ0FQX0hFWEFHT05fSE1YICAg
ICAgICAgICAgICAgPSAxIDw8IDEyLAorfTsKKwogI2VuZGlmCmRpZmYgLS1naXQgYS9saW51eC11
c2VyL2hleGFnb24vZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRl
eCAzOWIwMjAxODE0NS4uM2QxOWE3MTFmODUgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdv
bi9lbGZsb2FkLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMyw4ICsz
LDY5IEBACiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgogI2luY2x1ZGUgInFlbXUuaCIKICNpbmNs
dWRlICJsb2FkZXIuaCIKKyNpbmNsdWRlICJ0YXJnZXRfZWxmLmgiCisjaW5jbHVkZSAidGFyZ2V0
L2hleGFnb24vY3B1LmgiCiAKIAorYWJpX3Vsb25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNz
KQoreworICAgIEhleGFnb25DUFVDbGFzcyAqbWNjID0gSEVYQUdPTl9DUFVfR0VUX0NMQVNTKGNz
KTsKKyAgICBhYmlfdWxvbmcgaHdjYXBzOworICAgIHVpbnQzMl90IGhleF92ZXI7CisKKyAgICBp
ZiAoIW1jYy0+aGV4X2RlZikgeworICAgICAgICByZXR1cm4gMDsKKyAgICB9CisKKyAgICBoZXhf
dmVyID0gbWNjLT5oZXhfZGVmLT5oZXhfdmVyc2lvbjsKKyAgICBzd2l0Y2ggKGhleF92ZXIpIHsK
KyAgICBjYXNlIEhFWF9WRVJfVjU6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNB
X1Y1OworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjU1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNTU7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSEVY
X1ZFUl9WNjA6CisgICAgY2FzZSBIRVhfVkVSX1Y2MToKKyAgICAgICAgaHdjYXBzID0gSFdDQVBf
SEVYQUdPTl9JU0FfVjYwOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjYyOgor
ICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNjI7CisgICAgICAgIGJyZWFrOwor
ICAgIGNhc2UgSEVYX1ZFUl9WNjU6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNB
X1Y2NTsKKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBIRVhfVkVSX1Y2NjoKKyAgICAgICAgaHdj
YXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjY2OworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhF
WF9WRVJfVjY3OgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNjc7CisgICAg
ICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNjg6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQ
X0hFWEFHT05fSVNBX1Y2ODsKKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBIRVhfVkVSX1Y2OToK
KyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjY5OworICAgICAgICBicmVhazsK
KyAgICBjYXNlIEhFWF9WRVJfVjcxOgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lT
QV9WNzE7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNzM6CisgICAgICAgIGh3
Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3MzsKKyAgICAgICAgYnJlYWs7CisgICAgZGVmYXVs
dDoKKyAgICAgICAgcmV0dXJuIDA7CisgICAgfQorCisgICAgaHdjYXBzIHw9IEhXQ0FQX0hFWEFH
T05fSFZYOworICAgIGh3Y2FwcyB8PSBIV0NBUF9IRVhBR09OX0hWWF9MRU5HVEhfMTI4QjsKKyAg
ICBpZiAoaGV4X3ZlciA+PSBIRVhfVkVSX1Y2OCkgeworICAgICAgICBod2NhcHMgfD0gSFdDQVBf
SEVYQUdPTl9IVlhfSUVFRV9GUDsKKyAgICB9CisKKyAgICByZXR1cm4gaHdjYXBzOworfQorCiBj
b25zdCBjaGFyICpnZXRfZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxhZ3MpCiB7CiAgICAgc3Rh
dGljIGNoYXIgYnVmWzMyXTsKLS0gCjIuMzQuMQoK

