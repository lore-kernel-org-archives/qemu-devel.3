Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F4DFED2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xj4-0004Wr-4b; Thu, 12 Mar 2026 00:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xj2-0004WY-KI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xiz-0004HS-Hj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ab232cc803so3205205ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289959; x=1773894759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHbr4hEjoQMVlYqOZABZzmZC8L2t+s/8o2sZGPYPLgA=;
 b=Zv0LoBpFe4D6cwTXQBISwDJWLG+AxuThf5nbn1HKRSLDf0Eile63U+CwVvRl08P5Oj
 22QAqZhigoMTMOXKr4DebjbYvS/ZuAb1kEgcefOBtR0Ian83YLsXZFxR1KRTGp687y2Y
 2vC/Wlq170ktu9r9+hGknYWS796CRHn0WH5OGZ2s8NDHud50NBPOxcGOkuGBTUKkGHi+
 8V5ZS4EsN+H+K6OC2YuNwE/LdhIXBXc8I9CtGFO3cK+x5PgZ0kUdzxxZswwGeNsNq5dp
 DyBwT88W7XjC/WC2ewFurUjGQ7i+C5GEOGDy08S1qWdKfzZu3puVQh4QRJMJtY3pimU/
 IBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289959; x=1773894759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cHbr4hEjoQMVlYqOZABZzmZC8L2t+s/8o2sZGPYPLgA=;
 b=SfStFUIeBOzgY2cIoUxEwUroID4rn0kpvPSDAWDFdgF9DeEnBvbVvbfS/5a0Jrz7Fy
 MhFpVyhzido2LuHf3hLp+qhabZ/9VoeA2FS7SyQGjPzoe9Ax1MSYrWU+aDZLfj8w9hve
 F7TrSzND7vda2ZjRtz3kCv39iJh4Ygafd4O+HeROI2LvltT43eK2Bcv/e3WlVn6BwvAq
 4w+n06XsXc28d17OnemMaYmj0VfSXSW5W5dx6okQn8TtptLFSxEagjQj8W+iSq55gjm4
 cArlgBJaAsWG3fylZOdQGVaqCbPZF9EqST5URbfq2a0CiGE3h+aGY4wB86OCpDiH+SnI
 MEbw==
X-Gm-Message-State: AOJu0YzycFJ6PGZ7MfprColBIoSCMiNwG/m1CQIYPV4ui+z1GykoF7xV
 OCx2YNPc1NCyhvPyBpyapAq0O+EPwuTsv4b6KEQQTzgkgnON42aWAS1xoe7s9SHh
X-Gm-Gg: ATEYQzxoJXv7DCkMOyDlpOaPUdavmYZneBaVKEOJ3fgHnP93Eg6SpmBTrkKufmUyLU5
 VQnWPVBnYbvQH+ILVlF090vQaLeVLCOtIJ5jlww5fj4imSCp0wZh2CvtgnTB1PAjL47wgxenRRg
 5FdE8fkV8M9RqIv2mFcRIT3NkiaC+1v5W/FiTDV9swMej4TR3yMQ1BNcnBsmOR528/g3K0uCab4
 B562mtHzcdUyaLF6itubVNM9bdXcjkvrW5aJDkMQFu6buxKy7w+NxXi88D8w5xpyUMiwj+jV4HE
 naqbxN/WkIeRkaRpH9CCZRYTPY8QM01SctLDG5NNg3HElA59A9PW6zaAqii0UKeTKeXfx/Ayt7Q
 WYLbeZbCi+KVmn/ciZuqaQRgzfjJ9J9zleEaj5OUGl+nLPNdjWtK2ViemTP6xXuD3DMp9BK5xD8
 SOxcgypPMIpk1Y3bd1eeKbb7hcrXwtCwIZgZLE9s4oEg==
X-Received: by 2002:a17:903:2a88:b0:2ae:7f70:b2aa with SMTP id
 d9443c01a7336-2aeae892fadmr55570035ad.29.1773289959242; 
 Wed, 11 Mar 2026 21:32:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 7/7] hw/acpi: generic_event_device: Don't call
 qdev_get_machine in soc init
Date: Thu, 12 Mar 2026 14:31:58 +1000
Message-ID: <20260312043158.4191378-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the ram slots of the machine. So instead of initialising the GED in
the init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/generic_event_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 30dab43a00..9e9416d406 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -506,6 +506,9 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
     uint32_t ged_events;
     int i;
 
+    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
+                             &s->memhp_state, 0);
+
     if (pcihp_state->use_acpi_hotplug_bridge) {
         s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
     }
@@ -568,8 +571,6 @@ static void acpi_ged_initfn(Object *obj)
     memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
                        MEMORY_HOTPLUG_IO_LEN);
     sysbus_init_mmio(sbd, &s->container_memhp);
-    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
-                             &s->memhp_state, 0);
 
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
-- 
2.53.0


