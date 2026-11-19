Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82815606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=STGhrcY8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QLta5/M5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTxRH-0004Bi-JI; Thu, 19 Nov 2026 03:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRF-0004AH-4A
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRD-0001ZU-3u
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:12 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vQbj2194744
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SL7ot0XagmX
 +jlLEB+IH78jWmo3C6r0IDP96I4NE9k0=; b=STGhrcY85N26h7HAmEcmzIO7oLE
 rGoE9Vtm7j1f9/RF4/hTUQComg5NS3dAFj7mcNOMTsDOHNt239twQbroV5V+U1xN
 RAAecKdd/ZaziUUS9S2LS882cx4JoulxegTVT3DKBALXyNngE0khXkwmU19+mQxC
 QvCMhmp+mnzgez4OgrFzrSG1xLYD4C9koRmB2czUk/0TxbNpflvpi0vRL4fcWlu8
 ZMHpT+TS2dQ7XKgLC8eoMI2YLqzzxcaXIeSSVA/VJWqEjxt61ckL0ti3Vq5j8yte
 Fld/LQ7rviry37+PG6DYdbBwkD+fQwOo+xCnB8lM/8gLZSB0Fq4aNBUvWBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5quym1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5364605e74bso43884481cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076649; x=1795681449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SL7ot0XagmX+jlLEB+IH78jWmo3C6r0IDP96I4NE9k0=;
 b=QLta5/M5smizbvicmegc4nWzBPMeePuQnYnqxu2nWH5fRr0hoTzmifcmaGiJaveSE9
 fALA7bMfcSPf3le0nMbpFLCzFf9W4N9XNqwkZL2gaPBHVIX182W44Mfm0BbGj6w3vl12
 E/Ys5yV1OLPC9eCXVBjw0l1SmryQa/8c/0XGKUSXHW+HkYlw3VMaGLDmI3Tp1e/j/afk
 dpYssAUQaxjdV14jlWRv9sp6AUmkutmqX/kr/JQtXVmc0kH60/UkH8Lr/9/ht2g7kVML
 PpAey9P5hG9Hvd2SB/ewBbPfzhm7msXQRV1lZl8++cLVWZpp3ZFg9m8lljhAm+9uRi7o
 yYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076649; x=1795681449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SL7ot0XagmX+jlLEB+IH78jWmo3C6r0IDP96I4NE9k0=;
 b=VAjeaeKmwQj4LYneErAS1fMDkZuJixzyFPxDbfmDLP/owOBoBIAKtKdwamz/6JR5nq
 E/VNHYQazpGmcas4fhfdZfl2T+3zDWhCin9zSi/hlIzfksbajkT5toLjjy0PWJuboulj
 Tu2fuZOA1BZIoyvUqQYUhWAqIkdzmvZ29WEYrxyt+H0CRKfQNJFNN3m+C9+hPlnZjRUz
 jBAwOn+QBpQPiYpFc9FR3mSNMjvhnhyDMjW4XqrLryxdtrmNdZHvJ/tvJoB9hl7anaQB
 s2j45UnWafv+m+YZn3MsUfEAbXNMdlp6IO7uK4HYXzEZd8rTcnSSFw3/DrrOYiavywWP
 RonQ==
X-Gm-Message-State: APuU4Z/xc1fl0giNV5QtVCkDqC8Yp7xUY3/P1PWbFmMsjZTw692pRgB9
 zIzYIRHqyn0RIrjP5B4JYm8d1UGBd2RAidCHLNHOd/o6faf41Dz61zWCkvITuyRl68mmlOMx+EU
 diSzzMNX1mxuWbdY+BHrewfxKnxc4IDp7z3sR23pM4Df0NpgRUvt/aSSknFC1poBl8A==
X-Gm-Gg: AYBFou0nbnsoKPDPjFuNBLnUFp/isMlPDrhLK5Ev/S0NFn16PUECDHerh4O/CoeLlvG
 sDleKl5Ub3fbvzEIp7T7/5WLuwDYxXSwSAoaizWrR+cO7QAw2hUMu9UfmNJUfIGIPdpLSZwJSL+
 laCXRnm0y6ccCQpazJG5KN8zCYLmzUovwjqvHgzwRBEWhyWtaoy7DP/PCFL09kpmrlS+Sy/3oqS
 78hAkwSPOnotr7B7TVd2IcGRPAuui9bBpgd+ZO4Li50unwnWYM0NBynwCu6IQq4Me1mOPwJBS33
 fggGwO9dbHwL1IdspGAGBEUco71aK6yHQjtKIK5zNRYYcnRl0aBHhIyKHd1VIHTQWjMrj0Xo+OG
 nDr5QgK0hDlETXBnTWWf0N+Vid5o4UTFgFM+73QOp0pwiSf/mJiJKkuxsxNQg3x8iJgjJp4S6e4
 3z2P2KGDvC
