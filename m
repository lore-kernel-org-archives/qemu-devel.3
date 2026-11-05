Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A85606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIT-0003xr-Du; Thu, 05 Nov 2026 03:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIH-0003qo-Ua
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:03 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIF-0003kV-S0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:01 -0500
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so1441121a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869077; x=1794473877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oYoBAtb0sGasvrkB8IWuXlvz+SK9VWJjTLvw46YHTLI=;
 b=mQ5cwslIBgudHxm5/Ddw7vJewM7Yq4PZMWVwIqXIMl5ogVxziGITl/1MbQfwmq2LNY
 T2RRtKjCJ6e5aupTX47AJsGaos1/0tIpFTImVkAFdsE/zemNsi1Ov4WVZ0aGqIEFWZ3a
 zClEU87NP8J4V1Nk47DZBNiW5meRm2ZYaI9aSBIj8mPHGYdW1z4zEAlsjp2W5WVZIKSg
 CgeSB2z7jKA2YboVHEfvDCHTEe0ZePLKhcWbd/30AbQeWVQfq/NIjXo+60pr3dVHdF5t
 JrBN+Pi2dvge1lwRMSAP78XWuWL8gsvym5xmb8/NLzO32DIe7D5bkcjOWkIdEg57z4Bu
 EaKA==
X-Gm-Message-State: APuU4Z+SGW2qrdTkzlPOyRi2I9JW5oYq3kc+4KUDaG9MhipVi0VwfwM9
 Mu+gNtCks5eJacAftTTJlXZrEsPbpox+lnh89Pl8LLWBkdMSSKFQuYgvgDsbampC+YU=
X-Gm-Gg: AYBFou1dhfMfqhRDTSOXMeCL+qUZM6EDw2UwLeVG7VDg92ucwcWLfmM+kh9mI+I4DZv
 Bs3sm4LS8FzEUBIXG4uC3RYC4VonwcfYHT000ithU8ePHKvdU2DBDgBGHd8lNlac90Rbepe+1dF
 NO3dC0HTDw8/b5lPe2XtEwLzcXyepqVWUnPZdbJw8bsAQJWj1iwd6ldjTDD3R4j/jXOjn53WcUL
 4Qq81sAZXz+CKMIwdQI2sWvWlQ75Nbco5aG5Uqn/cSOmbNkmw1Bh0GGMjulIMgM6wwCBSVfUNnx
 gtCWnamnx2ahuFJpHikNnvIGbGMzKQcEdLeNQ3lOFbKJtZM/vryUVOzteAygTxTVKqTldliGFi4
 pliOMzLTj09Cx6MuU/fyogs0LQBL+bBxf/jnwMrQfbnxVxA+ybUlD+7WD9Y1auGaccf/kWL4k+C
 QRjjBicSEAy5zjiD5uHtlKlpcskqRaYeCMkCQlolZRX0NS+/x2vqjBV4Wz7VwMaB6Q7kAqc54Z2
 8/dSlx532BRR8bX7r4ukwqPYJmL22YjCBLByxhRcQsc8bMwMKhvvBMmMd46r4Q06Rq9929C8OE/
 1i3WYzHwuZ6pFQGeT/RjK1L8g2/advvL2YLfpfjbyV5nWuuG6eHPSainZruM4LGJ7akPhBzTj58
 usN120Dk=
X-Received: by 2002:a17:90b:534b:b0:3ab:4f1:4f76 with SMTP id
 98e67ed59e1d1-3ae898127f4mr16026476a91.24.1793869077290; 
 Thu, 05 Nov 2026 00:57:57 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3265a52sm2713011a91.10.2026.11.05.00.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:56 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:45 +0800
Subject: [PATCH 09/19] tests/qtest: ds1338: cover the reserved bits of the
 time registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-9-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=2167;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=suWA8DePj/ePX9LP9LtQ2tCEt/OdWCTqNVEUhuz1G58=;
 b=T8h1VbWrZkrWJgUBcgqWfj6DA4QX3w+5EyDFK5X/4wSt0ooMApSn/C3NHq4HJJ/mkOVRkX9iS
 8D6M+RbZ7MIA3+zUUiATwwC6oBLhoSyj4iMQm9dUfo6d6IM8/aDRO8Y
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f46.google.com
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

Nothing pinned which bits of a time register survive a write.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1338-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index 1b9c02d931..9e2e257307 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -125,6 +125,26 @@ static void test_clock_halt(void *obj, void *data, QGuestAllocator *alloc)
                     ==, DS1338_CTRL_OSF);
 }
 
+/* Reserved time-register bits read back zero even with the clock halted. */
+static void test_stopped_reserved_bits(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    const uint8_t all_ones[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+    uint8_t resp[7];
+
+    i2c_write_block(i2cdev, DS1338_SECONDS, all_ones, sizeof(all_ones));
+
+    i2c_read_block(i2cdev, DS1338_SECONDS, resp, sizeof(resp));
+    g_assert_cmphex(resp[0], ==, 0xff);   /* the halt bit is writable here */
+    g_assert_cmphex(resp[1], ==, 0x7f);
+    g_assert_cmphex(resp[2], ==, 0x7f);
+    g_assert_cmphex(resp[3], ==, 0x07);
+    g_assert_cmphex(resp[4], ==, 0x3f);
+    g_assert_cmphex(resp[5], ==, 0x1f);   /* no century bit on this part */
+    g_assert_cmphex(resp[6], ==, 0xff);
+}
+
 /* The user RAM returns what the guest wrote to it. */
 static void test_nvram(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -207,6 +227,8 @@ static void ds1338_register_nodes(void)
     qos_add_test("control-register", "ds1338", test_control_register, NULL);
     qos_add_test("osf-write-protect", "ds1338", test_osf_write_protect, NULL);
     qos_add_test("clock-halt", "ds1338", test_clock_halt, NULL);
+    qos_add_test("stopped-reserved-bits", "ds1338",
+                 test_stopped_reserved_bits, NULL);
     qos_add_test("nvram", "ds1338", test_nvram, NULL);
     qos_add_test("address-wrap", "ds1338", test_address_wrap, NULL);
     qos_add_test("reset-clears", "ds1338", test_reset_clears, NULL);

-- 
2.53.0-Meta


