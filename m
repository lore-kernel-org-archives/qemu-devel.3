Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F7CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN60-0005gG-K7; Thu, 15 Oct 2026 11:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5q-0005Wx-8d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:07 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5o-0001XO-7y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:05 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so3248700f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792077003; x=1792681803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICRLGSZ/DEoudJkKLVJVk8LBp8oLkoBLzgOCyFtFqxo=;
 b=e7ZtHTp2L24XIULu3Ri3Am/FiwXup8M11NPcT1a6be7XUTFjCJ4vw68Hlc5LPv18GC
 kE5WPtoMMmhlILafkl9X3BUUd9I1NhauzD7kpXzreBdBPW593JT/SPtJAVsD6asRcon5
 RlEnWkPGbHsD09R4UB0WFO+ZLDHnc6wqftJjRsKRibmEfRtLOm5IEyPg3atBM53lK0tB
 LSW/VvvTzAFgzZ0w7fOtiwEdrXMbFpJw81uwSfYDvARwyoMzguGlHWyJCUuFa3+E27uV
 7q8o2Sa/ExrB61nIdlK9/9viDx1jl1jslYi+3EyDyJ9HRb3TkvVGUmOBiBgl8NJcwjWl
 cWJw==
X-Gm-Message-State: AFq9FYKzd5RgIHvlosjgFyD1p+6yeZN5rmgGb9ApF9TwZKcuQqvWFPVC
 eY2SkVLKTQZY1FPA5AP1+QMNDYubyRN7LD3mOoDvwyEpLJZwI8LptL/1rgM9+g==
X-Gm-Gg: AYBFou3M3LOK0UNv9CJaRj3/edhG0tCSpBboEl+11Z1kTp/ejIx9NT9pGH53eV9soSH
 013TXedEq2gj+9L3w0ANj7mgqZOZzAewwcs3Ak7Z6+NV9SaPdn2O8/43gw5WN/HotUGEKfdVcZA
 7pChUtUn1CA5de46NeD3QW0+YPFqdbxg+rwFRCe2wchTHkbXtalIzaCVgulQG6f1cWB9GXJJ5fn
 AQ6cfA9BunyP+TYLk99jfP6cyLx1+UF7UbeekvaCDmfAvRAiwgHxR61PVZmnPmUT+ny5lqyrGbN
 AXY6MdEPMbXzFvGsWyTpnPNcwnvD0rgbUXOuTIyc2K2hIJG2cEfJHSuTf7R66Iy9dqhD7qbgjwc
 eSFzfT9sOHJlFhV6BUohaPUYSRl0eOVI6VVf0NO5SrCrcdUe3G8AGKCkokPCFvHizML4/Z1ldGD
 fFzaRbFvnUKU0mSC2AGlw62suZMRzox1SyBIGbSuFPx1gNicRWBZ1IVZlgS5MSALCFtANYrlyRS
 pRXyKoaIQ+AIlBj9zuQJSsjC02sI+Bb8DnFMw1QlQIEmA==
X-Received: by 2002:a5d:64cb:0:b0:48d:f34e:7561 with SMTP id
 ffacd0b85a97d-48df34e7658mr5958821f8f.14.1792077002424; 
 Thu, 15 Oct 2026 08:10:02 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de09693c7sm24117519f8f.4.2026.10.15.08.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:10:01 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:40 +0200
Subject: [PATCH 02/22] hw/sensor: tmp421: name the parent object field
 parent_obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-2-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065465; l=1266;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=X/kN3xjDzBiaRkUauZ8mdXFMaJnkPfrAonUxOqKT35c=;
 b=WjB09hui7HQXWFAbEC8wG6Br3jLUb4uI/kqiCrexynUPB01RTw+KxlLcc/cnDMJpAtlBfB1qa
 lLLAd96LyHRDF2VdMjjv0UuN12QZQ0G9jLnDyPXruz6egHsUT8/nipp
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Follow the QOM convention for the embedded I2CSlave, matching the other
hw/sensor I2C devices. No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index fde41b2323..e7927699ce 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -51,7 +51,7 @@ static const DeviceInfo devices[] = {
 
 struct TMP421State {
     /*< private >*/
-    I2CSlave i2c;
+    I2CSlave parent_obj;
     /*< public >*/
 
     int16_t temperature[4];
@@ -298,7 +298,7 @@ static const VMStateDescription vmstate_tmp421 = {
         VMSTATE_UINT8(status, TMP421State),
         VMSTATE_UINT8(rate, TMP421State),
         VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
-        VMSTATE_I2C_SLAVE(i2c, TMP421State),
+        VMSTATE_I2C_SLAVE(parent_obj, TMP421State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -334,7 +334,7 @@ static void tmp421_realize(DeviceState *dev, Error **errp)
 {
     TMP421State *s = TMP421(dev);
 
-    tmp421_reset(&s->i2c);
+    tmp421_reset(&s->parent_obj);
 }
 
 static void tmp421_class_init(ObjectClass *klass, const void *data)

-- 
2.53.0-Meta


