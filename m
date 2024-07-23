Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDAy-0006Tp-J8; Tue, 23 Jul 2024 06:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDAw-0006Se-Kj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDAv-0001Xi-4s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7lYzPlslzs28OpL2JOdMIA3bwyrM1HvLLKU1gK7kNg=;
 b=XaKpkn8WljIfaB2gHccQ0Vi94TGktq7O6y5w8kx+0f3fI0ilQ8ayNCkIIKBtQrOMqBUgUq
 jA4DpJg4mW+OJcyA4ZvINkSlwqoeu3I8HKMza+oU69fI6yYNqKydTqd3aQcEDOfnPfNrCh
 KV3k/szENcywKoM24gI7X0DnSwNVqdw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-AD72pIXVO76hVfZDjpHZIg-1; Tue, 23 Jul 2024 06:55:18 -0400
X-MC-Unique: AD72pIXVO76hVfZDjpHZIg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef286cf0e8so25250501fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732117; x=1722336917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7lYzPlslzs28OpL2JOdMIA3bwyrM1HvLLKU1gK7kNg=;
 b=hESpjqo0d5uB8mbP+6JXU7vomfsX7DgrtBZUq0Fy2PVDkIdiUjpfEAcfy8yYfPNJX9
 nTSIZizsLolZ8QkcIoJMKHO2pWPwaTbMB8yLh8xEoyOdABdUAzPUek7K5JTyYvEVg0H8
 rc8OnnHnP0an3ARRME5VQy3ihF/s0QHV3EnFWgx2lroJ8bbuPrHYvjmUYu4ZQ4MUY9tc
 ovgDbPyCVQkExUuwN2ny+eCi9VY1q8AvRKDtcEDJ/Otky8W7JI2n0V4rPqws91cEqVXP
 9ak8ch1oEcZnlZeTsMrqa2Pgl6lgkvA174UCkOqpUUsoDOwyn+f5D1z59/1iFGDD5uy6
 rKyQ==
X-Gm-Message-State: AOJu0Yy2k7A+uQ48nhxr5Zry9r7WzaOfC1OOz+YYMxXQsnvxNMFt8T89
 cHh0/iRd99eZm3rA/4w7aEhx/vg3691PbfIaYleMeW3SXU+jyKsW2ROwW/TOj+b8KWVlHmD9zvB
 DfKC4ZT7ydsugbMO9cZDEhLo93iXn2xg/kiNXFD4kAFHz0v/Yrn9/GOWOw720luzkFo2/69Z4+w
 zBM1flPr7tXotwjRhSmuZWB5//Ri72nQ==
X-Received: by 2002:a2e:9ec4:0:b0:2ee:8555:4742 with SMTP id
 38308e7fff4ca-2ef167dfa9bmr66561101fa.27.1721732116640; 
 Tue, 23 Jul 2024 03:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7eD1smRFN8gpJ2r6smIxD1GGqUURRg99gLh1itInWSjE6tthfbBVEntsNv+xW8+4D9e6xPg==
X-Received: by 2002:a2e:9ec4:0:b0:2ee:8555:4742 with SMTP id
 38308e7fff4ca-2ef167dfa9bmr66560821fa.27.1721732115763; 
 Tue, 23 Jul 2024 03:55:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a5ef56e2c4sm3848296a12.39.2024.07.23.03.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:15 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL v2 01/61] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Message-ID: <89cf6574bc4bcdb99894e9401ecea0063d8212ce.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

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
Message-Id: <20240702211835.3064505-1-zheyuma97@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


