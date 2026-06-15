Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A6CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4V-0002wU-8j; Mon, 15 Jun 2026 16:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4T-0002uW-BN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4R-0002BE-Ej
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxOtN781835
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z4yQns9jU4e
 p1zWTD35WRA/ea/hOTSXawKKLOYOonNM=; b=CYySII+5rcWBWKq9E+OqgT1twql
 DqXNStuiF/1Yr+2SRZ9qh0U0xD68o9W06O7pDJSVhrN5AAf0VKpOY5sXqHay1yJf
 LAmaAHqv4hz+YYVEc16XgEROf4I9GhFchIBL/yMa+KuDmbTLpa07AID8QZ1mMs0y
 3GmJ9SlhzLg4rxU9BSHVqhrfDT2HWPXhO0vfN4I3D0mdEbjEsy4vQ8H0NTX2t0Yf
 D3cPc5JS9xLzmzZMFfmOCoEhbvmt07gI4e3aQB1hGyMlRyVv8ov3A6bkLUxKUTIp
 PJj0SgoWtDGXD1KjDGGehwZWXukiOBPU6u9hVa4ieMWbIex5+tMWNk/ViAw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtxtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cec2c6b821so79952996d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555879; x=1782160679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4yQns9jU4ep1zWTD35WRA/ea/hOTSXawKKLOYOonNM=;
 b=M0ALupF5zsgQiuI9bA13zEtz4DXr3NZU4eAlAbCYBTKcUTKSZVG2GE1Ts9kg5/rVgU
 jxWCS6x+I+XDSqZZs0qK2ad7jOKsOkOEaEvMS4uvpZg3/m0h9WGXlg7aUwLAaz95nEUz
 fao5SWXXJWmrvcoGj8ukfCB6rR94zP4sAEo9OcuoOQwHRlfoaPNfD8q4gyFggngcBC2c
 8TR4E0SvQiHOESlfdauTllGv0V7tBtKolRwXF5wn7ENT/nNXtV5l8x119A17TlfH49A2
 i61ed0VVlA+15ahKyfaRh2JJAsZ3pWPYUz5gWpnVj3OWi2+Y27puyA+JrPIRBT8RnY+Z
 AFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555879; x=1782160679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z4yQns9jU4ep1zWTD35WRA/ea/hOTSXawKKLOYOonNM=;
 b=JbTepv/RQizgfOIh9cL8PqjhvjYoPwEkBxyKb9F+R6LB3AxTtkQlwSix//FNy8vRqH
 xbFvKe971Yl9G0RpHRlgT9Hj9zwQx07qRN3QxPZBvNmvL54uH3WU08vJbTKvD1G0SyCb
 q/nL8BWEtHRu088HIPJIMKU0NKZBl4pxYHGjWngDpl+q74waKOAGk6Fkg9e7MIUvcpXj
 OBEYDI2FJsuRg8Z4xX6KFI1esC9GoYMfX5VJ6hBRQ5+HX8jqdWBC3XV4xakbLH/aAJt9
 odlmXR7NWRzh4dwiBo9D+uL55g4scAPUmIrH7QtFYsY2InKcwhGTwvT9CKSt5bBBn/6n
 PFeQ==
X-Gm-Message-State: AOJu0YxJ93Zmv4HwdzMRoYvnHhzZ1VG+Akv5LhvGQNIi/UvUljA3wcvm
 TuH7nfI7K1/55Z82bsOP+w3w4s7yC/LDoPKro+O7PzYDEJcHDZ/r/1y2HtmhAieDtDFyIdRX5Kh
 YQ7Z4n46aQ8mb5YhWtCL5DOtDl9Nc61rWZkwpaTT9QrmfWAof3O+Yck6KZp1Byy2H9w==
