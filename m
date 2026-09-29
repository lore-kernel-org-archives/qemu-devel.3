Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC49CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSK-00039n-TB; Tue, 29 Sep 2026 03:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSG-00037O-Dx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSD-0005qN-Ru
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TqR12570996
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Jxfh4m5j1p9
 TldH+ELcA7k3wStDYTlHZjXpMqpGmGUE=; b=kGNK2xglntfc89pNJd/t7KVzrrD
 eQ7m5kLSYkWB/fchYNCjlwIB7Pw3eXX1zvY+4KXJtIxFVjuYMtmH6dkgm7FrW+sg
 TPVKJm/xp4BlxJ8nG0B1YEUXy+yoELdCyTdrsFjxrnphWKxKy8O+SvmK9HmvWX4L
 m8n23QbYPJt8e7wm7xOuGlJ1ew0Vj8xPFx6+TNF4eg7fS9vIGQlwuCjgka15N5Eg
 S1q4CymC8v/l8OhXYL8HOWizoq8QO9l5Ez02ef0RwIqLFhVKKFjbEh5a6+UdeT9Z
 I85KpyNn5nkkE3jN0EXzNamTE/gRCYjP2lb6HOHdlVO63RTmfxDah9f8bng==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9f9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313d1015161so13190044eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667644; x=1791272444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jxfh4m5j1p9TldH+ELcA7k3wStDYTlHZjXpMqpGmGUE=;
 b=a1jcg27Q1dkyFPsDdFZJysWRY7R4ttAqF5eZP8MSS8vza1BrOdBXi+SkJZqdTorh4a
 EnIPq+PYT2AH6jtYwX+tPg+BqlwXZxOLX5Eg9UsGSToI4/PmdiDkHD+bCWgmEKhAbgsC
 P7WhBv9wTrRT6oSOyGBfaFDVb+J0dMKDvL/KaLrXLsO6Yz5pB8ZrfJUFtC+CZnavaIoR
 uQ4I6TYStM0vvxverUH9nAtvqmelxmNhR8HAW81bSMSwV6ORaHSz1V0w8DCIKFh/8no/
 0WZ3WVH1oIAx8JafROnnsKl29pKF/whZaJ5YwGxBqcSryqIw8KHaX3+3EjxaaV9+z6TJ
 ZieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667644; x=1791272444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jxfh4m5j1p9TldH+ELcA7k3wStDYTlHZjXpMqpGmGUE=;
 b=oSpsSZghQxKW3zcA4LCihJCgzyfvsTyL5/T0D63iYONEIWEf7JaDlrGg7X7TqgYimf
 wX+a4sthwLb/cNAuryJ1GB/w0CcJvu0N/QZj0vPzAS3mMOSQeVknT670wSshqvTfdyK/
 n3629YaxL04aNHuFG1kEkxWhRasBRGqSHhl+K3REr0V3SZpRINp7/FuzDuXLnMEyYTEV
 9+45pp0E26C/6JQCHd6MdNbtZo+hhDOxA4PpHkTvfVHbCI6PeMjeUuhbhQ3i9KAkOEL/
 254Exyte87VQ/FnU+5Zz3Q9UyaWMCKvwkLwmwpc7A2H2/zXm+nCxZ/YWp5qFyxWBqQuF
 raTw==
X-Gm-Message-State: AFq9FYJG6JSVFljtU1bTsYlbrMdIJI0wilToeTsOO38DQ78B66w3b+HL
 ApeKBa4h+eom2ZcEFVRdC2NcjRk1dWrBMVjzMlz7HErTF3mQ6zq6QMVRkadiT1FOfHpa4Cmorst
 F4FiHJn7sGf1RXBBxBxv1iPyVGFWKkHSTbD2YX46IIEO6lbux6pq0WV8nsKXVLWU6GQ==
X-Gm-Gg: AYBFou3enGJ/C0meuMYMm0aaTs210efVivJ3ycE5+9yGgeePBe1vWubwUvkgcxr9s1g
 z4cEyUDzdYyvcySrHxg3tzkfGeB864G7hl2WHonMH76dINCqY3V68qBIdd48N/mi0dLyaL3IxoR
 HOWDiNDmzcyjqmmK+jeWX6PLvfq4yidrx67N4hBweSc2TbKuFp0bGQwb07mHtWiEM+uOdkL/Qjn
 J/gQFfdqaITbRU+EiXnKM6dHJF+3AfPbWoNYYjUhyuWEDBE2mPC6ncyhaCc3n7E84YtSqpZerLA
 f0sPDm0wUeoq4kHVilmw3QZGsZvWuezCTDbsJZ+L676XyKoBzvC98wYq7MDq7tGK4S+eex3IfA6
 DeW5ZfqGB7YI1ApBI6ZMyOo+UdV5y1wNr2Jyy7lvRd3Vi0leyz8YLH/2rGw==
