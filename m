Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA8AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1u-00039d-Li; Fri, 30 May 2025 03:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty8-0004xZ-Fh
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty6-0007HR-I3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BoHJxeyPF/p6KVBQExhHB1PAVhko9FK31Y7draEtl4=;
 b=hEUilJQagf5jefgwoiNKJ1fHBtXYpilEM7HQD90YSY1S4RWfnqN2eECFaDLVeYnBAwzWX6
 DUjJImJ9b9bocLvK8wXukM7Rs9MK0O2nKAXSkZST0mQjuVnccT10eobOG8gfJUszAOnzbo
 58pf+nOr3v7J/c1a6TRQfn2YoBsf9cs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-69hpClfgP1K4SjUIx6Aggw-1; Fri, 30 May 2025 03:15:52 -0400
X-MC-Unique: 69hpClfgP1K4SjUIx6Aggw-1
X-Mimecast-MFC-AGG-ID: 69hpClfgP1K4SjUIx6Aggw_1748589351
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-603f71f6432so1479852a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589350; x=1749194150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BoHJxeyPF/p6KVBQExhHB1PAVhko9FK31Y7draEtl4=;
 b=KbtxwKzCagiquFUlBYvtYoTljuaTxaFfok2/O3XHqIeZZdGoat0vTD7+UbWsrVTDMS
 EGcfx9HIUnTLJ+qit5oCcslknoNRuzBZ18bdK4IQILh9qYOmXmve76DXpwglXtzW+s7m
 R1CVvxggtN/36XWTwmoytawodI3tKCWqaYgnjU+GVb+Wq9ruTKFCiO9JatCgJI2RPyS1
 vxuyeavzSyu+jLzheJfwa3Q7AyVq0fJkomgkj0Ei5LEJAMu/ZkKK+0a9g1C26iBJqGgG
 i5liO7DOT49lnSgTK7taL83Ds2dMFQEmOPJyqxPixKhYVbFI4xbjbFqSRC4S0MVfVx0s
 InUg==
X-Gm-Message-State: AOJu0YzqLaxsbQdvted5Jb8orxEOegSu2wpdgmxNWbSkszPkgt4kDnHN
 GNdgJslZ1gTjLdqVhvPOYgAW3GzPUvkDlVLn7aWSEXSSH9dzgmx4Wtp3QXHPAYba/VlyVznyLts
 8VvXUfgkk+MUeiITMlyCmKCOSpbDVTmQeluasWcNST+wOVablmVelOXA0AhBg7mlzGkpLzMkzUc
 79NYCGuRAm0Ff7ScnQ51XGWDvurp62a71/hel9pqBR
X-Gm-Gg: ASbGncuqTKK8ewJ27OPcV1WKkLu9Utf/lyEIFtJAK95gqoIDn2/3iWF/ypAm0DibxxH
 3M8XOO4Knwpjmr+fzLS/iFqt8yhdN53qWqLL9i4Giz0aIhT411lmT4nflHD/AutFtYrZZfygWTC
 uFf0CGDlf/TiCO/a8f5YGUrp/rXgOvczRqfy5ayazaBN1Jdkpg+kxMJ6R1S1XOOpYKKhzJkZ0Ph
 bnHD9C5aUNCvgQkrzd2yxe6VYABHuKL75T7pqBsorCexZP49bhjhrm8MNZkMrl3KfKOivK+aBzk
 C7J9Jlq9GgwT8A==
X-Received: by 2002:a05:6402:278c:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-6057c1c36bfmr1047861a12.14.1748589349864; 
 Fri, 30 May 2025 00:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRSuxSbIUU89YQbn/wpePAYq+ofUbe5PWe2kCpQRSlxMmtbLB8JFZydgOseQtCrNqWQ6Htw==
X-Received: by 2002:a05:6402:278c:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-6057c1c36bfmr1047839a12.14.1748589349402; 
 Fri, 30 May 2025 00:15:49 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2b301sm1229337a12.15.2025.05.30.00.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 71/77] target/i386: Update EPYC CPU model for Cache property,
 RAS, SVM feature bits
Date: Fri, 30 May 2025 09:12:41 +0200
Message-ID: <20250530071250.2050910-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Babu Moger <babu.moger@amd.com>

Found that some of the cache properties are not set correctly for EPYC models.

l1d_cache.no_invd_sharing should not be true.
l1i_cache.no_invd_sharing should not be true.

L2.self_init should be true.
L2.inclusive should be true.

L3.inclusive should not be true.
L3.no_invd_sharing should be true.

Fix the cache properties.

Also add the missing RAS and SVM features bits on AMD
EPYC CPU models. The SVM feature bits are used in nested guests.

succor		: Software uncorrectable error containment and recovery capability.
overflow-recov	: MCA overflow recovery support.
lbrv		: LBR virtualization
tsc-scale	: MSR based TSC rate control
vmcb-clean	: VMCB clean bits
flushbyasid	: Flush by ASID
pause-filter	: Pause intercept filter
pfthreshold	: PAUSE filter threshold
v-vmsave-vmload	: Virtualized VMLOAD and VMSAVE
vgif		: Virtualized GIF

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/515941861700d7066186c9600bc5d96a1741ef0c.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34364cf96ae..b6c63b892e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2211,6 +2211,60 @@ static CPUCaches epyc_v4_cache_info = {
     },
 };
 
+static CPUCaches epyc_v5_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_rome_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5238,6 +5292,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_v4_cache_info
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "lbrv", "on" },
+                    { "tsc-scale", "on" },
+                    { "vmcb-clean", "on" },
+                    { "flushbyasid", "on" },
+                    { "pause-filter", "on" },
+                    { "pfthreshold", "on" },
+                    { "v-vmsave-vmload", "on" },
+                    { "vgif", "on" },
+                    { "model-id",
+                      "AMD EPYC-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_v5_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.49.0


