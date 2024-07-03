Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38065C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxSN-0008Le-2i; Wed, 03 Jul 2024 06:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxSL-0008LO-NC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxSJ-0002eB-2T
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720003397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oseQ60e5wmgH0ZYm/I14i7Pkbsm8+uJkxNMnBtHXQnA=;
 b=WZQssXeWEPrSOjQ7FEH1qTAM8N6TVTsqyJfxhGhTsBlzGrQNRT3jzomQTj06Y8R4ljS/WC
 AGy7IYALEvZlVLQBtUpmSPwWXl+bhMN7YHU3B3PfZ9lm31ggGsEpd9kWJrXVA01tjpV4he
 iup5d5f/2vdV7FDbphPjgUrI3uefptw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-6mpm0oXiNgiYRnwqSGLlPQ-1; Wed, 03 Jul 2024 06:43:15 -0400
X-MC-Unique: 6mpm0oXiNgiYRnwqSGLlPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42565672e0aso2870645e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720003394; x=1720608194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oseQ60e5wmgH0ZYm/I14i7Pkbsm8+uJkxNMnBtHXQnA=;
 b=EvSaQidRMkIGJ4N/mmxbnfCCI4rnrVleinJR28kPhpkXpO3PQNnPHJXIpaTguKTUML
 YZJ0YKDW8I3gjBzsv5CxfU5wsY1eA/Z7NFsx8rkqjAIDPNCWvYN44AUggvUKqZdG+C9M
 YMTQazAJdK8T7R8FA88zJ71G9JeIyEEmvV2DUKhzwxmMatTLtaCfRZK29Tpa5rFgMS2c
 TDnNVFKXNx32twX1cih9/ECkDtUgLPXjtZZ1AL4XJOV3KTBLRR84+82irNXuDRwv9JGh
 nSCwGttMLpoH61mWf6KPd4O0Dex/s3wWzhN2NNp4AOang37XEol6VAx/ciqinHDVfH0S
 V5Nw==
X-Gm-Message-State: AOJu0YwcSebXg96B+YdXloNPBXnODQkwtOlEjpxUbY/r4kx1XRzNd8Nf
 0Q28eZjocX0DEEtg/LlI0b2PrK7PLVna6P1gVV+X/YqakrJoC2CoZbrV7KcLBQreQ/UIG9yKnVF
 clv8S0NagiXN3zBNDjas+ZQIF69MflRPBZHwz67vHjvV0HDc80TfBjrL8qXbsDe6jWZMlz8PQpv
 exFMZWpAARW9qDhvjSXGntGmfx+A0U4egh1Y6U
X-Received: by 2002:a05:600c:5106:b0:424:86aa:b7e7 with SMTP id
 5b1f17b1804b1-42640914d1fmr13175695e9.9.1720003393993; 
 Wed, 03 Jul 2024 03:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5TKI55xriN+xEbVHEfhsraTS0wOn5l8z9QEAQe62aQruh/CyRQsAx1rG/N12ZFH/ir+Xyg==
X-Received: by 2002:a05:600c:5106:b0:424:86aa:b7e7 with SMTP id
 5b1f17b1804b1-42640914d1fmr13175495e9.9.1720003393622; 
 Wed, 03 Jul 2024 03:43:13 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af38a0asm237721405e9.1.2024.07.03.03.43.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:43:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: SEV: fix formatting of CPUID mismatch message
Date: Wed,  3 Jul 2024 12:43:12 +0200
Message-ID: <20240703104312.1642361-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Fixes: 70943ad8e4d ("i386/sev: Add support for SNP CPUID validation", 2024-06-05)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3ab8b3c28b7..2a0f94d390d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -841,7 +841,7 @@ sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
     size_t i;
 
     if (old->count != new->count) {
-        error_report("SEV-SNP: CPUID validation failed due to count mismatch,"
+        error_report("SEV-SNP: CPUID validation failed due to count mismatch, "
                      "provided: %d, expected: %d", old->count, new->count);
         return;
     }
@@ -853,8 +853,8 @@ sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
         new_func = &new->entries[i];
 
         if (memcmp(old_func, new_func, sizeof(SnpCpuidFunc))) {
-            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x"
-                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x"
+            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x, "
+                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x, "
                          "expected: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x",
                          old_func->eax_in, old_func->ecx_in,
                          old_func->eax, old_func->ebx, old_func->ecx, old_func->edx,
-- 
2.45.2


