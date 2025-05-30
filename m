Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1EBC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu2X-0004C7-OR; Fri, 30 May 2025 03:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyA-00058Y-Kk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty8-0007Hf-PF
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/grfrfmdw2VEW3aEhItmlhKzpNrlDj8dmnxLAFAR78I=;
 b=fmLpRzgaNlfcczBTZg0qAhe28eMNvHA+bx8N5nHJu2/HByC1D23X5rBCTMzygAe1ranGDk
 9QlETOYZcKBTeTM1Fw/oHC14X3end8cIEk/7MXGMy2wIxUv54KILwbcLoTSEvi2aD2grYm
 egdWpXGvdifTTwK2Vh/AvgvHJHuuB2Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-9khYwaPbNyCvMdvedqHcNg-1; Fri, 30 May 2025 03:15:54 -0400
X-MC-Unique: 9khYwaPbNyCvMdvedqHcNg-1
X-Mimecast-MFC-AGG-ID: 9khYwaPbNyCvMdvedqHcNg_1748589353
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso125420866b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589353; x=1749194153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/grfrfmdw2VEW3aEhItmlhKzpNrlDj8dmnxLAFAR78I=;
 b=t1hVza3uxHLKC+085/sTdObS94ylUdmCBJ1Mv9FOtZ+F/ZrV+N2BcoXbWcPlQiZ3gM
 eeIo4BWd2OP75Pj76n2sHw1Crt0eG2o8FR2Gb38+9KP1xEMZhK4299+6BUfTrcWRauEu
 kHPUKPYBkEq+lgHDbEjACFA9lDz2NCJdgDrRPuPK3Fi3cAlU0o/QhZSJnJj44b7ar3zk
 wMKW/L9WfVTWNMeuewLji1q2Ug2y1dPkeHDfDSwg4hL4uPgQVxa4fmOsourV06hieyOv
 RR//CdLJJ/qXmBA1Riv47CckXLpAxreBgm7rkOb+8ijI+79r0AeypMOxbJnISF8zmuEL
 AYiw==
X-Gm-Message-State: AOJu0YzuAfToHo620i/sZXBVyzk38hU05E9eMmVUvARFgjq4HKE174Fz
 fnsYfMp9UnUpDAroyGZdfrs/fMrLrGn2hqeZXKEvFssW9d/oPtUMsWnUOR5ZNb7Pg4pyfbikYNC
 pXZfCZXhRI9D9pnVeAMVDIbG4UYTqmG8BdUfdakiYgbqRd6RKEKEQmKGwPyc4MLYlMzpPUoIF06
 oyjSIBI1NAZ2Zed6TStmcg28FbGeI5AhqiSyo5jUzq
X-Gm-Gg: ASbGncvAfDibIowqfwgOmQFQVmnpQ+2jMmthgqzRNkCC5vODGtLQdI1u1aRsBDuPa0+
 sfeUVTB5q61XNw1IuSoQBzXg8sZfXLrQCnWReeRjW0PIks7QtLd4wcXoiAzU1Fg5L+yaworIItt
 02IEYdsDqFEocJ8B4tavqKGp1rJdJhHJDnOZQX1PF5fsdTrAwvvPh8tvapQDK8+tzXFZBkMYS67
 bwa7e+0wDkjnR/s7mbqiZeIeiOwjJ3Dy7SyM1nzpaJQw8dhdZ+zWbyqm0Nj3TJmfi08ek2tw78x
 YgaZlm2lMdzVDA==
X-Received: by 2002:a17:907:3d87:b0:ad5:6ca3:c795 with SMTP id
 a640c23a62f3a-adb322ad496mr196345866b.33.1748589352891; 
 Fri, 30 May 2025 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYeg74yLesoSJ0WsXwylZPHmzfC0b1zHYI2cpXSTl9Cj1WYbO1woNWk2rrz93NzpZH3xTl4g==
X-Received: by 2002:a17:907:3d87:b0:ad5:6ca3:c795 with SMTP id
 a640c23a62f3a-adb322ad496mr196343366b.33.1748589352313; 
 Fri, 30 May 2025 00:15:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad394e5sm274193666b.137.2025.05.30.00.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 72/77] target/i386: Update EPYC-Rome CPU model for Cache
 property, RAS, SVM feature bits
Date: Fri, 30 May 2025 09:12:42 +0200
Message-ID: <20250530071250.2050910-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Fix these cache properties.

Also add the missing RAS and SVM features bits on AMD EPYC-Rome. The SVM
feature bits are used in nested guests.

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
Link: https://lore.kernel.org/r/8265af72057b84c99ac3a02a5487e32759cc69b1.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6c63b892e3..5b5324a35cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2373,6 +2373,60 @@ static const CPUCaches epyc_rome_v3_cache_info = {
     },
 };
 
+static const CPUCaches epyc_rome_v5_cache_info = {
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
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
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
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 16384,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_milan_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5449,6 +5503,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
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
+                      "AMD EPYC-Rome-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_rome_v5_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.49.0


