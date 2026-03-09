Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7CCF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcx3-0000GK-Kb; Mon, 09 Mar 2026 11:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcw8-0007da-OU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcw5-0000NP-Mw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439aeed8a5bso9201614f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071662; x=1773676462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5uB+oJJAcxPuGuh1DjXOASB24mbYKaB2eXGC4gPbaY=;
 b=AR9Jfzy4NgGp2hhpMOk2vJ8fteyFzTZrTsQMv9EBad0qok5elytVn0jaYZXyvyT8+a
 TXmpMaZMna1Xnavqe/tmylS0N8bBAhjJCIrC0BZLetC+OjR9uyiH3DfaZKGj/2Hc8AKK
 D4R9e/Drgk2QOmEcpQ67H640+ZvYmNC1hI7PdSH8+uqCLll6Men8Cjp9zGe8GOKkbBGP
 iL/sb4k/OgxbFblHwuSw/NuW2G9XFFEpxSVJg7eWQIj8o4NouUBgKtVNvW7/Gf3gHhG6
 WokVo1EG/N3LvPbB3iMOw0cHQlW7sbxMyWMYA6u7OWk4IaymNx4F14CUV3X1hEI51R7h
 yW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071662; x=1773676462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z5uB+oJJAcxPuGuh1DjXOASB24mbYKaB2eXGC4gPbaY=;
 b=XjjY3BrpX8SvmPm3E929swrG7Y7JohksHmkci2eSai/Ur8QM9hpqWH/BjC6R8cxs/h
 rGgUtYMF3Bzkchswkw5bwllv3nOA08F47ZlWuV1KwYEOHSMv/BStUcZ/gcSyT2o+u9Mu
 od25qHHh7o6CEdA5ksHrGVM7p9TsjyzBvJRvT8DSDgwjOVa8HD3hhI2VcyJL4SIinRG3
 69iPIxa/H3wRV+rwEGkSvnsc7Qv17GjxeZxrh67XhZx3kCEp4G8JfIazQKA/y9Y8CXJO
 CjPEK+deRp2g+TIl2d2NjnR4DkI9ZvdzpH7UIbXV4cMUfVrk5sdFLYQJknEcRxwiVh03
 Ulyw==
X-Gm-Message-State: AOJu0YwVQVNt0c72/VnJrgOcuqjsYc6vMgdlbk35Vw9+6pkwzF5TG3s1
 6Y5tXnpMOnNp0eekee4+iVbpZWFJi9XtAPuxMSrJYssqIgNQtN52rfJ8H8U6/5l58IU0KrqgBet
 TsTCn9oU=
X-Gm-Gg: ATEYQzxDh6rZ4nv4j/GgHTJwr0D56neoxw+hccuhfV3AHMf/Q8M68xd7VZlGIAA3dRG
 6adHksO22wn6arxRlLHaSrHVBte5JGm7VRpYqiqe8Sdhl1o4p1yBXEMzzi5BYJ1mcpX888pZB99
 X0ZaT6HVs9O3HBVwqxXqadB15MUytQKPO9i5Eorc99BS0rD8ycUT4E5w0KaOggyc9YjKj2/Qx6q
 FNoyAdpZGAuEqh589uT3LNew1hCkctdyT0flLHyoGBg3/yiUppuTto6kzHD4VO2G4j3C1MFUG+F
 kAGFAWGkAbUSoO1aGChkQhCTi9Sfdg+4hG8NzLuikqBKDIuchOPwqI+b0We2vpe3ryl2y2Q54aL
 ZM90moviwvV55yvEQ1JX3996/h+iqYt58iWRKFI3qC31+IH2xsBUfBgIscVn+3zeboTNdDCkzZd
 dhsK6SgxO4no1haDd5/8nznNYerm/CJzpxf8AkQQvxJa+t2dK1YmkhyptEg508wNWnauMKb0uk
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id
 ffacd0b85a97d-439da656affmr20384401f8f.16.1773071662253; 
 Mon, 09 Mar 2026 08:54:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm30879656f8f.30.2026.03.09.08.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/49] ui/dbus: fix Unix.Map proxy leak
Date: Mon,  9 Mar 2026 16:51:48 +0100
Message-ID: <20260309155219.62400-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes: commit 48b7ef0f0 ("ui/dbus: implement Unix.Map")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260122113144.2046899-4-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 407719fc1e0..46264839d86 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -960,8 +960,8 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->conn);
     g_clear_pointer(&ddl->bus_name, g_free);
     g_clear_object(&ddl->proxy);
-#ifdef WIN32
     g_clear_object(&ddl->map_proxy);
+#ifdef WIN32
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
 #ifdef CONFIG_PIXMAN
-- 
2.53.0


