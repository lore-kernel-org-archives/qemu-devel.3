Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5116C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEj-0006n0-1G; Thu, 04 Jul 2024 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEe-0006iF-1z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEb-00087p-7u
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MTUOgRFnaAQLOr/FyDNaauHZx0Uilejdebgta3jTEQ=;
 b=XuH5OJ8fsxNMdMJon5SFxh6gMbFKnNQHPkimbElbNONoxJwSjfr89QEHdCWe8oEaIK6125
 W6a/AUSDjAz/IMVmAz6HXE9FHa3qhQzEUwoSxG4WIQr8kz4p/moQzb67T8NTqBPqFwAePh
 i1iVRzIo4Vpc3+sv1QJzYsseDxnUBEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-GSME48tbO5WlGufHvFhuHQ-1; Thu, 04 Jul 2024 05:58:33 -0400
X-MC-Unique: GSME48tbO5WlGufHvFhuHQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-425685183edso3708165e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087112; x=1720691912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MTUOgRFnaAQLOr/FyDNaauHZx0Uilejdebgta3jTEQ=;
 b=iwb8txBFgrGIVw7IPQl2edHa5YFCN+z/OUGM/0Ixg0oRp/sJqul1lWimSHhZ3QKQLm
 gAZrYWa+PVscCXnbFlOW3TZfnRRDROzDi8zlRCLWEKmpu0XF8GRToSQxGHxEbIY2oEja
 jeWmAxJGvdado+c3c//i2s7ooiPg1yeQoX7yACkVfz1Yf9rBEfjcxVL2GVeyBTu0rlXB
 H42CD1la12C1V7CaEB9ZSZT3NXDtjedgW1XtrR+LXdysr4+QF9J0caJbKkiGPW//AJZX
 7iU+CbcQtgg0b8RaSQ/OSc9ShO4nz6CWyR+Tislu9cV2NBuMz1Ld25mEFWBZo3u5TRlf
 kQ0w==
X-Gm-Message-State: AOJu0Yx9MUAipAqy3UPYHZEBi3mQzbK95I9sZyESaxoPtXkX1lHPhyLP
 rCLk/RQLIhf77tXtzpjTYby5vl+fZ2osKCPmFEnWpnXfAUlCLWW8nPaZ4uoXIfFac5YFDBMjISZ
 jQoPMQc5tGktSJ+9KqEiy1p5uLF+5lfqVqMIFTK/8s4Yg5MNsXYrmyjPRgz3zPPDkTkSfOdc8Lv
 vdzB22zN/K2Frh4DhsxC/RnRsCc4FDhh7oOAze
X-Received: by 2002:a05:600c:1d01:b0:424:a823:51d7 with SMTP id
 5b1f17b1804b1-4264a3d98edmr7901895e9.5.1720087111876; 
 Thu, 04 Jul 2024 02:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2d7pjRtK/y4tRaCePStbfdb7cFHEqio4Q9CKTU86/vYRj+HdJQeMBy9PKSnx3DzlKf/ij5g==
X-Received: by 2002:a05:600c:1d01:b0:424:a823:51d7 with SMTP id
 5b1f17b1804b1-4264a3d98edmr7901815e9.5.1720087111483; 
 Thu, 04 Jul 2024 02:58:31 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264aa07a95sm15361815e9.1.2024.07.04.02.58.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] target/i386: do not include undefined bits in the AMD
 topoext leaf
Date: Thu,  4 Jul 2024 11:58:00 +0200
Message-ID: <20240704095806.1780273-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
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

Commit d7c72735f61 ("target/i386: Add new EPYC CPU versions with updated
cache_info", 2023-05-08) ensured that AMD-defined CPU models did not
have the 'complex_indexing' bit set, but left it set in "-cpu host"
which uses the default ("legacy") cache information.

Reimplement that commit using a CPU feature, so that it can be applied
to all guests using a new machine type, independent of the CPU model.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 3 +++
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9bea7142bf4..0d5624355e4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2104,6 +2104,9 @@ struct ArchCPU {
     /* Only advertise CPUID leaves defined by the vendor */
     bool vendor_cpuid_only;
 
+    /* Only advertise TOPOEXT features that AMD defines */
+    bool amd_topoext_features_only;
+
     /* Enable auto level-increase for Intel Processor Trace leave */
     bool intel_pt_auto_level;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77415064c62..5dff91422ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -80,6 +80,7 @@
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
 GlobalProperty pc_compat_9_0[] = {
+    { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "true" },
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5e5bf71702c..c40551d9bfb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6982,6 +6982,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
+        if (cpu->amd_topoext_features_only) {
+            *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
+        }
         break;
     case 0x8000001E:
         if (cpu->core_id <= 255) {
@@ -8293,6 +8296,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
-- 
2.45.2


