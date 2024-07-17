Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF44C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwq7-0002hn-S9; Wed, 17 Jul 2024 01:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpu-0001vg-07
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpr-00022s-Uy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=WXoaf+nUGM0yOOz2FKuov91eFX5OzbtZU0y5gAh7il/AVI4ICW/wUikMqF+MDT97P/6ILH
 dM0g6i1zda0wMVjcBX0rE+OIdGLmCQosu4vUJWOHZ2SLY4r3NmKCA7fK3/vAS1dz2fzS5M
 +qwVi//gEypXxqOO5Yi2kaWcRSaWqEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-I-BKg60pMmS67cezwKZthQ-1; Wed, 17 Jul 2024 01:04:12 -0400
X-MC-Unique: I-BKg60pMmS67cezwKZthQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-426d316a96cso45214095e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192651; x=1721797451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=tBnR5DRbmHZz0jE5WSfoZc2PpZwlservFDaPaza0OVOQKdVVZgX3xAfoxIuD8T8z+n
 wdvEBljTA0wpSJzRQ7yRPyhXhJLuff27ZAlIKV05YAIRbq4f3JAupOfem0PUCvogM6ft
 Lmc6SWinS6BlTu/7b0xS8tqvIr/Om3NiTw9XK5vTYlg80lAWoxBnEYNxFlIIZ5aU6UY2
 s9l1I0paDN7j6Q+zwlQMu6IEW0PxHhDUmTmQqHL/Sa9i+BCUUmOgLgpThaaqlzDCYGEn
 EnJnbnBo17ledOafDcsbqyXUkYY74JlDKGB1jg+aoaFHVYbwQEQMGNMTP0jxVNAbQJTN
 EfTg==
X-Gm-Message-State: AOJu0YzpGKIhchPMV5RtwHaN6CBm6pyJid/IYiwoDAUKWW1GDb185zAn
 67IbGej2So9ZycsANxSrisXTXdFMQWPzEpKuHXqoySTmKV/z2eUyMejojCJO/qHBf6KVTSdr+cL
 u/av5E9z7FnRYaVIFnHGZC85J1cpbVLTXJl5+xNfENIReBLgFM2Ct48fOc7+nYzVFwaLcPQG041
 BfrNF6G2gkkqCngAsxoqzMSTbH912f9DFOXda0
X-Received: by 2002:a05:6000:1449:b0:367:9224:9621 with SMTP id
 ffacd0b85a97d-36831652dbemr560831f8f.31.1721192650830; 
 Tue, 16 Jul 2024 22:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2I5D3daTJc3397Rln35HQ/I8rX9TK6ncyWsdAnpIbjPtqEW6AKO1wjHptuXJfZprsFJpuw==
X-Received: by 2002:a05:6000:1449:b0:367:9224:9621 with SMTP id
 ffacd0b85a97d-36831652dbemr560814f8f.31.1721192650507; 
 Tue, 16 Jul 2024 22:04:10 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbe5dsm10661527f8f.81.2024.07.16.22.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/20] target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl
Date: Wed, 17 Jul 2024 07:03:26 +0200
Message-ID: <20240717050331.295371-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


