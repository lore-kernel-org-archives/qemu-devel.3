Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E351BCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNV-00038m-0W; Sat, 13 Sep 2025 04:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN2-0001xz-Aw
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMy-0005JP-RG
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9SNH9xZqw17k1dQa+6YNWYLqrGHzK/6Bj3FxrwgA7I=;
 b=AkVdlZLmrft+6HExA9wkl/cj4bo7DR+mIO2kzFD1BXZPaXrwVWdwkmVGeob58SaAV7M4lx
 88rB1cqNqhbC30xsKJZZotv20Gg/Hs7YWnHHneoUtKDuYbaBBymRZFk3BoM52rzz8rCk8Y
 KAK4bKKKTi50LFfqWckeBT5q3VdLc5E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-iJIGwg7nObCY_jx5albS3w-1; Sat, 13 Sep 2025 04:12:26 -0400
X-MC-Unique: iJIGwg7nObCY_jx5albS3w-1
X-Mimecast-MFC-AGG-ID: iJIGwg7nObCY_jx5albS3w_1757751145
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e3f8616125so2193378f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751144; x=1758355944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9SNH9xZqw17k1dQa+6YNWYLqrGHzK/6Bj3FxrwgA7I=;
 b=bqkwJhIE0YdKZVxFSkIgurwD5ln0Sl0cZz8rJfpq6oDZfNZHporc/lRM2+uy/N91UB
 ESHd9qD77UN/qeCgEmVDvJ7PlZ/2XP/bFBxmAWe7L/nQkm97jI7FHMug+p1bKiI3ofUH
 Ex62XrfUC3iYg/HBJiM+efQ/XdtUnBu3m3pL28VLFCGbFAMi14qkqCPMZmbZSnl7lw+n
 hmuxGRGE9OwN45eN1aqQQLk0i4ROPpaWg1kZ12ckd+NsCiRkCA0pa1fXVo9+lUTuDduR
 3F2kcnzqt38RID2pq0HVoxWPaeCj5Svn84Y3VlxPdQM2nqkf6lnxaiTkaa1PQ9NjX2x3
 7BDg==
X-Gm-Message-State: AOJu0YwMCImNgThQHXWsul/ofCFBOSZgww2EhuQhnVwavoNsaGnI84LK
 VglTKFYfSbiAgzeyXm77MLBd7tkaYoSg7L72lEA/4OugmTOfjr8jtisRbGs9F7cF217kpynPy0c
 AQUGOG+8Inogw4wgv4fWmCJ6tXsAKBRIGdsTsHav38jTrEnqEs14vklLkXrHL9nd8Qve8ky0o2Z
 i26t1HnxFlwjNLPrP2eg9HFlMgVSiKNallElcVpk6h
X-Gm-Gg: ASbGnctSZsdlRi0KfO00nuJCsJ/eFRVZEImE7WLpQ6M4/myxtz0K/QPA0ciA46G2dX7
 r1grVcsW3GRWcQ3KO6hdydtII8wa1Tn3mR5NPnavQbGlhkZLmxSylvxbAWYLBrMgwaX5jXmEKlR
 oUm6J5j6XjQW5NOTbRSR80s/o7c9qrPJFAgFf6wERQF7DggsG85FGkpoVW6NubO0MQvjaCjlox1
 pMunGCeMR7cJGx0Mf3UMdD3N+lFclsCP86pUeGKl4Q/n1dolLakhwBXPh6z2Pcj3v/PXHGCXAuz
 GO+2dgCQfS/RM7gA/13DvVQZ7g0lHHWBAQqQiKmOcolvmctKBwn8DONiKng/eaIYU4o441P4kvs
 k4gLYQ9qnLOlaUIHBBukE8uv63KOJ8zCTw099o/hJgdA=
X-Received: by 2002:a05:6000:240a:b0:3d8:3eca:a97d with SMTP id
 ffacd0b85a97d-3e7657aa17fmr4834509f8f.11.1757751144302; 
 Sat, 13 Sep 2025 01:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4PcvJu1lIPyQyLVKnpvdWupEXB9+VsmgBph6gOu8ZoRRaowBoFFFSHA28B4A5V2lbI/ZWTQ==
X-Received: by 2002:a05:6000:240a:b0:3d8:3eca:a97d with SMTP id
 ffacd0b85a97d-3e7657aa17fmr4834484f8f.11.1757751143819; 
 Sat, 13 Sep 2025 01:12:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e2d43sm9431076f8f.59.2025.09.13.01.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 58/61] i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()
Date: Sat, 13 Sep 2025 10:09:39 +0200
Message-ID: <20250913080943.11710-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

x86_machine_is_smm_enabled() checks the KVM_CAP_X86_SMM for KVM
case. No need to check KVM_CAP_X86_SMM in kvm_arch_init().

So just drop the check of KVM_CAP_X86_SMM to simplify the code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250729062014.1669578-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 728ad401157..c9856d471ab 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3316,8 +3316,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        x86_machine_is_smm_enabled(x86ms)) {
+    if (x86_machine_is_smm_enabled(x86ms)) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
2.51.0


