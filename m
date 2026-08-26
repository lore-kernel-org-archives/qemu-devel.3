Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A608AC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLSr-0003OX-HV; Wed, 26 Aug 2026 17:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSq-0003Nn-IA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSo-0001OB-Aa
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdH0w2001103
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CkXfbRfTd+rqOFiJ4L5vglxMVkj6QhelePq2/augL/c=; b=f+g2YRJrPRR9Zg/k
 ps+8M9pwkoF1y8ytGF2bjpSaGjw2Eb9P+DC3xf5RAupqyNK2G+bmAgoM0flxMma1
 R21SDgl+oX5RmPdRe94lEBs4b3OOgkMiRDGDepzfPWbUI6TGbkv0YWC8cqzR6LMk
 hUOykvXn2lzFj/145XXzcpngj2CmQYsoE0kmNxr529VRIvy/5aDkBRFzru6Is4j0
 1u4WE/uJr6oq+mFYhA7T+cQ9kHzO0DZ0Y60UaIlsD/Eu9ifeYL7yRZvct1ik6xrn
 wV4UWLfUou9STTPGrcDQnDOXxuX5E+Z5+EeCaAfm6All3pgESp0a7ts/zxuVrwf5
 +D6O8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec8w75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e538afe65so6780385a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780836; x=1788385636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CkXfbRfTd+rqOFiJ4L5vglxMVkj6QhelePq2/augL/c=;
 b=OEmXlhmNpoqVUucFdfL8oCflJC+fypUoPn5zhgguZ1KsIDX5US8Wi/S97z+Hff4qye
 cAG+ZYpzA03NBIaLeZ7yAEljox3m7RmCSIIRDpyzlPrdJjp4JEWcd1x2fg5+px/L965Y
 CkNK4ebB3q/rO3m3mCCbcfOAjgEyRtDUkrle7ICGkcTjiZOTHeuL1Q5N18POOPcc+ER8
 FYwKeesmZKLNEpqc0fPZgW7XdmNzNxtDiZU6sOI452YVl98+THXJaDx0SxjsiSzW0TRR
 hPdLZhCBwmAf+UN/8pD3Si1MzU8RHUBjYEmcKNIXoqRmwuSKjUi6jERrlMDeCblnVkDS
 D2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780836; x=1788385636;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CkXfbRfTd+rqOFiJ4L5vglxMVkj6QhelePq2/augL/c=;
 b=fQnSpRM8wZPbfvMSmMrv8io7LUpw9mdEWIAyt7TTn8ZckBdyx96plQklobwPWtt0EK
 +eWXO0G6sSeo5XwkxK4xAvP62VFOUi4g+JVYnUbKLkeIY2NLd/XVjAJaPmI3E8gMggfx
 u2JXEigMc88ZKAOLrBagqvkGuFskcRk0XKuKHJsZhSQ1M9AUkEMMhfXb40uo1TKPgSws
 mQOzPNDQiDVApXFaOh1TVsFzNzRMjQCmDP9L0H65iujxIaIDByiypHWatOV+08BFMHqy
 SfIi5DZJst3Emt5IAnfJIkJ8dx5mxVG9Tkik7/xDdp1z8j2YHFoAioUraa8YJjVwSx00
 LBNQ==
X-Gm-Message-State: AFuF++myWdeTEIQ5f7FzzgJzehKOI5e5w2mrTBMU2blAJ9LXiiBqkjX3
 2BRa96u3lpK52ibnv83GqXzNkWKIMoBLKwJAnMs+FsWZK9jOOxzMISHf1nYJHiEdj5bPabXu3kb
 Pi5XRi1gOsfR+NVRORkWkiPwP6zL0RkHYqexs8O5xz6HyrXdahQyzd1JpCigyagJZ5A==
X-Gm-Gg: AR+sD10ur78SIicUPp3oVxxHDyW4Uhhduh7jVefmC0j/FCGeq9lkZZ/6r4xbOCiytqv
 WSw41YOC9Txlw898d+/NpRC0wOEEHLjQQ4c0YvWVgY10mG2bPmLTRxg4FFeZG1433uCvlfdfXlh
 Xnztf+BV5+jF4ogoWz8CGhuhlXgPjoxQPBkWXi1W8VzLNZiSs6G2XkSA+rJrw4Z/ekT9toLLwXm
 u65Xgb1LHE5NnniSHDZppmzkGY4WA6TNRWl6J1p87lci3cPFjDFLZzNNSfyEefnFFv2a5u8uWsQ
 1s7g1g5E3IZOnQFPyNX0WHCQfrHBttwTDTj4+RTkNFyxe37ZnlVbjvraVouul3R5VU1dC2Rzu1f
 bbgx7fbS8Yr+BUaSNS4xlepovB4tr34F58vcNNg==
X-Received: by 2002:a05:6214:5681:b0:8f3:cf36:15ca with SMTP id
 6a1803df08f44-90cc7986152mr32463876d6.9.1787780835743; 
 Wed, 26 Aug 2026 14:47:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5681:b0:8f3:cf36:15ca with SMTP id
 6a1803df08f44-90cc7986152mr32463376d6.9.1787780835234; 
 Wed, 26 Aug 2026 14:47:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:47:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH v3 09/14] hw/riscv/fdt-common, virt.c,
 tt_atlantis.c: add riscv_create_fdt_uart()
