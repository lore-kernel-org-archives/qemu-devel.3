Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA35C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXqo-0002OK-Bd; Thu, 15 Feb 2024 04:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1raXqn-0002Lv-FF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:16:13 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1raXqj-0001XS-5m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:16:13 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so899571a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707988567; x=1708593367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+JQ0Ev2JlvyvJ4uulG5JSOM5ldpWV0pOJnl05fuaHW0=;
 b=XiENvnyJv0SbOHXXCfFSP5b4PYZzSCf3JEtCsk2l3e62dZO3kkVXvgTnvsNB+hYp0d
 mCdeooMoG/i1PpYREgHW0KUhHBGnLTO828QMj2hE/YU4eDiee9ZpcX4kEaIrtso1Y6qD
 nV5W3lk3K97fOwQiO9TFzjtgi9haPbVsGUfO+dxn02jTotXNZHbkQCCYR0PlHOjFsidC
 VqX1SkPi+aww4czRTywPYEYx9CyLGSYE/BG1mmQPfJA920fWmKCq2wxrNZLGJZwmdwdy
 +YWFns7dMMQ7WMzPnUce24gS5tjaI0wzd/4suHiXHuxCKmswJk0SPYldBNyBC5BEl0sb
 ksTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707988567; x=1708593367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JQ0Ev2JlvyvJ4uulG5JSOM5ldpWV0pOJnl05fuaHW0=;
 b=LeyLdgZI+elVDuUDyKvZpeEMjIRJxQ+MZrbIjJ/zrXO/twfc6VhZdru+VabLFgi6eF
 VWe9wryxF+I+IhTqalFkTt7VN28OaPrAlPaK6l+jlHIlcHbKBYF+uJ774MJu78sbig9x
 0Hf4qAxNwK3qTI3NV1XK+Nl/7PcZEVx5hAYBAYmoaiQS60WxlbbG3KDreonVB7vcLhkA
 vt3NeiY6VVyCxTSZqBQ57CCMpo95sp8Ilbnuma+GgG8eokQ7WkZF8IZVT/KDAYTStUJw
 OSRsAiMpeZcb9bDmi+6dTIoH3RIvZ/ivq6BAXWxUFvCxfhuTOm823LRzdQDj0X5lAOYD
 6GBg==
X-Gm-Message-State: AOJu0YzH23C2Bte1W/+4PHR1miRinTkGMDIovKjK62nNQrvitsqy0DTz
 WfC+SnPJf3gkw2Mm1FzDQYvI4cXOVxjB/67f9ZYdBJb7MYK7A8F+LWTauJX7ThQUcPI3lzrj0gk
 HNf8=
X-Google-Smtp-Source: AGHT+IF3HL0VxeUHH2AOcyoLXxR3uEMml5BJU2vIPnwsssZCC9hOe/j2qBPxYwdTPIQ/fcRb09AJFg==
X-Received: by 2002:a17:906:4544:b0:a3d:abd1:7035 with SMTP id
 s4-20020a170906454400b00a3dabd17035mr94260ejq.9.1707988566841; 
 Thu, 15 Feb 2024 01:16:06 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 zh14-20020a170906880e00b00a3d35bccdf0sm343307ejb.139.2024.02.15.01.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:16:06 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH] system/physmem: remove redundant arg reassignment
Date: Thu, 15 Feb 2024 11:15:06 +0200
Message-Id: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Arguments `ram_block` are reassigned to local declarations `block`
without further use. Remove re-assignment to reduce noise.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 system/physmem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e66d9ae36..d4c3bfac65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2154,10 +2154,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
  *
  * Called within RCU critical section.
  */
-void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
 {
-    RAMBlock *block = ram_block;
-
     if (block == NULL) {
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
@@ -2182,10 +2180,9 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
  *
  * Called within RCU critical section.
  */
-static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
+static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
-    RAMBlock *block = ram_block;
     if (*size == 0) {
         return NULL;
     }

base-commit: 5767815218efd3cbfd409505ed824d5f356044ae
-- 
γαῖα πυρί μιχθήτω


