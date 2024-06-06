Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C69C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCPk-000111-SV; Thu, 06 Jun 2024 08:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPi-0000yK-Es
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPg-0002Ny-My
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4212b4eea2eso9338875e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717677614; x=1718282414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8LGSYhX0LEADFn6su9hu7e+2gd58DQ39HHcU76gc84=;
 b=UMUsP/7UeJGd5gjx49ofoHfJZaKpN0SkFy8VdY6+NlNj4jEbqC27pLjLwBDkIu4cGG
 MoWwfM1qw2qaELwIoIAaOav09oyqPdFIRFfKsx/Y3TfXzRr2KhYHG8c2FtOpU8lAh85R
 eTPxK5FQB78tHt/CWn+rukXa3Dx+2nWvKiewpjRnVLIjighS+2jBhzqjPV4zN0i+KoC8
 cPND1jqjGQavKmhddL4oq97XvKI6CJlW78fwOPHdxfghKrpLIHvDFNn6cyDKXwuuipDk
 DR/jAUU44DIjFCj990ub7wYHwj4tSoqXb6XH/JzOuzJbI4wxOz1uHIdrY0XdfWFsOIZ7
 lQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717677614; x=1718282414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8LGSYhX0LEADFn6su9hu7e+2gd58DQ39HHcU76gc84=;
 b=hBfOzp5uIoz0FtAJYoTBsZIX24vhKawG+SHuSOp03bN6TDUQ4Ex2j+8uSpzXNJrnZN
 YdbcYBIRrDOBE6AF5HcxQYbFcELXWLGKq8888AN0vMpmHnxIQbs8nY6AscPlXGbM3quR
 DVIQQw73p9uPwUwPPPda/RXk4WXs4hCbrAUxibJcC4nQU1OxLOYzLgC9KGupErSbELQI
 00BxhDeufpk1qxkM+fjVF6VjU4Ykzs7hQ8CfA4jLu6zP64OJGTG/SKB/v6wxV3vLG1WN
 QmOY6rKOUrZpVEOtKUlCgeRUB5svo6oZ28nUN5nEqqRhXu6RDFlmg+909qCJa/7J0zbR
 wgfw==
X-Gm-Message-State: AOJu0YxSAEiUuUpUr4vGNTep8Vxj7NlFYq+ACbFmc94tNALqxbZj/ahm
 VOL7WWBNvOIp5gVqTIBOae1trVANN7PE8wsIfcZgRWZgd565L0N4jqo7OwEBcSLnQZPyhfzlbSL
 wwDg=
X-Google-Smtp-Source: AGHT+IEMwPTkEKPtszIQIdHJIWJ4T/DZds/eSaZwxFvnEeWJWiF5XTbXn0xPPBbINTy7M6Yh6E/sig==
X-Received: by 2002:a05:600c:4fd6:b0:420:29dd:84d0 with SMTP id
 5b1f17b1804b1-42156351b60mr46424205e9.29.1717677614327; 
 Thu, 06 Jun 2024 05:40:14 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d589sm20593305e9.4.2024.06.06.05.40.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 05:40:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/3] plugins: Few debugging cleanups
Date: Thu,  6 Jun 2024 14:40:07 +0200
Message-ID: <20240606124010.2460-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

- Assert cpu_index is assigned in INIT/EXIT hooks
- Free cpu->plugin_state
- Restrict qemu_plugin_vcpu_init__async() to plugins/

Philippe Mathieu-Daudé (3):
  plugins: Ensure vCPU index is assigned in init/exit hooks
  plugins: Free CPUPluginState before destroying vCPU state
  accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/

 include/qemu/plugin.h |  3 +++
 hw/core/cpu-common.c  | 14 ++++++--------
 plugins/core.c        | 10 +++++++++-
 3 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.41.0


