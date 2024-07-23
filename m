Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFF3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJI-0000uu-12; Tue, 23 Jul 2024 16:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIy-0007Y6-Fi
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIw-0004Fh-GE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso44701285e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767211; x=1722372011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efl2J6FZMNBybvIOohahy/rqbvmAN7ozlP6FIF0OQ4s=;
 b=QfZaLrxWWJ40W9K54k+09t0exDCPNjKY9S2tOAT4/qLaLQTvZDWLLgKUjttgmw2L+L
 PktN9OnMXGvhKfjhHgJ7azSYBfv9ikbZ1gZhVFoL9kGbFGaNbXU4PXmFWoqSR3U2d9gS
 UizxYFtFvRQcVGo42YHFidEjOi3+vpT7k80YPLP3yNkRqIjiD4B24DS1FNMxQo/gPFIf
 DaT8IU6W9xLo1dyeCN1MyMjI51U1iSmjjCxjUMeZDvb4UH9u2752bNU5GmsuLq1cM90k
 2bB/dOgncAEV5cmsTrLNH96zazlZ62wSTa5dPx6yyhvtO6YjmVlzNjkkQbtr3wTyjx41
 ASoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767211; x=1722372011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efl2J6FZMNBybvIOohahy/rqbvmAN7ozlP6FIF0OQ4s=;
 b=ua8OGrB7gzbdv/VwYdXQp0bEg4kdMdW1YzvALbWQvKi8DRPEef6fdGZTjbkN8eP8ZL
 gast4moUEogPyzq5kR5oIf5yUn1XCAqV8AnVdj1J8dzCjL6Woch55LljhAYSICRL2v3D
 HXMxvtrloEAGxHvejj1v1Udsj/cmITgWtj6Na3VuDxnZurs/Lq4lsuUlh18ht7CHlvf0
 ZQyHMBVxpQoqg7z5D7KnHh9jPY09Fx3FKcmocmoVQBNG6IEA5r3eztyLP2KSifJQTJwy
 iIfC6l/fogpjTTS4RcwD7BHP2qxOTivqb8LRK/xBvGfOfe5lDUhwDZvHgAivgEfgca8t
 e3QA==
X-Gm-Message-State: AOJu0YzV9Nsf1zAssu18yuXlJ1wEsyMFHmCweO9B0iRMk8AwrhUUVU2+
 0Bx4qJ03SVtk0q+4c0BJ0Eqr6pph7DaLHiweqvUxRVFijwgoWe50IrgBKBOShsqKt6tU1B8dx1p
 E7js=
X-Google-Smtp-Source: AGHT+IHj6RYFqo7w48bpHyWmP4T+IUyN9ddN93a5N5am/uV5A6O9Qbklt4EqwRGAuu/LiRgiYmLbtA==
X-Received: by 2002:a05:600c:4586:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-427f955c2d4mr81865e9.17.1721767211490; 
 Tue, 23 Jul 2024 13:40:11 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9413663sm316075e9.45.2024.07.23.13.40.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/28] cxl/mailbox: make range overlap check more readable
Date: Tue, 23 Jul 2024 22:38:40 +0200
Message-ID: <20240723203855.65033-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240722040742.11513-5-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-mailbox-utils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 74eeb6fde73..507690c0dd1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1086,8 +1086,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
 
     QLIST_FOREACH(ent, poison_list, node) {
         /* Check for no overlap */
-        if (ent->start >= query_start + query_length ||
-            ent->start + ent->length <= query_start) {
+        if (!ranges_overlap(ent->start, ent->length,
+                            query_start, query_length)) {
             continue;
         }
         record_count++;
@@ -1100,8 +1100,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         uint64_t start, stop;
 
         /* Check for no overlap */
-        if (ent->start >= query_start + query_length ||
-            ent->start + ent->length <= query_start) {
+        if (!ranges_overlap(ent->start, ent->length,
+                            query_start, query_length)) {
             continue;
         }
 
-- 
2.41.0


