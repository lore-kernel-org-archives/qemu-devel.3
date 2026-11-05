Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62618606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtIs-0004sD-OM; Thu, 05 Nov 2026 03:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIn-0004iF-Vp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:35 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtIl-0003nb-JC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:58:33 -0500
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso714250a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869108; x=1794473908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=56pPJS+C8la1MYmTdNNflpT7tU5QoCQdslzftdKxEFk=;
 b=L2/XRHaaKAF9E56NhgtfsZJoBpHUHWs4huDVLDPi+NnIBLdLKfyx9/EOPD4BRM7f3p
 LX1iVYr5f8Rr9ZUgx1vc2oXpPsj6dxwy5Qaq+6La7gJ7OOGF9iJcUI2pP0tryBEUVyXK
 9ws2Zq3L8rRUdn/FJZCoNBIUSbMWz47OBAv6AF8naKCaQJBebFUn3cFGBuVburbVF6o+
 IXEhs6KGSpRrfHQzjZtYadpLPxnJELOMX2mGgRNnxgCKanqW/zjZoG0E1Vx3QQuUn3c+
 TQFkuo9KaGOc2ziMAmgQNqlsJBGx92bi4oP42yOcZFPCxv+Ze/wItF71VVD6izvtYPMh
 Cw6g==
X-Gm-Message-State: APuU4Z/5BnhN9PlnG/fimu+aLGdABwbEWVHNKARXK9ErSqGqvAkJEsAq
 enPX5OK0hT7YgzZOCdLYV4kv4pgfA5N7H/DPQKwUBtDyh0dkXL/JCWwTpPOPrz5zSRE=
X-Gm-Gg: AYBFou2LDPet9nHE5oTxroqa1TYOxO2l/mJBP6Vxg87o6aMHJ0bzocXhaKCnYApFNHr
 0XjRj8mXgw3T2/H2VCx2UgDPvx5Q9D63MTKJgMqPz6bE7N2iWvmOnjpj4BeTdiJUUoaIOPdetJ8
 RmXAIKfTOGXdPzRGxUIB8UdbORV/gzn6agnUBzrcRzdjpKrACKFWUhfqjlniro+UASwH+lTiCtu
 dGLSMfg16Espo9PUDl9iV9CXcUHNRj95haUPD0PZPW3KuWoEcAHiFPJo+aJHhy4MkoyhBuOfG5H
 S6k97jsZMx799Z0cW1aBbpABI2M840iCT2piCJs8DbNDbx9OkDFkZmHSf6YSsQYiWKHPEt2JPF/
 aMz2lpCD3RcjCmgj1D646VnHI2cgRCsMJQQhQDW0v30umzPZrl/6EmNbjIBRlGuRCdynhTN6iFP
 KYUpJqV12uAhoMHeMX3Zs1e2Z+OUJI8E7n1paoPOzf+2Kqv31JJQEauxIiJaeIzKHEHeMSva5Nv
 ZWxKxmTjidkJ6nImNqL1u0YaDwYcWIrN3gtO/nsAibvKfdqM/0TCikDkxU6GcJDLQSmMv4gVqPC
 GAKrycXzYd4OIuRVUAzf9TOJdcsuiWuCEp2afsjxDrZxbyMDRYrNrxNtrApA0PrY7Izn39izWhX
 ZRkkRN9wyL+eyL4GmpEdA+KvjNgE=
X-Received: by 2002:a17:90b:164c:b0:3b0:9a1b:b709 with SMTP id
 98e67ed59e1d1-3b09a1bb873mr4311055a91.54.1793869108187; 
 Thu, 05 Nov 2026 00:58:28 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46998fe1sm1910261a12.27.2026.11.05.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:58:27 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:49 +0800
Subject: [PATCH 13/19] tests/qtest: ds1339: cover oscillator stop/restart
 and time programming
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-13-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868640; l=3347;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=/xAI0glxvoShi8yf2NDQf97RUj4tlRYLrP33FMRgSlE=;
 b=n9eMy+ZaO2gYL3OP60BHI5X6b0Dl3KrUmmhCNzzl/ZLZurzBFl8bXhM3E+C+fz/PHdjGCKxZq
 gMoGeNZ6cKEAi8AEU8gFbbC1+5/Elj6ZcLY6/gxPq+clt3+sgYozA5j
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.216.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-pj1-f44.google.com
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

Stopping and restarting the oscillator had no coverage, nor did the
time the clock resumes from.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/ds1339-test.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/qtest/ds1339-test.c b/tests/qtest/ds1339-test.c
index e9dcdc36da..ac19ebd71d 100644
--- a/tests/qtest/ds1339-test.c
+++ b/tests/qtest/ds1339-test.c
@@ -121,6 +121,54 @@ static void test_stopped_reserved_bits(void *obj, void *data,
     g_assert_cmphex(resp[6], ==, 0xff);
 }
 
+/* Setting EOSC stops the oscillator and sets OSF; OSF outlives the restart. */
+static void test_eosc(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF,
+                    ==, DS1339_STATUS_OSF);
+    i2c_set8(i2cdev, DS1339_STATUS, 0x00);
+    g_assert_cmphex(i2c_get8(i2cdev, DS1339_STATUS) & DS1339_STATUS_OSF, ==, 0);
+}
+
+/* A stopped clock resumes from the time it was programmed with. */
+static void test_eosc_restart(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    /* 10:20:30 on the 12th of July 2031, the day counter reading 2. */
+    const uint8_t tod[7] = { 0x30, 0x20, 0x10, 0x02, 0x12, 0x07, 0x31 };
+    uint8_t resp[7];
+    unsigned idx;
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18 | 0x80);
+    i2c_write_block(i2cdev, DS1339_SECONDS, tod, sizeof(tod));
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpmem(resp, sizeof(resp), tod, sizeof(tod));
+
+    i2c_set8(i2cdev, DS1339_CONTROL, 0x18);
+    /* The seconds counter steps within a second of the restart. */
+    for (idx = 0; idx < 15 && i2c_get8(i2cdev, DS1339_SECONDS) == 0x30; idx++) {
+        g_usleep(100 * 1000);
+    }
+
+    i2c_read_block(i2cdev, DS1339_SECONDS, resp, sizeof(resp));
+    g_assert_cmpuint(from_bcd(resp[0]), >, 30);
+    g_assert_cmphex(resp[2], ==, 0x10);
+    g_assert_cmphex(resp[4], ==, 0x12);
+    g_assert_cmphex(resp[5] & 0x1f, ==, 0x07);
+    g_assert_cmphex(resp[6], ==, 0x31);
+}
+
 /* The register pointer wraps at the end of the map. */
 static void test_address_wrap(void *obj, void *data, QGuestAllocator *alloc)
 {
@@ -206,6 +254,8 @@ static void ds1339_register_nodes(void)
     qos_add_test("control-register", "ds1339", test_control_register, NULL);
     qos_add_test("status-register", "ds1339", test_status_register, NULL);
     qos_add_test("osf-write-protect", "ds1339", test_osf_write_protect, NULL);
+    qos_add_test("eosc", "ds1339", test_eosc, NULL);
+    qos_add_test("eosc-restart", "ds1339", test_eosc_restart, NULL);
     qos_add_test("stopped-reserved-bits", "ds1339",
                  test_stopped_reserved_bits, NULL);
     qos_add_test("address-wrap", "ds1339", test_address_wrap, NULL);

-- 
2.53.0-Meta


