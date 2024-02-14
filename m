Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F8EC4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6wp-00024G-EA; Tue, 13 Feb 2024 23:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wn-0001vS-AF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wl-0006B4-Uy
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so43640005ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707885154; x=1708489954;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UHpMCU9+Q+3IXmsSy1dT2hPPsLkN972lqGuEQ2h6qwE=;
 b=seOW5gaZci5nHI+r2+nDyht/hKs6bw/A0EdOxPy7eRbMTsmnRw01AurBerVpvIop2V
 /z05HA9D6bi//0R3OmmC6oaj/ckEq+3mRIqu1vxbrhfDaj+/+CyQywr75St8VQriu0By
 cOYo2PJmpePUUOtc0l20ffsjcuHxWKqQDB1+eNzikYmPLq/uP7PPTudmeOs4lPPbQrDb
 XsytOE17xzeQhe1WJzTbY9oiI11GqDHDWbC+64SNxNEJWiKJ7RlK2vCUljoF1Exf0NHP
 /wTMKor/LaFKHuvQUlfXiayVCiIn5zq0ASTRNGsFi70qzU80Q0aqdDQwWZAtcIl0VP8l
 K3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707885154; x=1708489954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHpMCU9+Q+3IXmsSy1dT2hPPsLkN972lqGuEQ2h6qwE=;
 b=Co5YgZ/0nvmdUh01/LvBE/ptPhv716e97uJ/GVuTHXiWedZ/DQdHmrEZhp/NSptCV1
 wBqbpf7JLAQw4PWRqdDkKf8GTmqoQQYWsbBp9Iw8wkYCfB42f9nInT+1pX7ZchsJ+Qpu
 qgqod+xLDNa4/E4qwb/RtK5LOiddkPwypc9vILmQTiW9BW6sOXv8843XA2GPNPlv17/C
 BwBJbEDOUF3mVsz/czfQJruQ/2es6Mn/G0mJTiVG6QJC3slLTPB0EfwtWqIbRRVqSccg
 ZewVPZz+NkHhirxkHcvFMJ+AC3YNvIJvgLdbP5J2skW99/RIpUP0EUEHse3w0urZ66p8
 Aymg==
X-Gm-Message-State: AOJu0YwouxHAC0nNOScxi7+Na7NtDvZn5Fi8AVJcH8pCt+GldEQ/EKeW
 O8Sm558F0Fp6sg8XcQC/GBYU8dNrVAfbOWDB9tvP6U2RVqCW1++GAgd1xg9SYp5j2KkEMYwFLPu
 X
X-Google-Smtp-Source: AGHT+IG+7GyWgJ6Wwh5Hl4KEtfF8vZ/R6pampJ1DsN5le7ItEyPkqwFt+wIAUoFx59U4dtwT4RH+1A==
X-Received: by 2002:a17:902:ce87:b0:1d9:bc11:66e with SMTP id
 f7-20020a170902ce8700b001d9bc11066emr1714259plg.37.1707885154549; 
 Tue, 13 Feb 2024 20:32:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjTcZBqpgSaJGz9NDoBkDHizck2k/MID4sQl0Xggkn8C7tQ1Q8dXznKmH6Uqq+7K3ispvAqqHKx4VFLQWLGE361YdTMzDjkL0q245ySC3sY+2cnVKQNUFx9/fb35NBOtyagsCx/sbZ7+WCG8Q5K6hKlEB0/YHZlYxZi2kOid5BLJ3RlJ5S4g4lm+eGk4qVtWFEEvSAZheyu81Qsf5zQVtZT+iaJx0tMXnNUBdpprPl191fuffzzwkxq4eC5fqg3Lz9YCyIu4adgUyv
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 r3-20020a170903410300b001d70ad0fe79sm966130pld.291.2024.02.13.20.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 20:32:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 13:32:04 +0900
Subject: [PATCH v10 4/6] ui/cocoa: Make window resizable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-cocoa-v10-4-c7ffe5d9f08a@daynix.com>
References: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
In-Reply-To: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
---
 ui/cocoa.m | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 518fae26f6f4..a1f54b3ebb9a 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1378,8 +1378,10 @@ - (void)zoomToFit:(id) sender
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
+        [normalWindow setStyleMask:[normalWindow styleMask] & ~NSWindowStyleMaskResizable];
         [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
@@ -2032,6 +2034,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 
     create_initial_menus();

-- 
2.43.0


