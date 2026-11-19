Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88316606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YAE9Zo6W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TCdQDcFP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTxRJ-0004CP-Ek; Thu, 19 Nov 2026 03:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRH-0004Bj-H3
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRF-0001kt-NO
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:15 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vYki330748
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tGilkePA/I6
 Z7w81HYXyow4LaQeCJgl//68K2X2Vikw=; b=YAE9Zo6WmPhAWf4FgkrpcEq7Q4t
 ga1e5kIOeXe6pzL0rllBrIIYocryxoMlcfcqYNIiT2CoBPPwwtRK1N7Q1ImbV80k
 dtJ/oY8D1qqvXPKcLjQv0rbGMzLr9nbFrmQ9/Q478I9m8z/vE51lnX9ieytQk976
 rxPBoKgktPCKKFumw90Iq0Zn1Arq8dN8Ss110ySStnxYl/HrOF8hxqXvid8EzX11
 aYiJKaDkPHnqi5ncaGC543T0BKiNNBgeTMhkz3smq5sAQcKnH2yVlo24gvZH5Ro7
 9K1U2QMkMwoSUrhJ2UdGSAhuRF/bt+XytTPfgCl8YJLRDKNPeI95D9FHZew==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnkg4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso381260685a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076651; x=1795681451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tGilkePA/I6Z7w81HYXyow4LaQeCJgl//68K2X2Vikw=;
 b=TCdQDcFPzo5VHVcKv0y8p0PnLujLyGClU7x/E17/+PUsHQPBn2HIvvCDdDi49iRuGT
 qhgOg7Ltok/LabnWLt3RbNWwVcrztyl+Y4nb4JWZAeDMGddYKSqFle9GVj8Gc8kA8PDp
 JZ5XFehwZcX+4DH/3pWGYAh6ribYFvGsdgOgPgiDgW4leLwDPVmJ7ZKzJDhszrasofLi
 Va6J7fWX5CPNA/mXCosMDltjCdaemdp9Eeb97j3tfv2rFQAge9WaGImdS5VLUKCGvZLC
 yNyebhp29YDfX0K/+xsVuBMsYyOfmbEpktU8Vb+C6eb6+f8gH2ywuX5wWYu+4JnVLg3e
 flVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076651; x=1795681451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGilkePA/I6Z7w81HYXyow4LaQeCJgl//68K2X2Vikw=;
 b=K9lFw2RzlmnZX5n4jfRM+Zj9qYFXjXBq4NZjzSl/z9Lxzg/aIbB7vhKh9PyotFsLCA
 6Um79IBX22rvlaSkNZka66Ad4jKIOQZAXqH0L3J5R+MqebE9NxPbcBCVmknl6prXYO7m
 egRKjFm1NkXCPPQD7xy10HlVUR8kDpWFOpAI6Roe3tH/JDhh5CnGQBKbpp2wHnCE04Wj
 n1hL/OX5gSc98bSGDkGAYH/1E65uFJtMb/ho1gPdUm9ixPivRQwH1w+1F0v34j0nyAOz
 RIXP4IIL2UI7Kv6lrdU44j58AO6EshDOAm5N90DspLG40VMIuSXe9PY1OHDN7Jt4nj0/
 uVHQ==
X-Gm-Message-State: APuU4Z+3BOwsotOGbAApMoPhQMimn8gDzfcl15YderCTFffpO7xiE50o
 ywI4ceJWsiii7TKzqNPv7NhEBcMgRX0avUsgs5HWZ1Lc6jeYAwvD933levqUbsXX/afutzUdJDH
 vwf2zzatuWJZoSkYyMhNAb4B3c4MC2Q+TAeqX6evsj04qrj+RCLw3wg7Y7G81BdQidQ==
X-Gm-Gg: AYBFou3aCwQ9Sn90VWnpDDrMioHqhMVap+iNUe/0e59WoHmmc8pF1ZFNKScJPqxqzYs
 i3FuA20TAeHtcN2/5+W7Iu7m/tpKe3341dZiPCxg4k6twcg5ey4Wun3igwgs3fkdVhXTLP/wP/a
 KLfQxiRO1S/oDk0Mb30yOCZloLW2tq5wJ94Z6gD/e+jdhtyKO2eHMf7AUv+GBEn8FerNhIiL8Vz
 XS17OZ03JaPR/MFw2W77efl9gvg6Evt0wwXKPbtrphCQ4ZtXcg/bEw/50XaAE8m3FaUM8t6gF9y
 OFaAoc3K7KyR54Im8O/TtfYtblva7Z8PbZOqaHCzbbx3etIK3cFOxWZJOof99E0+oEimCOURglj
 aBfIWOjJy/NJ2whQp0Fs6RQufHjpJFTXh5LijpLYphceDQDolww0HnVsfWi5sWxUoHNlEBp/YXh
 MeWKncxlEj
