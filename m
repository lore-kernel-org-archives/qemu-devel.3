Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7C8C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQUK-0005Kr-2A; Wed, 26 Jun 2024 07:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUI-0005Jy-HM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUG-0004fX-NG
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70683d96d0eso2313305b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400011; x=1720004811;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iRIsabjOCp7YSjFwcV1tRdeNsvY9o6uLKWp2oClGRk0=;
 b=nquZsbtDjKaqBReVXGUBgvoJcu7jMPDMavaSDJKxdOyHK79I8gDeSfpUthJAlCMwNr
 a3eBmMMiDrNqKZn0UPF2d0ZV3lKBlIjJtPBe8/mcR8MDEm5piiyoIRx98FaK0l77tGtc
 moxNYjF9Eko3w3oX0Qm97VpXUwJ8cbMpgasTTyHh5Dy8CdjgdSZHkzT7bVKUXLkT0a/N
 GFPOIJOvwXRlHU+AYyzhZ9IgNDEcItmSI5Kz4kp/D/6B7hG+Rx8eRqTtO9ooy2u6Pdv2
 mot+HTd8dRrVyEYGAMD5HaW4v9ygPsyfAzmgiGTZx74Uk6pBGk8PzOkqiJGqqvkCWTZR
 f1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400011; x=1720004811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRIsabjOCp7YSjFwcV1tRdeNsvY9o6uLKWp2oClGRk0=;
 b=IMxHje8yZPjdRg6FD6KOVYZzFgwQUDQHSZI3FJ/rtWrDiUJDHuR4CaXQJpK86dOoj/
 9I7EM1L2Ij8o9pyJWjDMXqq57dwKlhh6HMhfrboQS9MtcYfyW0LNMNMs+GUz60YA/aaH
 YyI5D2XEkTTTpTvLBHGFL3ZIHsGZ3evW7er4QXFQufCz6wBFDxlCo9zs6wv9m/4eWLh5
 4Qsk5VLbAOGzxuLoyHkbjaMKB8WVxKQ4pcFqgmkULnDhLQiCzg6mO3056hJj/cyE/Y7f
 LF6++jT+F3Uza1GdUO/9eK5ySWkhL50aeB0gEmDKWTOS8fdthHJt19w7JqwvvjOmoBON
 IUzg==
X-Gm-Message-State: AOJu0Yx7Fo3w0wqINZusqEs4EEjkLQAw5CcNNG7x5yuiRVd68DobMob0
 uJw/onosIPt55gugmtpNGrrnoY/VTTcPAFvcFDfJx/dWs8Ig2Ckf6oK75GdmrqQ=
X-Google-Smtp-Source: AGHT+IH4urPQ6j+xa/HuI9tGhGaIO4IdTUEaZsjK099SMnteGDVmWKgkI9WZGwDiutNH4K+I8urtaA==
X-Received: by 2002:a05:6a00:4ba6:b0:706:61d5:2792 with SMTP id
 d2e1a72fcca58-7066e52a5bfmr8524764b3a.8.1719400011404; 
 Wed, 26 Jun 2024 04:06:51 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7067d11a437sm6020153b3a.118.2024.06.26.04.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:06:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:25 +0900
Subject: [PATCH 02/14] hw/ide: Free macio-ide IRQs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-2-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ide/macio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index aca90d04f0e8..d8fbc1a17ba6 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -464,6 +464,14 @@ static void macio_ide_initfn(Object *obj)
                              qdev_prop_allow_set_link_before_realize, 0);
 }
 
+static void macio_ide_finalize(Object *obj)
+{
+    MACIOIDEState *s = MACIO_IDE(obj);
+
+    qemu_free_irq(s->dma_irq);
+    qemu_free_irq(s->ide_irq);
+}
+
 static Property macio_ide_properties[] = {
     DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
     DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
@@ -486,6 +494,7 @@ static const TypeInfo macio_ide_type_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MACIOIDEState),
     .instance_init = macio_ide_initfn,
+    .instance_finalize = macio_ide_finalize,
     .class_init = macio_ide_class_init,
 };
 

-- 
2.45.2


