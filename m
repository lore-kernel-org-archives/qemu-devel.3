Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F4CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjY2-0003Fm-Aq; Mon, 24 Jun 2024 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjY0-00031Y-6y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXy-0005Wr-Ju
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4249196a361so6725015e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234949; x=1719839749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdZdPflGxnU9+ulU0ghp7a6tzZgDef0bM1QxWZe/c5Y=;
 b=kkgm4+ajCkOKNAuFarhMNdjDKQo1TAN09CQdAt06qAKOJVzbHJp7mhgcKvCefjFkJd
 ylMWs89fjow63WlaoufzDas4HeWu8n8QLp2p/B9Z2ZnWHdtxmHYcKldba7co4sAqNTGs
 GG8efpvGN8tyAIwAjtLNWt6XzMXNleh2l5xag1RWZC/fqUirCFZ6aohncyDyHOsFNqKC
 fxZvAyfLkKQBLF5GUsrn+Rt65kT1OBuUhSu3BhsQMSiO73QYO6lsw0X2i7ot7qYP6+KG
 MPz80+i6ut9LN0ijm0A0U442pwiniZKrvKU97mRqZOcmBhy9tBAA4godfuy0rGc9tzYQ
 syjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234949; x=1719839749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdZdPflGxnU9+ulU0ghp7a6tzZgDef0bM1QxWZe/c5Y=;
 b=r5+Zd+eaETuOGuD0K3ZawCOEGmLDa2Yz6/UiH2go/6DKs64Kt7Ep67Axz93Jly+W+e
 IVFFXuRqE2nCEYufmMKcHvw1FMetA7G9N4Zd8LLLD55kMONyd1Ancqd385IDBCs0fJqe
 uMAeIoR/CFz8+6yztaRWDJkUo9/d45HF3iM0FW/C/1n5oijLF+Z9bb1/+4+nZi5GsblL
 5fCSNCcjEN6L79DO49hI7kEssVt04OuboGQfO0tPKg7Hk53aJXHBsPI3YKsKHzvoCWlj
 mBouvETM1qO5TtegUcVQ3NwpRlwK+Ch/9wavShivV2XrpfZeMUHFiNsRJer2XmIksRkH
 AFjQ==
X-Gm-Message-State: AOJu0YwzTW4f2gxQ82Yai59YjuOCBX/aPxVKMqANvpKBvA2uhankbwAH
 MWAVcbmU71cw8CoauiYRIPbWf/sUP50AHE6tVTdDcbXcl7K2njqHWAU+pYGaWR+fHREpECZ5YF/
 L
X-Google-Smtp-Source: AGHT+IG08VHolRJbigqqgPAxjYP492jniy9OjguFF6SbR+ZxNeWsrb64BRgcQQXTccA6H/ogpOdleQ==
X-Received: by 2002:a05:600c:4fc9:b0:422:7c50:18ff with SMTP id
 5b1f17b1804b1-4248cc66677mr29054385e9.39.1719234948767; 
 Mon, 24 Jun 2024 06:15:48 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248179d3afsm140585865e9.5.2024.06.24.06.15.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/19] hw/sd/sdcard: Have cmd_valid_while_locked() return a
 boolean value
Date: Mon, 24 Jun 2024 15:14:33 +0200
Message-ID: <20240624131440.81111-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-14-philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 44225bae9b..04b141784b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1717,7 +1717,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
+static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1731,7 +1731,7 @@ static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
         return cmd == 41 || cmd == 42;
     }
     if (cmd == 16 || cmd == 55) {
-        return 1;
+        return true;
     }
     return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
-- 
2.41.0


