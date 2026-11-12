Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A1606A339
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GZTCrA0x;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R+OdQ+3u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjV-0000a8-Jf; Thu, 12 Nov 2026 07:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTiw-00081Q-QB
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTiu-0002VO-R2
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:14 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9CU294092378
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NxI1+DZPSHm
 2OBNcqU8iwN27qQ+ivTMTIzJsHGReJeI=; b=GZTCrA0xIHlGRzP2uwLxzDeHi4k
 b3lE/t470dnZgSHmChX5gT9UlH8quAOLQeZVJG43Zico+yPsDYLciXB4VRWY4sBv
 5ir6jWvgk7Kh56+VDvyAAVOE6WNd+79UHNUyv61tsvU0eNmbe5c5IyH30rX6XJ2r
 eCuOvxWA0uUjrjRE1cnRmx7egnjdmGSPvBPMdod2taBp91JN3h5vdQRFQQxZfweV
 qLXRVvJFBnaNHlkxVtQqnvaYElPhcyLXVUt2DQDLlk0y5AsRJ5nxhXGRfoyHV6PQ
 0PuUwc8drb0PNGE62RMb4ZYchtMKGxCtldDwn7MWqrGHgBi8st2D25YPqjw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8jra7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7bf2d734so93067076d6.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485770; x=1795090570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NxI1+DZPSHm2OBNcqU8iwN27qQ+ivTMTIzJsHGReJeI=;
 b=R+OdQ+3uNZkJ1zznx1dFIKJ/Ut+6T4EVRBheC8AwOHOKnozjl/lO3uZQ/HtPpIUaP2
 AYqmSOmjP13D39ZxDIyWY94eWxl+Gyh10/4PksKEVHMOPZXUL5+zyuAzhVh3g9Bkou0T
 Ozsiq5NeMenZw2El9SHvYoRJXWMGi9lU3L1hc+Ws+CQO7gXpbz1LCoLzDqFnbh68DUwb
 p88HnPhJ8GuvfciTUMylR0m4jUMwRSlAyXSwfRRvbhgfa5i4rwyvwVECy046CZ/CaOps
 hvd3saKZBH1/3v4Z2SCeq/HkkQBcsazH/wb5NwNEZwrUfVDAmrYlkiBuvN9uHNelCwkp
 +6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485770; x=1795090570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NxI1+DZPSHm2OBNcqU8iwN27qQ+ivTMTIzJsHGReJeI=;
 b=A8i/ZI65IoM/tHny45EbxOLvoenjj1B54Byz/7u5HjinF1SKTtZZbNegH9uF7lFEBD
 v2podg9FgtwrrHYCBC2g0DZuuuuaRkvDwS3eKLXNyo6ADhQlyOZJIrnM1kgrrOERPo0k
 Kg/85iR9JCeg0Dme0X9+1JZZ64eOCDvfJ+3MGWgFIyl3X5TYelegHo/eygZiT2tkXAl0
 tu/yxmXmfpa7/j7GlW9NodNXiFnVx3yhZI5UcQ2e5TK8SnABrAJUg8C5uRoY5EXgJApu
 YeYpPdI765MQPwRZkcoQVS2fvEHiSqYqKc3LoyVdY4+DaM2lg1uBazmLM75HXwjD74WS
 PZpQ==
X-Gm-Message-State: APuU4Z+RB/hAYHl7N0OQ9rEFTcoDgcqHA0jY1cJQ1AtMeuYaFYzqZBY/
 bAOhu8MXzVmr2aEKunVwjFTTXCyg1W0Padyl8men+n9411/JK7zKwy1VvFZ11Azr4tCJgCMQJMZ
 W3qBplu6jRDFQSh1gmuEWH+7CZTymO8JRB1kY5XKQzRIkf71CC71Om1AJq6MzOMg6iQ==
