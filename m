Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2922606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TY5nRVGH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=euUgJaOW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpB-0007b5-Nu; Tue, 27 Oct 2026 15:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoz-0006G1-Ms
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmox-0002DH-JG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHG552087961
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KwUA97zsQY2MBo4en3beWQ9BWSafCN4FEUytCtbFrkY=; b=TY5nRVGHTrUOdf4o
 U3Vj5QytvcQFXL5Jf7pVLuQrAB4JzCQQy9KixbhXVu6skWJz91oRi/2q1ROuAEfo
 pbOIy5XcI3ah3KvD0n1y0nuGs8NWvDsWmb/7NT3PXDexkmt0Qo3GbHmXsWqZY5Rm
 f791ffk3mV3l6jkoLsvKPaOn52hD3+6Qt0WvUl5rZCrfk3HOSLU7O5t5eTeO9Fk+
 IAMHNHwJ+2/3tjx+NAUbWAAF1xxJPVtRhGxNTdG+3BhbnEw8G5RptS91sU9gOzSf
 tmv4xGVFLSZxzhCRsLNUx1Pw0n+htcbSUzSkEE5GI+azvpOkqrrTO0k0/BnTWuDa
 vGZpiQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbb0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso19130685a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129209; x=1793734009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KwUA97zsQY2MBo4en3beWQ9BWSafCN4FEUytCtbFrkY=;
 b=euUgJaOWlDm9lCIXE7aKs34dLvA9PChF3BFXQQkJ/xTUYVYbZixa7xDb7vIkwSKpF0
 n/cOre7kEY9mZik9jfBmvA7+WwNQXFZE/3TOZMcn7x3EeZIK8E6M+YZ4ZQHqAHKzqiSI
 YYUOX+42yQQOaqGV5biANWVlVZFRddJdaEvgLxRC28SQbZZbKYitdHfZ2ubr+aFAyHyX
 aHcYQXBKZ4D2wYG+xl4dMLbj4nnZ1SiuimTp5QLPTMZ895Jg5bPILrWB1i8ho22gwnoN
 ZB+mTkwl5yUWMFZIAygZFOTeUMcfnIZ+Cuu7On4i9AICzuJ4HOuaGCgpMm1KMTQBxONJ
 z/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129209; x=1793734009;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KwUA97zsQY2MBo4en3beWQ9BWSafCN4FEUytCtbFrkY=;
 b=qw8TOY39YRh+L8b1NZDiBqixSTlFvK7bC0sgzr0t9ihQDd0zuTr5lO1hzrvSzM85bh
 7SqL6GBiGmBnAIRqiCUeK/ymCGS0UsYruuwIIkGnXwkuQR+QU7VnwG1MIIFj/ruUYevq
 lF54K0HMQedW6inSGzeaYBbXF8lPML5l524gNnOaxQ0a+6CUrMABmCPzeYkoksv+SW5v
 sEuXZrs2Uihgfio0vdrPNSUYJK4yodbn3cGL90QhVsCgCMUV+aluIzkrGarFZe40Q0uV
 d2OQIOdSCXrpXID5SMFk80k0zJR3wueAAijnk/hVmrnsTI4uGY68Y+5zsr4UQXVm03R1
 ZJkg==
X-Gm-Message-State: AFq9FYLew9qvgTMzKpLTXw5TNVqjFmMBImSLuGB7ueIBALJAKf9vZT2Z
 O+ESrYCCKlkQFLxypyB/baowejZyE69UEhDNOIa/ccginoWoSdVrGK6fXliR4oa4jDWaZnGBiKw
 uNCw//TFEZKemEvCeHNrW9OI5Iger35DZKFFTOioirgOaitxW45JKUL3+4/H2LacPGw==
