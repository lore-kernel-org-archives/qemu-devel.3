Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017A606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i8FaS9bp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uo3t9fWJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTxRF-0004A8-9x; Thu, 19 Nov 2026 03:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRC-00049H-W9
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRA-0001PD-Vr
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:10 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vWoT330674
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QqA1QHICVXz
 3mKYzsZuWLXgNaKahLGodXLKev5agLdc=; b=i8FaS9bp3H4NL4fVfG6LIz9+ege
 4zxMuwHtFxvPNkZ76m/3pv+UEuUOK434kTl1N9Au9bcHTpN9joEFz0HaP96yho9H
 JZNJcs5upJNq4EKijND0tYlBy9/eAB0Hp6lOC2jYCdLdlOaoka+HSoO/qv/cqJUa
 JkTndLQeFxVIh0T2TPCKWG6mb5+6N1H4ev59q9DEXBD8P5x9FZrwTsfoMcmzpIVV
 RN8k7PZgTJl/u5wt/n9FuWUdMSTKFV/hj14mx4/5w/JjMcsbv3LcnG4Gn8yQ3zpm
 rHJNfS9LBRMjhYvxvHCd5HZUNpdc9uZTZeItssHMaa1yYA8Dyg1mx29MPGQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnkg3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-921170b7de5so23570606d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 00:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076646; x=1795681446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqA1QHICVXz3mKYzsZuWLXgNaKahLGodXLKev5agLdc=;
 b=Uo3t9fWJjhd2TGUs51ZIjwNZf9C49IZmWbXdKROPC3amNXWoUUp/1hT+ZqL1lXa4Cj
 NVBiE1tEdITTd50Tf2DaLykEaO5dgptT4hD4jRbtaCjC0rB6JvVFIei0GanbPF2PGmAU
 tciW8iyKHXROctkjs+UokaLE/J45Vxr4aHBIt8GsTiM6sdsncBaNfDkuUB6qoeDjYxsH
 iRk7vvhKF72PLV1sQIsZQhFg5CG9KwcCdAWdhiPKinjEWBfVZXQxmWSlA1eEVEUWV82a
 Bs2j0kSPsPxZwLgcjDGVc7lTw1iM3rqxNtQu2thZeV4dpn4URAv72Gf1aJUGMdxIaXtw
 hhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076646; x=1795681446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QqA1QHICVXz3mKYzsZuWLXgNaKahLGodXLKev5agLdc=;
 b=up+7M+iRWDg+EJxyfB21Ew8f3pjblUKuqMMG41yq78DAqKJt6UcfHjlNngKErs1WvM
 sPtP+w7pz4dMMrxpK2xl1nri8JHzSxusd2+kjuZTqA+S2+OqYzjyeuT/G4P3S8jHNea5
 yeM9X7IGmzLdnkpqOJeIg7s8rjt+l5RT3X8Dpe09TiTGHHjmaJriP/RrIaEvs/wjWhQl
 2BOdGmHl3Fuzz4fVQVZoD5RSpje9cma5uyu82Vu/hKoLXXWF8GbZTug57zLWjcN75bzz
 HUhLbN6dPCqF3NPbt8r463n7V1e8ZH4oTUf/X5Wb9/6VncqFxwy5iwU7KkSn6scfXqtu
 OKEg==
X-Gm-Message-State: APuU4Z97oIGxzYQ1JSOd5MOBrDW0Mk3nIo5ckaDcQhiLD57GyJah3ops
 qRINgZAuGTGD5V2kg41ynP+AN+qFrpPmkTBT1AKZfNJzkGi36EZlPj4vXBrzs4i8E6jZFB2TtnN
 ugIRS5r9LhWCrvI8Kag/9Elsyr3dRV0Ud28TXHY6HYl2asGzK6MmOEdI4Fkl9ZhA7VQ==
X-Gm-Gg: AZFdTZdZyTheBpoheNN/mYBezjSwmIfmAq0lBO2wZMJgvU0qLkz6kWAX7JZ4VF+21Z8
 dMrHr92dFp0MQGXr57cPv4R5zsnbsOGU+hmG9vhDSNG3PWMAFm4QppApMJNg08jRuy+zfnwJzKL
 111+2nlNsGu2X+iKbnwCbJorAo/Qk+8xCHGoY4k0iJYYESrXGxixywYqzfuqKUj4/e9u9JjMew2
 BLiq0pdby05WxlKB6lAhFXhqhO3A/4OTzsSvliramgxHfjKyTmFDM08pD8HwqI6I5Zj8PNo2vQn
 5FeAcn6fcluRUZQhV7/S4Cwutniv3IrQHmXTN0rjjGHtElKlMx1rS5vUTOQDdTWXk+cOQGVcvG7
 GoNcMHV39p68wVMwFso13AYLKGht/jIrJfnm8Rj4srUc2pUiHawKnhdy3fK/BULPQgxSHg+ywXG
 Nnc5KkVLZg
X-Received: by 2002:a05:6214:400a:b0:91f:3149:d961 with SMTP id
 6a1803df08f44-92114ec05ebmr84517646d6.29.1795076646292; 
 Thu, 19 Nov 2026 00:24:06 -0800 (PST)
