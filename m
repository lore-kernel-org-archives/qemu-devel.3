Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD4606A32E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtol-0005cB-Sh; Thu, 05 Nov 2026 04:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtog-0005Wa-VD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:33 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtof-0007Pn-8v
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:31:30 -0500
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso9292895ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793871088; x=1794475888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TAKWq5OaS0dmrW3Pgr9SxuBdpwdzx7tYDqztdgweZoA=;
 b=v4qZpVGGePWQz2GgVM/UIN6qiNRESXSoUOn6k5Y6lp1tYXg4iK+K2SNwrAWYLAPnH1
 OgYXCkqMq0pKHImetOy1Sw0FFcbOFHfqcGFpfNr53trotLRXAZ78MJJ8yDGSX0rNE4Or
 9P6pYXdARhDrxecP9H8OY7vxMXCY9mMQI+EKo5fMuH2WMu7MceCP0IVqDk6K+xmK7+wP
 XJBjj/GOaL9O7rzViE04SnykWMq+IOhRs7uqiXYDyC0AOhbfbI6HSIb9vJgxCUc0nr8l
 y6WRSL8QkHBJPVt/I4TbeU7kZzOE6mbLvYOwxEVDrLC1npEQ3rIi6pncF9iwAHT1h9yP
 XghA==
X-Gm-Message-State: APuU4Z8bbRZW64V3+WJM7sY2NWHJoJ2dUwKVJ/BS2utLHq6OvUj6T7C7
 winf9Of3rCEEZrqjK7XNc1LpXw8bbFtWiapG39j/ifIMLG78tH4StHD6uUCh0tBHPzY=
X-Gm-Gg: AYBFou1ag/NiqJ/eSp8HfCQ/r1INDZoSyvDCnVJJPMau0G+xsBqkKDX+awqAhyahqCA
 KrYV6Fl9My4Cg0DProfdQForIO3C1cAtnXQuXK9OBQMd8INbsrY2j1OQSCUGcM2HqxuGGfVDhh7
 NexCh1cmlzvciyIklJqss6Dp11UabHuCEG4fl7QcAsEHJOKlKbkagyNbCGwWttt4Cy5+SI2efN5
 9tI2nkbnr0E4ycMl2jdZqcbm4g+jGh+Ksz864shZqgea/BlatbNQhAMZ/MkMW9FIomyu7ZiHbl4
 C6R7IAEMDeSOFOjkPgkjt6ACenNh0tqoZ4LzWKxj/WKfrQ3XanCwksQbxpnXV9LTacvaS2q+EQD
 U/gwmPq8+3qc56zaDckcaA4vJQfFIE/4evQbGaeYbvY6EgIYLvVwWDuaAVAXdO7YlsLrOVjDaL1
 6FZFGjFI505DwerXxZkkr/8dvcQwH4dM3V4CxTiFdHyulYUrUTmLqHHtWhnLV5LIT5Uet1UMoXI
 ScFIylEE++dkFNWaWf3b7umpggfHDHLhW46Vxz39h76EIakwJ+vLCT/SEbNQAw398CH2K2WS5Yx
 OW95IvxNgcuQrLQwuD4b2tyOOGh6O5iA6pfhNnJ8o38gHiUqrdXwFOuKNYbMd8WomQSdV2qQN8m
 2
X-Received: by 2002:a17:903:948:b0:2e9:9522:ed3a with SMTP id
 d9443c01a7336-2eb364b8b8dmr178185975ad.22.1793871087773; 
 Thu, 05 Nov 2026 01:31:27 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08fe55c8sm15655765ad.14.2026.11.05.01.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:31:27 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:55 +0800
Subject: [PATCH 3/4] tests/qtest: tmp105: cover the TMP1075 config register
 width
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp1075-v1-3-d2ee5da0b880@free.fr>
References: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
In-Reply-To: <20261105-sensor-tmp1075-v1-0-d2ee5da0b880@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870754; l=2217;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=eKNsPNpZHCrr7lt5jUn9ATmHMoMqISDae/0HeUQWVVY=;
 b=dR8imfEXmtt8+y59f3Y23lAukuaxECAb0Vutfo+CUybp6R5jOAk14AX2vDMIHCG8h74Mtahw1
 U4Puadoe6W+AdnX21pSP55MmknXkmqYYo2PeUpKx2MJE6vz47X4/8wi
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.214.179; envelope-from=eblot.ml@gmail.com;
 helo=mail-pl1-f179.google.com
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

Nothing pinned the 16-bit Config register: neither its single-byte
compatibility nor the low byte, which drives nothing but keeps what it
is given.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/tmp105-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 426c4f9ae7..b21deb1128 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -441,6 +441,33 @@ static void test_tmp1075_device_id(void *obj, void *data,
                     TMP1075_DEVICE_ID);
 }
 
+/*
+ * The Config register is 16 bits wide but stays compatible with 8-bit access:
+ * the control bits are the upper byte, the lower byte drives nothing.
+ */
+static void test_tmp1075_config_width(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    /* A single-byte write reaches the control byte and leaves the rest. */
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x60);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x60ff);
+
+    /* A word write keeps both bytes. */
+    i2c_set16(i2cdev, TMP105_REG_CONFIG, 0x6200);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x6200);
+
+    /* The low byte survives a single-byte write to the control byte. */
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_CONFIG), ==, 0x6000);
+
+    /* The one-shot bit always reads back as zero. */
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_OS);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x00);
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -508,5 +535,6 @@ static void tmp105_register_nodes(void)
     qos_node_consumes("tmp1075", "i2c-bus", &tmp1075_opts);
 
     qos_add_test("device-id", "tmp1075", test_tmp1075_device_id, NULL);
+    qos_add_test("config-width", "tmp1075", test_tmp1075_config_width, NULL);
 }
 libqos_init(tmp105_register_nodes);

-- 
2.53.0-Meta


