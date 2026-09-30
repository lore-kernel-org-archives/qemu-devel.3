Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1427BCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBovI-0001MH-5X; Wed, 30 Sep 2026 03:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBovG-0001Ht-VD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:15 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBovF-00045E-9L
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:40:14 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a15703so4810655eec.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790754012; x=1791358812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZWtYZozaGxQ3WyjiR/l/7DZHyDwU7S1l8IMnTPOhVhU=;
 b=ZlA5tjfzKzYiHZB+xAVkVNfqbAr/+nvPp5L4QFa/TueO9FpU7L1S2UQagAVVZlhbme
 IM5Xl5sT1/FGB8cj9malYZCzVyVfVzE67ml746l42D2o9LKM83k0ykqGRdPKH3827o44
 EG/qxu3Ti1EzIJ6qDtb2OX6bWEa2KAMpqCrVzPGN5whUfSr+2ntfu3pJzh+606cb2Lnk
 Key10Ms5FlrjLbv00mw60cD/NEiaZuhfS+HEAd/tU5twhuN0OwTHH+Uqd0eZylRjL6ab
 OAmkjo3mOeVE6t/gtsz7BspZSyTPALzf7FdNcqY4dyyd0ezNZVWoTRHnz939RXHoEooG
 hoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754012; x=1791358812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZWtYZozaGxQ3WyjiR/l/7DZHyDwU7S1l8IMnTPOhVhU=;
 b=isIB9zLwtaoewkhtyYQq0BQQ+uIXMdtULgNouW2KU/rJNtHyoSbOHWi8XVj378i8Iq
 VmZf8DaEpa8lqyn0cqvhD9N4io5Cl10UVRcShIPiNAVzjqNEWOqiLWIwai0fERNqlY2J
 vF9k3Pqu9QNxmQzL155zmZEVHVAdtyUn+CoYrZ+7Wdq1tIhlJCR0IeDuLMLRFBGF5ETJ
 PeguqvcSR91HAGvXi7+/C7lCNumg9hpV++9bUC9GxSxDqemT4h204ViYbnUNeHZoJ76i
 bj3eBLMYZgQ+ZeUTcsnx0B1Co01wiFiQnfcA+Aynlb2zO3dAB79kUNC5XydVEDpPLL2y
 w6Ow==
X-Gm-Message-State: AFq9FYI/LhqiDlAhZL1+oMdvhZP4aLCWpdwzZMZwJD+hwazPyFzUn7WI
 JktdA/yBE6D6oGcA8v5PSMbBrPJ1DUoqhsyJ1sXvX+CDbe1w2iUpjoIPs/BJBMmM
X-Gm-Gg: AYBFou0UG7TZLbtZqy4VPzcun+ZVtN6gh1uEXjc3LSIqVwOz3QePC8trAM34Dwkk3/y
 j31xWjf/x7ZlZqC0mPavT7UQvzn+4piRM4bhQf4T6qVMoJvDHZpqG4Za4TAWqgwCekETUL02Nc9
 fUpHjFrrddoKgWWPHRNrff5Al8JypEJvdumzLJ7Gv5Mag6fmnvmPZw9Av09sAQaGl7Y40sOItHL
 W4l3mPL08LQ05M5WEBhd9xuel/f0EOKwGNAn9sMjz3u/HOCJaoNNkoDw23BTYOP8ewD2HQyHIdB
 hheQMJ4kc0D3nTOWFaKycEREFoWRT/oD+Y03CXrqBixizZ3LTDqkTCFUvbrI3ATRh6pEGY+Z0pC
 lbWjeYK+8DNCvD/pw3cC3OddUg8FmruDuaWuwyF8MJOOgtsu5Ii6Mfmqt36p+JTX43h6LrP81pj
 0chrcqvChcppU51pLhtt/SApDjtF/Qo2sbtzwzTMKouMYGT5LraK/EQdmiM0Nps74nlNmXlcvDM
 xHk/DDkUf1zTn+kpQ==
X-Received: by 2002:a05:7300:cd46:b0:33b:e77f:8a3c with SMTP id
 5a478bee46e88-34cdcfae6a7mr1325792eec.33.1790754011728; 
 Wed, 30 Sep 2026 00:40:11 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5b4349bsm1825773eec.25.2026.09.30.00.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:40:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 5/6] target/i386: prefix exception helper implementations
