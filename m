Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03978E64AA3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4f-00081v-4Y; Tue, 03 Dec 2024 08:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4e-00081l-Al
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:20 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4c-0001Gg-S9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:20 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7251ace8bc0so4567471b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232977; x=1733837777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjcHxmTcRcs6gnPDz+2J4eyjqpNf01UJzBW549ZcPYA=;
 b=AqMeUzp5zEZLHNn7V9T9QjWq+lSCCzawjvgvRt4L7stq4J86onJPgM8sHS5jwdIqnp
 9pZZeBjEnAU+KZIm8Pi51/4motMlfGRJboTA9yyiHmtO7GfAv8IU5YfCPPKnkstIORrr
 WzIbqJAjMNu9ORyfCkccou7dd1lVL1uasXx83u5x0u0Q+mpd7/MY+LpvmJ5818qDVO/P
 8q3poSR4Qm8JZd3iZe8opSh9dFq911JMqZtoG8WULGnsx60eMKPfCispo9VTk771J8Bb
 kjr6j2v6c9KUqd8WSEvmJYpa3vMToSv/n4fe1yB4UsGyWCgpiQ7BP++RH7zGXUKz9JeJ
 1ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232977; x=1733837777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjcHxmTcRcs6gnPDz+2J4eyjqpNf01UJzBW549ZcPYA=;
 b=pTZXCjYlwsiajWn7QkKJtyyGSds4cbRV1NFeEH51BERPQ793ChF9qNXJgKgtfInSKA
 3+dWpcfwBZU8xNwrHhflhLZWcHnBpcxkxboBNe3OcGSMkbZXm57nWzeprLwxhmpNk69H
 XHZIdW2dH5toWdP52UerY7HmO0s7aOlayaQZyALKGlVLyCXJGQbBS+MGbKMzfMwN5Uw+
 3/2NfLuO7/Yo2RByTKg6BBYXt7SlPZXNs4c5aAIRlWxJLtM/5E0yp23WVlk5NVJUoyPa
 HCDeGbZ3BSFIZUvhUIK8vAq/HXKu15btBnwWO7jUwJpDuyoCKB7Bx1DHw0CLL7fbFXk+
 iMVw==
X-Gm-Message-State: AOJu0Yx4LRT8NugX27Ga41cgIC6QvDxWfeNdFIDKxr4GDOfGysptAvVN
 FpHyu4zY5g6Xn24qst/cm5nFcoSsEXmmjuLGQQWDSOqjmIEjrAqa+tlQtMvHiw==
X-Gm-Gg: ASbGncsoQzooYF+KvljnAOcjux9LztPV8qMZzDOUnzIrhzp3T4NTH4g10vyJ8zpQB5D
 e9RxTb4O7VUx/zqAsxvjXokBXdhUGIPNHEZhlbY51iO9o9I9PdorHla3siWixcdU/bCuqXTf8G3
 2W4RXYdW0qviFyYMhqGYWCPOcoBx+porxyMGSqaN0eaAZf3tpPqIvvpD1xVyDyMhBSBFo9tPJMP
 07vrpNwhR+VedA9YFx+eJdurcGOF0fGGSp9l583Ywl/XTB0bYqaKlV3JAg=
X-Google-Smtp-Source: AGHT+IHLU8Qbd8COS32ppcZTd9Xilkw/vVDaxNE5+Jl9ZL2XC+XKBqCf2F2X2DjpP5bJvCnMut7peQ==
X-Received: by 2002:a17:902:e746:b0:215:7136:f7e3 with SMTP id
 d9443c01a7336-2157136fb52mr209800245ad.19.1733232976853; 
 Tue, 03 Dec 2024 05:36:16 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:16 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 4/9] vfio/igd: add Gemini Lake and Comet Lake device ids
Date: Tue,  3 Dec 2024 21:35:43 +0800
Message-ID: <20241203133548.38252-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Both Gemini Lake and Comet Lake are gen 9 devices. Many user reports
on internet shows legacy mode of igd passthrough works as qemu treats
them as gen 8 devices by default before e433f208973f ("vfio/igd:
return an invalid generation for unknown devices").

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b5bfdc6580..7f389de7ac 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -80,8 +80,10 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:    /* Cherryview */
         return 8;
     case 0x1900:    /* Skylake */
+    case 0x3100:    /* Gemini Lake */
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
+    case 0x9B00:    /* Comet Lake */
         return 9;
     case 0x4500:    /* Elkhart Lake */
         return 11;
-- 
2.45.2


