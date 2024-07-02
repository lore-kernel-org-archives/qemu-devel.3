Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C05C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOktm-0000aW-Bl; Tue, 02 Jul 2024 17:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOktg-0000Yf-13
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:18:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOktc-0006XC-3J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:18:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso41455035e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719955118; x=1720559918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xIdyjds27+SyTMh1g3OjWycS3LrVvlhViH1VPYPMm+g=;
 b=NJyf3LWVXmHpAr/s5U7KsDn44ysGgrpkYzXow+rWucP4RdJm7s8WyUBy5d34qMpxhd
 lpTZd9etYzD+xWbGnVDwqY9R+zRCGD/vj88Y1rp6IlZsx95jnOjxYoUUe1Ap+hEfcTYs
 YZbgY0DfizOFCzsZz6BVZf14BImnbcSf+ZLbXAHzxsAavQEVhZZ9rcwwUjAxTtoUVAbz
 +GA0T4O3b/+J0jcDWXNoHyjAL9pc5W39opix4KB0XBzbZSf+Kj8vqgrVljZ+5IouJNSE
 zeg4/Ji3uSKd3iVbJT711myP7gIQGSfyezZ70I86PRpb3+FK7BCK0ACb3k3kCil7nq0f
 6F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719955118; x=1720559918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIdyjds27+SyTMh1g3OjWycS3LrVvlhViH1VPYPMm+g=;
 b=dCg3zxrIXalAwPZmJ909oTqKe4/66NtI5z711LoS8WBIXQpO2wszg0xDzcEXeKgcOE
 jZ/HQbHloTp1ashcsK8MynRf5wW8HOCvElDHzWqMK6Kps34yEt+RgyxRwwkYY29hn8e3
 3yuxXvBBrItC4mR6LN6KcEJfYrKxtYp1DbITcLFZ+Jx/evj1F8ILc+WvQkDqVwCK0Zgh
 ytntAXc/UFnSGLHDwa4HyxCMjWWVHE05LIemwvwd6MnQ0aW4tobIdDAPG1rfPwyKNZA3
 IAxuUV5BobMnGYdsYhQ/uzcIizSzrd6eMssVMF8LIceImxM40f4lW9700zitCYtYH7P2
 u/bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Y4k1LXzuwnq5Y0Pxdbn0+7rCDguaZh3f+ZXCURlqLngY24glOVA86LBEjDnmkEX3ONgCeUyziS5YiW90d47t8b0KZTg=
X-Gm-Message-State: AOJu0Yw7bpWKZN2z3+yssE75MIgdAYGA6eKTGNCK1yh2fIbSh/3kgW4k
 gKILta3hFIgjzpBmqnWIEsDz4JG6vspRH5FTINH5Srogr8MOCLM87XgJrVg=
X-Google-Smtp-Source: AGHT+IHlIDlUCjJp+I9Wwj+wno+EER4Y13+Ov6M/aZ1UvOiRdolVqwblsMi/isRvNagUuu5rXqIEvg==
X-Received: by 2002:a5d:64cf:0:b0:366:eb45:6d54 with SMTP id
 ffacd0b85a97d-3677572484bmr8813337f8f.48.1719955118138; 
 Tue, 02 Jul 2024 14:18:38 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a23b349sm2393783f8f.36.2024.07.02.14.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:18:37 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Date: Tue,  2 Jul 2024 23:18:35 +0200
Message-Id: <20240702211835.3064505-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x32d.google.com
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

Currently, if the function fails during the key_len check, the op_code
does not have a proper value, causing virtio_crypto_free_create_session_req
not to free the memory correctly, leading to a memory leak.

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
Changes in v3:
- Refine the commit log
Changes in v2:
- Fix the whitespace in title

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


