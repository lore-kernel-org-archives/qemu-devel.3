Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354F9C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOao-0008P5-Lc; Fri, 09 Feb 2024 05:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOam-0008J4-Ql
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:48 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOal-0000CR-2m
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:48 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e04f29c7bcso567453b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476325; x=1708081125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPaIihZqgTI36P3su/SudJp3fo1RzbBuQ0cqqYd2VBw=;
 b=dI4U7xToha2bn8Lp6tMY+47e1asRaHlZfGVa444/Vvtp3Smn5xvbhCdD9o+YM+OE6v
 q6S0zvrGRPL2d9GFYY27PbU98lpZZJB1AKYEE3fLdenDU2Boy5YZ1Mz/z845wxq6OEsJ
 rzRVLXW+U8YY6rJpmyrc0gRrqWTsm+if9GdJJddivd0AVhvx5i1FqSX5W/YMerBTCwXs
 uuMvc0wQKnlg45UWSNmbJocTGv8BohIzozGIL/wRbssBmevz7kl0OqVk5P6ryERgSCLM
 z9lrf9Nb1Pr1R52FejDFqYMYcUbDaZ362mU/FlvKjBTFePQtbbVEJaJ8544s7mYn3QvX
 0cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476325; x=1708081125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPaIihZqgTI36P3su/SudJp3fo1RzbBuQ0cqqYd2VBw=;
 b=Zxx9b6W8P/HqWHNEOxq8CC/RkXv0sr2cJom/TeNt6NC5/8MGZfDK5+Tg18jitQu2br
 KBHIJpRbR9Ylcy/KWvmJKlrwBqBRCzXxsd+AfMRIcr11Szqn6WsHBfCSRjG/oPmM6axs
 zC/inurXKi3cEZ+2QjACeXMvlll/7pMRAIaTzv6x2cQRRxZ0ngW9qAlJWUYXz+a9GOac
 eJoug/tgpIDn630H/3+hZDAjDKF9U0X1X7N6h+n22B0m7LcGVDQzBxUb1FPgnl1NPN3v
 4faQqgoGJkoFp83UMIKozEIG3fRAw9TlmPRrpBXPL3F3P32BNQ9X17W4jkreBlSDTlYf
 IDqQ==
X-Gm-Message-State: AOJu0YxPKQc9KWqPth/RSkbIvCyxlCODESwaRJX6NxfpRkqaBGtS2W+n
 2XKhREH0Dz+j2FnYq1uOrB8fRmDANYmSlhCgSTSZ9IBSi6vNNRt/oqONLf+PJpRZzg==
X-Google-Smtp-Source: AGHT+IEeQlZjfvPPuO1LOEyTghFH+YkVjag/xpxnZi7Xv3cMKo3ScNSHutDf1wjXdzcZh1CN/gGwng==
X-Received: by 2002:a05:6a21:e85:b0:19e:97ee:af55 with SMTP id
 ma5-20020a056a210e8500b0019e97eeaf55mr1329648pzb.1.1707476325270; 
 Fri, 09 Feb 2024 02:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1661KCqDgzlhvDpghTN3zizwXwRvmjOyeYsSjNhda+xKVAVGhs36CFRDfpug9ENQe7OzBeWujmWbE8zablG40KGgK8T3oDqmOxu3NFK/ChVf5BODZ6HuFpZXwlwMGX31xUPK22APX3H9q3eT4cSuV4yLaisjhpuXQQ/oQlHZRKY=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 06/61] target/riscv: move 'pmu-mask' and 'pmu-num' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:18 +1000
Message-ID: <20240209105813.3590056-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Every property in riscv_cpu_options[] will be migrated to
riscv_cpu_properties[]. This will make their default values init
earlier, allowing cpu_init() functions to overwrite them. We'll also
implement common getters and setters that both accelerators will use,
allowing them to share validations that TCG is doing.

At the same time, some options (namely 'vlen', 'elen' and the cache
blocksizes) need a way of tracking if the user set a value for them.
This is benign for TCG since the cost of always validating these values
are small, but for KVM we need syscalls to read the host values to make
the validations, thus knowing whether the user didn't touch the values
makes a difference.

