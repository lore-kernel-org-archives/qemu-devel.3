Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36536C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w7-0005MJ-NZ; Thu, 23 May 2024 11:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w5-00058S-0q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9w3-0004os-7y
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y96DI6nZ+NHIDncZ5Rw2Ykq6OgSXiyKtoBN+mvhdLas=;
 b=QXEt+KEY7du9cX5cgI6OXhvjGOKihTQ5nasWBQ6cPSCbLasjVwxtILKm6mnbg+STWx2+1j
 aznVGRXnvOICXZIGMVKiT5dMD8J0YNm15L+OPslCgidNBwxnN0ynEWjZKQu6BSg1dfrKyz
 eDYw+HBHcfzLHrvuv9QmFVPYR76x9y4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-6daK_Ew2P7SvtkGnypgoow-1; Thu, 23 May 2024 11:00:49 -0400
X-MC-Unique: 6daK_Ew2P7SvtkGnypgoow-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5a180153aeso135196966b.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476448; x=1717081248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y96DI6nZ+NHIDncZ5Rw2Ykq6OgSXiyKtoBN+mvhdLas=;
 b=UaoR16buPWbxIrlkvFi/9c/CnHSku+ILFkUdmntdjtF7Iwaby2DIonYgFeVgax8z+v
 UXAJYNF+SllgI94PY2PoCl4P9dF3BiBVfK/ezyhfjuWDSdeOJ/v8G/wJBQWEbZsUqY+I
 n3j3yqKHFRtitGJTXDwtHLupYRRjHElq840NddtcJ6ojj4l8NkMeWnJ53hoW+UigRYxK
 +mO6z+dMHxOMRm932iU6pzR01GD0qUhlCTAvmqMvoX0yrMxv07TJ1y22kvmgK8UlMxNH
 N4+Y2dYUBpRQXhvlym6aJheFxo1X8DsWWV+RhFpvq0eQDBuFRJbwcCBw7WjY8+0pXsEJ
 zz+w==
X-Gm-Message-State: AOJu0YwBIsqhIiEnStdlKgwNR0bCgm4qgpzn8tlsUR74e4+pt0y40c10
 FveTYr+fkda6Egq1RVUkupVvWmti3rZ35ce7zTXP7wF/eLhdqp/z2qw+fkwJX4xWhGSh+IrSNPp
 mPsmmKC83hxRdqfU3gQUKZ0K5Novr+53qF6LIqr9aeby7xU1lrikp39QSr0C5EimJsNMzJZel3/
 JjAf4+dKMYMP5ttFEnC5UF74NMis5QdcXc5VF6
X-Received: by 2002:a17:906:749:b0:a5a:5496:3c76 with SMTP id
 a640c23a62f3a-a622806c243mr410631766b.6.1716476447749; 
 Thu, 23 May 2024 08:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtAyeJnE9twfRIyB5xIl0CB00jkA8pSanx9ALQdaztBFwwBF/qaAj3YrjC6fhJyTA3AY39Sw==
X-Received: by 2002:a17:906:749:b0:a5a:5496:3c76 with SMTP id
 a640c23a62f3a-a622806c243mr410629166b.6.1716476447348; 
 Thu, 23 May 2024 08:00:47 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d4b2sm1930314166b.27.2024.05.23.08.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Robert Hoo <robert.hu@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Xuelian Guo <xuelian.guo@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/23] target/i386: add support for LAM in CPUID enumeration
Date: Thu, 23 May 2024 17:00:17 +0200
Message-ID: <20240523150036.1050011-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Robert Hoo <robert.hu@linux.intel.com>

Linear Address Masking (LAM) is a new Intel CPU feature, which allows
software to use of the untranslated address bits for metadata.

The bit definition:
CPUID.(EAX=7,ECX=1):EAX[26]

Add CPUID definition for LAM.

Note LAM feature is not supported for TCG of target-i386, LAM CPIUD bit
will not be added to TCG_7_1_EAX_FEATURES.

More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING(LAM)"
https://cdrdv2.intel.com/v1/dl/getContent/671368

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240112060042.19925-2-binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 ++
 target/i386/cpu.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ccccb62fc35..107f263429a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -927,6 +927,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cfe7c92d6bc..de1ad7270cf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -969,7 +969,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "amx-fp16", NULL, "avx-ifma",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
-- 
2.45.1


