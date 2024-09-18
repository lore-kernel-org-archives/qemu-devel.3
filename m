Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE17CDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0H7-0006BS-RY; Wed, 18 Sep 2024 15:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tyjrZgUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com>)
 id 1sr0H5-00063I-Uy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:39 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tyjrZgUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com>)
 id 1sr0H4-0007QV-IV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:39 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2d8b7c662ccso266295a91.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687416; x=1727292216; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TBdugsch+GIptmS7cOiUEz9KzkCdjmId5XX/UAGHjcE=;
 b=FsLEMBnJvyFeAErvCkjt/FCXDR+SJbLVs2D2xMS9tv1MTE0vwKi42NCsLk2VBd5YKq
 tqLB0nC0K1Xtpw/EnEyonKibsuC6+VlvwiC9zUxITwvEIUlgohBrnrO6jWq01KKxXMlc
 +NYSIAlKAYtPLnPpwZ42YrwCIgKsT1mBmafUY1lSlVhmWZitEhAWjN5K7JvMc7Ai48ns
 kg2DYOltBTkxtXL0AezeeQK6qVEXgL/bO33QMnM25DhJUg/LvR1kBcU7ypS6kdUManV0
 VPOhPjPeDOr+t5ddr7B/77h8jYNifwBTLJJDw67H/W4tmJiSmS+NQxZzxz4NDHa7MWet
 zNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687416; x=1727292216;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBdugsch+GIptmS7cOiUEz9KzkCdjmId5XX/UAGHjcE=;
 b=wIIAkEgaGUDZYc+P2MvuoRPUw7yt8+M+3mSJ82GMVHcfRc/gA1LdQRHmwD0JRoZccv
 jadl0JNUtvYX2VsVxrYh1SaS6Rt8tmWMBlWT7G906r9CyTWmVi9e4E+Hh11IEYg+yB9i
 j9XirB8qVHdnbxxOummzPuB0rEpkSNtrFx7ARybNsOij/rp/2HiAYmJBYglCGmtUrXBt
 m0iAQFMe5J4gptro2EArqhOwmgkQrHC0q0WyWqHvpyREWovY2pOnFasRvdnJgRScGjEC
 B19oArOwArsdoIr2f4fgxRy6xnGx6oXUOOmD09vakBPoeU/grbemOukRZ8gN3j7MjpCv
 ItPg==
X-Gm-Message-State: AOJu0Yz652fvgGiK+0VeVHFQqDCOyyQJYkRmHaZ1tl0JcIPsAsAHALlL
 UE38tZLk7uaVezcKYm4DGrp9jxfIlV99hJIDfR37cbcVVw+Q/HR82rST/wDyBrEqQbioQKXV3qj
 imWhiPmihb5qjhcxuojgqnQk/sc2aFHo+zwpUDVy4ydmZELSRqiZWGEsJTc5vxFiyBVKWEpf7JH
 RUsZ9UUJimaJPF7iGi9t3cmwGvYw==
X-Google-Smtp-Source: AGHT+IE9RANLv8donXWCo7OHxNyPfn0FnPh3Mr+E0BZj9ZDA+HoHcDMPTrUv39jv2ewnlDPc6SOsCksUUQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:3a84:b0:2d8:82ab:1999
 with SMTP id
 98e67ed59e1d1-2db9ff6cda4mr43406a91.1.1726687415723; Wed, 18 Sep 2024
 12:23:35 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:49 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-22-tavip@google.com>
Subject: [PATCH 21/25] hw/ssi: allow NULL realize callbacks for peripherals
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3tyjrZgUKCvInUpcjaiiafY.WigkYgo-XYpYfhihaho.ila@flex--tavip.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
2.46.0.662.g92d0881bb0-goog


