Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED3CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQJ-0005ki-Nq; Thu, 02 Oct 2025 07:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQC-0005jp-SQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:29 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPr-0005qW-Me
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:28 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d60501806so10734997b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404235; x=1760009035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDuC47W8l1hEZLeH/dJVOL+X1FV2Rfqtbu90OgZppqI=;
 b=itoAZ0SKoXKN7uUviHT8PlCn2lB9Q8NRzfxOrSbZzlp1WT5w/JMy8B4BQw0k+SnnBO
 urCHqorCb8lmVEAH91aS9/ORVNMNv/Ddq5lMmUrzGRK26DqUmL+7ehrT8BUM39fFUMLk
 0g3jH7O/e24S5lytbsisMI8wcSyHi5AKZTd4SHPmkKtygSV5h6BOY/VSecEiVVIUnDKq
 7OwJsvZZR7BbYtj1UHtzXndWi7wvPtWRxIOH4slVl8bP1cezC9ZvpuA6J9Cm6HvoWMq/
 xxdXsyZ7FHWcRWlv1vco734EkYarsmejEeGct2/MZeUJ2ga9uosf2MH9u5sxv13wOUPg
 buOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404235; x=1760009035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDuC47W8l1hEZLeH/dJVOL+X1FV2Rfqtbu90OgZppqI=;
 b=tUsJ4JmNx+lEKb6JGiUMoiviHNO6T6FLERANeRiYgEB5u38PAaczPGX4D+hiIiEOAw
 m9QtM65xPegF/CtIpl5Yo5IDnK124s2x3tRVg7fhcz/3yPV7/1cct3dCVNZEbdWuCnEx
 j6+U9XNy7KsQkthTTqPnSRlfxQOT8+N1jrrgaWbI/EAs4rv7QfLWMlnGXnfuqVOiQjCx
 E2Oy4ol6Iya5WSjKgqk4AUITzkJoiWdsxx3A9h9DYT0DWzx3fZHmNLm1MdFs79EyiK6P
 iTEXeuXUhP38pan8wVucQ1B+Rg4vfLk7mbdpQ6+bnQyZtMwQxt4JAx1FBVQNaGcSr3v4
 dYGw==
X-Gm-Message-State: AOJu0YwYtEcI7/LEl7HqjwIubzja8gZ+AeKkSQlOyBoKl30YUTa+uC+O
 QzwkRCCcNIPPAxYs0h/bC1h3yhxKLMjpjYHaS9LVNmQUJAxmWJXdwhSS4KxEgT/9hc57Qejh0En
 YOzdzl9Q=
X-Gm-Gg: ASbGncvautoOefvBZzX2DL1pNmVY9pdg0qSEWjrgEzRQNNr7JjLkqFz8mpH9VzZlC7B
 blPTh5+OmmOWVoOfRvn1HUJvVqtENPzw7OvpsqnaUBhcMVGk+dC0scASfIMTu3CbyarkPfuxvc0
 yMMjCxQ42dfQyNUGM3fiaf6RKobJ++Z0COW+oa0yL3DCnfDNp3ZfP352Ru5x1ErFIvz91KtncU4
 d69ihJxSqINJ5LDAWQPTb1fStQWiJNIofAvAyPIhnWEQaKT0rmF/PFTzQKTxjfX7G/xBOU/rc+Z
 UGar67jc/dZ2VE9ablzhl3sqzrGehgTMQfnXmCerF3+YAggVLDS3JL5sNjWvNlGgKze21NhVfBg
 84TPx9/Y+MNqv+otrQ9dX5B5+cDFFnYTlZ9s7AiM9uWQGx/jxJLfN9lbZI9lrRtyqoP01ZYmeEb
 E=
X-Google-Smtp-Source: AGHT+IFlNOnR1G8lcFGFWn2U2tsLamch2/ZZVOreOzp7MtvnehxtSzSOV5eMyj/ZvsKTHT7W3PvrUw==
X-Received: by 2002:a05:690c:7209:b0:76e:ffd6:b546 with SMTP id
 00721157ae682-77f6f28c144mr91599667b3.21.1759404234972; 
 Thu, 02 Oct 2025 04:23:54 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 05/17] hw/riscv/virt.c add trace encoder and ramsink fdt nodes
Date: Thu,  2 Oct 2025 08:23:23 -0300
Message-ID: <20251002112335.2374517-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mayuresh Chitale <mchitale@ventanamicro.com>

The trace encoder and trace ramsink nodes should confirm to the bindings
described in "riscv,trace-component.yaml" in the Linux kernel. That way,
encoder and ramsink devices get populated on the rvtrace bus and perf
record is able to capture the trace data in the auxtrace section as
expected.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6f5eaf5f8c..7ab407d782 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1142,6 +1142,62 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+static void create_fdt_rvtrace(RISCVVirtState *s)
+{
+    static const char * const tr_compat[2] = { "ventana,veyron-v2-trace",
+                                               "riscv,trace-component" };
+    g_autofree char *cpu_name = NULL, *ram_sink_name = NULL,
+                    *trencoder_name = NULL, *ep = NULL;
+    MachineState *ms = MACHINE(s);
+    int socket_count = riscv_socket_count(ms), i;
+    uint64_t addr, size = 0x100;
+    uint32_t rs_phandle;
+    RISCVCPU *cpu_ptr;
+
+
+    for (i = 0; i < socket_count; i++) {
+        for (int cpu = 0; cpu < s->soc[i].num_harts; cpu++) {
+            cpu_ptr = &s->soc[i].harts[cpu];
+            if (!cpu_ptr->trencoder) {
+                continue;
+            }
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                                       s->soc[i].hartid_base + cpu);
+            ram_sink_name = g_strdup_printf("/soc/ramsink@%d",
+                                            s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, ram_sink_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "dest-baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, ram_sink_name, "reg", 2, addr,
+                                         2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, ram_sink_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, ram_sink_name, "cpu", cpu_name);
+            ep = g_strdup_printf("%s/in-ports/port/endpoint", ram_sink_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            rs_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "phandle", rs_phandle);
+
+
+            trencoder_name = g_strdup_printf("/soc/encoder@%d",
+                                             s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, trencoder_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, trencoder_name, "reg", 2,
+                                         addr, 2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, trencoder_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, trencoder_name, "cpu", cpu_name);
+            ep = g_strdup_printf("%s/out-ports/port/endpoint", trencoder_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "remote-endpoint", rs_phandle);
+        }
+    }
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1166,6 +1222,8 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_uart(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
+
+    create_fdt_rvtrace(s);
 }
 
 static void create_fdt(RISCVVirtState *s)
-- 
2.51.0


