Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCB606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e31xPsVw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9i-0000vo-Oe; Thu, 22 Oct 2026 09:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9L-0000Oa-So
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9H-00055y-6x
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1298765f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676879; x=1793281679; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GVmZoNLcFfTiEWCamJcIcPOg4eqdrXf1kgXuTnB5c1c=;
 b=e31xPsVwZZD3HEu0N+YqylYAB8CRW+JEid4PIsTEdXnp1r+N4X6MrG3JWIdHJWEFtc
 YXN36+GaIaRSabAk16e58HaHicTorlM5R2XxqpW4p53HHD6bLTTka1lz1ztpn9d1byqg
 th0mw5gOdTDKhFIf7GTgLD4VIcenugjmXnuA789pPX6s72wpEDINIrAHtVyvEXFp/d/q
 fXF6VflBJov2uViBsnZx/H6xC2OW7hw6Z/YjDV2lo1PPwyz/AKdUExSInEQyse0s0wGE
 C/vw+VeIx/IeQ+/om1ZmYF3EY7vAVTmU2cjv/OQPUu8BoCcuA8COuQfqkpLAND+Q+1KY
 5yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676879; x=1793281679;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GVmZoNLcFfTiEWCamJcIcPOg4eqdrXf1kgXuTnB5c1c=;
 b=GzEM5gMqqNb9g2eueN7EhPFADMh7uTstSjTa/LlMzD1axPpj282yHkPhlbSjjrvrcn
 iXdVIUrAQSLsrhg0D2rezh4Wi5uIJWjXxEkL9Rai2B+IGqRbeVXqgmWg8iyWKG3ZhTka
 jjOcpqo7ez1G+cYbqkNh3GOC5UqGdH2fGaL7vgoI8guvLc2lldg9rJwKVz0Pq44v5jSp
 vBVOQCr4AAf3vbwyZKsAe5QpjONFvn5fYPDtR1q1HNbx5a8rF4Ygdg0Q/4G7H4bSgsvP
 TLBM4TJqIs245hyzPBa+V0fNQXcp4DIzoqkgE1/feeiSfLx3FNItivQE6YNzn6mxxVyN
 N2dg==
X-Gm-Message-State: AFq9FYJr9d6qIJz/jtiRaWgq8l+dThXDVvr7pfm7cYUnEGMyIjpOjXBl
 fyIVZvtvYbGNM+m3VlF+MfdQmXcmGxFL+/S0W/tNFmnTawDsXCVBz+bs
X-Gm-Gg: AYBFou27BphTcsEHT0eheQgdjKO5IfwbBhXJgJdIu9s/Y0GT8lHd6Na+LjUJ8Ozf1RQ
 1oXof7IogbDuZtaX7G+UKOnp9wk4277L/2NekdeWu/hmlm205YWFiZVBe+DGbL0AAY5oHmATfid
 ogIwT3mM//B56baCCcGd5TWZpdVOigoaMxmktLfYd/QcmHdHrGWgZTGQa7lrtWDeMWzTR1yKCZb
 wepL64AGHpwHl15EaVBiSsbIqWjiP7r7paJYzir+XgrjtXwVh0TAT8lWdlnpQyeDeNwK2ver1og
 ZsvJZaWxQnLdNGQYgof4OFHsUaNXemupdAaRRKG4KLC8cC4TeEvDKQUbtDs9XIRLS9f6IGx9hTB
 TJgv/4GN5KUzlHXPo9/8bNwr6uu/2yzAi5x3iwo+DWe6LZ1D8jOJlyIMFgozirctEx4gnqnrCFs
 SA8YnKKX3CwytO2CFbT9X7395uSSYZXwm5/aibLYKbdmt2bl8uxRQcVQ6p2XLWBSqE1y73nb+JI
 0EE139Uz+fq4T8WA/0C1o+3Cd07CTAnV+beJ7XL5kulxowB+CdazuBT06GwC0wv4WAfmaWILvmg
 FZHnm6YP7YQ+0Q17I88pXMYC32ZH4YYwxLOh4yP9mMBbPOXo5e1B8xJs1oxby/mpXT1nBu3JWtk
 3az35U33NYg==
