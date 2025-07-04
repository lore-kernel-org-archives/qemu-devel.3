Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48067C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLx-0002Dx-4c; Fri, 04 Jul 2025 07:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLp-0001yt-0I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLh-0002oA-9a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234b9dfb842so8258725ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627575; x=1752232375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpUo3t0CFtoL7yIcswWKm5ZEpTzjIl6c03PRx99mmbY=;
 b=bj3cz6bAOerjfNvRz2welAcMtRghPjFBIx6Ppg/TztWWOR0LxRK1npTp4RKXKdMlRr
 REXNfMxtLmg91vgTvERKZ6rIhxG+RU+kSWQmJRHVNu5JN+z9emvMrlz70QdZG+k7dbcl
 tnyes2d58oEhBmoLRdgSypkP2htHQqHhXhm2/IxSQH8MoPqQg/tnKaAzbjfjs0k10zWf
 jaUyQkpFVLk/bCn/0CGtXURe2xETTPG3YaunFdu86MBftMdT93p5ce6lfkD26ROp4uGT
 xw1Oup8mKQzdWCaiwSSe21JINZVG0Z+lrvMckkjNqPw/nQM0j9iIL/aGADD0F0CPWFrt
 6Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627575; x=1752232375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpUo3t0CFtoL7yIcswWKm5ZEpTzjIl6c03PRx99mmbY=;
 b=wDIZSnn88K8eHNeNY4cj6rmJUQlPGu0ZE8fV4aI/WQlTvI4GSc1NOzw+A0NMl+9V6g
 WwFcXSkMwZ+5QgSkh59j+g3kCK32J2opLi7bvyM0sBROHV9OFoSeJd3aHGlq2dE1vN1G
 xRUBFM0+I/V8o+HDibLxNqpC90ORG0c3jiIQDgSar6W78XIS5cwTJmWTrcdKrTBxP6+D
 8/wrYqMIuOdJw/huZu71k2HPtvR9hsmQ/ZJmIgq6fzKTt1hzewiDVOfh5gGWwLPBEo0r
 8lleIuqfUHRsGvcLLLbcSNnYpAR3ivpwaQjYGJT+FLqnZxCIRvBJ0MopBZYT1NgEGt17
 SjQQ==
X-Gm-Message-State: AOJu0YyKpAOJCIO7pkM7Y0LpzGVvK7efgEmxp+3uDXG1Ga6fRs+YBuxa
 B6clDgibn8MALoVTejqrv1Kiz35RpB2tdHV7LH7L6p7jNSgzHYZHeRuuxhatCw==
X-Gm-Gg: ASbGncusGMNNsBsmRTcIyVaeHNR0qbvm/DYL5WMZrjzcXGotLezm/bePl9P+YgSx2jz
 pXQ/nX5f7/5mInDrTRuFC/kk6zTN7h3BI1t5WO/+fU7KXGmxb+IEB3Nfo3koglX2obgC8B6wioF
 WIhoePcSoWkSnJ3oGk9WXhXeUvVoismH+CQ1AcCzuoFN26zGYop5p57GekSpBfP0aKqXhsap0a/
 8pl/fGjL7ZNQfZELeRYrXtbc4nYLp9AGDkB0OEpDq6+IgmUXioC/3sJ1JA0a5glsUMF8USTLml4
 8gsiYYijRYEd5nLEah31T3rOk+ga8ZMWTYTPVTIm/evP+qicdZJlVhk2towim+bVHm8bYyDGI+z
 Ks8oXcdNR+kgKhUoUknYDAjvbsPA5izey/f8a9zJHS70cJpzE1IODDucd/Vi3CaUTJ/8=
X-Google-Smtp-Source: AGHT+IHihWIRVLa/yMlPl4TcNHVQosbhxF34co1DvF4wqCQvWPpPVi1Eqy84TB5BePegTqb1vxhQWA==
X-Received: by 2002:a17:902:daca:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-23c8747eddcmr35525825ad.21.1751627575062; 
 Fri, 04 Jul 2025 04:12:55 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/40] target/riscv: add profile->present flag
Date: Fri,  4 Jul 2025 21:11:35 +1000
Message-ID: <20250704111207.591994-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Björn reported in [1] a case where a rv64 CPU is going through the
profile code path to enable satp mode. In this case,the amount of
extensions on top of the rv64 CPU made it compliant with the RVA22S64
profile during the validation of CPU 0. When the subsequent CPUs were
initialized the static profile object has the 'enable' flag set,
enabling the profile code path for those CPUs.

This happens because we are initializing and realizing each CPU before
going to the next, i.e. init and realize CPU0, then init and realize
CPU1 and so on. If we change any persistent state during the validation
of CPU N it will interfere with the init/realization of CPU N+1.

We're using the 'enabled' profile flag to do two distinct things: inform
cpu_init() that we want profile extensions to be enabled, and telling
QMP that a profile is currently enabled in the CPU. We want to be
flexible enough to recognize profile support for all CPUs that has the
extension prerequisites, but we do not want to force the profile code
path if a profile wasn't set too.

Add a new 'present' flag for profiles that will coexist with the 'enabled'
flag. Enabling a profile means "we want to switch on all its mandatory
extensions". A profile is 'present' if we asserted during validation
that the CPU has the needed prerequisites.

This means that the case reported by Björn now results in
RVA22S64.enabled=false and RVA22S64.present=true. QMP will recognize it
as a RVA22 compliant CPU and we won't force the CPU into the profile
path.

[1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.belong.to.us/

Reported-by: Björn Töpel <bjorn@kernel.org>
Fixes: 2af005d610 ("target/riscv/tcg: validate profiles during finalize")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Message-ID: <20250528184407.1451983-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            | 15 +++++++++++++++
 target/riscv/riscv-qmp-cmds.c |  2 +-
 target/riscv/tcg/tcg-cpu.c    | 11 +++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..2a6793e022 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,7 +82,22 @@ typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *s_parent;
     const char *name;
     uint32_t misa_ext;
+    /*
+     * The profile is enabled/disabled via command line or
+     * via cpu_init(). Enabling a profile will add all its
+     * mandatory extensions in the CPU during init().
+     */
     bool enabled;
+    /*
+     * The profile is present in the CPU, i.e. the current set of
+     * CPU extensions complies with it. A profile can be enabled
+     * and not present (e.g. the user disabled a mandatory extension)
+     * and the other way around (e.g. all mandatory extensions are
+     * present in a non-profile CPU).
+     *
+     * QMP uses this flag.
+     */
+    bool present;
     bool user_set;
     int priv_spec;
     int satp_mode;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8ba8aa0d5f..8a1856c50e 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -121,7 +121,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
 
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
         profile = riscv_profiles[i];
-        value = QOBJECT(qbool_from_bool(profile->enabled));
+        value = QOBJECT(qbool_from_bool(profile->present));
 
         qdict_put_obj(qdict_out, profile->name, value);
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e10e03a577..c5e260e360 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -867,16 +867,11 @@ static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
                                            RISCVCPUProfile *profile,
                                            RISCVCPUProfile *parent)
 {
-    const char *parent_name;
-    bool parent_enabled;
-
-    if (!profile->enabled || !parent) {
+    if (!profile->present || !parent) {
         return;
     }
 
-    parent_name = parent->name;
-    parent_enabled = object_property_get_bool(OBJECT(cpu), parent_name, NULL);
-    profile->enabled = parent_enabled;
+    profile->present = parent->present;
 }
 
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
@@ -937,7 +932,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
         }
     }
 
-    profile->enabled = profile_impl;
+    profile->present = profile_impl;
 
     riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
     riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
-- 
2.50.0


