Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD50C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHbk-0004hJ-79; Mon, 14 Jul 2025 07:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1t-0002Iz-JJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1r-0002Ii-H4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7ivlVK8LeaiN4yE6sBu0n/7LdVsgXH72+awvNRHcSA=;
 b=cWcHp2H9DGuiEhwSBMFfa91v/1R2Q+xA1Mlxw1WRlih6o3PaJm725v8pCpkyWvgzn6z3sG
 XHstjBzghNiiLpdgGb24d67CJUTwEs9vS7ZFGdCXB3fVfjWNHuEfCkr7Ke5/qQIpjR4qyG
 5fxRsEUzfDWvgm0ckxi0dl+qeFAtG4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-iDch3j22NOigMsAX0XG6dA-1; Mon, 14 Jul 2025 07:07:25 -0400
X-MC-Unique: iDch3j22NOigMsAX0XG6dA-1
X-Mimecast-MFC-AGG-ID: iDch3j22NOigMsAX0XG6dA_1752491244
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so2934839f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491244; x=1753096044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7ivlVK8LeaiN4yE6sBu0n/7LdVsgXH72+awvNRHcSA=;
 b=vpeWJ+3A06/Or6tDimv3unxHJNELUzM/FvTTC8Hoed5GqMiNPAv+87RpdX+W9yM6s4
 SiUgHQwOVFobQ2bgQdBeNCkaq9+htxnsUwRuzc/VWhZ1H3Ge7+mIOsESwuFvpKUen/0q
 7AgEWC6zJu684P6GGbRMTygkB35k9voftCOSQVFX6jcjErBohg4SlWR3SHOgyyrs8Pjz
 SuqH9EjfSkoYcCTiuqGw1WVI8MF3XqpdKpGfSzXD98GIWwBXjsR5BWhsWbi38DN31fKH
 Te0KQ1V+y3WUJ/twMYEFn9UlFdSApmVdavWicPS30ScZNXEJKyqVZAMas7efL5KslVvw
 gdHQ==
X-Gm-Message-State: AOJu0YxXEttOfL1TefGQd1PLsoDzD/X/j8qBFoBUILqA0YrY2hV4z71Q
 XNgmIwiQiFsj3VjlL2e+Kp/y+blFiZ0IBhWZST02GROuBXggN7CSZFh/GdMQ95izZPtZLWFG1Es
 cDs1vtjkTW+l045Q1Gdg4M6U6v7tvKRQOjUvHPOxsSc6gU6QSpRQpuKmt7R35QGXXEno5+f7Z3E
 dZachT9DLaBf2zmCFAPkp3aoey/E36ASmdlY1CJTPj
X-Gm-Gg: ASbGncu1p+vZsuPjWZEMS2hf5MK6flfprOUPnrlrpoHohI5OzStxOu2v09WunBXM5OU
 c5wvF+b0JYnAlUXl/if5mVGedRkVioZJS+a3dbykZHEMA/okZfDyam1QCE+pOfKNotWP6IHvT1U
 KlLag29AS6ad+OhBCRYHzVOvfsEWxjmXZe5M/fJjo1YUp+153dvi1Ygi4vsdxHfpW6T+OUpEotD
 Uy80ZHJcNplNj0dQI6kVl6QRGpv9CwLyK0zMiDG448eqMKWTKW3Qg01LwwhIuZj+3bx/sV/bW7j
 vPmiS4ds78WiVuGLQY/DrlQDyG15zce6g5GDjn43Bfk=
X-Received: by 2002:adf:b650:0:b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3b5f1895d50mr9146919f8f.39.1752491243544; 
 Mon, 14 Jul 2025 04:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEORH0RXW9jtd69kPa62/b5ZeVctH+2Slc5bUIjw63vmz7pBn7nztYSbvBhRRGvcVQ4fEkd3A==
X-Received: by 2002:adf:b650:0:b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3b5f1895d50mr9146886f8f.39.1752491242953; 
 Mon, 14 Jul 2025 04:07:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm12141494f8f.36.2025.07.14.04.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Qian Wen <qian.wen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 76/77] i386/cpu: Fix overflow of cache topology fields in
 CPUID.04H
Date: Mon, 14 Jul 2025 13:04:05 +0200
Message-ID: <20250714110406.117772-77-pbonzini@redhat.com>
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

From: Qian Wen <qian.wen@intel.com>

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EAX[31:26] to 63, so max num_cores should
be 64.

For EAX[14:25], though at present Q35 supports up to 4096 CPUs, by
constructing a specific topology, the width of the APIC ID can be
extended beyond 12 bits. For example, using `-smp threads=33,cores=9,
modules=9` results in a die level offset of 6 + 4 + 4 = 14 bits, which
can also cause overflow.  check and honor the maximum value for
EAX[14:25] as well.

In addition, for host-cache-info case, also apply the same checks and
fixes.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 608fdcf7578..fdc677614d8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -349,11 +349,17 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
+    /*
+     * The following fields have bit-width limitations, so consider the
+     * maximum values to avoid overflow:
+     * Bits 25-14: maximum 4095.
+     * Bits 31-26: maximum 63.
+     */
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           (max_core_ids_in_package(topo_info) << 26) |
-           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
+           (MIN(max_core_ids_in_package(topo_info), 63) << 26) |
+           (MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -7930,13 +7936,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-                *eax |= max_core_ids_in_package(topo_info) << 26;
+                *eax |= MIN(max_core_ids_in_package(topo_info), 63) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(topo_info,
-                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
+                    *eax |= MIN(max_thread_ids_for_cache(topo_info,
+                                CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
-- 
2.50.0


