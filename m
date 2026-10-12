Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1070CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHgD-0000om-7B; Mon, 12 Oct 2026 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHfz-0000gm-5B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:10:55 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHfw-0007ky-Uz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:10:54 -0400
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so425071f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817851; x=1792422651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9bQz/dpQcTFmknV0ZVNikpRUpVUFhyWc4TFL1C+8fm4=;
 b=LX1kpW95Dko5BpmKlDal/my712Ay97Mk8Ta8cZvHlzi3vGdxdLeXLLcGyHGfJzLpfH
 X9ItyE0LZuxAMYfo7bqfkQSkndwngD9kboRPu4NWF7hqZY+xLieU+FmOemOj+Mjb/Vmt
 bq9MFRxb5WjONB02taWdfbAMOIsSJJ+SKiPGRUfTKIA3bFKRdCzuSyajZxmdaNVkRJ8p
 kTOe869rEMPBNDSV1w27SRAFk7YOi6aNC4+WxZIfr+cAQ7Frth0vaBrSuWgykOpuDG8Y
 8nqLvlbonl8Mz3k2etTrAOn8grqbBlOr9g2G1GMniw4GJ5ecTSt58yQ2UUhmH2g0EDfG
 hY2Q==
X-Gm-Message-State: AFq9FYIqWRBkf7Z6AoO5n+wO2qqaem1hvUBnlbZu6SCDHEOqF0s/LYUL
 2Mp3LgaHvco1A70Jbm//PNHUspOfYMvRGf54y7UOnfEV76SWW2lTBplhbxMbGorH
X-Gm-Gg: AYBFou0j/tNr7MNaAuuo3i1UcuuZ+jnN8yfVMfNDqVnKRbuYW4uRqJdU9zW5978uEcZ
 wDEQ0K8tzjB/iXrwfbLnr02mZwai0uyXOhaoJJRXgcRljwO5WslrA09fdcJz1iiI9ivE3R4FB/I
 9O4ehFjUC+Rd7HU8ppyynLhBmohy8JBTOV2Jrv6GXWCc0KFnvRhZCW4h1mq3+k5j2+TMaiVi9lM
 Nh0i2wAf8dnhYF1zDTZqKdeSsicb3PJwB+ms2PiqkZfOPNeo1CXfEpMPanT8PrZZ3k3z/Ds6cfO
 gGPlMCgAHGecaTbvvHrN7c4Ah3cJR3fJ28ApHbXbaWwH7VRgL4N+AF36oAnSbvN983V5P2yCZGL
 Vyzpg1ssBIC0Vtig2dh9iLeZZLd3N6TeWFz89gtQUzeLp8EjvL2I0FE0335fyoKTVuexjvguobu
 /06R9NlvSWJ0nZ5mWMsp1afB6SA3CMQKNT1WlyWP45pezHj5TnTybDt49mTNPpWJCBcI6WXHWQ2
 cT/2x5uo02v7TmSK50MxwCwKgaMAp/XHIaGeE/urxqZug==
X-Received: by 2002:a05:6000:29d6:b0:487:40a:5ba8 with SMTP id
 ffacd0b85a97d-48dbacecc29mr10911946f8f.15.1791817850809; 
 Mon, 12 Oct 2026 08:10:50 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd3aasm19361499f8f.32.2026.10.12.08.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:10:50 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:11 +0200
Subject: [PATCH v2 18/50] tests/qtest: ds1338: cover the power-on register
 defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-18-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=1856;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=9nlnuEXuVbr9L6NPGTObkdBzIqjpFAqXLz9Eqo8+gf4=;
 b=EJka7OBMD+c0KBxDRvlXbDlcNQsODRKuSGgPWLO44rhTjOmICbJOPv7rRbgDjhdmigeBEQo8V
 88tDnBOTX2eCk+HxE0JRj6QNbiPu+RHy+uCJpiagxA9hyRs7ktIb/Oy
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f47.google.com
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
2.50.1


