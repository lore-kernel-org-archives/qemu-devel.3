Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460E7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0T3-0000xm-Tb; Fri, 02 Feb 2024 15:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NFW9ZQcKCgktxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com>)
 id 1rW0T2-0000xc-FA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:56 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NFW9ZQcKCgktxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com>)
 id 1rW0T1-00008C-0j
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:56 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5fc6463b0edso42279717b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706906933; x=1707511733; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5g3sLXPxpiK7LDiVehLWDyyJwIbWvaSWBTkeuyNpcN4=;
 b=xgXHQeD8z2iSU8b1z4BcrRLkKo33yRfZCTJI57yQPoG6ToPQWaITxGxyrRC36zPJqh
 1Tkki8Ycn4BW7z/rT0EkeD74cpWKiULNa7+XNpgst7kUhoCdHPD2Vs5Tq4zL7VM+r22x
 owM0EBQs93q8ScLrcYtl4VtKoApfKKKlNVWbDvzeQGSRdaBGwls+IlnGHTXWGEspyu6P
 43I+t7Q68kfiHSqbPc2GKvV7K9uO8k/1fK8BKxjMZoZ2YoVeel3FakFt0StxWtctKUAX
 +njjZBHiBQWQKQpyucL6cKlzTX8pE5ZEViHaQ6GXCBm5s+Q+tkDs/+6Sjz60l+D3X5vW
 vHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906933; x=1707511733;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5g3sLXPxpiK7LDiVehLWDyyJwIbWvaSWBTkeuyNpcN4=;
 b=GFQ6lufk18ZquXPEldfHZ+6mOB9VOiHeZNLHM6R8x+yER+XbZ+mcTbHPpDUzGXEe8T
 6PoqvJRPCGhqAVGMlY7Jv+1wcTu+Xj+6D+NsjFD3Zd5HeSD2OtJhBinvuLYfrGZnuZ8h
 ek6COBvsULrZk7f8fl+NNncfjrl4m5KtTafL16pTAr3HHA9e+t3OmSO7BjRRwi1imBiD
 EPvcT55sq+XEE2hCeg/ZXWeXjzt19EK8mxbCHEsnYJu/vbmd9tsCMMY/A8Ki1p9pvWCm
 X+C9B+Tkrj2ETcalFiP/sisBMTBHiGTz5Je77OgBR9X58lgm5dcZJ1HmJqaNqP/lXnWm
 k5Hg==
X-Gm-Message-State: AOJu0Yz6GGpamO8TbyUoe+0a2lAXF6HhBjCbQpqw/Uvwdh7Hn+cYYbS7
 tCw9Q92tQ/cZY6wHXR7CxVkndPUi2Zbp0IjpgWznIWA7cj51R4aGQtz2M2fDnunOvkqixcT462z
 AV8dGRoGJxnO1JU+2yQtbcvn3vjIMyze5Rmqrpzu40qcQePT3FtDvgQQqfBEwszSn0bJ4plKrhG
 Ra3w/hwcic2qBDOW+wb4F+Rkk1c+6cuTLuqpwY
X-Google-Smtp-Source: AGHT+IFjh/v0izNeSezdOTH8uoVXK54jMK56bBmHJOc58pQn8MNiC258Zc0Mfw9nailMMROez6IkXttCz482
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:690c:12:b0:5fc:4ef9:9d6b with SMTP id
 bc18-20020a05690c001200b005fc4ef99d6bmr615670ywb.9.1706906932843; Fri, 02 Feb
 2024 12:48:52 -0800 (PST)
Date: Fri,  2 Feb 2024 20:48:46 +0000
In-Reply-To: <20240202204847.2062798-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202204847.2062798-3-komlodi@google.com>
Subject: [PATCH v3 2/3] hw/i2c/smbus_slave: Add object path on error prints
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3NFW9ZQcKCgktxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The current logging doesn't tell us which specific smbus device is an
error state.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/smbus_slave.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 1300c9ec72..9f9afc25a4 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -25,11 +25,15 @@
 #define DPRINTF(fmt, ...) \
 do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+            exit(1); } while (0)
 #else
 #define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+             } while (0)
 #endif
 
 enum {
-- 
2.43.0.594.gd9cf4e227d-goog


