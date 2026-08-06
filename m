Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8121C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4hC-0005b6-L6; Thu, 06 Aug 2026 16:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gS-0004Lx-Cd
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gP-00053Q-8y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2824944a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048034; x=1786652834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXw3JpLk88kYCumIZlgonrFgtVcpDQ29a7De2HxhjDQ=;
 b=YVLQXlVpm1BqOtjqhYGde5GCueCGGfZW1F0eNuh78nqbNV7n3dLNlwp19l0lPHOEr1
 4YbU02EUKHnTgfa9++LprmB5B+GewAZTgk1iu4EzBFNsCZZGygni7pRSKWVAk1AL6t7B
 bjKhP8I7Hqvxj1SZNCNQrbLo3prEgrN/XGYe8S/jwfvKYBoVdU5fBrYb1OulWpDXtszT
 j3bUD3R8kd/IhSxOmjJmgZZQ1MxyenXuyTamBeuYrXHWcEwqGhbxUuJaodqt8H1RrB3o
 3KmcUJxAPelWDsSAfjX5TrO6JyA13wQG4WaPDOPIyr9u2zuL1NckTUkbpHqOeBuMp3gL
 2j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048034; x=1786652834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fXw3JpLk88kYCumIZlgonrFgtVcpDQ29a7De2HxhjDQ=;
 b=dSl/WJW+k4GfsfcbzoZQpw3HSf7l0H2Hf3xDBed9fXRPQpBZAgqJykilkza+msZYyC
 JL/b3M408VHW4/oHEkp+aAPkrmLQCpBMIRXWp2IIcv+/BQM55Ze8rrvA8V7zjyx3JgIP
 9T9UsoWzMB5DvfOK/jYKXp8bP0BfwfQ36+TvObKs+zf0cXJd2z3RQZmdvQ2VCSRVZ2Xa
 kCuDWbM8m1qIgjNBvBKf+MbE2qyQNTsUvjkjcYpmkB/tIkxz176j7EaYJFpUfz7xDkEE
 iWfuiNM9mb5Quhz1O86j+fCBGYYuP2p8OL2YkpH5RuO99kvL34T3C3jGqqTgu92FZKR0
 WBww==
X-Gm-Message-State: AOJu0YyDJZZxl1uXqxbrudNACbibpVdYkvX8GR8jhxNyVmnFeSln9ByB
 t/dNM1CN1lx6qPXNJthHILG2Gs55fYzcr6Cu8nLsX9XA/LmX8r41cNEEB13EZ77F7ciKbxLZ
X-Gm-Gg: AR+sD11+371xMoFB3yfX02wFrmVtk6CbwVrCWrwE+5QdLqc0mvPNVm/ztaFy24DCRdj
 +sLhSr6A3ijSp376KW302R8QBRJ3mddHTaf71DylsvAL/3C0lH4DxT5ZkwmElI83+wMnOh26UpM
 Oy+kLYHgpH6tmgJYbJlo2B8zllPrO/xmHE33+7hA+9VceAraMmUSqasAfn2dOrj88DoPswJMiba
 L+cRwXWLbrDGJNyV0aFfnI4ZDDAiqlTALI+LMReP6Jo4VBrvxcXyljwII9T17RnQHqAhUf0/t40
 0yyVPHeJCx2iVNpBF39IuyD66GCNwEOfSBvw/XG+XMu9slcDJC7oCtwouAiuVvmiCvD99XfhuAT
 yCkzkOoHU0aCTP5QSmFJJ14NCai01Bsh7BujgEEHRQc561MV0zUSdTz1+nPA/b6Y/Sjpu1l17SS
 G4OWEJTGXDkkxDr9y6g4tBgG4rYx9YlgEE/P2tKQcGBA+ZO4UCew4Dyq6Ak9QbgJcYUmsGZN4wS
 K2TjHx254awpb3t8w==
X-Received: by 2002:a17:90b:2785:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3903c5f03a0mr19648526a91.17.1786048034065; 
 Thu, 06 Aug 2026 13:27:14 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:13 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 13/15] monitor/hmp: display IOThread holders
Date: Fri,  7 Aug 2026 04:25:22 +0800
Message-ID: <20260806202531.243806-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1035.google.com
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

Display holder information in info iothreads to aid manual debugging.
Omit the holders line when an IOThread has no holders.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a..de37f83a72 100644
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
+        if (value->holders) {
+            monitor_printf(mon, "  holders=");
+            for (h = value->holders; h; h = h->next) {
+                IOThreadHolder *holder = h->value;
+
+                switch (holder->type) {
+                case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                    monitor_printf(mon, "[block-export: %s]",
+                                   holder->u.block_export.export_id);
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
2.53.0


