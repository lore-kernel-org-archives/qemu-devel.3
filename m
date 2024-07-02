Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1259DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfQV-00045K-5O; Tue, 02 Jul 2024 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfQM-000422-Ui; Tue, 02 Jul 2024 11:28:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfQK-0001lf-2E; Tue, 02 Jul 2024 11:28:05 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so5323784e87.1; 
 Tue, 02 Jul 2024 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719934080; x=1720538880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+gT6JHgN0sAyJsyLWXnk43TCFTRRU21Xv8R1X9fzSkY=;
 b=Noka3Lf/yKDxUVfKVf3RwgEebidwj5dBtZYcq22Xvohrtb7xzBiNEFs3d+17cuYSO4
 FaZRX8s0yRgiRTkpbdNTVYTZ02H/5tP3RzAD8XSqAPZ7wGCNKjl4YwIJdsFPuWcIKbsL
 SxXJs6Oc9tQkHsuOVT3EUuj4ERxY6qE1wT5gbORgtm6ljrysN/i8LLGr2uXgg8Jj9wtT
 4YU3IiDRNJl95EIikXdaNO5EU/GC819aLoqX0e/L9BJeSXxjbZa0f7D4XWzmwl/L4L+Y
 ScVpq+bmhPNphFFO+IVkeRXqcq0zF3K/Yl0M/KiL+v6vCEsYhQveP0gsu8zjFzUD3NtG
 xT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934080; x=1720538880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gT6JHgN0sAyJsyLWXnk43TCFTRRU21Xv8R1X9fzSkY=;
 b=sPxggacY5vs1+hB8HyApEUH6XyPgjlc5B8Vcnz+GeYZAmsibt7d/NNCutIpKK0oZYz
 ZhMM9PjY9JdEJSBh9V/Mt61JyTnYp9rvY0KVtSmc85Ms7YoMwNOpZueJGxJYgFf9Y33F
 L634A5fSRqwFKR/jd/fa2bHzX4ynhYoZYDC6d/YTkd3alZkwysKJ3v682WaSRk5AxCa8
 ZLTTIPpfsfPkpwY+yOuFxSscgfEizLEsM6FmU0jHwo8zDCRv/qYvUoG2E+hiaC1jA3F8
 CgX/T87/UvFQhpd3AH0+jYJLBQd7Sa2Ct0l5pfHkUvNhhb+2AqKMek6FTwpg9XXpg9ls
 ZTlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG97mImpqh3N0/w9UoEQ14wvCmsxZ2uswE089dXLAwPG7waFg9gCJ7fgtg1bHluHsvGJTYi0aOc/eoE7yE/7mVtbM4/kzZWDrwVGb3nAfIeJ6My8oRjMIKDWU=
X-Gm-Message-State: AOJu0Yw07aQ14vW3JZzMRQf6ZTUY51Fv8hHN53DKRnbPVOW+LEMkWZM0
 5aberUfQL0yqG21PgGeoUQW65CvUpDMknSmrlTNOUb5Mkjm+0NU=
X-Google-Smtp-Source: AGHT+IHVKi1YvQ1lZU0y0PCKZAAk5xsp6uAXKuz2kytUqMCJqUzTbAf9ndCebniMWOR1eEbSgN1owg==
X-Received: by 2002:a2e:a910:0:b0:2ee:7b88:7f3 with SMTP id
 38308e7fff4ca-2ee7b880869mr1758911fa.12.1719934080072; 
 Tue, 02 Jul 2024 08:28:00 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3f14csm204464925e9.6.2024.07.02.08.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:27:59 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
Date: Tue,  2 Jul 2024 17:27:50 +0200
Message-Id: <20240702152750.3017426-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

In pl011_get_baudrate(), when we calculate the baudrate we can
accidentally divide by zero. This happens because although (as the
specification requires) we treat UARTIBRD = 0 as invalid, we aren't
correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
ranges the hardware allows, and so some non-zero values of UARTIBRD can
result in a zero divisor.

Enforce the correct register field widths on guest writes and on inbound
migration to avoid the division by zero.

ASAN log:
==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348
(pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
    #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
    #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
    #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
writeq 0x1000b024 0xf8000000
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
- Enforce the correct register field widths on writes to both UARTIBRD
  and UARTFBRD registers.
- Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_load
  function to prevent division by zero during inbound migration.
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 8753b84a84..ba5f7cfbda 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -374,11 +374,11 @@ static void pl011_write(void *opaque, hwaddr offset,
         s->ilpr = value;
         break;
     case 9: /* UARTIBRD */
-        s->ibrd = value;
+        s->ibrd = value & 0xffff;
         pl011_trace_baudrate_change(s);
         break;
     case 10: /* UARTFBRD */
-        s->fbrd = value;
+        s->fbrd = value & 0x3f;
         pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
@@ -531,6 +531,9 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    s->ibrd &= 0xffff;
+    s->fbrd &= 0x3f;
+
     return 0;
 }
 
-- 
2.34.1


