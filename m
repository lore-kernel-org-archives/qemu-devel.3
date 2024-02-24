Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97065C54E4A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrO1-0002B1-HU; Sat, 24 Feb 2024 07:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrO0-0002Aa-Ri
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:12 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNy-0006ui-H0
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:12 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-599f5e71d85so1225951eaf.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778649; x=1709383449;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=quIPhkmGqk/yzrPnEiTwezMNDD4NMK43Kc2jTugQyzc=;
 b=WP/UNA/fiWbga2aZWy5vnbSWmTFmqyIKjdrBMb/4R6roPufHV9qFlJxARi4zpt3MIi
 O2y4TPJhiQpB3o7X9TFq9kbKgDKAgcn67F4oS0pZ8tZY1rMt8PqJBP62/8ZmMuZGjXoT
 igoSTKIgWK2kpjU3qH8KdVXH3SND63KiVnAfcBZtClEot1AHTQH72cvFSuOERSFikI/m
 VFp34I/Y8QXR8eYz5MtCYBLneFFDJWhH0+4mZlzl0+aPkLWChLI71fQpT+wPdgbFewJF
 qKej+hjc3LPowGrXqsL/haWqbASOVFLTtXeDZG8p6Bl4GOYvt00sM3XjgjMWAjI2stVe
 Xi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778649; x=1709383449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quIPhkmGqk/yzrPnEiTwezMNDD4NMK43Kc2jTugQyzc=;
 b=UNp+0MxszOOoUtPksQHq0IxY532v6qg+SyekWh5Rz3kdYnuWaXZRAbgDmsqhD/+6az
 txkYUDn+9tAEt3C9RFXTYXYP/Dzaunt7or8cVGJA9IE6BebMAuGkH2De2aCH6i0/DWZ9
 5kpI2BO3cIoE02lI0uFPP5Rw8x+73Fqj7WngyEjGiPAM23THK/vOF/MTi8YBv1ICk+c8
 TIBLCfLaiO9784P2jthYZlcDhmE9Dek4igcqOSFPnnkkylhv3gv5rXQmnerYUhVpi9wy
 8mw0piPkxT9VRBNjVja3J/th2taN38o2HUid9DnTQ/+BYG3NF/hJ7JQy7gmTVvkcxNTD
 9Y+A==
X-Gm-Message-State: AOJu0Yy+jrBSCczn6D7d4Qym1E26jL21uMTn4z963mwogKY5o1ff6UUw
 Cy9wW1iFd1IawVX/3iDt0MBTZhVZLdnt0zKY2hAQ5Qsm2fFDv9kBXP5lbc3dYsc=
X-Google-Smtp-Source: AGHT+IECVgOsib4PfzgLWg+OSbRtOgsYIHms35kijUmDnt8mro5ybPXVRCF/3KvXSe6utOgKZZMtKA==
X-Received: by 2002:a05:6358:7f87:b0:17b:c8d:f396 with SMTP id
 c7-20020a0563587f8700b0017b0c8df396mr3331471rwo.29.1708778648566; 
 Sat, 24 Feb 2024 04:44:08 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 q10-20020a056a00084a00b006e45e20e3ecsm1054167pfk.60.2024.02.24.04.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:44:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:39 +0900
Subject: [PATCH v12 08/10] ui/cocoa: Make window resizable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-8-e89f70bdda71@daynix.com>
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2d.google.com
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

The window will be resizable when zoom-to-fit is on.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 05c91e4eed53..cebfae04d9e8 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1348,8 +1348,10 @@ - (void)zoomToFit:(id) sender
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
+        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
         [sender setState: NSControlStateValueOn];
     } else {
+        [cocoaView window].styleMask &= ~NSWindowStyleMaskResizable;
         [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
@@ -2002,6 +2004,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
     }
 
     create_initial_menus();

-- 
2.43.2


