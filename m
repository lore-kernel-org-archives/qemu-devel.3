Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CB606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FwIOB1IC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aOYcj5F4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjR-0000UJ-Ap; Thu, 12 Nov 2026 07:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTj0-00082j-NF
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTix-0002Vz-DK
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:17 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAUVkA1629181
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uQX4PMKh7dM
 hXSe32oSNpxkmTAwd5otkRrgQIcHy3tM=; b=FwIOB1ICrntXKpwZANvwANw6IeV
 FxQBG3UAUTX2YojpXOx9z0I6UNNM2mM0HiV2U+mIaIUSKfl5OJE4FoKNhBn4w9Re
 9I7KD854ml/KyIGl7wGf3UPmpL9/5O0Jl5UemJ6qAUd8pry+mKuvG6h3WahjFIDg
 THK8M6SjAh43Y14D3YgaFrPg4BbckGAadl8tKxNU14lZEVlb3MbEKaiYRHB5uDRi
 Q2QD4YiTjaPy+V9vsW8MuCY+64XparUuTXpas5hRFSf5u04Q82rGUzxy+SStGfN+
 yXM7WJoeP5KNySLXVd5b5VSLMQGrw0WsZrpnKJEJPjtlelagIKbCEmX9yPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00ax5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-535252004e9so81648981cf.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485774; x=1795090574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uQX4PMKh7dMhXSe32oSNpxkmTAwd5otkRrgQIcHy3tM=;
 b=aOYcj5F4M8teS+whP0BMsu9HpXzpD2QvWw5LJD7sxKkXHqP7Vy03DjW6DwNv/9x/D9
 Cov+/PEQZHn3DZRW8GRPYvCgCyiB+6/yn4lRuwpvmnMxNBwkB17WwDLFLOJdOOjAP3eD
 ZbOyJiwygI2pLbSyGyYzH8qyNm30YtTjXC3dscjU3hJEfPaPqpRyjK3fApCTSerA6igH
 rxgNeuPA3/JMg/MGCDkWFKvHbsb+jlhmq1DQFG7bFTU0dFcOrXGaSgH+J9iBwiM+RoTC
 tPmCsNTJLybb+SznnssZc77exyD4U7vkrS2ZyxXVCY8UWAucAXvPIM7j3jELWnnWWaUz
 Rnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485774; x=1795090574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uQX4PMKh7dMhXSe32oSNpxkmTAwd5otkRrgQIcHy3tM=;
 b=1ZQsGm0OhbTS7YvQ4nhRn4oxoSIOBWc5cMSMPXbHwBydICduQ8z516ydsBdLPYM83q
 /jljVLtGDL6qNNdch3drx6M003StPYJFmmJXXpdmGvUZOpmeq31AcAyOvhNQCLUm88QZ
 VvD8pl995F4pk1ZYkG9tJIg7cIj8mzzoqv/AM69gxLbEgvXifgSBHFoFGpRROyqnya3o
 lZbIbAFExThU33hcUC8f0RwPpduvdMcNQQDstC9B3cTQPxa9LG3qzQvcu5MinXkcQ47u
 SJrs3LB3/iBKV4UK/wP4ZdocpUJDKbhtH5e8PSW13wN+B1D8CRfsMFlx0moFdqRVX6wx
 m1tA==
X-Gm-Message-State: APuU4Z/ZhUEK4fhIBuhhAtcsHjf5V+SZhAyUygpLtVXy0983RyZlHf1q
 0WOkqcahQ9HotRmY4kLcOza1WCMJQOeTHnD8qIa1YBWkFobRt3y50+8irC84baOfV4DNJhfut8F
 rPWDHeBnLNW/GB4lzpEL2+OgYHEumih3Xe4W4r7et1g7SXetAR2YkLfCY/ZijutTwOQ==
X-Gm-Gg: AYBFou3Vb1NeHdeEKfxW2Qyu2UZnIJCUG0DmQs76DKRge2GcsgVOxD40Il1o+o8T85I
 21n6lbHbfT/KxJgVssSgNVm4vFEfhZcgdo7C23ZksLh9QETVLp03lV4JA39Q24x1NdZRsPixORe
 +debAUSzY4SamxWwwMJJcUraNZ+B/XFoW9Tw+TANyhvuaw5bDVpJwkGn/M9URt5d5zHv1kQ2fha
 heH+ELj9DMKFfQ2b9qIArWxgvVpem1xo/LOTAnVLQbOzwJsfgnIH9RrPXV3B7wy0eokrvmAqalM
 NNSm64s0a7T9a30KxcLySEqFN+fyy7cqreHrxE4vxlr5Rl55bdR2M136sXdZ+tGPdarLh/gCKQV
 UZ0du8pIX9rhKRpdJ2nPtayCfBs39lURNHv5uAHFpE2FCFKbFRklaxgY3JJS+UvzJeL+KoA/tFe
 5DfTTKfhRrPmo/uQzBx5OeFPFtgGVITosd6xr2HuHRrDPG
X-Received: by 2002:a05:622b:82:20b0:559:af0d:a4e9 with SMTP id
 d75a77b69052e-559af0dad13mr18052151cf.51.1794485773579; 
 Thu, 12 Nov 2026 04:16:13 -0800 (PST)
X-Received: by 2002:a05:622b:82:20b0:559:af0d:a4e9 with SMTP id
 d75a77b69052e-559af0dad13mr18051811cf.51.1794485772930; 
 Thu, 12 Nov 2026 04:16:12 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:16:11 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 4/5] hw/riscv/virt.c: fix base baud in serial_mm_init()
Date: Thu, 12 Nov 2026 09:15:52 -0300
Message-ID: <20261112121553.485439-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
References: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX55vZzKHrMTlm
 E0U+psW5BtlvOyjAYxUhEywRf+CGPAp46oMBdHRVroLFDu4esJGRz9sv+egY3CGnjhNg+RZqEYB
 B4g/1vMbLnppXPUxcUdYUhe4/p/tmaPpPNqjzkRb1BCDWTyAgqTo9OIbDFV5lFLJ6Bgy4PI8ZSi
 N/oh6vp4pah82Pz6J6Vp1o/NVqvCuTurZ0kvvg8ufjeNOP0McrylJPf8QXZbcfdzrUczOU0JKV6
 zYV7whPTfxpEMmbdqnKibbn3W4wlJMLLXvmuvN8iWBDBFe561zKLK7MAZfUJvEXo0lqTSPAp0PX
 7BtaCNEF7neEvAwS5QUr8ITjtAfcVuuMiH9mLLI1IFIqsxaqprjYmNT9K/D6AnJb9vdYCv1q52/
 A4QhJzTPWlexyPrs+HLaNs8CZLUqEm3yoETACaoMpAMNRQkvomn/JgjrVD99pVHlhP98g6Us3Mw
 nQtqRrqqfpZrzIGjhDw==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5ae0e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=YBD5noFLO0MiZe3rPCsA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfXwihrOxubHUbp
 KEOw9oTdTbPHsadcNqWkFeeBdOTUEtC2VIxMfrW6qQcRTvNjOCEubqG0cGxwcDQklIbPoN9Eofu
 RdP+AiLEBv6GYywqBHAMGVd0CljKT+8=
X-Proofpoint-GUID: 1s5vohukd2MSiaF4H1eI5Udl6MaKDGtC
X-Proofpoint-ORIG-GUID: 1s5vohukd2MSiaF4H1eI5Udl6MaKDGtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index dd1b02a7b3..08dee967ae 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -914,13 +914,15 @@ static void virt_machine_init(MachineState *machine)
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


