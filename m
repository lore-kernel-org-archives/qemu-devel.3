Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69C0E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57L-0000Dv-Ni; Thu, 19 Feb 2026 09:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57K-0000DN-IX
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57I-00030n-TB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so10841385e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511695; x=1772116495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15BsUaxpg21YnBeuONEXheohe+kW6qaJbLz57+MUS6o=;
 b=ftSXkbO+Wis288snGSFTs0zxPs2nvVdzuaD3jYF3R4vNpLjs2iHj+ioT2nkRtG7Enl
 A/QFc+NIUd0alRkJHlOXIa5iVOec623Ie/ZoTBVC3OnG1kdwgUTdwi2nOys8UFRAmW8f
 HtFA5jvFGXjVjfhhhWCCJd3o/3Taqywi61rndo6KqIgjHMoVxNXsFITuCvdTcdyqyEOe
 N9ssqMxjzsPT3eoRopIGoE2AYylA9WoXEIz9Aje8q+T4ELLBT2sb9l1Ugq7TBruRznE3
 p5Q4iExmgnaIPrGLkVHZkOE+FIPxZntVJc50nlQ4qpZ8Pe2BurOyjfQygokX0Oo5caYn
 Eo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511695; x=1772116495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=15BsUaxpg21YnBeuONEXheohe+kW6qaJbLz57+MUS6o=;
 b=hKM1VqhT/TcOxt6ewnKVvS1GWsi8FfzzYJwbdhR5IPCy6GMVKYBxM9a6YEAm2JQZfr
 3XctZQfY8Op6GLeqqYjmO2K4KonTcAgPT9k5gmSQoIiEf6WeBVp0UNUfmnX9xPuUykAE
 C4/4cvF3EhtAeWGFyX+VyfFzKBK6Ig7jh8sK6at2V+Q4xdCOFtpySoeu7Ds/K9p9Ahyt
 X3UhqfoTkM+2mIqnMFWiAhWdZkv6fGFJFbE+oQpiuzC8Zn+EaVWKbHvvT2VyydsxIoCz
 11AffR7OQ/todQMGuWxWEMNefnf6DMF+ARWBtNaHYLQRZB/XDx61RE+DBR9HyqOCF6bI
 H37Q==
X-Gm-Message-State: AOJu0YxPOCef/Lfcrmc84dc7tnRqa63wyWGVpcmlG4YyonDOu3eSTXdh
 fKg5HnG5ERraVfghZQOtWGVD4DqQUGIZ/8lgaN2/kMJAQdJWqa2EuKtj77qXv8+M
X-Gm-Gg: AZuq6aLRz2i41SVkidtB9HTnzmyrnqUd/y5RzkXiVAvppP7oUltMc6M/nNzQ4fADA2T
 gxFAM/U8rRRvgBl7Z+u8Y4ozNZCbKqRdzJUSf1+796+pCtqfpsD6ChNIGIvsuHoeM7R0b6JT+XQ
 WNrrPbo2+o8qlc1GRDY7+5e59DeBinB8F5GZJQEwGB2jfQMrDKaExUtAsjOqhP3Zvd4ZQD5YlEl
 wr1UvZGZq1p+A97IStnZRIsarji7V8mXo4CkXi4mYOom0iotT60W0bTCjlLS+ejqVTgcH456/6x
 rOTCmDm4Nf5q8gIXZ1VmfqO7I4B3IP7VNdK5Pr+mFh7QDAMDLm8kUsx4Ft+ykECV8YPjN0Iz9FG
 jF5w8lHuLX21GrCDnViIiiTiztnCPfaSnkYthwadQRDJTOI7JSfls64fMGou38QncwbjnJMkcmN
 KVfSjd49nrjwheWWcZcuL9jloSBgRg7N+Or7xalgmWcUyzV1zVqjqeFEgv9iUfLUsVKzxn
X-Received: by 2002:a05:600c:c16b:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-48371043031mr350268985e9.7.1771511695002; 
 Thu, 19 Feb 2026 06:34:55 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:54 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 13/33] hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
Date: Thu, 19 Feb 2026 15:33:12 +0100
Message-ID: <20260219143332.3316679-14-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add TYPE_FDT_GENERIC_INTC class and interface to allow
interrupt controllers to register callback which can
be used to get IRQ's from this controller.

Optionally, interrupt controllers may also provide
auto_parent() callabck which can be used to attach
it to corresponding CPU's or other interrupt parent.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         |  7 ++++
 include/hw/core/fdt_generic_util.h | 59 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index a9ae56d1c3..d1465eafc1 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -711,6 +711,12 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     return 0;
 }
 
+static const TypeInfo fdt_generic_intc_info = {
+    .name          = TYPE_FDT_GENERIC_INTC,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(FDTGenericIntcClass),
+};
+
 static const TypeInfo fdt_generic_mmap_info = {
     .name          = TYPE_FDT_GENERIC_MMAP,
     .parent        = TYPE_INTERFACE,
@@ -719,6 +725,7 @@ static const TypeInfo fdt_generic_mmap_info = {
 
 static void fdt_generic_register_types(void)
 {
+    type_register_static(&fdt_generic_intc_info);
     type_register_static(&fdt_generic_mmap_info);
 }
 type_init(fdt_generic_register_types)
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index 38086ec1e4..c5aaa58dd6 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -16,6 +16,65 @@
 
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
 
+#define TYPE_FDT_GENERIC_INTC "fdt-generic-intc"
+
+#define FDT_GENERIC_INTC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericIntcClass, (klass), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericIntcClass, (obj), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC(obj) \
+     INTERFACE_CHECK(FDTGenericIntc, (obj), TYPE_FDT_GENERIC_INTC)
+
+typedef struct FDTGenericIntc {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericIntc;
+
+typedef struct FDTGenericIntcClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * get irq - Based on the FDT generic interrupt binding for this device
+     * grab the irq(s) for the given interrupt cells description. In some device
+     * tree bindings (E.G. ARM GIC with its PPI) a single interrupt cell-tuple
+     * can describe more than one connection. So populates an array with all
+     * relevant IRQs.
+     *
+     * @obj - interrupt controller to get irqs input for ("interrupt-parent")
+     * @irqs - array to populate with irqs (must be >= @max length
+     * @cells - interrupt cells values. Must be >= ncells length
+     * @ncells - number of cells in @cells
+     * @max - maximum number of irqs to return
+     * @errp - Error condition
+     *
+     * @returns the number of interrupts populated in irqs. Undefined on error
+     * (use errp for error checking). If it is valid for the interrupt
+     * controller binding to specify no (or a disabled) connections it may
+     * return 0 as a non-error.
+     */
+
+    int (*get_irq)(FDTGenericIntc *obj, qemu_irq *irqs, uint32_t *cells,
+                   int ncells, int max, Error **errp);
+
+    /**
+     * auto_parent. An interrupt controller often infers its own interrupt
+     * parent (usually a CPU or CPU cluster. This function allows an interrupt
+     * controller to implement its own auto-connections. Is called if an
+     * interrupt controller itself (detected via "interrupt-controller") has no
+     * "interrupt-parent" node.
+     *
+     * @obj - Interrupt controller top attempt autoconnection
+     * @errp - Error condition
+     *
+     * FIXME: More arguments need to be added for partial descriptions
+     */
+
+    void (*auto_parent)(FDTGenericIntc *obj, Error **errp);
+
+} FDTGenericIntcClass;
+
 #define TYPE_FDT_GENERIC_MMAP "fdt-generic-mmap"
 
 #define FDT_GENERIC_MMAP_CLASS(klass) \
-- 
2.43.0


