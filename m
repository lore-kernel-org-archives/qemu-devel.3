Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D7C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoI-0006dc-GW; Fri, 20 Jun 2025 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoG-0006dA-5n
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoE-0000JI-K4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZx4yG+bgFU4rtof6aU8LdU/H0Zr1YZu+nqmlHjr8Lw=;
 b=jOuL92yMPGlFBf1mpVZFPOi/rbFlfCeVYpZHuCQJDXPy5jDdMRNFtfqyrx4yfDBjNpIT1d
 NZalqaCOCV7VaOPYe57iUGM1oWYbHMYdgZplPvUfQI3uJeeD4uBQQaiAJnJDBOhbWDCBeg
 ibgoWFsRR2dGkCu+spE+4VxFLjs4ufk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-2rrVtwjHPdCnqRqTUJ10Cw-1; Fri, 20 Jun 2025 12:41:44 -0400
X-MC-Unique: 2rrVtwjHPdCnqRqTUJ10Cw-1
X-Mimecast-MFC-AGG-ID: 2rrVtwjHPdCnqRqTUJ10Cw_1750437703
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae066127959so30851966b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437702; x=1751042502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZx4yG+bgFU4rtof6aU8LdU/H0Zr1YZu+nqmlHjr8Lw=;
 b=MO+hDbDLMsxqP1p8iR6nirIfaUWe4/EbpBpUPbdiTxZST0iGQ+LqnXRc71soVs7R3X
 WA8rERWvJlSQuZwx2zr74mPjiGreijtpVJLlyBTkHKFR/yL/6dw7bDR5JA5g9rD3xnfU
 mDPXLKS/PhgrwCfEAAVYdEUoGuzjJUx1sWi2yO9dBdWU7s94gIkk+lblW0O9E/JAO9XZ
 3nioj3+T1JL0RyTrnpNtZr+Uux+Xpt6tYFGwFkklFtqYXUBbN1pDtbYdWxdpKa34RUCT
 kUz8Ys5zDBDv3grWo7CNXyLwEP8MamT5nAjsQbly67C6hqjpu6p6itkPPbqH8XKSznUo
 rsJQ==
X-Gm-Message-State: AOJu0YxUnOzeoSbh7Y6l5+kWJ90/YhtpNx3ZKx4evB63H3D5mfJ33BEm
 CQP4WEZdXDbBcfpwH7OdGStpp+5TOuQ+xXGBoHGYFERrmZcMcjVmn7avhBOVzlvykpFfDm+lQAm
 s1hGKdLLVtm3n/G5+C9ZST2uWgpLMroaBVX2HCN2+g9bpgEzxMZDCK4g+MugZX8AakrtafWfRW3
 bYh4ipUJ2h7X1Edw5AwAH2Rbhjk6kS7V2KY5SB4QuW
X-Gm-Gg: ASbGncuxhLFsTmlqqpDAffBR1UDUIY3sm4gEp1nW2Iqb/QfeiZFxwijYJ98f7HQHZZa
 v3ij/cn5t68+VSLH8/T8nk2eAm2a2C8b45eNCmRHazit3Dz5BuZFxGWSuVcr6N4GXO3GsX/v8/m
 HEXcKB1YDmJV9Rm0FJvD1Gc1YQmSOXaUbE8KS2yZqtQnqpHXaHeAmD5FVofXoHSKYxpYOW7K4mQ
 Kp2caj0w1pUDzJusyleueB6xmyFfiM24CJDMP2emR1TbUPkdYH5UXBSsqBrO31EPux7jLHA2NE/
 LFUevdsrU3xLozNNBaaRnxBGnQ==
X-Received: by 2002:a17:907:6088:b0:ade:399c:7a9 with SMTP id
 a640c23a62f3a-ae057b9257cmr343559966b.37.1750437702456; 
 Fri, 20 Jun 2025 09:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8+OBMPOBFVCBBwUMWd9zIIlTFFoDLwZwTaAAO1YsR6OGyHRodWtZRBIyDDwqFZaa1pxE2OQ==
X-Received: by 2002:a17:907:6088:b0:ade:399c:7a9 with SMTP id
 a640c23a62f3a-ae057b9257cmr343557666b.37.1750437702017; 
 Fri, 20 Jun 2025 09:41:42 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054083bb4sm186360466b.107.2025.06.20.09.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 17/24] i386/cpu: Warn about why CPUID_EXT_PDCM is not available
Date: Fri, 20 Jun 2025 18:40:45 +0200
Message-ID: <20250620164053.579416-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
a warning to inform the user.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 29bce67c3a1..0d35e95430f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8339,6 +8339,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     }
 
     if (!cpu->enable_pmu) {
+        mark_unavailable_features(cpu, FEAT_1_ECX,
+                                  env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
+                                  "This feature is not available due to PMU being disabled");
         env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
     }
 
-- 
2.49.0