X-Gm-Gg: Acq92OHZJKxwhjXcCCyIc8U5cXEL+bmBDIbj8sC+FQyTZvSUfkmGfID07UWM784fV0N
 9ilVtQ3XbqrUK27nhKBaJi3GpS6T8/DqwVMwXsp1hXODR3mYylILh/hSPZQLvXiLJrnry9sDsZg
 bJkSPuE60M38tYorCSHHaGI8+0NmLW5VRLvNTIYdj+ZBR4r/Qy9xDk/DbY9KOO0yM7Ovt5KJKQ+
 8Ir8HzxMqv3zz8ZfG2evbBARdMdNK1knPqr9+8OqbT3sBN9hJcGYa7aI8q1z8yFW1u4xLwiMm6k
 6hOI6riP/W2nXVI3OmNv1qd/JBX8Fc76lgSk9W+TQ+6Y7vcW0DaFwNX7CPuaqGJqdczmjt276Qp
 DGVEbNx2JnMYIgfnR+DnZhqM+Dq2MKkJPZPyrWnlRuMHooMYJMt7h5tCbW6w=
X-Received: by 2002:a05:6214:1c05:b0:8ca:10aa:e1f9 with SMTP id
 6a1803df08f44-8da1eb4096amr11165276d6.42.1781555878804; 
 Mon, 15 Jun 2026 13:37:58 -0700 (PDT)
X-Received: by 2002:a05:6214:1c05:b0:8ca:10aa:e1f9 with SMTP id
 6a1803df08f44-8da1eb4096amr11164926d6.42.1781555878267; 
 Mon, 15 Jun 2026 13:37:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 08/13] hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
Date: Mon, 15 Jun 2026 17:37:28 -0300
Message-ID: <20260615203734.954428-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX9NMlsjiYlQ72
 09gaVMvghg7YMr2YwpIloCV52T7pj9NmsJYopBy3LWd5iT+1jLIR94o5ANTfYAsNEtMt60cbq8n
 8mtSDh3ap9Mso7XdEJ2EVRwxCs3reqezbFbPyE3mB5lBA6aRE8kVhA4KuR9ND6ZrrdsScbGylGN
 BR+eQzFudd6d2NtznfQN01VFBJI3hd5/bLjwTc8Y97bSPRGxDdq0NUWK8qrDBHPUI/bGY1Df4V3
 hqiaAClFi+OH9BkL0OZfqxYdvlFa459377dPm3Mv6PqeebpGFtRF6zABmqxXMm2TemBr6oJOzS0
 OhMtxCis9vtJo8oLUr9l3kfj3V3mRzCmrUK1ENgbRbkJXZS/XFauVSJCFuBG6S9ya8+rq30Cgk7
 6JPHx/ulu0rEq3f4Z0ybbiyj0v/Hy3tN4qfEX4oLygopg4akcy5aA3AnbpgzhrjHkfhbHEljw4d
 luFNhLuPktmHu5iSdmA==
X-Proofpoint-ORIG-GUID: UcLNNlpySnww6-s7rLnmD9xlRwmrqHTj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX6ooQ9DWyjKaQ
 A1gTaSXpxQJvRocY4kbORFThCmdvwerFahWlAirh8aCAUG4WWZBnc1bRWe2/uhFFoyN85wOagow
 MeIgMYBXBR27k6RNf6tDELoNePxqJZU=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a3062a7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=De3kZSdNAtJ2C2JbOQQA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: UcLNNlpySnww6-s7rLnmD9xlRwmrqHTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150218
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We want to consolidate the CPU socket FDT creation into a single helper.
'virt' and spike has the same code but sifive_u does not have cpu-map,
cluster and core subnodes.

These subnodes are present in other boards even in single socket configs
without NUMA.  This is a strong indicator that their presence doesn't
hurt a NUMA-less board like sifive_u.

Add these DTs to make the FDT standardization straightforward.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9a791b36d6..a4265fed0f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -109,6 +109,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         "sifive,plic-1.0.0", "riscv,plic0"
     };
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+    g_autofree char *clust_name = NULL;
 
     fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
         "sifive,hifive-unleashed-a00", &s->fdt_size);
@@ -143,11 +144,17 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+
+    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
+    qemu_fdt_add_subnode(fdt, clust_name);
 
     for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
         int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
+        g_autofree char *core_name = NULL;
+
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
@@ -173,6 +180,11 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
+
+        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+        qemu_fdt_add_subnode(fdt, core_name);
+        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
         g_free(intc);
         g_free(nodename);
     }
-- 
2.43.0


