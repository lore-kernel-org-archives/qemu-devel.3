Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72173C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6ws-0002PG-TD; Tue, 13 Feb 2024 23:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wr-0002Go-A0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:41 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wp-0006CJ-Kh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:40 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso310846b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707885158; x=1708489958;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uDq193jDC/SXS//7zZzp4BuB0pNmGpuo5+lyA6P0aSE=;
 b=jQxyTAuGfc+qgjJsWC6Z1Dcw9s3tAYEGpERzPs2Kg3a2ZM8GetwVTl+BiFN7DZ+3vu
 q19I1HLL0fF3G31LDo2vXfzNC2K2uSNoAX61ZGtu53uN0ZW5BeVzi/Ia0haPKN3JDn77
 ru+cITh/QiloUtN7x0XDX12QuWVPYbNfabuQEIp0t0eIiuhuRY+kz1ms0jXPVtEjwjC2
 jEUHo7bSzqG0IJy/xqRZaJ2vnWuMmg1RLiiAs8JampJCYx9pNZGBGXW8/7zD4uVurRWf
 rFz0cev+2MUyd0H3JhDlAMqMmHpH+h63ybzRgfOrfZguzZrghVlfHi28AQ14uBMr4scd
 Pcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707885158; x=1708489958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDq193jDC/SXS//7zZzp4BuB0pNmGpuo5+lyA6P0aSE=;
 b=QckzYVn9lCgDiEcg3LpyRr3232r6zbFMVMpd35e47lC2f/iusAbP1kb+KYm4XXFpqZ
 89gHarWjofLSzMENlwgBBNRtST3AzlWzArnT+PaNvG6+jKYyENGcnf9FJfKfoshpfNvg
 dOGacgkKexu34MaHvaPl9pkZlQtDdCM7AW9yJi5Z0xFiCDnZ1GBTRKMFaN9Xd1G+ZY98
 qSmCW9Rx0Hgkfxh87sfn00qiqG9fLKujxEGBlIOjqzbSPoUnfPZxYi9muaTECajO8Mij
 zTCS7m9lAPQIWSL8r2di4M+0o2F+5+5MWbTN/wfOvUyW2eZlu+dJ/RMhnId5Pl3aOuiQ
 SiMw==
X-Gm-Message-State: AOJu0YwyvDlbZrNXV6QEhQySlLAH+VcCoEnc7b0xlLHf1g2xuhDRi+W8
 /wdzj7tAKWGcMDWl7RnQ7hb/8XiHkReddHgyu3Ew4Kz0tk/ai4b4tYfuiyazsCQ=
X-Google-Smtp-Source: AGHT+IHtmUAPvX+r9pmCfqDX+kZ+KZNATU96SZbneux4+9NdiNaGO0bs9Mm8D7JfsLJA+9AJR83iNQ==
X-Received: by 2002:a05:6a00:189e:b0:6dd:c23c:ea4f with SMTP id
 x30-20020a056a00189e00b006ddc23cea4fmr1409264pfh.5.1707885158199; 
 Tue, 13 Feb 2024 20:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2qRDY2a9pATcQK54jRkuEKZuBXkVYK0F0Xo9AkE3JsN/b9Dk77ADZPQaK1VVTGOj0Xi3Km+uBEktiWb/tdTOypKbgPo6U8g4oEyt9drwCE/wyPEnuISswCHZq77DYOO9yvxGtadG795QdUQNE6MGgJJJpvo/JA7TFd+BHsAOwLJO8H4IEXRW7gh5b6GOMX4IcsHcVzdWqskJcS9mCGL7TSiwf72lLc9N/M2Hp7ENunvKJU/PHd95C5awtzRRSgWX1aFZ9HDrG/A1D
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 r15-20020a638f4f000000b005dc389409c1sm3165487pgn.93.2024.02.13.20.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 20:32:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 13:32:05 +0900
Subject: [PATCH v10 5/6] ui/cocoa: Call console_select() with the BQL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-cocoa-v10-5-c7ffe5d9f08a@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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
index a1f54b3ebb9a..aeec3c48859c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1390,7 +1390,9 @@ - (void)zoomToFit:(id) sender
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
2.43.0