X-Received: by 2002:a05:620a:8801:b0:949:3644:edc0 with SMTP id
 af79cd13be357-94999574d97mr903378885a.17.1795076650885; 
 Thu, 19 Nov 2026 00:24:10 -0800 (PST)
X-Received: by 2002:a05:620a:8801:b0:949:3644:edc0 with SMTP id
 af79cd13be357-94999574d97mr903375985a.17.1795076650273; 
 Thu, 19 Nov 2026 00:24:10 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.137])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9211a6318aesm34524136d6.39.2026.11.19.00.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:09 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 4/5] hw/riscv/virt.c: fix base baud in serial_mm_init()
Date: Thu, 19 Nov 2026 05:23:54 -0300
Message-ID: <20261119082356.1264726-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qru_yIHKUUlSv3jRrA6kA1IUFxNypydk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX7e4BvUv31FQY
 5T2C0H3UTkT/6N99TPuStPaXfJmfjVGYP2p6IIr+9yz0PNWKqazE6CYzYiq4Id8FHKXY19VugVV
 c6L+LXgsgSnxFbBucSOmX1SNSmMyJxpr53vpJGbwQf+F/Z1oLRxFmtb4i3PTiRj6EHxRQO5kV/4
 /bzEJraLNAs1VsjCq2x6S87JA2IuL1eAg3YdsHUyHH7KijdWzvkYazchlCgkywRKk/4JmbgBETx
 DuSEz7y85AcAeeSyT02yBL1k8ECrSsbVYi7SV8o2cQ+2eJ7PmrDmKXy4feZGEQtYiwRie+v1+Ws
 Vhw4kKyBPM9rUNRF/dPl2cJPJRzyXAsn/wv4isGHZElSaj8vW7RtvysWKoxMFEbEuABigo02qXx
 QvoNUD4cooHSChUoUNO6udmV7c8/ZR1tZKymskzi0YweFP6M63Y/WX6d+wVZbpa6X+CWqgikjpW
 Iv0kQnser1bR1QjvhhA==
X-Proofpoint-ORIG-GUID: Qru_yIHKUUlSv3jRrA6kA1IUFxNypydk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX9dtmq54Wp/Rk
 YKNSDPLhQPH1fK+xeVBFQ/BpuEbkwCnVElWo2yCxSSCxfdpCbfu8L5Kcgwa2NAilSG+8WnqZl/i
 id+urymvNVTIVVwxln5bNBjO2KsIw00=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afeb22b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=a6tGUzlCxnQfwxx7nGpYxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=YBD5noFLO0MiZe3rPCsA:9 a=IoWCM6iH3mJn3m4BftBB:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We've been using a base baud of 399193 to create the UART devices
while, at the same time, reporting a clock frequency that represents
a 230400 baud rate.

This pattern dates back to the initial RISC-V port and so far seems to
be doing okay.  Linux thinks that we have a 230400 baud serials and
nothing seems of.  Or better yet: no one has complained about a
potential bug in the UART devices since 2018.

All this said, set the UARTs baud rate in serial_mm_init() to match
what Linux has been seeing all this time.

Fixes: 04331d0b56a0 ("RISC-V VirtIO Machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c         | 10 ++++++----
 include/hw/riscv/virt.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9eccf62d4f..9c621b5939 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -929,13 +929,15 @@ static void virt_machine_init(MachineState *machine)
         VIRT_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
-        0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
-        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                   0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ),
+                   RISCV_VIRT_UART_BASE_BAUD,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     if (serial_hd(1)) {
         serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
-            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
-            serial_hd(1), DEVICE_LITTLE_ENDIAN);
+                       0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ),
+                       RISCV_VIRT_UART_BASE_BAUD,
+                       serial_hd(1), DEVICE_LITTLE_ENDIAN);
         s->uart1_present = true;
     }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e4fbf4b64..63907d7362 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,6 +121,8 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
+#define RISCV_VIRT_UART_BASE_BAUD  230400
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
-- 
2.43.0


