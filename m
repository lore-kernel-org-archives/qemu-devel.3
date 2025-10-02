Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA47CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvo-0001DM-QS; Thu, 02 Oct 2025 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mv3-0000su-B6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mun-0005mR-Nw
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUFiULUVUzPH0BKks65FyI6vNwb5lhVHtOUe9XrvOsw=;
 b=OFE60tjF3dUdXs/o96nW2IU3ZZhKzsMuD0drSyVL0f85l4m9/q/pjutoTWdIeGI4mYJCVL
 PZZF/MLXqwcr/+lBMVR4ZMKfFLtErCoZc3cvGwpRyQgC4QUQIZAFFtDuWNsrV8Sbh0jUkK
 2I8GmaIYR1T26YAmUafWiYtBEqITHIE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-BiRl64kpM2WVloiwlT42yw-1; Thu, 02 Oct 2025 13:16:14 -0400
X-MC-Unique: BiRl64kpM2WVloiwlT42yw-1
X-Mimecast-MFC-AGG-ID: BiRl64kpM2WVloiwlT42yw_1759425373
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b2f9dc3264bso135576466b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425372; x=1760030172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUFiULUVUzPH0BKks65FyI6vNwb5lhVHtOUe9XrvOsw=;
 b=VrpkMGsVwAd00zrS1SZWqQxaQxS1yWxcsst7XW6V0Ez+k08n1/zRe75PKeOAL0aWFa
 X7gjriW/OfgK4bTA7Ya98eSweAT7QsS0SBT+D6KQG4rMnrYmxZNh+ZEvX85Y+Oklg26X
 EUo9cZA2z1IqXZEx/sivTu/gnuhibSb67rgwqBpXh04JoRR+2wp3P7gEwxZLJesD2adc
 BXPqWBcpf6Wm4X7U6U5Y2ArhEbsaDcxEnXnWPOn/hf25XIVCnvpxQaUE3WWfPXmm1XbT
 rkndjnVOEDC/TxXt2fTdy7ptjGrz9EgJzIZ72PX7Ni4JTyAo1dR84k7S8q4njx2z+d/n
 1IJw==
X-Gm-Message-State: AOJu0Ywa9pTN+AB0KKdrtuMKflFjBdmmXTwr/dl1MoSLAVIxf3MWpZV5
 2GxyNAOHmmJfPHScqi0iveM+pJFFeO0v/hvLONn5mKkP89NDeD10KqEjZq5z9OPqeWaeRRpW0MG
 tcUH0MXzk0bs2hRCdyf3c++ozswliLIwmyiSRbDPS7es5aU1ZjSeWPdWNPyyua4Q6/n1zbFdCTc
 yad9zPue9u+S5G0wpaeIIcYvx53aTZlYdYLn+7e1jl
X-Gm-Gg: ASbGncu65c/X4e/rGDAfiTWMxL6HTtHzLLyBdoKMv03SY2u89ahdJtszX5OHHTE8E1J
 ER7MSIt60O5JNYXWIC1NHMWFPSwRnm4UNE/muzL6uSRjNHi6l5kRfjuuN9z0wFX03h45SvIdHJ2
 h/qhJ0ABROauDk5y0Tj0vbx67Y4kllFmoGWJFXImanmuOGIREtRydRO6oZHLHiYlFiwQBkBEquF
 I1KSpE2fhGQzNicxRlS1w9Yr3axilUiua/S90XKRwJDkpKWjhw4XpI4Ztr5I2ZqqIQUYLOovCSR
 CFRv9oj82fogQu6Xf+uSZlf/AOTyL47pjE+32gZAD7jx60mk7cIxG1aDtQF1PnD04pbfBk/InQ9
 AZ5bVEV9WRGWVXZ+zD4DLuCnMX3TZHd7e6QOHyIJUQ8IR3mpQ
X-Received: by 2002:a17:907:3f8a:b0:b40:e7ee:b5e2 with SMTP id
 a640c23a62f3a-b49c324734amr26375566b.55.1759425372564; 
 Thu, 02 Oct 2025 10:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERWMpvLSwGR7aYI7pqRxmpb0oZlQcUy2vUSOCWsA/GyUhxYAEmxuJM3OXXe96y0ZqCUvOpkA==
X-Received: by 2002:a17:907:3f8a:b0:b40:e7ee:b5e2 with SMTP id
 a640c23a62f3a-b49c324734amr26370966b.55.1759425372061; 
 Thu, 02 Oct 2025 10:16:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652a9bf1sm250197066b.13.2025.10.02.10.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 12/27] target/i386/mshv: Add CPU create and remove logic
Date: Thu,  2 Oct 2025 19:15:21 +0200
Message-ID: <20251002171536.1460049-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Implement MSHV-specific hooks for vCPU creation and teardown in the
i386 target.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-13-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 02d71ebc14a..5069ab7a22f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -30,6 +30,8 @@
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+#include <sys/ioctl.h>
+
 int mshv_store_regs(CPUState *cpu)
 {
     error_report("unimplemented");
@@ -62,20 +64,29 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    close(cpu_fd);
 }
 
+
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+    struct mshv_create_vp vp_arg = {
+        .vp_index = vp_index,
+    };
+    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
+    if (ret < 0) {
+        error_report("failed to create mshv vcpu: %s", strerror(errno));
+        return -1;
+    }
+
+    *cpu_fd = ret;
+
+    return 0;
 }
 
 void mshv_init_mmio_emu(void)
 {
-    error_report("unimplemented");
-    abort();
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.51.0


