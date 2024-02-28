Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ECEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyK-0001W0-8z; Wed, 28 Feb 2024 03:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyJ-0001Vk-MK
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyA-0000W1-Jc
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaaGnvOvuEg+amyykEvtj5XWm41K6EEY0fV7AH7s47U=;
 b=YoiR+JpG1S8suB6FmGh+STBI0dKCecZHB6PMCvYpR9bX711nVHnSn8hNxoJ+bi9d+HSOI1
 vCwmKCbsCh0gGOAFO6vuAglxK2300pW5n/sAcuScNMYtZB/M1l14eSwnK19BQ+/+cG5c7x
 g+Zb8LgdtKN92TnKya5YZ8gPKfw+ZO8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-yzQfujq3PdSkvfP4B65j-w-1; Wed, 28 Feb 2024 03:07:12 -0500
X-MC-Unique: yzQfujq3PdSkvfP4B65j-w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3e94bbb22dso367048866b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107630; x=1709712430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaaGnvOvuEg+amyykEvtj5XWm41K6EEY0fV7AH7s47U=;
 b=MHrINMftzJAsD9p2s57DKkyFVXDnJEKIRvYXrSelA9yMsMs9Sp2Gq5eOwW28eaJrzp
 nwM+nzarfFBC4HKJ/i9phoQrUrHnC/R+GXOrsQ8Q0R15Alyuw7pDoTJT0kPAkXgFCaee
 xB4mheFkM5f6L07XRPR87tb4tGbVi8bkDk5pxB8GIvZa2PjVLWV1kV2cOkFajeI4CEb+
 Yx90AW1bV6Ns060f1+YTyCRPepWD6KqvO/C6O0XP3AkzazKNrWaMc2PfaZDstYG2EjSE
 IiDTibuuwX/8AMhBADWwsKmiNjw72xsR9KUJxwg1Im5BmqQbEi92fukQ8JsQWdMKDYkU
 K2dQ==
X-Gm-Message-State: AOJu0Ywnak1GTam0Y9Yf1MNVl/nHZp9zvHYrFYVeRAjHhtOTTMCESZwk
 8RgRUyrDWE817oWjmuM0C9Ccn0yUl672bDPRzWQoLVMdOTuEezFpTx0zEiYM2Bh+O3pUAR64DF6
 Loqpf+AOqBX08DzBk9VScCTeUJShT0NZJvXbpJazGfcyYOasVh+r2RRf1uwFIrNzJCCXrqMAVCk
 mmXJu8tL4xY5x2JeNb6pPJo06sVq7I0kzKFafX
X-Received: by 2002:a17:906:69b:b0:a42:f3a6:9f7f with SMTP id
 u27-20020a170906069b00b00a42f3a69f7fmr7114876ejb.13.1709107630209; 
 Wed, 28 Feb 2024 00:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSWHdk1bKJAGaPUAIqnmIiQGzY6CZeVMpweNzhyKOnG/9IKuQCDv1QWCENqS6lIHrjJi+C9g==
X-Received: by 2002:a17:906:69b:b0:a42:f3a6:9f7f with SMTP id
 u27-20020a170906069b00b00a42f3a69f7fmr7114851ejb.13.1709107629729; 
 Wed, 28 Feb 2024 00:07:09 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a170906468500b00a3fb4d11809sm1581168ejr.204.2024.02.28.00.07.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] target/i386: introduce function to query MMU indices
Date: Wed, 28 Feb 2024 09:06:40 +0100
Message-ID: <20240228080646.261365-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove knowledge of specific MMU indexes (other than MMU_NESTED_IDX and
MMU_PHYS_IDX) from mmu_translate().  This will make it possible to split
32-bit and 64-bit MMU indexes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    | 10 ++++++++++
 target/i386/tcg/sysemu/excp_helper.c |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dfe43b82042..8c271ca62e5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2305,6 +2305,16 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_NESTED_IDX  3
 #define MMU_PHYS_IDX    4
 
+static inline bool is_mmu_index_smap(int mmu_index)
+{
+    return mmu_index == MMU_KSMAP_IDX;
+}
+
+static inline bool is_mmu_index_user(int mmu_index)
+{
+    return mmu_index == MMU_USER_IDX;
+}
+
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 11126c860d4..a0d5ce39300 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -137,7 +137,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
     const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
-    const bool is_user = (in->mmu_idx == MMU_USER_IDX);
+    const bool is_user = is_mmu_index_user(in->mmu_idx);
     const MMUAccessType access_type = in->access_type;
     uint64_t ptep, pte, rsvd_mask;
     PTETranslate pte_trans = {
@@ -363,7 +363,7 @@ do_check_protect_pse36:
     }
 
     int prot = 0;
-    if (in->mmu_idx != MMU_KSMAP_IDX || !(ptep & PG_USER_MASK)) {
+    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
         prot |= PAGE_READ;
         if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
             prot |= PAGE_WRITE;
-- 
2.43.2


