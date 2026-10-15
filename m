Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCFCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIfm-00031H-Io; Thu, 15 Oct 2026 06:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIep-0001mx-Ua
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:59 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIej-0003o4-LX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:53 -0400
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so46015475e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059946; x=1792664746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4c8supkKneQ6KSPUU96myXPMZvz+cStDQRdD8Fg6fTw=;
 b=wTQ0Bt/SWqugxHPmlWyK4dM6qO5BHYIdZqd6N96itrKxpxKFUNK07X8p4XjTQ6aTEY
 Bqm1tBN1cOMuZCh4SMOs5NckqTq4+T+Zw9ZuZLFZSvpVWbc+mykfQEB99oxD5GxLC0ua
 OyWNCAIH3hAwf6LKnXUH0nSeHlIwzlJ5FAk34OMcvWM+n2+njOSRf0nFsym2KzBh9stp
 Vom4I1r12Nk83CZYGZO6AuNymdfH38Yfn/y5VdQUJZU6Z6s12Nwx/hVsUyZ8WL02+KRE
 TzPTJVMn+JgzF49RZzs0KNWLkqVpDEdYgq3sVgKSWP+H/8RvrN/dIRAL8y5Li0pJ4h5L
 F6xQ==
X-Gm-Message-State: AFq9FYLpIuPLgqVW1HyQV+GxrySfJweln+ayp8xVUItA1k+XbP3hg58x
 UBOY7Qx/rNITKVCJ7YDON3WYmQONwprhwAxU298Do5cjAbAfEOaSMszy4PVaJ8CN
X-Gm-Gg: AYBFou1eBEc5AdqIkzxfkDUYY9JrdnNuyZKRTgW7Fk7wCxSsCf7Wopy4VujWuWPiEdn
 3YyrFbx7Baun/M3oAv74mBRQYpYjTriV5pJ2CFzAHkreGGE2AZHlDGgiCRwePsKQvgolu2Ii0QN
 ydxMwhEfyqDvt8N0QqL3wiajhwxWCDqRAOUj/vavFTox2chlIjPL2cjRMbgyJqvZnhloN8VboBV
 QJNciVzHucsA/5X0iVom26846Oc3sUmR4WcVrOA0JOHWGc0DV3vozjMX0tUWmfppm5wYMaqJXuH
 v7p7in64t4jChMqTxUtWPl4Uwex6h9V6C8uH2hsRvBB0Vw+Xvo0VXN8S9eYV1AOHuAKQU0q58JO
 2UQVkuD7ZIgvrf7WV/S0Df21z+xM3YQJxG2VDV6dOXgTiSgnQSjt4nCTSQNro7SUmPV8bk7YhKK
 BdCZgZu65fY+bPItMkxsgHAIJSVHbO1nJpAhZwU5ilKthD6EIsuI1MCpbQIiUDNXR3rLbWGDK9C
 dzH8QYzks87+CrjgqdF5o7VKQJKcxeDcs+MMfullT8r7Q==
X-Received: by 2002:a05:600c:c3c1:10b0:4a1:ac66:5f93 with SMTP id
 5b1f17b1804b1-4a1ac666305mr124119075e9.8.1792059945944; 
 Thu, 15 Oct 2026 03:25:45 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd67502asm43938155e9.3.2026.10.15.03.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:25:45 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:02 +0200
Subject: [PATCH v3 15/50] hw/rtc: ds1338: refresh the user registers on a
 read rollover only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-15-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=1985;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Mt2M8RCp3ALFgPQLrMqox8ji8iLmVD233jOdYO4LkMo=;
 b=KSfgNBcB65VgaAY/WqcQeENB5NQO9aTXOxAUOu63dAIrSi998vo1pkPYEw+QxNpGgrN17iq6h
 bzWa3h3D/j7CgBVF9cbCJmgAyq7VsDBlRBlKAynCgw08lOiVFk4r0Eq
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

Synchronising the user buffers when the register pointer rolls over to
zero is a property of reading them; hardware routes a write to the
counters themselves. Doing it from the shared pointer increment meant a
write transfer long enough to wrap overwrote the bytes the guest had
just sent with the current time.

Move the refresh to the read path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 79bcff4599..c5fc74e6ca 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,8 @@
  * Limitations:
  * - Writing the seconds register does not reset the internal countdown chain,
  *   so the sub-second phase of the clock is not modelled.
+ * - The user registers are refreshed on a START and on a read that wraps the
+ *   register pointer, but not on a STOP.
  * - Leap years follow the Gregorian rule, where the parts stop at 2100: they
  *   derive the leap year from the two-digit year alone.
  * - The model comes up with the clock running; real hardware comes up halted.
@@ -157,15 +159,7 @@ static void ds1338_inc_regptr(DS1338State *s)
 {
     DS1338Class *k = DS1338_GET_CLASS(s);
 
-    /*
-     * The register pointer wraps around after the last register; wraparound
-     * causes the current time/date to be retransferred into the secondary
-     * registers.
-     */
     s->ptr = (s->ptr + 1) % k->num_regs;
-    if (!s->ptr) {
-        ds1338_capture_current_time(s);
-    }
 }
 
 static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
@@ -201,6 +195,10 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
     trace_ds1338_recv(s->ptr, res);
 
     ds1338_inc_regptr(s);
+    if (!s->ptr) {
+        /* Read-only: a wrapping write must keep the bytes it just sent. */
+        ds1338_capture_current_time(s);
+    }
     return res;
 }
 

-- 
2.53.0-Meta


