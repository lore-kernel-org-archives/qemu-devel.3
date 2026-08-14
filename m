Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB69AC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw2B-0004mi-Qy; Fri, 14 Aug 2026 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw28-0004Y9-7r
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw25-0007zp-Sy
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:31 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so2154931a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729768; x=1787334568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHZx/nEDqj6qBDUVJByj1LXYqrLbBjeJWaNTcrkLGNc=;
 b=REgmT/RnAwlIMGvw9pu3aJDCXkW+6AgxCm2OPk+CY7ETU6lru2T10ZssBUzrj0PAlC
 WW6e4pdt3FYyWF4oymPCRyhSOdiUIUxVS+fFQH+159cydqPn4tPk/RUVMidvIQ3LmLG4
 zkEVjmTFxf44d9egiIBZr6XaMq9F9V6Vz0JhQLzxMENUYLz6JvlF/j6Pl1X3TTDcNUlt
 mV59YjEfhjCAYALGDp15l6KYNBtl5QNZ2MoKJpJk60Zk0IP+Mez1Zfh4kXpUuGp32vUZ
 3PSlNF2zBUp1zekZc1T1LHeXFI6JOeURk3PQUxKxzCktKZtLx3lGMpwUyBgRB+FHYV+V
 EJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729768; x=1787334568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pHZx/nEDqj6qBDUVJByj1LXYqrLbBjeJWaNTcrkLGNc=;
 b=Cm5ggyAvdrG7SoZwd2MUBh3fYqvWAHbKnoDr3evW2R5MP/5rNgGnZdb+6pzkX5wwov
 bzMtOBc/3f5/x44VUmUpZ7r3XBVJCXCzwHrLpxu1hFfGRrri2wyTvZ/CRFL3lKui/SSV
 MAwnGy8MUeAEU1xBt9DvPSOyscaptBnxLSniFXwG7FaGyJ+uMLI6Zb2vYWBNqhtJmv+D
 mIVe3HoG+zxcBhSBa6RPsINQpKwENcCg2NAEZACYvj4RlIaGbRzSE4/7GTrxh/nxfXCF
 8JKLHD66yUddgSyn3QIFTimNBRKPMugdOlDvIdG+mzpNljAAo8q3uFwWDqNdmz9Zl15n
 xQOg==
X-Gm-Message-State: AOJu0YzfuBOSZzDmKlRiWIPUvnY0dmvfCfYjz4Ejd77WIxT2gNJxzWcY
 UNU+9H9EPQZl15VCVsjmmk64xyD+I3wNU+tUd6EcXxEA+NHFxSlx248X1AOEiw5C/1PkPg==
X-Gm-Gg: AR+sD13lxVqq/rLjQQgmBJISd+nGAJPYXceeZS5nX3AgkzA95ijSSpSGM3n1zocXOa1
 DxditFECNBE4jMeB2OaIGfWKGjyX+5lbt8ymJ6cQTglui8vM+sWOOuuJs9+Kvpy7yH9wNKs7sv0
 hZbec1dA3PVhEE39lCSCZhNIxpd7TIrF/7CFVK29ZKDNd0GiDfE2nr7nP9SrslzI80TStraoawW
 6rRPOMfmy8yGkGkdR9ecThrZt8AvV+Vr9U+CcZ91FS+y7AIlmw06wCka4hdc0B0f/dqy4A1oD12
 A1OxaM0BtuxndY3FJEMXrVZo/6MyFPDd4g3OB1xWVIeVuTcef7UAFLGTKps9/4j+ze1nH+zWKWJ
 NZ1tQiyGmA93B88Mhr5/blCONsPV01XP9vIUfUiZXqxfxh8EbxoLyd9RlYOE8CXZr3sl7dbdbPd
 RlTTkgbm8hunvZ5qW39f9obmrFHuUlxYZfLGjVkUOHyxirM+6ztDYKGnnpzJLGPvAVVNJGQyuQO
 jwlbd9d2OqH9/Tvnk8=
X-Received: by 2002:a17:90a:bf0d:b0:394:ed5c:ff9f with SMTP id
 98e67ed59e1d1-394ed5d013bmr3773576a91.17.1786729768352; 
 Fri, 14 Aug 2026 10:49:28 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:27 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 13/15] monitor/hmp: display IOThread holders
Date: Sat, 15 Aug 2026 01:48:27 +0800
Message-ID: <20260814174830.1691540-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
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
 monitor/hmp-cmds.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a..41a813e79f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -240,11 +240,32 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        for (h = value->holders; h; h = h->next) {
+            IOThreadHolder *holder = h->value;
+
+            switch (holder->type) {
+            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                monitor_printf(mon, "[block-export: %s]",
+                               holder->u.block_export.export_id);
+                break;
+            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                monitor_printf(mon, "[qom-path: %s]",
+                               holder->u.qom_object.qom_path);
+                break;
+            default:
+                monitor_printf(mon, "[unknown]");
+                break;
+            }
+        }
+        monitor_printf(mon, "\n");
+
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.54.0


