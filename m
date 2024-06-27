Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3EBC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrvX-0007xj-F1; Thu, 27 Jun 2024 12:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvO-0007cn-MD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvL-00019R-WE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424ad289949so19389065e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505478; x=1720110278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFkcsEXV8tTNgx1V48/Rdkr/iwnE0vz/gcdrAU/mSc4=;
 b=OhwhO4zlpzZZp/ZCBaTx288a81ZKtKh4ZP1voyhAPw1+8amQ/bvNh0bp7LbqvHYeQv
 nqwJL1BoSaY32BbIV9yh7DBxSDY9uqBrnCSgRfCF+BtjJnO7pOmujPHIKjCvWyTGzSI4
 dn4txEMXhHvcWTmhP0y/zRf0/xkJhAeYLJe39C09pNHkG7eSIjePDcZdyn+qWt+LofDs
 1jk/Mfpfmpe5pb7Z+qmZUAIRv1mzCh1wMYf7wJAlcQ+cRJDCXjRBUFOwFOE4sQBKCf5g
 2ZxPDlcHhV7CPwnSV6Ofn4P1/Y+og2V0PC+AWEhPtwUD0veYUiOfJdhNDILXfpt0lSZc
 eugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505478; x=1720110278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFkcsEXV8tTNgx1V48/Rdkr/iwnE0vz/gcdrAU/mSc4=;
 b=pq031KnevTkAXBJVppGvaZC9gKaQ0sAtJMzezUo2LJdzc1vMNXgr/Tnas3kYoFdwa0
 Zu8evb+vC4CE5PTRXa7OoQ60MnroILDszv3TrucPfORilYv9gb80goR1gDsMm5LFBvf4
 0emwvIPgS2sUGuVzkr3L6py1icsdbUZFygPqwjkvIuOtouiVv/wBkspSLILZjIJB+XFW
 hYK5NLybipSTnErEv8Dwe40rThzLa4nsyFsudj2eiWklDCrWZVGTar58JuHTPXEpmbHp
 JpUkdHzYDtSKN7dkQ0pMgZYiYIVJoL9uIPAsfWhCixf+d/jqhtxFJhgLt4HJxyhRB411
 /3PA==
X-Gm-Message-State: AOJu0Yy+OaSNT5I+CJEEmrqoNiK9u4ECtLGBvCjnsApj6/k0/jWf1wwb
 pDjixwOnbwBZGKUHBMG1BNMJBIJCM+gpsaV/o8ofk3S9MTcD0r63vEOvxX1PXvYjYlo/hbv9Bbi
 Mj/E=
X-Google-Smtp-Source: AGHT+IFvEuM5Q0EUNhzdGvwQ8l5NxFSOUQP2UnFaIw1/wF4EPwoc8Yxtkpdlu/vy+xFin0hCK0jMTA==
X-Received: by 2002:a05:600c:55c6:b0:422:4fcd:d4b3 with SMTP id
 5b1f17b1804b1-4248b9ecfddmr94205215e9.37.1719505478323; 
 Thu, 27 Jun 2024 09:24:38 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249b133b44sm71480295e9.0.2024.06.27.09.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 09/17] hw/sd/sdcard: Use READY_FOR_DATA definition instead
 of magic value
Date: Thu, 27 Jun 2024 18:22:24 +0200
Message-ID: <20240627162232.80428-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f37d9c93a..135b7d2e23 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -561,7 +561,7 @@ FIELD(CSR, OUT_OF_RANGE,               31,  1)
 
 static void sd_set_cardstatus(SDState *sd)
 {
-    sd->card_status = 0x00000100;
+    sd->card_status = READY_FOR_DATA;
 }
 
 static void sd_set_sdstatus(SDState *sd)
-- 
2.41.0


