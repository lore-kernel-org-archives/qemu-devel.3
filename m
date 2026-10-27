Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E8606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DBF2PCIm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hPvPKBo7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpB-0007ex-Tt; Tue, 27 Oct 2026 15:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmp7-0006zv-Gf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmp5-0002EO-Fy
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPQv3553875
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gzh6YzBeXWnzOXFWI/BzSO5pYBjHJBGJeOYqFe97Ijo=; b=DBF2PCImjrBWnGZp
 1rPAFnsSygFeO4dUEmZjLYe/1f2DA5tEvlaFiSzWwmwBwT5SgdLtXsqVydRrlFmP
 65voxxUSBSzStjPu2w0eV1rGkf0Ye0L85g0PKO/cu3mh2kQ/wCdbBRDUFmpkaZCB
 bQRwgIs3y7O/yuhy/75zlzczGhnfGYMMvox0Wc6mXXH8frd8mCVf0EOw+nidlhD7
 4CoTa+a+Q8+DW4rsLBIv6OOB/VekeAji5QX7IL99FEvC9l6TsJ/Mr2RcKyIyYKHe
 fOozmHQewm2kVbNaGG3U+t0UyyRrL0cBe0jvsxf5O1+TitUujNInWkKcUPXYb6RD
 zoofHA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f6f4fe531so24486085a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129222; x=1793734022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzh6YzBeXWnzOXFWI/BzSO5pYBjHJBGJeOYqFe97Ijo=;
 b=hPvPKBo7qI6KkuHOIfGiYCfPqk/psUA3txI+M2YvuoutjemqsnoUKd2lRCIJpwN9cv
 8776wAK4R2ebOQ7NXTjT3U+uG3O1M84tllGwENTg8buu4Ozvl70YNQ4OVZJwEzlhQLvu
 TlohyE75g9VFMtDwtnO4Lz6Qgns8PN5yWWfAojxUYjfOqQXxpXPBFtf0Ea3NcpBatNhf
 ry37jzFKZt2cZc9oHRiFgsl2pVtD7wCdb7bLu3xW1gS0mOO0myprc1tgd08/yt93lXbx
 tdoOjAPPLdR/XI0xPL4AfjZKTu1OY8C0m+gsuJJ3syYNnZBURu+N8DuRwd0I3mpm10v4
 iT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129222; x=1793734022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gzh6YzBeXWnzOXFWI/BzSO5pYBjHJBGJeOYqFe97Ijo=;
 b=YWprV2/W0YqIo81fvvQFmKu4SkGyqJKZtyX8eyb/AwaNLM0b8IWAwIZfZGKUw3yb2Z
 x3l9JEm3ZamcV/FvMSMYlfurng/16htZze9aybQosDtozFNHiDxDc1HJDg/HnR7QNdcT
 5EIvUeBgdQiaL2dd9aVvNBTz25KKIVrqycyqYmyGT0yNZepn+EA8CCoy0M9t/vBYPjqJ
 ALQq4OWhXCaafvRw0X1cx5FSipzlEUInOpjF6qxf5G9X7yMOZyVtZXVzrpnYr6yUacIj
 oPOujhAyIw6DlZaMYE3qzcrpQPQS/0vu3FK9O5G9XWxjTe1Z+hfdEkAqzjP2RLdaOOz4
 vAKg==
X-Gm-Message-State: AFq9FYKApEKCsP54xU336IJjj8hQkrJ6hdAS2k78FOe79feNqeNtB9Ai
 w4l0G4lFYjOdYuj1xE2cM9YU/F8Sty9568jWZXqUM9RlzxkkK0cJbroa76aDAEJFX/65OQhDY/s
 tfadVcQG7s8LwG/K0Q0BcvBjo0yE/sOXXXk2G/ejh23tYK1lcg5TtkNhKo7aXEXiaIw==
X-Gm-Gg: AYBFou1ai1qMuIS0EkqWTF4xoU2qfyhM6IcjeVnbnujpvkUwQiGdhF09aht9UCuIUgK
 Yi01g4YRAEcvXtZnWyA4Aer1mPIghOdclOafRZxi8SQjon0gH9+9zaeU620C5z2TwPoqaagoXu0
 GuWF1VBblNlRbZ0iMHBSlceZ4+cNCl5v5lnEBFiZ88ndyQN9qCzKDyHNLu8E8LwUa2u8QlfSl/Y
 1dbGXKbjSzFB5c3xETJln9DXXczcJnp6hH6SRei5kKE6Fbb/U0VVGK6KAOEm9GMPSHvBpLm7E36
 PllkU1xoamOCDTBzDtw4wg8Nne6klICu0urTxXEhldZGJXDsfdp9GEMIWXia6lXyCea5tT0SdB/
 c50zCgzxsCQn9aQiqKIu3bPerFdVLQtxKBAgvmr9393okhZXx5sGWxm7X
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4408 with SMTP id
 af79cd13be357-940ef995984mr1769372385a.68.1793129221865; 
 Tue, 27 Oct 2026 12:27:01 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4408 with SMTP id
 af79cd13be357-940ef995984mr1769368185a.68.1793129221254; 
 Tue, 27 Oct 2026 12:27:01 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8290sm3097105e9.9.2026.10.27.12.27.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/59] Kconfig: Extract dedicated config FSL_IMXx_CCM from
 config IMX
