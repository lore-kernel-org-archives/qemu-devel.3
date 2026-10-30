Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DC606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=050CV5IB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkfy-0001Ls-AF; Fri, 30 Oct 2026 07:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfu-0001KS-D4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfs-0002kb-I6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so362389f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359290; x=1793964090; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b/HG26TxZTq1sxK4QqoMzxHAvHSmMQFGYKOqt8YOLVA=;
 b=050CV5IBQ2C2hvGXrw0qdRUXvBNXCkjS222bMQnfaLMOrXM+t05NuEc+dSA6GXp/T6
 1dMcGD8srzStDRUgNbMxg7bKuOFEZaEgZZ98y2E/HzyxvoNZRApP9KOnLID64cENgoLW
 MrErbQUASbA4F26yeT3UoeCeJfrNIuOm2rKErJp7JZ8SzvCmaHsOsoKQfkNyLB8LXNdw
 0CqC2n5t9529g0YAMJ148nAqtSZYfQlj39bdmHWmw/UluEg8twLL1z3txBSugbkQSg/Z
 r7FI2hryxnEH392GQKIjLdyYh6AIqjN6gZkhQSXRytnADu45rNWNd5Z/679ABeHAohq7
 Cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359290; x=1793964090;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/HG26TxZTq1sxK4QqoMzxHAvHSmMQFGYKOqt8YOLVA=;
 b=aRHIINwAFnVqEBpp3NCEYIsw3ggboWNv2NMhbLIlv4G3ALrE6cVlUIFt1wvga0tVwv
 sccmarAnQBDo6fbimRvPw6TPcQcv+3ani41PycXi2+O8uQRggv+7N8WcIuEjgCfmbW6N
 bmaK8XuJ8e3ET19bpucmfVHnfJdNxMvXxU3UfiA+CerAmoTF1P1L7VVdVRMTYsB4Z4Oz
 RLk31fnuREWbiK/vqsb3RbzQbB19QCLmkCznaBUaZ6oTl1k0gEdH5bOZ/zTwtFGbfg8e
 HSGzkB2BpCIHwhgcBaUQX22bKRjp6gxjTDPyu3Lx/BYVcvGFPN/gaFtfXmXE/xWN7/Ef
 7iZw==
X-Gm-Message-State: AFq9FYJBjHKEzAg4wyAh224zvoA98Qpx747/N+FXeZKmhmOnOZr4+VF7
 XR9Kh0rx4Qs3xV29Hs0l5z5nly8PPwWg3oanUZ3OAHyBalXlefYe5W5J
X-Gm-Gg: AYBFou0ZN3NaFBgKz8hU3qgNSt6jC0Pnqkmqb+n8TVPSJh+gyNny5uDyjbxZtloEGbP
 hkrvHchlnDLnPbQErMaBR+DXbp1RS8SZVu1m3803muY+NiDEOS7PwLu+Fx55ZYwOZHs+otHJEdW
 tkaO+E8/qJ8UYkJ4a2aQA8seXrs4ynjC4PhWG2iqIeaK2PXordpic2rzlc9Jgxs63oB5x5hfjnC
 nW9mscyN4SCFj1CXd4yZBmwoIRhfYwnBGQ5n8LEN5tW4Z45avIboFEL1EKCioke2DTFLZAQ/hNT
 S7OCBRA7MRDuyQKL2/I834CpsT2tVI/WBrPvxsj2uZ7dKa6kSDp8Pg4ce8j1MAlYp+sA7w/SmLD
 G3PCzQeJS5LYHuZclgjmVIXeAnkjnmkLUFiATflMaPyXsWfJslIN0tJp6YiMRBIhRaDcZVUJqJi
 GtRw9qbriDh/OkHdjQd6ZhPdgcm4+Q4roRmu/BjaPgsVBwXZD+ts/vRaNB1k3b9HfI7MadRo9vc
 eJTdPGVu0Xe7NPwXhizMARjg4susAzVAaAta/gr8OzKvJFKKxI9SWMtVrI6hOkGxYw0Xm+w466n
 +w4M4dYBH/05MhCTRGdtNaTIYyxzWbiP7Ruw2cvuzW+hI3P9YqdCy6CDp/d62ybdXv25NoBT3Dg
 b8somZ1d0/Q0nW/oZQYkqEqdSS96J0X0NlEKW1rP4ysn5eFNDJ4NVrT3TvAqbkw==
