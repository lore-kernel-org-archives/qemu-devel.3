Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C517CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSd-0005xt-T0; Tue, 29 Sep 2026 04:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTST-0005rI-GO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:06 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSR-0003vf-So
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:05 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a49b6bb21eso409531a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671502; x=1791276302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iPmOtLIRXjhOE0Iym+HCcfkISTVUslh658pj6SzglRU=;
 b=kGU0RVFTlMmkoMqjmSBDUS6RRB4hijFhczI3IEOc3u2rhvCKrhM8Sew2KSPWm+o6XW
 VyCWA/ARvfHkt4boQ0lGmr1nv+Jy4nOA5N9DJYz0BFMPKvNLm1TcICh2Crbpagru73lt
 58Jaq9xVmblkZ9aSV04AsZ5vKldGFLSaoajkN4+JoHGezWuaIxkKDBYxBXq5FMMDbdIL
 /adO4uiKY17PK/wI42Of5fPA3bdpV8Hp9wCNB7gwIAzauQFl8LSzvseAeT67Z8sZI6TY
 jayrkLdpZKWp98Y4pWwOX2OndQztY3peQTZfFNp+opVE1r6mheqaQ+rrpE+HbOi+zy4X
 jjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671502; x=1791276302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iPmOtLIRXjhOE0Iym+HCcfkISTVUslh658pj6SzglRU=;
 b=ynTuhb/4huXdQ9zc8d7ZsL6zoWAjDY7rPQtV0kkjX2yDd54qBltJQp53Xt9kO1MfGQ
 aUGTwSkRl1+Tbsy+ZDP9/N1AkRHJnsI+cS1NXez1TsMEiTTQet8MejlqBMBjZuJ8cCiL
 0VBbNLK7NiV0ZvPyJCf1VQLEcjYyWwEws3xuNmtsCSuUr7VOCKHFjdsdR87YM3TiNlcA
 M2AvR2lgOspD1/U5gueNeVwhkKMCZV9JoE3leuc3zRIkOJkivn+zbLAd9wmSLQvBP/c6
 3wVn1JHprkVq72kxw7fnLWEaEgbqIwkC5r0qZp+z1hTSR4LRaOBLj+rqQF0KGR/nCnpc
 wybg==
X-Gm-Message-State: AFq9FYKAWjel4MfcSjFkECiG6giqiJA1aYWaJhV2vIJEvMumvsQmBbK3
 Jch6KdUG7G8jexpwk6BEd7x7+czAmkszVUkw+YL6uMlCrfxKYfPosNdCRrJNXhAz
X-Gm-Gg: AYBFou2AuDltv7b1acoC/M/XYShs6opxrY8BWA7Gh3RKvtigyf/FD7vc//akiLYXRit
 1bL9TBaMQxondFuJb8YIMQps6lmB5PsJkV1NK7UEw/kRmKHJaXHUJPWQCB4GNKrecGTBC+vSe9W
 f9dn5Qgd6rX3WWESN9ijsv59+vVsjso8GNngs/wJ/TtZX01uRqoOx1VCnHZgrR8mXsJbKmGrKj8
 lyutJxvBQv/BQiqMmjO1dNHv8clEH0lzzS7chESsoVgArCa1HXTfocxXOVZCtzHqdMOffN5F88g
 Z2nig8s7aXRJOOYrwPRQAtY5ZNFONRMPoaiI0tIalPBWZWSByrGPrPuxR8IqFupbzGUQdYynsfy
 0u1+00XR18sKaVNyRz8l8s/z86VHkMEOyJ/Y7OSz3/JnT5Bj9M3onwHvHA+nCDqVGRoZj8xpFrQ
 v0TNZwmCmYdIwphJjVHmfAkLosjkM3xki3eOMYHYUK6Bi/goGSzvtvmcDlc0rmK0D2kdj+y2HNn
 /e6GQ6yuE3bzrExSG5JaAEKmtI=
X-Received: by 2002:a17:90b:530d:b0:3a4:a370:d888 with SMTP id
 98e67ed59e1d1-3a4a370f2cemr566728a91.20.1790671502235; 
 Tue, 29 Sep 2026 01:45:02 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:45:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 11/13] monitor/hmp: display IOThread holders
Date: Tue, 29 Sep 2026 16:44:14 +0800
Message-ID: <20260929084416.1600199-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x2b.google.com
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

Display holder information in info iothreads to aid manual debugging.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9b1b94f8ea..7f1b6c35fb 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -247,11 +247,31 @@ void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_hmp_printf(hmp, "%s:\n", value->id);
         monitor_hmp_printf(hmp, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_hmp_printf(hmp, "  holders=");
+        for (h = value->holders; h; h = h->next) {
+            IOThreadHolder *holder = h->value;
+
+            switch (holder->type) {
+            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                monitor_hmp_printf(hmp, "[block-export: %s]",
+                                   holder->u.block_export.export_id);
+                break;
+            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                monitor_hmp_printf(hmp, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        monitor_hmp_printf(hmp, "\n");
+
         monitor_hmp_printf(hmp, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_hmp_printf(hmp, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_hmp_printf(hmp, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.43.0


