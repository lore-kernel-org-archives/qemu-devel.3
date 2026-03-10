Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D456FD88D4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06wh-0004vP-QV; Tue, 10 Mar 2026 19:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ya-waQQKCkAtmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com>)
 id 1w06wg-0004vG-I7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:02 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ya-waQQKCkAtmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com>)
 id 1w06we-0002JD-Pz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:02 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso63993252a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773187018; x=1773791818; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3OzRx4Ayf7JNrNz2FuMOcI8qzQtwuTq3zPiiZAoYYj8=;
 b=MgHKgkXZRoEjnhzN9cruwWAZtxxLxokWehd5FzGhvT43ccybdduJ17OfKNjC1TQRvW
 8hIAMd22zh+YpaFM/xD+hLK4uq5H/5hx7XIG/cH2+UHJr7cZHbQilUIvzgHPul+9p257
 LjxGOhDufm7tjXiO4rBOaDxndMjZ3F6a+AuYIPmATiRqqmM7k2fNWKQKIAzZ2DBq8ZR0
 miSZj6LcsrXT6JnqdyMdZvpXOOWKtNQFQhM7cA+RLj2MT8KvHI4lvpnete0P4HHqAFIV
 OazbPMkYjVXW4MvTHxoYkLH79Iva7qOJ2grlTm1Y5QNzFYixq0GghlXi+sbWZpV6KJV/
 2BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773187018; x=1773791818;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3OzRx4Ayf7JNrNz2FuMOcI8qzQtwuTq3zPiiZAoYYj8=;
 b=KcR4Yh//xJiOOeKQ6gD+dWpaHdUGWo7Dj1Lmdjp3EEZgw5P3WnyP/sVbj2rUtUXRk/
 BGUPlkxckxA7b/qCl5fHjuXLc8PN6BGl3XuvTmWqsrFdUdeeizlgnFDA6WMxINtvUxqd
 azZuQWu5UpAI3A6lYHBI1NgtRTjZA/dZqbAccDz1W0ni8kk5mCPLUbRBiYtm4z3m7iMZ
 vH/KcsaIyikUsnkrnN2BvrLj+p1ZxrL5G7jM0XRnLlRc1PmWPVGn2gwjsW+BgNJnwE3e
 YLz5HzZ6TeC8iCxjW5y1kBJ5SqfJvlbHvVKjaYOmRYKKIeIev2OpNe6afwQlkghTw2FX
 Xcbw==
X-Gm-Message-State: AOJu0YwupHGhzOVJf/kPaml2uMWE9TVA7nKDN4SSRrfEws4zZxRm93ko
 LfkFLuV8PfcAdrvbFY5Rg/QvoIgKIqLg48KLGtuutnuqfO8o9XW7JC5CJdDatI92XJKsP1Jj3A=
 =
X-Received: from pjqx8.prod.google.com ([2002:a17:90a:b008:b0:359:f772:3291])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5284:b0:359:8190:eede
 with SMTP id 98e67ed59e1d1-35a012ae4e6mr569155a91.9.1773187017920; Tue, 10
 Mar 2026 16:56:57 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:56:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310235632.3987668-1-rkir@google.com>
Subject: [PATCH 0/3] virtio-snd: snapshot prep cleanups
From: Roman Kiryanov <rkir@google.com>
To: philmd@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3ya-waQQKCkAtmktiqqing.eqosgow-fgxgnpqpipw.qti@flex--rkir.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

I am currently working on adding snapshot support for the virtio-snd
device. While implementing the VMStateDescription, I noticed that the
device currently retains more internal state than is strictly necessary,
including unused fields and full transport-specific layouts.

This patch series cleans up the internal PCM state to reduce the overall
allocation footprint and simplify the upcoming snapshotting and migration
handling code. 

Roman Kiryanov (3):
  virtio-snd: remove the unused field
  virtio-snd: remove virtio_snd_pcm_set_params from VirtIOSoundPCMStream
  virtio-snd: introduce VirtIOPcmParams

 hw/audio/virtio-snd.c         | 21 +++++++++------------
 include/hw/audio/virtio-snd.h | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


