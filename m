Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063EDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFL-0007VE-TX; Wed, 20 Mar 2024 06:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFB-0007Oq-BX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtF8-0004GY-9K
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEt+bnIEYXM3eqMtGHzHP7POB7seAo+l58iXMkd+kYE=;
 b=AgnIedo4dcqzK5JrHUhIzpEijSePxNVRtVIdnshr0dEuTmoyI7QfBK6smIn/4odxK2vhtA
 um7aV+bSlTuKOQ5LAYvYj+2N/6AUbVG8RypZziAtA38Xc4PEhbHfa9B/7rMCV5C5i0kMaJ
 QXOyvVuWFC+C+e9JRd3pJdkAtzHv2Pk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-_OAEaWVrN4Gff6OEWnu19w-1; Wed, 20 Mar 2024 06:32:19 -0400
X-MC-Unique: _OAEaWVrN4Gff6OEWnu19w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46df460e77so134054366b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930737; x=1711535537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEt+bnIEYXM3eqMtGHzHP7POB7seAo+l58iXMkd+kYE=;
 b=CjRuit5kM95/94GJy2N2Il6y+TM4U2HjXTVA/sMGO0VHlGDUl1hyTloErEg5NweIxg
 MAFJf2ffhrAjcv7AVceGYP02JdkuDXlZPfMF4qYLZsO/ly4o42bjf5GQ1eRkThIH0oLP
 5AjBWQ+j16JjWAy9juXcDMUxW2DJhsG4CI2LZA4n9Dq9ixl9q9s+exbhe5HetzvAGTXt
 1Ha9koMGbtcr0hUJdOEjNFQHPWQ2/KyWPPUnv0cnSB4N47Af+102grZrzYENBgjHvWnf
 yiSLv3WYSs5IYS3h8vzJlhSLe0FjMZ0isXQYRVtUyUfJvDtOMHcNxyTfLqR8/V70W5ri
 ETjA==
X-Gm-Message-State: AOJu0YxmXTLMRIT1m0kyvjuwMkRBo0lkQb0Y7suZxDAabsymHwZQ8gXa
 /Qi/nvcVLPfyrvaG7v2tNyNTrMvj+dHDOget6Xy0eyPI4Ozsm1IhkKdviP23gpS73R5Z/S10wRw
 lWSbrxLatUO3Ygh7sTTyRp5SGZ4qDthf5ZHRQDx2oal+aRTofs2zJJUbNULC1BPCwUoM3lQE+1W
 oeTaGeyzetH8AYighOWrGywW2a6Eow+/zlvyuy
X-Received: by 2002:a17:906:3914:b0:a46:c4c6:38 with SMTP id
 f20-20020a170906391400b00a46c4c60038mr4751841eje.10.1710930737479; 
 Wed, 20 Mar 2024 03:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGieTmAnLIk/KY+zYVyho0SOANxc17Kgop1vR2QER2H5m2ykn0Vx9quwzGaQdUqThwNh4USiA==
X-Received: by 2002:a17:906:3914:b0:a46:c4c6:38 with SMTP id
 f20-20020a170906391400b00a46c4c60038mr4751821eje.10.1710930737004; 
 Wed, 20 Mar 2024 03:32:17 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 nb33-20020a1709071ca100b00a46da83f7fdsm2006865ejc.145.2024.03.20.03.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-stable@nongnu.org
Subject: [PULL 1/6] target/i386: fix direction of "32-bit MMU" test
Date: Wed, 20 Mar 2024 11:32:08 +0100
Message-ID: <20240320103213.1048405-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
References: <20240320103213.1048405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 9a210d8d929..33760a2ee16 100644
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
2.44.0


