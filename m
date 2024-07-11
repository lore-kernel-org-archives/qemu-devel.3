Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE2CC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueP-0006Tf-8c; Thu, 11 Jul 2024 10:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueM-000677-4t; Thu, 11 Jul 2024 10:19:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueK-0005Xo-I2; Thu, 11 Jul 2024 10:19:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70b31272a04so1355853b3a.1; 
 Thu, 11 Jul 2024 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707594; x=1721312394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8fUUkofZlD0VQNVjPS4pmLNGcMZ/HOLexvY/fa0/IU=;
 b=LKmTmznksy72O/hiFVf/lqIqR7eh7fQMqMKyun5wTz/g5jo/xyesooi1olos6I59qF
 O6Qm/6bGxM4l8e9rCO5swCIGWdKt1TtdTRrqj+AQyomqcTMba0+lRaZleSAeDFsQL0En
 1GoQzdjyobT1BKZDadmSJb6D4ZgQ4GPAvuT4307RvndCBvxkd6rAWPTDiQuNRAo1gX7M
 8Fsi68toGT2KzqLttNnVEpy7PovQcoXffhSMj3rcJjv6DEKVotcVr7+CbKslWil4Olfv
 Q9dKjNxOYE++AZUXWB7uufjGf1Vw3cfuqzQe9m0zoFvMcmlkmFCiLNsugG6PH8UJs3du
 C26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707594; x=1721312394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8fUUkofZlD0VQNVjPS4pmLNGcMZ/HOLexvY/fa0/IU=;
 b=DNLpPiXbpE+Ea7kz6xU80mNG46LWuWWKZbDmCH9Y+1Ey7uW1JxTC1tXEENNvna9G4u
 OI5e7EPMRvCD/b7Tzr14q3mqdK2ECeSChGMTn4uPlCzZXZf86VaNOqMjIjOjA3HihP5C
 oHVSMUpkQVtOnCWhc3LsJ+02z5x/HCszXNEBryDeWE5BF0d7hALFAwIRsUte6nop152N
 77gNSyTy8UH+16JOc6eLdXfHXGfegD1moVqwxYxVd8uDjEyQW6lSg2WA+NSwv5zkZKQ9
 DLAHRt0pq8xvfpRRfs4wyxmkwb8OL3ea67vLY08Da0AZYLEdUyPq5317CtxIa41GGMjp
 7iRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0KqfS19KEwXreni7uic9fLEgh2OWY/aOA0LQ8d4swSOCVjm0QqxtSWD2+lQQWYwZIyKqenEBIVKrWGY9A7/zdnVRzrQI=
X-Gm-Message-State: AOJu0YwHZNJY62VQ/CfM2HLt6Ho9o3u9kyjqJLA2Vhcl+dZ5CxsR9H6P
 sLa7+fGDxv1sf9oPFE3B5qLHZNvfHd5XNsX8iaROra9KYztwcReBkbqSd9aJ
X-Google-Smtp-Source: AGHT+IFE483TGpRXNwj0rVPfaqgNEyV6O36xfDI/oU/2vV31yYGOP8wkvz0bhyxyTl+WtWP3mav8lA==
X-Received: by 2002:a05:6a20:72a1:b0:1c0:e619:bdb2 with SMTP id
 adf61e73a8af0-1c3b78070b9mr2814309637.14.1720707594443; 
 Thu, 11 Jul 2024 07:19:54 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 14/18] ppc/pnv: Implement Power9 CPU core thread state
 indirect register
Date: Fri, 12 Jul 2024 00:18:46 +1000
Message-ID: <20240711141851.406677-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Power9 CPUs have a core thread state register accessible via SPRC/SPRD
indirect registers. This register includes a bit for big-core mode,
which skiboot requires.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 2032f3f7c1..aa255233b4 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -319,6 +319,23 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
         return pc->scratch[(sprc >> 3) & 0x7];
+
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used anywhere.
+             */
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
+        }
+        /* fallthru */
+
     default:
         qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
-- 
2.45.1


