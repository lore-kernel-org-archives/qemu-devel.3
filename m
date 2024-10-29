Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6405DD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0c-0006uk-CR; Tue, 29 Oct 2024 11:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5nzx-0005X3-Mh
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5nzw-0000Oq-B8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmjj7j2upwlaHs7IvJz1blz9Nv2Vqs0ImMRiMwgLbLk=;
 b=XaX7+VewELo8SSAALzPIanxZ9005rxESw1HnT1aMwVfgVFT/xaWFKjrIZbrkOxJgrsyUBs
 LGBGFbD2dX3L6q0HTAMUO6/qu38n+UuDVNi6AtgVPv3QbaOh4oOiGv+6UmqN+LJz65SIRj
 VyGpkdqHjZka9ho/kc241eQwHPKbz20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-WB-qGcTgOSq_GqW3ASEyoA-1; Tue, 29 Oct 2024 11:19:06 -0400
X-MC-Unique: WB-qGcTgOSq_GqW3ASEyoA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso37172115e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215143; x=1730819943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmjj7j2upwlaHs7IvJz1blz9Nv2Vqs0ImMRiMwgLbLk=;
 b=r95BQQyCXLPOlraSP5MVSpk6JIeGun8FTWQxGRsGU3/cBhhn2RANTjivZgUcJJPzyj
 scMBVz1hKqOmQZLaImpaSHgzNpk9iitrT/OtUBLlS8IFQgWzB5GALd7s/aYLkUl/ZUuc
 tohTcHv7qJ2L1r/omXfyInlmSU575gMT+anZyktPnPzIwpWJwyfjRVVYqUyzDEJywP9E
 2+GcFR9gloInLmXsPU2H5vkb51YvLjlFahU17h0f88etyjo6+pZDjBpUVCfE2cuZMoRn
 uTpBdPPYnF5TtlsMa9Bc6ump0fa0cLRc4C6PsQNTHQaUuT/l0WwRt14u8W5rr5XMENDy
 t8ng==
X-Gm-Message-State: AOJu0YwIn9j/RFFGykD2Fa1cbXuCOqRrV0OJC3wZgdxApgWfCg3+DPDf
 HHluz/I3I6j5afYtl0OM56PKCjUATRCD52bVZfaOc09Ww27wIe7ykLrC+FH/2UaDewwQqKpSWLe
 /0rHDH+cmFXVOWeMqXIvT7PgsUeG/0mpoHhEkXMxR8SZydMVHNG/pdEFmrzM+QNTDb2gsVvqUUB
 DNJBRsemf0Xjsk4G8wGxG7YC7sSu5ozM07NBgrTl8=
X-Received: by 2002:a05:600c:4e91:b0:431:54f3:11af with SMTP id
 5b1f17b1804b1-4319ad2103emr95091545e9.31.1730215143084; 
 Tue, 29 Oct 2024 08:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW1QCg7TiuyBlyPBi6p8Zdn9CMlnu+h38IwmZrwi4KsriZB8mPnNJH7WBdwXd8ggdn996epQ==
X-Received: by 2002:a05:600c:4e91:b0:431:54f3:11af with SMTP id
 5b1f17b1804b1-4319ad2103emr95091325e9.31.1730215142685; 
 Tue, 29 Oct 2024 08:19:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3c625sm12830442f8f.37.2024.10.29.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 1/8] target/i386: cpu: set correct supported XCR0 features for
 TCG
Date: Tue, 29 Oct 2024 16:18:51 +0100
Message-ID: <20241029151858.550269-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5886b44fcf7..f08e9b8f1bc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1318,7 +1318,9 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EAX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
+            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
+            XSTATE_PKRU_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -1331,7 +1333,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EDX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = 0U,
     },
     /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
-- 
2.47.0


