Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9CCA9EDE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHh6-0001a3-4k; Mon, 12 Oct 2026 11:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHgz-0001XZ-07
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:11:58 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHgv-0007rf-MC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:11:56 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so12455245e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817912; x=1792422712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QueqO13xdW/ZwsAlzziCNKkk2yOl7iMFMMHkLAoSdjc=;
 b=uHYaPx0Qrj9lUSzuOpW+ESfRzapBlEn8LkifA2ll4MYLF7/gzYvuHH39TQgjpXdBy1
 DHemY/YFb3mFkADG1ow38RaIg4UuMEycQ449X/DLWgn+SJlDy4n0QcIUXDS++1I0HItn
 2LjJC2NaOiPNojhDo023QB+awMdMbV9tn5uwgAjavxlEwh5fv7fzNzrcfAIcHGF9zGsD
 gAnYms7790ah9v9BEV5qFUCLAhp94xpjZVlQdXIBspzVyY90dUMgbjG67JJG9QV45bAV
 iAA8RS1fjCAruNKCEkN/qgmAsMdJXLUv49U/PE51BV9qjWXZ4k7X/8CX3KxQ/rIY8MTx
 pbsg==
X-Gm-Message-State: AFq9FYIGcpAO0ZjicOUu7nrXA1/c5qugiT5Qcz7LsEZJnWJXBOxeF0d9
 DM6ftwMAvDJMyED3A8RaTlcNgPKeO07maws+QpHNBMcOQky0arxOr8wGB/JGIL5v
X-Gm-Gg: AYBFou2RhwfG+4+MHXZgW2o2PLgyBicQukSUrs2NvrrFaIkPskhI8ZMuuzs34C8vV/F
 m5yShM580sbj3N4mw9DNpBL1Pq58XGrq0zA06/ISXGbK46rP/qi4wCgEUyWLvEagsUchGoEPras
 r6xONzs+nyz851Y4RZ3fENb1XcRi8cQPbTfqzjAQ1hLhUDUQF6Xdp/4t20Y6f0i9uwRjRuS9cic
 ZBgXQR3ukcWwoX4GKrOl5fHwCQe2Zp789nySyLS8tM/J0hP4prHNRtiQUimTAAoGm4AlER4Jg7r
 n2/jEWrgMiJ4XQdU0hlcHHtlnc0QeL7up9BQVbSRmhfWqjVGa0jsxgcmQxhvXTTG2tDSL5ThCP/
 hvh0+5JEK6ysXBI0F9IoTnIO40QITJV+5feEGPdKZ52XhGGTvEoHmirwuoCo38KYpLzaUDc5Ayd
 3fF2dWV8GSRB7nXLkerlwiLZIsZT0mwc3RBH5mxEGmMXe3d/OEKHPtvE1O/eqRo5U3ZXSz7L624
 WZeNjT0O7CWZkov7rqnxF12p6QKKNR4TiB7EtyJ3VMqDw==
X-Received: by 2002:a05:600c:8b83:b0:4a1:811c:8064 with SMTP id
 5b1f17b1804b1-4a18e4d5512mr184353285e9.26.1791817912010; 
 Mon, 12 Oct 2026 08:11:52 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19c71a1d7sm114618035e9.5.2026.10.12.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:11:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:12 +0200
Subject: [PATCH v2 19/50] tests/qtest: ds1338: cover the clock-halt bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-19-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=2993;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=PGqbxjw1SjqsGpwA7KFSLwn1aqj7opA+7ReWeQn2c+U=;
 b=zjTBktTePMzZboKFMmcjtbHyQErYjv+tMeqwk9qkm+WoYd9cxaciTIh0isAwQ1FsWxHZ9yEHg
 rQ6oNNGuQPNDv8Q4lgAm75fXFpeTK5XJDpL4LhW5OewWi1hYz8uOfUd
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
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

The clock-halt bit had no coverage, nor did its effect on the
oscillator-stop flag.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index fad0ca53d4..1b73dca98d 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -32,6 +32,7 @@
 
 #define DS1338_CTRL_OSF  0x20
 #define DS1338_CTRL_POR  0xb3
+#define DS1338_SEC_CH    0x80
 
 /* The clock and calendar come up on the host time. */
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
@@ -85,6 +86,42 @@ static void test_osf_write_protect(void *obj, void *data,
     g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
 }
 
+/* Halting the clock freezes the counters; clearing the halt resumes them. */
+static void test_clock_halt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t frozen[7], again[7];
+    unsigned idx;
+
+    /* Clear OSF first, so that halting the clock is what sets it again. */
+    i2c_set8(i2cdev, DS1338_CONTROL, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF, ==, 0);
+
+    i2c_set8(i2cdev, DS1338_SECONDS, DS1338_SEC_CH | 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_SECONDS), ==,
+                    DS1338_SEC_CH | 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF,
+                    ==, DS1338_CTRL_OSF);
+
+    i2c_read_block(i2cdev, DS1338_SECONDS, frozen, sizeof(frozen));
+    g_usleep(1200 * 1000);
+    i2c_read_block(i2cdev, DS1338_SECONDS, again, sizeof(again));
+    g_assert_cmpmem(frozen, sizeof(frozen), again, sizeof(again));
+
+    i2c_set8(i2cdev, DS1338_SECONDS, 0x30);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_SECONDS) & DS1338_SEC_CH, ==, 0);
+    for (idx = 0; idx < 50; idx++) {
+        if (i2c_get8(i2cdev, DS1338_SECONDS) != 0x30) {
+            break;
+        }
+        g_usleep(100 * 1000);
+    }
+    g_assert_cmpuint(from_bcd(i2c_get8(i2cdev, DS1338_SECONDS)), >, 30);
+
+    g_assert_cmphex(i2c_get8(i2cdev, DS1338_CONTROL) & DS1338_CTRL_OSF,
+                    ==, DS1338_CTRL_OSF);
+}
+
 /* The user RAM returns what the guest wrote to it. */
 static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -122,6 +159,7 @@ static void ds1338_register_nodes(void)
     qos_add_test("reset-defaults", "ds1338", test_reset_defaults, NULL);
     qos_add_test("control-register", "ds1338", test_control_register, NULL);
     qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
+    qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
 }

-- 
2.50.1


