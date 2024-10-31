Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D8D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZM8-0000v1-FP; Thu, 31 Oct 2024 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZM2-0000QF-0t
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLy-0007MX-BU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6mbwd5mVuHOheuhPwduKLnjqSBNQFGENe6yVIdzQXM=;
 b=fZBxpcGu3oZkI2EhI6s+7IaX3dPy1t74jI1aCH6ur+rCXxnqMz3HZgq1RP4bfUMBqFvAcy
 0FSCc/XSrZED6Kdx5tOgO4O9DP651qjigDWHmpzikFqWazXEm1PnnFeDrh/MZDiK6F5aMe
 DPUPi1zulgi5x6jfM5Jh7VNZTxfigoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-qolOYyK_PwmvhGkLcgKxPQ-1; Thu, 31 Oct 2024 13:52:58 -0400
X-MC-Unique: qolOYyK_PwmvhGkLcgKxPQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5ca5bfc8so583395f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397177; x=1731001977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6mbwd5mVuHOheuhPwduKLnjqSBNQFGENe6yVIdzQXM=;
 b=qZoXvhFch20bKMdhDxZOlzXVihuTiYwdgHDqoGfPpjkZlgfE57tDPXAxw5PAKVmARg
 uR3t1LGDUAcaC52Vl0PPzGVBfr9eIIoONaSQwYx4PJOnEEqEyzilXXl69VZAfCyLz8ff
 aMfCl/WLLuS7AOHJpWmMmWeWDm9HESB8dtkf+S+cwrEh17hXNCveQsIWlVNQ9l8YXhrF
 M939K5VQXlCslQepaVt1pgP9se/9CvzxU+H+wOylUJ524ISq1bHs1fVsVrnd1UooTmn7
 1nbl03CqNdRjcetTH/QFwzsLJKkJRcyqTVKNvzpXf5eUiOcJw4PIGNG5y+OINYvs/smc
 VAeg==
X-Gm-Message-State: AOJu0Yw+lQHdu6IPzWUCTM0FE9A/r8xyVfm3XTjqANzBHVX2v6m57tbh
 1rZiZDJhMgjtvR8PQZB5bVj0ckoEWVRjX9359SdWCBAWCewUpJMhUx1kwbE+01pOXQE4XZt2Cpg
 ClORIBv2R2Ro5goAJLiyk9sExGrzvklGVc/K2rf7D64AWttZ9v3QiLKKP4pT587G40c69vW5E9z
 ++dW0c7DhXKFmMZeAP4G9mBh4Coh6y4hfeV/j05Lw=
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-381be776602mr3707330f8f.17.1730397176985; 
 Thu, 31 Oct 2024 10:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3dmJgtTCYQrEwJ/YrnpVfpEBgm9WkcbNxBr7+blGY2DXxNefPtkpExadaU6sO+orodGPsg==
X-Received: by 2002:a5d:64ae:0:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-381be776602mr3707301f8f.17.1730397176448; 
 Thu, 31 Oct 2024 10:52:56 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685308sm33440155e9.33.2024.10.31.10.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>
Subject: [PULL 18/49] target/i386: Expose bits related to SRSO vulnerability
Date: Thu, 31 Oct 2024 18:51:42 +0100
Message-ID: <20241031175214.214455-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

From: Babu Moger <babu.moger@amd.com>

Add following bits related Speculative Return Stack Overflow (SRSO).
Guests can make use of these bits if supported.

These bits are reported via CPUID Fn8000_0021_EAX.
===================================================================
Bit Feature Description
===================================================================
27  SBPB                Indicates support for the Selective Branch Predictor Barrier.
28  IBPB_BRTYPE         MSR_PRED_CMD[IBPB] flushes all branch type predictions.
29  SRSO_NO             Not vulnerable to SRSO.
30  SRSO_USER_KERNEL_NO Not vulnerable to SRSO at the user-kernel boundary.
===================================================================

Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/dadbd70c38f4e165418d193918a3747bd715c5f4.1729807947.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 14 +++++++++++---
 target/i386/cpu.c |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0dea1ba54a..792518b62d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1015,13 +1015,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
 
 /* Processor ignores nested data breakpoints */
-#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP    (1U << 0)
+#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
-#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE    (1U << 6)
+#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
-#define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
+#define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
+/* Selective Branch Predictor Barrier */
+#define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
+/* IBPB includes branch type prediction flushing */
+#define CPUID_8000_0021_EAX_IBPB_BRTYPE                  (1U << 28)
+/* Not vulnerable to Speculative Return Stack Overflow */
+#define CPUID_8000_0021_EAX_SRSO_NO                      (1U << 29)
+/* Not vulnerable to SRSO at the user-kernel boundary */
+#define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
 /* Performance Monitoring Version 2 */
 #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 846d3a9ef9c..8d4d3d9e3d5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, "sbpb",
-            "ibpb-brtype", NULL, NULL, NULL,
+            "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
-- 
2.47.0


