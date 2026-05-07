Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34098CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL126-0005sx-Ss; Thu, 07 May 2026 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL122-0005mV-Lz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL120-000435-Op
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso10562225e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169175; x=1778773975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+AgOP944w5f4wu7taCG9qXhAvfN+5wdVybT+wso3JIY=;
 b=Z32vyBM9kUP5NFu5Mbz0XbGVHrRGdwg8DS2ZJw+BOwDbdidNiImj6m4NL0ADiw8E5z
 8Z1v+i6qiZHImdcfE4FV8Gdo8rDKzF9J7rxVSvFIOcCwgQEe+Nx5yrC2lBz8NrL/ry/S
 fscm0wddK/aOAL4dsBtuYmz0DxdGw2orHHaq2RSlc0uZWKCvPMYU+kT7B2oVuwAoqucm
 JfaDGfWN8+vtnDnMcBYs8MzA6nx43nC6+havjHjlZ0TRrY+PhXg5owTXlMEXjZJOEnXA
 PGMCutAfZwbRprwEPTF3gpRAgcqXLE9+4laVzmcAAmqXGYg0VMZCi0Z277+ENfvewmmM
 6+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169175; x=1778773975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+AgOP944w5f4wu7taCG9qXhAvfN+5wdVybT+wso3JIY=;
 b=KlQMgEgobqmlRB9eRIrmZsYDeaRDZpokgStTSWsj0l1Al5VE4y+h10oeYHTYZszP2m
 s3qJNa2owfjpp02+feTJSAMeUXXBNxIXmMhrgwt/5eqftWDqKEh/XIg70QwvOpJYEr3h
 SbU5D5fhJmn3QN3jJUqHqLbodiPhh1Z7LRTmv2cA7bjmRRScyzBgONfoixVqehW3EjHK
 Q7PNS/epB+2+RxnU/TW14uJTDTdAAQBXrmPuGOKKkUVhyAAKzUtUMP9Z02zUXzSrBKyp
 fwkCL1y1OCD4UdmqtpUiibOaHDQZTQqg/KQ0l8CvB3gY65aThr31bVnUxkwWOgoUKziO
 LjsA==
X-Gm-Message-State: AOJu0YyoGIakeuzithxvcp6RcJJez256Uvykc7HzSmf1waoXzZCe4uJ6
 sTkswiSSrW9na/2AjZ//dCYtYzi8/NxoYFhWhXSlGLChT/ljYidSG67UB47Bblp6pm19tqgB0tS
 6gZDu
X-Gm-Gg: AeBDietAlnTbz33oRFryd+d44+HZxuuqvi+I8OzkwpivdKRfuMl1bgsRJ578Zmqhk+/
 c9oDST8nZPT8gnu3n9I29NWUT44haMiaR02Bh3pKWBo6co4sSTQxMf9sgkyFcGbLpUeH32Uxbjl
 GO6bDfSKY3oh3Yqw+DE3LlxOBAlGob+xE8NCiwaNEzwPR2F85qghpBhOQaCr2v1UZ2lcCwlfeaS
 TrQxoMGcBezJbZB9gd80+VUK5ge0t4783Uj4nDHc0Vgwl86vHvJG++QImMGHL32g2YeVxgm8kN4
 JTOz2fMIkHGG3qhqUVd9GntcvAV05ku8jx9j+McFK1Fmdrbez1PY8ASDrxMvLXPcV66fW4SuYBm
 42gI9jiQVT47Sgvs3e9SIU1X383jVu86qv7Nb3+IVTtQJQa0unvSnDCRRSg/9E/W8/av0koMi3H
 CSm4cJx/cJmYBEipyN+aNJIj1Wen6wlDsHRVLhHshXZA464+o5Bo1JLDOIK3XrqbZQWS5l0I3MW
 SNozL9TC/0JRN0hrNKjyaVK9zC59JjaZ68ehhNBMQ==
X-Received: by 2002:a05:600c:8485:b0:48d:364:e236 with SMTP id
 5b1f17b1804b1-48e51f30493mr147794285e9.18.1778169175002; 
 Thu, 07 May 2026 08:52:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/67] hw/arm/virt: Advertise GICv5 in the DTB
Date: Thu,  7 May 2026 16:51:48 +0100
Message-ID: <20260507155154.1886557-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Advertise the GICv5 in the DTB. This binding is final as it is in
the upstream Linux kernel as:
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-62-peter.maydell@linaro.org
---
 hw/arm/virt.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cf4d430454..3caba6e5d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1120,6 +1120,72 @@ static void create_v2m(VirtMachineState *vms)
     vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
+static void fdt_add_gicv5_node(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    const char *nodename = "/intc";
+    g_autofree char *irsnodename = NULL;
+    g_autofree uint32_t *cpu_phandles = g_new(uint32_t, ms->smp.cpus);
+    g_autofree uint16_t *iaffids = g_new(uint16_t, ms->smp.cpus);
+
+    vms->gic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", vms->gic_phandle);
+
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", vms->gic_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "arm,gic-v5");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
+
+    /* The IRS node is a child of the top level /intc node */
+    irsnodename = g_strdup_printf("%s/irs@%" PRIx64,
+                                  nodename,
+                                  vms->memmap[VIRT_GICV5_IRS_NS].base);
+    qemu_fdt_add_subnode(ms->fdt, irsnodename);
+    qemu_fdt_setprop_string(ms->fdt, irsnodename, "compatible",
+                            "arm,gic-v5-irs");
+    /*
+     * "reg-names" describes the frames whose address/size is in "reg";
+     * at the moment we have only the NS config register frame.
+     */
+    qemu_fdt_setprop_string(ms->fdt, irsnodename, "reg-names", "ns-config");
+    qemu_fdt_setprop_sized_cells(ms->fdt, irsnodename, "reg",
+                                 2, vms->memmap[VIRT_GICV5_IRS_NS].base,
+                                 2, vms->memmap[VIRT_GICV5_IRS_NS].size);
+    qemu_fdt_setprop_cell(ms->fdt, irsnodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, irsnodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(ms->fdt, irsnodename, "ranges", NULL, 0);
+
+    /*
+     * The "cpus" property is an array of phandles to the CPUs, and
+     * "iaffids" is an array of uint16 IAFFIDs. For virt, our IAFFIDs
+     * are the CPU indexes.  This function is called after
+     * fdt_add_cpu_nodes(), which allocates the cpu_phandles array.
+     */
+    assert(vms->cpu_phandles);
+    for (int i = 0; i < ms->smp.cpus; i++) {
+        /*
+         * We have to byteswap each element here because we're setting the
+         * whole property value at once as a lump of raw data, not via a
+         * helper like qemu_fdt_setprop_cell() that does the swapping for us.
+         */
+        cpu_phandles[i] = cpu_to_be32(vms->cpu_phandles[i]);
+        iaffids[i] = cpu_to_be16(i);
+    }
+    qemu_fdt_setprop(ms->fdt, irsnodename, "cpus", cpu_phandles,
+                     ms->smp.cpus * sizeof(*cpu_phandles));
+    qemu_fdt_setprop(ms->fdt, irsnodename, "arm,iaffids", iaffids,
+                     ms->smp.cpus * sizeof(*iaffids));
+
+    /*
+     * When we implement the GICv5 IRS, it gets a DTB node which is a
+     * child of the IRS node.
+     */
+}
+
 static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
@@ -1161,6 +1227,8 @@ static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
      * that information is communicated directly between a GICv5 IRS and
      * the GICv5 CPU interface via our equivalent of the stream protocol.
      */
+
+    fdt_add_gicv5_node(vms);
 }
 
 /*
-- 
2.43.0


