Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30B0E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAfp-0007xn-6j; Mon, 29 Dec 2025 05:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfI-0007pi-69
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:53 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfF-0000GJ-SF
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:51 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so9029499b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767004788; x=1767609588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5O9XwvOZjmNoe2JJ9aP4ZO66IgUxzTTJkBQs1eogz1Y=;
 b=Yq1+rMqzliSmjfQMGXTI3rsjGVjJwyAY8l/hMcpUR7cGoQgnDOum6HQhytVN2Z2kFU
 dp0xaIZEveknyoI+CXFykBggXYb5J7a8NIbnsBYlBIGST0mJHzEQjuClNeCB6CTd4QGQ
 1QVesql1i8XlnYgZpF15erBSuV+Q9JV3tWrgoi4pYCEOaLJk9M/UgSbTvVs6m0dKwkp6
 JaC5C9nDEjep1T6gQ4pakAI8E+3Yl4xz2UID7+gd74sdoevQYlZwPebiHQw2dmzfwaKn
 8Gl/yAZGfjPB78/M7h9qJx/SjltAG8jLLcniIifXo0gVMGFinqZCcOvdcPCycfFpoUHM
 0ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767004788; x=1767609588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5O9XwvOZjmNoe2JJ9aP4ZO66IgUxzTTJkBQs1eogz1Y=;
 b=q4eM6isnzbPv1XEk367ujivDoSweZNCR0bWLexSob6QnMBjiEO4G3gm4P/dH+cVD2J
 t2+etAnewVbxCQgKnsX9ZbkQu46VuvfkEPcEJ97w6nT1CKCWCBuFU6qzxaGx/gvQfVGj
 9x3mtG7LfIpmrtXo6ODhhrZGfVzkDsBNz6KoXNdosZvBOLQj18e8eEbOQhdNCpuVfDLT
 evRjrYsjP8rw8K2wKfdQlbsdapvj4JC26rxt5wGxBJh9PdW/X/NYDK+N/4kQW08cTYUX
 NPzFgkzag5nSeRNNwj/qbPdywaNgZonrao44OaQEwVSnwNVujFbtmIKkben3sd2rKKC4
 xI7A==
X-Gm-Message-State: AOJu0YwVh9RraEU4ILuDFIe8uteq2oU6pfCiZKOx+LqO/ZxIKAR+neEM
 xQBh1HGMdb6AAQCHCMtg4JiqwKT+RFvNcn12Jkzmq4v190383heOy3RT0/Le99pm
X-Gm-Gg: AY/fxX6RGliIt828DaFK5Nd+2IpyWDULSR542kHAUGDXqsGaqQw6Tc7u5UXVZNu12f+
 g/75xd6kAklM4AD/9ar34U0P0YQY9osdbDz08DIca+eVmonV62S5J8NlSh60KxWh968pTrBHuDW
 FsR43hJP5RrDi0jq7R7vdk3OBeieLIZ8t6VhM6Klg2JzPL0UD/i0IHGyRmCgLwAG3QQr65iwCCs
 1kUuK88Xb4fU2Y8fbBkjCKQ+yG4hPWRP70mtqI/w8VWShoIJ9goRieku2s8eIaTalVvom61TudB
 mjCGlSLCn1llwP3KZ2w9gtw2MGmdRXHzsGK80zmIdDzpY+YpHDNlBGZuBm4vhTptNNngMSsINLq
 tOY2q8Bi/+titpUslcVMELnd6rbNkkoJTsJYJ2BseWYNLhcEiFOB7TJFIUOmgAiMCYtuxHiVmns
 9R2HOcdGSFdEY=
X-Google-Smtp-Source: AGHT+IH10HhTQ+mFuRiSb7wof8E9Uk4JZJt+DuyUl4Bfys4hfgLBj4inFDIzk+e9TR63QG400pVARw==
X-Received: by 2002:a05:6a20:4309:b0:364:387:8f4e with SMTP id
 adf61e73a8af0-376a8eb2c71mr29986034637.34.1767004787714; 
 Mon, 29 Dec 2025 02:39:47 -0800 (PST)
Received: from localhost.localdomain ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e76f03baesm17082982a91.2.2025.12.29.02.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 02:39:47 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH 3/3] qapi: Add thread_status flag for iothreads
Date: Mon, 29 Dec 2025 18:38:59 +0800
Message-ID: <20251229103859.98777-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229103859.98777-1-zhangckid@gmail.com>
References: <20251229103859.98777-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x429.google.com
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

The thread_status depends on struct IOThreadInfo's
'attached': 'bool'. Show in the qmp/hmp CMD with
'attached' or 'detached'.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 1 +
 monitor/hmp-cmds.c | 2 ++
 qapi/misc.json     | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/iothread.c b/iothread.c
index 38e38fb44d..fb4898e491 100644
--- a/iothread.c
+++ b/iothread.c
@@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->attached = iothread->attached;
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 33a88ce205..84b01737cf 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  thread_status=%s" "\n",
+                       value->attached ? "attached" : "detached");
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index 6153ed3d04..2eea920bd2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,9 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @attached: flag to show current iothread attached status
+#            (since 10.3.0)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -93,6 +96,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'attached': 'bool',
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -118,6 +122,7 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 'thread_status':"attached",
 #                 'poll-max-ns':0,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -126,6 +131,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 'thread_status':"detached",
 #                 'poll-max-ns':0,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


