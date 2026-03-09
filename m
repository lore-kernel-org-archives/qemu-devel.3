Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6DF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcwf-00081O-Pa; Mon, 09 Mar 2026 11:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcw1-0007Td-MI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcw0-0000Mg-6T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso14201605e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071655; x=1773676455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8HKEnxXC7jOdNFCw1vDK2f2aMKDF2U6tfcBZgm/YZAs=;
 b=oIyS8P55aFboGC/DXsIrU0vFutSSO0OXgppM0R/f8LXmzYe40O+MlU6tJgJFPwH5EK
 hpMj+GOq+lY5fppr/++i6yVZSCO9HqqrecT/0letUNUYJCRFUIbOpItnJRsaqecqA5mP
 oNhgSYFsF9NHxHHFG6Y91yJho56GZfQ3l5ONtV2kPnGJ9WOM6pTk51jRbMRoG1H6YD/i
 dBY4mlG7OvRhsB92QCvXG2aZ5HHqfteONAQY+pzNF8jv+O0toRcbK8wqvGDjP9KUlDGC
 Zj3h0Bczn7sPJpQRNTMT8oW2T1Weoa7ssFdVUU8LUhUDRhe2arba9vzLvKiy4SktItaR
 Geog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071655; x=1773676455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8HKEnxXC7jOdNFCw1vDK2f2aMKDF2U6tfcBZgm/YZAs=;
 b=f3GWM1o9AtA0vgpNW43HifN0jZVM8DJUQNk5YGyjNutYJ61Cfg5YfvMtWssrPg/NY+
 PfLqM+akWWgM6tnl9TUMgzsLbKdWWTG6nPQhlXEvvwZuTQVPQQi/jp4JHy/how70S0cc
 PFQM6HcqinyF/vL5jq6SuceBjLAqFgScOvNNCkL99Nk9KIgSXxAwrNDgdl2HPBlZrdaG
 A8SXMcDuZ1spvUlQBmD276HCUpHfNWKqnwuoVzrPBiZBCRI1XnZH9/UYk8Csbv4oWUCT
 d5qpgt+ADogjf9IMDJK+WIqkXc7qHkx2JqGvKOLbO35Pq+E7boiyxDUG3jLApXtt7XE4
 9M7Q==
X-Gm-Message-State: AOJu0Yyx0saFqUiB2PoWzm6AIofJUu7CRekzC8AKIjZGGvIyX4u6M+qi
 mB9UIhg5hbw+NcY6Y67vtL9+h0bY9FYXW4mghQhMDFAEYNalNaiI+OOVBI6rpv8JWJonr5pgXTL
 6VRWStNY=
X-Gm-Gg: ATEYQzx5eWv5p3YD6Qdmc+EkxKyQ/OtbXjOzHzVs9VnFugX3M7IasVcvcP6T1v1DihL
 Hm3uX6KSw5cxP1KBSLnhH4Q2tEaUGHcMiHld6geullaD8X6QOKkeO/axDIn1mbctLPzenyS3ODu
 biGPZwc7OINEXk0kNpCLkTxnkFcCWbF3eJCs6yjNaA4Gk/FHfBfm4Lk557aDebgKTOgUS6pyDhh
 EpouY0wFH7aIFB08l1NI+0j+4cpS7LIsRx/OfW6YyNuEOCNmND4nqpWbEU6CoJjJxvBP5YWsVXj
 w5YvOmlONTIUPiXekcopckw1QfiVwC+bu2UmmDc4CzoDNWGjkq0yrsznraWZHf85dYP3pftbicn
 stsF+4BOz4u5UPTcUeReHpISi/8NCGOgyxE7Q4+13tGEzTEkN/DHUvPBSiaEvMbALsGT5WOlufj
 4TF2rxY9me73z3oV7fS8qqQeclbZQWy0ZVLx9EZwQ088ZkgTZdMv8UBaSmvXbfWBl80b8y8zUc
X-Received: by 2002:a05:600c:8b4b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-485419f1614mr1523135e9.11.1773071655530; 
 Mon, 09 Mar 2026 08:54:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9c293sm627925e9.10.2026.03.09.08.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/49] ui/dbus: fix leak regression
Date: Mon,  9 Mar 2026 16:51:47 +0100
Message-ID: <20260309155219.62400-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

For some reason, during refactoring, an extra reference leak was introduced.

Fixes: commit 7945576cf2 ("ui/dbus: factor out sending a scanout")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260122113144.2046899-3-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 52e041edb0f..407719fc1e0 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -815,8 +815,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
     qemu_dbus_display1_listener_call_scanout(
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
         surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
-        G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL,
-        g_object_ref(ddl));
+        G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
 }
 
 static void dbus_gfx_update(DisplayChangeListener *dcl,
-- 
2.53.0


