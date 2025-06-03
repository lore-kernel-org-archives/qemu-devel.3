Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C26C5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSD-0004vP-1y; Tue, 03 Jun 2025 17:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSB-0004um-2l
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS9-00066q-Bc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Czk7eYIkl0e8tYhagcIaK43fy9I0LhvHmm13rULJIgk=;
 b=GYHJMYavO1ZOvN+l7rgWeeEVcePjN9PPh+WZSA+T5KF3WZ49rAX2oz0vkZnzMCCJ9Sr5CH
 KZiOgYry0VWU0exsvr+DH3XkVXsn6DJhWAS1VAi5+p/ajxUeqKWZMkAJHDz9YFfbLWykuY
 9uRYJL8nlQo9MXhoJmGKbxmRGtE0aFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-0ACoAmuhOpWOciLIcBXU3A-1; Tue, 03 Jun 2025 17:45:47 -0400
X-MC-Unique: 0ACoAmuhOpWOciLIcBXU3A-1
X-Mimecast-MFC-AGG-ID: 0ACoAmuhOpWOciLIcBXU3A_1748987146
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so18006475e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987145; x=1749591945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Czk7eYIkl0e8tYhagcIaK43fy9I0LhvHmm13rULJIgk=;
 b=QBZ8egOnt7XE+rVtAKryuXWv+6x7TxNMnMHSrfvYadR15xEYSkk0nCDChCrmx2+fcg
 KsHcBNcoMiT55kBEic3g9UfdKEQ77wbzC6m18YVyQp5k3gvcIBn3aMlZQ1SdwpR2YZnm
 XDYOQe2GaFEN9kXNCTMP/G6w8C1o5bBlV/qSogaRcMEzFyF+JqCkWeqQ/EV84wLUEG0f
 wy58IU/b5bbsmXqhC84nIXz5MGEAqMKzpIhequ57zbm56Gn0z0RwnifDqwu7ju90TSCH
 3BzTIqUJy+v8eEUeZLeD/m0Rnnf4+qdrQWw3zzpvRpa6haF7vMd9kxxQjiNmRTK5K/zO
 Fvag==
X-Gm-Message-State: AOJu0YztrLxrBxCIvHu5sfE28jB9qxMmSnw2N7TwuTBZcuoMt2XNplSU
 jDxR52rMGMaQQF+Ko8Xo6OJWI3B910H6SUMPqkVyBTB+DQCVQYcLb290GvcyBmtJs7Il9bjVwVd
 0ZpU9SrbyeV4P0049viBDvsLvXHV8bATaHZtKg+JqCWz82syhJd+VRwV8Tg1IfNsSpMyxo0w5/z
 +OET2N/gSFuCMMf1MgDccc7cQ74kWW8YmAHKVfz/jX
X-Gm-Gg: ASbGnctuKzDhi6zFBYKligLr+yp3oRQW29aSbjFSOFu495V8XEB3HK+iarUjw8q5gMN
 EpFCpnsLQBgTCeiwBMTP2I5JUp+z+Cg1k3PneT7Sgi9uLXM8V3ztTTvvKMjX/mj+FnwRfwmzrhA
 OIt8pKPHPa7MUx0uQqdIwE4/gFHqrVhuFHmv/kMP6kFor0/pHHXO6RQ1eb4CxxWcur+k1bJ7LFb
 uTSpd7QraH8QUMrJmzCgEPafn9fqntk+g9OpQRjRy4WPrua1+wZkNktFUgLs8MNKAUkqDT4rj0y
 JRB6sodsmqezlQ==
X-Received: by 2002:a05:600c:3e88:b0:450:d611:eb95 with SMTP id
 5b1f17b1804b1-451f0b269a4mr2338545e9.17.1748987144699; 
 Tue, 03 Jun 2025 14:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJcpbCGkTlpfwIgMeLBa1+N843BANS51fT9DgWrixdHqhGdSavvT492J0m9go4C5EdLw5NA==
X-Received: by 2002:a05:600c:3e88:b0:450:d611:eb95 with SMTP id
 5b1f17b1804b1-451f0b269a4mr2338435e9.17.1748987144247; 
 Tue, 03 Jun 2025 14:45:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2333sm173988585e9.11.2025.06.03.14.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 09/16] target/i386: Add a new CPU feature word for CPUID.7.1.ECX
Date: Tue,  3 Jun 2025 23:45:16 +0200
Message-ID: <20250603214523.131185-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: "Xin Li (Intel)" <xin@zytor.com>

The immediate form of MSR access instructions will use this new CPU
feature word.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20250103084827.1820007-3-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/cpu.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1146465c8c6..0ec1cbd9f43 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -668,6 +668,7 @@ typedef enum FeatureWord {
     FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX ATTRIBUTES[31:0]) */
     FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
+    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 73403505c5d..b05f465e2ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -900,6 +900,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
+#define TCG_7_1_ECX_FEATURES 0
 #define TCG_7_1_EDX_FEATURES 0
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
@@ -1150,6 +1151,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
     },
+    [FEAT_7_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_7_1_ECX_FEATURES,
+    },
     [FEAT_7_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7442,9 +7462,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
+            *ecx = env->features[FEAT_7_1_ECX];
             *edx = env->features[FEAT_7_1_EDX];
             *ebx = 0;
-            *ecx = 0;
         } else if (count == 2) {
             *edx = env->features[FEAT_7_2_EDX];
             *eax = 0;
@@ -8349,6 +8369,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
-- 
2.49.0


