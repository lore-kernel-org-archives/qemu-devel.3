Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE93EC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmfK-0006Mr-MN; Fri, 31 Jul 2026 08:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmf9-0006Ll-US
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:48:31 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmf8-0002cu-Ig
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:48:31 -0400
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so682047f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502109; x=1786106909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S23pR2ZvsSLYFR0+0DeQ83TbuXFd8+C0obNCg2DOLig=;
 b=gM+3qe6Ms14RdpOhBdknHj3ynlSqMCwKZ1FDjm38yyqhA7uQMRt8D8/7KL4ETZ6UTU
 0YUZrc9hpZ+hU9rO2ACu3BF2KO2SUgIKPRr/lKzR3gyxXqKIoRq72bu2z0DVhJXq2aFo
 0PEao/smqJoKxU1Ub5Kruur9+PyxhLUuPUglIBWtuAxftUSFuK08fqbbYjbCb5mqM7yY
 6zCAh6W++VpwDFl1sN0r3O83wu6xcP98vJ103GLDikctXfNj64qfWoI3iovlATxcieJj
 aM0MsAen1hDyDJANAm16mkbWeK5mpliL07pZIoS94gKrzC6J6oaYCnfN12i9Sgagwf0y
 zU0A==
X-Gm-Message-State: AOJu0Yy3VELOAIiJhPK8z1tEFzrS1NaBPIVPFkFHKRmfGUC+O/MmRbrN
 awbURQUb1lwiBMFHLPFAIEtJKkvhpIxOO2NlCqjTvCbkZ0Nw6JO6xquCwJNEXVqb
X-Gm-Gg: AR+sD10q2rqNYl006ToT1IdR5R0L6nhtITjkvZ1EFWfUoea+3qAlTFTakHHWFXg5tEV
 wVgbEsYql9CCqyBdbO+K8lI78i60zhi66AgnmwD3cgvRTNYgYCZyfdii3sWoo2PI3tnX6akhlHF
 r5jbcHlWPDFeFeM9mBe22q04Wx9KxHF4eqrOTC9ihE4Y+BWUMVbqTzRXFHEGsufI2I3bfxCxsqy
 u3wLygVFMkUDqD09ekfbm4dG/nKr4SHhcEbNRUQlMaPgze3zbVcDroYfqWfEVC3aSCYsm5Kv3pY
 XhNJFTvQbjJ1YO9L1sdIreIpzhUp6zehUKum2AFxU6gDAGhMU0P8J//iEaY8HTGuY3Gim44j4mY
 toQPbkI95ooyPkElKrTGbvwpIVV5lza1FawvPF92BEsm1/t0zOZ2glFIFps0pZidjz6Cnw4iZoR
 Tcyhr8Px1G9AP9kEELQiyASuAhiN7PczXp2m3ohLHTLswmrnjXiMBlQ/Bm4Mr0Bqk2DFQJUHtkH
 WdxIQiYb1Fw/TnMIaBembAK3s4ciSuIZQj5
X-Received: by 2002:a05:6000:2504:b0:47f:7c50:2222 with SMTP id
 ffacd0b85a97d-47fd2adcf89mr4133005f8f.24.1785502109144; 
 Fri, 31 Jul 2026 05:48:29 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm3927899f8f.29.2026.07.31.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:48:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:23 +0200
Subject: [PATCH v2 24/25] hw/arm: catalina: drive pca9554 io expander input
 pins externally
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-24-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494709; l=1675;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=EtxfxNQ4ajDXh5xrjgZPSfhgjy+Z8hKW5J2/81txDi0=;
 b=3uhiNc8DNYIaTMNhkdWS2vMAaIVje9oq6moOgrhv1yblmCtAGe9N9xL9Z4PgdQ255jEsxXcKF
 eLi8DJ4nLEpD7CbTyJtxBjK9pB7v92+6DhmmDiGR1LhER6IJDIk5N9A
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f47.google.com
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

Create io_expander5 (pca9554@27) with hw-dir=true so its pin%d QOM
properties drive the external input level of each pin, matching the
pca9555 expanders, instead of the legacy behaviour that forces the pin
to an output. This lets external agents, including tests, stimulate the
input pins and have the guest read them back.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 928e140b21..69e072c932 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -545,9 +545,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
 
     /* i2c1mux0ch6 */
-    /* io_expander5 - pca9554@27 */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
-                            TYPE_PCA9554, 0x27);
+    /* io_expander5 - pca9554@27 (external agents drive its input pins) */
+    {
+        I2CBus *bus = pca954x_i2c_get_bus(i2c_mux, 6);
+        I2CSlave *ioexp = i2c_slave_new(TYPE_PCA9554, 0x27);
+
+        object_property_add_child(OBJECT(bus), "0x27", OBJECT(ioexp));
+        object_property_set_bool(OBJECT(ioexp), "hw-dir", true,
+                                 &error_abort);
+        i2c_slave_realize_and_unref(ioexp, bus, &error_abort);
+    }
     /* io_expander6 - pca9555@25 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9555, 0x25);

-- 
2.50.1