X-Received: by 2002:a5d:4ec6:0:b0:48c:7143:610c with SMTP id
 ffacd0b85a97d-48e6e3091c8mr3797943f8f.36.1793359289998; 
 Fri, 30 Oct 2026 04:21:29 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:29 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Subject: [PATCH v2 0/9] vhost-user: another try at supporting any POSIX system
Date: Fri, 30 Oct 2026 12:20:53 +0100
Message-Id: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0JmbU1bQYIr72FYlHaEMUJJBxoM4
 e4W3Lt8yfvvr8AYCBlu2QoBIzH5IYE+ZWA7M7QoyCUGLfVVSa1F7DxPYk4zMXqmRWDZVFVlTFk
 oB2k2BnzSciQf9Y95bl5op72zGx3x5MPn+Ixq9/7koxJSyMblLi+k0xd7b3tD77P1PdTbtn0BK
 Vm6iMIAAAA=
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
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
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

Patch 6 contains a fix for this problem. Patches 1-5 fix further issues I
came across while testing, mostly on macOS. Patches 7-9 are the three
patches from Stefano's series; patch 7 drops VHOST_FILE_UNBIND as
discussed in v1, the other two are unmodified.

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

Full CI run: https://gitlab.com/tpambor/qemu/-/pipelines/3007880563

[1] https://lore.kernel.org/all/20240618100043.144657-1-sgarzare@redhat.com/
[2] https://lore.kernel.org/all/suvpzkb3ppdodjdyo5zcpngz5mwrrlq3nfowemh4tqjghbc4si@hzrsr23fganv/

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
Changes in v2:
- Moved "libvhost-user: detect memfd support with a link test" to the
  front of the series.
- Added "libvhost-user: detect eventfd support with a link test".
- Replaced the library-owned self-kick notifier in libvhost-user with a
  per-ring flag; the handlers of started rings now run at the end of
  vu_dispatch(), after the reply has been sent.
- Dropped "io/channel-socket: only clear O_NONBLOCK on received fds if
  set" and instead reimplemented qemu_set_blocking() with fcntl(), so
  F_SETFL is only issued when O_NONBLOCK actually changes.
- vhost_net.c: replaced VHOST_FILE_UNBIND with -1 and dropped the
  Linux header include instead of defining the constant for other
  systems.
- Added a comment and an assert to "vhost-user: kick via
  event_notifier_set()".
- New CI run: https://gitlab.com/tpambor/qemu/-/pipelines/3007880563
- Link to v1: https://lore.kernel.org/qemu-devel/20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com

To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-block@nongnu.org
Cc: Raphael Norwitz <rnorwitz@nvidia.com>
Cc: Brad Smith <brad@comstyle.com>
Cc: vhost-user@lists.linux.dev
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

---
Stefano Garzarella (2):
      libvhost-user: enable it on any POSIX system
      contrib/vhost-user-blk: enable it on any POSIX system

Tim Pambor (7):
      libvhost-user: detect memfd support with a link test
      libvhost-user: detect eventfd support with a link test
      vhost-user: kick via event_notifier_set()
      libvhost-user: run handlers of started rings after the reply
      util/oslib-posix: implement qemu_set_blocking() with fcntl()
      chardev/char-socket: detect peer close portably
      vhost-user: enable frontends on any POSIX system

 chardev/char-socket.c                     |  78 +++++++++++++++-----
 contrib/vhost-user-blk/vhost-user-blk.c   |  14 ++++
 hw/block/Kconfig                          |   2 +-
 hw/net/vhost_net.c                        |   3 +-
 hw/virtio/vhost-user.c                    |  19 ++---
 meson.build                               |   5 +-
 subprojects/libvhost-user/libvhost-user.c | 118 ++++++++++++++++++++++++------
 subprojects/libvhost-user/libvhost-user.h |   3 +-
 subprojects/libvhost-user/meson.build     |  17 ++++-
 util/meson.build                          |   4 +-
 util/oslib-posix.c                        |  26 +++++--
 11 files changed, 221 insertions(+), 68 deletions(-)
---
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
change-id: 20261022-vhost-user-posix-e7b999aa751d

Best regards,
--  
Tim Pambor <timpambor@gmail.com>


