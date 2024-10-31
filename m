Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26FAD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLf-0007Tu-Um; Thu, 31 Oct 2024 13:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLe-0007N9-5p
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLc-0007Eg-K3
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy9bORYpCijIRXD12pq3hathdMu3AKwAgv2Oft99Il0=;
 b=N+v7x2lSX5pk7kkqmTNgZyQN24VtzDA+io3ZWb/5M36fc0lJJ3+QBNTnnTIUrT/MW4NVme
 mQ8f2EVdxIDdzb+3c36NQgGr941NO8h8aNgVvgTSDyNDuRBvkIthBvZE3ntoXOI57mPqPm
 h4pkjGyYFge7kZ48a3w4dkqaA9ipMCM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-L3Oqr0K3NZG82ZA_nuZmGg-1; Thu, 31 Oct 2024 13:52:38 -0400
X-MC-Unique: L3Oqr0K3NZG82ZA_nuZmGg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso7225915e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397156; x=1731001956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yy9bORYpCijIRXD12pq3hathdMu3AKwAgv2Oft99Il0=;
 b=HzHWXxuZpZbHAlV7Sp624TbUMdmklG7NLbXQY4BY2g/EWZgIMUabu7S2C5bTxEsElr
 JCRm8cNQkMFBUPtRDz2fUhIy+UTyufC6RdtfXWaNg4ZrAtE4Kc43HqklAapw0GuhKEQN
 peZ5XarCl5vDpWKaoW2V+nXWF5RktXPRevlqbdnDAqCx2j/8WDSdCgeS71Kz5zy/PpiA
 UlhFrmDpeNE3WsNbPj7ezpr0mfE/PAjjeU/I1mEzcsFpm7CY/SPK3i2iIdbRbJwgF0Ys
 aRUb/1OCXTTXOTn5phgv77UmiENnx8sjsq6UI+M8qWzgNJDj9SkOMN5S5qfJ3IfCckS8
 tsvA==
X-Gm-Message-State: AOJu0YyCHrow8Lv0fb7i5uOM+KW8COVzpUv7yTpLfJKPC7wcvSi3E3KL
 /SmIWZYmFQo6ujr0FzhxO48Wb24cqzJRP3Fm0CNox48uVQl2ntJE3Uq/WIsk06XPhCpuz009W/m
 eTNIY56aKrnHzSOzBqC6Q1yuP+gfE4W8DcDK36DIHtvFVLsOK+bryTJnJVIj/lUqOS5+1R1+4JT
 7tNn1jcTS7NkV1YSONu4xNlNfMJ3BKiYoDzHop9lM=
X-Received: by 2002:a05:600c:3b14:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-4319ac6fb0amr171446505e9.4.1730397156165; 
 Thu, 31 Oct 2024 10:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM0FjCyxkL3mu4e2caFPVYkosfEO3X7QBTE+vQYFmLazsceaifmSGvYbqd6l7I8WexkcOdSg==
X-Received: by 2002:a05:600c:3b14:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-4319ac6fb0amr171446285e9.4.1730397155815; 
 Thu, 31 Oct 2024 10:52:35 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116b181sm2762993f8f.107.2024.10.31.10.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/49] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
Date: Thu, 31 Oct 2024 18:51:34 +0100
Message-ID: <20241031175214.214455-11-pbonzini@redhat.com>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The check of cpu->phys_bits to be in range between
[32, TARGET_PHYS_ADDR_SPACE_BITS] in host_cpu_realizefn()
is duplicated with check in x86_cpu_realizefn().

Since the ckeck in x86_cpu_realizefn() is called later and can cover all
the x86 cases. Remove the one in host_cpu_realizefn().

Opportunistically adjust cpu->phys_bits directly in
host_cpu_adjust_phys_bits(), which matches more with the function name.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20240929085747.2023198-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 8b8bf5afecc..03b9d1b169a 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -42,7 +42,7 @@ static uint32_t host_cpu_phys_bits(void)
     return host_phys_bits;
 }
 
-static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
+static void host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
     uint32_t phys_bits = cpu->phys_bits;
@@ -66,7 +66,7 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
         }
     }
 
-    return phys_bits;
+    cpu->phys_bits = phys_bits;
 }
 
 bool host_cpu_realizefn(CPUState *cs, Error **errp)
@@ -75,17 +75,7 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
     CPUX86State *env = &cpu->env;
 
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
-
-        if (phys_bits &&
-            (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
-             phys_bits < 32)) {
-            error_setg(errp, "phys-bits should be between 32 and %u "
-                       " (but is %u)",
-                       TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
-            return false;
-        }
-        cpu->phys_bits = phys_bits;
+        host_cpu_adjust_phys_bits(cpu);
     }
     return true;
 }
-- 
2.47.0


