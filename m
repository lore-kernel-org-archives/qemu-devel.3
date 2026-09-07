Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E07C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cQh-0007Ab-CG; Mon, 07 Sep 2026 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cQf-00079f-8w
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:42:45 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cQd-0002lU-NU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:42:45 -0400
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so12787545e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799362; x=1789404162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yXN++fw5zgOO6Nzdt5aDXW+w27r6GydROb+GJyYC31Y=;
 b=PNqVRwEo+6wZ9eTvX9PTQTmU98n0adb65RWyV5eNXR7VBdpmJcaA4pqQ9mrakIx+s3
 AnIXQ2rm+DXwKN3hxSAs5rVMYgG0uKOnpUQszi4rXxLDqVKssrvHcsBG3RuYAmh5AYgQ
 ZpGNQt5kCB3XqS9SGDvFKC/xpb7chvY2oHCAlAC5IUQHxOexW0cVE3+QPyZ7lL6VY5kN
 G5iUCd2TzU6MqQjEopWjAxwHZs6Fua+pbn7DODfBPbDWvNXs7ML6eLspNagSF2sDu9D0
 5Fjr1KE4Eq3Qx+caeBpm+PMF22tCIPdGzAeEMHEZTZ3bqOz/XVeRG4jrtMoUssnGAclc
 Au6g==
X-Gm-Message-State: AFuF++mvBZR0IBRO84NSXF8KD9a10t8hF8a+nO38QS/bs34fBmJIFxbz
 9HmxvUdf6J0F21RGEkv0SXmnQtHswbOYnjsZeaidZENHcbHyQ6xweJBbECJRnTt5
X-Gm-Gg: AYBFou37AQD+qiwI2IADYPDkJKFlsobcfWvpqFFphUfWBDTNAs6/jC4nJEJVW2hfE2g
 L5Gle5+5+MdvyC1XIZdcXFLxQJ7cjBHdf6NhB1t0DhneL6zV9Qbb+0Bcff+lZOZ3nKWn/pxK4Y4
 9Fn2GNzFy4axtYhdhiTZZh5SqWtpMD/m6oN3zZ1xkH9fwrkZY6hk2ZG5stQJcrII6y9OCRzYcYx
 9U2LbOSUrYsvGbY/UgzUNygT+7wzTvsPL4GRVV80epdHObF2M1kxoWvzPWWvsJ3f2lNZ5rR25GA
 lAQCpnNGCm50dhSIKNlIOEqY/s1JY0yCz+VQctppof5KhSyG5+bEdNG9i+86Uwk/biv1vzLOw+A
 +do5BHx+y4YD8NmeS1fexJhIibsmXe1XKuc7IMBzm3wPuFYUfVg8iR6uuAi68YhKWZsDk9L/DnK
 cxGDenzeStDBCwMmnpF15Cf5MJtVZX+gSCoiazgILAvdUNDxpYDuNa39xoynAxXSCl+AS07QVLT
 94IAofn1vjGTIulRDN3PbKZsyN4ir/OGt1c84ZT1JLrFw==
X-Received: by 2002:a05:600c:4505:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49cf7fe607cmr220873985e9.2.1788799362092; 
 Mon, 07 Sep 2026 09:42:42 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm859019835e9.0.2026.09.07.09.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:42:41 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:51 +0200
Subject: [PATCH 01/50] docs/system/arm/aspeed: add the catalina-bmc machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-1-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=1992;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=jOGxphM6i2yuU0VVdWKJiaxsh0O18wnvUcN3/3+xhQk=;
 b=Cto8ykDil9oYTgsGQA7AV/sd/46SI4OKM5pjwd/qHnmnAUrZ5/O41M3k3fD3BoRESR9x0Yiqr
 RO2VXaUU39KA/25jod8P9EPZ8LSlJktDSIebEUsVeyBbuLcZQfdWPhz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f44.google.com
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


