Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F12CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPyM-0001GM-8b; Wed, 24 Jun 2026 11:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcOsJ-0000Rs-Hr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:46:47 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ganeshredcobra@gmail.com>)
 id 1wcOsI-0006D4-4g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:46:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso150281366b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782312404; x=1782917204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d26vkdadn3vAzOoQFZxQmkUGh5WiA2B8Lzok9c8Anpk=;
 b=QKDjUtjLViAr+qEslojiWIC2VOtU6X60bP2ogkqxdHhkP22SXS7PhM+uBysTPxUt/a
 80p6v1rGetLgCsfTT22H/VlUixk+pq+/vwsorAuLQTSyHPKk8ANnuOOiHvaNSU3oFejw
 4yY/hZCKoSj4+EM3KL+P666YXgStKlwPsRsIb+Ptu8Vbjk6gTT5vHTjHUJcRb91oHXw2
 0yzPRYCjVykEkt682qpPHQ6YWbburoUfduPqxy+eRfuvSCY84aeQB4OR3r+t51riKTKt
 pAD+lqd4/sl21XmknlX+y64h5nRDH/l7zEumXm7s3YAD8j4Gw6fPrN7TMGNHO4J9dCfN
 Hq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782312404; x=1782917204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d26vkdadn3vAzOoQFZxQmkUGh5WiA2B8Lzok9c8Anpk=;
 b=rPeJl0Z/EW4E9HidNQpLZ8Xa25uS9+fpHoPvBssfP68CKN748oo9OB1KzrPz21DA8K
 8BALoG2Jw4BfbmzzeRyAwgYCLuEEnOJsjjJqNOeFsCky21BdftaubcsEx4HlT7GqNplP
 UtfK94OxNFWzNAAiukVDN8BTC1HC5qX8/Wq6yPX0A9TGwGb2Y7odm12BnzS15YvBLTIk
 Qljpiw7JE4I6q5RZ6HggI1FLcxPigkmadh3tM/SkpF4gVCxHcSnBy3BZlRlOtooj2RBy
 G+IxOtmtyjDJ0eqnZ2/fwF81v6/VdL2UbIlkQIbRi+WM1aQSqs9siO7VXItVwB3X6cRs
 ck0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gUD8WB7Pc9F1+NbR7DjsE2YJ78mkX5Qo2Rnvxi9cXZjFkus+3L7QdOCckAZAmzpqnSQf07Rn+K+mq@nongnu.org
X-Gm-Message-State: AOJu0YygBO/ROyA4vQSENFfV/rhdwTBJ6hd+5D36ej7DZxP6csyMqJ+F
 nbQGhzphuptVmgcNUiVkKNiupqyvZ8WL2uKyd524b5/HSQkDhBZ/Y1z8
X-Gm-Gg: AfdE7ckodg9y4tvs8GWbv0g0F5Jt3GXrq5CniAjZNlpFOYjboXbTLHfZVioOi24SqKR
 lNZyyNRZj6JsRA9T03Q783jpQscVYmcdKTs+KfyXmBQtK3RsshxjNesPkUy/8tbHEqqGoy6ZHCg
 aMrj7lWrOgDHmYeE5ttfNiNW3wPgO+oEhqrG9GplU7puWE98qQ+yNpT568yVZfyZOzN2tuW5mKu
 JpB5V+ko8ho47hC7htXrb0ybmtVCVem+Y8Z2mfZqPhYR0QThMGGbSxj2caOhO5m2H5pL274K/Q0
 0cvWEWj4QiePQdfJTK88w4XLlODrFSkjZvApxnliFNhMaBrFpnI0VvDBctWOh5vgHdUSH20YpcN
 +1e2wZNPLgMxZOo8T5ajYGaiiDpnhLqzDFnY9FzG30yMbi9WP3hfDPBkXY/btV5CfVICWeSK+f0
 yLCEdEsQLl46pOqaGgU1ZU6mjv8b0=
X-Received: by 2002:a17:906:4785:b0:c07:a892:8df2 with SMTP id
 a640c23a62f3a-c107cf16332mr480828866b.7.1782312403566; 
 Wed, 24 Jun 2026 07:46:43 -0700 (PDT)
Received: from localhost.localdomain ([86.2.40.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840eefsm8177109f8f.1.2026.06.24.07.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:46:43 -0700 (PDT)
From: Ganesh Harshan <ganeshredcobra@gmail.com>
To: philmd@mailo.com
Cc: zhao1.liu@intel.com, qemu-devel@nongnu.org,
 Ganesh Harshan <ganeshredcobra@gmail.com>
Subject: [PATCH] hw/core: fix block comment style in cpu-common.c
Date: Wed, 24 Jun 2026 10:46:38 -0400
Message-ID: <20260624144638.30990-1-ganeshredcobra@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ganeshredcobra@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 11:57:02 -0400
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

Move the opening block comment delimiter to a separate line
to comply with QEMU coding style guidelines

Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
---
 hw/core/cpu-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f8..6c9127cc30 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -249,7 +249,8 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
 
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
+    /*
+     * qdev_get_machine() can return something that's not TYPE_MACHINE
      * if this is one of the user-only emulators; in that case there's
      * no need to check the ignore_memory_transaction_failures board flag.
      */
-- 
2.47.3


