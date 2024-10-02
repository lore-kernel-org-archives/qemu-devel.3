Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15CECF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHA-00061x-SD; Wed, 02 Oct 2024 01:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGu-0005bE-3E
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGm-0004r0-AR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b833f9b35so26746125ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848274; x=1728453074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH0zhu0FnJOH36Tztins+VRQFpDAQeoIDsJfE3P9dRM=;
 b=I1mqUJiNEIXiuXGrBdybRsaueRQxA4CqLzAJcUyZVFlwFWCOmxDCN7P0s9fEnstjX0
 aOXTqzipyet0tV47iBplnLNFks5cbZ6TPlviB+RALmLuo1exsVr/vNxyRAvVl66rwTfw
 oYesCHenTOJPrRJbExBzdFAGZzR4DgCO1IdA5NsviwPxlDh46gYt/kqIaOP8qWsfAGRe
 DhEAswCWaD96lmOtKyph5Cfo4UP7AUgjYVwTV5ro4klNUjezZUrA5JNf5LOunRcArce1
 sT1r26/kpQMe8Z2ZrtUylYcjalkll8GBYqJ7+eqoqnPyhSb4xRwgF/IQO0zFr18BieXg
 uhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848274; x=1728453074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NH0zhu0FnJOH36Tztins+VRQFpDAQeoIDsJfE3P9dRM=;
 b=BvY+TlTebn5dGc9G6rz/XXtIg9tCih8KHejxsp5kUZm3N734ZY5YD0aofwiMMZsiU/
 klVXdkHRiSUAZn6IcbZ3DjbHRluI0MGDaL6Av/Xz9kzBW35BmFYmVph1tRLQQGgkxnSK
 bq41arnvmmofh/1W8nvqt2wLIQJxmQGOM0Z+eodaOjGLfzw0VIUvEnChtDCGeTysv1Oz
 bT+dlI3ymybAlhpSNYnYVYl1TjE09NhRjK1eXmUmLkQvFW4ThbGbddEt+l5ekOq9kHpH
 adtu01miSJ78xy5l2kBCRJB2aLZFJz6Le/BxkRipzBgaF7h6s/urVZVq+aBNHlQfMbmC
 abWQ==
X-Gm-Message-State: AOJu0YzyFOZertX0zc2doJ/U82aDqnkZ5mw+eaq8DIeP3Xh85IeXChcZ
 RqxW5mXQFVdjMs5WuJMp/oeWYz/ZMmvVaGKVILj2W1vpFk6EWRJuFdmVIpzp
X-Google-Smtp-Source: AGHT+IEG2n76BWsCj04veYLdlwDCP1pf3lwmWMPxpflUnJiebQGFGmaJyRDcJc/MsQoyYHvmQbvUIA==
X-Received: by 2002:a17:902:e5c8:b0:20b:a10c:9bdf with SMTP id
 d9443c01a7336-20bc59fdcffmr31488965ad.32.1727848274347; 
 Tue, 01 Oct 2024 22:51:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 05/35] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice
 in implied rule
Date: Wed,  2 Oct 2024 15:50:18 +1000
Message-ID: <20241002055048.556083-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

Gitlab issue [1] reports a misleading error when trying to run a 'rv64'
cpu with 'zfinx' and without 'f':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false
qemu-system-riscv64: Zfinx cannot be supported together with F extension

The user explicitly disabled F and the error message mentions a conflict
with Zfinx and F.

The problem isn't the error reporting, but the logic used when applying
the implied ZFA rule that enables RVF unconditionally, without honoring
user choice (i.e. keep F disabled).

Change cpu_enable_implied_rule() to check if the user deliberately
disabled a MISA bit. In this case we shouldn't either re-enable the bit
nor apply any implied rules related to it.

After this change the error message now shows:

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false
qemu-system-riscv64: Zfa extension requires F extension

Disabling 'zfa':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false,zfa=false
qemu-system-riscv64: D extension requires F extension

And finally after disabling 'd':

$ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=true,f=false,zfa=false,d=false
(OpenSBI boots ...)

[1] https://gitlab.com/qemu-project/qemu/-/issues/2486

Cc: Frank Chang <frank.chang@sifive.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2486
Fixes: 047da861f9 ("target/riscv: Introduce extension implied rule helpers")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240824173338.316666-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..dea8ab7a43 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -778,11 +778,18 @@ static void cpu_enable_implied_rule(RISCVCPU *cpu,
     if (!enabled) {
         /* Enable the implied MISAs. */
         if (rule->implied_misa_exts) {
-            riscv_cpu_set_misa_ext(env,
-                                   env->misa_ext | rule->implied_misa_exts);
-
             for (i = 0; misa_bits[i] != 0; i++) {
                 if (rule->implied_misa_exts & misa_bits[i]) {
+                    /*
+                     * If the user disabled the misa_bit do not re-enable it
+                     * and do not apply any implied rules related to it.
+                     */
+                    if (cpu_misa_ext_is_user_set(misa_bits[i]) &&
+                        !(env->misa_ext & misa_bits[i])) {
+                        continue;
+                    }
+
+                    riscv_cpu_set_misa_ext(env, env->misa_ext | misa_bits[i]);
                     ir = g_hash_table_lookup(misa_ext_implied_rules,
                                              GUINT_TO_POINTER(misa_bits[i]));
 
-- 
2.46.2