Date: Wed, 30 Sep 2026 15:39:32 +0800
Message-ID: <20260930073935.712-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260930073935.712-1-luoyonggang@gmail.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
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

Rename the i386 exception helper implementations to
i386_raise_exception* to avoid collisions with common helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/i386/tcg/excp_helper.c | 17 +++++++-------
 target/i386/tcg/helper-tcg.h  | 42 +++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 1eaa602c91..0576d64390 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -34,7 +34,7 @@ G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
 
 G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
 {
-    raise_exception(env, exception_index);
+    i386_raise_exception(env, exception_index);
 }
 
 /*
@@ -120,25 +120,26 @@ G_NORETURN void raise_interrupt(CPUX86State *env, int intno, int next_eip_addend
     raise_interrupt2(env, intno, 1, 0, next_eip_addend, 0);
 }
 
-G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
-                                    int error_code)
+G_NORETURN void i386_raise_exception_err(CPUX86State *env, int exception_index,
+                                         int error_code)
 {
     raise_interrupt2(env, exception_index, 0, error_code, 0, 0);
 }
 
-G_NORETURN void raise_exception_err_ra(CPUX86State *env, int exception_index,
-                                       int error_code, uintptr_t retaddr)
+G_NORETURN void i386_raise_exception_err_ra(CPUX86State *env,
+                                            int exception_index,
+                                            int error_code, uintptr_t retaddr)
 {
     raise_interrupt2(env, exception_index, 0, error_code, 0, retaddr);
 }
 
-G_NORETURN void raise_exception(CPUX86State *env, int exception_index)
+G_NORETURN void i386_raise_exception(CPUX86State *env, int exception_index)
 {
     raise_interrupt2(env, exception_index, 0, 0, 0, 0);
 }
 
-G_NORETURN void raise_exception_ra(CPUX86State *env, int exception_index,
-                                   uintptr_t retaddr)
+G_NORETURN void i386_raise_exception_ra(CPUX86State *env, int exception_index,
+                                        uintptr_t retaddr)
 {
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d..430e49efe0 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -60,13 +60,41 @@ void x86_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
 /* excp_helper.c */
-G_NORETURN void raise_exception(CPUX86State *env, int exception_index);
-G_NORETURN void raise_exception_ra(CPUX86State *env, int exception_index,
-                                   uintptr_t retaddr);
-G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
-                                    int error_code);
-G_NORETURN void raise_exception_err_ra(CPUX86State *env, int exception_index,
-                                       int error_code, uintptr_t retaddr);
+G_NORETURN void i386_raise_exception(CPUX86State *env, int exception_index);
+G_NORETURN void i386_raise_exception_ra(CPUX86State *env, int exception_index,
+                                        uintptr_t retaddr);
+G_NORETURN void i386_raise_exception_err(CPUX86State *env, int exception_index,
+                                         int error_code);
+G_NORETURN void i386_raise_exception_err_ra(CPUX86State *env,
+                                            int exception_index,
+                                            int error_code, uintptr_t retaddr);
+
+static inline G_NORETURN
+void raise_exception(CPUX86State *env, int exception_index)
+{
+    i386_raise_exception(env, exception_index);
+}
+
+static inline G_NORETURN
+void raise_exception_ra(CPUX86State *env, int exception_index,
+                        uintptr_t retaddr)
+{
+    i386_raise_exception_ra(env, exception_index, retaddr);
+}
+
+static inline G_NORETURN
+void raise_exception_err(CPUX86State *env, int exception_index,
+                         int error_code)
+{
+    i386_raise_exception_err(env, exception_index, error_code);
+}
+
+static inline G_NORETURN
+void raise_exception_err_ra(CPUX86State *env, int exception_index,
+                            int error_code, uintptr_t retaddr)
+{
+    i386_raise_exception_err_ra(env, exception_index, error_code, retaddr);
+}
 G_NORETURN void raise_interrupt(CPUX86State *nenv, int intno, int next_eip_addend);
 G_NORETURN void handle_unaligned_access(CPUX86State *env, vaddr vaddr,
                                         MMUAccessType access_type,
-- 
2.55.0.windows.3