X-Received: by 2002:a05:693c:65cc:b0:33b:e47c:f3a3 with SMTP id
 5a478bee46e88-34272c5ceb2mr11431572eec.39.1790667643496; 
 Tue, 29 Sep 2026 00:40:43 -0700 (PDT)
X-Received: by 2002:a05:693c:65cc:b0:33b:e47c:f3a3 with SMTP id
 5a478bee46e88-34272c5ceb2mr11431537eec.39.1790667642813; 
 Tue, 29 Sep 2026 00:40:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 09/19] tests/tcg/mips64: move mips64r6 sources
Date: Tue, 29 Sep 2026 07:39:57 +0000
Message-ID: <20260929074007.118970-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb6b7c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ALku5c8DAAAA:8 a=xz38mcJZfOssY3GY9MsA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=Skunnq644UPbuD6fT1yj:22
X-Proofpoint-GUID: l7Bvph-959GyWie20tcENxkguwZTJ1PH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX/qMf6LbD4BRJ
 Vz0NGAG7Rlh3k1Tdc2tb+oKkgVdGzk1wqufy5zhmUjlO/kizM3Mj3OwImfF73MrggNvTVCEJvhe
 6XmzjmF+0AhLLxP+MFG3s/f+J+U9KlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX4X6CLs4niMuy
 aGpQmSFquxBNk2b0i0HV3g5woiFFpUwOsjhMgJCGeXxjyDJz+re3dMrKkPdryXxhnAJvHrIKPSG
 jP0mOohrpy8bP7T12J/n0a2Td2uQzlNwNNSuEVrpkzKTCTQpPXPJPnhlTT3DPK4ohq+whTXEtyG
 0h/TvGmIXQ4jxG1dXsCfeVFV2fEEyZFFXsVLJqGn66gQBmEAF0NpVNE7/U54Qmcbr7UsLPvPzWs
 oBy+SJOvLo7wr6N+0IvVF/tc08gIsNa6AW4+roNjkfrkX3u/qw0/B5L8PKNh+xXj43JKYtzAiBO
 ok+DOkUc1mdlS//I6mQR2r27sOKetGtgx5+WveSNt13Np9e15hlfbLz0ITP6p3RWKTrw7cucViv
 sPOWKFWTMNke8NanGtAdS7BC5FcojRrASse+AEMCPBYSxOai+yCEimzkZN4ruUNCLXAIF/slzpw
 rPIm193oBt/7P3IgPcg==
X-Proofpoint-ORIG-GUID: l7Bvph-959GyWie20tcENxkguwZTJ1PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile | 40 -------------------
 .../logic => mips64}/test_mips64r6_and.c      |  0
 .../test_mips64r6_bitswap.c                   |  0
 .../bit-count => mips64}/test_mips64r6_clo.c  |  0
 .../bit-count => mips64}/test_mips64r6_clz.c  |  0
 .../crc => mips64}/test_mips64r6_crc32b.c     |  0
 .../crc => mips64}/test_mips64r6_crc32cb.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cd.c    |  0
 .../crc => mips64}/test_mips64r6_crc32ch.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cw.c    |  0
 .../crc => mips64}/test_mips64r6_crc32d.c     |  0
 .../crc => mips64}/test_mips64r6_crc32h.c     |  0
 .../crc => mips64}/test_mips64r6_crc32w.c     |  0
 .../test_mips64r6_dbitswap.c                  |  0
 .../bit-count => mips64}/test_mips64r6_dclo.c |  0
 .../bit-count => mips64}/test_mips64r6_dclz.c |  0
 .../test_mips64r6_dmuh.c                      |  0
 .../test_mips64r6_dmuhu.c                     |  0
 .../test_mips64r6_dmul.c                      |  0
 .../test_mips64r6_dmulu.c                     |  0
 .../shift => mips64}/test_mips64r6_dsllv.c    |  0
 .../shift => mips64}/test_mips64r6_dsrav.c    |  0
 .../shift => mips64}/test_mips64r6_dsrlv.c    |  0
 .../test_mips64r6_muh.c                       |  0
 .../test_mips64r6_muhu.c                      |  0
 .../test_mips64r6_mul.c                       |  0
 .../test_mips64r6_mulu.c                      |  0
 .../logic => mips64}/test_mips64r6_nor.c      |  0
 .../logic => mips64}/test_mips64r6_or.c       |  0
 .../shift => mips64}/test_mips64r6_sllv.c     |  0
 .../shift => mips64}/test_mips64r6_srav.c     |  0
 .../shift => mips64}/test_mips64r6_srlv.c     |  0
 .../logic => mips64}/test_mips64r6_xor.c      |  0
 33 files changed, 40 deletions(-)
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_and.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_nor.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_or.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_xor.c (100%)

diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
deleted file mode 100644
index b7f5811a5e9..00000000000
--- a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-#
-#  Test program for MIPS64R6 CRC32 instructions
-#
-#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
-#
-#  SPDX-License-Identifier: GPL-2.0-or-later
-#
-
-ifndef PREFIX
-  $(error "PREFIX not set, please export GNU Toolchain install directory.")
-endif
-
-ifndef SYSROOT
-  $(error "SYSROOT not set, please export GNU Toolchain system root directory.")
-endif
-
-SIM = ../../../../../../../build/qemu-mips64
-SIM_FLAGS = -L $(SYSROOT)
-
-CC      =  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
-
-TESTCASES  = test_mips64r6_crc32b.tst
-TESTCASES += test_mips64r6_crc32h.tst
-TESTCASES += test_mips64r6_crc32w.tst
-TESTCASES += test_mips64r6_crc32d.tst
-TESTCASES += test_mips64r6_crc32cb.tst
-TESTCASES += test_mips64r6_crc32ch.tst
-TESTCASES += test_mips64r6_crc32cw.tst
-TESTCASES += test_mips64r6_crc32cd.tst
-
-all: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-            echo $(SIM) $(SIM_FLAGS) ./$$case; \
-            $(SIM) $(SIM_FLAGS) ./$$case; \
-            echo $(RM) -rf ./$$case; \
-            $(RM) -rf ./$$case; \
-	done
-
-%.tst: %.c
-	$(CC) $< -o $@
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
rename to tests/tcg/mips64/test_mips64r6_and.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
rename to tests/tcg/mips64/test_mips64r6_bitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
rename to tests/tcg/mips64/test_mips64r6_clo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
rename to tests/tcg/mips64/test_mips64r6_clz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
rename to tests/tcg/mips64/test_mips64r6_crc32b.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
rename to tests/tcg/mips64/test_mips64r6_crc32cb.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
rename to tests/tcg/mips64/test_mips64r6_crc32cd.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
rename to tests/tcg/mips64/test_mips64r6_crc32ch.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
rename to tests/tcg/mips64/test_mips64r6_crc32cw.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
rename to tests/tcg/mips64/test_mips64r6_crc32d.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
rename to tests/tcg/mips64/test_mips64r6_crc32h.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
rename to tests/tcg/mips64/test_mips64r6_crc32w.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
rename to tests/tcg/mips64/test_mips64r6_dbitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
rename to tests/tcg/mips64/test_mips64r6_dclo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
rename to tests/tcg/mips64/test_mips64r6_dclz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
rename to tests/tcg/mips64/test_mips64r6_dmuh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
rename to tests/tcg/mips64/test_mips64r6_dmuhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
rename to tests/tcg/mips64/test_mips64r6_dmul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
rename to tests/tcg/mips64/test_mips64r6_dmulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
rename to tests/tcg/mips64/test_mips64r6_dsllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
rename to tests/tcg/mips64/test_mips64r6_dsrav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
rename to tests/tcg/mips64/test_mips64r6_dsrlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
rename to tests/tcg/mips64/test_mips64r6_muh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
rename to tests/tcg/mips64/test_mips64r6_muhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
rename to tests/tcg/mips64/test_mips64r6_mul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
rename to tests/tcg/mips64/test_mips64r6_mulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
rename to tests/tcg/mips64/test_mips64r6_nor.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
rename to tests/tcg/mips64/test_mips64r6_or.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
rename to tests/tcg/mips64/test_mips64r6_sllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
rename to tests/tcg/mips64/test_mips64r6_srav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
rename to tests/tcg/mips64/test_mips64r6_srlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
rename to tests/tcg/mips64/test_mips64r6_xor.c
-- 
2.43.0


