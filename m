Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB375CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU2L-00066K-J2; Wed, 10 Apr 2024 05:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2H-000643-Tv
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:30 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2G-0005eV-9h
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:29 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e6affdd21so749440a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740466; x=1713345266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTSWrkOypAhA6kMD+44qfKpFKP2exY3ZyHzORb0u98w=;
 b=oXsZY55LCsZxH50L8PiOssMIUl8C8XunUgnAZja1vejZbJ4HX2JtZxUJ8MDHCP1Wi/
 lF8B5vge1Dx9kNpKO0N95IkuOdgdPggTBk2x36P7j5Nw127BfWFsR4UbKh5nFdyEh8Yk
 mq4IroeuCeFxrUzOUPDsIgHrCiQSysygaclqv8dFgySDrv2jXP+uUUtHWd+9AKr/Jy3j
 4lQa7Lu9puLnA27zKwqCsx60QPUDDzo/Xi6qJH5X0ZGNfl2eCJ01WjtvMJcYwmyspEf4
 /EqnRVcvr0lG/3dpSbtIUJ8t6y0obB2QjewT2So8ZO0k92tbHl583nMVnsrLrOk12nux
 70bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740466; x=1713345266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTSWrkOypAhA6kMD+44qfKpFKP2exY3ZyHzORb0u98w=;
 b=kfvP7QLihbQwXCEGnAbOACADVzYb8VEfaPrEFhGpZ0T+cao75ZBIcPj2K7vk0ihRnK
 /gZWT7dvuncLVz/afBGqieq7qjJZ9yxuSU+hpLhgWeJ6M4OwzY9bc3dbjZcInsZSoKkJ
 xUec4wTuqwLDW7n4iZ53WYckzapcW8eF3R3Airr/l1jZIaUeFViacycGMmXgOYR+XW6E
 /Jk8bo5BRj6Ue+SR7XFN/wKHWbpGm09vbQ2hy/xKHZznL7QRiF+/IHuX4gre8fWLWLzm
 j6p9g6z+IZnrXkexqvZZ40PZ94VVmaFqeuIzEVEnzlq70fb4oAXZx81zuPCGAiNevm84
 dv+Q==
X-Gm-Message-State: AOJu0YwkuwP9x1ATK4hBEgJSYaJRVrY+t1KFS98a6+lu96HonVTVgQ4k
 X79abhI4qlCrB9S/tpTjpDxfOSwveYRp51poxjZiq+Ld7P6KX6SCsjgFWnTcW/Bh+9eOshIl9Pc
 0
X-Google-Smtp-Source: AGHT+IFjXIBmBO2Boh2IgfRGkJN/ZJD1o3HtoBJs6FHg3LfeGF9+laVHdPEhR1i+19X1DqUMHPDx9w==
X-Received: by 2002:a50:ccdb:0:b0:56e:64b:8733 with SMTP id
 b27-20020a50ccdb000000b0056e064b8733mr1416801edj.40.1712740466408; 
 Wed, 10 Apr 2024 02:14:26 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 cq9-20020a056402220900b0056e3418cd4asm5786842edb.20.2024.04.10.02.14.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 zhenwei pi <pizhenwei@bytedance.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 11/16] backends/cryptodev: Do not abort for invalid session ID
Date: Wed, 10 Apr 2024 11:13:10 +0200
Message-ID: <20240410091315.57241-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Instead of aborting when a session ID is invalid,
return VIRTIO_CRYPTO_INVSESS ("Invalid session id").

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none \
     -machine q35,accel=qtest -m 512M -nodefaults \
     -object cryptodev-backend-builtin,id=cryptodev0 \
     -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
     -qtest stdio
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  outl 0xcf8 0x80000820
  outl 0xcfc 0xe0008000
  write 0x10800e 0x1 0x01
  write 0xe0008016 0x1 0x01
  write 0xe0008020 0x4 0x00801000
  write 0xe0008028 0x4 0x00c01000
  write 0xe000801c 0x1 0x01
  write 0x110000 0x1 0x05
  write 0x110001 0x1 0x04
  write 0x108002 0x1 0x11
  write 0x108008 0x1 0x48
  write 0x10800c 0x1 0x01
  write 0x108018 0x1 0x10
  write 0x10801c 0x1 0x02
  write 0x10c002 0x1 0x01
  write 0xe000b005 0x1 0x00
  EOF
  Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
  function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.

Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20240409094757.9127-1-philmd@linaro.org>
---
 backends/cryptodev-builtin.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 39d0455280..a514bbb310 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -427,7 +427,9 @@ static int cryptodev_builtin_close_session(
                       CRYPTODEV_BACKEND_BUILTIN(backend);
     CryptoDevBackendBuiltinSession *session;
 
-    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
+    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
 
     session = builtin->sessions[session_id];
     if (session->cipher) {
-- 
2.41.0


