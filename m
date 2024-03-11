Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjaYB-0004Vg-LT; Mon, 11 Mar 2024 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjaY3-0004V7-El
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjaY2-0001PW-0m
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710143892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XjC5bz/hkAEhannpJoBtgr6jB3+kTcrlWgLxuWtXWGw=;
 b=UNLIlqy54QRf5b1L2IqvhxN7tOUoZVpjy9VuQpws8J2JoPNIkE9z0ZT2J5Vid+3LFEOZWS
 6EPIjSkWy2ZeJv42ELVQ1atzU3xJcpzlUQeuY0WLSYouMK93Urn8/2myvnLnmHuac7ORX9
 UH7ie/AerpMmx0aMezSROVuXarQsQ+s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-UYSogrp5MFyKQZL46-UbfQ-1; Mon, 11 Mar 2024 03:58:10 -0400
X-MC-Unique: UYSogrp5MFyKQZL46-UbfQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so324997366b.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 00:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710143888; x=1710748688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XjC5bz/hkAEhannpJoBtgr6jB3+kTcrlWgLxuWtXWGw=;
 b=uZXGmrNLi/5JNM/yCHlHy1xTZakGt0rYTn6YpqRIUErVV0jyoWHy1pCxaIMH823zfI
 J7cl/qZbTsQZA+blOTWu/S+9c2YqaKaqObDiNHzYP5KfhHZbZSnIjMNT9293rqTKfHnj
 Zf3cXnXSxfy7d5FTedr7dWptAh9lhUD9U2TLnXRoLus7lIzYstOEbzixQzUMywpCLRDr
 E9K7WBVMChOC2RXWOO/Gxp9iA/Nrr1TzPMC80uqkgwaHTizgynTUkzHgxtW0j02AHj4E
 fTisyBilBzZnm1kbkP2HDbQgGUoUbJzIdLHh/MaMtTN04fIU7RGqGyUvFiHMGTeOl3c3
 XVBQ==
X-Gm-Message-State: AOJu0YwPjC2DVUqXY6ADpP1bEtHclKyaWnwdZX45ddC8vC0hEldmcMIi
 yqB+PJIhPhhhqv6A/w/5/7KvY5ERrZynp1dF/E/JX9AduCwBymVTpchoyVPltWyHpojq8eIJxdC
 k5YslQGO+LJVJHkEublj7xuzy4jPyG31QUkPiGfp7TWPlJEAAvULbhIKpkIWziP9MUq87bTPXxw
 rwRqzLtK+21tEACpw9m2td626JEJw1yXHM4cq6
X-Received: by 2002:a17:906:a14c:b0:a45:432:cacc with SMTP id
 bu12-20020a170906a14c00b00a450432caccmr3060869ejb.61.1710143888493; 
 Mon, 11 Mar 2024 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74FTQp0LwMAB8+X3EK2PTCYHZZUx6dcToJE7q02YveAhpKzL8Uxp2k44swd48YeAwWss3vw==
X-Received: by 2002:a17:906:a14c:b0:a45:432:cacc with SMTP id
 bu12-20020a170906a14c00b00a450432caccmr3060860ejb.61.1710143888113; 
 Mon, 11 Mar 2024 00:58:08 -0700 (PDT)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 ho30-20020a1709070e9e00b00a3edb758561sm2597692ejc.129.2024.03.11.00.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 00:58:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: fix direction of "32-bit MMU" test
Date: Mon, 11 Mar 2024 08:58:06 +0100
Message-ID: <20240311075806.668555-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The low bit of MMU indices for x86 TCG indicates whether the processor is
in 32-bit mode and therefore linear addresses have to be masked to 32 bits.
However, the index was computed incorrectly, leading to possible conflicts
in the TLB for any address above 4G.

Analyzed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: b1661801c18 ("target/i386: Fix physical address truncation", 2024-02-28)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2206
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f5..6b057380791 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2334,7 +2334,7 @@ static inline bool is_mmu_index_32(int mmu_index)
 
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
     int mmu_index_base =
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
         ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2666ef38089..78524bc6073 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7735,7 +7735,7 @@ static bool x86_cpu_has_work(CPUState *cs)
 static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
-    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
         (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-- 
2.43.2


