Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D2AC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ4T-0008T0-5G; Fri, 09 Feb 2024 07:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ49-00087O-OP
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ47-0001xg-DJ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:33:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4107d76dfa8so1174745e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481990; x=1708086790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcayKF0S5fuq4dnazv16i3De/3X7znpGdXMiaRyrsN4=;
 b=XCRm0powtD18ImmQOnuaDlzHAu+kJi3KZG8PWL/Qsk528rduJwThTRRXKaJT9sTYrc
 Tqrl4w7LGWypUE4C9UiH7x6TFfTOqyCYwwgXuSZzZhes50mF3heweyWE1jxOXUn15aYa
 iRclmcF3hb7vFlVe4lFirDQrL6p1B6qlQBrcQd3EZbhqabzbMeH0YD8BVuXZnx/an8Z2
 oIzdMdUMFN6FHTjOsblg2HZ6wLw0YraEefbFLuN+InA49Jx6+2gRw6vJYKVTHO9dlQBQ
 +d8QBSISALzvLKaKNJWUH3/YICE//sjsva+ZML1fIIxYMyfF3T1IfpLtDYQubQih6c8I
 e9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481990; x=1708086790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcayKF0S5fuq4dnazv16i3De/3X7znpGdXMiaRyrsN4=;
 b=Al2v4tp5wgv5xFfmLkJ+R973D3Xfrg/zomZQ6a9K8WpoaFUgnwxFCgaSp+lJe0Phhi
 6F3Z4ny9OdZY3Amzj+yyjVYrLWhLUZhm5S48dxBr5JFOz6ugaYVw3MXHiIy+YuY2fRxQ
 WBth+qB217G4Om3IFjurHNVRvqH+TCDWelbIB5y9rHf4BMkdk3tZIjBURjsTPu0zP39d
 8Uq/E81o/9WRxKycJz6KsHgEcLX/KfrqQPxuPeRxEUG5kEVq4KSyIqm8Fgm5fV5IxIJ1
 H7hA/rDJUeJlx3SU7gHe7zxdAm8RaUGsmqkZi3iyY12GtyTMGYBwSaSGUwCtpXvl5jiX
 V29Q==
X-Gm-Message-State: AOJu0YzvjD4iIgsiKPmnQmeBwRv0XFKh1rmoshfdmHgZrpdNbxg6jiF2
 AU5AFi80bWJOeR7KRLEAycA/AhnlTekiAiVo8Q7QIOwsF6Zh1kbWyAOnnuX95aqlrIVnFAu7YhG
 y
X-Google-Smtp-Source: AGHT+IHymHyBHrI56TJOBErn7HMGdIbLtD9MmfpU76aiMBRb6xVnr1Dh9YBJV+bjjR2Z+7Xj6ET4WQ==
X-Received: by 2002:a05:600c:474a:b0:40e:f632:494c with SMTP id
 w10-20020a05600c474a00b0040ef632494cmr1082594wmo.30.1707481989975; 
 Fri, 09 Feb 2024 04:33:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWm7AlHq26PilrZzGO+lwC+lnCRy4B0mshbZq/Z/Vz/tNNgW7nFvgHSEn3NR4kNBb1QD1bYsB9sbTCQkuIplJZ2vp9wxhLxJ2K3GM700Ez9NaVI54aJS8pvb27MxRewqDqmPyV6XX8JX6NJR4CFxRuIk0nKUBCz9Tu73w0MVJP/g/uTEy2H8/Q29lGIP3sPfaP5lHgQAq28YDAttTHR8JOJsF9QPi8M916fOKpYfk+PGy7LswYbdFiAG4IFdlY/lQ+jYeehao+iI7x1u/l3AZxsOrPT38dPcNvKFKcyYfMGHcHS51TINF0/9eO8AGsu08buzgh7OtDd/xs=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c4f0400b0040ecdd672fasm540810wmq.13.2024.02.09.04.33.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:33:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 7/7] hw/misc/mac_via: Have VIA1 child access parent IRQ
 once realized
Date: Fri,  9 Feb 2024 13:32:25 +0100
Message-ID: <20240209123226.32576-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We shouldn't call qdev_get_gpio_in() on unrealized devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mac_via.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index db6142b5f4..67e51430bf 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1246,7 +1246,6 @@ static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
     v1s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
     adb_register_autopoll_callback(adb_bus, adb_via_poll, v1s);
-    v1s->adb_data_ready = qdev_get_gpio_in(dev, VIA1_IRQ_ADB_READY_BIT);
 
     if (v1s->blk) {
         int64_t len = blk_getlength(v1s->blk);
@@ -1270,6 +1269,13 @@ static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void mos6522_q800_via1_wire(DeviceState *dev)
+{
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(dev);
+
+    v1s->adb_data_ready = qdev_get_gpio_in(dev, VIA1_IRQ_ADB_READY_BIT);
+}
+
 static void mos6522_q800_via1_init(Object *obj)
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(obj);
@@ -1336,6 +1342,7 @@ static void mos6522_q800_via1_class_init(ObjectClass *oc, void *data)
     MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
 
     dc->realize = mos6522_q800_via1_realize;
+    dc->wire = mos6522_q800_via1_wire;
     resettable_class_set_parent_phases(rc, NULL, mos6522_q800_via1_reset_hold,
                                        NULL, &mdc->parent_phases);
     dc->vmsd = &vmstate_q800_via1;
-- 
2.41.0