Date: Tue, 27 Oct 2026 20:23:10 +0100
Message-ID: <20261027192341.9197-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX6H24JhPs7sBm
 Xu538fUY/vxCwQTzUPHFw6lZ1BbQIiRqMtV5sy+vel7TLyW/+Xj7p0Gjz/Ti2H/+QhzsEKrkUuS
 cB7GX0amqHHFS6z63we9BDICMd7cPfy5erkXY49wE1eVKN3kTocLeSZ3tsF+cpcv9YtfXw4iQy1
 vn+VBE0n8lysVVngefX/55eCKwSpaV8w/rkUZPjBqiHi413XheRsFkbZJSowQiUYNdAhxYVcxya
 AXLXA4UxiftLUrI0K25shKR8LfjYSP27q3vyMXssBzrmdOb2qmXDn3mLzvK1gUyJzAfl0x8+uRW
 6afg3UgOXdg9CMGgez1JuZknFn3qnJ3DYLC/KZsrqFCtokRXStHG93ltZ/vSyBIauZaDsZ0oysb
 IPIJxNKaym61ch0R7HcnYh49O3RdoyVwyZAHMAOZCrOjOhmx9P2/4P9XvEES448c/GwI5sBUvyy
 JXksxfwoJWk1okm5arg==
X-Proofpoint-GUID: d6aBqas50jDxpSNezEh4NGF-RthXXan9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4oFm5mgJPpFE
 IlJXUKvZ6Q+7zeBU+meeenxCExIvxKcLaSyR9ps1M2GR7Dy9NQkzVJNeDyP3gCfiBpeqPeA09SA
 1jzvWIzNOFQRYl+AjqX0sIrzLjYvEec=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fb06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=89OC-F0PJ-CZB-ShPt0A:9
 a=K_paWFUX5Z0lrulP:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: d6aBqas50jDxpSNezEh4NGF-RthXXan9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Bernhard Beschow <shentey@gmail.com>

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
SoC-specific config FSL_IMXx_CCM to eventually eliminate config IMX.

Note that config IMX_CCM represents a base class for i.MX clock
control modules which is used in i.MX timers and FlexCAN.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-25-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      |  5 +++++
 hw/misc/Kconfig     | 25 +++++++++++++++++++++++++
 hw/misc/meson.build | 14 ++++++--------
 hw/net/Kconfig      |  2 +-
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c01b1ea979bf..4d9279ca2c8e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -479,6 +479,7 @@ config FSL_IMX25
     default y
     depends on TCG && ARM
     imply I2C_DEVICES
+    select FSL_IMX25_CCM
     select IMX
     select IMX_AVIC
     select IMX_FEC
@@ -493,6 +494,7 @@ config FSL_IMX31
     default y
     depends on TCG && ARM
     imply I2C_DEVICES
+    select FSL_IMX31_CCM
     select SERIAL_MM
     select IMX
     select IMX_AVIC
@@ -505,6 +507,7 @@ config FSL_IMX6
     imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
+    select FSL_IMX6_CCM
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select IMX
@@ -581,6 +584,7 @@ config FSL_IMX7
     imply TEST_DEVICES
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX7_CCM
     select FSL_IMX7_GPR
     select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
@@ -669,6 +673,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index a69c56ecc69b..de95648f0b0b 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,15 +91,39 @@ config ECCMEMCTL
 
 config IMX
     bool
+    depends on IMX_CCM
     select PTIMER
     select SSI
 
+config IMX_CCM
+    bool
+
 config IMX_RNG
     bool
 
+config FSL_IMX25_CCM
+    bool
+    select IMX_CCM
+
+config FSL_IMX31_CCM
+    bool
+    select IMX_CCM
+
+config FSL_IMX6_CCM
+    bool
+    select IMX_CCM
+
 config FSL_IMX6_SRC
     bool
 
+config FSL_IMX6UL_CCM
+    bool
+    select IMX_CCM
+
+config FSL_IMX7_CCM
+    bool
+    select IMX_CCM
+
 config FSL_IMX7_GPR
     bool
 
@@ -114,6 +138,7 @@ config FSL_IMX8MP_ANALOG
 
 config FSL_IMX8MP_CCM
     bool
+    select IMX_CCM
 
 config STM32_RCC
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index f4a4bc1c482a..a859e704a5f0 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,21 +62,19 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX25_CCM', if_true: files('imx25_ccm.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX31_CCM', if_true: files('imx31_ccm.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX6_CCM', if_true: files('imx6_ccm.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX6UL_CCM', if_true: files('imx6ul_ccm.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_CCM', if_true: files('imx7_ccm.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SNVS', if_true: files('imx7_snvs.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_IMX_CCM', if_true: files('imx_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files(
-  'imx25_ccm.c',
-  'imx31_ccm.c',
-  'imx6_ccm.c',
-  'imx6ul_ccm.c',
-  'imx7_ccm.c',
-  'imx_ccm.c',
-))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index b56a173eed5e..4a2cacbcd2a9 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -160,5 +160,5 @@ config CAN_CTUCANFD_PCI
 
 config CAN_FLEXCAN
     bool
-    depends on IMX
+    depends on IMX_CCM
     select CAN_BUS
-- 
2.55.0


