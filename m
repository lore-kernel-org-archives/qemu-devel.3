Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF9C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCztg-0004li-Dt; Thu, 08 May 2025 07:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCztd-0004iD-3b
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCztb-0007ty-JS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746705514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NGD9ZmxNcCJDdey44U3+5fn3gZhvKzO8yYn00qU84Sc=;
 b=FTgW/fAg/aTflsk641p8Fc0W8d+W1jPh8EPTSQXV0WF/KipHJ1T4RP1JEGPuG5XsrYhKuE
 nJPtn4H2ITlaVhHzWitEViu+pyHbKSZVpHOB5oMfKmzcpfQ9pWajyCTwj627HV4TGfOabZ
 czx9ZoR0C5/4tVDdLUtBOXuYfychuKg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-uzeJaM5pNQi9X0M_M0u-0Q-1; Thu, 08 May 2025 07:58:32 -0400
X-MC-Unique: uzeJaM5pNQi9X0M_M0u-0Q-1
X-Mimecast-MFC-AGG-ID: uzeJaM5pNQi9X0M_M0u-0Q_1746705511
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ee54d5a00so388565f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746705511; x=1747310311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NGD9ZmxNcCJDdey44U3+5fn3gZhvKzO8yYn00qU84Sc=;
 b=NZvxLPQd7CnYFIY9Uw7LiGq7l5lJe663mCKOo+k5Umtxv9NcvqTcyQZtfMBpczM3Dg
 yo0Fhk4cJzmtQasEgzNohIbxqr7HbhpAvJJ/08vFBquO6NyopcoH9yQY5IDLkYeaU1zh
 FdDXXeOcbyfYZqHQ4PIrBZifwQvPv9sZp/oj2NtlnaFBa0tSYHGQZZL1xr79ZV6QTZXV
 ZgzoQWbGPcksa139GGrcyIAHg5xsywlByFGCC48H5G7qMIPfwSrap3x0FKJzQHSxb+OD
 tMsQFn9WW+/JE+EW+1HsFpP3Ri2UXaAm/Dr00QUsc/g9NJfwaCETSTMmKN+WTOsuxlaj
 Ew3w==
X-Gm-Message-State: AOJu0YwXKLk2y5WdUdMvXnRg3vGjMS+GS++11h9Otr5Bb5Mp+PW3AEMX
 8hbg/CtZb4gequtI+fbXsQquR4HYR8fSR5lW9WYaCGuAPoQBFyzN92mdCfyYvViowkHJbhgujnx
 3Px+iOU1y0ihYaR0dMgeiXZ05fUlRSmlQauhzE40V61anUGTT8FM9E75YDMTFP6qnHIEm56Ffqo
 5lbZ3jW5Ch47cpqdqwrePkawQ5CBWGtR5N88Kl
X-Gm-Gg: ASbGncsUKjYdjzx+Eio7jN7kQhtzPBiE2yHMZ9cLZc3XuaJshLt7ks07kwhtabZITc3
 3nOJL7gaXfspGiU1e3hpXM6vqkYtWs/PdMqMIHR5iT063F/fk1njl6WBqBZT+T2zXhZ740pQOSg
 sY4xRG8PQUHmJYgrW1B5Q+gZS/ZXNIMPhFEVN1KW+K1zlNh4k8NJEAw3iTu2eINiIXo3HPTeKjw
 6IBWU15AvDz/h3widZnaI08rxAG5jItXhBFdveJjasxxKrCizpq+VTsipni/XRG3QNGeKbmLYf5
 d9ApQJdOLs6V4lU=
X-Received: by 2002:a05:6000:22ca:b0:3a0:b8b0:440e with SMTP id
 ffacd0b85a97d-3a0b8b0462dmr3715889f8f.45.1746705510973; 
 Thu, 08 May 2025 04:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAxVrHcDoX/4jHVERk0WVkrHTMy0iNepc5pRMnWW4/W1rp8d7yaVl88XZqqqp5fIiRqOZwNw==
X-Received: by 2002:a05:6000:22ca:b0:3a0:b8b0:440e with SMTP id
 ffacd0b85a97d-3a0b8b0462dmr3715870f8f.45.1746705510521; 
 Thu, 08 May 2025 04:58:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b55d2a1dsm5634821f8f.11.2025.05.08.04.58.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:58:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: list TCG-supported features for
 CPUID[80000021h].EAX
Date: Thu,  8 May 2025 13:58:29 +0200
Message-ID: <20250508115829.485421-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


