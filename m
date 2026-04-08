Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F0410F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYbw-0004D8-4x; Wed, 08 Apr 2026 15:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY9F-0000Q7-46
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAPnV-0005jk-HF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 06:06:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so3797018f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775642767; x=1776247567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHTH/uGgH5PIwndy2Wldd9xoHKKg1h022rqcq/Lli30=;
 b=v3T5M1NP7/oIObEv3MvZvZcFVphCLe0R40a/W2OOwxPmt7ZXDipHXB7WLAfqGT4ZGO
 uKSxxoUeaG3lv8m91mxVU8B+M5H/KeFA1yeid2J5y97Q44UB18WzjJk7KqLfZ83Vqft+
 TUPvS1uAEfg7YoyYSZMaEV337oeGfYu+1LtWFFa/PUFOqpzlt3xP6MSwn9+NIPiRret0
 qgQyMUBXK/mBXupmDXpbRPQc+W7K5cYDJ5S3MEuYKdEuhv2+w5/861+0yqry83n/9WPE
 HI2yL1FoHcDF9evO5CdS1BpbzcCrzFG98p6fFbm+ge1/ISCoQWDvBNzrT/Is2tQ2qV/n
 aTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775642767; x=1776247567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHTH/uGgH5PIwndy2Wldd9xoHKKg1h022rqcq/Lli30=;
 b=jiBxba/wdflNmm+wrxaMfzwITY80+UFvdxxbhm/faRILOCzpifYOXCcICWWqY3KO3q
 9U8ohC5LSuF3Yt1+O2dP0+AyP0eL4ZTHRrTY2La6CEISUJs0g7EzVXVVxKmvkiggVT2r
 IEMCFe3RO6kQsC5gqi2GnQ1rLIycVSQyGm1HSMAwv8aKJkoR83FqM75jnNl11TvqFKCA
 e888RUdy/LE2TjzPgVaEl0/o2PYVQi70z2cxNJNEsRWk2728IluHn1fwGKYzNQ2PH+Kr
 7KZ8ZZF6dlLFJnZDNdYzY49AYv8T1HxTAqs4Q/tYQ/bRdgqUolc+RnSdBaRBabkEEaUz
 QVHw==
X-Gm-Message-State: AOJu0YwZNteZDFSnwEW1jmsWGWdh654YOFd1YK51N4pi9nIMCxpMjNWG
 NCTc7xx4fjw/NLgrrmAvaaEfusYGqVRmQNsCyFCl36JH8ANcelxMbxR17kK4exggLCBKeVtQNsG
 QReCyL1U=
X-Gm-Gg: AeBDieuu8KqqLJ2WLAcZY++rpbQWI+zDka4ClpmKRJ5B/gdya5VxGCaIBFAtrNhOlzH
 TQTBCaxhnGGKMslbFvTTObShq8UmrF6phA1Pif7maOZKaJRf+e25GldXkp4Pfh6FJfAs1x98gjD
 jJp6ixsNj2IiI2zlJajhu2/dhj3DSebnK3NVISDOb4yx+iILlsGpHC7uY9CvPwDyaswQEF4QVuJ
 Yreq1tF8pkN9x9fh8Ky+E+UWunKSCWaWTY/lEmTkfiuYjpU7th6kBqWMUtRav10PVCD6wxdjaMN
 63NAS5KvQ9swrCjtIapdiTNygLF9dm9MT8YZT/zZHvrlGlDTwv5BhuGu4xW5dV+XRx+cPN9xS+y
 fiJO+PbbIY9pJkoiNYIFB1MQYMaknWMzMdghTGbDu4IaApWHsDikEOBd5Kfwnyooj58n65qlK9i
 xXiTeIE67tSsFxj0mb7Jiwekw+MZrzpT1IrbSZaJkcBka6HmJe/JfT7rJKQLLAmsjpcbg5yg2H
X-Received: by 2002:a05:6000:2503:b0:43b:4136:1e76 with SMTP id
 ffacd0b85a97d-43d292e3e10mr30550681f8f.29.1775642766941; 
 Wed, 08 Apr 2026 03:06:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c637asm54636719f8f.14.2026.04.08.03.06.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Apr 2026 03:06:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Penney <matt@matthewpenney.net>
Subject: [PATCH 0/2] io: use g_clear_handle_id() for GSource cleanup
Date: Wed,  8 Apr 2026 12:06:03 +0200
Message-ID: <20260408100605.66795-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Generic conversion inspired by Matthew patch
(20260408010026.4611-3-matt@matthewpenney.net).

Philippe Mathieu-Daudé (2):
  io: Clear dangling GLib event source tag
  io: use g_clear_handle_id() for GSource cleanup

 hw/char/cmsdk-apb-uart.c              |  5 +----
 hw/char/nrf51_uart.c                  |  5 +----
 hw/char/serial.c                      |  6 +-----
 hw/char/stm32l4x5_usart.c             |  5 +----
 hw/char/terminal3270.c                |  5 +----
 hw/char/virtio-console.c              | 10 ++--------
 hw/usb/redirect.c                     |  9 ++-------
 io/channel-websock.c                  | 21 +++++----------------
 net/passt.c                           |  8 ++------
 net/stream.c                          | 15 +++------------
 net/stream_data.c                     |  5 +----
 net/vhost-user.c                      |  8 ++------
 target/i386/kvm/tdx-quote-generator.c |  5 +----
 ui/dbus-clipboard.c                   |  6 ++----
 ui/input-barrier.c                    |  6 +-----
 ui/vnc-auth-vencrypt.c                |  6 +-----
 ui/vnc-ws.c                           | 12 ++----------
 17 files changed, 29 insertions(+), 108 deletions(-)

-- 
2.53.0


