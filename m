Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CD2C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTg-0003Zd-E1; Tue, 13 Feb 2024 07:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTd-0003Hn-Mf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:29 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTc-0000vG-0h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:29 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29041136f73so2564436a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825686; x=1708430486;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zthbQp6xqUSSgPtsY42mEFpzp+NHKvQicLn7aLSfUfs=;
 b=ehLhCMgbTqppBZVQRomM8N5dTj9AC6+3m+lm+tUz/6dT3VXJRVcxXkDgErq2HBBYHG
 YFVyMcaj8WDK7Uno/j8R6ISxAMzYnkp5TWm5V0eRhO26gJ5OUSlKIuGuQY2KS6V+wTD1
 7/ROQIUuuXTuDkORMIvnin+ooTjxGbiBv7OJ53XSrvjCZzJGiSolyVnSk95LSEy8m5Oi
 ZZABFbrsO5/eUApLRSBKxuFXf9HgEcqHXG9eLLIbeE7aKj9SSeJ1SDIHnjwR5VWF7MII
 9XcNTkacnmHg9Qo1Sszy1hmTEgku4I/ay+1lPb+SG6d7lZj/zVtmAIqxV2+XSQA6q5T+
 qVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825686; x=1708430486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zthbQp6xqUSSgPtsY42mEFpzp+NHKvQicLn7aLSfUfs=;
 b=pnbx2IFbdBD++DusdLzfQHIi/DujwOpP/KXMQj9rN9quAPqWjg0gQP1zpjgUWYVMam
 oGZVUEcmxS4HdkjFgNAb1XElyOINZD/okWB72M3dFVpY9srsK+JaEQDV1TFtpzAcgU8I
 t7xl1fxR0gEstjgo76v9v7Fox+gAqInj/tyEKb+weLUWigKE7kg1KmX21sQAP7QCmD7o
 7C8U2eg7BBGaFjGlGiIdDb7XZGhRtBKjGgdZGSbicjcca38OQzf5AFVg2cTiJZp+eRzR
 HHcOJEWSzSKba4CsQWMm/W0FVKHr5xySpi2wk/uYBH06lsQWvYOEGc42Jd3Fe//2GNEw
 zKww==
X-Gm-Message-State: AOJu0YwEMGfoKLUacajY+pfQM8EBOPdl6yItku69T/iclENiIwUm3oRq
 WnkyHZ1UeF4hoZTp/fZYxwq/6CYeE7j0Bd0iBFhIbCeBoof/pjj9VuFQzFlli+adJo/QMYhITus
 5
X-Google-Smtp-Source: AGHT+IFoeiw7mqldsysqIm6PSdv0Pvjet1svhREXIAncJwJlZx+blTU5dQb5S3TPkI23HnpHFDogLA==
X-Received: by 2002:a17:90a:fd02:b0:297:a6d:a499 with SMTP id
 cv2-20020a17090afd0200b002970a6da499mr5572430pjb.14.1707825686062; 
 Tue, 13 Feb 2024 04:01:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCyEXq0uE5gEeVNB+u1dQkhJCciqVT0sPLurFwtus7wPb8YyZeGi61bhI4oJdq5Z8ZaOCPOhW9n+kCrIZSLvNxj5QVMcvdldhQ+d+fOPr3Lc3rkyvvQMn7rtNpTbRl6noU9v09YxTm8xgD8CoTlnS9Y6SxGKCinEfZtr3zt+s4XdyuoPRm9p/nP3WTo6DyOubCRYikxrLUgVxN2VyfM/AelSLOQk+oWH6LLrXhk/+xgJcfe6mpMq0rqZwHL+vIyLVLZ4D0XSOIYkjx
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 q19-20020a632a13000000b005dc8702f0a9sm1096986pgq.1.2024.02.13.04.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Feb 2024 21:00:58 +0900
Subject: [PATCH v9 4/6] ui/cocoa: Make window resizable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-cocoa-v9-4-d5a5e1bf0490@daynix.com>
References: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
In-Reply-To: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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
index 5d21ce143671..754539937ffe 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1379,8 +1379,10 @@ - (void)zoomToFit:(id) sender
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
@@ -2033,6 +2035,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 
     create_initial_menus();

-- 
2.43.0


