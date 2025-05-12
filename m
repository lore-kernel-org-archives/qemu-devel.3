Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7765C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTi-00062y-9H; Mon, 12 May 2025 15:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTJ-0005U6-Ca
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTI-0007Vo-0U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGD9ZmxNcCJDdey44U3+5fn3gZhvKzO8yYn00qU84Sc=;
 b=EmAWH/CWdX+5ltpZtHgQiAlk+LcqVROtZsBSGOyLghHcKDzFoICoI7F4X/CXATCakXa+9C
 r974h6VLs5T7Gsw7iN3Y49wb4811uRy5/cP0/6yDzoLhMv2yxvnrNX2NS4Wwx71n9bstVt
 va/IjTmE7gCGeb32b/2CEKrE0afIq7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-Brfd5CfhNd-lzwKkMNcLKA-1; Mon, 12 May 2025 15:05:49 -0400
X-MC-Unique: Brfd5CfhNd-lzwKkMNcLKA-1
X-Mimecast-MFC-AGG-ID: Brfd5CfhNd-lzwKkMNcLKA_1747076749
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7ceaa20so1569864f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076748; x=1747681548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGD9ZmxNcCJDdey44U3+5fn3gZhvKzO8yYn00qU84Sc=;
 b=ryb6wjar1oBh2YXyIRH52eMr3KJT8+YUFnL2N82CjUbOo606/OMQ1E/JNk5ZRhd1DS
 b0k202L1adsta/QiBWvL+t/2kpQLaJSMsCOqSjcRqyDIB+yNopdwX+yB08h1m1mDfK6o
 PJnciRHCBYt25pz9K5FIqGRCUj2w+9S7K42QGvuMfs0ld6ZnNHlIBD52sZN7mUiDzW8E
 vxwrn/NFBukYMmPJCelp3P27FY8wckdGVv4q8hMcFrIzMzD0tFfhxG8IB0zijYn5u6Ix
 Yu9lIoOC3WNsb6/TGyPEccKUFkZuGSwKnAZRArkzb/gK0exQ8JT6PKDmZPSpgGUuj/kI
 bA7w==
X-Gm-Message-State: AOJu0Yy6OeL0uG4biGgb+5VgKiN6NaGnvc1tGwljw7du42scm6ycUElW
 ZXEpPxbTwSNR/SHHd1eLLtpYVGr7XvGDJMrZH3cLV+k4ClqqDQ0nnGBgdY98CqN84DZ2GIAjvLC
 ogZY/151a3kpcB9ooEV+J8IfUoq7Ffsg10C5E4OjL8a4AneJ+qHYDwpdspabn67wmBcuxSundQe
 mnAZogj2Qt7pVX/mfaaF7sl2elQNw3QrP9uaiV
X-Gm-Gg: ASbGncvklhPkLXebf22tAeu16k8XwnsIIdqBwiNisXZrEDCQ4x3v9zYXSr5PWR+IqjV
 HMpqo0uuj62N9Mlao62QaGslFqcNdp9Da4fPPAOgkmlvOC8IFKExikIg/hX5vMXHhASq9dzPv4C
 JofZjWsiTWT3hZ/XZoZLbq9M1jHfFtPx+seS0MTEkccQHRuzc6hCO9bRj08NJdXKZUr4ahP8NNh
 8bvbnFsvDM/zmP9DU/K2Fvbyt475uhkctZUAnh070BCjEQhRbMFcgUKtpF8H57amLy4oPzOOpch
 G64lGlmqSFpuTTA=
X-Received: by 2002:a5d:64a8:0:b0:3a0:88b0:b81e with SMTP id
 ffacd0b85a97d-3a1f6488193mr9882387f8f.36.1747076747945; 
 Mon, 12 May 2025 12:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtlPipdmA9t80Nv2LkR1mbqH3dko2FEpqQTsR9doiH6RXhIy/moaMRTNbHTKi1W7X94nIOag==
X-Received: by 2002:a5d:64a8:0:b0:3a0:88b0:b81e with SMTP id
 ffacd0b85a97d-3a1f6488193mr9882372f8f.36.1747076747514; 
 Mon, 12 May 2025 12:05:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2f65sm13638171f8f.55.2025.05.12.12.05.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] target/i386: list TCG-supported features for
 CPUID[80000021h].EAX
Date: Mon, 12 May 2025 21:05:16 +0200
Message-ID: <20250512190524.179419-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ca6307c72e..1656de3dcca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -922,6 +922,17 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_8000_0008_EBX  (CPUID_8000_0008_EBX_XSAVEERPTR | \
           CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_KERNEL_FEATURES)
 
+#if defined CONFIG_USER_ONLY
+#define CPUID_8000_0021_EAX_KERNEL_FEATURES CPUID_8000_0021_EAX_AUTO_IBRS
+#else
+#define CPUID_8000_0021_EAX_KERNEL_FEATURES 0
+#endif
+
+#define TCG_8000_0021_EAX_FEATURES ( \
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP | \
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE | \
+            CPUID_8000_0021_EAX_KERNEL_FEATURES)
+
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -1249,7 +1260,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
-        .tcg_features = 0,
+        .tcg_features = TCG_8000_0021_EAX_FEATURES,
         .unmigratable_flags = 0,
     },
     [FEAT_8000_0021_EBX] = {
-- 
2.49.0


