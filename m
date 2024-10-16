Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B13D2F7C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1BVO-0002A2-FK; Wed, 16 Oct 2024 17:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVM-00028s-RO; Wed, 16 Oct 2024 17:24:29 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BVL-00013p-DX; Wed, 16 Oct 2024 17:24:28 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so440035a12.1; 
 Wed, 16 Oct 2024 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729113865; x=1729718665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnMQo+rYjxc+6D6y/U+RZNjtUqKrnuqcrTxxP6UZ8ck=;
 b=ZpxUk89teF9wDoztiihljPps6VmsgFvy7z+erGmcwhX05MutdYtqnB8fhPiCdmL81w
 L8E6g6f+GzZFVoYM0zaNA28rliEr4eA9KHywn9MGiMLzJxYm3ja+JFe8pmhUIUI+NnMw
 s2yqtnH6IbydNjFJuSRmS7n4AMIXk4E+vt+psRSrYWmWtLYtH7u8l7ikuzl5vDAwb2Aw
 /Nj7MkJbSAreFT34/OkXeocfu8mzfk4d2NW1/pjwObkBMpjP3N2+3qDX24C+u8u1XFFy
 qdTdMPEKnKp+YWSyfGBW/0HK53bFCaG7brTK6JNBZ/9MtXIR7YF/ZC0UNmnWW1Zewqbo
 p0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729113865; x=1729718665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnMQo+rYjxc+6D6y/U+RZNjtUqKrnuqcrTxxP6UZ8ck=;
 b=D20dCSOvdRT46BQMdsj3UktQEcAvpOsMZ0RHlHO6Q10qLS9EN4JkJLf3SrigaKuQgv
 5YNBQT9ZwyBxQDlHgh9tQEcrZnKW0Ia1qNXHp76ghaMeX6tkrTadxwAnbjkR+9uTlK7V
 7I9UYtaELDurrGoBdEI600N4COBwxis71K1fwqwdTPqFzW7r0QdrQS6/kXL8zrvb31ea
 c7tnxER++xpt/C27UtxuVBUOE8vLmE8+OM75roGioP9TyzXkr9hdBzSAbZxDQaDZmH3T
 LHXfz+DpK/u+KfOL68YyMPiGY6yQVWn1EwwuB0YrXqosSMRVW+8lBZ5YOt/rC7uXq7+i
 IBEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHLP65N+DImbuC4luu267AAhh/SzPVDtJwrhcfCqTRIe9srghaqoWhDcdFburPJs2vSQT4l4stwA==@nongnu.org
X-Gm-Message-State: AOJu0YwVrLV49BuxN3NTW0T1XGaKoEOmpZWRvfJVVFK6ltMUhiWD+Adz
 iH1qBJe/7viO6bTOqBqo/GtXIqq8PVi6GsroE4x0w53HGvk2fERcy1DHLw==
X-Google-Smtp-Source: AGHT+IGEUaaGIUiqW7xl40Z73HDRtN8tEhjFaNzCNNHwbhZm240LyXu9+rlMFOboLs1e05fAH5+OyA==
X-Received: by 2002:a17:907:7f12:b0:a99:f945:8776 with SMTP id
 a640c23a62f3a-a99f94588c4mr1369022166b.24.1729113864966; 
 Wed, 16 Oct 2024 14:24:24 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29750a9asm218005766b.88.2024.10.16.14.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 14:24:24 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 5/5] hw/net/lan9118_phy: Add missing 100 mbps full duplex
 advertisement
Date: Wed, 16 Oct 2024 23:24:07 +0200
Message-ID: <20241016212407.139390-6-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016212407.139390-1-shentey@gmail.com>
References: <20241016212407.139390-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

The real device advertises this mode and the device model already advertises
100 mbps half duplex and 10 mbps full+half duplex. So advertise this mode to
make the model more realistic.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/lan9118_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index dafea5a875..5f9737556f 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -149,8 +149,8 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
         break;
     case MII_ANAR:
         s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
-                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
-                               MII_ANAR_SELECT))
+                               MII_ANAR_PAUSE | MII_ANAR_TXFD | MII_ANAR_10FD |
+                               MII_ANAR_10 | MII_ANAR_SELECT))
                      | MII_ANAR_TX;
         break;
     case 30: /* Interrupt mask */
-- 
2.47.0


