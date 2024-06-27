Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467F7C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMplw-0001z6-7u; Thu, 27 Jun 2024 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMplt-0001yU-2E
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMplp-0003gM-OZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719497200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omeEP+EChxLrWKFVAw/fyi3wTf+uHg0OC6QMr9MwfXE=;
 b=Rnl78sHExA3x095E2zjAiq7+fmHQ6wy8JwGce2zI/67e2YIOGwA35BPa2AJ6HgPRzOmRqQ
 aB0eNr9Er5JLGQnWqI8AFEf6hiFOArAcADBURazqMZ77DPeZWhY2pIzWJkfTzKpQhYQKmj
 PQcOe2GhS3pWSQLYHtAlBYfTKXsoUTk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-po5dssx8P_iw_M6lOTZb0w-1; Thu, 27 Jun 2024 10:06:39 -0400
X-MC-Unique: po5dssx8P_iw_M6lOTZb0w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7194d0fd53so339423466b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719497197; x=1720101997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omeEP+EChxLrWKFVAw/fyi3wTf+uHg0OC6QMr9MwfXE=;
 b=s+rpn+Ek8cACVEIcl3pHnk/g8t0YmsrvN3fS0mpA6Ijl022xMt2azaZrq27+eyEnbH
 pmg4E4eMYvDW+9MyYDtj1d4eV2CecfYP9ux3D8mNSNxAVOJ6Uqzunlyy2BJfmxPoeAKt
 GWC5OoN/EbvW6vSy9Ks57uF9AxmOguWjsVcppSMuh/xY0ly1YcZCW4T19czMXe+AQHMg
 buyXB5PuOJOpt9vzdnNckCMkc+Cn6F5ygpg4oWJgpbYfnKH9Hpm8Ef2FH5cd0fuHUKvO
 ec3pzYWWT9NAlCga0RRcmQyw3Lipt0rPGZoAtPCouY2/JvuYlVKjsSEDjzegOq3IN/mu
 /BmA==
X-Gm-Message-State: AOJu0YzSiQFJUnyvzigU8nkK/2TUJcKptQ+D4uDfyZpAFR741H3vyqO7
 0UBs9ZSbN84n9s+9v4bCKKSZHYadohZt8TUSSnkMHQTKWH1O2BILvTyLgawTjU2yOdaHYArvybt
 zGWr7y2yNhZCHf9e/qI3AsH7XNc//oBGfZVcgyinj/CAhtJNPWUp2LRSSEFV08rtXEO3+l1ZQRs
 tf/ixViRyUISa8NRZnDZOJqztjxTpiYOXvJzl4
X-Received: by 2002:a17:907:a80e:b0:a72:7e1e:62e6 with SMTP id
 a640c23a62f3a-a727e1e65cemr588647166b.63.1719497197496; 
 Thu, 27 Jun 2024 07:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXINIDstjLifrWxu81EqWugJsfQepKF8HP2z4IC1V66fe5A8OwrMmsGOzzEXfxqy8bG82MrA==
X-Received: by 2002:a17:907:a80e:b0:a72:7e1e:62e6 with SMTP id
 a640c23a62f3a-a727e1e65cemr588643866b.63.1719497196893; 
 Thu, 27 Jun 2024 07:06:36 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72a66fc8d2sm2224866b.53.2024.06.27.07.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:06:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	John Allen <john.allen@amd.com>
Subject: [PATCH 2/2] target/i386: drop AMD machine check bits from Intel CPUID
Date: Thu, 27 Jun 2024 16:06:28 +0200
Message-ID: <20240627140628.1025317-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627140628.1025317-1-pbonzini@redhat.com>
References: <20240627140628.1025317-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
causes the bit to be visible when "-cpu host" VMs are started on Intel
processors.

While this should in principle be harmless, it's not tidy and we don't
even know for sure that it doesn't cause any guest OS to take unexpected
paths.  Since x86_cpu_get_supported_feature_word() can return different
different values depending on the guest, adjust it to hide the SUCCOR
bit if the guest has non-AMD vendor.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index deb58670651..f3e9b543682 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6064,8 +6064,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
     } else {
         return ~0;
     }
+
+    switch (w) {
 #ifndef TARGET_X86_64
-    if (w == FEAT_8000_0001_EDX) {
+    case FEAT_8000_0001_EDX:
         /*
          * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
          * way for userspace to get out of its 32-bit jail, we can leave
@@ -6077,6 +6079,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r &= ~unavail;
         break;
 #endif
+
+    case FEAT_8000_0007_EBX:
+        if (cpu && !IS_AMD_CPU(&cpu->env)) {
+            /* Disable AMD machine check architecture for Intel CPU.  */
+            r = 0;
+        }
+        break;
+
+    default:
+        break;
+    }
+
     if (cpu && cpu->migratable) {
         r &= x86_cpu_get_migratable_flags(w);
     }
-- 
2.45.2