X-Gm-Gg: AYBFou3/g5m1JY/KW0lyIIzDou9/F9CczP8Cixaqow5zugjzspT6jNZsw0vvUQflUkC
 HR0x6RiRsbPXdd0cH5Ki7QjmKv+u2sB8zq/asWsPGM5Qtgk41fqKGmy9LGRgvC5ohndheA0v2un
 dc5GFqMRvB+JOCEFrDOGcnVxNC2Wogj5J22o1VGfYYPUZxvEYF1XClxIuqtZTyvagMx6AKth41p
 ARBFTKMJ2iVoJduT7QgbbfivFKXTFNnT9UH+WS8M+ow6VxTfhokkZ66kiZaPj/K988NEm6a8Q0s
 ADgEdcm/4jzoEOseLU3QrrKcA8J0OSqXKyTtZl/D0zJ+wQlkCYJ/cEYkE5XLD3EmDcXuKvrRrqo
 UM69uT84O2/UCCpIwW1EjFCAjmU4Op7KeuDR4FPmcSlb06rU43U4hxGhK2aPPtzdQ4ALJQNVdl/
 NOk/wldxr18LxQY84FNpxaBl8KdGMVnqZghmX6rcNNQ9hK
X-Received: by 2002:a05:622a:1c1a:b0:536:6902:daea with SMTP id
 d75a77b69052e-556c0ea78f7mr90885281cf.23.1794485770298; 
 Thu, 12 Nov 2026 04:16:10 -0800 (PST)
X-Received: by 2002:a05:622a:1c1a:b0:536:6902:daea with SMTP id
 d75a77b69052e-556c0ea78f7mr90884791cf.23.1794485769676; 
 Thu, 12 Nov 2026 04:16:09 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:16:08 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 3/5] hw/riscv/server_platform_ref: fix UART baud rate
Date: Thu, 12 Nov 2026 09:15:51 -0300
Message-ID: <20261112121553.485439-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
References: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX6ldTQ0TgSFZR
 dL8qHelIv4+h2yijdkJ2xQv3oLC/owA35eXvMpXcXAcLTZ3ijteO/GdED38OSro9/34WnkXAzwi
 WuuHLDIflnkmkZmVn4USZGdmQc2YVOs=
X-Proofpoint-GUID: 2JG7D83ZSxifUgYh2h01g6GPA_g9_3Qg
X-Proofpoint-ORIG-GUID: 2JG7D83ZSxifUgYh2h01g6GPA_g9_3Qg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfXydwGnqWH160c
 AJ9ll76qAIiaCAXEAqk4Z7QTjLyEJtif/toN0Eb9M9u+NTTIiEXHGqJlnlduT9VB2T8YR1NFKWa
 YDskWUKWEgbZh4biQuzsetp1LuS8baWfZScz9tdg59+iVMG7xLaS9z0xHn1z/4BPVSAetjby8Tr
 Mp7KHABK69dpzFIB+YZCnS7DjWaLmlDUW7GfmXF2BlrA/4uC4a5s9IFoL/lyHqhlCIyZmgmvg9o
 fS7UK+NFrIhTubALg5byuevrk06sHwQVgE3YE1tCqRHV2Xv0k186pVE51+uV4Y3KiZBWFCggK5I
 r1NjKucLKfu11uWM6e85xcxXS13wd3szoPMBeKRekjqGQQNPNb9X8nuGUST/nnUkqhCiwGGjvsF
 l8WTSzjbRFee0wLK/VbPjxulePT3S3vhDoKOKAgugRmd8LFwtRsei0vtD5RAduUp/P8zcFPrTI+
 Oy4TlUz/5T6cpWzfvUw==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af5ae0b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=HyuSmn1QhchWdNVMt-0A:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=kr7TZk85JJIQSqC0cl8G:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index d727ea6c41..af5114ac09 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -68,6 +68,7 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
 #define RVSERVER_IOMMU_HPM_COUNTERS            4
+#define RVSERVER_UART_BASE_BAUD                115200
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -315,7 +316,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
-                          0,
+                          RVSERVER_UART_BASE_BAUD,
                           irq_mmio_phandle);
     name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
@@ -613,8 +614,9 @@ static void rvserver_ref_machine_init(MachineState *machine)
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


