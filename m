Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4DBD74962
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 07:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWUXm-0003wv-2e; Fri, 19 Dec 2025 02:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DvlEaQYKCmUbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com>)
 id 1vWUXj-0003tC-4l
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:51 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DvlEaQYKCmUbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com>)
 id 1vWUXh-0001hz-1E
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:50 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2a0b7eb0a56so40130675ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 23:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766127886; x=1766732686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=2NWSfFYiw1gSHJQD7OZI5VOqX9+Kqwl02R0YqxtWv0M=;
 b=gkFJOIBcH+zonk1F77CPfSZGNdJW67XvjQAqi0Vt1g5NndgJxcluyJQOl28RUfUPuY
 N7VOjW+CuVrea02bilRQko4bv2xByUcW7EYt2elRrgOn3NBTkg/8nqonBmL7lzaKS1Ll
 Lu9YEW8v+0hUssFt6XdioHcHW0fhJBq6VtBRyjXaz27pBksyr2yUhTI3VZ57YwEA/7mi
 w3OgrP97n+B+4egeW+6MrKqb1iMq7dfxhdgppXbReHaFsFuEoE503J8otZL5Zj6IL1lf
 endjgh5Ou0u1uFs+XJ5OHCbw6NDFfpseYinBq5JbCWJhohMxtk2GCDA0phaTLXr/GGne
 nHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766127886; x=1766732686;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2NWSfFYiw1gSHJQD7OZI5VOqX9+Kqwl02R0YqxtWv0M=;
 b=FwxNi5AvPv/PyI5wFzuNaMxmjvZmLrWqhlC4VbjmtoXj0iwQmqJWmDOt2pwQzOvR0+
 uO45eeHjmeqdRkAfudUR/LxmU0BkjUpj0mPoXDRt99wL5Oz71i8oi15t3ig8qvsAAm4s
 Eznt8AImyonCANS7z1HiZ6Cr9G4fPbjJwS1WYSi4qV30+5ntFIBcRvmDTvJToiiMrNnz
 MpWOXUHVRUKJEAYwKSh0GuOTl5m5aCz9uHr0OBlHN7t9QduYF1s4Fki1hmdhJL6w4Vgp
 mSd7wuIkVWTlX+si4SeOoYnYLa3z2BcdBNkIIdI8HSk8f0KUcKTT9UhDPlzcqZi8ai19
 VM7g==
X-Gm-Message-State: AOJu0Yxlp+5HxPwVacbksBFl2w/Hv+WxKnB+Q5B2KR9JqgyjX7s71H03
 shoCg84A8dvSgp1q0325DK7eX7Ywz0ujeiYWxaL33xQyWlALyXlOONJQO3ClMORd9QTdrGDGB0+
 WBCieNzfm4B97rRPMJWnLaZ8b+W3kc89sgVabiNE+fax9darips9ypK5PSZvYSosQJ9XyDacSrI
 /9e9qRUVfrnQ15VjRrH4/im7EEoK2ryNViRMg=
X-Google-Smtp-Source: AGHT+IGr1xBheiXGThlyK0XRG2xqtvWQn1VgI91qllTA2WJ6aTpjze+dAzQiXpo/REhL7y3oI399nGUcIGQ=
X-Received: from dlbsw5.prod.google.com ([2002:a05:7022:3a85:b0:11b:b064:f5dc])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:910:b0:119:e569:f26c
 with SMTP id a92af1059eb24-121722b56d1mr2836989c88.21.1766127886348; Thu, 18
 Dec 2025 23:04:46 -0800 (PST)
Date: Fri, 19 Dec 2025 07:04:18 +0000
In-Reply-To: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Mime-Version: 1.0
References: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251219-aspeed-sgpio-v5-5-fd5593178144@google.com>
Subject: [PATCH v5 5/6] hw/arm/aspeed_ast27x0: Wire SGPIO controller to
 AST2700 SoC
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>,
 "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3DvlEaQYKCmUbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

This commit integrates the Aspeed SGPIO controller into the AST2700

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index e5f04bd16e80696e41005d9062a6df6d060b8088..787accadbecae376d0c747d054e=
c6372785375b1 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -519,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     object_initialize_child(obj, "gpio", &s->gpio, typename);
=20
+    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
+    for (i =3D 0; i < sc->sgpio_num; i++) {
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
+    }
+
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
=20
     snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
@@ -973,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *de=
v, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
=20
+    /* SGPIO */
+    for (i =3D 0; i < sc->sgpio_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 +=
 i));
+    }
+
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;

--=20
2.52.0.351.gbe84eed79e-goog


