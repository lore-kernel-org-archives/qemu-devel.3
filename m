Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05C606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MxHF0uwA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gb+9n4NF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpo-0002GV-QW; Tue, 27 Oct 2026 15:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpg-0001xz-5s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpe-0002J3-4J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWqm2452023
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LrLDkrojus1lb2ciDkdrn33x2QXGEoPqfGjgJtuVJnI=; b=MxHF0uwAaNcbcyfh
 v/SR6VYsFh0CIspIwy7wyDf2Xp+PjFFgF2Hc5skwiNS8Uw/Hhu/aBP/sT87f1sKg
 lNBilUaMuZg/+QnASIge5j0q/j+RbhTQn4dWgUm6s+ZeJIjQaD0r9s6vBgYNO5YK
 AWwlrrE0oozft7WaYNc5sGsJqeBh6Auh6QNEkVdGP2MA9HrXTjqCWJ6RSdOlMkU4
 +vkoV9zBLLaw1iKmkOrfv+EeQsEiB+krG9yuVH85p4Y4okHgo8VB/nbpw61bBEFr
 sEREl590W/Rhcna0OGEHeDP8kDX9hc7OPp1vDk17LQdF93Tc0tGMI1o2BjTyDguQ
 FKRG9g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0uvr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c7a1a32a5so6765746d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129255; x=1793734055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LrLDkrojus1lb2ciDkdrn33x2QXGEoPqfGjgJtuVJnI=;
 b=Gb+9n4NFoEvLRI4kHOzOQnu853aOWR0ln5tI657Q83TQmE644hQgOCM4X9VF4bBChO
 oqjmjGaRuPdu2s0iuOUlqv7KVqx8cXQg/MTBjlI5onX8iRqDNRCMZnSC/W0o1sCwcenz
 U/Zh4pVBG3Z10pyii+aBHau97zFO20Us5wWHoLrjOU5M6QS9NhCEPgf7QPUQaT/Ee/9Z
 bZ0+UlyL4YtjWpxFuK8RcaZ4PwIeXegufyrzyYfS5LXFUZooSR2J76ofP8bpyc/qb/vN
 YBIFVx7JN9pdA+0uS0JPncdAflZc5IXX4M/L/HJDujnA9SWjssAyvq+xYCtn5KBsrnDw
 De3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129255; x=1793734055;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LrLDkrojus1lb2ciDkdrn33x2QXGEoPqfGjgJtuVJnI=;
 b=C6nee/0NIpBFhlv2u/fYnlWEVJ4kr7sxYeXTyPed1Bq81Lfjd8Au5duVQhC/X+u2E5
 mCFdzHz1U6vDoLoxIZcMmeR/iiRWEe2aZBv7mhOQ8toxwEPaMqWJF9UvUz03UIigueh+
 qhLE7zfeGQg72KVz6EmBAXSM8MGmatEjne+nMn/wY4svFH7vyAGu7AmSewwxmuxUIKXg
 H2FAi3GqbHw47TpoDeIgzzm+9NXccNnkq1xfPzKU6qZtgi5g+cIRIAxeNZeoBh8nVgpC
 46PqBasNMIED/1bJAhf4I3AZB9crEJSldFbA+04O+o9VahxsnfZSeFLl3bDQkmabm0OW
 GI1Q==
X-Gm-Message-State: AFq9FYJ1Jo2gkudZHsr6XnOCKdcIpAvJr7SvQmL5/PpaQzhJi9v0ga32
 eYkZo+HW4y2O7DU7rUi2Fud+MS+Gd7NPqR0ZiUWFu9L0ZnZlFN575zOMWR1ACXxxcqy9okkcp4n
 awMJl21JFwkLbazy2oYu+vZ7OY+5xp1iEuHaPtMnQ2ExE6KPtyqhTwHfe+j3nLkmvkQ==
