Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F411CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNoo-0007j7-Va; Tue, 08 Oct 2024 23:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syNon-0007il-Hb
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:56:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syNol-0008Pb-1v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:56:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b90984971so65534355ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728446213; x=1729051013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zysoOgYWRxFsYfR8sAY5YlZkGoFfzyRqcIlflQhRqKQ=;
 b=TP8dm8eNNDOZOgCoiKIj+IJQYGXwfkHI9aj2LaPTR4yBS+RlYUJMxfkFDWB+fYxmyJ
 oPt20/rZWQJ2renaOCQ7LjxNnw73JEgP4WoaahNvY6Rmr324b49JKwR51pVl7VbnMfiT
 eg2/N+9kUfl0rq4OEBlyu8+JW2oDvKfh9bZrETFsVgzcPUSw31oiDcWcsxfUs0Uwyp5J
 YZB5tHvbS8W9Htm1sj6vocH9vJ9Dk8094322LmChX8ti5Zu5wGZsB17WKa2YV2FGouan
 CaTeb6tsV96R+DxVs68UztaUB3MeeAmF8Ojjcl2O7hQdAPTSwzqqbV/pzY6dkw7wEK2m
 u1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728446213; x=1729051013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zysoOgYWRxFsYfR8sAY5YlZkGoFfzyRqcIlflQhRqKQ=;
 b=aILvlytVOa+USs/N2rLVd2zDzJFXKGjhQm6vGwbd54shEOpmdBFi1U5CLkpL+FE73o
 0M5u6DgOVKFiwYXdmcmhCtcPA+0CJrZvZZ3jKBJ7QKncbybAhqyJnT7OBymGRdvARqJY
 avrdg8RcroKljqBGYzBcwNkrWMR86TrzARoOdrI5zXqbZx9iXJKWkEzqTBThQ62YVQEW
 Fu47obihB/yaCJX/9Ren8K3pNrw0qeGJYqymLpqTw1o9yDUj3A4a+7McG0d8Pwz+o0HZ
 3DrLdk2XHoN6wXQlkbGOONZwVpp9PmZDVURrW+XlCWf4nXbfdplSAsrpytwUWqvHJv+N
 o7OQ==
X-Gm-Message-State: AOJu0YzoqFKsR6hVJvRiwimq+twU6wvWrKRvYLsMd/GgPFsRrq1A9yoi
 sudNFUxsFF94Xyk8dVpibdAVgdStlcYBPnTMov3znTk5zyfz/RNcqzBgLASj78J//83R6I3IJB6
 L
X-Google-Smtp-Source: AGHT+IHHOAAXiK86D5kpqgvkhWQJ4mGIs4kUvfOR44j2sdswvokkRkbhranYe3I3YXGTRxdzWB7zGA==
X-Received: by 2002:a17:902:d504:b0:20b:770b:ad2e with SMTP id
 d9443c01a7336-20c6373ce12mr17785155ad.28.1728446213234; 
 Tue, 08 Oct 2024 20:56:53 -0700 (PDT)
Received: from KK6FJ77W06.bytedance.net ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13994f84sm62417255ad.290.2024.10.08.20.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Oct 2024 20:56:52 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Wed,  9 Oct 2024 11:56:38 +0800
Message-Id: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.66,
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

On Intel platform:
CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
logical processors in the physical package".

When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
CPUID.04H.EAX[31:26], which matches the expected result.

As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though threads-per-core should actually be 2.

And on AMD platform:
CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
result meets our expectation.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
only for Intel platform to solve the unexpected result.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff227a8c5c..641d4577b0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * AMD requires logical processor count, but Intel needs maximum
+             * number of addressable IDs for logical processors per package.
+             */
+            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+                *ebx |= threads_per_pkg << 16;
+            } else {
+                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
+            }
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


