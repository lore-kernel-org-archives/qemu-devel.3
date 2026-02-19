Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07202E9A04D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57N-0000Ez-74; Thu, 19 Feb 2026 09:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57M-0000Eb-Hf
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57K-00031M-He
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so694051f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511697; x=1772116497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52LpKx5PjCvsBbUvDEQ/GR7vrZlvEyVnyZodnShE5dU=;
 b=Cj9JFUwZR4iAzbIIJGo0u+wbeIBEWQAp6vYA/xqn3+gBb5qqgqzn66gWUcnWn6y3X6
 8ZJPED6LsFhsFH9C+DJzfupuRNMU4LbyLfanhwjccvwq1NxWH3DPx+Orisg643QBZToR
 dC6ymGAqVQOAfLaoSIGfcQtykydhrmwBNXCs4mbLHfiC1pci7PoThsEBuIm/oYEXPOgp
 t2PMTg+FsdvlfKlKaRsC7zwxEYwzgWHwRhos6TZirp0+AQNG5G0z8mr8H8nqXEZcW28w
 Z+Q6HF+2zDzqx3OIgDkgwL4u8WLDtMvsJq37lRUCbOL6mLcpFz5ZU/sPSStQHsZWS2NB
 JmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511697; x=1772116497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=52LpKx5PjCvsBbUvDEQ/GR7vrZlvEyVnyZodnShE5dU=;
 b=V1P84oMu6oh1WRxn16XLgRzvogZJlfXtdOnOCCgDx+UBFclvDE+2kV3pzF3wGzqPgd
 3AIN70smX6OIz+WLktglPgJP2hEYrBmVLK8uGAHzTmNk5XZofmH+JTsV/fkr5C4xxgGM
 qyCwIb9WZScgmG8VuPpOdJKsoV1wlM7qV8HxctIft6V7avUS18tldGIRPMAgv5V+01C/
 lWURCzYaMxtKeuaJoK42+xN8e9yFibvTYUPEt5hJnJHd0+Vtg5oZT/Eq6qatFjYS7pGI
 Nk5QLFlWA4Q9UK+Db+9WoCb+fUQ1FZlyWRFL1pD+VPA/794gHwDgWY4Uc2zc/Mj75ObC
 oh6A==
X-Gm-Message-State: AOJu0YyBrrZjX0b2H1Bn5leUeIpD07euLZfudyRkI1sQaZpwimvMF4O+
 DoXvCEPfRfZPmOVs7pg0iq0Z1GiRgi8+iYoYE+JeGvSuz8VZKvUEUnDnDdNps7TI
X-Gm-Gg: AZuq6aIa6qrMh/8X/CwTbL5yQrDbheJRUApDKCNP01osFhhV6qPZ2Izpk5dvn71emPn
 Gi4Dt/0+47PaSeaUSIdOUCIrAjp7X/sbfmp2fsHgSH1RlSlxupyvpscdgXiv9ZcjHdd3S1zZETI
 pXU6sGnw+lc0NBJ4OGQs9UwRRsRKhamOGwAlQrwjG+TDEQl/S3HXXc0xIMJBIhBksfqy3iNhOYp
 b+EjEbR+d/R8958+MVXU08Cj902WeFt5Gqxcic0P6pULgaRW8ASOmyJUYows2OHKe6W90xH8GUY
 2pfmIN5YmW5nD1YIoOnrl52y4cT8XAiVIIlpqjd5Xew54bif5euHF5AZP4LB+jiDp3t/trCLeHp
 GG0uVyFkD7kZCyHXys08Tkkt7J29hLfJAH+195OtAI0nvNXX2QrJcBBKih7JTvCsIS+AiRn1smK
 9vtEN+SlhNoq4gV8D6Mv70/gDMp+Bp/j9SGDkwpbDG5Phrggouc1DdPHDLP6ILEumWGp20
X-Received: by 2002:a05:6000:1a8a:b0:437:6bcd:77f9 with SMTP id
 ffacd0b85a97d-4379db98640mr31342797f8f.40.1771511696540; 
 Thu, 19 Feb 2026 06:34:56 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:55 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 14/33] hw/core/fdt_generic_util: implement
 fdt_get_irq/_info API
Date: Thu, 19 Feb 2026 15:33:13 +0100
Message-ID: <20260219143332.3316679-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Both interfaces may be used by devices to get IRQ information
based device tree entry.
Both methods will identify interrupt parent for a device and
retrieve irq entry.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 267 +++++++++++++++++++++++++++++
 include/hw/core/fdt_generic_util.h |  18 ++
 2 files changed, 285 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index d1465eafc1..dcacc5033b 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -70,6 +70,11 @@ static int fdt_generic_num_cpus;
 
 static int simple_bus_fdt_init(char *bus_node_path, FDTMachineInfo *fdti);
 
