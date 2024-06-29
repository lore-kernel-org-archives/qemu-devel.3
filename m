Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D1BC3065A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRWK-0001Dh-Lp; Sat, 29 Jun 2024 02:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWJ-0001Cq-8N
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:11 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWB-0000BA-IS
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:10 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5c21c5eb371so639446eaf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719642302; x=1720247102;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kvp08yfJRIidgp/95v01Xb3aU8UlxI7ZGQZzFfMbDV8=;
 b=2/1tv3RTy7Zev+EY2Dzo339+GmF0dqDJKfjK/bNArJdCJXbS7257+SZjaZYTsBZyha
 UvhN+fOOnR/sdv0BhWawKCN+OAmvtzGXaAR9gulN3qvctibvusPG9G3a8cuoF7N6kTK1
 6X+N9fQhf9B09DKRXF841Ft5iqeorWZSXIE538E9SoVvavA4HzntumwYYyIooJiwnFpO
 0v2XsdfFJpOVo/HcS6Arbo/DlP8r1iVcg7SXHbf8RusEBon2MC5WoHzzF78WQhGHvzv0
 PbvF+QActDZpd4IZvm7kBNIPnhkZcECkcPlKm546KUuUB/X7CLGk8tdpBN7UOdxsb3/1
 1kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719642302; x=1720247102;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvp08yfJRIidgp/95v01Xb3aU8UlxI7ZGQZzFfMbDV8=;
 b=eIZ2xCTLmF7GtgtwQD2vp6/Nb37IfgfyhOmtnErFVyxFNLC8QpW1CYyjPO5CFd2DhL
 GlLWulBR0vNEAmXXfBWSTcmcvYOfcjfQNY2qDBStXShcOptgZCVuc0WOUi6upiLN7+bB
 StkACqP/MAzd8+hpU5f1jlrQFfiPUSxbvMUwsVuVHozT2eXmwJayOSTt1DtsUQBB5F2a
 N6LSVtCPoY2zddZO1QTGIHZd8YUwEz6m3UEoDpuDfz/qvxrgCte+sTexOo4aRfsecCxh
 j+kpWxFHxowyjpMvbrlAkCPnRZ0EX82uMl4lZfPOZ9/MX7WdO3euMX6NubU670gXXRB9
 H6gw==
X-Gm-Message-State: AOJu0YwJwY59k0L8g+QsdLqbTUkAKOE+8cL1h/z9Jngm+/UFq+S1rCCw
 lI6s6BKDMza9sY4m+p9r8QhejP8wyRC6+b9C/YPAATz7qVLzKeOy2Q8B1ZtTw7I=
X-Google-Smtp-Source: AGHT+IELSIRqOfzZdviFOFtuk6xHyiEg/4OilNtkUmE2+uUG5s/PZvB7ic6z+4/MgTGCOnDcXm81Kg==
X-Received: by 2002:a05:6358:3402:b0:1a2:5caa:1482 with SMTP id
 e5c5f4694b2df-1a6acf43ed4mr28471555d.32.1719642302156; 
 Fri, 28 Jun 2024 23:25:02 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c91ce42667sm2647181a91.16.2024.06.28.23.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:25:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 15:24:45 +0900
Subject: [PATCH 2/4] audio: Drop ifdef for macOS versions older than 12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-macos-v1-2-6e70a6b700a0@daynix.com>
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
To: Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index ab632b9bbbbd..cadd729d5053 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -44,11 +44,6 @@
     bool enabled;
 } coreaudioVoiceOut;
 
-#if !defined(MAC_OS_VERSION_12_0) \
-    || (MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_12_0)
-#define kAudioObjectPropertyElementMain kAudioObjectPropertyElementMaster
-#endif
-
 static const AudioObjectPropertyAddress voice_addr = {
     kAudioHardwarePropertyDefaultOutputDevice,
     kAudioObjectPropertyScopeGlobal,

-- 
2.45.2


