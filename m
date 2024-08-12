Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA90C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 01:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdK5V-0002nD-Lg; Sun, 11 Aug 2024 21:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdK5T-0002mi-Gv
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:43:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdK5R-0002qR-1m
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 21:43:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so26661735ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 18:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1723426980; x=1724031780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=avEVceMifpipUBT6ldxMcEq7G2/EptaN2U+ICKQ1hzo=;
 b=QJMMOiPD22c/hVHLePkr9XUiU3AgvswENdkhNoVLx1b/5RgrcbOAHPOORjsIXKg0mG
 oKC8k5X/b2hv5kjym/PCkxG/v71BSj0dwoh6zFtyy3qZY4EBAS0wkdUWBwhBbLvM0v3M
 2lw1VFZCBFDZ5ZWWOGYY4B8rDwM1tcGAcFN6PfwUHLUgCkqWCaH1LsbYkTfuwkLQ1dhH
 SW5iUsZOHzyuFo5aO1ywuwsQ9IjndCFswO4XCScDyrENNB4Xk/g0qBVROPMPrqzwIM2J
 ugh1jDBuGjDDctLTG87sg9T2/Bn7WvfZe0QSZ/5FkN4CpJY5ttEE1YLH2/4ahl10dhNf
 yGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723426980; x=1724031780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avEVceMifpipUBT6ldxMcEq7G2/EptaN2U+ICKQ1hzo=;
 b=Qx0gkIpMFS6YYbJFFQW7UbahLj9UVIsMaWX8FcbX6t6Y2TR+5sjFKR9P6OmlZwKEfa
 QT47dMIYE4Zg8MGc2BmrSu0X8gIN1pbpcoznuXfS796xeJZyG7A5T1OyDvs6CmNOFgss
 Df9L3/+nOWs+42VzCsk8taQi6nLWyM/Y10LthhtKlMsN6hvHCbkASdspj3Y4nUYT5icq
 5NWVcaGl6TxqJgapGtQ2ei4WvHFE+GTSSBCuq03owo5uaE3lKx8/XBAf02atZzSgsA4a
 /jr5g8VadSsYBzvNU9vYtQDMCkcyr+osc2O+VgeJ20Xkc9JBpqn2DFUwRHqNF8UMD/Ra
 pMFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdcB2tzR3GXuoCS5wFFP7fyg7HZ6ca3bRpMziMm8+CtjuH5n/9vTiBixKTkZYGBouCTu07jrL11R0XFBfHt/if1CLRgN8=
X-Gm-Message-State: AOJu0YzSIllEUJhB5PsQfQd9aUUS9buLKhUFw0ndxicajO+YasHjCwvK
 GwltORcrgxc30d0IbkA9Msy5thLDIOkKt5H4a43hXL/N+nVCfKIbTGh/uD/2MCI=
X-Google-Smtp-Source: AGHT+IH9aXsboGcVo+nQd0vTpKxuJtvE29Ps+J9DQ4bk9MVZPpdMTDbLvA0TMIBA8Sa8jAxKTel4UA==
X-Received: by 2002:a17:902:d4cf:b0:200:9539:ee8 with SMTP id
 d9443c01a7336-200ae4dbc4emr57948265ad.7.1723426980319; 
 Sun, 11 Aug 2024 18:43:00 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb7eab09sm27627405ad.41.2024.08.11.18.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 18:42:59 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: armbru@redhat.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] qapi: Document QCryptodevBackendServiceType
Date: Mon, 12 Aug 2024 09:42:52 +0800
Message-ID: <20240812014252.1398754-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QCryptodevBackendServiceType was introduced by
bc304a6442e (cryptodev: Introduce server type in QAPI). However there
is a lack of member description. Thanks to Markus for pointing out
this.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/cryptodev.json | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 68289f4984..9622c6d92b 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -28,6 +28,16 @@
 #
 # The supported service types of a crypto device.
 #
+# @cipher: Symmetric Key Cipher service
+#
+# @hash: Hash service
+#
+# @mac: Message Authentication Codes service
+#
+# @aead: Authenticated Encryption with Associated Data service
+#
+# @akcipher: Asymmetric Key Cipher service
+#
 # Since: 8.0
 ##
 { 'enum': 'QCryptodevBackendServiceType',
-- 
2.43.0


