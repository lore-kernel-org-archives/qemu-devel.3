Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EB7D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2O-0008RB-Q9; Thu, 02 Apr 2026 17:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2I-0008LN-HJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2G-00078a-SP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so206763066b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167027; x=1775771827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEv5arXU/isUBZYgJvgLUA50xxPvAFJsx4xFvYCWEAU=;
 b=mR21d4FOvID1MUg94nwqPuUyx2BhLE8VdN2kCpHE6bDejwOegxI8jCpUcmSQWfIoJx
 7vciB0fXAbJDvVmvA4D2+VpCu8yTYFZVO5GfHhbT1aFmutefqX3r/OoGLKQjGICnfjbc
 /kv2KUMT4xt023Ztw/5Y6j6bqqOSdlYTgh8ZvfcINoRPkZrwA5z1yQUU/uVncU03J4nl
 eXT1BSJj5ZrvXswApqXo7IoFHTRbrIL7vZYjkWnaRRQgRaHorTN919Gex971D4GvmOZo
 +6HEyUNOG9RwUgt0w/iyb6KB1Y+9jhBbYMTc8E7Hu2W1gWlfoziulwhiImD2nLY1rIRS
 fYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167027; x=1775771827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IEv5arXU/isUBZYgJvgLUA50xxPvAFJsx4xFvYCWEAU=;
 b=H2W2GiztKZTJ5LNDZSHMsLSjxIwuugi5j4+t3jIFiW35PDxpyP2W6PIlmNX4K+Pd9j
 BHT2O7gBOEmi1DUJbX4zLsvnmeiE0mfgE6k69rE3Osx49lgh/O6CWLIYrAHpc/7ucZek
 hLVRLbY6nJthLg+mKA13NDx6aUVFhmsgW4eDU1gmKbj+h2J5Z/C0jqxeXH3U0Gw5RYBn
 jj4flr3PXuuKeonFMgikxrfsok4U2sLidkThWurFU/yipd9DQy+JtUWvuLYSU3BNSfAI
 kq3td0P78nctcGI89kgOZ/R+HBvN2hEyl1HPVqudOortDxt2eBlUvjXov8ASEo++40Li
 imCw==
X-Gm-Message-State: AOJu0YwZoyL+6qwpu2Kc/7FhZHOj5W7haO6Fk7rqlIKfeYtvyCpVaXS+
 OK3FiqerDixnuniqCOqalUBXy2noJn6bEHx9ZDrP268JMEwnlC/ru9HkFA52F7Xh
X-Gm-Gg: ATEYQzy3i3VXjwlZ9bRGyJ9XWmAyT/26WyXORVHKsqjh0CKGm1GXjZJc8aD3gif6gEA
 MDPVOhNjYsKbWFfAUqkrowsBf0u73iA895RJ4jChZac+bPH+rJkEvgPpLiaXaQMUtZ6EuyGK7Hb
 Gmiz/V5ks8oLt5DJ3wATV4/6BZew80NODu3z8PzG806Xz/azSPzgjfU4Oho01utbVjqB7AbY59G
 F8sLhZjP123TkBAlZt2pC0ohX4/kzCh48rz3/JA8zHFc4PT7DO5dF87CVsEOxy5mtNJao2nVWlu
 MvNzd0YgixYFV8BUkI6MRt5BlBbboG92xcLJ6DFK7ODzlfSf7rVYxbzRMDjlAQSC9sFe8m+XOju
 tm9GOrbeddPUYuFwnSFRofuJ3prIpNryEnIVD9gSTE3gUXyTGmYKMU+BKnkSJ9RF+vqAceJsWjd
 7G5KUURxJmYIkYD6bUAazeSxMu+Q0zIH7vNH0G2saaDpbUGWuj4ty74XKVFbpZjauFpiuSMA==
X-Received: by 2002:a17:907:86ab:b0:b99:1074:74f with SMTP id
 a640c23a62f3a-b9c67978769mr28859866b.34.1775167026951; 
 Thu, 02 Apr 2026 14:57:06 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:06 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 14/33] hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
Date: Thu,  2 Apr 2026 23:55:59 +0200
Message-ID: <20260402215629.745866-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x633.google.com
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
index 8f91bcb66c..d816e395fd 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -617,6 +617,12 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
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
@@ -625,6 +631,7 @@ static const TypeInfo fdt_generic_mmap_info = {
 
 static void fdt_generic_register_types(void)
 {
+    type_register_static(&fdt_generic_intc_info);
     type_register_static(&fdt_generic_mmap_info);
 }
 type_init(fdt_generic_register_types)
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index e3671990ad..c92c79dd12 100644
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


