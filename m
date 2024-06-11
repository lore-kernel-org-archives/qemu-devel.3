Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53949C27C5F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs7A-0002OL-Hs; Mon, 10 Jun 2024 23:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sGs78-00029W-98
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 23:24:02 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sGs71-0006sy-R0
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 23:23:57 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c9cc681ee4so313793b6e.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718076231; x=1718681031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8AjwpqgqIAUXWO+7jvYmOin/Joepb58U4E/wQwlKinU=;
 b=NU80UruzdR8kSrRuCgvVtiz0JEoWx9PXQx1LbnnGsfbXWi/5rAtTNifLr1eW7BSiWG
 PH86VU5SIuy/DMeLoYhfLeZ71CVzGioSo73BSaMAbkgZ+TQvS1Szi2dKl8Uwr2ViIWrc
 sG1gkiDnFdP+a1dgky1iF8eRznW1OKPnDp8bevpTeDZKomLOXOpOCwbbLonfdzxNPOqS
 fmeT426flr/GastwgKGO1YFGcUduXxwgY3H/QMJFMYRCeVxD1Z2foyE4wTaGX9Byddtx
 0shWYBLkc27D3Pi0Zo3eTLbAa3kXeQNlxqtxP2zHwIoXp4B+DxwuLr9UgMZPAFvTTSYh
 Aj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718076231; x=1718681031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AjwpqgqIAUXWO+7jvYmOin/Joepb58U4E/wQwlKinU=;
 b=JylV8i7PI2d5s9ip3RNfYIS4pSNYNodTG5/wipNfrbjtrzDZB2UK43O6rM6SZOvCgu
 9p0CB5L2gCS/6BtzFZa9GQrRJ7BzIUfljFepyjDxqVY76WDgqyuytkMW8goBNj/w7WmB
 h00HdRzR25A3rFCwcFvd6a/5nksUNFNCV9wnDSDLcYRRnetZLtE28RJCBgHvhfodBFtf
 TMrAEGlF0c8Kua49udANlKoX0AfBRb/YnWEHybY9mYuk9FaQrPYz46IejKQOoFVmpjXf
 SSHfI5JqamzI2XCEowtsbR7IJhjHuN7zqsExxxqjfkinaYkqa1hjJiuxI5Xw5GJYuvTm
 Q4WA==
X-Gm-Message-State: AOJu0YyJCtsOl84Iub820eGkDx6l5rOmquhwUERnmfPntCYXsUfEPHlm
 zELVUrFdaBzsUe+rAFWXwJJCes/Mlu1WReGiC55eIaEpFL0mLwPbPo3VDTTIFjOexgIRTULHpYp
 l
X-Google-Smtp-Source: AGHT+IHUQxtxOLZ1SwUyLkICLGxFt5UqoknEK/fIxHteqBPO5jrZ++eMXcqOMvMME6ngD83cNdFEsg==
X-Received: by 2002:a05:6870:ec94:b0:254:9ded:a3b7 with SMTP id
 586e51a60fabf-2549dedd4b0mr8244665fac.56.1718076230852; 
 Mon, 10 Jun 2024 20:23:50 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([139.177.225.238])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704318d45e5sm3668553b3a.117.2024.06.10.20.23.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2024 20:23:50 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xieyongji@bytedance.com, imammedo@redhat.com,
 zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for processor
 cores in the physical package
Date: Tue, 11 Jun 2024 11:23:14 +0800
Message-Id: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

When QEMU is started with:
-cpu host,host-cache-info=on,l3-cache=off \
-smp 2,sockets=1,dies=1,cores=1,threads=2
Guest can't acquire maximum number of addressable IDs for processor cores in
the physical package from CPUID[04H].

When creating a CPU topology of 1 core per package, host-cache-info only
uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
resulting in a conflict (on the multicore Host) between the Guest core
topology information in this field and the Guest's actual cores number.

Fix it by removing the unnecessary condition to cover 1 core per package
case. This is safe because cores_per_pkg will not be 0 and will be at
least 1.

Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647..b68f7460db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6426,10 +6426,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
-                if (cores_per_pkg > 1) {
-                    *eax &= ~0xFC000000;
-                    *eax |= max_core_ids_in_package(&topo_info) << 26;
-                }
+                *eax &= ~0xFC000000;
+                *eax |= max_core_ids_in_package(&topo_info) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
-- 
2.20.1


