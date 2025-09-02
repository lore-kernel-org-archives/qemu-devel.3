Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4551BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnx-0002cb-ER; Tue, 02 Sep 2025 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQns-00024C-JP
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnm-0004bm-SQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3cef6debedcso2433888f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818715; x=1757423515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RM//SOSyMG1jcYS0Uj3ddE2XoaaYiQer2JjB+xASa4s=;
 b=WKaMEc+rS1oYZAR1DxvBsKk22+zk2/CUbnpTEVS+zDP+Dc+VU2DD14xFX8je1vD0zj
 CRy5bVBi+xgh8QSw7D9ekoS+RohQht6b0hjskEUFYdBlWQNar9fnA5DR7rRF6ke45X/w
 T/AOBLyUX48C581b4eYeqOd6sQ3KM6uB69Mu+2U8VwK+b0LqwuRgdbZVNhdEqnFQOb8l
 DGGjwRgBh2JOWRb8Z/AOwfEvpJPJRjEHFReNZKVC5kkDtMKBNUSrFeqfxps6LpGTw39i
 EkgdxYVunbsy5J8UePHNAXc+u6hhNJ7kWSjN/lwl6hn+pFeO++SgRxBz7M0tWIAE5flm
 fESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818715; x=1757423515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RM//SOSyMG1jcYS0Uj3ddE2XoaaYiQer2JjB+xASa4s=;
 b=cw0OQ2Nw0z7sHgspXpB4VC0+n6gQoc2ioTNF6nUy+MXCiLd1jNvZrgF8xF2QIkB01r
 /o0ly6qY0z8169ygUQfxvP5aIc10Xo3eIwDBTu4eEI2WMie2JZpdDc1hGbDhFQo+yAP9
 9HOndSCU/LMeZE0Gy02Qm8lV+vHJ/QzCzLsaGJfuI/JXYaRvyb0xhNyyshF3UqkA++uB
 Id437XEsfOAfCt4425YY8WTl111OUJhWLeTNclXNIoNXLinx2okBzH1ekjomBKJsgQ/P
 18beAtcMywL79Oft8tW4Y9ZN2oxNJ5zCvivyxTodNUkMjQcImqOJ+/3jvh+E1LwlKgWa
 Nk6A==
X-Gm-Message-State: AOJu0YwcK9gAmShdUtHMOV4kPjIZA15o6VmiOPr2RSU2tjR9SaifEY+e
 eDZenTi9ztS7F71tvuTViRw7gyn6IB3ua78M7JjyRfpdwr8CYO6+xoc3YHwcwe8ufvxkpww0fij
 661IN
X-Gm-Gg: ASbGncupN0xwqTYcTiq00LUwu63MGupWx4z4PlI53hREXh5aRNAkPZrePO2vslOlosU
 +JoGkts5eTh8iI5EG0AFOMPm1kuXO+UcIxEz3M08n3aNVSyje/foSpiLfUqqMB2ROG7+UGSU1T2
 YWAxsxnwlZtl3s0iWDcFqEHHXqw3vkzUuvhesvIier2L+xfyAJRiwNeebGmX0L9xfew7FAzbgdf
 CXcV/DRONEu4ZzB5TbzotcROlop/cchPQ9a1KGwK2h9iOnb1rySyvk8kijqZgoOOSoL5PJhSst7
 unkONS9gAIWEPhBcr8dJMUamQxK90I346uf29mDyvJbxfucgSbQC6pxTCrE2F6s3pDnvADc9Blw
 uHcJBcUM322AigMGghfKIRemhQmyj1ajqneGijlFTq6Q7JgGhBFD6aNLfugmQKdNf3/QwoRO0
X-Google-Smtp-Source: AGHT+IGn/QtRcRwvQpS0NGy0xyc9gtUZcOnYBTxRHUQsQ770bbSYnEvCseuTdtlMCTU6VtkpKMhf9A==
X-Received: by 2002:a05:6000:25ca:b0:3cd:93c5:eabc with SMTP id
 ffacd0b85a97d-3d1dcb7627emr7293564f8f.18.1756818715176; 
 Tue, 02 Sep 2025 06:11:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d53fda847dsm10623228f8f.0.2025.09.02.06.11.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/39] hw/char/serial-pci-multi: Use qemu_init_irq_child() to
 avoid leak
Date: Tue,  2 Sep 2025 15:09:58 +0200
Message-ID: <20250902131016.84968-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The serial-pci-multi device initializes an IRQ with qemu_init_irq()
in its instance_init function; however it never calls qemu_free_irq(),
so the init/deinit cycle has a memory leak, which ASAN catches
in the device-introspect-test:

Direct leak of 576 byte(s) in 6 object(s) allocated from:
    #0 0x626306ddade3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qem
u-system-arm+0x21f1de3) (BuildId: 52ece17287eba2d68e5be980e1856cd1f6be932f)
    #1 0x7756ade79b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1
eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x7756ade5b45a in g_hash_table_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a
) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x62630965da37 in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qem
u/build/arm-asan/../../qom/object.c:568:23
    #4 0x62630965d440 in object_initialize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/ar
m-asan/../../qom/object.c:578:5
    #5 0x626309653eeb in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-as
an/../../hw/core/irq.c:48:5
    #6 0x6263072370bb in multi_serial_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/serial-pci-multi.c:183:9

Use the new qemu_init_irq_child() function instead, so that the
IRQ object is automatically unreffed when the serial-pci
device is deinited.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154053.2417090-3-peter.maydell@linaro.org>
[PMD: Use "irq[*]" as child property name]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial-pci-multi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 13df272691a..34f30fb70b8 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -180,7 +180,8 @@ static void multi_serial_init(Object *o)
     size_t i, nports = multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(dev));
 
     for (i = 0; i < nports; i++) {
-        qemu_init_irq(&pms->irqs[i], multi_serial_irq_mux, pms, i);
+        qemu_init_irq_child(o, "irq[*]", &pms->irqs[i],
+                            multi_serial_irq_mux, pms, i);
         object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
     }
 }
-- 
2.51.0


