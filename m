Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288AAC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu0f-0000sY-2Q; Fri, 30 May 2025 03:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxv-0004Z6-1Q
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxq-0007G1-5x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8J3cKYky+YvibPH8//zXLa9CJRE/+9JtZ6ufyQAxg+g=;
 b=ST9GoMLrt5WC1ZbB8VdEbU5+2uluUemp5++vSeX091gKZrqmLNiQJW8x2XLr6VWjc4KsDz
 k3jK6RQoKP0EPize/M4SASsgLtTspgR09uwyiVU1+r8ybsQ3so+4isuVcrAuzBFgBDihGf
 gVcRKO20ZCz8hgdTLX5NL4O+7MoaT4k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-W46PlixQO8GlqCeXEucuBw-1; Fri, 30 May 2025 03:15:35 -0400
X-MC-Unique: W46PlixQO8GlqCeXEucuBw-1
X-Mimecast-MFC-AGG-ID: W46PlixQO8GlqCeXEucuBw_1748589334
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6045c7d93edso1360231a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589333; x=1749194133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J3cKYky+YvibPH8//zXLa9CJRE/+9JtZ6ufyQAxg+g=;
 b=ga/mank9QtoNhrBQzVN2yAYAcVSuFdu0PLpXK7vqlfKGb/i3JtI7kMmQjROD84IrVK
 9B/GCq2M+1Q7OKaywT9cEYm+629z2vfvfkicSAPuDLXv0DgZMQm2oPHWVHXvRYPfhfbs
 vcFENEDZm3hIYymLFgzvfv5eA7doTcOBBFh3/KjD9DP1SusikJXPmsPEd22oHfyYWfE7
 qCRfpdtwhscS/aejVRSpEAc5uILaSQ0wd+Ge8aHISbehLuKt9DmCQyf1rM0rP2OgCA1F
 MgQ+V+7gnKEKwiQwEfu0vZY98Tz0PQHGxbz/bAu+MEc90pw50CKLdDIsHqHIqqDp4rnM
 /Cpg==
X-Gm-Message-State: AOJu0YwcxZNwx9kwjOhRBJl2QLuvedhXI0h2QfuLclP7n8QUdWUoU2OJ
 1UEkIjnWxuAeMFwHTuun+j7oInfAj1mVwjp42DuIZK2ktvVo6X/ieIcJ8U7MTjTVrRsE/+/8wK4
 iPtOobT9oN3DHIOa6heutiusrulgF8goZtasRc62QgYK88EcVMI2oLHI70NW5IbjoutOQeSgw0u
 Dhlmi/MnBE/94dx4zWBok2cWUlU9X/DJBSniDHShsB
X-Gm-Gg: ASbGncvZUMc4xq+Z4AHabPMb/DzZN3HEC1p8prFCQuPN1yYBoTtKp+4UYp1qxXIddXg
 RbR8WrdAUYt2gWyxzEhdGWmu1ogIU/0NISN5pFsMe9lC6Tgpz6F5b3EbFx49bwJNmmTU34YLBU6
 PTme8lk2mu+dV1fKpOMw9xdlwI3+trxvgav+Zm6I8ZKwkBzhrba/PCYNyViuLFqIJhM17DmUFtA
 NtySVhMkeBQD0HADA3DfRm8BxhuC41hnMq9XizTUryouKQg0bshYgjknNjRFxb2DxkE02ISVaJH
 FQuSgxSdldG+g6m5Q8WEsz+Z
X-Received: by 2002:a05:6402:520d:b0:602:e46:638 with SMTP id
 4fb4d7f45d1cf-6056e159678mr1850419a12.26.1748589333589; 
 Fri, 30 May 2025 00:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWy8JhVMLuRVVnl021PKTHpGvWBjnIKsFObmteGDYAIIjdnmtMLCaQadHbgLJLBvJc14c7w==
X-Received: by 2002:a05:6402:520d:b0:602:e46:638 with SMTP id
 4fb4d7f45d1cf-6056e159678mr1850387a12.26.1748589332980; 
 Fri, 30 May 2025 00:15:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c75aebsm1215146a12.46.2025.05.30.00.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 64/77] target/i386: Print CPUID subleaf info for unsupported
 feature
Date: Fri, 30 May 2025 09:12:34 +0200
Message-ID: <20250530071250.2050910-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Some CPUID leaves have meaningful subleaf index. Print the subleaf info
in feature_word_description for CPUID features.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241217123932.948789-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6258027ab15..be3812973f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5780,11 +5780,15 @@ static char *feature_word_description(FeatureWordInfo *f)
         {
             const char *reg = get_register_name_32(f->cpuid.reg);
             assert(reg);
-            return g_strdup_printf("CPUID.%02XH:%s",
-                                   f->cpuid.eax, reg);
+            if (!f->cpuid.needs_ecx) {
+                return g_strdup_printf("CPUID[eax=%02Xh].%s", f->cpuid.eax, reg);
+            } else {
+                return g_strdup_printf("CPUID[eax=%02Xh,ecx=%02Xh].%s",
+                                       f->cpuid.eax, f->cpuid.ecx, reg);
+            }
         }
     case MSR_FEATURE_WORD:
-        return g_strdup_printf("MSR(%02XH)",
+        return g_strdup_printf("MSR(%02Xh)",
                                f->msr.index);
     }
 
-- 
2.49.0


