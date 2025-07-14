Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628BBC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHVe-000811-Po; Mon, 14 Jul 2025 07:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH19-0001no-3s
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH16-00028W-JP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR6j7BhZab0elBL4igl7ltcFzqCGAaAHJVZIJY5nUn4=;
 b=hzxkKC9AXkyAK7brF4kAtEwI/gNM5GHkteBVX5QoTWayBmrBzBFzPevK074oVH0e/Q81Pu
 EBQxu833IEFbcM7lcIsv986aD6eS/u8a/6Q++w0ZEIymUjMzc+NsPQXmlxOntrVzSytM0b
 13oG720zaJOurfKjliihMId2YOOZnu0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-bNlMaX6oPiWs3TUWaZ-S1A-1; Mon, 14 Jul 2025 07:06:33 -0400
X-MC-Unique: bNlMaX6oPiWs3TUWaZ-S1A-1
X-Mimecast-MFC-AGG-ID: bNlMaX6oPiWs3TUWaZ-S1A_1752491192
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2171832f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491191; x=1753095991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR6j7BhZab0elBL4igl7ltcFzqCGAaAHJVZIJY5nUn4=;
 b=QJLWltDnnBkHTllBjHlLfnrh1K8EuXpIKVfrQ0z6U2gyVzuWJrkUyhstBwaJfTHztl
 agGWQty37g383lqkA7CV6f/TED3c2z1gcFuqZEDdJQI61+80zTu/RLXyPl/GKcrOKvaG
 oTx14odjuCLg+5Mlkn5Nw/lYZ46ZFXecK3DXdFIY6NX7269NWb48Qv0n+coV9AxBp9xm
 HykL5c0MKSnIqlF5DPRuRI/BbjZ8trA/gijxZfjwmNzFd+yYT07SLrpFcrasnwx+6HXK
 LhuAgWqIdHSFSj2rgWIs3LG5+xwsVVHpscS37Il/eqYKVpxKqW28gVfU87G4t+Ph73U3
 /90Q==
X-Gm-Message-State: AOJu0Ywo0i6TRtGSEyNaByJaIgWhz/xz97QEanLcJLL6GcOIfKCMtqiZ
 DzJWwf6nVvirDCM2V5Nat4S9aj8v5g4TTXoFCfUgevL8/aeiYe92szcOsx+RWIlCKMeTIXdhOji
 wkh+flZH/WGlDBA9PvrAHDUE2ml4I6ZXmn2k6PFJSCJ1szCX6AmArJJZQVwrBXJq7oPK0lZdms3
 RtixMNszLijo262uRiXRotRxDbQU5sjiYAyEKetm5D
X-Gm-Gg: ASbGncvtCMWV4qhKJDXo6NzlInsbbbVvrOMxBCQvDw+ah5ORAH72qIj5A+ALbVYU15k
 pAi2PplKg76NsXJbsIu0tnKppYquR1mI44PnfGDnbf/kYXy/CoGaRTBM/5wQg/payyzyliwBL0U
 Nw8WW4LEMjwzc49NvEyDRgnPX+cvY5HDwjTKSvQbygup6sKWVRjEPsnH8YG9pujxJiZFGuqAed+
 WwxEZVElvKakByy3ZHQJH1byH/chY2JxcxNNmojwEeb8Mle4nEScslkHMgN/BzBp+27JsYS9bdm
 yM+ivGoX5G/yqsuq2csFzBZSYH0qWOwAXGFXsxakBFM=
X-Received: by 2002:a05:6000:2388:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b5f187d0e3mr10954260f8f.7.1752491191216; 
 Mon, 14 Jul 2025 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiuSfF84UqKQ4W78xs7PMKnFx3QFxXTNNdbpY01qa5fDTuTTtk7FQlzWP7RWBvot1k5ZUSpg==
X-Received: by 2002:a05:6000:2388:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b5f187d0e3mr10954216f8f.7.1752491190566; 
 Mon, 14 Jul 2025 04:06:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1890sm12034273f8f.3.2025.07.14.04.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PULL 55/77] i386/cpu: Select legacy cache model based on vendor in
 CPUID 0x80000006
Date: Mon, 14 Jul 2025 13:03:44 +0200
Message-ID: <20250714110406.117772-56-pbonzini@redhat.com>
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

As preparation for merging cache_info_cpuid4 and cache_info_amd in
X86CPUState, set legacy cache model based on vendor in the CPUID
0x80000006 leaf. For AMD CPU, select legacy AMD cache model (in
cache_info_amd) as the default cache model like before, otherwise,
select legacy Intel cache model (in cache_info_cpuid4).

