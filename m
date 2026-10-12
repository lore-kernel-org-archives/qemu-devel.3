Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F1CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHPi-0005ma-En; Mon, 12 Oct 2026 10:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHP6-0005g2-H7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:53:32 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHP3-0004jk-N0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:53:28 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso26290405e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816804; x=1792421604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yXN++fw5zgOO6Nzdt5aDXW+w27r6GydROb+GJyYC31Y=;
 b=Cr84FKFqAWkP0OHD98LiJ42QuUqo/57LBs2RwNU6UwRHYLH6WeQnBNBs16wXHQ2gqu
 S0xr+dNbaV8OZ7SQr8l0ajgG8iqVXG1Qou1dfQ3T97mFREfke2tK7dakauWO/aMmEmvG
 CpxxvOYJzF6Ewj8HWKGfu0GDNZsp/XmHQhTYq+52dVYTBDAaVqrrhd/nPsb6aKq7lsDK
 iw85gX3I0WI0HbO9NXtDuZmGSXND7HUoDh0j9bdNs6WDOf3LXcpujieo47YXbiyXUjyR
 ATddV3x9+h+vd6X6kPG4r1Ye9Y1Cv4JJZnNVbvXK2hwDfVNl3YXgUkXQykqnPOQnXzM9
 GTeQ==
X-Gm-Message-State: AFq9FYIledLXf/2VOgJR8+e1tOn/yng7iSW5vyMgXYNO+y/Y8kP7kqcQ
 x+NDyrm0/O5UcMlUYNP8QG+pfj58KtVUU/rOBgdTp152lM8EPlQlfhgBmMUpeNTQ
X-Gm-Gg: AYBFou1YDBNfHCUDw+ROMtAX8xWHsPt24jIZNSbnIS6iIeC7u83Zr9ltl7O74nibbDT
 U4FvLwwQRr/w24Jmz3A9ba/GEmrl+1IToTQkSScW8wae478z5VrXM8Auvd1IIE/R6aA0PKgVYVc
 ZbtbeQ5Mr4u2vW11FZuCLZJmvNceAayKVJ2oBtmvUB2fmmf5fgls7ScNUQ9pjwa8kpbZ3UfLSbG
 FG3bhlPob5cmVejzM05gkdn8IBIfkz493bhZ4OkNQP1SHTIGQ+Aj8Nf5n+Lutsdj6sv2Tinl+C6
 CLRpEjHX/FEzBQdAb/kT1xIBMvRLDlt5uuvUzr91yawIdHGoy1vzaC1+8LzMGfWzVUbY0C0Bwwx
 J6KjPzgx0lDTwPPHpgJ4v0kyWSzgGH/Ogd4GY+dQlj6dtPlDWu2g3UoftT7ZppeTuWVGwg+Sloq
 UYsMUg0ZxTEDMIGFyv8DY3WoBLqAROyfLu7gPQah2lyNwWuc42XV87sizodz7c+CbK1Dr/7NQGU
 KNXSBNZ4dnvXUGdxRmSIrllyXVSRwrTEC2s6AQ5HYPxcGYMYMi3NFUB
X-Received: by 2002:a05:600c:c3db:10b0:49f:fe89:efca with SMTP id
 5b1f17b1804b1-4a18dcde66amr145444135e9.19.1791816803828; 
 Mon, 12 Oct 2026 07:53:23 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd3aasm19296117f8f.32.2026.10.12.07.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:53:23 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:31:54 +0200
Subject: [PATCH v2 01/50] docs/system/arm/aspeed: add the catalina-bmc machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-1-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=1992;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jOGxphM6i2yuU0VVdWKJiaxsh0O18wnvUcN3/3+xhQk=;
 b=BndPsP7EPmKREvNz3huXhMaogYdbZ2XWQyFcgAHmOv4OvtApr069o6KfEFX904R/m1h50qU0X
 sIuOVxop7ATBZznxmEHi1kwyMIHTNHjSxsT2wMUHJo2W82YNuTRofrS
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Facebook Catalina BMC machine is supported by hw/arm but has never
been listed in the Aspeed documentation. Add it to the AST2600 machine
table.

While at it, shorten the document title. Listing every machine name in
the title duplicates the tables right below it, and made the title (and
its underline) grow past 350 columns. The machine list stays available
where it is readable, in the per-SoC tables.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 docs/system/arm/aspeed.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2d51ceeb84..933df41f96 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``anacapa-bmc``, ``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-===============================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards
+====================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -33,6 +33,7 @@ AST2600 SoC based machines :
 - ``fuji-bmc``             Facebook Fuji BMC
 - ``bletchley-bmc``        Facebook Bletchley BMC
 - ``fby35-bmc``            Facebook fby35 BMC
+- ``catalina-bmc``         Facebook Catalina BMC
 - ``anacapa-bmc``          Facebook Anacapa BMC
 - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
 

-- 
2.50.1


