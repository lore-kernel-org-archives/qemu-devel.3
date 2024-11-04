Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFF0D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kq0-0000f8-GO; Sun, 03 Nov 2024 19:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpz-0000ax-3U; Sun, 03 Nov 2024 19:20:55 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpx-0002dx-Fu; Sun, 03 Nov 2024 19:20:54 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so3037947b3a.1; 
 Sun, 03 Nov 2024 16:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679651; x=1731284451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEIGqe7PKMmIVL8+XPUOIg+FX1T8unIwew41qiim4B0=;
 b=lht5W6m7j5PltVENZQOheDxVpcHo7thcdHiwuFskioZLS9pr1sNVqe2FMSDSyzoUmF
 mPsn26GvrriTX7irWv1rNYWDdWMrHKYLjNzQbJiQGa03kzoa3EcHIfaiCZNVMoocjxCk
 +pZJJtAsiowWuPWI8w+9SdmII8KO+Gfv8D1qEJ4x+L0wVmrWSJGhS6W+D7XvkBkddMVn
 bENYWddizjgWGUWwe//hJH5b66tpKkdKkwiDGX5ysBdJJtVstnocHPdaa4HLQhcU7df3
 HcaIYpNLomNp6dZFh3ssnvj3TIuSrDyMQfL2XtiFsyKZ0x3V8CWxUd8PVeQYWbRP49gC
 msWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679651; x=1731284451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEIGqe7PKMmIVL8+XPUOIg+FX1T8unIwew41qiim4B0=;
 b=Xi9KgKn7njsq/Fyxr9PMCd356vKrsn8De8UAEeUoGfgGRUhbXjyxyNYobXrdcPj1Yl
 s5IHScG22Jah0kkyYs+GT4HjMq25knfjClNE9X4F6G7//HjbrwLhDtrGrmuY6xyPqHwW
 +h7oqWoODM08UShzl0hyHWcF1dJ91wLrHqP7jk/goCDpvr0IGbSQFNQ2/FyGxj+rJj7y
 cbORmgTcSipdA6h+EFVW1x9WnMQOYo0ED9XWYCs13HAQa7NSrV6+il9zrCn7nkCxl3ta
 xZwbpMNKAbj65U7++k/s+oGz+7CzQb05MX4wNGIVybLjo/ULSa9VTBvb5xXuf/kbqQma
 aplQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeHgViAL3nlOAvlpm2Eee3+jsiCj4GpV/ozyR4vF8Ob/Yhv5+MvdEXxHfFMV+gpVLTtiGDJos+Fw==@nongnu.org
X-Gm-Message-State: AOJu0YzmcFwSmz8Lk9p0iYEp6WTgTXz6bdB0132ErXOhUDFW6VDLH6pY
 ZGTwJ7KkC/43qqf2adb1dkdCSrmcwyGoKkjs3mr12NZoQ5pLH5o87SMX/A==
X-Google-Smtp-Source: AGHT+IF1B295fl2CzC/fWDQDBmzG+lcgzst2TWlvLZBxqo3PiiNYAHMybGuCQTsXl6vSZC4QlwmAPw==
X-Received: by 2002:a05:6a21:2d8f:b0:1d9:1dcd:b229 with SMTP id
 adf61e73a8af0-1dba54a4957mr14259161637.33.1730679651309; 
 Sun, 03 Nov 2024 16:20:51 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:50 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/67] ppc/spapr: remove deprecated machine pseries-2.11
Date: Mon,  4 Nov 2024 10:18:16 +1000
Message-ID: <20241104001900.682660-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.11 specific code with this patch.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4c76d2841c..faf88a177b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5054,21 +5054,6 @@ static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
 
-/*
- * pseries-2.11
- */
-
-static void spapr_machine_2_11_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_2_12_class_options(mc);
-    smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-}
-
-DEFINE_SPAPR_MACHINE(2, 11);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


