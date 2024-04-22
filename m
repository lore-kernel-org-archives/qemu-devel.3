Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62BCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 04:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rylQ6-0001AF-MK; Mon, 22 Apr 2024 00:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rylQ3-00018u-Ht; Mon, 22 Apr 2024 00:36:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rylQ1-0000LW-M6; Mon, 22 Apr 2024 00:36:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e2c725e234so37441275ad.1; 
 Sun, 21 Apr 2024 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713760598; x=1714365398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n3at13TXv9A0AngjciclfQQPdiYQczLuI2wXF5rISsg=;
 b=XgJGAXyK1BYq4NxYIQLRF3yThzuvPV9M5Zn0If5gchQbJehDpDmsd4aYqWw6jYsMlu
 +1XurwaRoznxxwRnE64BerhLNU6dy1I4hOPV5A5p0Fs8L2cN/zXKnmV5OePlG4MF6/fU
 GOawFyp1h+ykNaZgxfZxt4Cpth6B3GZBS07yG04Bo/58i4aqMvuc3G6fiehAhcksDI0/
 q3TEV9X8MLzjQ1sUH+tN8B/aYDci6tLNxNC5NKKjfJwdf/vy5vduNwbxb/kZ7TzcYZUw
 /l8Eb0CyWWRjcpUo1OObEPeyFwO+HRe3DE9alz/Z+yGPpRvgE5F6ifl/7FJdGPcZ90gV
 ufRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713760598; x=1714365398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3at13TXv9A0AngjciclfQQPdiYQczLuI2wXF5rISsg=;
 b=kzOSFmBNIQ7TJXP19FG6tiRP2rFtO5MwKdNc8r2UaOkbI7WAIedtIt36Cgd5NRJn0B
 y901Trx0IUyT2PEwVCCnnkt+KiOaDgrkGbWd7Fl/uDyX6wLXLQba6/TQyGfHAUfki+bq
 pk3/9AUwvaypDVsA0ODkO0gs+CIhR5YUOlK0vAvOrce4fK7Iy5jm358ptuk4W7KymnqI
 eDb2MM8VDnZAPqYbG2i/j6KF2bAMuAXbUifgQeZR6q577y2IfYa7MEjYdwfNFn8GIqxs
 3hj25gRot8ztt/8c+pGzSTfaDZ8ySxy2DTPpIWtv8Z25gUbZig4qD3QCTikU68MqFLIT
 tpBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdmlSFMCiI0I+zt1aSRN7tygzq1H3o9Cs2mZXLN8buRpTnyUfoB4ay7Aok37v+sJxJmHiQBQfknorsAdulE8DnAKNHES8=
X-Gm-Message-State: AOJu0YxLIdl3hYdEWK9uyGtnaP3gIjJoSC9gIBvxKLLFbkteASA8aakY
 /eAk00PzIJhRgZZxhDmfk8zgnChXq3tvrmc5XYccjl8XoWIJwBtd/xjO0g==
X-Google-Smtp-Source: AGHT+IFzOJ0XRoT7iOsrUK4TIwL46L5ayg/OM2fxzrd6KiAYz7U2KD7sLRHiDznoG/WDhJPfH17Rnw==
X-Received: by 2002:a17:902:ec84:b0:1e2:bdef:3971 with SMTP id
 x4-20020a170902ec8400b001e2bdef3971mr17437431plg.16.1713760598611; 
 Sun, 21 Apr 2024 21:36:38 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170903235100b001dddcfca329sm7066777plh.148.2024.04.21.21.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 21:36:38 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, jeuk20.kim@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, mcascell@redhat.com,
 zheyuma97@gmail.com, j-young.choi@samsung.com
Subject: [PATCH] hw/ufs: Fix buffer overflow bug
Date: Mon, 22 Apr 2024 13:36:30 +0900
Message-Id: <c136fd237c253393a658dab51cd4904e4ceccddd.1713759623.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

It fixes the buffer overflow vulnerability in the ufs device.
The bug was detected by sanitizers.

You can reproduce it by:

cat << EOF |\
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
outl 0xcf8 0x80000810
outl 0xcfc 0xe0000000
outl 0xcf8 0x80000804
outw 0xcfc 0x06
write 0xe0000058 0x1 0xa7
write 0xa 0x1 0x50
EOF

Resolves: #2299
Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index eccdb852a0..bac78a32bb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -126,6 +126,10 @@ static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
     copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
                 data_segment_length;
 
+    if (copy_size > sizeof(req->req_upiu)) {
+        copy_size = sizeof(req->req_upiu);
+    }
+
     ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
@@ -225,6 +229,10 @@ static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
         copy_size = rsp_upiu_byte_len;
     }
 
+    if (copy_size > sizeof(req->rsp_upiu)) {
+        copy_size = sizeof(req->rsp_upiu);
+    }
+
     ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
-- 
2.34.1


