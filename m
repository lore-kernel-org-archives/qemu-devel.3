Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62943C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIj2-0007UT-Ua; Sat, 17 Feb 2024 06:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIiz-0007Tk-V8
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:17 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIix-0002gm-Gs
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:16 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29026523507so2205143a91.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168754; x=1708773554;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cQV0Uu2y+Oze5LMvp7CVg9JHrPQPcJX0lu2SgQQmfr0=;
 b=MQxVjXMYhNaSGsEhPPGc+VZMf1eF5rojo7CCFxFBH5dcqVQowCqFQ9yDDzB3xCldS6
 LVcyInc1u89M1Kvlmiku74Y0i6CVUOUem+la7RsrTTEeYdkP7w0+i2GpyekfqRt+Xis/
 5uS6vGpk2Mz+irOqv9+muryvNDnqi3la9iLp+jV03pRYPrUBbXDWWCqVvZ+jp5gLUwpk
 8sQp2EbmKP6NFHVEc4T4x/8ce90St1arbJuctR6X0BxvckA4lnWF4Thz8QvSoybKjBmP
 8aRDGRRbUadNmBqdBH1JxzH0vmBq9/6EmHJM30HCVMYB7CY14f6oHdwskScqzGJKRznt
 AWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168754; x=1708773554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQV0Uu2y+Oze5LMvp7CVg9JHrPQPcJX0lu2SgQQmfr0=;
 b=jOj9QOs+O5LSx3zqdj2sRxvBPtDlVDWngHzqOaoTotJlX+2arwGvObYB0ptSZJ4uLB
 NJIoJjdYf091pmdmqn3TD+SGISxBdETJcZbiztlnqxb4gNyWaYP9goK7azLoJmi+uDwa
 K8D2jM1M7mwO2T1xu06Ux6zcM2AK2eAXGjCyRO9Pm413Cfl5nT2Q5cmCln5LhxIHqH1R
 pX96tjkWiqc1fxtNpr5k/WG1I6N43gcVvexDs/rtGZ1BoCKVAc/I1STLZy5aVznoMv/h
 eTF+LlCMiBWuC+Lh48Ns1psxu5N10LEm71YNH/5a2+tNWl2bVNcs9BLNn6PWloLX/r1f
 5fVg==
X-Gm-Message-State: AOJu0YyqOCF1JoMfjvnvnzqsXVh9uURv62xR7bLHnqA6c1Y5mMJ11uCM
 T8jcmZxJMQk4qTkww5xKiTprRbdwtwTwjZVuzV3ceBnH8R+0pFODgn0FClkugu4=
X-Google-Smtp-Source: AGHT+IG9eTn8rFlHd9xyVziFMfKVuG60Ok6JELkQibygCWt+xFKiapf8lIj7HCx04NLczNRAauX2RA==
X-Received: by 2002:a17:90b:e8c:b0:299:3497:40d4 with SMTP id
 fv12-20020a17090b0e8c00b00299349740d4mr3617308pjb.35.1708168754176; 
 Sat, 17 Feb 2024 03:19:14 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 w6-20020a17090a1b8600b002966a13f2e9sm1505548pjc.37.2024.02.17.03.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:19:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:51 +0900
Subject: [PATCH v11 5/6] ui/cocoa: Call console_select() with the BQL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-5-0a17a7e534d4@daynix.com>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

console_select() can be called anytime so explicitly take the BQL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 17f290987563..81de8d92669b 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1391,7 +1391,9 @@ - (void)zoomToFit:(id) sender
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
-    console_select([sender tag]);
+    with_bql(^{
+        console_select([sender tag]);
+    });
 }
 
 /* Pause the guest */

-- 
2.43.1