X-Gm-Gg: AYBFou1dScHUakzUI9m48t4NZLItljtrEcfYK/SnEi7NxAlyzh8H/b/a01x+AGqb60+
 3UZZOI03BMANxsW+Jmt+svWs5vrFLduFn4bk6J3x/0y4dc54LEU/Cg3Ecp5nBs43Skx8YGXlw+q
 qaIXliSCRuF+2vYy9bMd0HKfUj2KEEaSc3WHfOgHcWEILSGU7Q2rxaPuXSoxKWJp83/ioliQYAO
 +hUd2LPbg4Y7mGH1iwLm91eljFUZowKln1CiM5kpdurPIX6VbCW7JibD39BN6K36brnph64oZbP
 plk0w4imnKH1PZIPZQpixNjWBUQw+dJyosprKjS+S4LniwrYBDn5BN31f6705VAiDyl8E3+umQJ
 U7UsKEKDBk+KT/rrYtAz3uPXZ13R3SAf3eumZbLfVx2fNGOtdtd/PI3C0
X-Received: by 2002:a05:620a:1793:b0:936:df48:d507 with SMTP id
 af79cd13be357-940ef914997mr1742248985a.18.1793129208616; 
 Tue, 27 Oct 2026 12:26:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1793:b0:936:df48:d507 with SMTP id
 af79cd13be357-940ef914997mr1742244985a.18.1793129208086; 
 Tue, 27 Oct 2026 12:26:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm23013365f8f.7.2026.10.27.12.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/59] Kconfig: Extract config FSL_IMX{6, 7}_SRC from config IMX
Date: Tue, 27 Oct 2026 20:23:08 +0100
Message-ID: <20261027192341.9197-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0faf9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=O-0016Qn-tzLSH4AuisA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: z9ghTSUoZHxzI5grUL54ZXkuNqb2tR-v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3BCgSKZQNMcK
 V4AkCTzIaSkv4jsB54A8UIiqkA3Wjj+GS29MxTH5OWXp9TPlOJU2uf9lg3Xf70St8lzZmhMH5sH
 QEgkjDKcGow/+niQGQ0qbSJmmmsy2zI=
X-Proofpoint-ORIG-GUID: z9ghTSUoZHxzI5grUL54ZXkuNqb2tR-v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5nA6i50Y355M
 MjAxgK1hLLS1l0nOm7giXlUoGAQNsLNWnL0eMzgsSg/hK6CnLvfYMssqLiUPoRDJT4NfT6B8p7t
 gOqpnvgr+tTkkL832vZV87w+GHQxe67Khtg+nGiU7+J9O3q67RMPxQoH2dXX/tFP4bbS21aa5I5
 hbJaPJv8WXhyHkqnK3Aje3iNuMLHxANTTVAV2XGEnVlDcZrm91WYjQBcnCuqN2I4WSQ0hAezzMC
 KOGDadOULx85iBobxWAD7vFx+QNecZL5WgbpjBjgIJzGYfkZQKsvnpZobi/6A/IiVWDkZqqb1fG
 B8r7+QfrABIXhcLwfNcKPRhRODKkZmKELxDV0wVUzzJWRKc6dHxQyh3RR5MHi3T/o70MwLMZzgv
 Wt4emBi5+bf5bnyK3F+FQVl0dUjMRq2R/N6/kLYz/TzlnTe19g2rpiUPj/mjO5BFxdsWUCsdC6C
 Kexd/jKc4Iuv0HNDZXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
SoC-specific config FSL_IMX{6,7}_SRC to eventually eliminate config
IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-23-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 3 +++
 hw/misc/Kconfig     | 6 ++++++
 hw/misc/meson.build | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 55e09e3d9957..5e6b81bfbb95 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -505,6 +505,7 @@ config FSL_IMX6
     imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -580,6 +581,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SRC
     select PCI
     select IMX
     select IMX_FEC
@@ -662,6 +664,7 @@ config FSL_IMX6UL
     depends on TCG && ARM
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b329d6bfda97..ce9fabb8edc8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,9 +97,15 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX6_SRC
+    bool
+
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SRC
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d6f1162ff9c6..44a21b9faf63 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,7 +62,9 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -70,10 +72,8 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
   'imx6_ccm.c',
-  'imx6_src.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_src.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.55.0


