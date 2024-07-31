Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFFC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Lc-0005BR-Qm; Wed, 31 Jul 2024 07:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lb-00056R-JU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LZ-0006ly-Ug
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXQp/6q+UgrnD2vb9HkCYwGfgn5PjByeKn38gVNGzJM=;
 b=RqvWZ8WmGA1WDfRE21p71VvSIAlCnjdvXhgATWv4+csRDQvIrZSjk9nWaOCzH9odXuIKMf
 axPBmHBMmLQnk4JeZK2A1RTDP2vAkVeg5sqlsr8ZBJCKmt7CEPixImBpmRRS3pwedf8r51
 Uu4khnxyKprIZoaHscdFZVhT7bG8OaM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-HyYRgSHOPsiakK2bnpQqng-1; Wed, 31 Jul 2024 07:18:19 -0400
X-MC-Unique: HyYRgSHOPsiakK2bnpQqng-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52eff10441fso6390606e87.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424697; x=1723029497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXQp/6q+UgrnD2vb9HkCYwGfgn5PjByeKn38gVNGzJM=;
 b=PbfGVMIUkT5FbfKlu+cz0fJsjKYCqcCSXHcPShdg2hhBNxEQcCF2Kum8nJJUZADJYe
 +G39AMdWcygcesPH9NfFmu7EtbrQe7aCJOXunzuD9enWNAi+myfky0BYG+/goa4monIh
 D2Iu6i2yMJw+Oi1i+eNcbWypNb1/FK0QfTQvRTrhP6TpSuJonzukfFwbUk5N74yOYGxD
 FqAgsVoEgYLI54nbS5vNqFCAxVFOFnAfVqG91S03ufQba5Mvi4ek1qLSb42fR4Q0A9ds
 1nAc6pf3NytJUBj9AfH0ddL/awTMYq0o3318pB9Ti30hZLZ1NQ12WbbYW6aqhn0tIdpo
 7veQ==
X-Gm-Message-State: AOJu0Yy7DBkE6lc/5Evmr+2eU1s4MI3l37nHaknn/YcVqmVVbL0Kqt5E
 2MwRlUH1Kwt/bVxRq2+3K3ounKlEEW+AyLrU98izzfAoO6FZQtr/giiSWXN8dAX2B1MsXg+jXdQ
 NMYCckR05FZA6lJQ/CuK7T2J+1RUpk7vc/kHl6FvBPjGTgDtKIW4Wzr+T/oEgs3IXZ39M/1/6e0
 rSN2zEBCGN7NNDjvQ5bzJ4fp9m2FiluSXjXY8k
X-Received: by 2002:a05:6512:286:b0:52f:c2ef:a76a with SMTP id
 2adb3069b0e04-5309b2720a2mr7918448e87.18.1722424697394; 
 Wed, 31 Jul 2024 04:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERpqr58GDaaFTu+Ox4BYb5uKLqIsNilOjryoHAFCWA5/YvTgu4GL8ve4O+U+WZWCL7g19peQ==
X-Received: by 2002:a05:6512:286:b0:52f:c2ef:a76a with SMTP id
 2adb3069b0e04-5309b2720a2mr7918438e87.18.1722424696873; 
 Wed, 31 Jul 2024 04:18:16 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590cedsm8530617a12.29.2024.07.31.04.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/10] target/i386/cpu: Remove unnecessary SGX feature words
 checks
Date: Wed, 31 Jul 2024 13:17:59 +0200
Message-ID: <20240731111806.167225-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

CPUID.0x7.0.ebx and CPUID.0x7.0.ecx leaves have been expressed as the
feature word lists, and the Host capability support has been checked
in x86_cpu_filter_features().

Therefore, such checks on SGX feature "words" are redundant, and
the follow-up adjustments to those feature "words" will not actually
take effect.

Remove unnecessary SGX feature words related checks.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20240730045544.2516284-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ef06da54c63..a9535284aa9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6537,8 +6537,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
-            uint32_t eax_0_unused, ebx_0, ecx_0, edx_0_unused;
-
             /* Maximum ECX value for sub-leaves */
             *eax = env->cpuid_level_func7;
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
@@ -6548,20 +6546,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
 
-            /*
-             * SGX cannot be emulated in software.  If hardware does not
-             * support enabling SGX and/or SGX flexible launch control,
-             * then we need to update the VM's CPUID values accordingly.
-             */
-            x86_cpu_get_supported_cpuid(0x7, 0,
-                                        &eax_0_unused, &ebx_0,
-                                        &ecx_0, &edx_0_unused);
-            if ((*ebx & CPUID_7_0_EBX_SGX) && !(ebx_0 & CPUID_7_0_EBX_SGX)) {
-                *ebx &= ~CPUID_7_0_EBX_SGX;
-            }
-
             if ((*ecx & CPUID_7_0_ECX_SGX_LC)
-                    && (!(*ebx & CPUID_7_0_EBX_SGX) || !(ecx_0 & CPUID_7_0_ECX_SGX_LC))) {
+                    && (!(*ebx & CPUID_7_0_EBX_SGX))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
         } else if (count == 1) {
-- 
2.45.2


