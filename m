Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB28AC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8M-0005Gm-7Y; Sun, 14 Jul 2024 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8G-0004vz-OP
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8F-000267-2u
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=EJhyAf9BESePSVimDoTLSq++zGYaoeUznQ/pgKIWxa3mMDaoD9C5fSiSKKaVJGT7LcBL9W
 unDv3Sgz1/4gz5OHLiXa3JDiIDPV0F0SMPuC3S46y5Kxbea5XqDiaiwNeZ/gqPrykr6Ckk
 tQPC/V3gM6xJXEDNrD+ArH4dDp/4w78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-BndHyV1NO-O52A9cIjjzig-1; Sun, 14 Jul 2024 07:11:04 -0400
X-MC-Unique: BndHyV1NO-O52A9cIjjzig-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42725ec6d8dso32402465e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955462; x=1721560262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=wVNpe42fPe80nLzqbR8V9ussptBuE05eTF5JpX659Nr85QLs3AjKtGb+gOBaErAj81
 nxb/XJoCLpztjSKQsM+u4z6oKWWFq3O6ELyfJA8WsCCHVh8NRUJpax0lQaH/0vwJLfP0
 9/kMTc5MIo2ym1X2zzWLPvNZSRoNVRFE2Qgsvy1Q3NHVzCqLjm5W6KE1mb5hqKlIfjgs
 F6xPz84MT4tRwAS7j0Um9Tz1l3yytLnfUfVMIjmgaKGb8c//ArDZitY7rm4w2A4KLnIM
 csKlDx1vyh7mrnjYvCGxXjkX3rQtyvSxODsdtHcOcI7aHg2/DA/U9kKEGu1dydDbvskE
 ZBAg==
X-Gm-Message-State: AOJu0Yzu1xpH9ok8pnn5x9w41c8hvw5NEHHMn17htmbTHhhIWsLe+7it
 HjnTDIUKoLdj1xsVJOIm6zx8E4qAm35S2UDq0QqhJ8mn54AYaY9W3AquOjFv1Pk+SqkHRhIjcGZ
 x49ozRb2yDp1VNa/69h3lof1a6uLDsNPhIEv/+xYEmCW7B/VylamD7sj8TtKbgl66THsmeKiCP3
 0lztoeqRSyUAGmx9YPEzJNNWDThC6vjKJTyhsf
X-Received: by 2002:a05:600c:3013:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-426708f1c97mr124836835e9.33.1720955462575; 
 Sun, 14 Jul 2024 04:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuPa39c4EJJD5ZK6UOrT5ikByoKhQFw7f4dyQfg1x4TLynriXEpI4aWGeeO69Mpt2rUawZsA==
X-Received: by 2002:a05:600c:3013:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-426708f1c97mr124836735e9.33.1720955462222; 
 Sun, 14 Jul 2024 04:11:02 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25ac47sm83415875e9.18.2024.07.14.04.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:11:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/13] target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl
Date: Sun, 14 Jul 2024 13:10:36 +0200
Message-ID: <20240714111043.14132-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Disconnect mmu index computation from the current pl
as stored in env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240617161210.4639-2-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 11 ++---------
 target/i386/cpu.c | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c43ac01c794..1e121acef54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2445,15 +2445,8 @@ static inline bool is_mmu_index_32(int mmu_index)
     return mmu_index & 1;
 }
 
-static inline int cpu_mmu_index_kernel(CPUX86State *env)
-{
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
-    int mmu_index_base =
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-
-    return mmu_index_base + mmu_index_32;
-}
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+int cpu_mmu_index_kernel(CPUX86State *env);
 
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c05765eeafc..4688d140c2d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8122,18 +8122,39 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 {
-    CPUX86State *env = cpu_env(cs);
     int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
-        (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
+        pl == 3 ? MMU_USER64_IDX :
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
         (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
 
     return mmu_index_base + mmu_index_32;
 }
 
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
+static int x86_mmu_index_kernel_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (pl < 3 && (env->eflags & AC_MASK)
+         ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX);
+
+    return mmu_index_base + mmu_index_32;
+}
+
+int cpu_mmu_index_kernel(CPUX86State *env)
+{
+    return x86_mmu_index_kernel_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
2.45.2


