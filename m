Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87251C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxw-0006F4-3Y; Fri, 23 Feb 2024 11:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiz-0005d7-Tg; Fri, 23 Feb 2024 10:44:33 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXiy-0006Mt-EX; Fri, 23 Feb 2024 10:44:33 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so865137a12.2; 
 Fri, 23 Feb 2024 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703070; x=1709307870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX8n0tNdAmuLPTHJh8fiQt/+xqsTkEf/Jf+VNbC4LxM=;
 b=PyhzZFElxpej+J5oeBqYPslWQdMEiHlM2Wc0MjrSHFMICAdcK25fII3f4CPrHNTmf7
 Ry+9BXf+sB+kzLyo/j6e8miaPW4IGMK4khy1UMHizTMcvRbmob716nizabMSz9zgs5LD
 /77bKbIbEWi6DlnEQliGslBTrWxx8Del2jHi57A/i1qeqimWoDVJHFln42bF/rhwC12c
 WOWbgbupBE+v9lrCptIVFcnNT8oO6z2VQyzDafEFjw2to5gAZOpmqB/eQ/5xNcj4pOCA
 lT8infcZqyIIIbLAIanILqADU0//cfGucwgSJBhCm8Yh3Me+UeaZnxHyRnKNt1MDC+iK
 7qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703070; x=1709307870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX8n0tNdAmuLPTHJh8fiQt/+xqsTkEf/Jf+VNbC4LxM=;
 b=EWaU+tUq2N6/3vubklx4XoA7yw/YcmBZYSN4ZStZMRGDrDVjW+rx8lC4D+DrYam1AF
 UjNKaUFuyF2lJBX3QGakGW1lxw+CYWb1pkzZ+O8eRY6WGmIS96ki+HLwWJVAIADhyZMH
 ctCm1pcW6k7lKULXgghnjKiguWMZG2NvZTL8s0ldthjdp9KSXLjKwlflw0wLV178iRNO
 HibdFr3opBSKkW427jPnQhsZD8mXPWjCycLuROrP5ihoQLSW8/xQFh4ef7z2UB0ik670
 QZc4q5qj8oVSEMlPlDJptvS4wampj8/553Kc/c19i+mF4pR2e6nf/YFCsUDiVxM7EgUg
 pgVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVod0bzMSkbq0FVy8kF1rbPvumKkL+Dk2JUApx3jon7NZ3ejPdEJlUARXEo0AdNBXwRimeCJhfYX5jiI836ZKGugZA5
X-Gm-Message-State: AOJu0YyzBfv1/+LwMEWIAVadeloLpncKFszO3WNWzdFaojeOL7z/vLgr
 5cS2dhUr/lQLJjesStWvEmpYQFb1E2KVKHBatojFzPaxywGyYLJJLS5BtG4L
X-Google-Smtp-Source: AGHT+IEsh9ucUQtW13McWTbgsEjl86EpFK/eXeiX1wjbPloBQ17yIljMAnbSnEziA1uCsuGoUN7WeA==
X-Received: by 2002:a05:6a20:9f07:b0:1a0:a082:b2b8 with SMTP id
 mk7-20020a056a209f0700b001a0a082b2b8mr220481pzb.33.1708703070559; 
 Fri, 23 Feb 2024 07:44:30 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 20/47] ppc/pnv: Change powernv default to powernv10
Date: Sat, 24 Feb 2024 01:41:39 +1000
Message-ID: <20240223154211.1001692-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

POWER10 is the latest IBM Power machine. Although it is not offered in
"OPAL mode" (i.e., powernv configuration), so there is a case that it
should remain at powernv9, most of the development work is going into
powernv10 at the moment.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..b949398689 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2242,8 +2242,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     xfc->match_nvt = pnv_match_nvt;
 
-    mc->alias = "powernv";
-
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
@@ -2267,6 +2265,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
+    mc->alias = "powernv";
+
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
-- 
2.42.0


