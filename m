Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF820C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3f-0000bW-LT; Fri, 20 Jun 2025 18:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXj-00076u-1a
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXh-0005us-Iv
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453643020bdso9552715e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440524; x=1751045324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZzVF8esaMEHgF7o4hdbgL9Jdv4iiE3l72PZBRMZZ3E=;
 b=TxzONHKC0mUAmvW3qAaPhK5Pa6fylvpl5DGUvyBdW5dBvCD0ecuSb3LP28UqXo9y//
 zGa2i2t2UHOi2Et4lgAGF6isBQlsZMjHNRlYCKx+6dFbs+ccs0bOb7vDvVPKKBEYQF0x
 zTeqCZuZGzwyTV1wUGP2fwYRKBEJdlUY4HiZeZca/WT67MYnsXra5dWlLXiLwRrbveTe
 6r5EzlAHYfLUgRoGVGnKvIQj2u73XJDFrsjdR4XhhlfueFuYU8aMPp6XDTo8g9JplbO1
 ggJgmJx7kjBItvZLqvefNrBfC83eLMnN0YtVRARPgruyENPO3sdbOfy+1/3OZF3Tmjcc
 KgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440524; x=1751045324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZzVF8esaMEHgF7o4hdbgL9Jdv4iiE3l72PZBRMZZ3E=;
 b=kP5YGRKWDLGVqYMEvDLwyTqnuPYfD9bWy0YqTLjHmbNBXcDfvL/kjV4jjHKrF8i80i
 uIA+jS7jbWWzXVs7pWBznON9rdmXiD75tJsDyJcgiiEC6vseo+gDkopEbYq2R+CQGZhb
 ygVpvD6vXHWbNnlMOokdD27xNBfiUQ+uHopptm5vs/+QZoXoV+wkqopR/QjS2pOrJ3y/
 VnmfOLZiUMHfPGg2Vvd9qW5lsiFjSTDdrodA7MBRCHAYz4N4dYt+JA0pI/omqO9jUs3b
 xy6LbuSQhWe0H6B+IgA1iCcPTpwaxTWrxNi/Bmnjp3Zb68hfamPvfMAPkrfRw4rwKIbu
 J9qA==
X-Gm-Message-State: AOJu0YwcEojYydEUbF/WR7gGSnZhlrhKlmx774L97p6U4Dm2GL07x8/H
 nB+Y2LnI8sQ/Qh2LgKP6ET7a24X6VpNtyeWKuXasS8C0fsuaV2hrIB81Oo02DUavXAouSQJOJzO
 YIXPRiXCDNw==
X-Gm-Gg: ASbGncuKy6i2AvsKG5OjccsNpQt8hRd44vfBSv50eocbvJC8RuEQmTpjK7rz9wLg8HW
 46+0oYph/qhmLgTCtEZpHGcmrDw8A8I9uKam7LTcyrmeiAeRzHb0GXyhRpl5E5mP4ysnPHPzO9h
 DGTSe1KXiAlIPUxwKJRUlJpzKLxiQdGfoaT13ieJra12N4QIPw8tGlxAvDeBWPyMMIp0XNx48yd
 vvfgB51RrXGFHlxcXWzQsoZuURiNejuyZrf9/VZZFI3pZaAlbAHRR/77QAjqGtMYhX8uUfbYcMQ
 kGBLhUt6MR0SQzrupyk4ueyyxspzd9qwVlGPFGkHGvoqSXa2YcsQTgJf52O8EaTEUD0ecC1QMND
 9D/pwuSeEFuVOhE8uA0zdSOb11xgf6DZoUs6dvoOmDUSFRK5xYIgkdPdb
X-Google-Smtp-Source: AGHT+IED9E+nUoseKNwt5BBDlwzacLA6jlOji9KDf+D9GeBVkijb6hTkb5OHxPBuuTTB+1IbpntmgA==
X-Received: by 2002:a05:6000:2010:b0:3a4:dcfb:3118 with SMTP id
 ffacd0b85a97d-3a6d12fc1f2mr3341600f8f.10.1750440523783; 
 Fri, 20 Jun 2025 10:28:43 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10113sm2604388f8f.2.2025.06.20.10.28.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 06/42] accel/split: Empty setup_post()
Date: Fri, 20 Jun 2025 19:27:14 +0200
Message-ID: <20250620172751.94231-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-all.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 28f626d0ff4..8b9f8ff77a4 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -37,11 +37,6 @@ static int split_accel_init_machine(MachineState *ms, AccelState *as)
     return 0;
 }
 
-static void split_setup_post(MachineState *ms, AccelState *accel)
-{
-    g_assert_not_reached();
-}
-
 static bool split_has_memory(MachineState *ms, AddressSpace *as,
                              hwaddr start_addr, hwaddr size)
 {
@@ -129,7 +124,6 @@ static void split_accel_class_init(ObjectClass *oc, const void *data)
 
     ac->name = "split";
     ac->init_machine = split_accel_init_machine;
-    ac->setup_post = split_setup_post;
     ac->has_memory = split_has_memory;
     ac->cpus_are_resettable = split_cpus_are_resettable;
     ac->supports_guest_debug = split_supports_guest_debug;
-- 
2.49.0


