Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0244C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHVv-0008Hl-IC; Mon, 14 Jul 2025 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1t-0002Ix-Ht
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1n-0002Hy-6h
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6w/O8DUMjDwJGRTT3NN93h6bgPpbT9nKbZqZ0VqM/4=;
 b=DYplQBEJYyrAPVknzTWJZn06dHtpy29wdR/P0yeg2OyW7vnZ5TcdjVXoDUJrvNUpWKVB26
 g9SwanUIzTtMGv0RY1R7ajOQXLKTGyJ4X5NIvOPtSQuoxOHaA0RV3KryoSD4nF1efukiJT
 9gn25stT0hP0R2lhtqAr3XWhtC4FvqY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-AYbC0D4pNpOzd-b48XSbZw-1; Mon, 14 Jul 2025 07:07:19 -0400
X-MC-Unique: AYbC0D4pNpOzd-b48XSbZw-1
X-Mimecast-MFC-AGG-ID: AYbC0D4pNpOzd-b48XSbZw_1752491238
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b20f50da27so2494650f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491238; x=1753096038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6w/O8DUMjDwJGRTT3NN93h6bgPpbT9nKbZqZ0VqM/4=;
 b=M1qhGgFhGCMzy/RIlAM4pn0rwLCe04KnwA2EYP7cPrWtFwxwnAnYIVlOD6fyQ9z78r
 wHLxQfx4AUh4VLdjpJcXWBAnUxkHIVunlQBt/8O+lwu0WG0+SIUQxr1KdZw1q7jmu2k1
 GvXG8usMCAqy67i3lOk3SaIqkpLP248AMxJbpQkK/+GEnGYgleVwbDOPrVKyP2fhmNqE
 FuFTZSGKuB4gYhE/YSv7nROs7tTniv+1/a3+7wBjlDo1td7kAbw+2wP5FvJ7zYJWiQUK
 krRXiPDOr8KQix3jweWHnT4aGFU5YsED/6kOSmeSbR3WGbQj58G95cMFR5jbyvEJ2SFD
 mzqQ==
X-Gm-Message-State: AOJu0YxotDbpSU9SHon3kqEc3oZfws9CNQxEAZbK597BNV47I/nRyF+h
 Wa6QN6k2QjkMIbveEl59Eq7julCDq267h+xFdmgT0LyLBxP4U7QnFJanspp0cL3J93IPXqhG21w
 K1FwjpXUjJc3djH+Gp869XQ86t4lUIzyKMNegzNG1jTDslPyG9EtP3Sk8URTlgIxLDy96Na91U4
 iqXH2OIV53+dnNEZ09nNqPTcPCCvAddUYVF6BGruxx
X-Gm-Gg: ASbGncsrXnRUyEeaRG0LxR/No4w9/hd4DUdUPvxhZbiFHfdeYoYND7tX4VOhS0TjJWD
 XB3WNF9x5CvpFl6YbzR4l582lH4TKJcNUq5WNH8Y52GhUOhawlUmZ2A1QzARUA0VyzP4jVMZVF5
 x0T2ees7XOa8hDm40c9fQBaP/Xj0MNjg3RjvMmXvEMP9JzRyA01VEgYs7UGXPUJUQtt9eidsrCc
 L9hgl1IghJ7eYUq3xlUlXYgBFN4cIXxOQTt4EqQyG80hIt2DrMJouwvoEA0lFCgzHl4aVJJaRa/
 0eDFlATn4tNA0KQcEonrW9wrzfWTozYOdj60fKQ4adk=
X-Received: by 2002:a05:6000:642:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b5e7f34e49mr14461016f8f.23.1752491237763; 
 Mon, 14 Jul 2025 04:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaO/Bviye0gYD4qsJFPYwbD23m4B5O57FcePslOpsQMTLobrSRkA03oP4Z76xk1dD3Pi0s4w==
X-Received: by 2002:a05:6000:642:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b5e7f34e49mr14460985f8f.23.1752491237289; 
 Mon, 14 Jul 2025 04:07:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd4b32d8sm129140415e9.17.2025.07.14.04.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, Zhao Liu <zhao1.liu@intel.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PULL 74/77] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Date: Mon, 14 Jul 2025 13:04:03 +0200
Message-ID: <20250714110406.117772-75-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Chuang Xu <xuchuangxclwt@bytedance.com>

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
it's necessary to round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise there would be unexpected results in guest with
older kernel.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though threads-per-core should actually be 2.

And on AMD platform:
CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
result meets our expectation.

So round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer only
for Intel platform to solve the unexpected result.

Use the "x-vendor-cpuid-only-v2" compat option to fix this issue.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b7c22e5d38..12e719e9957 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7871,7 +7871,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
+             * count, but Intel needs maximum number of addressable IDs for
+             * logical processors per package.
+             */
+            if (cpu->vendor_cpuid_only_v2 &&
+                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+            } else {
+                *ebx |= threads_per_pkg << 16;
+            }
         }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
-- 
2.50.0


