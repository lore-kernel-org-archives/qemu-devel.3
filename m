Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAB606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFnTpDW6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYt-0000lL-A3; Fri, 13 Nov 2026 04:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYr-0000k3-Sf
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYq-00061t-BR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ed2b4348fcso2408695ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562027; x=1795166827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dL/Q6T4ShqA/qNYT5CLVTesugf9vIPbAH1J8Fz30V0c=;
 b=cFnTpDW6XI9BqkRWyTBluORyS78nbgqmLc8Gg6sh63IQz96mc/Utb2BNHn15BCxCx8
 sTgNT6tgss2EijmdEMLDRQ76XyxtlkbBIC6r+n7eDKdPHjqHJxp0ApeMrLu9CwGI13yp
 CzFoIpaNgVtdtshRemKn+G6prZpZHGuMP+3ard3Z9jV2Pubc3T5+Yppt/N1NwFcLtWH6
 zY+sgccDUOFijDd5Rud/PAL5QIdCIeb6z8mn4Z3eQFWZq7np6Z5xvTJTym9H89Z3/7XO
 t3uQ8rvcl4IfH2BqO7M+Oh5tsowpUv8QK9HZKyE/L+y+CQzwsI5ZiTgKLdctMti+DI0t
 Q6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562027; x=1795166827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dL/Q6T4ShqA/qNYT5CLVTesugf9vIPbAH1J8Fz30V0c=;
 b=zYcrTBlypjx6jHGzibY1xaMLO4Z3nVBUksu4FlDPUfgAsp+sGHXbLWQKks2nIfRc43
 4S86WdN4d/25HL+FIdC3HRg6iDuccRdOhI0onvbDguq0+78M6DxW5bRiJU87lmYI4aXk
 sL3fANWKk8jRkySB8P2smC9hNVrE4DsMqXxQkf+3DXh0Q14dOUzSg/FCHtlBA5B0n/oy
 d8psPMMzhIe8L0XBzBKL0ZodgXa+/e/LUiSYH8NojkDjU4IOi/Vpf/Iq7WVZOguzdpnu
 1ijX4iDI5eJCS3B7rGDFW/69JQssSeB8o3UtaC2mG/xzLtQlUvnqP4bEkWA/+1HlF6iB
 7fow==
X-Gm-Message-State: APuU4Z/ftP4ScR+ZfrDL53tQPKRSIoo9UNDljeUZDRfFeCl4VgMz9p62
 PjM17mNvOhsBaeWs+s12feh+Z2KrekbtL80Ksx1RYAcCGaBHRwYgeSj90N719twv
X-Gm-Gg: AYBFou2on/iGvodwG3uuIeMNVHKwMeBIvtaSJPBjpEP4XdKMMHhFzMbZ8laanKyzGlH
 MeZF8AJ/YEntRpjQmj3CboC/mv6QFScVbesoc3ZcYedjSJKp+KCwMxk09sUxSoS6zRu15udyECJ
 Tq3eYwZsCLjr5zmrRw2VyWQ2RFrYTS8Y1f6SiL7D98N4sgP0NQpmXYcPkXc8pxhqFDg45mAmKqg
 Bgc7x7sG4hFk78rzwxjLIyb/sazkaIF6nxUbeYb/xAtwtFBkMPqQLLixfxonMPctfQnE1vSMjrX
 /7wLMTnu4oWFzWmCrfdjpq89WacJnwxmBONx1Cl3sJuOpi/GVaAcsA1wV6wazKRMy+cXPP/B2oo
 6LXwr2oEHfelO/ZuO1OBGf8IGu3is4zct3or6NcKFMf6KpvaFsb08eXWSG9BsboTLzrHegdbzWd
 nbnNbLZlMaj7YnhJnmCIsK1eazS38LPY4PB1wwAA9KdZGDKfjPyTRbjG5ZpARIE3OU/YFrX9idm
 sspLZh1NzP5IQcINLEn5cz6gD8o4Gw23zKTM89I4XvYmvLwrWhJJCFFiljaFR0joryBWNIHfUFt
 VV79GkV4bQ2LS08Hr6AM75mcmihA1ZXCPMiC9Vpax4qGevE75c6aFSehgDU=
X-Received: by 2002:a17:902:e542:b0:2e9:2a0e:aaaf with SMTP id
 d9443c01a7336-2ee0dccfa87mr20219185ad.57.1794562027060; 
 Fri, 13 Nov 2026 01:27:07 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:27:06 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 11/14] monitor/hmp: display IOThread holders
Date: Fri, 13 Nov 2026 17:26:02 +0800
Message-ID: <20261113092605.942292-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
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


