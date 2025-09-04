Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD8CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuBmq-0002Cx-6V; Thu, 04 Sep 2025 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3k665aAcKCiQPEFOLEYGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--pefoley.bounces.google.com>)
 id 1uuBmm-0002Bs-3V
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:22:04 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3k665aAcKCiQPEFOLEYGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--pefoley.bounces.google.com>)
 id 1uuBmi-0003xn-Mw
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:22:03 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e970a7ece01so1867704276.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756999316; x=1757604116; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dYzV/AQiEq78OD9b7CeZkT4qNCS4VNM0VZ+9D+2T0TM=;
 b=dIdiC3AL9tgLaFF8hl9rbimi59pEh4nWPLcEe9VG5eKNVQCgxGNUibzgmp9wKPcrUH
 uckfn6BtfYaaDb1VLFiyV60j5rBkOJ7IlNEz6Y3+GA1OJ4vWHbSZq5bDU3uKp0ol+teo
 qQawoaJkWJXpCTw65EOWfYKgqNyvV5YQnRHt8YBmIrMWM4y/QRbGWXQ/v9jer4CxFnp1
 IwTjnoZ5cDuYRFFJUqbPmn4DmSt/uKB+IUhCf+/xughrIRpgioQPuvIe17lPBpERMzKA
 GQTPSnFl888v3aUxFHyb6M6z0GyD+/lI/vSBKGUg/pkE40QeSej5tLeq/ldQdGBXcBn9
 kvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756999316; x=1757604116;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dYzV/AQiEq78OD9b7CeZkT4qNCS4VNM0VZ+9D+2T0TM=;
 b=v3xI9Bzm2lqc0SaewUetU/6ekQ8I6zhzlo5Z/kcAkxfhwyVfJNcqU0nG9ucc1y28BN
 1rPL9HWaDbA6aPj8i5vL5hlVBCpf2+UNCf4uAImQM4X4Y6ExGSodLRfRaM5w2YWuZNiP
 9FgVBINn+PgthXXSk9CegRvt3r6pKfXItluI9ZboiK8lWPefCRw+HXM5XcIdpNwEMGuG
 eHJHbkSrHsMEfFN2Bb7dCm6MykPcTH0Obk4+HJaZE/xmnHQtzIAtMIOVeB/u+xVj72JG
 90x3MhJpvmQMnb76ONclfsZDmf2IDbyWDm3dMSA81pUpnFiDI3j9j886AFUBbE+OMmwe
 CCYg==
X-Gm-Message-State: AOJu0YwgmIRp/KqSaUYTQqSiPM+L4DOt4RodZPuIvdZ6l9NLttlFnYf9
 SbQv2wOCyOldflbubFLNkRQBNLpo6Oe9qFjVfjuYD5H1hrCre1rmYJVQYEpcTQKLG6ClDWfBKTq
 gkCGlzVOMVXxHQnrpemPN5XE1fRyQO/acdJzS46ZSKLph4S6Dqt1KDLTughApiVB8/OFIW6tC4K
 +CPMEASXJPMUJBWCsbI3lh8U7/qgCMLLHQsWByNZKl
X-Google-Smtp-Source: AGHT+IFQnkBDn9rL3mIu+i76ZXO7mib5i8uRFdHv8iCdCjdOp9CSrKS6zBVlodvnUN0bCRBfw7dX/3/8ORBv
X-Received: from ybk125.prod.google.com ([2002:a25:a83:0:b0:e98:a06d:acd7])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:708:b0:e98:a303:d1c
 with SMTP id 3f1490d57ef6-e98a5820b92mr16812056276.32.1756999315856; Thu, 04
 Sep 2025 08:21:55 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:21:44 -0400
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIeuuWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMT3cy85JzSlNRiXUPLFMvEtMTUFDPzRCWg8oKi1LTMCrBR0bG1tQA
 Vj0yHWgAAAA==
X-Change-Id: 20250904-includes-19d9afaed67a
X-Mailer: b4 0.14.2
Message-ID: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
Subject: [PATCH] linux-user: Add missing includes
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com, 
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3k665aAcKCiQPEFOLEYGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--pefoley.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

We're getting errors about this:
linux-user/elfload.c:2770:36: error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'

Signed-off-by: Peter Foley <pefoley@google.com>
---
 linux-user/elfload.c | 1 +
 linux-user/mmap.c    | 1 +
 linux-user/syscall.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472c95efb4eb9bdccd81e9902 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -5,6 +5,7 @@
 #include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
+#include <linux/mman.h>
 
 #include "qemu.h"
 #include "user/tswap-target.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 002e1e668e631130526053599e1d18ffb4b4141a..9e92117ca3e8e4f45cb333366ecf3668b8986200 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include <sys/shm.h>
+#include <linux/mman.h>
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c7f478085ac1c7cc8bb2026f8b32038..4101b0e4e7812740afe7a4246a902a5364d7c331 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -101,6 +101,7 @@
 #include <linux/soundcard.h>
 #include <linux/kd.h>
 #include <linux/mtio.h>
+#include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/fd.h>
 #if defined(CONFIG_FIEMAP)

---
base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
change-id: 20250904-includes-19d9afaed67a

Best regards,
-- 
Peter Foley <pefoley@google.com>