X-Received: by 2002:a05:6214:400a:b0:91f:3149:d961 with SMTP id
 6a1803df08f44-92114ec05ebmr84517356d6.29.1795076645727; 
 Thu, 19 Nov 2026 00:24:05 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.137])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9211a6318aesm34524136d6.39.2026.11.19.00.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:05 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 2/5] hw/riscv: make UART FDT helper consider baud rate
Date: Thu, 19 Nov 2026 05:23:52 -0300
Message-ID: <20261119082356.1264726-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wXKN0F5-cb6_X-d2jKdjS9yrcfsDwUrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX3pNYtU/1HIdQ
 AoqKMrf52WkRl5ivAqphSAAro2+8VjSpFUbT22MrtwkT2mvo7Gh1L2F0s4mR4t7nPbPpOQRu8Yf
 FQHpsVhoZaXW5bRplT22hRYIUhEfL0FuKCZ8GxmyRncRyEU2w0lSl5C7jd9AgeSGZhj3/NKzyfJ
 yWIk0NY7i3RhwoMWT8504lD8BIXr379FTyxxL9Dejbrk3ESqam9VYz26bkiwss+khSdG0uvKPWc
 fJcbPFsVjd15xKZfs98eieU0/XK9B96y/7Rs9zizTE95263HdIR7m0IAxyg/nvuhYhi03Iei/0K
 yWH/+2xmW6aaCE0q5NnA+155ss71DuLG76T42lCDT8/ouVBp65P2cctMambYkBziMpbGMWMkijT
 UMqMyhUbrwC7cL3V0PV1DVsccby40MJVQuOZeZNErt/A7TY699EH3+mM8/iaNgBMiWwvudGnBWN
 SFM7awKak5QuNfKQ1Ww==
X-Proofpoint-ORIG-GUID: wXKN0F5-cb6_X-d2jKdjS9yrcfsDwUrS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX73rSdif35ixb
 7GxNxBcuJKZmcg3egeySJFyJRsCtlwN4TL9zPh7DpqHtYqvSPmKcN49zcORmFwOIvodmFXPFm/B
 p96nzKP5Pwr98dNUKnxcSER5W+mBIo4=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afeb227 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=a6tGUzlCxnQfwxx7nGpYxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=uxJGSlK6fkZaI5NcCCYA:9 a=1HOtulTD9v-eNWfpl4qZ:22
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

riscv_create_fdt_uart() is defaulting to a 3.6864 Mhz clock, which Linux
will interpret as a 230400 base baud serial.

We need more flexibility to set a different baud rate for UART devices.
Add an optional 'base_baud' parameter that allows callers to set a baud
rate for the related device.  We're keeping the existing default in case
the caller does not care to provide a base baud.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>`
---
 hw/riscv/fdt-common.c          | 19 +++++++++++++++++--
 hw/riscv/server_platform_ref.c |  1 +
 hw/riscv/virt.c                |  4 ++--
 include/hw/riscv/fdt-common.h  |  1 +
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index e90502b1bc..685b64531b 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -21,7 +21,11 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/riscv/aia.h"
 
-#define UART_STD_CLOCK_FREQ 3686400 /* 3.6864 MHz */
+ /*
+  * This 3.6864 MHz default clock results in a base
+  * baud of 230400 symbols/second.
+  */
+#define UART_STD_CLOCK_FREQ 3686400
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -798,11 +802,14 @@ char *riscv_fdt_get_uart_nodename(hwaddr addr)
     return g_strdup_printf("/soc/serial@%"HWADDR_PRIx, addr);
 }
 
+/* If base_baud = 0 this function assumes a base baud of 230400.  */
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
+                           int base_baud,
                            uint32_t irq_phandle)
 {
     g_autofree char *name = riscv_fdt_get_uart_nodename(uart_mem->base);
+    uint64_t clock_freq = UART_STD_CLOCK_FREQ;
 
     qemu_fdt_add_subnode(fdt, name);
     qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
@@ -810,7 +817,15 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                                  2, uart_mem->base,
                                  2, uart_mem->size);
 
-    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", UART_STD_CLOCK_FREQ);
+    if (base_baud != 0) {
+        /*
+         * The base baud formula is base_baud = clock_freq / 16,
+         * ergo clock_freq = base_baud * 16.
+         */
+        clock_freq = base_baud * 16;
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", clock_freq);
     qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_phandle);
 
     if (aia_type == AIA_TYPE_NONE) {
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index fb770cf6fb..5cb55a43a8 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -320,6 +320,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
+                          0,
                           irq_mmio_phandle);
     name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 016003d73d..9eccf62d4f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -398,11 +398,11 @@ static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
 
     if (s->uart1_present) {
         riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART1],
-                              UART1_IRQ, s->aia_type, irq_mmio_phandle);
+                              UART1_IRQ, 0, s->aia_type, irq_mmio_phandle);
     }
 
     riscv_create_fdt_uart(ms->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
-                          s->aia_type, irq_mmio_phandle);
+                          s->aia_type, 0, irq_mmio_phandle);
 
     name = riscv_fdt_get_uart_nodename(s->memmap[VIRT_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index b3b14ada0a..2a06aedb61 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -131,6 +131,7 @@ char *riscv_fdt_get_aplic_nodename(hwaddr addr);
 char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
+                           int base_baud,
                            uint32_t irq_phandle);
 void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
                           int rtc_irq, int aia_type,
-- 
2.43.0


