Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE32C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cUI-0006AW-Rj; Mon, 07 Sep 2026 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTr-0005Xj-BV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:09 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cTp-0003ZZ-NA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:46:03 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so2539431f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799560; x=1789404360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9bQz/dpQcTFmknV0ZVNikpRUpVUFhyWc4TFL1C+8fm4=;
 b=HAfi/H/MdIeecLa9iDqqQx+Wuw1T9tJI8jikLAan2lykiN9C8GnGvy3XmWjR7I0mh6
 VLmZlGop5qCGWo663XPwewsf0P97cl+t6Ugx8BnpbSUxXNAsognoDxU5niJ3q1C2hqL2
 QEvPxqSmGdoeGvrMeLgHgW6YfZVbEyWDB8C2UP9OJES3jD+++VttKelI5+fQdoeRBXoH
 GqbN7VjcVsSyz6wkBryGh5AX6dEiru4BkAPVXlfYgxKg+EJloH74TXur0UJm/qKsYXwA
 bfbtN6LgjIVUieEy0b9BWZkJaHrU3XFvi1BLQna6dCk3Li8TCr4z0XfJL85URNZ51Fan
 e5+w==
X-Gm-Message-State: AFuF++kho1ItpZ4gSXf615dm8o+PSI24PpzOMjXTzPOH+DGzkFoTzi53
 moQcAwoM2gqfNQQnZJKXTmfhL5N7RmtlOe+rpRZZ+KCxKGJqAC1U8uLikvUOfqaQ
X-Gm-Gg: AYBFou2zS4/7ATYHghq5CESCR2ASFu1M/me+aW/Bn0cjqvBSCRLIZYANaiq+7svse2j
 jcb7/b1N08BwD0zeZqthT9Xxe7E8M5phTJGFrnJG82hGhHMytgFpMSMGN07A7S6C14ubZ6aPz4v
 EOwsLyZVTIGAILzZ8LoXx5smvYzHdVQ3HXjNWu1c6wual0z3Yin6ec46NMTcVZVrQxocjSJ8G7G
 OXvf2Em33uUf+zA4D+Q3smIqahFr+yfeS8qfX4Q+RMij462HkjuT4wEPuubVR1BYQl2NcRvaOan
 70NjSkszwLXXrMULOKsvdZekBAixligSsLCUN0gyU/TGNQGtPtKPERXysm9H2kHbHrgKdJCw1eD
 sHJL9mr2YNqLE/9Wp3/bFUajnKTUrvdTFx1sIoxA/xodH3UKW5Wh6NMDwXvwXeDNzMQRjj9L5TO
 zLDilN01XxTsHoOzVcptyBKELmy15vyPl7++dTdtJ73GhJ/ZmCzc9d4+5Spl2Mtp2S6kU/NnFTd
 0mSR3hvNuJOVMxiTZBXJwjKdDy36gcBUC8=
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id
 5b1f17b1804b1-49d0e79635amr87342445e9.26.1788799560138; 
 Mon, 07 Sep 2026 09:46:00 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm327269645e9.3.2026.09.07.09.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:45:59 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:08 +0200
Subject: [PATCH 18/50] tests/qtest: ds1338: cover the power-on register
 defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-18-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799320; l=1856;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=9nlnuEXuVbr9L6NPGTObkdBzIqjpFAqXLz9Eqo8+gf4=;
 b=x91vqxodgYiosSFS1bCekIByxelavNlrQRiGJNYP6+RCmICwPqEjqCZ3+zuENbJ6tpLFFfvAS
 K5UWyZOkty5DJTc9o5tqD73PXezARQl6//Xz26WzmlQlMsN+uuO3c/T
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.41; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f41.google.com
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


