Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBEAC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSI-0004w8-Il; Tue, 03 Jun 2025 17:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSD-0004vS-Fo
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSB-000674-Op
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZwngO2l7V1Fr528pWV5WtDvi4S3hP0kwMZlpkoq8II=;
 b=RzxpuFNhLky+vHGBHLe2w0jak4CdbbggQB/sdHYqUndfIl/HXIZYfcylKF3IkAuyJRTg+2
 I9fORQx4yDKDHrxQCgeUEXTfo86NJlpMheqnmYN5HFWv4tJd7DH3gV3QLeQ4qq1R5+E7ef
 sDb3ru9ONGQqdEH+Miv26/+lrpFVw+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-R8d8OfhTPy6wL5cB2oGm-g-1; Tue, 03 Jun 2025 17:45:49 -0400
X-MC-Unique: R8d8OfhTPy6wL5cB2oGm-g-1
X-Mimecast-MFC-AGG-ID: R8d8OfhTPy6wL5cB2oGm-g_1748987149
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d64026baso25848935e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987148; x=1749591948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZwngO2l7V1Fr528pWV5WtDvi4S3hP0kwMZlpkoq8II=;
 b=pf6OGmqyZqfvjX5n7Pj1Auj+pva0ZdxFAijBdknetB5Pf8R147CMLiR0skXRX8IjWw
 QMR8csC817CMACdphg1HXvk91sMaBhVhrIGLDepGPAne7nxVCyGWiKm5LjjPgsAKOZaQ
 GQR7kO5GTw8+/rKID/sLXOGBrkx6iKOWRzfChSqJmIREo1z2ZUkBPMd+qizibTOIqoPQ
 3NMbNNnO4426ZORMKbhiCHMSecHGj7OMDC0bNaQY3su9GIi1jo76LrZjR5DTmmydSumZ
 EiYRSabZTPPyyHoRQ8lSgW/728jdtqFwJRm6EPQxjZdv/T8MEEL6tifetUZk4oI+uS+1
 8DUw==
X-Gm-Message-State: AOJu0Yy8Ze9484R24ncipNwMilGQeRtJbhOTXghSctjtn7YuhwG4SiE9
 XUuZJHIkUcNuNVGeYgmCOgz5S9JE0bLiVvsu+mGtp37bjA1neLKiNYEuZkzxdbkNvAExTcb4YBX
 bt/allp0XYkRqRS2XaKye1JshDhPttpLKtAw+1RK4tBytWL0N0bLk5ilE1ZKbZNsD7OeVgqLWPn
 ACHlKF0oz75pAOhRRsY8/LHXAcscrssdOp7ZxanmVv
X-Gm-Gg: ASbGncuO0JvEBVNdtHRuRWCx0ZSpRf6P4sf50+nNy9yzDozy00NnLDFHyDBQ3Ym871l
 1xePemkSwib8Hm1sLngXzH2CFT45yO2O3xehiB/188IyZSTxzd72BQoYXNYHzAVz9gC7VhwjsVX
 aAgY8jLPNOYb52C4gTDOQjscXBDQJJLrIXqbEksMW7JpH/Yg+A9obdTkyMr4yB0lNVm2dlCe/TQ
 pNL6Y0qxNxp9xAGlgAUiDOywnVp/YsV8gjUA/qvv4Eff11qbUFDxjKLZc7fABOpL+bYZJ/gxhQz
 U7yDDOS+WjjtTA==
X-Received: by 2002:a05:600c:818c:b0:451:edc8:7806 with SMTP id
 5b1f17b1804b1-451f0b3fff4mr1969115e9.32.1748987147792; 
 Tue, 03 Jun 2025 14:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd0rV0rQowl7bEY4Igg1+11+ILXkV8SDkPcuoXEDrP4Dcma6WICn4f/pVQL6GgEodoxsZE+g==
X-Received: by 2002:a05:600c:818c:b0:451:edc8:7806 with SMTP id
 5b1f17b1804b1-451f0b3fff4mr1968965e9.32.1748987147415; 
 Tue, 03 Jun 2025 14:45:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972b5sm19608575f8f.76.2025.06.03.14.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 10/16] target/i386: Add the immediate form MSR access
 instruction support
Date: Tue,  3 Jun 2025 23:45:17 +0200
Message-ID: <20250603214523.131185-11-pbonzini@redhat.com>
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

The immediate form of MSR access instructions are primarily motivated by
performance, not code size: by having the MSR number in an immediate, it
is available *much* earlier in the pipeline, which allows the hardware
much more leeway about how a particular MSR is handled.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Link: https://lore.kernel.org/r/20250103084827.1820007-4-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 4 ++++
 target/i386/cpu.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0ec1cbd9f43..545851cbde1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,6 +1001,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Linear Address Masking */
 #define CPUID_7_1_EAX_LAM               (1U << 26)
 
+/* The immediate form of MSR access instructions */
+#define CPUID_7_1_ECX_MSR_IMM           (1U << 5)
+
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
 /* AVX NE CONVERT Instructions */
@@ -1024,6 +1027,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_2_EDX_DDPD_U            (1U << 3)
 /* Indicate bit 10 of the IA32_SPEC_CTRL MSR is supported */
 #define CPUID_7_2_EDX_BHI_CTRL          (1U << 4)
+
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b05f465e2ef..40aefb38f6d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "msr-imm", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.49.0