+static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                       char *intc_node_path,
+                                       uint32_t *cells, uint32_t num_cells,
+                                       uint32_t max, Error **errp);
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     char node_path[DT_PATH_LENGTH];
@@ -241,6 +246,268 @@ static int simple_bus_fdt_init(char *node_path, FDTMachineInfo *fdti)
     return 0;
 }
 
+static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                       char *intc_node_path,
+                                       uint32_t *cells, uint32_t num_cells,
+                                       uint32_t max, Error **errp)
+{
+    FDTGenericIntcClass *intc_fdt_class;
+    DeviceState *intc;
+
+    while (!fdt_init_has_opaque(fdti, intc_node_path) &&
+           qemu_in_coroutine()) {
+        fdt_init_yield(fdti);
+    }
+    intc = DEVICE(fdt_init_get_opaque(fdti, intc_node_path));
+
+    if (!intc) {
+        goto fail;
+    }
+
+    while (!intc->realized && qemu_in_coroutine()) {
+        fdt_init_yield(fdti);
+    }
+
+    if (!intc->realized) {
+        goto fail;
+    }
+
+    intc_fdt_class = FDT_GENERIC_INTC_GET_CLASS(intc);
+    if (!intc_fdt_class) {
+        goto fail;
+    }
+
+    intc_fdt_class->get_irq(FDT_GENERIC_INTC(intc), ret, cells, num_cells,
+                            max, errp);
+
+    return;
+fail:
+    error_setg(errp, "%s", __func__);
+}
+
+static uint32_t imap_cache[32 * 1024];
+static bool imap_cached;
+
+qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                          char *info, bool *map_mode) {
+    void *fdt = fdti->fdt;
+    uint32_t intc_phandle, intc_cells, cells[32];
+    char intc_node_path[DT_PATH_LENGTH];
+    qemu_irq *ret = NULL;
+    int i;
+    Error *errp = NULL;
+
+    intc_phandle = qemu_fdt_getprop_cell_inherited(fdt, node_path,
+                                                   "interrupt-parent",
+                                                   0, &errp);
+    if (errp) {
+        errp = NULL;
+        intc_cells = qemu_fdt_getprop_cell_inherited(fdt, node_path,
+                                           "#interrupt-cells", 0, &errp);
+        *map_mode = true;
+    } else {
+        if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                             intc_phandle)) {
+            goto fail;
+        }
+
+        /* Check if the device is using interrupt-maps */
+        qemu_fdt_getprop_cell(fdt, node_path, "interrupt-map-mask", 0,
+                              &errp);
+        if (!errp) {
+            errp = NULL;
+            intc_cells = qemu_fdt_getprop_cell_inherited(fdt, node_path,
+                                               "#interrupt-cells", 0,
+                                               &errp);
+            *map_mode = true;
+        } else {
+            errp = NULL;
+            intc_cells = qemu_fdt_getprop_cell_inherited(fdt, intc_node_path,
+                                               "#interrupt-cells", 0,
+                                               &errp);
+            *map_mode = false;
+        }
+    }
+
+    if (errp) {
+        goto fail;
+    }
+
+    DB_PRINT_NP(2, "%s intc_phandle: %d\n", node_path, intc_phandle);
+
+    for (i = 0; i < intc_cells; ++i) {
+        cells[i] = qemu_fdt_getprop_cell(fdt, node_path, "interrupts",
+                                        intc_cells * irq_idx + i, &errp);
+        if (errp) {
+            goto fail;
+        }
+    }
+
+    if (*map_mode) {
+        int k;
+        ret = g_new0(qemu_irq, 1);
+        int num_matches = 0;
+        int len;
+        g_autofree uint32_t *imap_mask = g_new(uint32_t, intc_cells);
+        const uint32_t *prop;
+        uint32_t *imap;
+        bool use_parent = false;
+
+        for (k = 0; k < intc_cells; ++k) {
+            imap_mask[k] = qemu_fdt_getprop_cell_inherited(fdt, node_path,
+                                                 "interrupt-map-mask", k + 2,
+                                                 &errp);
+            if (errp) {
+                goto fail;
+            }
+        }
+
+        /* Check if the device has an interrupt-map property */
+        prop = qemu_fdt_getprop(fdt, node_path, "interrupt-map", &len,
+                                  &errp);
+        imap = g_memdup2(prop, len);
+        if (!imap || errp) {
+            /*
+             * If the device doesn't have an interrupt-map, try again with
+             * inheritance. This will return the parents interrupt-map
+             */
+            use_parent = true;
+            errp = NULL;
+
+            prop = qemu_fdt_getprop_inherited(fdt, node_path, "interrupt-map",
+                                      &len, &errp);
+            if (!imap_cached) {
+                memcpy(imap_cache, prop, len);
+                imap_cached = true;
+            }
+            imap = imap_cache;
+
+            if (errp) {
+                goto fail;
+            }
+        }
+
+        len /= sizeof(uint32_t);
+
+        i = 0;
+        assert(imap);
+        while (i < len) {
+            if (!use_parent) {
+                /*
+                 * Only re-sync the interrupt-map when the device has it's
+                 * own map, to save time.
+                 */
+                prop = qemu_fdt_getprop(fdt, node_path, "interrupt-map", &len,
+                                          &errp);
+                if (imap != imap_cache) {
+                    g_free(imap);
+                }
+                imap = g_memdup2(prop, len);
+                if (errp) {
+                    goto fail;
+                }
+
+                len /= sizeof(uint32_t);
+            }
+
+            bool match = true;
+            uint32_t new_intc_cells, new_cells[32];
+            i++; i++; /* FIXME: do address cells properly */
+            for (k = 0; k < intc_cells; ++k) {
+                uint32_t  map_val = be32_to_cpu(imap[i++]);
+                if ((cells[k] ^ map_val) & imap_mask[k]) {
+                    match = false;
+                }
+            }
+            /*
+             * when caching, we hackishly store the number of cells for
+             * the parent in the MSB. +1, so zero MSB means non cachd
+             * and the full lookup is needed.
+             */
+            intc_phandle = be32_to_cpu(imap[i++]);
+            if (intc_phandle & (0xffu << 24)) {
+                new_intc_cells = (intc_phandle >> 24) - 1;
+            } else {
+                if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                                     intc_phandle)) {
+                    goto fail;
+                }
+                new_intc_cells = qemu_fdt_getprop_cell(fdt, intc_node_path,
+                                                       "#interrupt-cells", 0,
+                                                       &errp);
+                imap[i - 1] = cpu_to_be32(intc_phandle |
+                                            (new_intc_cells + 1) << 24);
+                if (errp) {
+                    goto fail;
+                }
+            }
+            for (k = 0; k < new_intc_cells; ++k) {
+                new_cells[k] = be32_to_cpu(imap[i++]);
+            }
+            if (match) {
+                num_matches++;
+                ret = g_renew(qemu_irq, ret, num_matches + 1);
+                if (intc_phandle & (0xffu << 24)) {
+                    if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                                         intc_phandle &
+                                                         ((1 << 24) - 1))) {
+                        goto fail;
+                    }
+                }
+
+                DB_PRINT_NP(2, "Getting IRQ information: %s -> 0x%x (%s)\n",
+                            node_path, intc_phandle, intc_node_path);
+
+                memset(&ret[num_matches], 0, sizeof(*ret));
+                fdt_get_irq_info_from_intc(fdti, &ret[num_matches - 1],
+                                           intc_node_path, new_cells,
+                                           new_intc_cells, 1, NULL);
+                if (info) {
+                    sprintf(info, "%s", intc_node_path);
+                    info += strlen(info) + 1;
+                }
+            }
+        }
+
+        if (imap != imap_cache) {
+            g_free(imap);
+        }
+        return ret;
+    }
+
+    DB_PRINT_NP(2, "Getting IRQ information: %s -> %s\n",
+                node_path, intc_node_path);
+
+    ret = g_new0(qemu_irq, fdt_generic_num_cpus + 2);
+    fdt_get_irq_info_from_intc(fdti, ret, intc_node_path, cells, intc_cells,
+                               fdt_generic_num_cpus, &errp);
+
+    if (errp) {
+        goto fail;
+    }
+
+    /* FIXME: Phase out this info bussiness */
+    if (info) {
+        sprintf(info, "%s", intc_node_path);
+    }
+
+    return ret;
+
+fail:
+    if (errp) {
+        sprintf(info, "%s", error_get_pretty(errp));
+    } else {
+        sprintf(info, "(none)");
+    }
+    return NULL;
+}
+
+qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                      bool *map_mode)
+{
+    return fdt_get_irq_info(fdti, node_path, irq_idx, NULL, map_mode);
+}
+
 /* FIXME: figure out a real solution to this */
 
 #define DIGIT(a) ((a) >= '0' && (a) <= '9')
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index c5aaa58dd6..dfc9fa3632 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -16,6 +16,24 @@
 
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
 
+/*
+ * get an irq for a device. The interrupt parent of a device is idenitified
+ * and the specified irq (by the interrupts device-tree property) is retrieved
+ */
+
+qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                      bool *map_mode);
+
+/*
+ * same as above, but poulates err with non-zero if something goes wrong, and
+ * populates info with a human readable string giving some basic information
+ * about the interrupt connection found (or not found). Both arguments are
+ * optional (i.e. can be NULL)
+ */
+
+qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                           char *info, bool *map_mode);
+
 #define TYPE_FDT_GENERIC_INTC "fdt-generic-intc"
 
 #define FDT_GENERIC_INTC_CLASS(klass) \
-- 
2.43.0


