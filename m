Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD855EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXu-00058W-Eu; Wed, 11 Sep 2024 08:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXl-0004Iw-7O
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXj-00011M-Jp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CNOQq4FCPyKHD3scgo6SQA3bN8P0n+b7XCCMQAnvYU=;
 b=Wp8BFSMmiSWKFtN44VrVDNFw981lsWn+2WjlkHYXrWrRNKm9jQVn3VFN7BA1e4GIirZP3X
 iC09n9qpR3TDaEwPg/+JtGO5sFV/kxKZ78Pzf1Lr5gUr680idZFe/b1xE8hC1beyz8Qm4j
 HyJ72LdjUkrKTJHmHX+Gc8AIJxlFtP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-5-2hB0P5OkmnxVKNCfqKxQ-1; Wed, 11 Sep 2024 08:33:53 -0400
X-MC-Unique: 5-2hB0P5OkmnxVKNCfqKxQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so28460725e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058031; x=1726662831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CNOQq4FCPyKHD3scgo6SQA3bN8P0n+b7XCCMQAnvYU=;
 b=wfhILvHQy9IMP4z+LnBG/iwucocASghTEEiOqB2Z1mTy59eC6d8qcAaEgP2z+fuUKc
 kzjVocb7LzS2DCif7iXcJBb3EKhYTsd7HY1eg11I8SuOCWyppiU6oVt65FJi2Q+PAYcJ
 3oWwDZ7xaQChlcHvBVEyzlyXDwgmF3gGKqFLKNaZSL73hxYjDcJ953+04UtbGUZhTtKY
 qDd/jTyFx3Kh1v1FF0u42qOTCejS5qiuBfMwIp3MD2OFe2kwe+WhFbVXKVLNvnVdbGgE
 8GBf4saz+/I1gSsIF8w9ZKfDroFMjPEKSaUZxlToxuAu8sPlHAzGUOZ2gkWcSnehjbjD
 L7IA==
X-Gm-Message-State: AOJu0Yyue+5O+dsklaR7qIvkCyrJfVD3zibEfPJbePN5UOqEKoJr2BCF
 VgfJ7i7pDpBDcITdu8fxBDaRWwQ8xRxIVPvsWMkooFBD3f0rB1dhlY+P3Dl1S5PWA28XzxXKo10
 jgiCj679GcF2X9I/qE0q4NBnYcO6pWXpudU+1GG8C5vSb9FGa9G03o9LatqWK8DUgVQSiBkw2P0
 c9Bia5ueen9qzcE0s6Y30jYQPR/1r0FZuUfd4+rmc=
X-Received: by 2002:a05:600c:1396:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42c9fa0b8b2mr146490905e9.35.1726058031197; 
 Wed, 11 Sep 2024 05:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKOy9OyfO/IWkYn4OlDbzv0wUQp1YhEDUA+b/Z9yzbuZtiMulZ0zLPPkZVgb74xCktmw3Jbg==
X-Received: by 2002:a05:600c:1396:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-42c9fa0b8b2mr146490655e9.35.1726058030697; 
 Wed, 11 Sep 2024 05:33:50 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb30b83sm141316825e9.14.2024.09.11.05.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/17] target/i386: Add VMX control bits for nested FRED support
Date: Wed, 11 Sep 2024 14:33:27 +0200
Message-ID: <20240911123342.339482-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Xin Li (Intel)" <xin@zytor.com>

Add definitions of
  1) VM-exit activate secondary controls bit
  2) VM-entry load FRED bit
which are required to enable nested FRED.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20240807081813.735158-3-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04..31f287cae05 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, NULL,
+            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.46.0


