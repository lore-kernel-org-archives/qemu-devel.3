Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E054606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnA0xwIN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzw9-0007Qa-7y; Wed, 28 Oct 2026 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzw7-0007Ou-Q4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:11 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzw6-0006ia-37
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd5d2dafeccso445230a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179629; x=1793784429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dL/Q6T4ShqA/qNYT5CLVTesugf9vIPbAH1J8Fz30V0c=;
 b=hnA0xwINsYoNIBmcDpQEJwoypiod6EnasGjTYDMx/TldfoO6m/U4ENal1fxyvxfXCV
 2fn9hPVkcRR1iiKTjZCmFiPNBHHLKmnpOPlLeuOEjqN1DNEOJV5KzO0/iccAIcIB6Hl3
 CBm8PmiRZAChrzYoXIqHF2fEY2zU9XHIBxZMKdDBbJiY9M144vFLorX/NtDrrjE6OX34
 4z/PXMop1z/rLyc6eSYAayWv8iY8ugRMV6Dc19jKvwZyl47P3KE+J3nkqhiP3H3EQv01
 qHGss2/xo4DoCGudXZZmhcobfG0xD6FOXlGHBeg7ELH9elhAVJbjogej3jRVBYffmUxa
 bkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179629; x=1793784429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dL/Q6T4ShqA/qNYT5CLVTesugf9vIPbAH1J8Fz30V0c=;
 b=Lr/oRi5QJd8bKUX/NEH0m+9zrL09khoUJQmNSUQVvCNFijJUy1FWWGjj6dJA7o+ty/
 IC0qPZUSpzoNDPJ/iE1fRDAS+eJIL9jVKbx64ylrUUZS3mE9+05TOH77d4haNYpE2vky
 47OGAHkx26pBIvXrOUV3I6Ss5ZGVPeK+7Nm4Zae77PvYapkanN0GjVrJquBeLRaF0NJI
 QaFk939ZCVGK7u4ujEqMDdhklBtd75EnWe7hFeDM0N+NaLjvVxchRB7mRCUXx09DuSTa
 o3jTtB/cSjmx059HPWZ/ziqyXZNmwWfkZYQz/bv9ldb2cl4qrNlcdzaP2PjzvF2YFfG6
 KZ9Q==
X-Gm-Message-State: AFq9FYIWhlj3HmNQPmWXbwKrSk0BSv8qi1WeWmZmm2+D7fzZdj5vzlvN
 sHVS/k1bD8RBjM7gsMzzGFDqlFgEjO9SQY1A1DxXjUaN2n/9sBdlDBFBSFBosH26
X-Gm-Gg: AYBFou1giJMefG8NXntBxDbiA6Gu3iGp5UXrxS1a4G6SaLX7eqWSSASFEsHk+2AaG/2
 pOPYke8u6nHxfmGwe8mgxdsbmV9p7ObQVziGH4vJc4nYiV0AE+KI+rjTt9fj1RNNz7gm8rdFkfZ
 z9QPvfUFmuYcyduA4gPcn1cT21BwWXgeOC2KlWb/0V8z9+uwlnr4Dp6iVNREyywkigcqBMXMQFU
 CqrbAn1pBMusDwXlDwC21N5+iAObCPC7WqSsKvMXnaqBxlGc3WKHag2yvNBGFP1SE9x17//9U2W
 nymadUDRXwPZK9WR8mH0vSC2vmjSTaF1lmT08ndMObkNTZY3/WiI1n0zxLbEvzOZOWhrCy5wJkA
 4e1EUrvfKROzcqMLdRZON/m/5ydM7AF8yMdKKn9W0Kg0xDmehfvJtOEiuW4LLEIYJCYxtyEJUfC
 CRrgT/KiftE1wYFd7qZxGrRwdNj/lv4ohzWYuXJa4pxARZNcfYG+pTeWG9W0oqwceSa9kxm3drs
 PUECV2pUWyjIUURp7EVEE4P40PbhOMNA5TXWKxL+ueKK6EzqyRHs4g1OVI9r1WH100slI7aFtdo
 YP1KFjNcBbMPQc4laKVHQu1/xjp4EMTjShKS+5mL6CL6aiOB53X5hixq5xw=
X-Received: by 2002:a17:902:ecc9:b0:2e9:660a:7946 with SMTP id
 d9443c01a7336-2eb004b353fmr15398215ad.28.1793179628684; 
 Wed, 28 Oct 2026 02:27:08 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:27:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 11/14] monitor/hmp: display IOThread holders
Date: Wed, 28 Oct 2026 17:26:16 +0800
Message-ID: <20261028092619.1654474-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x529.google.com
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

Display holder information in info iothreads to aid manual debugging.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.53.0


