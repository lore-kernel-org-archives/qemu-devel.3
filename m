Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E82BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVKB-0002g7-4f; Fri, 23 Feb 2024 08:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJW-0002Y4-Ax
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJU-0000RE-O7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtBLXpePvS/o3MJlxqLzK0dQtsDfqNmgQ7GMtdCEPZw=;
 b=a7k/OJtB43UsCYPY3xqkCyjJEr5hY0EzhH7Tnxf5hqQG8aQ7Qm+ilgjPIE59eeqAgd3I16
 iC19oHOceFtwxHrqKBakEqG4c1Dk3aApNtmbTFNTs3OdERSHdeIx6TbXgArQmnCkxKGItI
 LRGlP26UcPZv8IaSYiu+MW9k3eStdaw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-XI9EHFdUP_eVApb67l8iuA-1; Fri, 23 Feb 2024 08:10:02 -0500
X-MC-Unique: XI9EHFdUP_eVApb67l8iuA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d247045a5aso5812381fa.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693800; x=1709298600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtBLXpePvS/o3MJlxqLzK0dQtsDfqNmgQ7GMtdCEPZw=;
 b=g5Jhrv8ueJU0k+1DCZFtJ8Y/GUSG5ZM91zDK76x0UYxMrbi2PzUdmU/azrCt8y7Y3l
 PU8vFHMiCjSFc4g7moUtjXK5us0W9OOgf5nVkRrZ3oO/6esnuG9P6+GTP0MMh+9pnlaP
 maCcyoU/uVmnKmtjVpCIEaFXDAgX7bmfV0qmIURuSgzo+GUGER11UkRLHOSbTWjmCIjc
 6liTX7kNXwBR6qbGq4vT+19uzPVRIzkR/F2b+jAObusmxhWuyT3GnzV7LnsvKzaxty96
 zj8v02ZfBdjdORVwiNYZJqj5eZY4wkYHqggrdSPp5Cm53ypkSChrNl6vpYWT3pJaQcyB
 N4Nw==
X-Gm-Message-State: AOJu0Yz/+mrP1Bf9DERKg1YKyblhM6XM000UgaPhs746X9ETNX2jaWwR
 XyKKeAx7ROM9TfkL8IZpA2crLNvmGQ8sNrDcrOykAwegg0FwC9jsMLfa+6PoF2h81P1UaArOd2H
 ZWZazYyO/X5gdsycBeBFGWNVIoP258K0+oCDkkXg3FQ7ANqAiTWNuIoW2sSTvqB1P3/zJwCW3/g
 i0554InrIl+fuMGAbhDEi41m0UMVyLjiXRvaTl
X-Received: by 2002:a05:651c:1a07:b0:2d2:3c88:cd57 with SMTP id
 by7-20020a05651c1a0700b002d23c88cd57mr1559366ljb.32.1708693800139; 
 Fri, 23 Feb 2024 05:10:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ctPWsSITOZkh017u0lakxn8dLN3iAtpvysL3g4XP347kvxf6IuotRPjrhe/wn/Q3b2cE/g==
X-Received: by 2002:a05:651c:1a07:b0:2d2:3c88:cd57 with SMTP id
 by7-20020a05651c1a0700b002d23c88cd57mr1559350ljb.32.1708693799826; 
 Fri, 23 Feb 2024 05:09:59 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a2e9d41000000b002d0d02e50fdsm2543848ljj.78.2024.02.23.05.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:09:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 3/7] target/i386: introduce function to query MMU indices
Date: Fri, 23 Feb 2024 14:09:44 +0100
Message-ID: <20240223130948.237186-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
2.43.0


