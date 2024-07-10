Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C569C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpm-0008RI-Th; Wed, 10 Jul 2024 02:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpl-0008Mt-OL
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpk-0000ur-1S
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=XVTxqToPXrWF3hl7iOhWIpnx1X4yhe6I4oN9N9bUs0wIEwkKvvX7gkvUJcqYWU2cP1Iti2
 xr4irxzMaeYVSkhzxqQkEoECPRH/WCc886evJMSvshklJcylvG/AKCBN91aSQHtK9e/aiB
 t58+U6/499y5yG1w6OjVPBF7rUo65LM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-A56q7UioOOaxK9J_ueZ5UA-1; Wed, 10 Jul 2024 02:29:39 -0400
X-MC-Unique: A56q7UioOOaxK9J_ueZ5UA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee87d500caso59438401fa.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592977; x=1721197777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKHaLhM9UAuURgVWP4GssGjRnYIMl9btSsv/NKhFweE=;
 b=geMZPi8CkSWnCm4iIaE+CCeuPRngZhl2dLqnFHwGtgPnZiT5eB4aCIZyex04b66S0q
 kVWdBT1TnnvIwfN1864+O07F1Jp3wME8RJgWjP1fga/rHNriI3e1QhpLxbwKP5r0GqG/
 a2+cK9HDMuCCcR3UPt3PKr5COy7U5qDde4SE62rTuVq24W/TWVazgUrlpKACftv+XItS
 z5dWrl8JiVWPnu7UYg46LK1WK3jM2SKzofq5xZ7cuNHpdo7qGpKOYdjwfdZS06SZ8bqj
 KzbnrPdy8r3nxWhLgiRa9vOuPX0HZoO0H5cRgt2rPXYoAQSGmav/eVh9pS0k+ZkF7KLg
 e3Qw==
X-Gm-Message-State: AOJu0YzvtuLSvrBShAUI4kttNuIt/qA83YjUnXX9JDcvSxwNOdWD3/Hq
 bHNfJA5IQkr+r6uPwWwhWSUSioQOpwAe9y4SSSjLCEH/Tk/D3CIXs5HwNY+CfbTFie/Yg8YbnrM
 PibU/zaz16tLZCeCJK+p0uLqdAF1bKssbfudDXUpW39ogaewXSrAnX+2dqPX4XepUBksAR90fnE
 4rWcCIjZ6rWItP/RHIha6942e1VZVuS2Kik9Jt
X-Received: by 2002:a2e:90c7:0:b0:2ee:4514:aa9a with SMTP id
 38308e7fff4ca-2eeb318ab0bmr28900871fa.48.1720592976947; 
 Tue, 09 Jul 2024 23:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbrXwaCVR8B7ar+Qt5qj68fyrtyRkOnIvtVS2q+rGh3Er8iLlWYJy2oLW1NIwgx7GoRiakZA==
X-Received: by 2002:a2e:90c7:0:b0:2ee:4514:aa9a with SMTP id
 38308e7fff4ca-2eeb318ab0bmr28900741fa.48.1720592976556; 
 Tue, 09 Jul 2024 23:29:36 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde848e7sm4335496f8f.44.2024.07.09.23.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 05/10] target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl
Date: Wed, 10 Jul 2024 08:29:15 +0200
Message-ID: <20240710062920.73063-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


