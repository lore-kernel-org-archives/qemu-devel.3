Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD1F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6NQ-00059u-7K; Tue, 24 Feb 2026 23:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6NO-00058K-4O
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:19:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6NM-0004Ws-AO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:19:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so59701555e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993190; x=1772597990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zTxZiDwMO3Sc4Z2rZk6deISwKYqSQPecO7LzPMbzDvw=;
 b=EIy9DjD7sq4sHCjjVgX1MYaKKtX1h4j4rNYXKOzdk5kZRZN39TiPDwR9FfwQlcjHxe
 p+QxGuINsEtajJz8deaKgfCLLAzBgAeFKfeknj/hRfWhGtzIaNrdsaJTiy9aQLNWLNHg
 WTChEKKdlSrNEn2PezQNTMXHMk3O1vP6tUKvJpziiE3on4JaQEb/Q2UT4RBx/SG687KZ
 YiML1gKNuG+srvWGa2prUNsDF5QB4FGfLDa9B9vpksWIFF3KvFoH3/kQDpwkncZvfA26
 k4m6By1m2hFFu8gEeavKGfM9g4cvHNd6MoNPikqHk2Y9hR2XyTGXc+mf6PSv12U/FeT4
 Shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993190; x=1772597990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTxZiDwMO3Sc4Z2rZk6deISwKYqSQPecO7LzPMbzDvw=;
 b=qwacmL6cWih2ydsAl8dp9/sikYNXbD/9iTPH8h/GKn+7JEK0/+1vLUPSZZG/hOvuOp
 FV58ueXQkMOyECGnDu+XGiuM0z7Gv+4qBOXstnuNpzSwaulGwq7tbq3YFinbsvt75qal
 hBEqoRm7cLktyIY1VIo8hirc+fjOYmhUaxwhrJ7FbE/Blbtx9Wa2SV2PgVxxeex2bmCF
 5JxFZ0C0evm0GI5syAjgZ5D9I7h1xqa/Opy5tmYEHV95TzV+X7LmzPv2hqsEeVDvWBfj
 qZP0kBoOtoCY3IYQjEiqSIcV80sgwonKIpLXkNCCbE+H8WOrsy6wDvqgGyBFeuNoucs4
 83Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ/aoYuQjjKE6SFLrOck9nGAWd9TSJJZQmCSZooE/dNMw4ZQWLwN7b0aZHQ+QxvC+BRj5b4aN4tthh@nongnu.org
X-Gm-Message-State: AOJu0YyYa6A0Sl6x8cfhG1Bu8Jz1m33oEKuqB6RqbSmejVJVvHDbe/De
 3EqMefAkwMkYsMtq6vYRr4hKjRmPxkiazNjgP/RbhaApm9OIdv5gH2cA1fAVGtCPVaw=
X-Gm-Gg: ATEYQzz7ZKGHg20J1fn7VqGPHW0R5dPevz6W3iE59KrvveD/Z4OuEN5Khag/1En9n53
 fBlAeZCnGy8sPzmNmu6UleNiWP8YYHtaIqCB/ZTFBCNbJ9mgHuBfRRKE9kkl1oIlFndXqm5T/SK
 DoLr+JQ+IBE7lwuoIAMiU+Nz/bc7j47Ezw/a4KJfgsKjyHSBW7YVqwNLjS2xSfK9VMilV+9Ec/r
 6kWEr7TnDgqtymJQglkv0/I04jNSIApMvzbu1R/1XYPg7joFxRHIqdDm/e690vjrWo8E3t3kPmz
 ieVYEWy6OREdCOxRIsUI1Urvti6qUq/jlVacv2Qi0LKmy39VLUL2yrCfM7bnb/aCYVvvppYN3jv
 O2pBnIAH0G2hKo3FoUzVLgCleV+zEaVot+CS9S8jeTVnwYqvIPPEwXsX5RbCkweT6eEKHQQl5Wh
 soM+8FMGHhi79/vu7SnWOC5iNa51AmgDV7jICqUY8rgX6r5edFdLRckM+VjKhHXuIlf3rz8c8C
X-Received: by 2002:a05:600c:1e1d:b0:483:456a:514b with SMTP id
 5b1f17b1804b1-483a95befe5mr244952055e9.12.1771993190240; 
 Tue, 24 Feb 2026 20:19:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb6d16sm2535505e9.5.2026.02.24.20.19.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:19:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/virtio/virtio-access.h: remove target specific code
Date: Wed, 25 Feb 2026 05:19:41 +0100
Message-ID: <20260225041948.52929-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

v2:
- Rebased
- Removed virtio_vdev_is_modern (Zoltan, myself)
- Include Stefan's Acked-by tag
- Include "make compilation unit common" patches from [3]

This series eliminates some target specifics in hw/virtio and replace them with
runtime functions where needed, to be able to link virtio code in single-binary.
After a first try on a series [0] doing this change and making all virtio files
common, Richard asked to refactor this part, thus this independent series.

By diving into virtio initialization, I noticed that device_endian is always
storing endianness of cpu associated on device reset. The root issue, is when
dealing with target who dynamically change their endianness during execution.
ppc64 is the main use case, as cpu always boot in BE and most of OS use LE. arm
use case is more limited, as big endian systems are mostly dead nowadays.

Because of this, initialization is tricky, and goes through different hoops to
have the expected value. My first approach has been to try to change this, by
simply setting endianness on the first access. However, it fell flat, because
current_cpu is not always available at this time.
A second approach was to set endianness to LE by default, and change it only
when setting device features, and potentially discovering it's a legacy virtio
device. It brought other issues, that showed that current initialization code,
even though it's complex, does the right thing.
Thus, I focused on refactoring virtio_access_is_big_endian, and noticed that it
was not even needed at this point.

Patches 1 and 2 are refactoring names to clear some confusion.
Patch 3 eliminates virtio_access_is_big_endian, with a lenghty commit message
explaining the change. By doing this, we remove target specifics from
hw/virtio/virtio-access.h.

Of course, performance has been tested, and it is on par with upstream/master.

Results are on 20 runs and expressed in kIOPS:
reference: mean=239.2 std_dev=3.48
with_series: mean=238.1 std_dev=3.56

---

Performance has been measured with this automated fio benchmark [1], with
original instructions from Stefan [2].

Download artifacts and run benchmark with:
$ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
$ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
$ ./run.sh /path/to/qemu-system-x86_64

[0] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/
[1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
[2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
[3] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/

Pierrick Bouvier (6):
  hw/virtio: Add virtio_vdev_is_legacy()
  hw/virtio: Simplify virtio_access_is_big_endian()
  hw/virtio: Inline virtio_access_is_big_endian()
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio/: make all compilation units common

 include/hw/virtio/virtio-access.h | 43 ++++++-------------
 include/hw/virtio/virtio.h        |  7 +++-
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/vhost.c                 | 12 +++---
 hw/virtio/virtio-pci.c            |  6 +--
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 hw/virtio/virtio.c                | 12 +++---
 hw/9pfs/meson.build               |  2 +-
 hw/block/meson.build              |  4 +-
 hw/char/meson.build               |  2 +-
 hw/net/meson.build                |  2 +-
 hw/scsi/meson.build               |  6 +--
 hw/virtio/meson.build             | 17 ++++----
 13 files changed, 50 insertions(+), 144 deletions(-)

-- 
2.52.0


