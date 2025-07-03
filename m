Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36664C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHeJ-0005di-Vi; Thu, 03 Jul 2025 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcl-0004KD-Mm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcg-0001RL-JO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so53375155e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540216; x=1752145016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig7RKTLH9UJlDQU329juJSY2hDH3DZ7PgtnDQ6yaDA4=;
 b=EE4d2T+Le6tGWjgcjCqYx/L5bjqvuHCkMTvWT7iR7zsLvFJSonGeKft4naIjpQVFmQ
 lRmwduFk5aNKTYWaj6GgxXK/lx6Ye8rOSCCSDHyyE/utWCY+Y23n9qGuWpbQ5fwM4xXi
 A/gMq1+5eZqyBfch0rEFrcLyIiMkvez3WDRJvzpwUHlCZXIBXMskmm2Hhvx3Z+KE6MEr
 4fWSzO7Ba+vvJy82fWg9K0cLo0chqGBpC18+36pGbrkr2s7x++3Xv17rau2Vp6rKe/Ze
 lRMlUXG69ulSiO5BIxbv5Nh4R17j0kVyCJB9m15VlAlabudkcWvjOn8P2Mw/ds46tKAZ
 eiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540216; x=1752145016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ig7RKTLH9UJlDQU329juJSY2hDH3DZ7PgtnDQ6yaDA4=;
 b=v5ffh6+LVR6JfJyuw53Gf+qlPZsMgJMdwhKRhOuFui6yA/8Kdc6Q6qIs4cN4o3pZqE
 QvzA7SHV3jCOfGC/FUMI4gMHcgo5hcuSgbTkYC/uzUPlOMzmDXh2nYyvpx5gMUBQpPVU
 fhptpvWXN9fq+G/YP+Vfq+JWu7pYjN+jY4WPe47svGKfQSH5hfBWeetlaRWjE8UGCmFN
 T17JFrdRNM+UlQ0QNfHT9zSGVHcSl9FOUMKCa9MvK8Jp/Oy3fWsxi2Xk3BxFVRpvqfNN
 aaDrndySQkDdCpC0lzeFUBwZ+oTo/0AcKseB8gThHWvqIz5IOa6awleQVQrFoLTk1aW8
 vWVg==
X-Gm-Message-State: AOJu0YxjAO1eGTFNk676J1t1NiwZaHmMa9GaNHnD5oJQCZf9TJgjHu6n
 bhxVG18oYmFvX1XzUkpQArnf2pEhva8nAYEHItASBvfsLs56EwuXrYMoHK2J7VJodANCvUT5nUl
 +cEd9grU=
X-Gm-Gg: ASbGncscjl633PnxKq+A+5mVwImLCw/bLWSfem1CRJCCZ6qX8jER6gxfHMej7IxaGXu
 YBujaVPlAuZvsPTWDeVm033JVQK1ig7LQPf24NsMNRw6fXgK9Q2I0wDScJ+euZWmuCeMFPjUuKW
 nx5juMZYziXA3r1uTZz824hhw7ptLuTd/ehnn4zKv9YSuuZjQiWUjQvbLwNy5Nkfg6miYZRAphs
 BP2kCyzXiN/T6QYpNG4wLGIVY6BlAyCnle6H7pB1o3+rNQZuk22UvdbVDIw804J4QQBv+V8ckKs
 +lx679sV3O0kf/ZpUl3b6PAxwfApvqJx2o1/B1L7ybfADigZNxe2mpceyUxjDQECQ2VxykmrGdK
 dQvbB3/48eG0=
X-Google-Smtp-Source: AGHT+IHaj9RtQDiEeVRArxp+XRt5ldxps30/rxJJslo7khH4Q15jtcYUkXC+vICQ0L7oQrotPITPPA==
X-Received: by 2002:a05:6000:4105:b0:3a8:30b8:cb93 with SMTP id
 ffacd0b85a97d-3b32e8f61dcmr1884068f8f.32.1751540216212; 
 Thu, 03 Jul 2025 03:56:56 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59aaasm17990675f8f.83.2025.07.03.03.56.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 14/69] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Date: Thu,  3 Jul 2025 12:54:40 +0200
Message-ID: <20250703105540.67664-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/kvm/kvm-all.c  | 4 ++--
 system/memory.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index b9a9b3593d8..f327a71282c 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -46,7 +46,7 @@ typedef struct AccelClass {
 
     /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
-    bool (*has_memory)(MachineState *ms, AddressSpace *as,
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72fba12d9fa..f641de34646 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3789,10 +3789,10 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
     return r;
 }
 
-static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
+static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
                                  hwaddr start_addr, hwaddr size)
 {
-    KVMState *kvm = KVM_STATE(ms->accelerator);
+    KVMState *kvm = KVM_STATE(accel);
     int i;
 
     for (i = 0; i < kvm->nr_as; ++i) {
diff --git a/system/memory.c b/system/memory.c
index 4f713889a8e..b072a6bef83 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3496,7 +3496,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         if (fvi->ac) {
             for (i = 0; i < fv_address_spaces->len; ++i) {
                 as = g_array_index(fv_address_spaces, AddressSpace*, i);
-                if (fvi->ac->has_memory(current_machine, as,
+                if (fvi->ac->has_memory(current_machine->accelerator, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
                     qemu_printf(" %s", fvi->ac->name);
-- 
2.49.0


