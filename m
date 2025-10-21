Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D65CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCG0-0002Fw-TA; Tue, 21 Oct 2025 09:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCFz-0002Fo-KK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCFx-0002XI-OI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1120787f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761052707; x=1761657507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YUrXfs78t2/pPyUV1D8Kof5PgM5d9w3SNyN0XND7iuI=;
 b=bxZ6ZpXNuRJ7B64p7rHOa7pPXTDHDIVEfEFYia/f4lnLcgQsQbU6amHPN+M2npdihJ
 VLVrEYTUhofIzOvzJ0tl/GIHkGPnjoxEF3Y0I/+Tyl1PgtmWdftdQ3E/QnYnowXAvpch
 6iYqAEK7Ot63DYwBmiv3LzdD4/2qEZCg/Rv4EF8Eon+yLSKsj/lIJ1M4j/QlHnjMA4Gp
 Dtk6VY6X0TLOZVcP+tv1U79n6sYfyfKk2sVCoaOGLeSQgox0Iu4KT7cZabkas+Sv0QTL
 HWIcdVBZanB9+xNLgKwFViEbWhXeL+05Ljgoj1oLPk9BN+q7G9yrjvDR3+AXMf2pQ/Fz
 TgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761052707; x=1761657507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YUrXfs78t2/pPyUV1D8Kof5PgM5d9w3SNyN0XND7iuI=;
 b=XLBEj8biOZxuUOTL/NtAM6GpiKfbaqQxhFXC4JkwSWyn57a4pM0MdirMD/u4cQ6tqY
 DUyK8vC6g0/NvvCz96xmLcB9y4F5lgZR2J0BayHnJ93cEF3QwW4bevLZCDIH1m+3GJo0
 c0qlOqADUoKgbVKNZjWe4J+/Wua5nQrj8rZ4T8NJ5boR/V0GQcKBIwVQsoWVS3XI89lW
 KM0PrnzeOrduQp345bOSLFlYTvu6N6F3ME8wK2fQObRCjFPFp9Pbtg0jHUug1tLHN4hf
 1Gbm04h4yusMTTMwasp5G5TlKOjjHMCp34MAwESMuklzyliYg2ahZkv5jHqU2HxS27D+
 CgHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ+nVTAR/YxuxtucxCDY9R/yvthzMKW4Dx/n+uAdrg/J5Rl4T/IPQmFMe5AoAjnKzbHQDVx0y6nzcj@nongnu.org
X-Gm-Message-State: AOJu0Yylz15fhOw1UuaGAXN7QflFdVfcJg+SXeiDu4c7+OGnzhyOBC+g
 gOuZgKJrstn1Yn2dWWr7O/gWtXb9Me74w9ctpXncdQD9KQBb26ovFw3y1i+EHaTFTiM=
X-Gm-Gg: ASbGnctYIiQd54DRc3SEDgnYEdYIALx0LxUgbhGcv4rRdah+3ZJnZNB23Rz5fpqI75+
 ryK0nZv5pV5+Phwg/nt/XhG/xco6NruUUB+wUk2B9zVkVdSzI3f4OgTKCOg821JFSnSt8w23Nu2
 6+hWD6U2h2UKi1nQ8s50nYmzvMWQJObgD0RkX48gxv1gYdF3BzGc+aibMDIoWu+19x6pQjlVWwS
 2hIT9grpTImsWaB2XK+9l6u8TGF7K5NlFm1XecOT6FA7OvbEEJVM5ZwD58XsUmnOLNqkHaR4sh1
 pe/YGShniniYtxtNXyqWsAZWVm5/qoKAsFcau4JTtWxFymsw06dzQoTSdq+muhHfdR57s877Mh2
 ERrtN7EK5OF8qtqtu5yTxW7c/Sv2tInjZKqxdoDP+xWwlPxmXYCA2OBd7k3xQNJGztVpnugexZL
 5DK+zYekDXDIsbY/xTuDmkq8OUh1/ZcGLtto3eKJwuqnCIqVK8GA==
X-Google-Smtp-Source: AGHT+IE8YCn8DDZVoVj83d5CMo4EixaDnEbvhciDXYqQZybmRzLDGJRXSauQmu9JPyeOeMUoKrunxA==
X-Received: by 2002:a05:6000:26c8:b0:427:72d1:e3b1 with SMTP id
 ffacd0b85a97d-42772d1f20amr8312439f8f.41.1761052706860; 
 Tue, 21 Oct 2025 06:18:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm20473196f8f.9.2025.10.21.06.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 06:18:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/audio: Remove legacy code related to '-soundhw hda'
Date: Tue, 21 Oct 2025 15:18:21 +0200
Message-ID: <20251021131825.99390-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Few more patches following Marc-André cleanups, allowing
to remove audio_register_model_with_cb().

Based-on: <20251021090317.425409-1-marcandre.lureau@redhat.com>

Philippe Mathieu-Daudé (3):
  docs: Update mentions of removed '-soundhw' command line option
  hw/audio: Remove intel_hda_and_codec_init()
  hw/audio: Remove unused audio_register_model_with_cb()

 docs/qdev-device-use.txt |  4 ++--
 include/hw/audio/model.h |  2 --
 hw/audio/intel-hda.c     | 23 -----------------------
 hw/audio/model.c         | 26 +++++++-------------------
 system/qdev-monitor.c    |  4 ++--
 5 files changed, 11 insertions(+), 48 deletions(-)

-- 
2.51.0


