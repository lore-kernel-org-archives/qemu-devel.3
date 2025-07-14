Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFFCC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHA2-00037m-86; Mon, 14 Jul 2025 07:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0S-0001Om-Fp
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0Q-00020g-JY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTubnZ3o2Xiym1BO+0Jx8Ne4oet/OLGfGzFGRCfDWJM=;
 b=c1ucV1cYhYTUD19SJe8H9d1KSwu3yhp0Cwg+ERoqdARQ+XOFm7u8Z1VeMXlEpo4LaKeUmD
 Sy61lZ1LXW7LTewvBv07uiXVYjvNyvWvvFW4s3Q2pXXp/09ZtcCSQKKDr6j5kpw2RnS/5z
 sTL6P1FcZuznFnRtmMdxn1Y7FknGjw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-61AHHMq-P_qnRyEdl-Yo4Q-1; Mon, 14 Jul 2025 07:05:56 -0400
X-MC-Unique: 61AHHMq-P_qnRyEdl-Yo4Q-1
X-Mimecast-MFC-AGG-ID: 61AHHMq-P_qnRyEdl-Yo4Q_1752491155
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so1840195f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491155; x=1753095955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTubnZ3o2Xiym1BO+0Jx8Ne4oet/OLGfGzFGRCfDWJM=;
 b=fM1IxynCU0yGxdBl6O+J66fsrYytdwu3hg1MDKytiZNeBmval3Y8mlhNFzAIq7EXp2
 RT/qRkk1yROQzMK+Bu+WEP16/6NYEtC49AGKlIPQtwpC83EQDo8HodXlgTwDltZIG24I
 r0I1uMVZgAXX7LS534MU5UTLpUerLcN1QZuUkWChZNlvWVZe8lrJ5WGML+QEMoqjiNxB
 F/VjwcLt8vDZbFLQj5E4m1BBS5lBjvL8kejPc9POKrzjjw8FXytnV/MXZ2bay4tbt0Cs
 KSxgkBJhuXsaL+e/X3vtZ8kSiKn2Mmvb+xZl7jqZ94jFQTJk4iPbeasdZbgfci4iS2Km
 xKNQ==
X-Gm-Message-State: AOJu0YxNketSVmXwwf1RXwkUqwrbYi39FVKFqyWqxibi5a5quY1eDaLv
 EEyqdvLnuwGPdnctXIDy9EW/GaJP1KF24ILlHqSrpiDbNiNmn2D5SD9BmUhXl1LAeJTJM2raX9D
 UCPXS3RhLm2Atiwabmj0n2ypeNgI2j5IqARN6c0fnUnC+PSo3Aq/wlBo77G6Db0W9X8nxa8MDob
 DHGz6jSN0169YVkOaZ7pmSOtKTI3QYQ+TYmXep+ETa
X-Gm-Gg: ASbGncvItZ1lLZuZCD6Sd93gbq5cOK+SXUv78KOt9BENDx2qoSV9rLyQkveQfE25WmW
 CawnGdEaH+raOA0Xw3K7XqgPNGXGMe+jG65CdjEixVUX0vcsBwJK4DxQua2vODYGDzonjUH+5Ud
 tXzJBSGAG5DJiEOV70/eyyROV744eaf2DnUBn5WZKZSylXjBp0MyL/h260aRavW1WQyKauYGJBs
 Xc/hfTTxh3MktCBIDVcVhr+t3+5z1E8eo7jXur4J0PYGOq8kgT/r899iuokrnxJvPWljLOlhsXY
 s/EPTtsDuFu8sHcuvFd6nPnVUtnpovs3uEIfbXcPWl4=
X-Received: by 2002:a05:6000:4012:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3b5f2e229a9mr8767497f8f.39.1752491154860; 
 Mon, 14 Jul 2025 04:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxZCI6whCGuhwZJQbFjNVK4kWfAqulRs1wLCzTC1CnQkSpF9Konh5oajRVqAwnAib+rOso6g==
X-Received: by 2002:a05:6000:4012:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3b5f2e229a9mr8767475f8f.39.1752491154358; 
 Mon, 14 Jul 2025 04:05:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43906dsm130735525e9.3.2025.07.14.04.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 40/77] i386/cpu: Refine comment of CPUID2CacheDescriptorInfo
Date: Mon, 14 Jul 2025 13:03:29 +0200
Message-ID: <20250714110406.117772-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Refer to SDM vol.3 table 1-21, add the notes about the missing
descriptor, and fix the typo and comment format.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f9e6bc8d0e6..f107e586734 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -68,6 +68,7 @@ struct CPUID2CacheDescriptorInfo {
 
 /*
  * Known CPUID 2 cache descriptors.
+ * TLB, prefetch and sectored cache related descriptors are not included.
  * From Intel SDM Volume 2A, CPUID instruction
  */
 struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
@@ -89,18 +90,29 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 2,  .line_size = 64, },
     [0x21] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
                .associativity = 8,  .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x22, 0x23 are not included
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x22, 0x23 are not included
+     */
     [0x24] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
                .associativity = 16, .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x25, 0x20 are not included
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x25, 0x29 are not included
+     */
     [0x2C] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
                .associativity = 8,  .line_size = 64, },
     [0x30] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
                .associativity = 8,  .line_size = 64, },
+    /*
+     * Newer Intel CPUs (having the cores without L3, e.g., Intel MTL, ARL)
+     * use CPUID 0x4 leaf to describe cache topology, by encoding CPUID 0x2
+     * leaf with 0xFF. For older CPUs (without 0x4 leaf), it's also valid
+     * to just ignore L3's code if there's no L3.
+     *
+     * This already covers all the cases in QEMU, so code 0x40 is not
+     * included.
+     */
     [0x41] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
                .associativity = 4,  .line_size = 32, },
     [0x42] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
@@ -138,9 +150,10 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 4,  .line_size = 64, },
     [0x78] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
                .associativity = 4,  .line_size = 64, },
-    /* lines per sector is not supported cpuid2_cache_descriptor(),
-    * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
-    */
+    /*
+     * lines per sector is not supported cpuid2_cache_descriptor(),
+     * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
+     */
     [0x7D] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
                .associativity = 8,  .line_size = 64, },
     [0x7F] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
-- 
2.50.0


