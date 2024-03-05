Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2D6C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdT-0008H2-IS; Tue, 05 Mar 2024 06:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdP-00086E-UT
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:59 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdK-0002ok-Eo
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:59 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so8243564a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636812; x=1710241612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BD6Kyo1n9e4Vc/VDtm7XcC1eUkYKmt1UEkhUMSJXsxM=;
 b=xdrJFadh+qvjaykMr2xnsPhCk3/QcXp00uRnYuK9LdIKURzVK0wHGow1JHchVetn8x
 j3nypfBTEj8Gn3euQg1xgdVMHO3RZjLt2g+kjcJm+GGdDgeLti1HraSVg//2wJul/mAl
 ldRL4efx/BYKxJLCPylHBThLPfBQOdouNOH/RJp/2t4gaAWfYSmQJaE+dzcLru5E2cYz
 pXfvUy5XE+J8LbnERv9CNarRPvzQ26sgFX8k5R8lUS46eTEUw+3zHqGks+SjqWsGU7Re
 xV4bis4HZcFp65UVoXW1Q+tbTdL6sBQAJvyOuPteFBGD1ANrh0/cbbutIZyWh2wX5IjJ
 mNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636812; x=1710241612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BD6Kyo1n9e4Vc/VDtm7XcC1eUkYKmt1UEkhUMSJXsxM=;
 b=hs5swByPx2uJcC/s/eJUKS4mw9F1yI8saaI9uuIwy3pPTFwjlV/Mn3CfkqVWYUYsgc
 jqJroHuhsJh6UtfOSY7jJVypvKUdZ9LZonHdkNTIHMD+DmgoktPz7OILaNxpL8B8dH2l
 Nn1L4eG3ZAUSOMNTAw/KHi83aNcE77UoK4Q7leSvL41JBUnkQQkQRD4+V9tkHQ4TQPy0
 yxWzezowYB/Tr692+6935eHErghtsdJUGAlgorSs+DUXGqqAd88pRPC2BJqbiYA8pVig
 b6NKKAuBFPKm2/3v/g6VqKPX/Gm89KUapUW1kkdKHmLGaISzmynSaxbAHhkVSYZvTl3W
 8Gww==
X-Gm-Message-State: AOJu0YyLHtDrfcmRE23zeHVD5/y8wQsmW5iA2pO6/ygPXNDlHAH8Eg8q
 /A4GavL3Cr5sUiWNbpyZYdkC7muaFyVnVkF+13wFq1MfosIalARCPPI3hCRp/Ub7qeSbkwjMZgS
 h
X-Google-Smtp-Source: AGHT+IGosgmIyYyHEy+o53tt6a42tZe3NRYYT8n/KGJzioxo8nzAO8VdUzRfFX8ZLLqr8aJ8sudidg==
X-Received: by 2002:a17:906:408d:b0:a45:69f5:c3c9 with SMTP id
 u13-20020a170906408d00b00a4569f5c3c9mr3176440ejj.6.1709636812815; 
 Tue, 05 Mar 2024 03:06:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 oy29-20020a170907105d00b00a43fe57b2basm5900527ejb.61.2024.03.05.03.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/12] ui/cocoa: Fix pause label coordinates
Date: Tue,  5 Mar 2024 12:06:02 +0100
Message-ID: <20240305110608.21618-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A subview is positioned in the superview so the superview's frame
should be used instead of one of the window to determine the
coordinates.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-5-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 6e8cd24e88..a2e52ceabc 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1451,8 +1451,8 @@ - (void)displayPause
 {
     /* Coordinates have to be calculated each time because the window can change its size */
     int xCoord, yCoord, width, height;
-    xCoord = ([normalWindow frame].size.width - [pauseLabel frame].size.width)/2;
-    yCoord = [normalWindow frame].size.height - [pauseLabel frame].size.height - ([pauseLabel frame].size.height * .5);
+    xCoord = ([cocoaView frame].size.width - [pauseLabel frame].size.width)/2;
+    yCoord = [cocoaView frame].size.height - [pauseLabel frame].size.height - ([pauseLabel frame].size.height * .5);
     width = [pauseLabel frame].size.width;
     height = [pauseLabel frame].size.height;
     [pauseLabel setFrame: NSMakeRect(xCoord, yCoord, width, height)];
-- 
2.41.0