We'll track user setting for these properties using a hash, like we do
in the TCG driver. All riscv cpu options will update this hash in case
the user sets it. The KVM driver will use this hash to minimize the
amount of syscalls done.

For now, both 'pmu-mask' and 'pmu-num' shouldn't be changed for vendor
CPUs. The existing setter for 'pmu-num' is changed to add this
restriction. New getters and setters are required for 'pmu-mask'

While we're at it, add a 'static' modifier to 'prop_pmu_num' since we're
not exporting it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 91 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1718a213c2..1b11e9098b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -58,6 +58,15 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
 }
 
+/* Hash that stores general user set numeric options */
+static GHashTable *general_user_opts;
+
+static void cpu_option_add_user_setting(const char *optname, uint32_t value)
+{
+    g_hash_table_insert(general_user_opts, (gpointer)optname,
+                        GUINT_TO_POINTER(value));
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -1268,11 +1277,15 @@ static void riscv_cpu_post_init(Object *obj)
 
 static void riscv_cpu_init(Object *obj)
 {
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
 
+    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
+
     /*
      * The timer and performance counters extensions were supported
      * in QEMU before they were added as discrete extensions in the
@@ -1282,6 +1295,9 @@ static void riscv_cpu_init(Object *obj)
      */
     RISCV_CPU(obj)->cfg.ext_zicntr = true;
     RISCV_CPU(obj)->cfg.ext_zihpm = true;
+
+    /* Default values for non-bool cpu properties */
+    cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
 }
 
 typedef struct misa_ext_info {
@@ -1491,26 +1507,46 @@ const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
+                             Error **errp)
+{
+    g_autofree char *cpuname = riscv_cpu_get_name(cpu);
+    error_setg(errp, "CPU '%s' does not allow changing the value of '%s'",
+               cpuname, propname);
+}
+
 static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
-    uint8_t pmu_num;
+    uint8_t pmu_num, curr_pmu_num;
+    uint32_t pmu_mask;
 
     visit_type_uint8(v, name, &pmu_num, errp);
 
+    curr_pmu_num = ctpop32(cpu->cfg.pmu_mask);
+
+    if (pmu_num != curr_pmu_num && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, curr_pmu_num);
+        return;
+    }
+
     if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
         error_setg(errp, "Number of counters exceeds maximum available");
         return;
     }
 
     if (pmu_num == 0) {
-        cpu->cfg.pmu_mask = 0;
+        pmu_mask = 0;
     } else {
-        cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, pmu_num);
+        pmu_mask = MAKE_64BIT_MASK(3, pmu_num);
     }
 
     warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
+    cpu->cfg.pmu_mask = pmu_mask;
+    cpu_option_add_user_setting("pmu-mask", pmu_mask);
 }
 
 static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
@@ -1522,16 +1558,54 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint8(v, name, &pmu_num, errp);
 }
 
-const PropertyInfo prop_pmu_num = {
+static const PropertyInfo prop_pmu_num = {
     .name = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask, MAKE_64BIT_MASK(3, 16)),
-    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
+static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t value;
+    uint8_t pmu_num;
 
+    visit_type_uint32(v, name, &value, errp);
+
+    if (value != cpu->cfg.pmu_mask && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %x\n",
+                          name, cpu->cfg.pmu_mask);
+        return;
+    }
+
+    pmu_num = ctpop32(value);
+
+    if (pmu_num > (RV_MAX_MHPMCOUNTERS - 3)) {
+        error_setg(errp, "Number of counters exceeds maximum available");
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmu_mask = value;
+}
+
+static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t pmu_mask = RISCV_CPU(obj)->cfg.pmu_mask;
+
+    visit_type_uint8(v, name, &pmu_mask, errp);
+}
+
+static const PropertyInfo prop_pmu_mask = {
+    .name = "pmu-mask",
+    .get = prop_pmu_mask_get,
+    .set = prop_pmu_mask_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
 
@@ -1618,6 +1692,9 @@ RISCVCPUProfile *riscv_profiles[] = {
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
+    {.name = "pmu-mask", .info = &prop_pmu_mask},
+    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
-- 
2.43.0


