Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95992C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObE-0000nj-AU; Fri, 09 Feb 2024 05:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObC-0000lI-Jk
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:14 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObA-0000Fs-V1
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:14 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e2b5f48763so413578a34.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476351; x=1708081151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/ZZkBQH/7y9CpDxczlh/aHj0hgFtDWH4iSxB0x/2jQ=;
 b=GGg2c9tc+Dul9i03lBiyzH4mJKXG/vWfNSOPtRSoj21G3ThHt5EIJ+t2wr88hFOSvr
 VTyWN6xjOCTy1RzWTcZ9dWCA+qSDlbClxLxWH7F6DDA0aXSlpKl37GuanR2Hf8OodP5B
 AcQiBj9yrCCoxRvmwCQAfAQ1itV5xtu8mhMeHjsD1d/p8uDpOnSaWMdHlX2rO7rXP48O
 PUXgkRwedz9xTFv4H9W12PL+Sew3rW5+2D3bpE2nBaQzVbRGpX00Vbslp3CC/dXBj3WF
 Y2XI5giZOs8/Q4XAtvPmaNYtpPqb2993Kh9JFWV/4U7T+zblYOp0OAU6iWMPCRJR7pzl
 4Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476351; x=1708081151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/ZZkBQH/7y9CpDxczlh/aHj0hgFtDWH4iSxB0x/2jQ=;
 b=gD0OwRGhNQBAt08SqAr2efF5rJWHqUbdVzhxVuUlrirowaJDKLSVceShs6Cu8nSpwF
 dzBgRlrPqSDPsFtBgEZqBZxQGbQqJF9KEFdUBLaj5jX0f1TsRA0fHC1k14GVBnj0OCv+
 X6m9dfqMuSsufEFDo4sGFv5mpFpdaca+RiWGDxCAo6/j9tzm+JcF8ykAPEhkImhCdn48
 eHkiGV59ee3VQdbNNCtmcngWOmBM0xwFzW+SA+jwR8nUYB5WSvUhllPihRry5C01Oqj8
 3IOSupVMosUZ084pG8CI99FHWeHWIAecQ8voSYkjkctOq4FEKtGbBWbbQOTnyN1zweJX
 VybA==
X-Gm-Message-State: AOJu0YwaN30E3/CmgM1IlfFJ83P7p//q1QS8mEfbnw4zqYqd/5Lucyoa
 mKE6i8koWcgj6nAY3Rl6/3Zger3wqHXQpFLHVRYN6YzZsly//EA/pWsvZvCe02G5cQ==
X-Google-Smtp-Source: AGHT+IESMzxfedsU5731WA1/pYC6sMw7TpkjMMg+J2QPZj66E01rgEHQedN2N00deLuYeCYCNNVi6A==
X-Received: by 2002:a9d:74cf:0:b0:6e1:140d:2747 with SMTP id
 a15-20020a9d74cf000000b006e1140d2747mr1107376otl.21.1707476351618; 
 Fri, 09 Feb 2024 02:59:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXFl+bbC4KzjY7OEXV3rfJ0cx1BFjZ+TURrstbmf8g0vOIcaPSqJ+NfTR+bJYFsAwe5ENJbOtYaZeClmL89QbwkFgjtlqbFXZvrlNP2CHl0LIyPj/b4o7EemHlBVd4f+/sXf4oqLwS0cNt9XL4of+MEy5XuZ3Q7Jvv8geVzgiQcZ0o=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 14/61] target/riscv: move 'cbom_blocksize' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:26 +1000
Message-ID: <20240209105813.3590056-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x331.google.com
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

After adding a KVM finalize() implementation, turn cbom_blocksize into a
class property. Follow the same design we used with 'vlen' and 'elen'.

The duplicated 'cbom_blocksize' KVM property can be removed from
kvm_riscv_add_cpu_user_properties().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  4 ----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3703efe702..3b3098ee76 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1326,6 +1326,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlen = 128;
     cpu->cfg.elen = 64;
+    cpu->cfg.cbom_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1877,8 +1878,42 @@ static const PropertyInfo prop_elen = {
     .set = prop_elen_set,
 };
 
+static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cbom_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cbom_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cbom_blocksize = value;
+}
+
+static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cbom_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cbom_blksize = {
+    .name = "cbom_blocksize",
+    .get = prop_cbom_blksize_get,
+    .set = prop_cbom_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
@@ -1967,6 +2002,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "vlen", .info = &prop_vlen},
     {.name = "elen", .info = &prop_elen},
 
+    {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index dc0466df69..094bc5f47c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -493,10 +493,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    object_property_add(cpu_obj, "cbom_blocksize", "uint16",
-                        NULL, kvm_cpu_set_cbomz_blksize,
-                        NULL, &kvm_cbom_blocksize);
-
     object_property_add(cpu_obj, "cboz_blocksize", "uint16",
                         NULL, kvm_cpu_set_cbomz_blksize,
                         NULL, &kvm_cboz_blocksize);
-- 
2.43.0


