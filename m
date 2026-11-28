Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE3606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6AxxgZ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xXDrZ-0007Qs-SJ; Sat, 28 Nov 2026 03:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xXDrX-0007Px-4Y
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 03:32:51 -0500
Received: from mail-pj2-x06.google.com ([2607:f8b0:4864:39::6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xXDrV-0007ER-1s
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 03:32:50 -0500
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3b4be95e0afso2840158a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Nov 2026 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795854767; x=1796459567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nr4FtpaGfNFkwiRxs8ounCMJmoWHiETeLGNPli+6bj8=;
 b=A6AxxgZ0VMRCnbsDaOqfKJDeEbzXujvzHqsXyQhKsBqaF+O0jhK9xdTkhRd3EgcLOD
 I+xqCnBNvupWhBq8ftgMOdG5AY1PcWJAdbbFhVazHQrbHX6DPiSQAPr0EhNgpQVwIBFq
 LBWIk/9dN25ODLWhXxOZoa42RYRjJ5tXMJm6faZjk0upMmM3yA8dz7ZMkDxRQoLLjyR2
 F5lbTTj+89rJDyLivAhJC7Qi5AuV3fs22VuWc4sh0Vt9XuYmra4R5QAnkSkSi2cpA8Yi
 lc6dbPWHJ6IoXPKKe9Ty/duWfewR99jy8GFjPl/sUKRhf+F0tX9MnjI1svCOUBb210QW
 RUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795854767; x=1796459567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nr4FtpaGfNFkwiRxs8ounCMJmoWHiETeLGNPli+6bj8=;
 b=leiQk9ChsvjJHY1YfFuCD3yNGPKgRdv6L8J0y4FyV9Tz2m1BwPc78Gw6GJzDE/AahO
 BizUh+b0i//YIJv5xBEFvOJbvWe/3CuggD4laME0H9HuY5aNtyRQFR4RdhPtD5SRPpK8
 +srjlB3mDrRFiuxRzE1Uop3eUsVWTbHpWiu37OVbVzAfrufcyCmGGvndAJUVsMlEJbre
 QVPYVyA/LNNgjB4j24dA2OZ2JHITk0EkeNfAdARE1FZvGu8pwQs11TlsDojxrRti+KSM
 WJfIB8KULbvkE8s5FkgOZro/WMJSqW+VBNYaKxqTA1ebAY6lGt+WUJbCi9ReNWmxJEd2
 h5pg==
X-Gm-Message-State: APuU4Z/e2/P03wKvW7F+eS76hHCgpi4vn33dk8wa5mB+4U1mTwjXygMZ
 tsee/EuLKEhNkjUPapntmuoX1SnWAjDe16RaaxE1DEK66D1ghUa8xKJ11rWkXHlG7/g=
X-Gm-Gg: AZFdTZdgB1umEFcWoTs9Q3AIDVBkWCgTmUELAW/llLxsYDmVamh+tlHJi2is9buVdiM
 Zv1XXCfPU+AY/6yR4fuPsOGaDCHg3a0PmxdVjXF09Kwn0A1PysTmRN0lkAOpcdDHnK+Wnawpqxo
 dLrWzx8z6cUdCVMvfJQ7Y8MYrHvBHSKpW0gkMUqMX6MyvArHyvYm2zw4eE3o87KuG0Fktwo+9VV
 Agj8a60QW3v4KEbG0gwlglIUX5yHBrXSB1pmOtXQMasB8ATXMOLJHtfq+0a7YHyiDlEZI1sE25N
 Zy+6jpEIsN/Ml4Nxce3GAsx0U5C/+DobvnJThsF+OqBDvEZVZ8cENeZv6e9Ocm1029sz/94jqji
 rexvDhrNuldfnR/JugJ9QxpJfiQl1I1Kx+2P4RGJqrAgCtY3VUtQsTMdzbsmsm5mrqD0WUx0VRl
 C9xh0JKVhmpqEmpYanr3aZijTDnNA0wpTIiBWDh5bpXG1fWnWJS19lAOYdxxfuYXsEJ8k8BFUFm
 MH0w/lUkBiMsMIc6evUxfLvRtPqUxf8lDYDKuPoam2QdMFrZIMT2ohQnfPBWTcGhTEEiyROJAlg
 HHU6LOPELRAkqHhU1IUfP0NRsUQ=
X-Received: by 2002:a17:90b:2f07:b0:3b5:a68:297c with SMTP id
 98e67ed59e1d1-3b50a689b5cmr10860735a91.66.1795854767097; 
 Sat, 28 Nov 2026 00:32:47 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0332bfsm14410853a12.22.2026.11.28.00.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 00:32:46 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v5 1/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Sat, 28 Nov 2026 16:32:24 +0800
Message-ID: <20261128083238.1434965-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128083238.1434965-1-zhuwei@sangfor.com.cn>
References: <20261128083238.1434965-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::6;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x06.google.com
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

Keep the head of the list in a separate variable and iterate over a copy,
the same way hmp_info_blockstats() does, so the entire list is released as
intended.

Fixes: 93bb1315250d ("hmp: fix memory leak at hmp_info_block_jobs()")
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7bae4d425c..9a3df965b0 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
 {
-    BlockJobInfoList *list;
+    BlockJobInfoList *list, *info;
 
     list = qmp_query_block_jobs(&error_abort);
 
@@ -769,26 +769,25 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
-    while (list) {
-        if (list->value->type == JOB_TYPE_STREAM) {
+    for (info = list; info; info = info->next) {
+        if (info->value->type == JOB_TYPE_STREAM) {
             monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
                                " of %" PRId64 " bytes, speed limit %" PRId64
                                " bytes/s\n",
-                               list->value->device,
-                               list->value->offset,
-                               list->value->len,
-                               list->value->speed);
+                               info->value->device,
+                               info->value->offset,
+                               info->value->len,
+                               info->value->speed);
         } else {
             monitor_hmp_printf(hmp, "Type %s, device %s: Completed %" PRId64
                                " of %" PRId64 " bytes, speed limit %" PRId64
                                " bytes/s\n",
-                               JobType_str(list->value->type),
-                               list->value->device,
-                               list->value->offset,
-                               list->value->len,
-                               list->value->speed);
+                               JobType_str(info->value->type),
+                               info->value->device,
+                               info->value->offset,
+                               info->value->len,
+                               info->value->speed);
         }
-        list = list->next;
     }
 
     qapi_free_BlockJobInfoList(list);
-- 
2.56.1


