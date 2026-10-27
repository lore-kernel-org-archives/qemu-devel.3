Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GE/tIw5X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fMZfxL2y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpd-0001n4-7V; Tue, 27 Oct 2026 15:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpZ-0001bU-Dn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpX-0002IW-Gm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHx5d1459929
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JI1EdqtvtwZnB/SoTaofspaQvuOmXYxZ5jh6tyKabyk=; b=GE/tIw5X3dDpdATj
 QrFpvCMXKfiIo1THupvjz4mbqazsXDr/1Fd5MY7dI8bDdKWwfEfur1W8yuauDMA5
 BhQEL8VXWS7q+/4sqlu3zCmqGOwOAMruIhn6bjbjag7Jt6emR9ddnKHIKucLYkOT
 jz0o+pPkRsbAs2a4mYaDSuajKYwUtaZGSVzxkEBhPR5Hr3KTqn3MK7iCqKFBQam+
 Qt60sDB7EpmQ+homxsyrVXyHQRtcBtTk1oyhJA3n8iu6UQTGzLkqep6GNJDg72oG
 BpCx/f4tXZGCQLCfoK3aW91yyyiXRzwP38yCXUUfIUvGDcid8gNx2h74Lgka1Omv
 PYljxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710vdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so24571385a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129249; x=1793734049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JI1EdqtvtwZnB/SoTaofspaQvuOmXYxZ5jh6tyKabyk=;
 b=fMZfxL2yqOlBil7rGaSEYbyzwm0amh8LWUIPfFQX+15J3oK7Q9fSNtQSpHsqRVUH72
 U8XZhUGLyBjpSKZSx6URaz6MRXnmMMnUB+O0Tv+sa7FH1BJA7Y8ZOK57aLwiC19vYby5
 cx+ZElGgmJwijqBNNS2nGsl8yswYrlWk5Qv9TKCpC36VHL/BDTnqW/fs36+JTPtOYRig
 FuGQvWqUGjt62jekOIcWrskwG7l+B2rd+HzxI34M1WxIRMia9FPOlHCokO/yUNi95t8S
 1fv17F5nyGj4s69DLHpe7ZrxIRXLNUc1ZfT5ENxFA1MDJniBxzDL65YrlEITZB3MlfNu
 7G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129249; x=1793734049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JI1EdqtvtwZnB/SoTaofspaQvuOmXYxZ5jh6tyKabyk=;
 b=hCGD47UgjvMPt+p0DlnGJEJtwMMtCql07WtEEtnG9Nzyg5WhIGZU3/HzY5ByjK9k79
 2W9TEmZten5f7cYUsmqDzBwg4vRUKE3FJxxCFc35Q/K7rjOY6uBUcijFLusxnLcvTMCi
 GwV81JLUlUUKfKvJ0PLEhL3AsQLoFmdWIYPY772zfYxTrFpxfMUkJ22dm0SU5AkNA4U0
 syUwuxy8pP+rvBdqY0RSgcKxTDIRQBhsMD0WBsk9XXGVP6gNnziKa62KqUrzUOqKBAkS
 X6xHKodrtqwSRx4x9logVXg3EO3VV4NqJqEBQdy2gRJbvw+xFKrtzu/WoTOJoWRyc3o9
 Qppw==
X-Gm-Message-State: AFq9FYLP4+elnSXWauWM/at1ihiF/Q57Eb0r7/sLiEaklM44V0LO2V6P
 9EyXngqD0k1ybAnDmMzln0L79+Ew7OMrSJQfUyqBWmWmmZqobjbdl2fj+OjxH2x7RFehZclKMk7
 vuRVIU7CQqNxgKK8tRKxsJK8Jmun9lDAbXPASO87wdfIY5s42mxbA0FqCLr+5RfZebw==
