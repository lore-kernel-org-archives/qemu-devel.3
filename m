Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B004ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHZi-0004P0-Vt; Mon, 12 Oct 2026 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHZ2-000494-7E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:03:54 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHZ0-0006SA-Id
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:03:43 -0400
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so12400605e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817421; x=1792422221;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vPB5f/PPZ/fTGUrJWi/0AwBmdqaHERhdZDqmO3v6YS0=;
 b=EUeB+YS+E5E1+53HLJX7JsHYGC6BWnH+NrkGZWwddA13TjXIPAIhPo9PgkWuubuq8l
 fj4bYwjNoYPZpofAiPW6qv4jXuQbLam69cxUXEHVVMbH5HuB9rcjXlS9ludHQAt4t1NM
 Ya333XgS7aRIEKHRwH7n8OOae2dkHXJOjrxuNqk3x78lM7+7RYFaPERB0TX0cbAA/WRz
 WXgLm+2isge6f+7zDnAHHKQezWYqdZqFitmVzD1aSpd9hpcP3b9Lphxo8dc3pCDtpsHL
 zj3MmVuwR7wfMGGK+VAdb/QsV9YKajUCqu+tAiXpLgMWAvBQURdkZjxwaoiLUP+CL1M0
 HtlA==
X-Gm-Message-State: AFq9FYLdMXT08dfppP9FK0lCR+L8LTIDfs9E+3OJ9I+kPw/001qA0DZ2
 mgKhPQZF1i2QGt/nEEphjdBYQaHKfkb1YHJAtq+hCH8aeH/DcGsiTtwQOrpzCQpM
X-Gm-Gg: AYBFou2caZsaOn6xxnbC/3qeBSszo9m3WWLPuHMz1rO5LWHgRkQT8lgq5hIvP+F5IuN
 7xGmDVlCSLt/ZDFLAYUTRU9o3/EkjV+ep2m8v/1nH5b4h47K/MhbLcKmj7RYCqbbey+6u0V/NQ+
 3IxB28glU1/+eYgxOMR8euM6afEfMsXR/H/7fJQDoWEnfJdN8uQjXO8DmpLKjjdVi6JKRb4SyD1
 +DozX55LfJPF2jkKo21kPBO6pv+XYZS7JhqVEm/XqHF3MnqdYbWLxfen82j3kr35+8vuhvpSQfR
 AO6DjCuoXe4AfGj4CXGuApsJQ4vCh6yPSU08EnCdN9d3NrAz/Sxm9myqkZ14FwIcBOFM/n6fS2K
 w4QoRqHXUj6GTO6y+QRqPnnRzb6CZ2J8kOpBHngixnxWHm0P3qC5YVFV91uOd4PGxRTTAvlepx4
 mIIC9Amq+aQ/j4vsSX5kEsz8gco8CwalkprcMbwi/piDJax8yH1qhu0tg3Eb783+32VIM1q2N/x
 ZSljDOQj9fF94LTqTgZIV7zX5+BSF1hogftc4a9EnhaNQ==
X-Received: by 2002:a05:600c:3554:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a18e43a1cemr187370475e9.1.1791817420622; 
 Mon, 12 Oct 2026 08:03:40 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1a1feb78csm87213025e9.0.2026.10.12.08.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:03:40 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:04 +0200
Subject: [PATCH v2 11/50] hw/rtc: ds1338: prefix the file-local helpers
 with ds1338_
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-11-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=2049;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=4sMpXciwY1X59HescikiS3PryefwPgkY5TQZ1q6pfqQ=;
 b=HZAMH3EH9Mhlg4TMlDcCgbSk796PNWu8xS95fvrSTWKaIU2aFTYUDy/d7lzBqdmKvM23CQWd0
 NmK9iB+ZkFIBCkxnYuJg0LygW1TYHoB+dgtho+6v6apz7MWyUgpti1C
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
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

Two static helpers predate the rest of the file and carry no device
prefix.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 74aee6c746..1755a3a37c 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -57,7 +57,7 @@ static const VMStateDescription vmstate_ds1338 = {
     }
 };
 
-static void capture_current_time(DS1338State *s)
+static void ds1338_capture_current_time(DS1338State *s)
 {
     /* Capture the current time into the secondary registers
      * which will be actually read by the data transfer operation.
@@ -85,7 +85,7 @@ static void capture_current_time(DS1338State *s)
     s->nvram[6] = to_bcd(now.tm_year - 100);
 }
 
-static void inc_regptr(DS1338State *s)
+static void ds1338_inc_regptr(DS1338State *s)
 {
     /* The register pointer wraps around after 0x3F; wraparound
      * causes the current time/date to be retransferred into
@@ -93,7 +93,7 @@ static void inc_regptr(DS1338State *s)
      */
     s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
     if (!s->ptr) {
-        capture_current_time(s);
+        ds1338_capture_current_time(s);
     }
 }
 
@@ -108,7 +108,7 @@ static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
          * START_SEND, because the guest can't get at that data
          * without going through a START_RECV which would overwrite it.
          */
-        capture_current_time(s);
+        ds1338_capture_current_time(s);
         break;
     case I2C_START_SEND:
         s->addr_byte = true;
@@ -129,7 +129,7 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
 
     trace_ds1338_recv(s->ptr, res);
 
-    inc_regptr(s);
+    ds1338_inc_regptr(s);
     return res;
 }
 
@@ -204,7 +204,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     } else {
         s->nvram[s->ptr] = data;
     }
-    inc_regptr(s);
+    ds1338_inc_regptr(s);
     return 0;
 }
 

-- 
2.50.1


