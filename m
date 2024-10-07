Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E53CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxiu1-0004bh-HT; Mon, 07 Oct 2024 04:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sxitw-0004bP-OF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:15:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sxitt-0002WA-Jf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:15:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so30043845ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728288923; x=1728893723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4jEKDaliBrhfUZYD/I7SficdXSuxLO3cX5dW23bd5fQ=;
 b=dp4NWSOCcTZx+ykmD6XQ5Q6Mh964EEuyhRPS3yIyNIHsuIOEcTAx3q+BzIODzwHzFq
 ajst9tLzHwqXoi//4KM4lG7hNbYQyk4jo5cLIZlYclNgcvLzKWTlo9/7kkFyv8HlHxJ2
 enC6KvnojdEUWUtpLFg/eVnWQD/3Ff5aMolh1QiNKRTxvkiqUE3KUURYY155HS4QXZYp
 xmeEP2zVeaQqc2f+7xgFtOrIFvvx0fZCJQr5nanp6a9g1R8HFxqQ0wNN8bmrBvwfgAGX
 38tVF7AkiQJsLBYErth144iDTtVd7mlWDCCDoc/eWvBqfEo9c3AKEOv5MCTfYutppcij
 jAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728288923; x=1728893723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jEKDaliBrhfUZYD/I7SficdXSuxLO3cX5dW23bd5fQ=;
 b=RuVcde5/abs7uaBMGk79FhaeS4oOYW2zGTVBvAp7jarTOKGwmTiVW4ah5kP1FAjkgV
 NfcoLLvpNBhpGeop/3iz239/K+k30FUro+bGBHkzJ+HyUNohAbK+4qqdTtjyaP7DcojM
 /UVF1kZcn2GcCep0+JxymybsKeqp5aWpvWTRc48RrVCXc6OshwBXfS+aPavpWsFwtaPX
 1mJA+Bx1FSfeCyT63Z4LH+POZK0nZkvhxiM1E7UlmXgLbSM1YIAnF/vn2/t9o4F66ad4
 5h/RdV2jZNgD776aGqsxkVBRF8cgGG0N0YUyUROSsIJUKg/e+mAZtP9EVWOB7JIxAwAK
 Fx4w==
X-Gm-Message-State: AOJu0YxMMcVGnM/e3LgvCLwxBSdo8JvVSfQMe56Y5hc5J3kUbgVPo/R1
 v2RIUD8Gwzoo+OSmcJ41ly3ykEsokEL+k0YSIzBU8xymW3jp920+9GOhyEpfJrypsRYnYrmTBjY
 N
X-Google-Smtp-Source: AGHT+IG10dduOOXESdCPX2bPQhAprSod9+FXePVP9phMMjEsEEqHdbbYP7YyznOfWzw4hDaPAXK9RQ==
X-Received: by 2002:a17:903:1c7:b0:20b:7633:6e5 with SMTP id
 d9443c01a7336-20bff045264mr152590075ad.50.1728288923390; 
 Mon, 07 Oct 2024 01:15:23 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([63.216.146.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138d0cd9sm35124105ad.107.2024.10.07.01.15.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2024 01:15:23 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Mon,  7 Oct 2024 16:13:44 +0800
Message-Id: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.668,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
-cpu host,migratable=on,host-cache-info=on,l3-cache=off
-smp 180,sockets=2,dies=1,cores=45,threads=2

Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
CPUID.04H.EAX[31:26] as expected.

As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though theads-per-core should actually be 2.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
to solve the unexpected result.

In addition, we introduce max_thread_number_in_package() instead of
using pow2ceil() to be compatible with smp and hybrid.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..1b4e3b6931 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     return num_ids - 1;
 }
 
+static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
+    return num_threads;
+}
+
 static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
 {
     uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
@@ -6462,7 +6468,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            *ebx |= max_thread_number_in_package(&topo_info) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


