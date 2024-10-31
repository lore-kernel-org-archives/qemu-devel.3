Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A999ED767F8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZM4-0000Yi-JD; Thu, 31 Oct 2024 13:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLv-0000EA-CC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLt-0007KC-R8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpiS+KiNNyocJM5727DUTMhKbqIwBGE9ctY55O9ci58=;
 b=fCoiaHJJKxHgn71W/iPCGkTmS+ixm4C1DgJfqHI1KXYYXtdzgm9dDL/D3tlbVak3XTFDbw
 /NEqa+8i3cBXPSDDcwUEljHARHBU0tQWehCSxQfaV5jDwZstlabZVBA/dA878D+8WukFy4
 U0qslu1JjJLl/HhWwI2D1qDYCx/wq64=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-oCa4fALrNrqw0TC_4CFt5A-1; Thu, 31 Oct 2024 13:52:55 -0400
X-MC-Unique: oCa4fALrNrqw0TC_4CFt5A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539ec1a590fso1021422e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397174; x=1731001974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpiS+KiNNyocJM5727DUTMhKbqIwBGE9ctY55O9ci58=;
 b=rCOWlS9+jqDPc/XQZ9xUeLDS2gIXwtQSKYqg5HNQhAb1GFQsqSc9S4VU4g5piTDOCv
 7xZl4WDOjgodljaTA9jCdhmRKixLwfvnmfN96+DMWIxyImfkNdwO5vOuh3mpbXpn8d1e
 BrfhE70UQhWdha8rVPWfazi6p+vBbLqxTePd0jlCNflDbPJ7oEt2KIHa1UrY/dzpRxiY
 d+UU0no93d5uX7wUrbHAu9NjEGFN189unDEFR5OhUUT1M3UGGzmv1pSlHCq85RgJnVbA
 hOW/JTRNcum29SkOTVQ4VmqWbbrpHrra2Jsie1zE6hn22PhA5MWClVT+P8UtKAzU4HDx
 qVkQ==
X-Gm-Message-State: AOJu0Yx5k6rSJ4P+lCNph+MHr0/i5YINeMTnsLr5W2R2qelzn2T+weeV
 EUf47zt82YNywmnTH6VFRblSsbHcCw/B6VcBocPs/AJ1DLWksVfKF/efwxMjMv0P+u6BUgjVoTj
 fei9WOGDVYAMX0FeL6X7c+wq551ja2uwV1R9LK+S4RI0J9mA79Jll7qOEHL8xaQSHaBH3ED/QLZ
 dPoaeT7EQCBM/YCli8W9vvG5GcbeGHkieQWrIQlxU=
X-Received: by 2002:a05:6512:3f0c:b0:53b:1369:fcf8 with SMTP id
 2adb3069b0e04-53b348f96e8mr10899435e87.15.1730397172324; 
 Thu, 31 Oct 2024 10:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwbJA4137dp2Sc2D3hAYP1y+mVnSFK2dyKTePpGMInfTY4234jZwc1i8B0a+YxVuDXyNgb4g==
X-Received: by 2002:a05:6512:3f0c:b0:53b:1369:fcf8 with SMTP id
 2adb3069b0e04-53b348f96e8mr10899420e87.15.1730397171824; 
 Thu, 31 Oct 2024 10:52:51 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca747sm64005985e9.45.2024.10.31.10.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>
Subject: [PULL 16/49] target/i386: Fix minor typo in NO_NESTED_DATA_BP feature
 bit
Date: Thu, 31 Oct 2024 18:51:40 +0100
Message-ID: <20241031175214.214455-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Rename CPUID_8000_0021_EAX_No_NESTED_DATA_BP to
       CPUID_8000_0021_EAX_NO_NESTED_DATA_BP.

No functional change intended.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/a6749acd125670d3930f4ca31736a91b1d965f2f.1729807947.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580f..9eb45faa654 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1014,7 +1014,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
 
 /* Processor ignores nested data breakpoints */
-#define CPUID_8000_0021_EAX_No_NESTED_DATA_BP    (1U << 0)
+#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP    (1U << 0)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
 /* Null Selector Clears Base */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032ea..94faff83cd8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5226,7 +5226,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
             CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
         .features[FEAT_8000_0021_EAX] =
-            CPUID_8000_0021_EAX_No_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
             CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
             CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
             CPUID_8000_0021_EAX_AUTO_IBRS,
-- 
2.47.0


