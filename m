Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B3DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0n-00011u-5s; Fri, 12 Jul 2024 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0k-0000o1-Jo; Fri, 12 Jul 2024 08:04:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0h-0005oO-TT; Fri, 12 Jul 2024 08:04:26 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-75c5bdab7faso1153190a12.1; 
 Fri, 12 Jul 2024 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785862; x=1721390662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyPOIb2VK3dD8F4THz9rJokTRHuUTmaR6trLMdHrvl0=;
 b=BDAx4z2Yf36JqfhyQxQTjXjmmB0F8t/tzd3sQKWRKZYvtA5Xx+T1ZMIz2mTtMzXDZz
 buMU7UjM2jSCXX+HrjHvnIovGzay2BgbK1gWVsrYvMQxInbqlsz6Mr+4ZFRRhv2Ny4ns
 ANdnglIptw8hPsMdEagZdVkPraEla1mvolhAjfLBITkIWWYXjG0fwX79gyl+gmoZy72D
 F6Ps2BF8K3nUXziZd6pLTd74GbakXKd1HxLQT4oPRJWf8k6fJn6Ep9vGRV1nrWQ590qG
 TlwhFbL20JtA/1O/lJpA4tpZ+m8Oqf6pSihNbG8hPMWE7nH23YAQE8vpx+lRRIjjdL5N
 rVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785862; x=1721390662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyPOIb2VK3dD8F4THz9rJokTRHuUTmaR6trLMdHrvl0=;
 b=YxJTrY4an2g1BbaS67E00sAyCt3jIrvt+pMY8t5I0CqWL3ag2ZC4dE2UWpeZj5dP1z
 ujZzrt42GLRrEbCgs8FjR6rpI+7OJkPD7DNaDZxueEpX7qpzIGkD4brRI7etzQb0ScXr
 MjV2H3IPMLI2kq9CgPvCShfh6gZ313ewHdEiRuw1Xf7g4WwxxTG01sjDLD0o5AcMNqtB
 nKmLv3zokpfzZ6A4m+E3jIY6RvDNzlCuzR6su9pBJIaAMobtBltMSr52HxJiroJJwBIE
 oCa9JFz9JVoUsASPNO8sO8PHSMl8vlvUrRSmRsya5ZJlmFPCXr/hn9US0Y5raeknM06y
 35fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSDX1aApRIXSHF6ZbWhZbA56a0TIok40X/NA9lh1V0/TV4JFjt9Q7unLgjPqKQECstDCRUw+FnArOYiy2UHPWDQjGGCps=
X-Gm-Message-State: AOJu0YyHwL6NLPWIIQm69Ap8c60C+ZP7lu60ly+cEDkdWqNBTU+ixPmu
 yOj2WmPo4uwxrO1G0DBNM7XC3isQVJbkoK1cE+aKL1UN/rNrTLhlyFg0cg==
X-Google-Smtp-Source: AGHT+IH3rZqRp5M/Bb5J5vdgaHZDCtshUfFeNET2SCkD/JW+Ex4B1E7UG1cwRdoc34GFdvc7xuhnoQ==
X-Received: by 2002:a05:6a20:8422:b0:1c2:a696:6a48 with SMTP id
 adf61e73a8af0-1c2a6966b9bmr10057010637.48.1720785861766; 
 Fri, 12 Jul 2024 05:04:21 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 13/19] ppc/pnv: Implement Power9 CPU core thread state
 indirect register
Date: Fri, 12 Jul 2024 22:02:40 +1000
Message-ID: <20240712120247.477133-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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
index 692e48e6bc..e69236d2de 100644
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


