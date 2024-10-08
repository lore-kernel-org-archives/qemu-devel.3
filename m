Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5433ECED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyug-00073b-1g; Mon, 07 Oct 2024 21:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pIgEZwUKCgc0h2pwnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--tavip.bounces.google.com>)
 id 1sxysy-0008JJ-Py
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pIgEZwUKCgc0h2pwnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--tavip.bounces.google.com>)
 id 1sxysx-0000EV-9b
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e0b8fa94718so7692684276.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350372; x=1728955172; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1mTGypMKoK88/Cq8OZic1Nsr2IiKXj3+YmHX8y0r+W0=;
 b=X0SQlrhAI/Nu+zoWl5WzXxCALs4PbN01LsaFsGHJIVaxsj8Ua/zm1l+t5bwOQgS7j1
 cRqjdBe/Y4RHO4Lg6/XKR+vzt6A4gNqUP+FqeEwUK//t8QCIQVvV1NcCWza6MmLZ+XJZ
 BpbIk6IzZkTjerZI7Km5A/A6rWf5YlOnmZ4DsrwptZGspIS2qU1FlwE/Mg++OTyQjfg5
 WuCaoyC8w7eC2sxG9A0H6w+ZAH5zYNlzghfXMBKeUZggDI1v0OGP7/Zuma60ORNyrBs1
 OS+kO18UhDO/u9orvlqm8LeY7NyRA9TGhNrD8NtaFcryB2vln6XwU2XPoNjLO85UrBVq
 nrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350372; x=1728955172;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mTGypMKoK88/Cq8OZic1Nsr2IiKXj3+YmHX8y0r+W0=;
 b=O2D2/Ajqlge1+Famdvn44oba72mHHuLHMMmXdNP6jNYZhc+wAU9cNF6TCbKlfN7kUW
 VlIhdVnGIjioJXzFq1HuE6TLOW+fhg1zU7uApTTX/JuX0reX75pcRmsti7m8SE+eamR5
 L+jxAOJubBNLfDgf9d3Cn/3xxM6VpVY8sYjsnGBYHFKbQhCJiJImW4LhzvcugPDHGsfM
 UI2qY/D5meLA9KlzVtYREIplPTVKIfRe8+7zpXJGZqbtk0OuYSVRwvin6z/glKED4fc9
 XVPH9wkfQh/PU+8g+QcP8QFSv+bYqhfnPEdRkFH6neTe7j3uJtfRyI3ViRERk4CGC7qT
 uo8A==
X-Gm-Message-State: AOJu0YzC8Q5MzVSVEOIF4zp9ryOUJ0gxhGuCB5te3MGWb4udg/XoFWHU
 j81/Q7TvK1ETdSqvakS5PtDRkD2v2Ltg0KjpGUYflNfYmea5WgeAjMWnxRHZSg5znIA/eND03tJ
 E7+YBmZMDkzb8HC8V8IXw1+x3P0W4MGO4/wFuDbhiZKF99PfmSqaEmMI44yiHGjLdu0/cRi1bEv
 iVsOpTujFs6fZidJ1zgSy6XTdC5Q==
X-Google-Smtp-Source: AGHT+IF/ARdhONsx0FgU3D7YbNyHJC6S0I67yHm7MDoA26Xb/wKvXX1888vusp101w+M9RfBvBAteQE5BQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:dc01:0:b0:e25:fcb:3205 with
 SMTP id
 3f1490d57ef6-e289394d93cmr58923276.8.1728350372143; Mon, 07 Oct 2024 18:19:32
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:47 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-22-tavip@google.com>
Subject: [PATCH v2 21/25] hw/ssi: allow NULL realize callbacks for peripherals
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3pIgEZwUKCgc0h2pwnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/ssi/ssi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3f357e8f16..d1f3ce7c22 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -105,7 +105,9 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
     }
     s->spc = ssc;
 
-    ssc->realize(s, errp);
+    if (ssc->realize) {
+        ssc->realize(s, errp);
+    }
 }
 
 static Property ssi_peripheral_properties[] = {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