X-Gm-Gg: AYBFou13xtZkXYAEqrJ+Nzda68eiDFZUFmo/oiClu0InPeWojnrT/iCk3nFftpGTnYk
 9Ll8l7sMfeQKlGz5eO7lGxAz/hH2p34fGxzcDR4ri7BHoMnLmFh6gvRScD4J/VUbtF/mArpZLR2
 SNgioF7UqzecNbVcc+XiE6rfYnQONPl4fXBhgwkkGZsHcDnPzugSHltNpfLge1qPkuZSFQGnWR1
 le3GSSKf4y9iM3pmtVRrM3OkCHKGrZ6MGjWkziFqdcLQJD4eaKuGQjj7XUd1EmKAb7WCOeI7dzN
 mYqGWHfyMSwkHt5mrTI3pu17eJqMGPiybYXwpdM5b7XyPMz6IaPg4v98C6FDg+cU1MExskjXvqL
 jJHtcukp3Jy0FEpJ18iTWBESSjWKahi3MCXzYMbS/nQQt0hTd2qjUYIky
X-Received: by 2002:a05:620a:2b4e:b0:93b:c458:8254 with SMTP id
 af79cd13be357-940ef9463aamr1620002485a.46.1793129255416; 
 Tue, 27 Oct 2026 12:27:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4e:b0:93b:c458:8254 with SMTP id
 af79cd13be357-940ef9463aamr1619999285a.46.1793129254958; 
 Tue, 27 Oct 2026 12:27:34 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm24752702f8f.1.2026.10.27.12.27.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/59] Kconfig: Extract config IMX_SERIAL from config IMX
Date: Tue, 27 Oct 2026 20:23:15 +0100
Message-ID: <20261027192341.9197-35-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4h9EcYh47Wd+
 W1lXN+DFkvwRb5xx/LPVxpG371nObob+qdE68MfVdbpVnxgeVrmPY0M3KqFxsdrfZCD8mNLnFKz
 Pj9jDAOhpKRpY/xIgBUbfJU69xiO+R2b2nzoqgxo8meXfxlAT6JZX8hZAe32xdcSZjByo3S+LZU
 X9abcyo03yzrsAEawRUNmLQkz8WaawZMB3gwM8YgodESV1rkK109pMW8IskCktr8zQxZJEYsoCh
 kQtUTSrYlp9a+yGbBncDvAd/lXevPZIcBy4zI3K2y1YWX8dPh7AToY5Z4I4rXaVOzQvhaiMGM8/
 QFJ+HL102/p9aLHVJ8OjQ5L6CG3OsWoM0k7lJyDMJQ392sLT7UUtetzrIER8UKUhNQXFJgkjfFn
 Pu4ckpE9szjCRALA48wscaDAy0d61/MejIdfdUveAalvwUNkuNVwyZxIB9uezVi9rFraeiwbqNY
 DCn/Vrmyyx9zF5eCPNA==
X-Proofpoint-GUID: MJBYk_EOm1Ja9ApNLF6qKnG7hiCS91Yg
X-Proofpoint-ORIG-GUID: MJBYk_EOm1Ja9ApNLF6qKnG7hiCS91Yg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX6P5D4dOD//6R
 C9BNpMGKumE0Gg8NtTb0nQ4/9rtLxMTYJLINTgh+k+jBwxPnEMOfPpdsDk8DI3fmq/PBEQmcdOB
 dHxFx6JIrhllYm8TjgAfimr15z0qw+s=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0fb28 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=xCNJqmkWo5Od_A7jMvYA:9
 a=NRrQhWNJJhzriTs_:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
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
config IMX_SERIAL to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-30-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/char/Kconfig     | 3 +++
 hw/char/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 89b3ecd99a2b..4b67f6432f82 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -488,6 +488,7 @@ config FSL_IMX25
     select IMX_GPT
     select IMX_I2C
     select IMX_RNG
+    select IMX_SERIAL
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
@@ -505,6 +506,7 @@ config FSL_IMX31
     select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select WDT_IMX2
     select LAN9118
 
@@ -522,6 +524,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -605,6 +608,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -627,6 +631,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -656,6 +661,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select SDHCI
@@ -702,6 +708,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 704004064192..d77f851668b2 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config IMX_SERIAL
+    bool
+
 config MAX78000_UART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index b2250ee6aea3..111bc1da64ae 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -3,7 +3,7 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+system_ss.add(when: 'CONFIG_IMX_SERIAL', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
-- 
2.55.0


