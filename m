Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B95CD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4h-0006a1-Hy; Thu, 04 Apr 2024 15:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4f-0006Zg-L0
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4e-0000O0-40
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3416df43cabso998634f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260114; x=1712864914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pt+lDyUe0AWJLsfkvxKd5ARWznd8vhavQW0JVI/GeGA=;
 b=CcQOpiQRIS4vvdUsLTWZIMJGsSq3P4QxxCLZo6rtKtU/IcZ+2xaXQXs3ZUvIfjazBC
 SDthyt3f7OQ5/cj6eLqjjkn1kwDYemCUxGAEWgrncYDJAcidbodF1OA/81M6Hh3lG4up
 8/oO0/GhlUpMBAp/rx2jWh/NepvxY6sQoOrzxG5PNFkgQoK0xTMQpAfsM9EtJ2TyLkhf
 3Zgtxjk83QKrWhPuBgHT0Aj4afx10aY7pfoZgMR8eAMJOs53CBRGNfsMOltIbSTJMiF3
 5QeALnYPuMbe2exl55Uyh5SQJQJ4kL6XKVLspO9iq8O49eZTZ6H9r9tC82+ZYQBGSv8S
 QSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260114; x=1712864914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pt+lDyUe0AWJLsfkvxKd5ARWznd8vhavQW0JVI/GeGA=;
 b=rAX3KcCjiUsrofudJZ5yC8s5zpCw/jFBztWSTvyhhPJaVV/9SgvRvlg3G0q/onuD0Q
 sxdfDAbrPcRWMlQEc3ai7y2igy4Q0rLODkc+X1tZjxQRlGAtW+4s4wq2vjdz2LgvgBnZ
 3v9lXseMrUW0H+h9xRWjVpv5HvsXPfIlEJE+W5/ZchoLbYqPjy4UdIgimUvsqwA0Xgs3
 n9IpQ9tUilpms6e2ASFXh0Bv59b0gkybLw28CL2zGACvmVDXtrUovSX+eU6sLe56awmg
 +9on6X4BecSnxdbC86B8+dgyFxJD2Qyh9P9FmwHxMxvNNwzXs1qGkHdSW3/0wFsTGOTO
 9fwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxME38OEzQv/gONsuAnbu5r+gif8+K2zW/9L1TJz3CT7MQ9VGRv9wr3DN7LfMCHn4hwQL1KGjusScXGCpN7eBtvgQkvJo=
X-Gm-Message-State: AOJu0YzdpQYBuQfzdt3wHFr3135ToJYkrHGqh78bMuMs92RT5WuvIivW
 hRQ+NmhghNr/b/hfgqUAIyz9izbLi5DAHcrMajLqKfGXANuNIu8n5EYISwnn8Jo=
X-Google-Smtp-Source: AGHT+IFeMVBn58Z1vU68gBocDbsnTAmL47smFNDjNs4IgBc4eoyD8sMZ44mCvBnEnKtMG2pouGqHyg==
X-Received: by 2002:a5d:6803:0:b0:343:59bd:113d with SMTP id
 w3-20020a5d6803000000b0034359bd113dmr2406471wru.51.1712260114447; 
 Thu, 04 Apr 2024 12:48:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d5887000000b00343d38ee4a2sm167521wrf.11.2024.04.04.12.48.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-9.1 6/7] hw/core: Move reset.c to hwcore_ss[] source set
Date: Thu,  4 Apr 2024 21:47:56 +0200
Message-ID: <20240404194757.9343-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

reset.c contains core code used by any CPU, required
by user emulation. Move it to hwcore_ss[] where it
belongs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index e26f2e088c..1389f1b339 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -3,7 +3,6 @@ hwcore_ss.add(files(
   'bus.c',
   'qdev-properties.c',
   'qdev.c',
-  'reset.c',
   'resetcontainer.c',
   'resettable.c',
   'vmstate-if.c',
@@ -16,6 +15,7 @@ if have_system
   hwcore_ss.add(files(
     'hotplug.c',
     'qdev-hotplug.c',
+    'reset.c',
   ))
 else
   hwcore_ss.add(files(
-- 
2.41.0


