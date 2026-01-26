Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8579FCF65CC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJ9z-00024i-IC; Mon, 26 Jan 2026 04:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9I-0001qx-Sg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9G-00015S-Av
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:43 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f30233d8aso28424905ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769420681; x=1770025481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfM1Ui6UpB9hYTqu57s4tI7ls03jx2MWBG0J4lV/k+A=;
 b=FaHm1uzyajVdnBI948cQcJG1ZEBVZwiq3weuj9ZlIAGvVJjUiOmCyitlAMCPCqLl9K
 kiX5i6Pn1I6ymQO1oYRCw0ZBD4TqXofLXI3/V79hcnelyvprRW2wXexjgtObiUNv0d5p
 JUT5SSJtNW1URViQeA5Z8tLaIpPOwu0fnL9ejk+GfSF8p1ElebCYlbYVRFcpC3ZKDkcx
 8W8oxbFTbRFmBmRDyAMKTIQm8QDcdJ9h6im8q/MufPm3BfSYs9mqNGlIGlLzUB2fMTg9
 Mlabp4/RWUkeEDSATjrwSNSeFdUxqBOIpCrQ7cL0OyQdbe1pXklseymJkHc9geGrEdog
 nK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769420681; x=1770025481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfM1Ui6UpB9hYTqu57s4tI7ls03jx2MWBG0J4lV/k+A=;
 b=aGjZYVBYgYY86OLfIq4HwD6TL7lg4UxGULTjowie9Ryc5NlAegr8Vdt6TN3tPCtDGG
 Px0HCyhgnlY2i9oOc3bpJHMIaLnRfnx1DByrexoYmrmZjUYXUcAD+O5aroDv4ktbyQV2
 eYvZsdQXwOpMFhRhVa53H45MGrae5LGx3BjRzQQSp9HgUWx2ws0zodCM2GpWD1g4tIE7
 TuiTUBDn6O8UTCTnvJRyCgucLsmMzQlqaVcZaD5MbaLiTFlxUoGmN9t22HT0TIIQsv4/
 7dBIRoVZ9ogWEMHvy0iQexXNM8pumNrjezsFmH2mN5DA0iVVbYbjokWJBJRaR2kCH6Xl
 IlgA==
X-Gm-Message-State: AOJu0YyrSKEa6Smp3dLoFSgit/p2Q5YVT3NaEqiGThNoZiC+n6QR9ZB3
 yF/X8+ePGXmDlh+F0as9g/1eS+KL1s6+iUiTjbtU0PnMJ9iVgRScVHgCE3t1zJVR
X-Gm-Gg: AZuq6aLUl1yv1xn/HvuL2kSnDX6ERhtrMC5rOFSlXX1VT62hrcw4i+bHQ2A4XiBxaH4
 oBqC/L3e3zp4I5Y1q55E1DL0LwEtzaPNSyQK+26AASmL7nVEN4Nli4B4nm39oghdoqSSugNww/i
 +kAC4iCQlH9rc/15IEmcxtiN4+kWQ8j2yjLCQtEwwyGhejnoZ3IpLQM7zQOHYgyXkPnkrS8uu6X
 1gCvtBTFMBUY6Tkii1mSRLd/4uYfmn3KxORFvGJEWNifuRsJ/pLf7MDxHdhHHzCLfQcHXQyx0oc
 +jl8W6QubCWYcd1khFdcszTt8Ld0jUijHbFHJ58roakoXehQUpKn4cSohoMP/yYaCdYqobe43Mv
 nrUKaaQPHRweiucutfSto4uIpLKYsEioEfJo6Jn8U9gZo6KvSXGgAafHXvRXBAa247AXra1PZVj
 v0tbNTUhsaEHC2A5Y=
X-Received: by 2002:a17:903:3bcc:b0:2a0:d5b0:dd82 with SMTP id
 d9443c01a7336-2a845323587mr32705975ad.61.1769420680665; 
 Mon, 26 Jan 2026 01:44:40 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f978d2sm85605585ad.52.2026.01.26.01.44.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:44:40 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V3 3/3] qapi: Add attached flag for iothread
Date: Mon, 26 Jan 2026 17:44:22 +0800
Message-ID: <20260126094422.23116-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260126094422.23116-1-zhangckid@gmail.com>
References: <20260126094422.23116-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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
index 1f5062df2a..cb865d6e48 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,15 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @attached: The attached parameter is a flag indicating whether
+#     the IOThread is currently associated with an active device
+#     (e.g., virtio-blk).  In hotplug scenarios, users can
+#     pre-allocate multiple iothread objects to serve as a persistent
+#     thread pool.  When a device is hot-unplugged, the corresponding
+#     IOThread is released but remains available, allowing subsequent
+#     hot-plugged devices to attach to and reuse the existing thread.
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