X-Gm-Gg: AYBFou1JqP6ayhZBcwx+HVthsJ323pNoPqu/gpkXj0enwPamcZA8sbO6IdGzPUlOQJG
 lb2esdqRdtbfzzQwKVuDm5dIxyx+wf1X9CmBGBMNmr8rpWwV34a386bJ7+qRkiLL/qy9BPLt1lY
 9aaPwdFyqQvVEleHUuhGDISzER/YAfmw7ydpeCHzLJui49/3SbI5FfQKxNFuQEiOsbZ95w/v1LT
 53nxngP2m3NmAOKPs2TkaMqMm3IjgV4LEhCNZDM4xme3IyMgvgS7aro3P0CcbsftK9yYpbrfTCt
 6oTNX4uhW5Ms44M6Pl1DtgkwdgZuaJ7l0mPpm10rx5/dOGcAv12qFSllprYw/myKo0udMCMyVzo
 xC4Dc1W64SUUh8R7Kr67I3wE38WUY+pN2tHgqSHiErEyqpJNpxTCP7mYj
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4408 with SMTP id
 af79cd13be357-940ef995984mr1769564285a.68.1793129248877; 
 Tue, 27 Oct 2026 12:27:28 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4408 with SMTP id
 af79cd13be357-940ef995984mr1769559885a.68.1793129248329; 
 Tue, 27 Oct 2026 12:27:28 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92eb9b52fsm6197945e9.2.2026.10.27.12.27.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/59] Kconfig: Extract config IMX_SPI from config IMX
Date: Tue, 27 Oct 2026 20:23:14 +0100
Message-ID: <20261027192341.9197-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX7hjazHbub2ZT
 4tGVknhwl3SZtMcwnsZfCMPZs8MpHn4QF1vCDfgwAJPuJRr0CwmZnIXpEP6ofN7KOjb7Pv6dLw4
 nyhoCnrUU/MmRAWJRFOjCoJiA0WUjWqZBvLJRbqvar7i/ZvaQfrPsU+MmUrHG4oCWvbUQHpTEWe
 PGbJIN+h4P6R6l+Ltgxm8jn/RayYy1dGudVp3+6YELusc+Qipvnb+Ac0PoaUJtZTA3MY23FX5rt
 js+BQoUuqIvlAvjKk7eOHBd0LX/FQZA2vwS290UIhscVPtKj8EVk+e4wGoemslZP71Lp5nOlSQP
 r9svfn4wLKdVU0QDH+UrB90aErmrK52E6ltHaCWSM8oHNOji+j/QBCCRhBGsSsMcozG6L8zFVkj
 XukQw8xHutC+vK0Vgl/nuJQFRp+YNpluP1iraXW3ca0wwTcth7GN9RGR7bhB0IPiQ4Sh1sHuvzp
 iV1cT2ALGw8l4/47y2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1RcmvXEkJ0Wg
 FSpIuIBUyJ+3tTpl8Ul6l/XEr8JbM5VfdaRML+IxdafeEyyZF2YSSsTVWLT14qoOFdhByZf7eBI
 mTWYUxR9rhWVRmUDypxElUdDaLM/t9o=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0fb21 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=f3GtY390AhsygJ4OoPwA:9
 a=dcd5Va8fKio1jsbK:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: 0ivymgELOaHDQfQtC8VPXUm_f1irglHI
X-Proofpoint-ORIG-GUID: 0ivymgELOaHDQfQtC8VPXUm_f1irglHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
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
config IMX_SPI to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-29-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig     | 5 +++++
 hw/misc/Kconfig    | 1 -
 hw/ssi/Kconfig     | 4 ++++
 hw/ssi/meson.build | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 92e6e3b4790b..89b3ecd99a2b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -522,6 +522,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
     select WDT_IMX2
@@ -604,6 +605,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
@@ -625,6 +627,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
@@ -653,6 +656,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
@@ -698,6 +702,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d625141aafd0..e1396aa8c221 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,7 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    select SSI
 
 config IMX_CCM
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1e0..d477d20e9ba4 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config IMX_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea20012..f334e48e2fe8 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+system_ss.add(when: 'CONFIG_IMX_SPI', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
-- 
2.55.0


