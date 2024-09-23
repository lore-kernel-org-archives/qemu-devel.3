Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B24CCF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg7H-0001Rh-33; Mon, 23 Sep 2024 06:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7G-0001PV-55; Mon, 23 Sep 2024 06:16:26 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7E-0003mm-Mk; Mon, 23 Sep 2024 06:16:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so624963266b.3; 
 Mon, 23 Sep 2024 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727086582; x=1727691382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3utLXrcQvqqr/ZW1nAz9brc7pd3D1v8OfO4apq/Xqhk=;
 b=XqfQpZunjVs1i+pSG/23AJ+wjOIa4BI5ABUUEllUuw2clkJc7TKRBlL/dsdetnq31L
 iQ1a1ZRzOm6PvkcXLNBjnpSfH1IWLe6tIkz102+YTte4Chuxjf7PQn7lYNFJObHaY90H
 op9wihY1w8skasyhts3lUvwaVnmNur19VbEnSJJure5mM33Rn4IrwjvYKb9zAj4y7QD3
 Fba3zeVOlkAY7hGh7hMJxvTwTqjAQPCTPwvBLvHVkpGaqK+jTR14IXt4cTV628JXx++3
 hYBidvThxCb5eerorR06x+xVM17MnkjS1t7Pn0kq/3novE9DaO47jWNqeDvJFmzkd45n
 g7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727086582; x=1727691382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3utLXrcQvqqr/ZW1nAz9brc7pd3D1v8OfO4apq/Xqhk=;
 b=VzL5HsQfc1GTAwWabdSo23nIUiDDNw2baI+duoNgMvcSkBUpBNj3AwNEkQQllwlp4s
 CYNNzwXIFInsGkv9e/oRsUC384unhevRTJeD/XyFOEPZKoQtdGB8PnJ00NWBWd8W+Pbw
 4WLIbM416v8TeuCnNOntD6SFkZ7FM/Blg9zpfZ5hbtsPqjvC3YLdbX2iLV70cKhsJXcs
 lvQJjTeUi8p5gMamBwiSekqSwKX05w7Cyr0/F36ocOwdizL0+YIk8O/6lEvdPU/Jt3Wl
 NFjekcx/Gl30ISPF393eNoBZH73pxFi51TpjfpMWigs2vggAIJ6VooQStxhLp9c9VJax
 jNVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi3x/vkMoNoyYLnD/sHlmYQK9xfTVLCsmPHuC7xbSgsg3ZHVebGX5pD4IH6TrpOsZFXR9in3u0MQ==@nongnu.org
X-Gm-Message-State: AOJu0YwhGpEr8QS9Xv9oYbbkU7vMyCtxxsxkLiCAgP2ND03aDC2N11kq
 tWcSrKoUwNspqsqcWpIX4iirXrPMF973dL3HhLhK95jPdNE79Ba9ljZSMw==
X-Google-Smtp-Source: AGHT+IFY7rj9BR6buLIywCchIL+hMutgPcCCTGbm/4hFYhN+DllbfuJvy9sKWlcqvW/SzhsB4uLQ5A==
X-Received: by 2002:a17:907:e246:b0:a90:d1e1:eeb3 with SMTP id
 a640c23a62f3a-a90d50d0521mr1036149666b.44.1727086581944; 
 Mon, 23 Sep 2024 03:16:21 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f43e9sm1187655566b.72.2024.09.23.03.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 03:16:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/3] MAINTAINERS: Add hw/gpio/gpio_pwr.c
Date: Mon, 23 Sep 2024 12:15:52 +0200
Message-ID: <20240923101554.12900-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923101554.12900-1-shentey@gmail.com>
References: <20240923101554.12900-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

The device is only used in the ARM virt machine and designed to be used on top
of pl061 for use cases such as ARM Trusted Firmware. Add it to the same section
as hw/gpio/pl061.c.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..7e0d3509e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -656,6 +656,7 @@ F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
+F: hw/gpio/gpio_pwr.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: include/hw/input/pl050.h
-- 
2.46.1


