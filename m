Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC0C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDT3-0007Di-OH; Wed, 29 Jul 2026 19:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3H4lqagYKCjYlalmkjYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--titusr.bounces.google.com>)
 id 1wpDT1-0007Bf-Gw
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:39 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3H4lqagYKCjYlalmkjYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--titusr.bounces.google.com>)
 id 1wpDSz-0007JZ-Tp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:39 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso1158863a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366816; x=1785971616; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/xteIKdxXDxQ8Aqr01sR3LS+skiTi1bfiq4aNzEz6EU=;
 b=fI4M+AzZSYWOzcQ37Y7SKSF+Berf/yd0lXubNycgM4tzYB0VvspwFZusZXUhrBG0rD
 Ke1wNLrbaoX9F/BNDogc9qq0uZWkj1MOrMWnjH1MVkxz+cRLj7m8vJA0D67Fz1S9wCxc
 ZVlFUrzI/a8j8QXwbW9LNEbXX5YRhv9r5gouzI1v6NTahhwSfRSW0ojFH3HsoeVbwTLn
 1BPDTT7LBsc2GH3XD6HCBzdWwSjX908ZpclH4LZUu+AyBee3zR5hP7i7yODllXdMNHNB
 /XDW1iORt9OpuH2IiesbaGsokc+lZb06ApoSjq2AcTRDdMAIdsP8DArYwYJSgHCsrwuy
 Qkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366816; x=1785971616;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/xteIKdxXDxQ8Aqr01sR3LS+skiTi1bfiq4aNzEz6EU=;
 b=R4Uao/pB0b1EHxwLrzgzkFtYATaS8/E9F5uLMCmcXiYFWr63VaQua3waV9aRGi7kC8
 IaQOT6zaAgW9WjC80WowX3zsuDkuid9+xIlngrlWCq4ebl+VPMFu2FmCN9tGEco74oxy
 Tj3/DFHjMnHNfsws4JjFU35Li91UFG7gTzD+z7/KJsfSvaooIBuBFE3EhTciNoeFlLmo
 74Z4qsA1sLMpZVh+ivIKqjf9vCtaZ8gcBMMaiVYCjEeEUsUn+cobVqJS6K6XcZx7amHn
 sY4G53NRX9/dDSv6IptXJcdhVifWuKx3G8yIQqqo/5uGWoTbfVsHK/u3KhbigB7fpUXh
 VqUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquxRruUHOGT8bWnfTeZlTvLvGfBpfqBX+HzQ8cWVGoaKCB3buB/AzADcHy0ryqRpMttlyUA844/xCS@nongnu.org
X-Gm-Message-State: AOJu0YxiOgF/kWUCnR4hVExGldFpib3sLR6Wp2VMY4c8q0qdCODxHQyi
 Gd3nuutakhtFI4yPxc05vuz7u98gpqimy5iQg6+Wy2LvRUW0J3MNNrqcfSp5uShXZvmryTGGmlu
 sBGRWqA==
X-Received: from dled15-n1.prod.google.com
 ([2002:a05:701b:42cf:10b0:13d:21e5:3b5e])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f95:b0:3c2:dcdd:a85a
 with SMTP id adf61e73a8af0-3c900470d00mr95706637.13.1785366815484; Wed, 29
 Jul 2026 16:13:35 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:22 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-8-titusr@google.com>
Subject: [PATCH 7/8] hw/sensor: adm1266: expose vout_mode over QMP
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=3H4lqagYKCjYlalmkjYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--titusr.bounces.google.com;
 helo=mail-pg1-x546.google.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_MILLION=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The vout_mode registers can now be adjusted to allow a wider value range
in read_vout.
vout_mode is per pmbus page, therefore vout_mode[n] will affect
read_vout[n].

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c        |  8 ++++++++
 tests/qtest/adm1266-test.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 80960dc1c4..1464307971 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -271,6 +271,8 @@ static void adm1266_get(Object *obj, Visitor *v, const char *name, void *opaque,
         sscanf(name, "vout[%u]", &index);
         mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
         value = pmbus_linear_mode2milliunits(*(uint16_t *)opaque, mode->exp);
+    } else if (strncmp(name, "vout_mode", 9) == 0) {
+        value = *(uint8_t *)opaque;
     } else {
         value = *(uint16_t *)opaque;
     }
@@ -293,6 +295,8 @@ static void adm1266_set(Object *obj, Visitor *v, const char *name, void *opaque,
         sscanf(name, "vout[%u]", &index);
         mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
         *internal = pmbus_milliunits2linear_mode(value, mode->exp);
+    } else if (strncmp(name, "vout_mode", 9) == 0) {
+        *(uint8_t *)opaque = value;
     } else {
         *internal = value;
     }
@@ -321,6 +325,10 @@ static void adm1266_init(Object *obj)
         object_property_add(obj, "vout[*]", "uint32",
                             adm1266_get,
                             adm1266_set, NULL, &pmdev->pages[i].read_vout);
+
+        object_property_add(obj, "vout_mode[*]", "uint32",
+                            adm1266_get,
+                            adm1266_set, NULL, &pmdev->pages[i].vout_mode);
     }
 }
 
diff --git a/tests/qtest/adm1266-test.c b/tests/qtest/adm1266-test.c
index fd3d8079b6..9cdd206c3f 100644
--- a/tests/qtest/adm1266-test.c
+++ b/tests/qtest/adm1266-test.c
@@ -186,6 +186,40 @@ static void test_vout_mode_exponent(void *obj, void *data,
     }
 }
 
+static void test_vout_mode_qmp(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    uint16_t i2c_value, value, expected;
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    ADM1266VoutMode m;
+    char *path;
+
+    /* set a different exponent per page and a different value */
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        expected = 1000 * (i * 2);
+        m.mode.exp = i - 14;
+        path = g_strdup_printf("vout_mode[%d]", i);
+        qmp_adm1266_set(TEST_ID, path, m.raw);
+        path = g_strdup_printf("vout[%d]", i);
+        qmp_adm1266_set(TEST_ID, path, expected);
+    }
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        i2c_set8(i2cdev, PMBUS_PAGE, i);
+        expected = 1000 * (i * 2);
+        /* check correct value from i2c*/
+        m.raw = i2c_get8(i2cdev, PMBUS_VOUT_MODE);
+        i2c_value = bswap16(i2c_get16(i2cdev, PMBUS_READ_VOUT));
+        i2c_value = adm1266_linear_mode2milliunits(i2c_value, m.mode.exp);
+        g_assert_cmpuint(i2c_value, ==, expected);
+
+        /* check correct value from qmp*/
+        path = g_strdup_printf("vout[%d]", i);
+        value = qmp_adm1266_get(TEST_ID, path);
+        g_assert_cmpuint(value, ==, expected);
+    }
+}
+
 static void test_vout_clamp_to_max(void *obj, void *data,
                                    QGuestAllocator *alloc)
 {
@@ -278,6 +312,7 @@ static void adm1266_register_nodes(void)
                     test_vout_mode_exponent, NULL);
     qos_add_test("test_vout_clamp_to_max", "adm1266",
                     test_vout_clamp_to_max, NULL);
+    qos_add_test("test_vout_mode_qmp", "adm1266", test_vout_mode_qmp, NULL);
 }
 
 libqos_init(adm1266_register_nodes);
-- 
2.55.0.508.g3f0d502094-goog


