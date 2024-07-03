Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5BCC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyOo-0005Ow-V2; Wed, 03 Jul 2024 07:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOyOm-0005O8-IS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOyOk-0002E2-Uf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720007021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=06uE3a+8elCE0VpcE4vt/8GwafraE9+Wk9HtMQRUHuk=;
 b=U1JRemjutmYjbenDVyDP9C7ZwNmG8A0y+jVM3wYLE3hBe/Nn5CMkMtYb44OSCEl/+DOCjx
 8syZpUY1wCQA4cgygJJG35xRxFUbs30jCbjSSpWIgZdkNCQIkqpyMXR1bVFIhj5AyL+0Ql
 gJaxPaNMDUQNrrZvoNCwr94Vey8j7ww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-v7JcY52qMcCNn4Jg8ds8xA-1; Wed, 03 Jul 2024 07:43:39 -0400
X-MC-Unique: v7JcY52qMcCNn4Jg8ds8xA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-364b75a8194so3165634f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720007018; x=1720611818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06uE3a+8elCE0VpcE4vt/8GwafraE9+Wk9HtMQRUHuk=;
 b=whEpgLqF3WPD/esc2pWad/48zR7aNlupx9WkC79LZYaNdXJx2hRq5oGux/kzdkLkoo
 UMjtil+evl7zdDpuxaRDaM2DO0I9M7A0zh0/G7xc8NC3Cn/1TGvMcC7J15bnKaRtlP4O
 8iSnqWn6kCRbjrLAY/BIvz/A3BECC5pWfpIdj1hju5A+5yySt5AIG4ozUJCjNULJ2cDv
 64FjMVVn8sm8df5L1d+icWKdrJpM47PX8+3ktrYl2pDCQ+iYtt9RXOZlqBa+FBLfEIKr
 hC0+m/M2Yt2arn3ZSHg/s+gpo1MRfBKlI5gQxJKnQXHF4krhsYUbboiNGQnR164idu5c
 jIFg==
X-Gm-Message-State: AOJu0YwpKJDZBzAqKGC8Bxb9FxbuN0FGc5ytJZNTs6h98is2EdCw2+Fu
 BXl2c9ZMFcoOG6jejkmaIwI7L7Kny/Y6wtPqRFnAoTkrhoRz3NkvgNa4GP2adKi62ua+qIenQRj
 ADk67KNVlh4Hs3SzWfr0doSfXwKg3E6AHH0MBuxwz1nb/DDvc6kGgYw0pjm/rQDAbYPOf02upUt
 GTRa0OqlocjA4fjvl741DyE/pEPn+uGhLkDOTs
X-Received: by 2002:adf:ce8d:0:b0:367:9754:810c with SMTP id
 ffacd0b85a97d-3679754820fmr328292f8f.38.1720007018483; 
 Wed, 03 Jul 2024 04:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3jMnOwBHvF3fSxxw6dJLQ6jy0BqP4YBIgY0ajiiuim05q+8Njmxy+OD43QUP+RPi3+G8cfw==
X-Received: by 2002:adf:ce8d:0:b0:367:9754:810c with SMTP id
 ffacd0b85a97d-3679754820fmr328282f8f.38.1720007018055; 
 Wed, 03 Jul 2024 04:43:38 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb92fsm15793097f8f.88.2024.07.03.04.43.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 04:43:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add avx-vnni-int16 feature
Date: Wed,  3 Jul 2024 13:43:35 +0200
Message-ID: <20240703114335.1657042-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
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

AVX-VNNI-INT16 (CPUID[EAX=7,ECX=1).EDX[10]) is supported by Clearwater
Forest processor, add it to QEMU as it does not need any specific
enablement.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c61270762f..aeee7102af1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1131,7 +1131,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
-            "amx-complex", NULL, NULL, NULL,
+            "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.45.2


