Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D666C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYplz-0005zg-1z; Fri, 17 Jan 2025 12:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYplC-0005IC-UZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:04:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYplB-0003L4-9d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2164b662090so46041015ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133431; x=1737738231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aXybp6m1M+vXi2xN0TsmNLhT/jKq3ExXEUmLXhSP5Y=;
 b=kDvKjuOd+SEjh1k1qz7vsZmR3ytorsz/zlQQaN7VrAb12TYceNegj7JcBFxpqJTSfg
 9Zf/xEDfWgacJiiRcuDcf2xQPiK3rOrql8fyMAX+uDlf5cWDs3Im6bzN2pF9zfQSITls
 sr+DahPSPQ1peOAfsvoZV0Jnuh8MNyTqmErlSDSQF6zHA8dotu/T9v8rLDNyVOvs/0t9
 H1OeToiAogLDbbf0LNQQheaJ1ZFCs3LseAKZeTd70icpFELSbY8BY6KKNIRJ/CVlddr3
 XPsOm5tlG0nDskVRmuYwoJ4RNLa/h+GFG6Jrk93j8bfxqcGVunMtUb/Vf+nlaWoklI4T
 64Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133431; x=1737738231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aXybp6m1M+vXi2xN0TsmNLhT/jKq3ExXEUmLXhSP5Y=;
 b=uwenC7hd40E2BU7Trej57gL+OrNMmSEBb77yToO61MPw5toEUpEUr4HbMCEfUfMrc8
 HgXWdK1+yjJnvSDsuwJ2k1ZWY9HBahcBhw1QE54RK1AfM9zillRZPQM0ObQjxiUEFpBw
 66vDAZ/h2ciDZE36JPzOCtoeh+Wtw/wDx5Ldu/ORopnqiXP6iaAthKghLlkuxdWa2FMH
 l341d2dDteRJzAbMqvKLDdNbBaAhXcBwPFB+WEkqR///+2bMEj7RC2T3ciLUh1wIKvcQ
 GJWA7+aXxfQ/YInNR1bC7RFnrPO7wyJAD48KbGU6MJWXv4sDQJP8E7kEFklOj8m9bxre
 0lmQ==
X-Gm-Message-State: AOJu0YyMAZRdU0HmNoqJIW08pp5EXfPwPcc8edEg2QHe72R1Zxr2WoXS
 JQycTD6bvPd0AjDQvOiFk50iilgt8ehQ4/6+Zn6j2809CjlC/iSZEeQtQA==
X-Gm-Gg: ASbGncs0ezEpu5Q8jdS0S04hmIs5S1UzwGYWN2bcVO0G+DvY+Mk10DHN5KkNudl81ub
 6iwnU3fx01dVAMigPL3A97FDaOd+jK4s7XxGVXKlR4Su5IlOJ9/TKNeQBb9OTSa5GeJMERwZ0yn
 Pys35P/kmcV6icYz6sioxTa9862PhwcuTioh4ykez9rrjbO/w3iebp/By7Alt3ysBw7bxZqatHJ
 rkdww+ajnXHGopsJ/56QfjIHE6v03I7mpr78Zu53Fe725D22for2L51EXFDF853wB2rAb1bt4QN
 hWDX3TNc8dsQkb4=
X-Google-Smtp-Source: AGHT+IEJJfWqn8HG5Wqoi+KU2TIVv+NC3m+V2CljxwrPvvjswy7nRBwRTHoW/jQsUtDn7gVDgH1daQ==
X-Received: by 2002:a17:902:f70b:b0:21a:82b7:fea2 with SMTP id
 d9443c01a7336-21c35502582mr60469495ad.15.1737133431145; 
 Fri, 17 Jan 2025 09:03:51 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:50 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 8/9] net/e1000e: Fix xITR minimum value
Date: Sat, 18 Jan 2025 03:03:04 +1000
Message-ID: <20250117170306.403075-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

The ITR minimum value may be a mis-reading or ambiguity in the spec.
Section 10.2.4.2 says the maximum observable interrupt rate should never
exceed 7813, but that is in context of example of the interval being
programmed to 500. On the other hand 7.4.4 does say ITR rules permit
no more than that rate.

There is no minimum value specified, and zero is explicitly allowed and
disables throttling logic (which is already supported behaviour in the
throttling code of the models). This seems to fall outside ITR rules, so
should not cause any limit.

Spec 7.4.4 also says that EITR registers should be initialised to zero.

Remove the minimum value from the ITR and EITR registers, and set ITR
default to 500.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c5be20bcbbe..34bb5f8096b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -51,8 +51,13 @@
 
 #include "trace.h"
 
-/* No more then 7813 interrupts per second according to spec 10.2.4.2 */
-#define E1000E_MIN_XITR     (500)
+/*
+ * A suggested range for ITR is 651-5580, according to spec 10.2.4.2, but
+ * QEMU has traditionally set 500 here and spec 7.4.4 ITR rules says the
+ * max observable interrupts from the adapter should be 7813/s (corresponding
+ * to 500).
+ */
+#define E1000E_DEFAULT_ITR (500)
 
 #define E1000E_MAX_TX_FRAGS (64)
 
@@ -2831,11 +2836,7 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_itr_set(val);
 
     core->itr_guest_value = interval;
-    if (interval == 0) {
-        core->mac[index] = 0;
-    } else {
-        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
-    }
+    core->mac[index] = interval;
 }
 
 static void
@@ -2847,11 +2848,7 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_eitr_set(eitr_num, val);
 
     core->eitr_guest_value[eitr_num] = interval;
-    if (interval == 0) {
-        core->mac[index] = 0;
-    } else {
-        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
-    }
+    core->mac[index] = interval;
 }
 
 static void
@@ -3500,8 +3497,7 @@ static const uint32_t e1000e_mac_reg_init[] = {
     [FACTPS]        = E1000_FACTPS_LAN0_ON | 0x20000000,
     [SWSM]          = 1,
     [RXCSUM]        = E1000_RXCSUM_IPOFLD | E1000_RXCSUM_TUOFLD,
-    [ITR]           = E1000E_MIN_XITR,
-    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = E1000E_MIN_XITR,
+    [ITR]           = E1000E_DEFAULT_ITR,
 };
 
 static void e1000e_reset(E1000ECore *core, bool sw)
-- 
2.45.2


