Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA1EC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru85Q-0001E0-Px; Tue, 09 Apr 2024 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru85H-0001Db-3N
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:48:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru85F-0007nq-99
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:48:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a51e452a1ceso137917766b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712656079; x=1713260879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3hDI87sq1FSJETxnPQkKo8rSPEGOq41R9YSzB3DSAZQ=;
 b=BnLVPmLDHimgc/PQYER4c6PLRbW3pKw6bFFKG6tZqTi3HIYUC4lOfbnjh8DXDUDmrq
 s2XxZYLakx05EL7Im+asGrddMl3IQFub0FWtvCZ9H50g739ppZXtnlpMvSkjAFP4zY6C
 XN3R6jtNf6pQsJZmBDuz8KgAot6Pda6rK8PqCPzB7IyXjArxf69c87JW2QRcjy6HhvQc
 UF7aGv7UfvJtT8w86nqCKS0mG4F9NtPC21Bp6iJ9Q595r68nNJvPxHphR5bZY3nJzWGp
 RnzRdUOmDxcZFl2VfElcDhLlDivd4r6rwvfRtngr9+uODBvoJW2CMZnYM7Zrl8S1T7MJ
 waUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712656079; x=1713260879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hDI87sq1FSJETxnPQkKo8rSPEGOq41R9YSzB3DSAZQ=;
 b=cjpcVXNCyabJqmcs9MLVt6lqyEy16w8QtBopmQ18nvY1yFTLRyy8TX916cwltIzaK0
 Yfr34qstdMNuLfLHlh34RsAwT1OYJsk3B5Vv4gbCrp/BIwGrji9Oi/Tw14M76ZuPBgNm
 /dj/Gdj9dse/ibEVyX55J7Z7VY0lvHJMbwmQqhechUsup/U5iqr74iaK2xJSWCtEL3/b
 Np6WItwlnv7xufZDZx+2eJKKQG+QwfppFhsuJh5z3sOgbLxHG/YlrEYjdVJeHV3KkGpJ
 9+2O3m/VNLuXGsDzUzWYcuW+ApTtweHRBt7Jua1Bdcy6H+rZOlDx6RfCTL1dtIPyv01Q
 wCQA==
X-Gm-Message-State: AOJu0YxERZ1ZV6O5gl/vYafpnGMUNAymyXTGQ+ipK6eFwwg8IvRveQvR
 x0GzG97Eootq7KbP2gC4wQTt+uDRkWJaV01qZXKIN6/AZuCWfMqqPM6W8wCUcbt7eHkeqLyivLu
 o
X-Google-Smtp-Source: AGHT+IHRESIchrPnaDc1qZuWsH073VMRNWhDKbkNLomtnvh2XrT8yw+OQUDXqbml/xXWFxwlMUXG8w==
X-Received: by 2002:a17:907:728e:b0:a51:d136:affb with SMTP id
 dt14-20020a170907728e00b00a51d136affbmr5357117ejc.40.1712656079596; 
 Tue, 09 Apr 2024 02:47:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a170906394300b00a4e40e48f8dsm5443003eje.185.2024.04.09.02.47.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 02:47:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH-for-9.0? v2] backends/cryptodev: Do not abort for invalid
 session ID
Date: Tue,  9 Apr 2024 11:47:56 +0200
Message-ID: <20240409094757.9127-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Removed error_report()
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


