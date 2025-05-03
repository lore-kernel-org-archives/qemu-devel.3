Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A4C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mb-00088U-9u; Sat, 03 May 2025 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mT-00086E-KZ
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mQ-0006fl-Uu
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGFUgCwnObUQrsqI5z/bsk7l8Vga318bTFC9U7szmG0=;
 b=gsZ8GXzdAuPeUhhqTv56US3SVNHCYPI4gIv0CQzzYGuG6tRAo3f8R5lT1RQWCcOxFG9GeZ
 iPlDkIdfKcHr0B6bur6Nd+vNsP5VjFB4Z8C98hnAjFWPwa7FFApkfTnLWUWxSzLfinoNm4
 zKep4rEM3U74/wBWSsXuZanYcaLA/xU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-AnNq3tUXODysBM-GUzQVvg-1; Sat, 03 May 2025 03:59:24 -0400
X-MC-Unique: AnNq3tUXODysBM-GUzQVvg-1
X-Mimecast-MFC-AGG-ID: AnNq3tUXODysBM-GUzQVvg_1746259163
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so13604625e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259162; x=1746863962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGFUgCwnObUQrsqI5z/bsk7l8Vga318bTFC9U7szmG0=;
 b=J6UftWqJ9xgka75f7aIAGsKrsOaS2iS04H2X0VumnCGHPvUsvmYbX6rYW2FEoH1UhH
 TMPCDCQ2xCjullJ0sc2X2TlwHLlA1pdRZsSsHAGyXo/7qsvQ6Hfq8pF6u3Ac1J+kmttr
 HnP1hi/PNJAGlGPv9NrowWMLk9K6KkE2GTWpMRvi1lJ6lpqXrnAOc/YkdWSSCckhw/Wa
 N+hOKeI0uOUctB81nA1CsIM2alk4+Pcue6ojmeTsCxv2tr6TQdatBwqjONABqh/cYV8V
 YV8N85sFfy8Tspzg90pygUa+2wtrsbGs6dgqgnxx1Pf2/aVIwsPVBOKMv1h49kTFkgMM
 2alg==
X-Gm-Message-State: AOJu0YzkPx54kreDqHqUlAj5uQN3pbLcYz9LbboSelSQatMFQ7NUyDdC
 POFsih1abJIxLCKZ4yEZK2XOy0CjAcr8UHXYeCZKfn73j4jfURfQbJQbOo+5jUEZlA7VzzlF4ky
 MAH7QlPBSY9cf4CJS6v5mLeD+jxhhNOIA2A5mmZ+QbI8kIoG90HoyWGBP3u85p72wGA/8319lrD
 KIjTVoxUEeAFV+PqGZfPsjXALHQ8T89clJMyk3
X-Gm-Gg: ASbGncueqiOEb6J1J7+53XxMeS/O9hv0Uj58RHrC4TjiCyQkdQCVc99J0f7wOsOsrUQ
 4nzMMve3QlLFF9fG9eTlCwwWxbNLzXHMvM8M5OOSYLJShtQHhQZcGm2iq/RzzJrd+4K0cGNrtNj
 SXlUvrGVaZ0f8g2G5sjYxMDSrJggaPmF/ojJbBqxmCsq7HAfu2hpHrwlBmqOUng6vjnNhU5ofte
 JZ2eAiwE+FknIOefq62WWl1AGzwzFpvuku9WIpf6GP1LwsJnnCX4t1b/BWj+iGcGVq2GqBIrNcL
 Ktn4z/yQB68vYiU=
X-Received: by 2002:a05:600c:1d9e:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-441c48bc8f0mr1882495e9.8.1746259162697; 
 Sat, 03 May 2025 00:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwfvoGrDDxN0DgZiHxq8l6Alli1lseb0D7OcNZdPslH725XvhomroVnSfd4jFgSFyawe5vlQ==
X-Received: by 2002:a05:600c:1d9e:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-441c48bc8f0mr1882315e9.8.1746259162290; 
 Sat, 03 May 2025 00:59:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc67fsm68173425e9.5.2025.05.03.00.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>
Subject: [PULL 08/13] target/i386/hvf: fix a compilation error
Date: Sat,  3 May 2025 09:58:53 +0200
Message-ID: <20250503075858.277375-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

From: Wei Liu <wei.liu@kernel.org>

Include exec/target_page.h to fix the following build error.

x86_64-softmmu.a.p/target_i386_hvf_hvf.c.o -c ../target/i386/hvf/hvf.c
../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
  139 |             uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
      |                                                 ^
../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
  141 |             hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
      |                                             ^

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/aBBws1ikCDfyC0RI@liuwe-devbox-ubuntu-v2.tail21d00.ts.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 23ebf2550ac..99e37a33e50 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,6 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
+#include "exec/target_page.h"
 
 static Error *invtsc_mig_blocker;
 
-- 
2.49.0


