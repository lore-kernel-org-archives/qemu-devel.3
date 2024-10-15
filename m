Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A2D216AF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMf-0005Yu-5h; Tue, 15 Oct 2024 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMd-0005Vk-FZ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMb-0003IK-VI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUmSACYKcbnATfGmH+SmfS6XDaw+I+gZmfDAyJvyAIA=;
 b=jE45lLwKcD6jqmDQ5M45jFflW2SDG8NITlpjL8KSq6P523rWaFEqy1JYOAFnKirE7pDEHv
 TWrNecdE0+9m+blEwajG/VlHyzJoT313CxNjjTzys6n/SQvQR/vVp+Gum4nBVisqKI/Hyp
 Lw7hvGDtpDYDvKXBZ8jBX0TjWwtlJFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-tddnMHsPPYeMZE60OXfY_w-1; Tue, 15 Oct 2024 10:17:28 -0400
X-MC-Unique: tddnMHsPPYeMZE60OXfY_w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431207426e3so18284335e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001846; x=1729606646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUmSACYKcbnATfGmH+SmfS6XDaw+I+gZmfDAyJvyAIA=;
 b=Uqhb0Qc8mAXFzYkAKgGnfnFJr/wrr7Wcqx0bBC5ccn2rFgEbja5x4F5iKkS3Swfbzj
 HFwcYDF2qcZZFZeYXcqcnLymyMo7bLl3CchyiHO6ACFJQJfExeDsOoHSFpVRLMIf7iQE
 4MCKTSAOPNKOkDfBZuFhYZ8x7tmLX+1wa2Qk2o2kEyoFQdMqYGoNOBS7Bg34Ged3FGEx
 EpJ6pS3WmhrmzPAlGy5Zk/Rp/bo8cCF3S2hR+4UpHiBFgXGrfwFUF2tUZxifcUHr/nAm
 Eni7131XX6ha93LIFPs4PhcyiU+OHppktJzY0sXpm6zDwubhWl4T88xWkanWsTz4YhH/
 8PPA==
X-Gm-Message-State: AOJu0YxbD7uyxQBkan33PW2LEvkAtoeebyd/aslU+lbyqRpTip5WlHa8
 orNdEFuHIHclowKUAwIYHMu3RWbI2Wgzt7IlKUBwfvdJgmegqDgdzpMAds27h7dRu81ArYQumJh
 8zBSU8pYim6vTaxVgiu01P1M1RnxGMePhSdpBALS2yoOaN8D4xFlF03IQy+ZPZ4zCFQ0H6IrVSI
 hl6+qLUGHOgadYB5m2OQfxLoj1ho3cP+gjkDobrkI=
X-Received: by 2002:a5d:5105:0:b0:37c:ffdd:6d5a with SMTP id
 ffacd0b85a97d-37d5519df73mr13014928f8f.6.1729001845701; 
 Tue, 15 Oct 2024 07:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgeGSee1sIIMSD78GslpSAUiSMJZ3temoaPBTikEdS6CCmx2/XdLWOkFUTon+UDwj8oLo83g==
X-Received: by 2002:a5d:5105:0:b0:37c:ffdd:6d5a with SMTP id
 ffacd0b85a97d-37d5519df73mr13014894f8f.6.1729001845148; 
 Tue, 15 Oct 2024 07:17:25 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf8416sm1685083f8f.77.2024.10.15.07.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 03/25] target/i386: Construct CPUID 2 as stateful iff times > 1
Date: Tue, 15 Oct 2024 16:16:49 +0200
Message-ID: <20241015141711.528342-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

When times == 1, the CPUID leaf 2 is not stateful.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20240814075431.339209-6-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6f6301460d4..77e88165707 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1838,10 +1838,12 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             int times;
 
             c->function = i;
-            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
-                       KVM_CPUID_FLAG_STATE_READ_NEXT;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             times = c->eax & 0xff;
+            if (times > 1) {
+                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
+                           KVM_CPUID_FLAG_STATE_READ_NEXT;
+            }
 
             for (j = 1; j < times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-- 
2.46.2


