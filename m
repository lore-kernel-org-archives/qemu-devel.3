Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D59BC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jk-0003iy-St; Thu, 25 Jul 2024 19:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jj-0003Y5-9x; Thu, 25 Jul 2024 19:56:15 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jh-00014Z-DY; Thu, 25 Jul 2024 19:56:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so393563b3a.1; 
 Thu, 25 Jul 2024 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951771; x=1722556571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRU5mXFW75+0u2krwZSICCQjsBiOHONwJX33wBY+3tw=;
 b=d1g0mwIxFXTcOIUUk7IoA5XUmTAC2G4WNX6cZIiwTClKBeN5NJpS38BKVuaGfDpOkx
 O3HLTLU8/TrTMYcDp7hY6L7OdkJMemgs9RJa2zgOCZAxs+tESV9h7XB7JWdmp/CJvuXB
 8NRXmOjUEkCMCfXOARFPZYgMIfS8oe+b+q/zJgFQf/oswRi4vpeJIPEpSOK0eqFRaeQZ
 qxrXQc6BHohmhLMV8fe3lde61Ij9lOXBhqwWsMjZoOaVxMeETQpQQi6WpaGmGNExNUJn
 3h6tI8Ge66+wZfbiwFrQoH2QxwN8r6vZYAFcslBWnX4h62/5BCqW07uL/lL9XBa72S+p
 9M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951771; x=1722556571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRU5mXFW75+0u2krwZSICCQjsBiOHONwJX33wBY+3tw=;
 b=Lc/62JU+adlL57wJM9mkbmEvTftfLSpc93v34gHfIIqU273zESq8NET/JbHOe4s/lq
 dKAsuvoM2gqNeOCiuh3ZgM9xmUTDL+GGv/ZRav5jyrjkYdm6crMOUh+P4QGyBdG/jQ+P
 L4MAalmpyxZCdG5fLssePMiwNQ3sAfp8aXBEUWUswuREDJb+HL81bG/NXT8y7BDrr+r5
 OET2f5U5nmcn9QGEqA3918PeL1MbGlzbIUOTqGReXQKga/Q5HH8iIC9bAyK2cwuWoI6S
 39p5gk2Y68JVc+v6bJFI1vgjH6ejdCGe7Itq9NnBc21bCqUU+DgMQ6kkL4gTxkn13QFB
 bgPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNqtwIqVTWOPWFHcwoqohKxDOOlJd5GTwi9h2gDMLrQh1M0jn34buriFGRzGeskIsK2Wzc7WU58MGdwqqewzY/Kyb
X-Gm-Message-State: AOJu0Yx6nMuoEnkOIkWeKzQ3hIhbP9ED4gICRk+ebDMM53w0viwIavlI
 aZk7rtPYoadI0KKnQgKsnwOi++HwgJ5MIj+k9ZeotbMKcVQCmUwVG9Svfg==
X-Google-Smtp-Source: AGHT+IHV5ekeAEkL4HiU3q/R2LGpGjhjZ4D617fwj8m6pfPYdgCf0CuWxGdkynS0OJMaB6X/CYQZOg==
X-Received: by 2002:a05:6a21:6711:b0:1c0:f5ea:d447 with SMTP id
 adf61e73a8af0-1c472880cdamr5152586637.31.1721951771290; 
 Thu, 25 Jul 2024 16:56:11 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/96] ppc/pnv: Implement Power9 CPU core thread state indirect
 register
Date: Fri, 26 Jul 2024 09:53:03 +1000
Message-ID: <20240725235410.451624-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 9789d69664..1b83971375 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -325,6 +325,23 @@ target_ulong helper_load_sprd(CPUPPCState *env)
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
2.45.2


