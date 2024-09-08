Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434FEE6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snHhu-00030B-Od; Sun, 08 Sep 2024 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHhq-0002rA-78
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:54 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHhn-0000fL-AS
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:52 -0400
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2f75f116d11so9580911fa.1
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725801109; x=1726405909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9q+YIIrgdQyzRQXNqBoVfQ3f8EP3T/uI3ZqwIVVnwUc=;
 b=Nvx9i2EtC6qYADQfF5JMcr9cPXabUjqq9Bu1bhVBpc8Jtfu+V/eUWkusgMQvPdLEqW
 9pKtBWVx+07jPzlxEHrLHmrN37OWrkwA1H5JBkYDXIeK9f+7QeL8cQVmiqw5xcARx/Wq
 k2AyNebxF+wzYPni2xRCB2UsSn9ga2nTG4SF//sElaINaGqacY+0GIhIN853adHPtkKd
 dLLu0OV3dbsTLJbOK5QJtDJvEkWA53YrM0N+XQHLdsYTvy/8PDUCOXh2FNp0WPKoPG6u
 cDLwy+wWCzmwOiNpZUdn53+nyC9cJqH4QeAxrl6w552TPhdaQCl3MQ5I/LVIjczla0dV
 ybIg==
X-Gm-Message-State: AOJu0YyfK/16aZd2n4tl82H4S6E5HT4BhEzsh5s0VWcIb0eSB746XHFS
 tp0ZMDwADLhDzYLG5P5P1JTWfIZ7xYFkMMRIrIET0YqgdqxTRidt7edSKA==
X-Google-Smtp-Source: AGHT+IEnWQpRkO7PpBX8UuLXpifWodOKzN8nqCmseigjW5esqHPEIpAy7VXMTQerTW0CEspxMQ31yw==
X-Received: by 2002:a05:651c:20c:b0:2f3:ee44:c6de with SMTP id
 38308e7fff4ca-2f751f2b7ebmr47425381fa.27.1725801109323; 
 Sun, 08 Sep 2024 06:11:49 -0700 (PDT)
Received: from fedora.. (ip-109-43-115-52.web.vodafone.de. [109.43.115.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm1842418a12.57.2024.09.08.06.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 06:11:49 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] hw/m68k/mcf5208: Add URLs for datasheets
Date: Sun,  8 Sep 2024 15:11:27 +0200
Message-ID: <20240908131128.19384-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908131128.19384-1-huth@tuxfamily.org>
References: <20240908131128.19384-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.172; envelope-from=th.huth@gmail.com;
 helo=mail-lj1-f172.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The datasheets for the SoC and board we model here are still
available from the NXP website; add their URLs and titles for
future reference.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20240830173452.2086140-3-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5208.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0ad347dfa8..b6677ad6bc 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -4,6 +4,14 @@
  * Copyright (c) 2007 CodeSourcery.
  *
  * This code is licensed under the GPL
+ *
+ * This file models both the MCF5208 SoC, and the
+ * MCF5208EVB evaluation board. For details see
+ *
+ * "MCF5208 Reference Manual"
+ * https://www.nxp.com/docs/en/reference-manual/MCF5208RM.pdf
+ * "M5208EVB-RevB 32-bit Microcontroller User Manual"
+ * https://www.nxp.com/docs/en/reference-manual/M5208EVBUM.pdf
  */
 
 #include "qemu/osdep.h"
-- 
2.46.0