X-Received: by 2002:ac8:5f8c:0:b0:533:983b:e53f with SMTP id
 d75a77b69052e-55d5a66d699mr81222881cf.59.1795076648598; 
 Thu, 19 Nov 2026 00:24:08 -0800 (PST)
X-Received: by 2002:ac8:5f8c:0:b0:533:983b:e53f with SMTP id
 d75a77b69052e-55d5a66d699mr81222671cf.59.1795076648039; 
 Thu, 19 Nov 2026 00:24:08 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.137])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9211a6318aesm34524136d6.39.2026.11.19.00.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:07 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 3/5] hw/riscv/server_platform_ref: fix UART baud rate
Date: Thu, 19 Nov 2026 05:23:53 -0300
Message-ID: <20261119082356.1264726-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fo0pdF1bykYHttrzvFqS3ORCxqW1howh
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afeb229 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=a6tGUzlCxnQfwxx7nGpYxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=HyuSmn1QhchWdNVMt-0A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=kr7TZk85JJIQSqC0cl8G:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXwnPVqZlrg8ya
 A/o2b7rL2QdR+az8SRUH/B5vVFMJ3qtYVBPIo6rrLHUTsIyEYCYY5C/5m6BE91mitNqHNIRb748
 Bfzfznb3XqZdZFhQUPyOGHTUKJLTKoI=
X-Proofpoint-GUID: fo0pdF1bykYHttrzvFqS3ORCxqW1howh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX181/i3OiTNEV
 Lx1Nk7HVKQ1sch9PS1lZ/EfCARKVDbJdB5aYl6lV6yyTFO4kmgkF51L/OT1+o6P4e5SctSY5xfU
 9jgMbyrt7c6s16gCVAYJOhPaHe37ju1LiLtimyqfg6V3tcpm0Ii3avAnXAg/Y3LJlCSLdUo+BCr
 pw6AFm+V9TWswf61Bac6gim+JXtWTETxGsJQBHNCJjJt3NnVZ6iu7zKCiPiHy7/xgSJcOMjyjUk
 VpYdyk1EUWzdGbCJ/1HBzTK6LQCZvSwNkcN9a5cgPW7gCOdilZEMujtvcibs7Vwf4UfZboFke9Q
 EOZe6xCb2LC5MHWOlc8vEcX/i1siDqIz0HHSBhd7gBNmj9jarQi1dcKPteDNhBWKa6+jpbv5L6c
 Ey/mLfjXkndvi9WpFE5jxYoc2JILR0qimpPm/Y3kOZWtF400EqaakjjaW6PC+lvaMwYdbFCcZKh
 HhUQXrhs1jePVpign6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The riscv-server 1.0 spec requires an UART with 115200 baud, per rule
"HPER_020" described in [1].

At this moment we're doing two things: the FDT is being created using
the default UART base baud of 230400, and the device itself is being
created using a baud of 399193.  This odd value was inherited from the
RISC-V 'virt' machine when implementing the first interaction of the
riscv-server-ref board.  Linux doesn't seem to care: dmesg reports a
base baud of 230400, a value derived from what we're writing in the DT,
and the serial seems to work fine.

Straight everything up by setting the required base baud of 115200
everywhere applicable.  And for good measure let's also change the boot
test to be sure that userpace is reading the intended serial base baud.

[1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html

Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/server_platform_ref.c              | 8 +++++---
 tests/functional/riscv64/test_server_ref.py | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5cb55a43a8..5fa3130a25 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -68,6 +68,7 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
 #define RVSERVER_IOMMU_HPM_COUNTERS            4
+#define RVSERVER_UART_BASE_BAUD                115200
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -320,7 +321,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
-                          0,
+                          RVSERVER_UART_BASE_BAUD,
                           irq_mmio_phandle);
     name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
@@ -618,8 +619,9 @@ static void rvserver_ref_machine_init(MachineState *machine)
                                                     RVSERVER_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
-        0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
-        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                   0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ),
+                   RVSERVER_UART_BASE_BAUD,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", memmap[RVSERVER_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RVSERVER_RTC_IRQ));
diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
index ad29094dbe..fa7225ccc1 100755
--- a/tests/functional/riscv64/test_server_ref.py
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -71,6 +71,9 @@ def do_test_boot_linux_test(self, tpmstate_dir=None):
         wait_for_console_pattern(self, 'Linux version')
         wait_for_console_pattern(self, 'Machine model: RISC-V Server Platform')
 
+        # Check that we have the intended base baud for the serial
+        wait_for_console_pattern(self, 'base_baud = 115200')
+
         # Test e1000e network card functionality
         wait_for_console_pattern(self, 'e1000e')
         wait_for_console_pattern(self, 'Network Connection')
-- 
2.43.0


