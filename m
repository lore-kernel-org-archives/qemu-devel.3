Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A7606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmcKBB6b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV648-0002mE-BF; Sun, 22 Nov 2026 06:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV642-0002ld-Nn
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:49:00 -0500
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV641-0007p8-40
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:48:58 -0500
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-3b4067446d7so367736a91.1
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 03:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795348135; x=1795952935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9aW6QxS7cs0xANMhoMpPUVT0BwKOmMM19GplgVY2WOI=;
 b=QmcKBB6b/8PugZ1VgGdt34QwFplJ06/WLDfHaWQiVuv8T5jWGfVkF4hsAwL9WHk/A6
 9yGSU1lnK5k0gw4VfzWjiCH6b7HVCtsHcnPwTuHpDFvHb4SCnkdka6ZGP1k2wu8176L7
 JbOAqN34ESMy3qBNWVH0xhseunSj5+hmKTmru3aMRqLVOOALXDij9Cg4EcwL9F02Kw49
 6b1Yyo/HmoXkQ9+QXJRtc/h4iZyLjbUavQg03v80Pf62hR8w8kRKzxKQC6gPdinybD1C
 U0BvENRGUWgcwq2Dg5jD5800vip8XQqee/VUan8ATuB/g4oi4c2X0uGYAxljoGZd6CUl
 vRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795348135; x=1795952935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9aW6QxS7cs0xANMhoMpPUVT0BwKOmMM19GplgVY2WOI=;
 b=hKwy+IBj/pGOFilH9ZH6IhlXEl8l51BMJvXdKzz0MYYeoBcMPUNs/sWKkAwcuFl1Lt
 ldaelULYFLbC1JBBcqTOBX8KG4SYVYYJ0GZMasxptrBIwOJx9cnc7WGSIdL06hFjiTZs
 07sipndEjr/6aNQA8nDEM0raArTy+fxUrG1m1TvStuP61voUYc0tbyUvBAeoXXOy29S5
 SlLY7OA2dQ6G54sk8PBLyFT4R+QJPWR+8IoYKblR89OLV7s8r0wNDYuu8oVNEjOZ9xgN
 cBuVMzuD/y6QjJbc2ckqC6WkgotC/4mGa/1Ms9dNa7b+LDqHK7zQINPCcRDQNWi93OxB
 gfdQ==
X-Gm-Message-State: APuU4Z8IReyDJw7nevL5QflFNzSF8alInMGEFYm7JUZmf1is2y4Z9sed
 o5aW15Qx2XwzUSbAUar1Ad6S4i1pNhF0bhA1E6ogfqxQeK6X34+glOqye7UyWLV/
X-Gm-Gg: AZFdTZdsDD64T0xxHqDWrd03k02ZHNCaY9vhCOPSb4rKNiWLDoQlbprALuZIYOAGgVG
 qTMpjBEdYZ1J8xA5ayE3EM6emeXbNCXgRnzOqOsCdaEb5js+wex/0BwrLXqvpdp4lnVDvKEMmbh
 8rb3yTDQx/+aMi4MpNykV3bhVDC36A6IkkjbbGK5+Ve1D8rHTrvXuEvVe9Xuesfb7pShfh4tgs2
 wOCPq2h0bIsJTFUugolh2lWi5IJso+uZFxC39GkfQrBzTbWRbYUdz9PhEYsEumHaucvlP4ywU4D
 oOkE4kUUUspj5ahJvb2uRJsv3YFKegPa5E6yFlnvJA5KeBL4iX/vc3DYHAD8VF0/3P0FQvF6ctT
 UGqFTElUFjMICdgDZYsgF12tIlUPrISzr4KdhILCmPOGeQn+oy2AhUAYuV5QyW0FQEj0FYP15gk
 5Yiccwjgx7oalhTPeQRlKMPQnQP7ujVOw7XT44/3le34kXmD7x1xi1qMHQAcy5raQMa+ulzuQE0
 3YB6Jk18J3twAs62ScJg18LQv6IZvkchGCviXVEcd2nODNHWouI9wkm8XxW5uBQ3DPLTdvmkGMP
 +njVDMddAtZQQRLvuDslweFvDNo=
X-Received: by 2002:a17:90b:2fcd:b0:3b4:1b3a:ae76 with SMTP id
 98e67ed59e1d1-3b41c964aeamr7352968a91.42.1795348135491; 
 Sun, 22 Nov 2026 03:48:55 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b52dsm13698947a91.5.2026.11.22.03.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:48:55 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v2 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Sun, 22 Nov 2026 19:48:49 +0800
Message-ID: <20261122114849.1672198-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122114849.1672198-1-zhuwei@sangfor.com.cn>
References: <20261122114849.1672198-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

hmp_info_block_jobs() uses 'list' both as the head of the BlockJobInfoList
returned by qmp_query_block_jobs() and as the iterator of the while loop.
Once the loop finishes, 'list' is NULL, so the call to
qapi_free_BlockJobInfoList(list) at the end of the function frees nothing
and the whole list returned by qmp_query_block_jobs() is leaked.

Keep the head of the list in a separate variable and free that one after
the loop, so the entire list is released as intended.

Fixes: fb5458cd10a1 ("qmp: add query-block-jobs")
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 block/monitor/block-hmp-cmds.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7bae4d425c..d3f404146a 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
 {
-    BlockJobInfoList *list;
+    BlockJobInfoList *list, *head;
 
     list = qmp_query_block_jobs(&error_abort);
 
@@ -769,6 +769,9 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
+    /* Keep the head: list is NULL once the loop below is done */
+    head = list;
+
     while (list) {
         if (list->value->type == JOB_TYPE_STREAM) {
             monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
@@ -791,7 +794,7 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
         list = list->next;
     }
 
-    qapi_free_BlockJobInfoList(list);
+    qapi_free_BlockJobInfoList(head);
 }
 
 void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
-- 
2.56.0


