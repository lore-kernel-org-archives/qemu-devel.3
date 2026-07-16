Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79375C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPn3-00076P-Ow; Thu, 16 Jul 2026 13:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPn1-0006t3-W4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:28 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPn0-0000WS-Ey
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:27 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso4795659a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222545; x=1784827345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RpLsNVoi9MP1a6H+NZ4QnrSsQSxyH85XlPl91aINz4=;
 b=nhwpw3kF7+hAA2f0x5Eid9t0Z+bqM3Op8bMnj/1WIHJoIRtFEFV6Slodf3WNciImfM
 StuuNeOiYD1Isn4HAPfkcEFOmFfOWxFsUa8zEpmuV6wXt/3SiyFplJYyE3wKMLq0FTZ8
 w9OC9x027wCirREVBq6AKZHrKXJ5uU5ArklTbl52T4Hc5jwFboQhTPzu8qLMczBFAgYs
 cJlDCRjHkGj0oe05hR3d3qGgJ7NWXAq7uu9I0uRMAKYfiZxBLLPMmlBeFbmZ5WPQbv42
 JqThEQmGlwm1uz3kj06SvJ/6YPu2OKKJHcid3vDY6SarWI5gjdmUAseHLyfJ/h/CvERn
 R2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222545; x=1784827345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/RpLsNVoi9MP1a6H+NZ4QnrSsQSxyH85XlPl91aINz4=;
 b=N2m3PBniMWl6UgLygDBfd6VkeXHIljJIEuiCXfKuWcDsXZyGspkfOB98GZ4PG09iSr
 0Gz/2kMKS7bI1Rr6nwxgd+tKW+yKFXroj7LTL6Bkd6ds5tkqRPFxVl5KlSCgTik3/RjV
 ri76zooSlbl2u4FyRgMDlzvdlYAJfaq1zwu0Mt2eN8c1yEpIA9irqIeHUKGX6hmwJKs8
 ROiprf1EZWo8iZs935o+d+C+9kUQ0XLpTMQptbvj6r9wkgIJbJN1iQ4QNHhWzwDXUd7B
 alhdaCtWmvFyPeoGafrtkhEGqWRc/gbOpjyZQYyTiSiI/ktXTaJXhaGnNmjD4eXdfVZE
 Jv0Q==
X-Gm-Message-State: AOJu0YzOuqmkZMHsLnRbBoPo4Fedr4qiLrA0Ke9n9pQWBQVz7kmwpkNg
 txHgI7JERrXt3lLihlUNQakTjDPYp6qFuUFMUffjH8Rda2yt2mDaYLcwsQ0Ie3UyxkY=
X-Gm-Gg: AfdE7cnwtlWJD5IbivMbyoiGjIX10pwlwrrSV8FBn5huJqjM/RdH1NoO/AR20NIKWAh
 RzqXoARJnDk8AHk6L4kjIFjArm+71Utas9fyi7NWOJKLAst/1xLv36UJwUsEwyE6GDdeSPvx8P3
 u6XR9OxYvHWhHYhLkOUrl/vVPfmM4+vhW0n6Liit9rkQujFWMroQ0V4I2uGIeHlzXTCY0K+Wa6T
 RWDoPrpjqY7bB2qNnF+MItYrHEubkyR25+zD3r+KjoB/NARWl0zb8abM2kbAQj0Em01+mq2eXJ4
 9DinSoRKUm8Ememe+hDSU4E1nl6UIJSlh+Pvf7A0Knmeqx7qSWQlk0oW2qN1T7gATHMvt6QI/OE
 T8up+Ovun3YKpvdLU2wDV2SGeaFhHgu8g9G7KxA/MqzYWqzeWU0ecIcEkUxsvpCklazyQfXBfsF
 xshDypPqNeqm0VtycC3JJRcNX1pvxABQ==
X-Received: by 2002:a05:6a20:728c:b0:3c0:9c19:6583 with SMTP id
 adf61e73a8af0-3c3576391d4mr12982079637.61.1784222544765; 
 Thu, 16 Jul 2026 10:22:24 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:22:24 -0700 (PDT)
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
Subject: [RESEND PATCH V10 13/15] monitor/hmp: Add holders support for
 hmp_info_iothreads
Date: Fri, 17 Jul 2026 01:20:54 +0800
Message-ID: <20260716172108.87700-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


