Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE85BD262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 06:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRuZ-0001wE-9M; Wed, 21 Jan 2026 01:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuH-0000OA-1j
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:33 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuF-00013U-GJ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:32 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so2938271b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768977690; x=1769582490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olYl+ojj5pAUGzCeG4J9qYl7b7WfDNvlaOE9LiAmEu8=;
 b=RDNvF3RyuvlfyTMAOXorQmMFbftNOYXfN0rfrpt1YwEWV3t3ve3rd2ib9ziAE2fOPz
 W5qrD5c6seqwI2noEkTDehNczFiPXDZeryhGWUBDeIIQt2g4Jul0zwWRZGrleFYeVp3M
 qfwW39LZVCXtv9/ymDJZ5ssUrzkfER4ce3Z/IPsgR2YTuVgn1LwPsPAgB9teCO+mdyLZ
 1/lfUV9vlkmkO+2aoYFz6T7Xk3oli1Sn/JBs6Dgpki7lfDu2qfNscE1oD0cFvMlRUrcR
 LkV52yqe9ZIzwAJQd9I6mR77X6cScIDljWEJsOHTWmRaSHwWOh7j+XOQqW/XPq6BBZ1R
 jCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977690; x=1769582490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=olYl+ojj5pAUGzCeG4J9qYl7b7WfDNvlaOE9LiAmEu8=;
 b=BfRbdJ5e4pUy8W9G1h6h8gLELGIFkSRWR1zcguc1YbP2luEQ2WTmRETLCCyRcwgtbC
 O9FKzZKtMRJRYmwqLilwomSdwl4vmOTj5Iwo4jzhKbGY4qyxCUE9YxrDUUXWcZ5sSrh/
 ABz3OZj0cbaykeozGnmI9i9Wkw0dMQVmawRgxpe4VAydVzdGhlkwH+k4rZEbALEPMMfw
 ib9i7IgX6wSosZAUddYqFfNyzyDJSyvqn0dGgOkYCvhcR6D4elSNExaDgixpZCA5Sn3X
 4ExsDstCrNl31b/kQx2BYok2OR9KDSQWsITI1N/CGdGtdYaO7gif3vcUTNQk1HkMEkQY
 Y0CA==
X-Gm-Message-State: AOJu0YyCB0mUg6jiS+o83bUXSsgU9hVQ2DFZTHDhCr0le0F/+cb7uMO6
 eQYbC8CpIN8WmAZ4WcTAx3EBmaFakwUoF2hGb6iv5WouEW22otx/14l1bjr1awgt
X-Gm-Gg: AZuq6aK7C3qYP2zFin/i7mNkZqWejqOslubNahR0YBN6YWPaHBTul08W/8Gm9iPAjfP
 ugKYe3GwSACZHd7UhVJ/t0Apa/iP7f2LJRGr+skAoZ/dhhEqdfKC1mkcs5Pfb9r0veeYO5IINsO
 qoa+u90pJj8ZqoW0uAYQvJjVrqFxHKcTSqyZXYx91hvCjkU/3P2Dx38BBBrE/aDSIe/UZdIpreb
 SUYQYX8l2LZTLFJDkC7FLNOi0AkaM6MugPTRO54sI5Vxno84cBatJuNnYELfKHOeg/c8czQbuw9
 sgBMXccHgjquVAMt/LAIciLAUHDHz9n2eMEdfqEhetgjMpXW4Zzszk7eYivOYELBXX1mCO3uuFR
 MuWO2M9cU30odRZBKxIHjHX0OhIHcZK04LFnneRF9Hyj/EGQTriSpkblVke7GkpaKY4qMuV26Rc
 TXN5CBcLqdc1r1B5P9nH0+h6yyZQ==
X-Received: by 2002:a05:6a00:896:b0:81f:99cd:faf8 with SMTP id
 d2e1a72fcca58-81fa1780c4dmr13120941b3a.8.1768977689758; 
 Tue, 20 Jan 2026 22:41:29 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b3165sm13876714b3a.60.2026.01.20.22.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 22:41:29 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V2 3/4] qapi: Add attached flag for iothread
Date: Wed, 21 Jan 2026 14:41:09 +0800
Message-ID: <20260121064110.28760-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121064110.28760-1-zhangckid@gmail.com>
References: <20260121064110.28760-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x435.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The attached flag depends on struct IOThreadInfo's
'attached': 'bool'. It can show whether the iothread
is attached to an actual device. Show in the qmp/hmp
CMD with "attached": true/false.

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
index 5a673cddb2..7463f34bf5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -202,6 +202,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  attached=%s" "\n",
+                       value->attached ? "true" : "false");
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index e87994c9d9..99ffd45ce5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,9 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @attached: flag to show current iothread attach to device status
+#     (since 12.0)
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
+#                 "attached":false",
 #                 'poll-max-ns':32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -126,6 +131,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "attached":true",
 #                 'poll-max-ns':32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


