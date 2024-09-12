Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9724EEE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPQ-0000T0-46; Thu, 12 Sep 2024 01:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPL-0000Ek-7R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPJ-0002zD-Ag
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:18 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-718e6299191so291785b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119016; x=1726723816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FihobyF5TVd7Cmn/sPRvZcTI6XyLQLapMPzEBDPYEuQ=;
 b=gbkb4WA5Tie7WYood07Ei0ARROrLnkLRjvzA5rXrT5MykUGqkBunWDszk2Vtrs8mEU
 GqRAja34EoEUG/rr9+uAGyd1pAKyrogLQAqHT7ZZ+sBkdQHoqiYP37XMJE7C10IO8gUk
 y6kKb8deRuPPdC8IX+qP6OjrX4e2onW9ab2bdGIr2KBs8FzPmDJpMO61L3xMgvh6vcr0
 aG30LFKuGHdNDSksvNpTZdpAksBH4pY3Q4nrXk8To6FOrbCFRosMu0yhnI5u9Qj784T1
 NtwEPxYpBjfX31yEPyags2XLHQguJi4ZL8jZWOJz8xYDjBwdgsVi1O8Bqc8etMK5pJ62
 bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119016; x=1726723816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FihobyF5TVd7Cmn/sPRvZcTI6XyLQLapMPzEBDPYEuQ=;
 b=uPBfB7opgibaEwGMEagaQsVMPsPOBnFhSFIi28WGrV66279vKH1RlkE5RcjYfhDEZL
 uPAg6fNQg1vI56eocxRUx3hmsQpsLW2bip5wmXmXwKFXapfFWbBjrCMFacG1BjgSJNJU
 Mlx6id7w/EPsuT8K463PRmCaZCI7OrDeBPle6MoSGIS3sRoYObUYJp7HBaqzZgNdb9cO
 4IOL1pAZCG9lLBFfLP6NirnKaZzUsw/t2nwGFkz0ziGPkvuCzX+UlQwUcGqlHu72JXxs
 xOMiiOaYXgm/QC/LhvqdCMe8bulrj6iXd3rUV6YwIYNCWAYgVUGmuBgu8zDfQzrstolI
 IJdw==
X-Gm-Message-State: AOJu0YxVdrNgg8iYHkMCAf7oZJ3NuidQdCoslTkAm3h2JIGuoVsEm9Dq
 QDXTG+7Pbe+IxevubnSSLpGEYREOEzidHmSzQBcH7Iv4CcDZmQ1uo8G4Nw==
X-Google-Smtp-Source: AGHT+IFsd3yQPAcWdB7imJ9tUE7I7V3j+NW/8K/QfFRqs+t9/iYFG/pvhVR+AHy9YaBaLSDnI6IKPg==
X-Received: by 2002:a05:6a00:1952:b0:714:3acb:9d4b with SMTP id
 d2e1a72fcca58-719261cb457mr2327387b3a.18.1726119015390; 
 Wed, 11 Sep 2024 22:30:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/47] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in
 implied rule
Date: Thu, 12 Sep 2024 15:29:10 +1000
Message-ID: <20240912052953.2552501-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
2.46.0


