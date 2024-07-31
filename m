Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CCEC52D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBSS-0001vY-7X; Wed, 31 Jul 2024 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSR-0001qw-3A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSO-00057I-QT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so6801765e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722440499; x=1723045299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0Xf6TSWqP5X6W6Y62S5VXV1XsPi4SWZOscEiUZ5BTE=;
 b=rCsvKL8KITL34sGCMLLy9I7fgUr7XsiIbS8sdULFwQHylF9y4wjTWuRzgevMCOkH2j
 WnA+cGzQW99FD+10yiSjxK9qKamjGx/z+kv2tTltrpKfpQL7SkAgSwaViOfSWwCEXlkS
 rq1k/6dQwJIGta0IAjDezg4j+LDky14AXO0kUp0WK9e8dqDRhgYY4+fG/oo5eibMySAe
 XGt9tO+VMfnTW6kMc7UthGyqXrxZKhcmZuGvBUdICS/h5AEOs0y3q13Y13M9iRcMpl9p
 msx73MyPEktXbmProoGkv5E94uwbqTzM/u3BwLwvJPPhq4Vc1dy89PghZf9ooVYGMBan
 f8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722440499; x=1723045299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0Xf6TSWqP5X6W6Y62S5VXV1XsPi4SWZOscEiUZ5BTE=;
 b=NPOCKN866cZQsWgeI55cy25L2pfyM1C837c1URufAfbkKnwZTtv9DKcbl/s+lRJXUm
 FWsgzPVvEUkg9I2YR2OrwU2jp1lpVFIa0GKVM1fCG8jjpQrPbYr6tAvaQk+jw21hDnLF
 2oH7Lb4IzxUsQGWEs4o1HobUd/9ClezYrlVdYD4GDOttHsN2XDzhs8DggPZx8X3D64yZ
 gdOV3z+4PFSQ2LND/CmAMl83xIV0n1y7MtL2f0mVpQvlC7lcj+G7RO6NMO7+RlcZK4Kb
 aQfW0bilJia7ResEDZMeRzMpOmR3/eBX7oCIBFamq+aR/+jZZvq6f4mFM9VE8rCKPbuR
 Omnw==
X-Gm-Message-State: AOJu0Yyj5KNCSYV6Zu9XKsxvW5K0UJnOF0k8yXuaGpiMGaHRfRRZmFNw
 iVNASaQNaXKLkBWO5vXCws2X02Eg9BnBtnxaU2nofEH38w2S+ziDoMt4dwHbseJLwRM0F9ReJuZ
 Z
X-Google-Smtp-Source: AGHT+IHES1N0FwejfguzXRrIqpr3MkS/Vl0v03PYBY+/Hse5hj+NgShxkAfpJWuDDbLVhXkmvlY29w==
X-Received: by 2002:a05:600c:4707:b0:424:7871:2e9e with SMTP id
 5b1f17b1804b1-42824400d54mr44598045e9.6.1722440499231; 
 Wed, 31 Jul 2024 08:41:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm25201295e9.46.2024.07.31.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 08:41:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/3] ui/console: Note in '-display help' that some backends
 support suboptions
Date: Wed, 31 Jul 2024 16:41:36 +0100
Message-Id: <20240731154136.3494621-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731154136.3494621-1-peter.maydell@linaro.org>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Currently '-display help' only prints the available backends. Some
of those backends support suboptions (e.g. '-display gtk,gl=on').
Mention that in the help output, and point the user to where they
might be able to find more information about the suboptions.
The new output looks like this:

$ qemu-system-aarch64 -display help
Available display backend types:
none
gtk
sdl
egl-headless
curses
spice-app
dbus

Some display backends support suboptions, which can be set with
   -display backend,option=value,option=value...
For a short list of the suboptions for each display, see the top-level -help output; more detail is in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The ideal here would be to programmatically list all the
suboptions, so you could say '-display gtk,help', but that
seems like a lot of work and I'm not entirely sure how
to do it :-)
---
 ui/console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index e8f0083af71..105a0e2c708 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1632,4 +1632,9 @@ void qemu_display_help(void)
             printf("%s\n",  DisplayType_str(dpys[idx]->type));
         }
     }
+    printf("\n"
+           "Some display backends support suboptions, which can be set with\n"
+           "   -display backend,option=value,option=value...\n"
+           "For a short list of the suboptions for each display, see the "
+           "top-level -help output; more detail is in the documentation.\n");
 }
-- 
2.34.1


