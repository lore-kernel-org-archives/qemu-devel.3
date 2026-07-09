Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqdY-0001hH-AP; Thu, 09 Jul 2026 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdR-0001fL-Nr; Thu, 09 Jul 2026 11:25:57 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdO-0000Gu-6T; Thu, 09 Jul 2026 11:25:57 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id B65542003CC;
 Thu,  9 Jul 2026 17:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610742;
 bh=kt0kAG9do4HQJ9IshjozRg4XTHX7KV510mGPiRz2MXs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tARy8xK5MUnr+Y1MoPYPJ2oO6SKu7N2C230mog/hyoq4xAzW9KAuk+6vcgiBu7V4/
 fHymfvl7yLDZZclRKgr2BVVlBpNye8MZAgf/bY0EvaMVxLKkBoPNV0JtFkTuxa7Wga
 SmXoTR8mG0Xiu+5v65jLASmQGbZSbGoSVosAxX3cpn+zQxS8r7fkYm5r/4Hq5Ys9N7
 Ue/Go+0PJltegebqhUVC00EhH+KYRkvtBPJOQgeQ/fBsB5H+ocMZqsKWIn91sepAYk
 lIJnRKdIw5ByIp3OQAMCb0ozExPgbndJSvPYwpzaKzME9LOmtD38rd2QYO2/UIgo4g
 KMyI/gKhI6N4g==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:42 +0200
Subject: [PATCH 04/29] hw/gpio: pca9552: default description to the
 instantiated type name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-4-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=897;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=kt0kAG9do4HQJ9IshjozRg4XTHX7KV510mGPiRz2MXs=;
 b=toDy3ump7aV+xpo5dspuPifAxeEJZHIZmRU3Zkq50bD8p1t8ZPtUd4+v1u5ZB5QNgl5L7bcwE
 WdWRe4vkEaCB8abShrGqefqL1ja8bw6JlRKyKkB/EzFT7zyoipLto9P
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When no description is supplied, fall back to the actual QOM type name
(pca9552 / pca9535 / pca9555) via object_get_typename() instead of the
opaque "pca-unspecified" placeholder, matching the PCA9554 model and
giving meaningful device labels in traces.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index da21e56aab..ffeb438d2a 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -488,7 +488,7 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
     PCA955xState *s = PCA955X(dev);
 
     if (!s->description) {
-        s->description = g_strdup("pca-unspecified");
+        s->description = g_strdup(object_get_typename(OBJECT(dev)));
     }
 
     qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);

-- 
2.50.1