To ensure compatibility is not broken, add an enable_legacy_vendor_cache
flag based on x-vendor-only-v2 to indicate cases where the legacy cache
model should be used regardless of the vendor. For CPUID 0x80000006 leaf,
enable_legacy_vendor_cache flag indicates to pick legacy Intel cache
model, which is for compatibility with the behavior of PC machine v10.0
and older.

The following explains how current vendor-based default legacy cache
model ensures correctness without breaking compatibility.

* For the PC machine v6.0 and older, vendor_cpuid_only=false, and
  vendor_cpuid_only_v2=false.

  - If the named CPU model has its own cache model, and doesn't use
    legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
    cache_info_amd are same, so 0x80000006 leaf uses its own cache model
    regardless of the vendor.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is true, they will use legacy AMD cache
    model just like their previous behavior.

* For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
  and vendor_cpuid_only_v2=false.

  - No change, since this leaf doesn't aware vendor_cpuid_only.

* For the PC machine v10.1 and newer, vendor_cpuid_only=true, and
  vendor_cpuid_only_v2=true.

  - If the named CPU model has its own cache model (legacy_cache=false),
    then cache_info_cpuid4 & cache_info_amd both equal to its own cache
    model, so it uses its own cache model in 0x80000006 leaf regardless
    of the vendor. Intel and Zhaoxin CPUs have their special encoding
    based on SDM, which is the expected behavior and no different from
    before.

  - For max/host/named CPU (without its own cache model), then the flag
    enable_legacy_vendor_cache is false, the legacy cache model is
    selected based on vendor.

    For AMD CPU, it will use legacy AMD cache as before.

    For non-AMD (Intel/Zhaoxin) CPU, it will use legacy Intel cache and
    be encoded based on SDM as expected.

    Here, selecting the legacy cache model based on the vendor does not
    change the previous (before the change) behavior.

Therefore, the above analysis proves that, with the help of the flag
enable_legacy_vendor_cache, it is acceptable to select the default
legacy cache model based on the vendor.

For the CPUID 0x80000006 leaf, in X86CPUState, a unified cache_info is
enough. It only needs to be initialized and configured with the
corresponding legacy cache model based on the vendor.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711102143.1622339-17-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e98ffb11c31..b557fd01c02 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7983,8 +7983,33 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = encode_cache_cpuid80000005(caches->l1i_cache);
         break;
     }
-    case 0x80000006:
-        /* cache info (L2 cache/TLB/L3 cache) */
+    case 0x80000006: { /* cache info (L2 cache/TLB/L3 cache) */
+        const CPUCaches *caches;
+
+        if (env->enable_legacy_vendor_cache) {
+            caches = &legacy_amd_cache_info;
+        } else {
+            /*
+             * FIXME: Temporarily select cache info model here based on
+             * vendor, and merge these 2 cache info models later.
+             *
+             * This condition covers the following cases (with
+             * enable_legacy_vendor_cache=false):
+             *  - When CPU model has its own cache model and doesn't uses legacy
+             *    cache model (legacy_model=off). Then cache_info_amd and
+             *    cache_info_cpuid4 are the same.
+             *
+             *  - For v10.1 and newer machines, when CPU model uses legacy cache
+             *    model. AMD CPUs use cache_info_amd like before and non-AMD
+             *    CPU (Intel & Zhaoxin) will use cache_info_cpuid4 as expected.
+             */
+            if (IS_AMD_CPU(env)) {
+                caches = &env->cache_info_amd;
+            } else {
+                caches = &env->cache_info_cpuid4;
+            }
+        }
+
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
@@ -7993,7 +8018,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (cpu->vendor_cpuid_only_v2 &&
             (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
             *eax = *ebx = 0;
-            encode_cache_cpuid80000006(env->cache_info_cpuid4.l2_cache,
+            encode_cache_cpuid80000006(caches->l2_cache,
                                        NULL, ecx, edx);
             break;
         }
@@ -8007,11 +8032,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
 
-        encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
+        encode_cache_cpuid80000006(caches->l2_cache,
                                    cpu->enable_l3_cache ?
-                                   env->cache_info_amd.l3_cache : NULL,
+                                   caches->l3_cache : NULL,
                                    ecx, edx);
         break;
+    }
     case 0x80000007:
         *eax = 0;
         *ebx = env->features[FEAT_8000_0007_EBX];
-- 
2.50.0


