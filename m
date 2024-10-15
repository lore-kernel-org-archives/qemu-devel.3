Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DA0D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMZ-0005Rv-Io; Tue, 15 Oct 2024 10:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMV-0005Ko-UY
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMU-0003Hi-Gk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJhntmVL+IIZJoQgkrQP49+0DkjO0yya6uVPlEEo4vc=;
 b=eMRvlsNnSX5KoDgFDrjnsVurF1U7dctzMoTDkUvAXm3lKuw9leI4ONaepei241rpvR8eE2
 wNKZCoy4GZdkT4DLqcHHda7FUu51s6q69EYi34OrXCS225Z5HYdafZz2wXG6KylWBHvrKS
 4dcUIu1qg+pw0hYFfKVytc8n1YjO9Ko=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-WVDjH4uuPceg2zfaLSsG9A-1; Tue, 15 Oct 2024 10:17:20 -0400
X-MC-Unique: WVDjH4uuPceg2zfaLSsG9A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb5a195d63so8711551fa.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001838; x=1729606638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJhntmVL+IIZJoQgkrQP49+0DkjO0yya6uVPlEEo4vc=;
 b=YDWDUoNmMeYFgvlUmXHz0avMn21S2WAnJi9ybx9zGIikAP8pKP0Cbs6shSE8BRrg/8
 K3OuRqnO1B7q38gaMri/g5PMDS9+dc6R6/jkBbn0s1UtgvotzHBgTBiLDbOI33BNYBRS
 2b77WmkjCTfFQOBqu4Klo1MjNMK2TBz0jdxt4MHxU8d/TZn8I3bg74dGpJBXQfsYiWjA
 Jl6e1T+LV3ZkKr1UaGO9K+EkS01+XPjEznDTfZZWDJQ/Zj1NrAxekn6nBf1kruOk6FTH
 +75OgdJtLf/y98VkIGrPGv+FBlcjFH5OT3czbnYc/nPsevRurwGxDUrwM9HZCXDqaZZ9
 JVZw==
X-Gm-Message-State: AOJu0YyeEGvOUBbwNntFxXsyh6yJvpxfK1jlNglPcLE49CadfUXIEHuM
 PPla00U7DmFaTA+bcHPVkDNEnSt/u2qJhRnbHD3ZhvoldEZNjCiUHO0JAlGqctPPT5jmQHrTAqp
 ndH8Rzv9sVASbgwKGaIri9VSccP0WZtxoOp+p8TNF4aHlTlTxO+XTzuQaCRQjJ6MS4nLjeloOJr
 nn1P3/6zofpGVM7tzQRONXs6Hi0QbMehJ+0OMMqP4=
X-Received: by 2002:a05:6512:33cb:b0:539:f7a2:65ac with SMTP id
 2adb3069b0e04-53a03f4b3b7mr457756e87.35.1729001837754; 
 Tue, 15 Oct 2024 07:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxcK0x6gkUD+kDozE05CQ29/tC4qjPaqEuQAyb+/qI5zgE6Wz/1MStErq93T3bE8luBzm7Mw==
X-Received: by 2002:a05:6512:33cb:b0:539:f7a2:65ac with SMTP id
 2adb3069b0e04-53a03f4b3b7mr457724e87.35.1729001837201; 
 Tue, 15 Oct 2024 07:17:17 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87ed1sm1696797f8f.45.2024.10.15.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 01/25] target/i386: Don't construct a all-zero entry for
 CPUID[0xD 0x3f]
Date: Tue, 15 Oct 2024 16:16:47 +0200
Message-ID: <20241015141711.528342-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently, QEMU always constructs a all-zero CPUID entry for
CPUID[0xD 0x3f].

It's meaningless to construct such a leaf as the end of leaf 0xD. Rework
the logic of how subleaves of 0xD are constructed to get rid of such
all-zero value of subleaf 0x3f.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20240814075431.339209-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e6f94900f3c..6f6301460d4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1864,10 +1864,6 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
         case 0xb:
         case 0xd:
             for (j = 0; ; j++) {
-                if (i == 0xd && j == 64) {
-                    break;
-                }
-
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
@@ -1883,7 +1879,12 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
                     break;
                 }
                 if (i == 0xd && c->eax == 0) {
-                    continue;
+                    if (j < 63) {
+                        continue;
+                    } else {
+                        cpuid_i--;
+                        break;
+                    }
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     goto full;
-- 
2.46.2


