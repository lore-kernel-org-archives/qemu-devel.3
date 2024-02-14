Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309F2C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFs3-0003mE-H2; Wed, 14 Feb 2024 09:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFrz-0003jv-Q2
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFry-0007Bi-6i
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d944e8f367so16492645ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707919453; x=1708524253;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pEI2WvfoAsGKBNaBDe79EIfk6lm3pODeqpO1Qugvgkg=;
 b=k2uXiCOmYbl4M0zGg6F+9IQHbxfVeJBtPMYgM+Wpz6IF4jE27II58lP9Ew+peUHxgh
 aS5ta7lCO6g9tXl8Loh9LDcNqjZ3AfLOHJkU0qOpdvHp1PJaFe+GY2cjSSucIwAGXJCc
 5sxCkmTJzWCeCKvs99swVAUNMWZRIWuI9bZU8SqiijKTHmy8q3i1f1FnRIq/w3WuCYEI
 jIkH//WcL48asrgpXyhhLnLCtTKdS7dPdtEhcEGkTgK1E5lixpyEgtP58MwDBdCG+f5D
 kOIK2vfYQc3Y85ekr3kDPvNKMzoc6Yuwpp0PrRy8hdJs1KlV+TfxgHRvk7NhfQ+Qui2p
 VnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707919453; x=1708524253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEI2WvfoAsGKBNaBDe79EIfk6lm3pODeqpO1Qugvgkg=;
 b=thR35Jdr6XENZwSndxyKhUxTBRW/xDuFvF6tzTeE73/0iEsi2IO4yJTwBphK1kenFN
 v6QKufaPALot+aOJIsT3Wu+w93yBfQKvv9D+W7Dbv3YvqFwBxguObb1zOe9wo33yA/5K
 HyfJGxTG/e8Mwd/aKn6xcZ99JXYnlQFS2WzXgAkXagrUiE98DrcLy4WXsTMxxy5bGZVj
 aSfCBhndPHfjIjAekvI8tuG2lOVvMS5AlyV8qasoCeI3UNYB92okDAwVCJfTLL7VOBEA
 II4xWXNJLD5jNZtwAWKPxvTjs+17Y+eLlhD1Dkv1z95+AtInNPI/CDiJ55mt1Tpqh6t9
 tcOw==
X-Gm-Message-State: AOJu0Yw3YrDyKNA6wEv/XLfgiOqGTcZXuS9rm+ZCJaOeGyzxALH5Ji8O
 WulFlWqjpsVkuouZKTlUnACGy9uAlME3Vsh/W3wnRSybf24hQdWd4r//LLLQqUU=
X-Google-Smtp-Source: AGHT+IHbVPVKkCCpxS/XdMEU+pUbll//xKv8Z9GBQILyCD83WwwMwI3aN3PA507w3ituNkpxSy+BkQ==
X-Received: by 2002:a17:902:ecc5:b0:1d8:fafa:f923 with SMTP id
 a5-20020a170902ecc500b001d8fafaf923mr3463024plh.10.1707919452769; 
 Wed, 14 Feb 2024 06:04:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUD+rK/tssUTiAIP2tFcsh96bgAPT9BUKmFHujQ9WZQQywmRZJTuhMPLQGnNjzetLuozSGyXp+DwofDAE52JB3OqsS4e+Tsi6SERfvSG8PxB5txdICebmuOaqBMoTnor+tnSNxLgLqL/n5Cf6V/dPR+V314bT0K0VDKkLpFlu/Tj+CgLE/PBZoR2Pf5lhmq7MxocT2H6xODQLhDXlVIJFGi43WyIywkzlKO46Z5+I5MhGbVtyD1X2/AlVLTYU0A
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 lo11-20020a170903434b00b001d97fe26d47sm3783187plb.34.2024.02.14.06.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:04:12 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 23:03:57 +0900
Subject: [PATCH v7 2/3] meson: Explicitly specify dbus-display1.h
 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-dbus-v7-2-7eff29f04c34@daynix.com>
References: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
In-Reply-To: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Explicitly specify dbus-display1.h as a dependency so that files
depending on it will not get compiled too early.

Fixes: 1222070e7728 ("meson: ensure dbus-display generated code is built before other units")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index 376e0d771ba9..0b7e2b6f6b42 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -91,7 +91,7 @@ if dbus_display
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
   dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, sources: dbus_display1[0])
   dbus_ss.add(when: [gio, dbus_display1_dep],
               if_true: [files(
                 'dbus-chardev.c',

-- 
2.43.0


