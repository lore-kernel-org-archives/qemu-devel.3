Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5708C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOb5-0000Pc-45; Fri, 09 Feb 2024 05:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOb3-0000PB-Cf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:05 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOb1-0000FD-Md
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:05 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e08c16715fso204330b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476342; x=1708081142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJLjFlZbUMSKj6lGlsdgxdLiYvNgAMDnfm5/5N+UROw=;
 b=j6i3kqUFysGdE1pELke/9vgrjRrXxsDG5ne76y92b+573r7t9rFqBKvoiUlA4sYHsf
 dPhquewJbpPGYa0jKEzflPXQiJx9r62fnWifoDUJQCRixEFrt1vT5f28lEA4ZHm7DcS3
 S46HGrukAgZ8MCnMi4afgMaMBNZEGygN+zht6ixfB1/8S0e3GJCaXucOC219Tw3U6lj2
 jsXmn44MtkBjSNMsq/R/MqlCm51vtIMHXxJVPqKN0awDWpVyHxosBGmSX9UeRAJKSt4A
 2e4u1yxiJfqvuxWWUzNePeE41jb58q5CvCSxW2KM+I9b7MLR1cV6ufze8mAah+G3FIby
 CMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476342; x=1708081142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJLjFlZbUMSKj6lGlsdgxdLiYvNgAMDnfm5/5N+UROw=;
 b=IrAkWZVCGbZKvnwGWtPDv+xIPeaz1KRayTEIlnbNIGrWEA6pUAHxtsVjGOOOW/vwHl
 oZqajn0w4GdvWqPtn/+4zXpglt0OPpJdhcSoPsuEhqc5GToVdVNQdfjTg2HpDy5k7ICn
 am2zBPYnlaBWd3W0RdBkfwFsWIoCKzXfNR+z08CTrEfqkPFHwA2gbD6kqh2rSu41Zjhh
 KHoa8qA8KHTjzWiGsDzjSLhtZvPa0Fqrxp1y71Sss4+h2z3Zu6tJ5AFQf6OWXk+XTdhY
 cxgw04gp5xe/gbvYgmsI3IPC+Sm28OFLn0+BObPvu2hYetK+DVefsaFYHBck5SWn0lZR
 POuw==
X-Gm-Message-State: AOJu0YwQpv0imyke3MsTwVefeqx7bMtCNLYE3RtBEw4c7vzZxW/ey9KQ
 hLjQ1R+1dyHQ0lIVPXe7yxgGgMk1EtloW8L6eV/b3i3idwtqEELGVfRFmpsT+GVhRQ==
X-Google-Smtp-Source: AGHT+IEz2Fapw3wbdKVZ6+RmSgQF6LDumzLVFJ4itVRKbZ21KdEBPFWQPR6OGDd3bVQL/iY5nGBKFA==
X-Received: by 2002:a05:6a00:2e8c:b0:6e0:708c:165a with SMTP id
 fd12-20020a056a002e8c00b006e0708c165amr1265550pfb.5.1707476341881; 
 Fri, 09 Feb 2024 02:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdWk3NJ9bTH1I+iGmnSZzi6myAbGFFw/UZTzOYdEcIabCc7v7OlcIGNryUUP95y2/O+Tgtjp7g1ASv8w8jYGboizwBcgs8JDCFXZyGeXkGMpqcH3AtKHLwF2kFfCwKRl5ktomgIy/CaV0S3iok53NqVD6dt18+D8LtWpQMF+jkmVU=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 11/61] target/riscv: move 'vlen' to riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:23 +1000
Message-ID: <20240209105813.3590056-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

Turning 'vlen' into a class property will allow its default value to be
overwritten by cpu_init() later on, solving the issue we have now where
CPU specific settings are getting overwritten by the default.

Common validation bits are moved from riscv_cpu_validate_v() to
prop_vlen_set() to be shared with KVM.

And, as done with every option we migrated to riscv_cpu_properties[],
vendor CPUs can't have their 'vlen' value changed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 45 +++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  5 -----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1a7a2f1d64..140bb09816 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -29,6 +29,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
 #include "sysemu/kvm.h"
@@ -1317,6 +1318,7 @@ static void riscv_cpu_init(Object *obj)
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
+    cpu->cfg.vlen = 128;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1788,8 +1790,47 @@ static const PropertyInfo prop_vext_spec = {
     .set = prop_vext_spec_set,
 };
 
+static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension VLEN must be power of 2");
+        return;
+    }
+
+    if (value != cpu->cfg.vlen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.vlen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.vlen = value;
+}
+
+static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.vlen;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_vlen = {
+    .name = "vlen",
+    .get = prop_vlen_get,
+    .set = prop_vlen_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
@@ -1878,6 +1919,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
 
+    {.name = "vlen", .info = &prop_vlen},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9820612f36..eb182ca876 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -298,11 +298,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
-    if (!is_power_of_2(cfg->vlen)) {
-        error_setg(errp, "Vector extension VLEN must be power of 2");
-        return;
-    }
-
     if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
-- 
2.43.0


