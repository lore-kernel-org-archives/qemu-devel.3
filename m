Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CB6EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkj-00076Q-C6; Sun, 08 Mar 2026 18:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMki-00075E-H5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkg-0003XL-SM
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so5313385e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009453; x=1773614253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zp4tzyYE1+SHUwjfn9CYbM0y2EMXsnd90/WhSxnB9Vo=;
 b=hISQ7PBh53iRkHaENbIZPSVvQsuOA0TnwbODQbepQ5YJEeBi+Cz+KGRrjr6vyiJRFf
 PA9SdeQsMPI9/TfN9KMfXy8WD5m8ha/8aFDYVUYLJibvDL96LYGk5RW9gymoDGbe4HnT
 SMjTgKXx1lBcd6dZ6Ddu7aQcZR9yQNX3kUeyo6bYyR+mRIDceQFW2fMjrGSor+3xKrUq
 hF7S9iE7VuuPk2TXpbANym7nO0lvc0u7EiC1uufQOS2XwCimF49fyCXgoh1o36XSctul
 Y2A4rl8nLUanKk2xL6Nwtd4iKWy0Sq7LJBZis8Rq0cKM5neD8fktIjGNX3wbqmwMTSfu
 ikuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009453; x=1773614253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zp4tzyYE1+SHUwjfn9CYbM0y2EMXsnd90/WhSxnB9Vo=;
 b=kXMEPPrXW84c6nKwHAec7kNTqRMyDLBDlE2jnZka6h4yLP0J1L6wUE6LtMxxlytJBN
 4bAB4pJaMUWRgWBlOAjP+uXCIWZ8ldp31gyeWCDEKEmBavaQYehekOgoqk2mnv4cBr0d
 VG4MiFZQslBJY+dTOHy2QPId/AOZJXmHqUgtFYn5jpO+OlD2rPiER6+FxB76cLacmBlH
 5RmGWU/6hxBD1Cx88WjRrnqFdnTmJ06X+rI5jddJnsijGLCyfoQOpVmCxz6WPX8H/SmV
 6jI2W/ekIr6snfP6DOIKAZurI4VQQarmdNyjITj2O8s2cMQP8ny/UJoV73Kn38EAe+O6
 rEoA==
X-Gm-Message-State: AOJu0Yx+C1U38+4e8f2Ho5iqxVly/pCcxFHKPuOxS+jzHB1eZI5wUf8q
 peA85+8zp+i6y9Gv06KkbavAatwJm9Mw3nsHEiLcNIYKs82Fk0LwPNeSMyh+hpQXdEHIrwcyTCL
 /N0T78V4=
X-Gm-Gg: ATEYQzzT1k1aIjspPfiH/jaNTPJADmv7sKXZmpowGUAD/Bs6EA9hvqba3rKy1fEXwL5
 VhNSy4z0Q1I+y82ZoWLc0T6Fqas8WjGNrlcUgPHI5eksgYSLxcZI2tvoSmon6jApoeYMTBbsI/5
 QDalRlZBVOE5nDCDWoKu2By71aWG/rkZju2UGNHQPWrvftLkAA9RB8kOTBzw0kDmlgtbk7p5gvg
 tBQLjh0XhKAqLp4CaNRbHMTkv47mdW8z6orI/yFuM87V586NOCdX51/nnNJHCpaLQUAohaoEWlO
 Y7yToW0vZACXKsYF0V+B/b3og2YgrfHBOKWvnf0dRgu63pvUhicOzJkppSEvOmBautCfQVJ4LOM
 wauVwXHd8RermCfUOYbROVShSbla/wdozYPKC4JDB6E6OEPwHdDmHCIFLY/U5A/VH/Ig/ZyrMvG
 e3KdqL9Qbalyl4Ykdx0smWZEeD1VJ2h1W67vfK1Lz/MTX4L2x1CQILSeHjKAi5WCLks7vTl1mC8
 qquTzuUJwNkt9/O
X-Received: by 2002:a05:600d:8497:10b0:485:2ce2:4c8a with SMTP id
 5b1f17b1804b1-4852ce24e86mr74582875e9.1.1773009453042; 
 Sun, 08 Mar 2026 15:37:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae56300sm20799956f8f.37.2026.03.08.15.37.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/49] MAINTAINERS: Replace @tuxfamily.org address
Date: Sun,  8 Mar 2026 23:34:10 +0100
Message-ID: <20260308223433.25503-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <huth@tuxfamily.org>

Tuxfamily.org has had many outages in the recent years and will likely
go away in the near future:

 https://forum.tuxfamily.org/post/3381/#p3381

Thus replace my @tuxfamily.org address with another one that is more
reliable and hopefully will survive longer.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20260303203044.8403-1-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6730cee490c..5ad5918d7aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1357,13 +1357,13 @@ F: gdb-xml/loongarch*.xml
 M68K Machines
 -------------
 an5206
-M: Thomas Huth <huth@tuxfamily.org>
+M: Thomas Huth <th.huth+qemu@posteo.eu>
 S: Odd Fixes
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
 mcf5208
-M: Thomas Huth <huth@tuxfamily.org>
+M: Thomas Huth <th.huth+qemu@posteo.eu>
 S: Odd Fixes
 F: hw/m68k/mcf5208.c
 F: hw/m68k/mcf_intc.c
@@ -1373,7 +1373,7 @@ F: include/hw/m68k/mcf*.h
 F: tests/functional/m68k/test_mcf5208evb.py
 
 NeXTcube
-M: Thomas Huth <huth@tuxfamily.org>
+M: Thomas Huth <th.huth+qemu@posteo.eu>
 S: Odd Fixes
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
@@ -3088,7 +3088,7 @@ F: audio/paaudio.c
 
 SDL Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
-R: Thomas Huth <huth@tuxfamily.org>
+R: Thomas Huth <th.huth+qemu@posteo.eu>
 S: Odd Fixes
 F: audio/sdlaudio.c
 
-- 
2.53.0


