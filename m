Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A2C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrp-00008F-KX; Mon, 27 Jul 2026 15:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrn-00007V-8c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrl-0000Ma-OE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KkUZwiZCp3omFxnV90IJXEAM6ZshsqXJQAFCai5nyM=;
 b=dlA+3YZPB4EU9TU8wjCNUA0dhBkz6csrUo3HkACuMO9vusZTFAfaAV05WarIhV7eks4CVI
 BnCzzBSBTyoJL/PPDEkzS9aFpISk6uiB92s602FmQdbvBWewb5mJbbXTTWfFMaeEXXSaSj
 q3RHIIwH905/sEXrw3vJ5NlecOPi1ao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-PDFd6UPZM4iU1Ath3CIC5A-1; Mon, 27 Jul 2026 15:19:55 -0400
X-MC-Unique: PDFd6UPZM4iU1Ath3CIC5A-1
X-Mimecast-MFC-AGG-ID: PDFd6UPZM4iU1Ath3CIC5A_1785179994
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-492488f8583so28268545e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179994; x=1785784794; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0KkUZwiZCp3omFxnV90IJXEAM6ZshsqXJQAFCai5nyM=;
 b=QRDSybOF5sIfzbfFlxg3oaxex2iYnRZCcFX6+6UqQAs73nDYS/Yl+QUDgAjJ/hN7AU
 5u3vSzZ1WX5UzvNVXXDeDeQqBonp+ccB4uDWjS1/8iyrB8tPkhHP1kKn43EpCqi7zIm8
 NcjHl9zkM6nRO3aREtuAz1h2laD7KYr2n8unkNjdKHxhdHbhN/QVGGifD8vbSohF2jqX
 xcZbQ2gw+4kgel0p+syfzEPeGr0PoWq29BTibE9fi3XdakLOv6PUKxoBgd0Uws8g/w0O
 IEhgHDofy9TLBsHR0Hf8RObzXRigdx7wdLveLynrii/2GWUdF0/18R4bnRLjCg8x4Ioa
 EeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179994; x=1785784794;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0KkUZwiZCp3omFxnV90IJXEAM6ZshsqXJQAFCai5nyM=;
 b=TqwQ03ygx2N4CVIBNYJF/sc3hVg5iPITW9Yh1i+S1nwWU6cbhxDN7D+W6EI1zLIsJz
 hvn+w81M6OPr+URXQoDHuy7rwmV/sKhbw+z+UInvwLvznzXmsd2F9UfqC+Z6adCTnh8J
 5neAv+ZSTRIfoBu+P7GILt+zKDd303gqM9paHADj7xV4j7Mz/5mn818fjsaZGRBR1why
 +cP8fTMMopHLUMIVOuDmybtXSL18fHNs8i0QhONos6tixZWKPHLxTC3DlXwCr+oJTb4y
 Wb//kQgOsfX7aKzTU+lEk53JypGPbg76DhRfRMcFTnEwW3ybMfWHVqX0F33zGQeLp9VU
 RH2A==
X-Gm-Message-State: AOJu0Yyp5RySVvkOV4BpElS6rwPJjRAdLWaCh5Bh9TzJCGA5aUD9n3vN
 1RlUUPnuND3MkxiTJgzhqa2UZOSm4BtNxkn8RnJj9ZxCk5IgveU/2YJVw6auSXNnZViv2WGZUJM
 ocyuAYrUDT7yHXo42ceWabxkcwJbnO/5LUlj01+uPr3Pli7PXd6l3bkMNNHPjY9G1HAcc+d6HqF
 Xpn/2FFKKdLz5x6gLVwMGtXu6a/3WwGKwDcQ==
X-Gm-Gg: AR+sD129zuLXHXGAIyeFKqiyMqYPHmStOvQoStGA44SU77EngAM4y3B/tVCVuQts+zS
 IMbydu74o7/j0TvY3DVUa5gH7BbIMVXM4Rq+RN6MYOXU+A4UzNPiCYxOzcF4nmlkN9D6plKs03n
 d/oXtYNfZe7alAbfeiz4TzDRZvnnZR8bppjYpENbpLEz8AhWsnEcLDypPGkecwkrFUbIgeaGury
 1SaXY+MsRhVUbXwnerhJiDjnL3Kio7AjyVJ1tr9ttpTYziecnSizXkNqxMN0IHldZFZC9hH3Hh2
 b8A7saDHIDeIcfQHQiQkd/tfzsJzXf2AMNf5g0t4FgixvCWpZEHYOtkJIXuRUY7lB1x5PYv+nNj
 B9M2sRYpH34jgwbIef7G5kw==
X-Received: by 2002:a05:600c:1990:b0:495:67b8:d97e with SMTP id
 5b1f17b1804b1-496c4fcdd98mr3922325e9.30.1785179994209; 
 Mon, 27 Jul 2026 12:19:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1990:b0:495:67b8:d97e with SMTP id
 5b1f17b1804b1-496c4fcdd98mr3922015e9.30.1785179993656; 
 Mon, 27 Jul 2026 12:19:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm52624772f8f.30.2026.07.27.12.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:53 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Feifan Qian <bea1e@proton.me>
Subject: [PULL v2 07/30] vhost: do not crash on ring map failure
Message-ID: <27806d2ddba2da97fb4137cba7d4172356c42914.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When vhost_commit() rebuilds the memory region table after a flatview
change, it revalidates cached host virtual addresses for active vring
parts. If a mapping is stale, QEMU abort().

This is not a security problem - only the priviledged guest
can control make it invalid - but not nice e.g. for driver debugging.

Let's call virtio_error() instead, marking the device as broken.

Fixes: 0ca1fd2d68 ("vhost: Simplify ring verification checks")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3783
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..371dca17dd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -755,8 +755,9 @@ static void vhost_commit(MemoryListener *listener)
                        (void *)(uintptr_t)dev->mem->regions[i].userspace_addr,
                        dev->mem->regions[i].guest_phys_addr,
                        dev->mem->regions[i].memory_size)) {
-            error_report("Verify ring failure on region %d", i);
-            abort();
+            virtio_error(dev->vdev,
+                         "Verify ring failure on region %d", i);
+            goto out;
         }
     }
 
-- 
MST


