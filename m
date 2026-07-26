Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803DDC53219
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PW-0007Rj-3K; Sun, 26 Jul 2026 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PT-0007Qz-T9
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PS-0004FZ-EQ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K16jKduEuMv24m8AFbyJxmAvPDg0GFdoPSEFWNEBbj0=;
 b=Yum2K0iMJBTn7qItMfMSQGxiHSjs9I1vxa7+teCI/tE1l5infPfYTotJbj/hKgJEUN5D/0
 K1s5uovUrsIL5cHTVTtJaye/VrlMVcvl8ZdgPwVy0QvpSsbnUZwJl2OdLVgorqHAN4XeXB
 04wxrwv3xSk4p9uZT+0+LhRYR1PMo2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-XutG-HD1NgKutT28m5CaZQ-1; Sun, 26 Jul 2026 17:29:20 -0400
X-MC-Unique: XutG-HD1NgKutT28m5CaZQ-1
X-Mimecast-MFC-AGG-ID: XutG-HD1NgKutT28m5CaZQ_1785101359
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b408a5c0so7738045e9.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101359; x=1785706159; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K16jKduEuMv24m8AFbyJxmAvPDg0GFdoPSEFWNEBbj0=;
 b=hENkZsQmfi8+rf4nWfHvuK6lyJ3L0lLl8AkhmyCo29sxN+TVnNlWfIK6yC+aKWE8WL
 ZrEmdHqsVjx//2WiEYznXP5/dBw0vW88O05RW1ZpNliWi+oIAzkNQeeG57psjnFK6HhN
 mXMFfV9vU65INwPG4bffY3hZBrDLXyzMt7OGGMX4W0FqRY5H43EfAxoJzSt3P51Bzn0x
 GiNYjacucvRunCV0fNpw9/RRQjBI+udK693oBSg1BkRbtBXqkOZAYRWrYLqQna3VkglA
 CJQI8+dxcnIxXq+PptQny6JXktCXeehO9FCkgJeR9Tb5n6DvbY+nQZWzxvTHfev9/XeM
 LDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101359; x=1785706159;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K16jKduEuMv24m8AFbyJxmAvPDg0GFdoPSEFWNEBbj0=;
 b=ioTSS6odMPbk5SOckGF32zGTRFfWvu8pokYXN2V2h676l17dbz/I2OJyQZ4j6OtnBX
 9fwkCAAqb5Gs6r4kEXjfDycR1jfz3/ksQkwffzPdilIcNeoUj53Jlzam3t1+s5klR3mw
 uRCQNlSWJg1iIPSPysmFHIio18HQY7jGMip8rt1qljw3AHSx3n0kwPzBQ2TdCUzi2VmB
 /+bi/rV7ZmTDdHSGySuYq429iqptvFEYsM4jXm/uatp84Q1vpyUiZhcRzg0wiCSKcHFg
 U9LSwBhNXdH7zFHADbcN41NWLbihMyZ5fZ6V8DFrnD1IechFRFVsmNepGR+1nmoXR9zh
 23zA==
X-Gm-Message-State: AOJu0YwJ/AstLx3PLLtgXGK+UrBaeRMRLLQIFpiGUZC9kwQ8ZSx7bJuc
 7GUOCrIBFMa4Fs+zwvRWDUsNT0IAbmyZPp4yCVl3V+L1yjzCAqX3G1elWwBQXvBYck8C3yCxgoq
 PVamnXkRFxmT+/OWOgoOWw6P8gpkRoc/bZHRFkP7MbQl0Znox71VXIWXZ97KcNKyyhIPF+OVutO
 dFxIFQ9aUwFUbW+pBkHsssu92lZeCt1Z1owQ==
X-Gm-Gg: AR+sD132Ik+Inz/mdrRNQN/QKWGa58GJyJXR7DtDckhquK4gv43P6QzAM0isICz5lW1
 Hj7EJ+cZwZ3oFLLL3Sfx9Mi1jm8pbL7LlEDypShsmD34DU0r56c4j9cTuF4yw3PXI6fAEhX+Trs
 mePz1IMHUgdFBQShySUtBUZrS+l//gCbbvEDHo2FuRnI3YjFZvXQOcK+N8COZxh6C+m+CtYppiS
 nB3fMQMjIxUfSHDmTCBmq80rusKbR1E3bnIC/nPfFQfAeXeXVqToaTOQVhK+OGfoKbFj3d1cNcc
 05230XNUlEbIFn7BjXLw1Asmz7M5C35N21RLAP2DiSPwYO4OObExNvgXYE7TqdZaa0YzVofvRor
 MmbGesPPXHJBN9v7I6R/Y9w==
X-Received: by 2002:a05:600c:a20b:b0:495:5d6d:d4f7 with SMTP id
 5b1f17b1804b1-496b571a00cmr49549825e9.24.1785101359099; 
 Sun, 26 Jul 2026 14:29:19 -0700 (PDT)
X-Received: by 2002:a05:600c:a20b:b0:495:5d6d:d4f7 with SMTP id
 5b1f17b1804b1-496b571a00cmr49549725e9.24.1785101358626; 
 Sun, 26 Jul 2026 14:29:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm185801245e9.2.2026.07.26.14.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:18 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 07/30] vhost: do not crash on ring map failure
Message-ID: <a502996a2faedf1130d3bae1cf31573083ec2ac9.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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


