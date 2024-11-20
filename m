Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849CED6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfX3-0007Rx-8p; Wed, 20 Nov 2024 02:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfX1-0007QG-Fq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:47 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfWz-00009c-Kv
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:47 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso8250226a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732089224; x=1732694024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bi4v+nZMri7qo5o9uiT+S514uJOdE4p14PmNQibE+6M=;
 b=LiY2JOq+NHTpG+rrnf5T0W5UxyO+AFwQQI/LZ/H/zclKQEEdV021Ie4B4jOQc+z1ml
 FN4UlPZOqiJNLBHSldQrgnv3IgjoQuJCIUlGoFi6BJzMVptLhZQY0aoaNC2LBr0VXzK3
 Sr7kfpcYuDdgBgIxAwOwsEIScnBQp6FM46kndhn9H7O8zaTGEj9GNo3eOYP7/P8bp1VL
 RwdOh+P+9RJEOJTmqedPVAC2M4TVrYAgVBMUTlIirD9OeXOWfUMVF9X7r4sldR7aw5jw
 r+8vimi9V4kgOqQwMomcDYGO4G79AJhxZgDJJA8SImeiy9EtO+rH6W8FbLFsGhNwCurO
 zAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732089224; x=1732694024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bi4v+nZMri7qo5o9uiT+S514uJOdE4p14PmNQibE+6M=;
 b=hHjkh0guqzKk578xOu+nKJXEBGBBz4we+0SRd6hrNR4zo1hGOLzBduQypa7mzGo9/d
 h1tZVsos3c0pJHbZZ03Apu201/fkViHxfsP88aSZES4RiOR2KttdNJ4IadlaHIytLoom
 bOnOAIWTXiSlXdHunSJYtnGVgJmSCwBxfnHk1UzT2lPt/ZZS0WevXkbVOMQpWJRtmgQB
 F/ekd4iB3bNyTB/hiaBQqZ4x7HUfwYwH9tAjhnPiD/X0DNIPW9httfoKTGMBo8mfFw4j
 iVCIJDA+Hf0qQU53Y9BE1Qv2XUPLUeFmUbPZy59aUYAtzSJeNFkrBbvtmBI7OxGRKRC5
 BDdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxO1G2+9E0SrVSvC7gW+6dBCaNUFB+H3pgnhCgAOluH0R7ckNpYki6tv7TW50h7X71DK4RAhVpmvKK@nongnu.org
X-Gm-Message-State: AOJu0YxwIJeu4Z2esWzdqmbBDZCd3SHYNEaG5HlIVJGuvzyU5WGC5fd4
 ro6cFhKyB3dq8RXzJuDbzaBQxpP5zh0UaFcU6NKLZlrd0oSTaKb0
X-Google-Smtp-Source: AGHT+IHd0R0h6iq72TbjMbAT5LOQ82WbefuctmcYQGUnB1FqwAvDM3wWqt0vIGWKrfYZ3s94G7S01w==
X-Received: by 2002:a17:907:c1f:b0:a99:499f:4cb7 with SMTP id
 a640c23a62f3a-aa4dd551cf4mr137855466b.23.1732089223736; 
 Tue, 19 Nov 2024 23:53:43 -0800 (PST)
Received: from finn.fritz.box ([2a02:8109:8384:1400:37e7:543e:4254:db4f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df265bbsm738395666b.38.2024.11.19.23.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:53:43 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] chardev/char-mux: shift unsigned long to avoid 32-bit
 overflow
Date: Wed, 20 Nov 2024 08:53:20 +0100
Message-Id: <20241120075321.27143-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120075321.27143-1-r.peniaev@gmail.com>
References: <20241120075321.27143-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allthough the size of MAX_MUX is equal to 4 and likely will never
change, this patch changes type of constant to unsigned long to
be on the safe side.

Also add a static compile check that MAX_MUX never bigger than
`sizeof(d->mux_bitset)`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>:
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index bda5c45e6058..355520714979 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -316,6 +316,8 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 {
     unsigned int bit;
 
+    QEMU_BUILD_BUG_ON(MAX_MUX > sizeof(d->mux_bitset));
+
     bit = find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
     if (bit >= MAX_MUX) {
         error_setg(errp,
@@ -325,7 +327,7 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
         return false;
     }
 
-    d->mux_bitset |= (1 << bit);
+    d->mux_bitset |= (1ul << bit);
     d->backends[bit] = b;
     *tag = bit;
 
@@ -341,7 +343,7 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
         return false;
     }
 
-    d->mux_bitset &= ~(1 << bit);
+    d->mux_bitset &= ~(1ul << bit);
     d->backends[bit] = NULL;
 
     return true;
-- 
2.34.1


