Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D56FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3L-0003eu-B6; Fri, 07 Mar 2025 13:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3F-0003Ut-Lr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3E-0001ce-1m
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso13615455e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370637; x=1741975437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krlUeIQnTGSREObLa/ECb/a6wxL5+gnrd7UhE7/j7Y4=;
 b=N9hfvTsttsE6ramriuYgHTndOhTPHPuNGtt1ZOakn00CSZckTIhHAYHx3nLvtLFZRV
 SKi4hLyXSY+7aLtB2+s4BW3GkRNnGtBbywQYqmWGKQdVWiDBMsGrpB9FMKOR4VZ9dSEs
 0ezrPc6+zRomgMlrhFBL2s3LYxgWA3EX877GSlua1pv+T5FCL/yqID2zApCsFUDA+9Ar
 F1UhIMcrqESVVxXS/U3auZMiwUmrHVsCLzzcojmOsDhiD5alkMiSybGvBJ+gHgqcITBk
 +RWXsY2Zs6JFvqEObT/R+7Nf5Tu0z6+nJYOPDVBZ+b+4iZlWHCwjRCl0XBScmRjkosZl
 tvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370637; x=1741975437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krlUeIQnTGSREObLa/ECb/a6wxL5+gnrd7UhE7/j7Y4=;
 b=PGcTePmK2tRaA5zeUZLqfwakQwuWawKy9zJzZjkH86PftVf8sU3uZO08v4adAen2ck
 nKUtHO5ib1DACpIjgxSEbDxKZ1mqjToqMdiLElT3eoUGrF9TGL3JiFBZqZVXPwyUq0W5
 w8SGnjAzuElj6iRwWx7Jr5pLuKOKTa9xty5Zd6FgKLhD8thfLxQIti0uK968CfTmClnw
 SzKkReJXB6lX244la4lJAjYxnITgYNBkFnGGDfHkQhNEfYDeexrl2NaZtmJUPt14i4oO
 7EFWrFio+CKxAcDdyHSLvt8IzywfselZ/rhbnQovb9kh8VHgxPct8+8nBtgBhcI51Jt2
 f7mw==
X-Gm-Message-State: AOJu0YyIld2DpY/PTchgyQQAjsaOTih+TLKnvrwCE/OM8eYHq4BJe6Pt
 TwlT+hE7fq36eKb0M1S4xNSvbw+pjq5pguZi1huQz3aOWM25QLviBkt4T3iVeQOAfSs2pYXT/IO
 sWbI=
X-Gm-Gg: ASbGnctpdkAbIWgMLKOZyQYsHSOiVLrBqyFCOVfc7/2uJaVsl9UvY1oGjxLO+GxNhjn
 pCDSC2dzqOpL3ce1x4ywDJ9XPjri+0ZEb7bTQRLHTpqmAhYJmREOEg/UCvo/Lde4K8s3dh4C//B
 ZmBB2i+aGbXy1NOO1Nh9GDrE5ou8dqHQlTPUg+SRdrWSvayX7HI7piLktUMNQ3+VucGlDZK/Fw1
 N8dWxsNCoP0Wb/65hpQeg/Bv6Yyg9+2mDC25DUe03W36IDGABjwsPUyZfKgX5XG04v0co6Ccxsu
 hOh08KBGfAyftKOULBHyiVOgCQMGOeI40QlMotSppL/mcMls/DlvLwm7HVm2gY2SvMtlnPZplZc
 WO+B20rtxrD5ar1LMKac=
X-Google-Smtp-Source: AGHT+IGu5Q1YPuPmBb8fk1NDTqZebT4A1/g6W7nPx0JHWu+hxOl2cltZSz5gJGPwWO4yjdIb8BwaRQ==
X-Received: by 2002:a05:600c:26cc:b0:43b:c390:b77f with SMTP id
 5b1f17b1804b1-43cb91c5affmr23555105e9.26.1741370636721; 
 Fri, 07 Mar 2025 10:03:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352e29sm87392995e9.32.2025.03.07.10.03.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:03:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 03/14] hw/vfio: Compile some common objects once
Date: Fri,  7 Mar 2025 19:03:26 +0100
Message-ID: <20250307180337.14811-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some files don't rely on any target-specific knowledge
and can be compiled once:

 - helpers.c
 - container-base.c
 - migration.c (removing unnecessary "exec/ram_addr.h")
 - migration-multifd.c
 - cpr.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/migration.c |  1 -
 hw/vfio/meson.build | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 416643ddd69..fbff46cfc35 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
-#include "exec/ram_addr.h"
 #include "pci.h"
 #include "trace.h"
 #include "hw/hw.h"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 260d65febd6..8e376cfcbf8 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,12 +1,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
-  'helpers.c',
   'common.c',
-  'container-base.c',
   'container.c',
-  'migration.c',
-  'migration-multifd.c',
-  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
@@ -25,3 +20,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+
+system_ss.add(when: 'CONFIG_VFIO', if_true: files(
+  'helpers.c',
+  'container-base.c',
+  'migration.c',
+  'migration-multifd.c',
+  'cpr.c',
+))
-- 
2.47.1


