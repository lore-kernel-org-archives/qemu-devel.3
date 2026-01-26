Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E71CC88E7C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIuM-0001OA-9o; Mon, 26 Jan 2026 04:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuJ-0001NT-RO
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:16 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuI-0006rm-Ar
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:15 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so2108115b3a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769419752; x=1770024552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xcEbVeMspBHBI/IGMwZd4bbdEPN1lQ0szLRZ7z8yI8=;
 b=Ac0qJ/5hsfRadR2VxBfnteFEQ9hvbvuovBmm+vaJ5N6WdfJleiUM72cTiLszrF0KrR
 0OxixBsUr5s/m/LrPTrOaqc8mQ/aNIgyKXs/MDWG/PbwSv291qmA3TmZqjuRG0HIJg78
 5P8Vpuk7m+IWKzfcJzA/e1k87NA0AW+CfABlWun7OdM3rAK3zORqlFiRxweIgyiSznHo
 /7tZgh1Iel/uVXKy4140FyAwKvuhcKyhCjzUekHNW2Rg5tTpTT3zNiPaWPfy90hMImwK
 F/BETNqDsDR4br62a8aGjAFLLWS2pJglXtPBEiOH5nNWViqKKQD6KoT1397+vx/Xhler
 PWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769419752; x=1770024552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1xcEbVeMspBHBI/IGMwZd4bbdEPN1lQ0szLRZ7z8yI8=;
 b=a+rYYMJ20496lOQGa5oYb+f3Sqnoyt+MeOq4kLhiXsaBJIG//5jQEvh2f80pzl0TLv
 kqLFRcGxDtFa8HieUMJEH1BYB9bs4RRwwYuY6q457frrjOOvkkstjQpvJFONNTaCDVvf
 3QIg/5NL86b5wNC9akyrk4wsDNReBxW1DAxENCPXQ3Rj7/B3wzQ/nSnrbA98o9RPjQVB
 3LPNImbrjH5CFosO7Mpu8p/hteUyTHBkbckUP3EGDdAqlLmX8V75rKVOay8foBafI4Jy
 m2RVJCZ0j7etKx2OiQETlKSwFFcufd8pChUgDMZrUgEtyXBRvSlZnKORItzm758yReuv
 E1zQ==
X-Gm-Message-State: AOJu0Yz+14aTNlj4zPlfsdQE609U+h625VuiFh+G3lIP30hIbzqFBoRc
 smR7RJT53IyUKHb4wvLLpAWMnWK8KJqWsTjshdRX1v8w1l7H0puHrF1FXN2Z1dsQ
X-Gm-Gg: AZuq6aLs65oAYRy9I3LZYwpr0d/fCBKKAkZ5CAKI7n4L9uk+OgSv6x8ZImGdJ7MUJEt
 HTiV2UAPOMP6ceKQdzDY/QBTUOjGpwq2mUh9yM1t0a9uZ1XYR2sNwDCaKksYyFP5KgvGS67ED/q
 cQj8Qx0QbZ/W2p2Bc7XC2Int2Tn9yRbwsOElZKNoDFNTVW9IsEapgGsa0EpRNiSIeWcBvCb1OyU
 NBjKVUPpgJtMeJo40X5xn8MvZdvABfWeZzY3UrifrGFHk7BLpugkdEInE9qn1ws7SOCcKllucK1
 GEQqswKXidkFg8xrg+WKtk3UQCSs8I6kW/lnQLzt9tS/XrVuXTL3LT27EFhLDrekWw7886LZU0M
 aEHmzIxrlgTiGZfyNMGCiSUxnfQr6bQ2WUZ7beBd4S2oFTYEvU4takCdugVVjni1FSQbDeNq6Zx
 LM+OrTJWZaWlEutN1H6r8JdjVDSw==
X-Received: by 2002:a05:6a21:398d:b0:2fb:2e04:eeae with SMTP id
 adf61e73a8af0-38e9f115198mr3565611637.21.1769419752416; 
 Mon, 26 Jan 2026 01:29:12 -0800 (PST)
Received: from localhost.localdomain ([129.227.88.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f97a8csm85568265ad.53.2026.01.26.01.29.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:29:12 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V3 3/3] qapi: Add attached flag for iothread
Date: Mon, 26 Jan 2026 17:28:54 +0800
Message-ID: <20260126092854.20343-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260126092854.20343-1-zhangckid@gmail.com>
References: <20260126092854.20343-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42e.google.com
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
 iothread.c         |  1 +
 monitor/hmp-cmds.c |  2 ++
 qapi/misc.json     | 12 ++++++++++++
 3 files changed, 15 insertions(+)

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
index 1f5062df2a..69e1e11e30 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,15 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @attached: The attached parameter is a flag indicating whether
+#     the IOThread is currently associated with an active device
+#     (e.g., virtio-blk).In hotplug scenarios, users can pre-allocate
+#     multiple iothread objects to serve as a persistent thread pool.
+#     When a device is hot-unplugged, the corresponding IOThread is
+#     released but remains available, allowing subsequent hot-plugged
+#     devices to attach to and reuse the existing thread.
+#     (since 12.0)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -93,6 +102,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'attached': 'bool',
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -118,6 +128,7 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "attached":false,
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -126,6 +137,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "attached":true,
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