X-Received: by 2002:a5d:5f55:0:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-48e263ad234mr11993726f8f.0.1792676878768; 
 Thu, 22 Oct 2026 06:47:58 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:47:57 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Subject: [PATCH 0/8] vhost-user: another try at supporting any POSIX system
Date: Thu, 22 Oct 2026 15:47:21 +0200
Message-Id: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE3SNqGpq4hFMRgLlQ4iEXdXL
 N/i/wuEIpNAlV0Q6WDhsCToPINu8stIyH0yGGVKrYzBYwqy4Z4yXIPwiWRb55z3ttA9pGyNNPD
 5Levmt+ztTN32fuC+Hyte5Rh0AAAA
X-Change-ID: 20261022-vhost-user-posix-e7b999aa751d
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series continues the work started by Stefano [1] to add support
for any POSIX system to vhost-user.

Three patches from his original series were never applied due to failing
tests [2]. I was able to reproduce these test failures on current master.

Patch 4 contains a fix for this problem. Patches 1-3 fix further issues I
identified on macOS. Patches 5-7 are the three unmodified patches from
Stefano's patch series. Patch 8 contains another bugfix I came across
while testing.

I have tested this patch series on Ubuntu 24.04, macOS 15, FreeBSD 14.2
and OpenBSD 7.7. On all platforms the tests are now passing. In addition,
on these platforms I have tested successfully booting a Fedora image with

  qemu-storage-daemon \
    --blockdev file,filename=Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2,node-name=file \
    --blockdev qcow2,file=file,node-name=qcow2 \
    --export vhost-user-blk,addr.type=unix,addr.path=/tmp/vhost.socket,id=vub,num-queues=1,node-name=qcow2,writable=on

  qemu-system-x86_64 -smp 2 -M q35,memory-backend=mem \
    -object memory-backend-shm,id=mem,size="512M" \
    -device vhost-user-blk-pci,num-queues=1,chardev=char0 \
    -chardev socket,id=char0,path=/tmp/vhost.socket

Full CI run: https://gitlab.com/tpambor/qemu/-/pipelines/2974109193

[1] https://lore.kernel.org/all/20240618100043.144657-1-sgarzare@redhat.com/
[2] https://lore.kernel.org/all/suvpzkb3ppdodjdyo5zcpngz5mwrrlq3nfowemh4tqjghbc4si@hzrsr23fganv/

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
Stefano Garzarella (3):
      vhost-user: enable frontends on any POSIX system
      libvhost-user: enable it on any POSIX system
      contrib/vhost-user-blk: enable it on any POSIX system

Tim Pambor (5):
      vhost-user: kick via event_notifier_set()
      libvhost-user: self-kick through a library-owned notifier
      io/channel-socket: only clear O_NONBLOCK on received fds if set
      chardev/char-socket: detect peer close portably
      libvhost-user: detect memfd support with a link test

 chardev/char-socket.c                     |  78 ++++++++---
 contrib/vhost-user-blk/vhost-user-blk.c   |  14 ++
 hw/block/Kconfig                          |   2 +-
 hw/net/vhost_net.c                        |   6 +
 hw/virtio/vhost-user.c                    |  11 +-
 io/channel-socket.c                       |  19 ++-
 meson.build                               |   5 +-
 subprojects/libvhost-user/libvhost-user.c | 219 ++++++++++++++++++++++++++----
 subprojects/libvhost-user/libvhost-user.h |  12 +-
 subprojects/libvhost-user/meson.build     |  11 +-
 util/meson.build                          |   4 +-
 11 files changed, 319 insertions(+), 62 deletions(-)
---
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
change-id: 20261022-vhost-user-posix-e7b999aa751d

Best regards,
--  
Tim Pambor <timpambor@gmail.com>


