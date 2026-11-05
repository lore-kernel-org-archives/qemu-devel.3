Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A1606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHv-0003OO-E6; Thu, 05 Nov 2026 03:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHt-0003Nq-8x
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:37 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHr-0003io-87
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:36 -0500
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a089dfee18so252190b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869054; x=1794473854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2TFQ/K2+n3LqcTPLQTKo2+VbMDYp1DEdeJ43Ldv0iQ=;
 b=Q5X+xKkV62DruwabrYZbVBGPNEluyZ06ntPpiCYN3aEzjMjPkmgXF+voMpxNXexUK0
 OdEsWzRUD7meRn8lZ1S0my4h8AA8/YuOdq+6otE+cnuz3cwTZj2YLIlPOmbm3vmEKBun
 XXMthCyIGuyQjK57oKh7jdRuTFMYNl0KJv+gkgbvTqtcvFxP7oGRJc+ydv+VbmUm8Zte
 sU/dJi1AgPm/oNuw9bu7S1eD7bTNeeXG3+F980UMFhBKsHWsO1f0yJMkicUzC8ntQS5w
 bYK7OugqrcOdzjovWvFNYKXo4ldmS+3SJICIsLuZCThYnhbexzwz6q5Dql2EJRC4aSf2
 3WQw==
X-Gm-Message-State: APuU4Z/ybOI38vBAQv5l3BLygATUHZZW2i295fY8wCFy0KK7Tl7sylAe
 KS7OnOPkamMHNADfTxakRBWkwQE1eFCi/td3ISGvJ4lc5GIphy+CmNLpnRcMDLT7hq8=
X-Gm-Gg: AYBFou2VrziQoWz1DdNyAgs1Wh7K2xI9wKHyiFiJLhXKkq68HStlVYly/p8r1WxV4vR
 8Ke4bVbXdKjL5lk/gB5NH3ohqTOeqbo2OXGq/cwaNUylGoFRE5xAJCyBOhT+dmfcZFxr9LwaiSV
 eIs+mxfu8kgnPFgQhtrJsEFmqFccQsUt7Yuyt8Rf+8PdU33MQemGgAEO3Er+ZIYfPE+kYnx+aAl
 fLJDd8nm5AwF256arBs8rAKuzq1jaeZy7aw8TG2uUZhhoLh+pBgrJico5WACZJrKSUGmAEEwtsb
 X/Y2r5at1wUtnrdtoga6bLxTIjbairZp2Fg+7bzPP2k4kWyk94pNMfshuOtIhmIBqM5expyudjH
 gAS2ObU2bMJR0heiEB7tiuSwC9C+ntoe7n8Gl/epXarLf49hzqUvGQeBDuVpxKYNSp4WlE4UToT
 uTI7F5vFcUTup3EUJxZcYsNDjTe2fC9vhzBoT3hIwJnWJUUsKRFkQJYU+A9/u+Q9n/9Kq5y4L1/
 EGGog6UMlmlycnJGRxQ659mwMbXwZsslCoHog7wNSVHJnD9Ebp+2CC/eRYPPmenbWEUBYRazGBY
 Y8yyQbza6tU7xE5ibhkesJE3yR4CSFEl3wlvNz5x5HzS9E42qZxjikoNR4E3ypG8dYovD9ElSiZ
 e3hrsivVswuaG6faWkvwz/BVhyro=
X-Received: by 2002:a05:6300:6186:b0:3e0:c2ce:3f71 with SMTP id
 adf61e73a8af0-3eb983e5911mr1315097637.37.1793869053599; 
 Thu, 05 Nov 2026 00:57:33 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09b089601sm1837217b3a.30.2026.11.05.00.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:33 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:42 +0800
Subject: [PATCH 06/19] tests/qtest: ds1338: cover the power-on register
 defaults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-6-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=1861;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=sNuGg4g0N4khunE3Y+1axZd9urwfd6Pf1mqgjJj3DK8=;
 b=XWSEM0g75FqI52Z+SqjmB5ZhBbzHFfKNyO/bA7AROXfJqbRbJVjHiXVQgD/rx1usAYS+be3Ye
 kSJtO5k03bkBiVx52iARyC6HBm/fgVnrg3qFuctzv7uNCJXSs1bFMpr
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.179; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f179.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing pinned the reset value of the control register, which is how it
sat at zero rather than at its documented power-on state.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index 6066a34846..fad0ca53d4 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -31,6 +31,7 @@
 #define DS1338_NUM_REGS  0x40
 
 #define DS1338_CTRL_OSF  0x20
+#define DS1338_CTRL_POR  0xb3
 
 /* The clock and calendar come up on the host time. */
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
@@ -49,6 +50,14 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(2000 + from_bcd(resp[6]), == , 1900 + tm_ptr->tm_year);
 }
 
+/* The control register comes up in its documented power-on state. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL), ==, DS1338_CTRL_POR);
+}
+
 /* Writable control bits round-trip; the reserved ones read back zero. */
 static void test_control_register(void *obj, void *data,
                                   QGuestAllocator *alloc)
@@ -110,6 +119,7 @@ static void ds1338_register_nodes(void)
     qos_node_consumes("ds1338", "i2c-bus", &opts);
 
     qos_add_test("tx-rx", "ds1338", send_and_receive, NULL);
+    qos_add_test("reset-defaults", "ds1338", test_reset_defaults, NULL);
     qos_add_test("control-register", "ds1338", test_control_register, NULL);
     qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);

-- 
2.53.0-Meta


