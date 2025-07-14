Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DC1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHXM-0000ZG-6n; Mon, 14 Jul 2025 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1x-0002Oq-Fv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1u-0002JI-Jz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAj8gNQPx0+zlFmRZi9dDjnOFhk6i3lq0mODeXaaGSw=;
 b=Ar8+9Z5XVeObfiQucNT7L9M7z+mjQSWOKjgHe1qRoGBGc5lONal268vY2aruHOwI0Ii1em
 cFye/7i+gmckUxNrlkQBj9IGGOwAymLqs9QS27AXT42rmKkJw85QnsuHNWhw/WJtD6Uvea
 9mFzmpSQk6KqNa3eu3wIBLXHSuuCtwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Jh6ffjNJOj-NDO7UTE9mlA-1; Mon, 14 Jul 2025 07:07:28 -0400
X-MC-Unique: Jh6ffjNJOj-NDO7UTE9mlA-1
X-Mimecast-MFC-AGG-ID: Jh6ffjNJOj-NDO7UTE9mlA_1752491247
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so15277355e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491246; x=1753096046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAj8gNQPx0+zlFmRZi9dDjnOFhk6i3lq0mODeXaaGSw=;
 b=uRpaRYfqSQWK/KMbaAasFmwj9PUF4KXOfeFLtagy8DpSDzT3MVjdbqo59LwK7mu0Ql
 Lw9Vz1h2Oa6El3/I4ZLiKpGX2Gid7drBaFJuUugphJ2a1voEB4uaLuoV3w88XJeIz/sl
 tYqCL6VE1qVvb74DKRhlxT+8QJoXYpngq7ipxJ8KlLfTozDldbDiNhXsNWZXV3yzRpfc
 PC3Nz6A746vJCIAL2JHMlBU+xSzIVvYqG2xArufmT4GL9xpGvItjNgEnKUhn9kC9/Xwf
 YPXL0Rtzi3HJfbko6Yf0+VsnX5GYw0UeSrP3Amw8IL5j9YsUIzlJFuUp9jTKiahG4Eon
 nQVQ==
X-Gm-Message-State: AOJu0Yz+gF4PPMXrMh1kOMcC5hqjmA9sHyMJL+cumAcDkSekbmHk6pZT
 pGb3GHVQgqPk7tUz6z8ceTyTi2G4OUaReDTGiPINPnyFLs5iQKCLtvCpQ7+3EDY5wvjb9p7h5TR
 gdz+pvDikYe7xEXw475S8oTeDY6UuV///I6HB3GpYJR4iwpqSl2efqZpZqE8hIhGpJ4cmldOFl/
 VIPypQYZN+7Eh/aLycBanpYK/8yCkmdocchcrqBzFh
X-Gm-Gg: ASbGncv5gjPz8wpZldlUcu4g0OUIgT1O7o4KSyeHEpL1icyA0hwl5G3k5TJQwK759QM
 JzRb4Up4qpLKviKQJVcKfaZ3AcFuItVR1K5h6TkvJiJHsxUJpYjwbD5Y0EGKC/y2YIu4sr/sRh5
 RHC6fjgBhiRj/zPy8/Bvp1nLrC6eTcfxOoskZ9CWu7EPSPMw6OZaV8RKMfN6ThMtiMAwVmDBBO6
 YbFEcckR/jomIOpIu14x1wCSmbaTvk83uIDul4v9997tGrhhEmRRZUHbBHisDFQPduyNzk4/UQ2
 WmapiTuc4QjylrZ0CUVp3Sz6mJdSIFxZcJYGrYbb2w4=
X-Received: by 2002:a05:600c:4f91:b0:453:62e9:125a with SMTP id
 5b1f17b1804b1-454ec27dc91mr124181775e9.18.1752491245828; 
 Mon, 14 Jul 2025 04:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTfQx0TSbr4qUaRQlVn5DvSM6Dn1S6BaJpd4uCbAN1z4RKQZguC7Sry47iia+2Z3aIvO6DLQ==
X-Received: by 2002:a05:600c:4f91:b0:453:62e9:125a with SMTP id
 5b1f17b1804b1-454ec27dc91mr124181485e9.18.1752491245371; 
 Mon, 14 Jul 2025 04:07:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561d19a21dsm19914315e9.24.2025.07.14.04.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Babu Moger <babu.moger@amd.com>
Subject: [PULL 77/77] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
Date: Mon, 14 Jul 2025 13:04:06 +0200
Message-ID: <20250714110406.117772-78-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
logical processors sharing this cache is the value of this field
incremented by 1. Because of its width limitation, the maximum value
currently supported is 4095.

Though at present Q35 supports up to 4096 CPUs, by constructing a
specific topology, the width of the APIC ID can be extended beyond 12
bits. For example, using `-smp threads=33,cores=9,modules=9` results in
a die level offset of 6 + 4 + 4 = 14 bits, which can also cause
overflow. Check and honor the maximum value as CPUID.04H did.

Cc: Babu Moger <babu.moger@amd.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fdc677614d8..da7d8dca633 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -560,7 +560,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
+    /* Bits 25:14 - NumSharingCache: maximum 4095. */
+    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.50.0


