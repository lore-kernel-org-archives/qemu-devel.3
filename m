Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B161BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wn-0007D9-33; Thu, 23 May 2024 11:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wX-0006q4-QY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wT-0004s3-PG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qzxmuhdIjAhTs7rtWsfeVu4o37deEU0k8r0LtHUVko=;
 b=SeSKW4pqNtHdyj7YcqEQHzBHzGdrgho4JCMpn+JAcMvAtYs+/FHxef6bCwSMdJtPpM8wL/
 VqwdBktwDmQRp1J+OJP+5m3wt0L9edbO55BOiz/iKBEFes+Erem8+iCwhNx9xVyWj7oP9q
 x/U34l1DqBI8O1wmp98fzzRoPBC/L7E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-LLtXc8UROyaDGji2tjfs1w-1; Thu, 23 May 2024 11:01:13 -0400
X-MC-Unique: LLtXc8UROyaDGji2tjfs1w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so131204766b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476470; x=1717081270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qzxmuhdIjAhTs7rtWsfeVu4o37deEU0k8r0LtHUVko=;
 b=G6oGr797kmflMPGwdOdXmumIE0shpmpV9mwgLK5W7bh/6L7p210/KLtnm5ydQmEQ3C
 laBc28MXriBukWqW3uOvcDw8k2GxrTU8YetAGAi0pU7P/NcNJiXsUp0C9WowDclp37vl
 4wAQe6gHB4IPSrtcEHLrin0fSvU9qwYFl4+cI5L4bJVpVHLOMoBaMnPlHSJEdry/HDkF
 CKwm+UJZbupyyUYS4Lgjjqg1R6ULAi4sy3qk4ShFjrj1aMfNNVZKQGM/CSGNzfgMMlBd
 Bt/BJQV1XAgJqSTu6yGuHok/FTTnFZSFtBvaHP8K96W7L6ZCJFyTyWP5/hleKETqOk3r
 Hjzg==
X-Gm-Message-State: AOJu0Yzs92JJQOsAJsayxrB5FtoQi1e0n+2RObQNGwo5zN73g0PhqyHf
 YlUGY8TZkCPI+UjIQACDSCZgjvGOuJuoiozIuF5sPNPgTHFDBz3z2BUDvbGq6T2YzlqYbJKnvkw
 Zbb4s7aBXGLVqfO9jNfRpIdJEYC3WXgLcS+ZsjapmF6PyY0hbKnaCZEFkmD3DxDXlYGMcS0jDCz
 R5ZfO1Z1Ci3asqF3TpeYncNzZUrkf22K2sauwc
X-Received: by 2002:a17:906:6a02:b0:a59:c319:f1e0 with SMTP id
 a640c23a62f3a-a6228171b37mr385432366b.75.1716476470619; 
 Thu, 23 May 2024 08:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWgFAkvYU8dlsswJzloFiOybHVreP+VN+veAttkceMPmIpl/XfkHLOvMSmQyTiu2rIyJPjGw==
X-Received: by 2002:a17:906:6a02:b0:a59:c319:f1e0 with SMTP id
 a640c23a62f3a-a6228171b37mr385429166b.75.1716476470212; 
 Thu, 23 May 2024 08:01:10 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781e97bsm1933153666b.32.2024.05.23.08.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 13/23] i386: Introduce module level cpu topology to CPUX86State
Date: Thu, 23 May 2024 17:00:26 +0200
Message-ID: <20240523150036.1050011-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Intel CPUs implement module level on hybrid client products (e.g.,
ADL-N, MTL, etc) and E-core server products.

A module contains a set of cores that share certain resources (in
current products, the resource usually includes L2 cache, as well as
module scoped features and MSRs).

Module level support is the prerequisite for L2 cache topology on
module level. With module level, we can implement the Guest's CPU
topology and future cache topology to be consistent with the Host's on
Intel hybrid client/E-core server platforms.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-13-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h    | 3 +++
 hw/i386/x86-common.c | 5 +++++
 target/i386/cpu.c    | 1 +
 3 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8c83900202d..e79293158a0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1898,6 +1898,9 @@ typedef struct CPUArchState {
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
 
+    /* Number of modules within one die. */
+    unsigned nr_modules;
+
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
 } CPUX86State;
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7d4f9b20f23..994f8424889 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -271,6 +271,11 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
+    if (ms->smp.modules > 1) {
+        env->nr_modules = ms->smp.modules;
+        /* TODO: Expose module level in CPUID[0x1F]. */
+    }
+
     if (ms->smp.dies > 1) {
         env->nr_dies = ms->smp.dies;
         set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f95d539eeff..eb1642c253c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7887,6 +7887,7 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
+    env->nr_modules = 1;
     env->nr_dies = 1;
 
     /* SMT, core and package levels are set by default. */
-- 
2.45.1


