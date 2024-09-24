Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503AFCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrU-0003nR-U9; Tue, 24 Sep 2024 18:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrT-0003mP-5F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrQ-0001cP-Bp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so5121804b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216296; x=1727821096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vxdm0TSPbNu/fg8w6qlBUaj3+EOLbKQClWKworMoGLA=;
 b=nO6SxZwN+kHXzPKsD9QTufi/XJz5/gLOFuk4QwaPMzd0Q9gQaiJpzMqNUwdIlsZLqw
 3zPx3s18oRtUVjuJpbttvf6fOW14pcA8ZHVcSloLSnZZvC4/HrbFH2KL1EXHU34M9PIZ
 MbJxQWA1C4o14jeU0xFbGbdMog8Tx4PkOKsQERbUVj88Ej3zoG5JyMVQ1Tv76UAEf5fa
 wQZ07/bAUobIRnlytTREwcN+07Z9TEpDg1HU8Z7+Kv0lRurxpRzgs0jhHl2vdto1e/rL
 L1pEPCxoka9tMJPj0qiT3m4KqaeDFZz6aDU7LIUAJ4mD9IK9XZR9Qke+n6uL3j7LIpvh
 OC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216296; x=1727821096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vxdm0TSPbNu/fg8w6qlBUaj3+EOLbKQClWKworMoGLA=;
 b=tC+8m/JSY74U/IUjYVPC26Hmkmu5aGGcARnONhoSd+bqFfc1QAfJdLwzHb325MCwMX
 82xFV6QwUL73q7phdHJM9mVtS47uzt66JgBMOXXZDE8ahQvLGLND53oGPlz6Sxhx7qvE
 m0xu2wieJ5AXpLHpXclr6tuwDazmA0boufOkOZdnSDrs6tAILdFSzng7tMXlsw8ikK2e
 2a4lv9fA1uR/aDquQKYo7Tvo5ijMFU7e+mHEvUMdwivYgwpA7wF68ZEOslMG97ObRl6D
 TIofBYBg0kxbM/KYLPRGpHIPl7pWLZgfWijgo9WshKf/Fkn1KVi/eM/NEWpGicr61M6q
 QMBg==
X-Gm-Message-State: AOJu0YxOsjs8S0pMDQ6SY+04NjA/7jKkwWbt9bGG+n326xx4Y4ewemn+
 22B1iGkLxedH+YikZZ/Ot3evDoAAG64MT18twivR79rZlcgHxqX+WTgskg==
X-Google-Smtp-Source: AGHT+IEaYHncyjBm6cxCZu+vqBCGCveiOZg2Prd1RrmUTTlXmRSbNnRcpnohYjisRNjJVQ0y0UkXmQ==
X-Received: by 2002:a05:6a21:8cc7:b0:1d3:dd6:45 with SMTP id
 adf61e73a8af0-1d4c6f30de0mr886389637.10.1727216296456; 
 Tue, 24 Sep 2024 15:18:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 05/47] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice
 in implied rule
Date: Wed, 25 Sep 2024 08:17:06 +1000
Message-ID: <20240924221751.2688389-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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
2.46.1