Date: Wed, 26 Aug 2026 18:46:37 -0300
Message-ID: <20260826214643.122728-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f5ee4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=t9496tuAAAAA:8 a=yW3xyeNQz5FfInszwWYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: yveFFkcdXZQ56DB1u_J-ITj_Q8sd8mZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX9DHLmX0zE4i7
 7b12FgYKPveu3tjZ3iCT4STOW7KOoirVEjJVA9kiy8rn8VXMDBGvRVCvL6hMR0rcko5H/yHrv2f
 CUPWHfJbW6/h43B6DV7hrgSwrulLROtTu+XK1jOY8vAwXI/LJirw6Pze3eINn4yX9NkKIwoNGYy
 Ux5nnDUinwUykhZR1WeZSjOtn2grrwcLiu+I49G9f4lnouV61iAY0WmVPplwwU+LxMWtd38EvMV
 yE+oiwtJq2J6qiAd5VFd3YTIryH26XaxM+Edq/2tyZzlFczUZpoVLPe7J+NrHM3/m+5+E6vRhEV
 2ltunts3wROke/c9v4vYaXn5/EOyfUYXOuWWLfbygf6XWpLvSGZpHfeQx2DP02DvGrZB83oqAV0
 CC2xVdrFBh4ezdF45k+HSPkMWeer+x4cdyrakaa0+noY7QG/v5BZowYHVWqPY6WUbDKmodbX8Bs
 63wGKdqHjrn01feB5Yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX+Raqx/+Mu3YZ
 pAjDUg33Y5IAob1ef69fPX7nCyyVDQgZNrSS9fNiNOhctOHZF1VH4hjf6rCb/jyR0kjgF3K1Gk3
 GILYWbqKctiPCyvFVZATz29c3jih31c=
X-Proofpoint-GUID: yveFFkcdXZQ56DB1u_J-ITj_Q8sd8mZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260183
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.

To accomodate both boards the helper is doing the following:
- an 'uses_32_bit_spacing' flag controls whether we need to set a
  different uart reg spacing for the 'tt-atlantis' board;
- an 'is_serial0' flag is added to control whether we need to set
  additional properties related to the first serial.  This is required
  because the 'virt' board adds two uarts in the FDT.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
 hw/riscv/tt_atlantis.c        | 23 ++----------------
 hw/riscv/virt.c               | 44 +++++++----------------------------
 include/hw/riscv/fdt-common.h |  4 ++++
 4 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index e6bb107309..fb7098f213 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -795,3 +795,42 @@ void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
         g_free(name);
     }
 }
+
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           bool uses_32_bit_spacing, bool is_serial0,
+                           uint32_t irq_mmio_phandle)
+{
+    g_autofree char *name = NULL;
+
+    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx, uart_mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, uart_mem->base,
+                                 2, uart_mem->size);
+
+    /*
+     * The tt-atlantis board uses an uart that has 32 bit
+     * register spacing (0x0, 0x4, 0x8, 0xc....) rather than
+     * 8 bit spacing like 'virt'.
+     */
+    if (uses_32_bit_spacing) {
+        qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
+        qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irq_mmio_phandle);
+
+    if (aia_type == AIA_TYPE_NONE) {
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", uart_irq);
+    } else {
+        qemu_fdt_setprop_cells(fdt, name, "interrupts", uart_irq, 0x4);
+    }
+
+    if (is_serial0) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
+        qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
+    }
+}
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 6a2c57bb13..a265acbf0b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -260,25 +260,6 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
                          IRQ_S_EXT, s->soc.num_harts);
 }
 
-static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
-                            int irqchip_phandle)
-{
-    g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
-                                            mem->base);
-
-    qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
-    qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
-    qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
-    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
-    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
-
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
-    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
-}
-
 static void create_fdt_rng(void *fdt)
 {
     uint8_t rng_seed[32];
@@ -345,8 +326,8 @@ static void finalize_fdt(TTAtlantisState *s)
      *                       aplic_s_phandle);
      */
 
-    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
-                    aplic_s_phandle);
+    riscv_create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
+                          AIA_TYPE_APLIC_IMSIC, true, true, aplic_s_phandle);
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2e1d1ea12b..25d7d89a42 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -418,41 +418,6 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_uart(RISCVVirtState *s,
-                            uint32_t irq_mmio_phandle, int memId, int irqNo)
-{
-    g_autofree char *name = NULL;
-    MachineState *ms = MACHINE(s);
-
-    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
-                           s->memmap[memId].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[memId].base,
-                                 2, s->memmap[memId].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
-    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
-    } else {
-        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo, 0x4);
-    }
-
-    if (VIRT_UART0 == memId) {
-        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
-    }
-}
-
-static void create_fdt_uarts(RISCVVirtState *s, uint32_t irq_mmio_phandle)
-{
-    if (s->uart1_present) {
-        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1, UART1_IRQ);
-    }
-    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
-}
-
 static void create_fdt_rtc(RISCVVirtState *s,
                            uint32_t irq_mmio_phandle)
 {
@@ -578,7 +543,14 @@ static void finalize_fdt(RISCVVirtState *s)
                             s->memmap[VIRT_TEST].size,
                             FINISHER_RESET, FINISHER_PASS, true);
 
-    create_fdt_uarts(s, irq_mmio_phandle);
+    riscv_create_fdt_uart(MACHINE(s)->fdt, &s->memmap[VIRT_UART0], UART0_IRQ,
+                          s->aia_type, false, true, irq_mmio_phandle);
+
+    if (s->uart1_present) {
+        riscv_create_fdt_uart(MACHINE(s)->fdt, &s->memmap[VIRT_UART1],
+                              UART1_IRQ, s->aia_type, false, false,
+                              irq_mmio_phandle);
+    }
 
     create_fdt_rtc(s, irq_mmio_phandle);
 }
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 3d121d1098..bb76816f6b 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -128,4 +128,8 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                                    uint32_t *aplic_phandles);
 void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                                     uint32_t *intc_phandles);
+void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
+                           int uart_irq, int aia_type,
+                           bool uses_32_bit_spacing, bool is_serial0,
+                           uint32_t irq_mmio_phandle);
 #endif
-- 
2.43.0


