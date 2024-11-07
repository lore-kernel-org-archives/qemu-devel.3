Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78541D5D688
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98b3-0001cH-GE; Thu, 07 Nov 2024 14:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FxstZwYKCkIxmxywvksskpi.gsquiqy-hiziprsrkry.svk@flex--titusr.bounces.google.com>)
 id 1t98ax-0001VF-2a
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:07 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FxstZwYKCkIxmxywvksskpi.gsquiqy-hiziprsrkry.svk@flex--titusr.bounces.google.com>)
 id 1t98au-0003Ld-KH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:06 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ea7cfb6e0fso27083097b3.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009303; x=1731614103; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7hncGgySUr3tVJodOoCwhdjUjxWooLQLxe671zubbZI=;
 b=ubMBkcOCjnrX0yitE9Y2cAHiuTPQo9TFSy6y3II2qBSL0svu73jRx6Lu8XsMpBNc3N
 L7iFepWWwQ/ehdD0gCtk8fU5/QR76DrzUx/RiInSOWhL6ScgLrF5BrXIxEv5GpkaC9km
 gU/P/PHkh9pjTwqY68DJXdgANQNcFH5QIZ9X4t+CTTtiC3LyUkxGAwFtZdzj32pGkpm5
 OD+UipxJ12TRtd6sczEf8oEnwd46lVnHRDgItqqkvs63IK964kA3qUWrjXdatDH61JOL
 YS+2FPI53uLE1oAspMtdFQvEdheIBJzlrsB3mNjuhmEJP08VNTDlo11noAaXd1V13n29
 Q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009303; x=1731614103;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7hncGgySUr3tVJodOoCwhdjUjxWooLQLxe671zubbZI=;
 b=s7u4lK6vk2SqN4CL8076XnTdwurBq866cp+RYaFGMv/otQPOpYDYx997wiMZigI6GN
 9y/rmevDFvc8/5mN4M46VbU1qHUT4NY9SeaLtS8rgrEtlHKt2BCRHMkos45TjVm/OZpE
 2IM5Ez9T/+E45yJ5RZcHIvpIpG1+3aUQGUPAFVaE3TK69FlSq9SQbHH7h4+KlYnbaotD
 vEhVjehCSUgPb/XL+QmuMoYN/1X59QjoB7Aq9kTXmAkkNOwHnAYExjgNfgVeYzwKLlSa
 U8qEOHqJc1+MU2MiqZINLqB+xrAbWc9sIS3LUGEkBrPHDlsJ4o4U7+lS6RYXRd2MOnJ7
 KtGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZXGC4O1IlMwg1pkZbZWmWbeD3JWDcBfBSNIq2Xmlh87QZp4LMwB4XiJvSJNE9sW2B5gYQGxKPyIQ@nongnu.org
X-Gm-Message-State: AOJu0Yx/PPwgb6m1xoJBnJeJ1JFd7ebsps0lBhL3WIgtqWqW+0p7k7S0
 +0pMpjUUYx02gvjgX8x2jDY6WJuKhYbw78sTrx9f+uN5IBchfuqMyLFNnTm9wCLIY1cfwyQ4bQk
 mtQ==
X-Google-Smtp-Source: AGHT+IG/BBbjNIb+sHx+VtZ8fCT9DJ18NOQeJo8RTwkKJK1ExhcusVN0vYb9C/DWHhCHULHbKC5LPEovtFM=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a5b:acd:0:b0:e30:d561:dad4 with
 SMTP id
 3f1490d57ef6-e337f8417bemr3381276.2.1731009303114; Thu, 07 Nov 2024 11:55:03
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:52 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-6-titusr@google.com>
Subject: [PATCH 5/6] hw/arm: imply I2C_DEVICES on NPCM7xx
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3FxstZwYKCkIxmxywvksskpi.gsquiqy-hiziprsrkry.svk@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1b25e73578..30480dad7b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -465,6 +465,7 @@ config NPCM7XX
     bool
     default y
     depends on TCG && ARM
+    imply I2C_DEVICES
     select A9MPCORE
     select ADM1266
     select ADM1272
-- 
2.47.0.277.g8800431eea-goog


