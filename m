Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FAC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkej-00081t-MW; Tue, 02 Jul 2024 17:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkee-000804-OF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:03:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOked-0007Hw-5I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:03:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so3215910f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719954189; x=1720558989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eT3tfvANiBCnVaEI91vYtDYUp3ZwZaFuJlrs2Y7RAys=;
 b=U9Tg+RwAwUCRkpOguxu4HRefefkBRKKUrupZJbpmdL618FxvRZ7yD/VOou/CQLyN9a
 rdq6xfG1Ap0noa6qODNSXlNu8cBvA1ZKJ5Gz0sawTeQIzQd65U24MrCpJsuAURjUeOqc
 fEgNa9tpm206j2r1xxoF8p3oLpwjah0AmYB0so3WmTXe1nmKyO2x4F9rM/4rWuzLCMSV
 VFGGxow6Koa1JrPItMANpbAGKo05YTm2DMo5wdM1VbFgn88eDt+mA0I54cqqRVAxaZ0u
 yQg0YGhVrOdaGIhYQGq8HWcO/UVCvaMYEEqiu0SfZXZDBxlqQSeMsmo8EKwAGLM9Gyo3
 uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719954189; x=1720558989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eT3tfvANiBCnVaEI91vYtDYUp3ZwZaFuJlrs2Y7RAys=;
 b=EwqEZI2K5zf6CCA3NWPHqAjBKk5WSISQoIHgiEeLXBdgCdztj4NT17s7mG000/HQzD
 iCfX4N8Zwb8eScuqEAWD6ttQrCM601p1X96eK3NYPQMk6Crum0paKJ5/hhwJ5d2L0Qma
 e6lcu8XquCNXzMB+XPlIToW3gzkP155xIAxX1oY21erfAJa1NYnxq/AayrQqtjo//Dw+
 cSwBK7SJBM+j5ZDDMo6CxTbirkJsPBA7ImD/BlOHUn7Bo88U3vrhPCn/BVZITlzPldtG
 msOq+SPBHjC30NxF/WkR9RafLd+ORspfR3hfsvYXjgtcJxpGHvzEI+++/vtQQDQ06Jqe
 oCZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6g9HHUULSunCUeBrwvLG0uUs4adr70LsKDoJThgQUITFLGjz/WDLeyUf1Q01Wt974AZ3gKI0cSedeyJLkIpvIZ0ukCQ8=
X-Gm-Message-State: AOJu0Yw33IPRHLOzFVS4TTSy0cvEC8pxsGYx3skScMj0ZJYb8JfiC2qm
 7qjt1Ud0Lte072SxAg3G0XsmSemSmTL6O3RtCRnEwG9I/B/IFY4=
X-Google-Smtp-Source: AGHT+IEToIuyzV4vlj7y/8IWjbc1L9c4SBlJnyBz7Hb55nRAtCUx++7N6TfgnBP2JkvgAyEDHG6z0g==
X-Received: by 2002:adf:f510:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-367756aade1mr6411680f8f.23.1719954188339; 
 Tue, 02 Jul 2024 14:03:08 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678fefc01dsm910313f8f.26.2024.07.02.14.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:03:07 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Date: Tue,  2 Jul 2024 23:02:27 +0200
Message-Id: <20240702210227.3059947-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=zheyuma97@gmail.com; helo=mail-wr1-x430.google.com
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

The assignment of the op_code in the virtio_crypto_create_asym_session
function was moved before its usage to ensure it is correctly set.
Previously, if the function failed during the key_len check, the op_code
did not have a proper value, causing virtio_crypto_free_create_session_req
to not free the memory correctly, leading to a memory leak.

By setting the op_code before performing any checks, we ensure that
virtio_crypto_free_create_session_req has the correct context to
perform cleanup operations properly, thus preventing memory leaks.

ASAN log:
==3055068==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 512 byte(s) in 1 object(s) allocated from:
    #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
    #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
    #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index bbe8aa4b99..5034768bff 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
     int queue_index;
     uint32_t algo, keytype, keylen;
 
+    sreq->info.op_code = opcode;
     algo = ldl_le_p(&sess_req->para.algo);
     keytype = ldl_le_p(&sess_req->para.keytype);
     keylen = ldl_le_p(&sess_req->para.keylen);
@@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         iov_discard_front(&iov, &out_num, keylen);
     }
 
-    sreq->info.op_code = opcode;
     asym_info = &sreq->info.u.asym_sess_info;
     asym_info->algo = algo;
     asym_info->keytype = keytype;
-- 
2.34.1


