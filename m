Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F5FCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIgC-0003g2-4w; Thu, 15 Oct 2026 06:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIf3-0002Dz-FY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:26:12 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIf0-0003rk-T3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:26:08 -0400
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so3239508f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059965; x=1792664765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2TFQ/K2+n3LqcTPLQTKo2+VbMDYp1DEdeJ43Ldv0iQ=;
 b=ywhHU8i5aqGn7OAHy+emMtWKOGP1nZYW9+yltJhT5XJbNJRCld5pHdxe+oXHGrAOmD
 dslflXAZiWycBnT21STBMiSlxN4pChqn8rgfXoIZmftLVdamzEwV3psmgsysDOXkVUnp
 cH3EPKQOHwPx94dnHZ2e0/D6VRSjfUF3GKaHR4wXc0z9X4Pw1+AGsheBtXduhD1F7DVI
 Lf5iBIZt8aN0gSfTDqXSEay1g75c7snLN7OnIKyag5CdDBw3+TyeZmfdqyR2is39jMm/
 KcRTtshKsgPOp/cIGI/8RiBXcNG0J8894QVW+sQaQK0IiclOGLt2aXnIR5++y6ajS1xT
 QOpA==
X-Gm-Message-State: AFq9FYLqAVSsAKsuTO66+QV7p35XqNTNls06/p8Aviyu/H+IDiEC4Gp0
 4nSlt854aAhVTYckJ6KS/U5ZvqLG/R0njJ1kMc0gm6LJWcWpfWFUhMHiINhlTQ==
X-Gm-Gg: AYBFou2b2aJcBupZExL5sFADa0woefKOHwXlwd5KshVIvP2HoeyfhpyaCAU7d2c46ka
 oieWDFlTh9f7xr7xXujlQmBUckCL03DwHwr9V3vIu7kYiDLbCSIBVgZJs7TLpouORXE216H4djJ
 MKjXE0GgUBjqf5N8x3wJUSgqWGcDku0JgVT+vZgeU2aSEL2nNpLaGXdB/fzGYTtCAe4k39Dmspr
 nSh5n0A0JjcNplr0NKU0fd6A//jBIm+XA2+VmMsx7uYRolWhHufP21bJIWbwNfx2kgplckcnbLV
 dEqnvfBGo4JzmvECTrI4j3RVlUZiW4dUlPY+doWuwnSlJCk8BSvYBArWjwjdHZPQqHRPa1UkiIc
 wqIIToR890HxJIvr9chOPTLjzBux0TKRGsuHFEOomOx3TjTC3tpKVpCXfaO3ZIlJJ6tWS/xbIHY
 BsaJGfXQmjCWAnAmZDyl+3+MpcKhTzmUxLbyViKtafvUV9/fODsDzAeAV6w1M4ZeO6y/MP5GgR5
 upMwZtcOGKHgL7syD9RzT9PwKz7h4QFPjJoxjaTIpZiuQ==
X-Received: by 2002:a05:6000:230e:b0:487:1f7:f506 with SMTP id
 ffacd0b85a97d-48dbaadeba7mr33207131f8f.11.1792059965300; 
 Thu, 15 Oct 2026 03:26:05 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de3f7f8b8sm16999660f8f.35.2026.10.15.03.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:26:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:05 +0200
Subject: [PATCH v3 18/50] tests/qtest: ds1338: cover the power-on register
 defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-18-7d50c8a108e5@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=1861;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=sNuGg4g0N4khunE3Y+1axZd9urwfd6Pf1mqgjJj3DK8=;
 b=B9w1AhJUOH+bW2Ty9gM0yPxx9RdhaWOx52lDoWu6MnpLhmEF70PyKX5ySRIENfFRgP7/LgqC7
 YSEc4hHCynmARVTbWx0+OZxaq8y57ifFrrNvdPeX+D9AH1MlfG8ygPw
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.45; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f45.google.com
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


