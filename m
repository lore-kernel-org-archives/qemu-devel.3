Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76FCC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOmgo-0004Fg-Mf; Tue, 02 Jul 2024 19:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOmgn-0004Ee-9H; Tue, 02 Jul 2024 19:13:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOmgj-0004Yr-LX; Tue, 02 Jul 2024 19:13:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso34330535e9.2; 
 Tue, 02 Jul 2024 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719962008; x=1720566808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xHkUt+eV1l1vcITX4D9Ydky+EZIHXltfyBlVfjJmleE=;
 b=ZurYSll86zmnwmSfBA3dn0Vgxgg/3mrx3b43iJ6JCwuAiDIyf1JnPi9d+NaRFRVkBS
 aZOHaDSc+0F8TG1ydL1X8PVn5TK2CM5XZ18Yaf3Tf8IxFnC3GnvNkwjVb1PZjmd0nndG
 aCb50M1nj8ulCuZUKtFt6qhIHnWspeYejqPx+ucUy5d0Okq1hKyHK6TsQHtTFK53DVG7
 TtnKBt7WZjpw8JN/38Hk3mOmXt7lvrA9gFu5nl31jLzs1O6Kxb4NXr5c2T6I3R+JHwcd
 /BvlxdQ3qiFXhkyvNe4IIEQufL5NJ5mAMR8bkAf2KvX+Ij9PCnggUMO4mtfhLXYNJPri
 yqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719962008; x=1720566808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHkUt+eV1l1vcITX4D9Ydky+EZIHXltfyBlVfjJmleE=;
 b=GmTThs6jAJvhoJ8hDNETs8L0tkvYFQONnsYc6JISghmf6OZkm312p8PidKsU345H9K
 39LF5GfKvTiq0vyBPyWDe3XUCpM44Om0ldgFvaqi7JPjUKeskJusDgsfN6Y1bqr6B4Dd
 v7aTam4K/E4OrEK05rcK8RmypXKWejHuRGv5pwxjHMsfCLZs/s/GbFnCnZUMWnCpJd9s
 LY/AAJ5yHaGOQDw5ibGLpz1ZDtgzSXf3tzaAZkJrgkLCVi+rBF6pvETXWxQWshUeD108
 7eyv6GRde9Yuw58+8bLq9EnIH9NYh2WbdeopGcTRtc8S5rLXh72P7xuGaQagN7biP/gl
 5WkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjSEYJmtGHXGjS+AXepGwtpMiy0H2FYpH/RPNYoiZlihOgFVyTxfbIcJbX+ik9cH36kpSQdjOsn+buhxdA8wQk98ALCoEdEHQqNUT5GERD9pC15llJkQ+ZXq1wTg==
X-Gm-Message-State: AOJu0YygYMp8brp5JptO2WuOjLxGzfL7Fi7RMdzC96v5AX+EavVflSgg
 Ae98888nPvNch/g8UudWE3Xg4WvJqKvnv0Fl+wQ6gqWAOwOMBMA=
X-Google-Smtp-Source: AGHT+IGtFVRHmAqvedEr19BSPe093sL6u3BELbRkEnCM0ScA4c1ZDPrgFkJIiz8RwNtW0IGfGfUjKg==
X-Received: by 2002:a05:600c:2157:b0:425:3084:c99 with SMTP id
 5b1f17b1804b1-4257a0642ecmr72431645e9.31.1719962007498; 
 Tue, 02 Jul 2024 16:13:27 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f99sm219690105e9.41.2024.07.02.16.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:13:27 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/nvme: Fix memory leak in nvme_dsm
Date: Wed,  3 Jul 2024 01:13:03 +0200
Message-Id: <20240702231303.3077584-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x32b.google.com
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

The allocated memory to hold LBA ranges leaks in the nvme_dsm function. This
happens because the allocated memory for iocb->range is not freed in all
error handling paths.

Fix this by adding a free to ensure that the allocated memory is properly freed.

ASAN log:
==3075137==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 480 byte(s) in 6 object(s) allocated from:
    #0 0x55f1f8a0eddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7f531e0f6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x55f1faf1f091 in blk_aio_get block/block-backend.c:2583:12
    #3 0x55f1f945c74b in nvme_dsm hw/nvme/ctrl.c:2609:30
    #4 0x55f1f945831b in nvme_io_cmd hw/nvme/ctrl.c:4470:16
    #5 0x55f1f94561b7 in nvme_process_sq hw/nvme/ctrl.c:7039:29

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..cf610eab21 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2592,6 +2592,7 @@ next:
 done:
     iocb->aiocb = NULL;
     iocb->common.cb(iocb->common.opaque, iocb->ret);
+    g_free(iocb->range);
     qemu_aio_unref(iocb);
 }
 
-- 
2.34.1


