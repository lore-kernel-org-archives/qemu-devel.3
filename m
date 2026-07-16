Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6809C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNKF-0000YD-RE; Thu, 16 Jul 2026 10:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNII-0006V6-Fl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNIG-0007e6-Sd
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2caea3f742bso81219735ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212948; x=1784817748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RpLsNVoi9MP1a6H+NZ4QnrSsQSxyH85XlPl91aINz4=;
 b=HprA2TYpRZ46WLsY3/7ZsP7YjiOtsc4f1RzTe5U4WJqChsbu0drrfrpfzWOGyrLbfA
 rO0QvXtJf8x0hLHxjDVzFl+jtcVsoJnIM+GKNEcIy04ZOOFxU+V9f/BQKsV4CRe7k1kj
 RSJsqxbmzsTXqo7phlgKn8SEt6YWXykhlRfoHtzQuQ9ERAexM5w6G84+zjEZLnRtX1dy
 r2s121cFfH+P18DIaX6/Hs66J8vCySYKjBYm1y8Zltx+CxdpbAvqLckAky8GO6y/abhw
 6Yqi+4+yVeJ2YqcHemkbOc/wa/d7ZHE/fn0YPq/l8tArcy4n+non26nPIPZgCClG7WHw
 8L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212948; x=1784817748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/RpLsNVoi9MP1a6H+NZ4QnrSsQSxyH85XlPl91aINz4=;
 b=nx/cwmQEevpqYSfg5VswVSPutQ9quTrn4dG1jj3bpqFnk0AvxG0FW9hLJaJ5Bl39hO
 JbUWcLh7wHNSd31fGck40gn2gE0xTwgngIY7DlWrGbprwaUUJTs90NOy+hS22COlu6Re
 6JwvQgBXaahTF+KggGeAtjrybhXN0kZd5Ma0I0UulECKJCcuEmkJQGjZAOfgXdQWtCy3
 3SdYuUToZ/3GaJ+8Dri9QDWPZujKyEx3mi0zF1jXcqMndLfV01AdooJFZ/BgLTVJ8+d5
 tsiKpGdrNWFs90czYPEChD/4GvwbzZIJdlKo9lohqhK34bQ6axM2KjGCIFLcf/PMAxKO
 6z2g==
X-Gm-Message-State: AOJu0Yw7oE5SwYlCrcZlCbkcv3i5VYOYsL1sTfbFYqfB7X+ZZrmI+6Zp
 oKDMDfk6QA9o201VuAdlyDVHcQ627tTcGrMcsuOKCW4J2Zc0apVMfqTYznEEn1oZFOE=
X-Gm-Gg: AfdE7clmUDwzj36fvbXoRMjPHOG3r1h5cSkOm+4QemEOzL78Sp+rdPf2o3Uq4XDNzsS
 DDQfezi+35HwF1NW7QGqNOnyosQ7yUEgSRcuI/oeUEPDlf4GybfWK5qzHcrjw9/XW0jojp4mF2u
 LhEbMvlBESeO2rKqnd+guUEhce5dYrXhQt7aMIYz0MTN7ib9iHieVb7zRP8SW2ujhI2ZoOONYwb
 KHge1kU2OayAne7gFB33zqHzY/oxOcYmS9SyZXlPqQgG/DCzEKm+knUVxoi0plSDvV5IExdR6Cp
 oMiWzGpa5b6Z033n5e3fsI56JOVYLkkdYdvZFz3NgTKRTu/2sQIVTs8Xg8ADSr61VIZfbV8NhKN
 Rpq+15/4smmb2IX28b/E/4pBdL2IssV2rgKAxeG/NkHWEZ9PhObz+okJ1BgoZ9GjAyWiyoWZEpE
 TTAcAzCgIZ70ylqIabtmdJZBGAhH1bSDWOLWDI7MAHCBqmAxNHL0s=
X-Received: by 2002:a17:902:db06:b0:2c9:e86e:aa0a with SMTP id
 d9443c01a7336-2cef0f05baemr107223255ad.0.1784212947666; 
 Thu, 16 Jul 2026 07:42:27 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:27 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 13/15] monitor/hmp: Add holders support for
 hmp_info_iothreads
Date: Thu, 16 Jul 2026 22:40:38 +0800
Message-ID: <20260716144043.76414-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62f.google.com
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

Exposed the iothread holders via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a..cd2d9c1d59 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -240,11 +240,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        if (value->holders) {
+            for (h = value->holders; h; h = h->next) {
+                IOThreadHolder *holder = h->value;
+
+                switch (holder->type) {
+                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                    monitor_printf(mon, "[block-export: %s]",
+                                   holder->u.block_export.export_name);
+                    break;
+                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                    monitor_printf(mon, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                    break;
+                default:
+                    monitor_printf(mon, "[unknown]");
+                    break;
+                }
+            }
+            monitor_printf(mon, "\n");
+        }
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.49.0


