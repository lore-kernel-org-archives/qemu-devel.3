Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CCC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7e-00056Y-EJ; Tue, 18 Aug 2026 01:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7c-00056E-Lm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7Z-0003i0-6r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so4367231b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029939; x=1787634739; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eYeq9bPe6CWbjsZmFOByTII3fv+JYv7PgXnda9ah0pM=;
 b=q9oOxoWhpXTTVa55HEJaBAM/p760gOy1SyRZSuFtXJqgTTF01Fb8ngR+Mg9pQeA/x1
 n/O7KIijPGf/+IPZKQWNLxVB3bv5P9HKpkHvdJt0yHfNPX/g3Tdgr9NxpbzYzQiHHKQ3
 wSMoylwASoLTNtkqdHVzT6TjmYL0G6AHPIR17y/2wKuVbi5kdGECOtxfczs/MV8Gh6ue
 6u/q/uU4nY6R4ldRKZk3z51U7pRuKVhRpmQt+mrnX2WDpg2/OpeIzvNthCex09MDdX/p
 caBGrpupXwKh1JYJbD+CvVCYBlAcfFY3n0FbHdR6OTpYTWM0KymgJvNvslqfG9+xOnf/
 RBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029939; x=1787634739;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eYeq9bPe6CWbjsZmFOByTII3fv+JYv7PgXnda9ah0pM=;
 b=sDdBq5dscjJD0AZZKq+OTjXrg/Rn1LycY7LeVl/mYodfiObVOv9FMiNRFkq+FWPDpw
 4IZj5sMkEtz47SY1Fbi6sj6lyUtBMPAS32stizk6Tp9sfk2HHAJvdUG3OxpAasvFyPOI
 7rQEvqtj+v2C5gNIMRWKJVueSgm/rg3bzSC6JD/ZuxGy4LCnWuE4VzzBIBDLLiP6nmDj
 rOCiD0xSp5IOqjjAjthafb3OOrDuakzYzmzeRZHHGSfngLew0qlPOglOy1pLStycMdg8
 nOQp1Q+Y7vKcwiKYx+qSsRPknqhj+svREmyPdcyLlNfv51CKCqVzGg+GTuNVu8YXpnWg
 WxQA==
X-Gm-Message-State: AOJu0YzXgFSgM7KmK22omw9vNfEG5DV3TBpnUej66pkBj6hj9k74jtcJ
 EgYP2Y25y5HZMhmarBBxfIh1DcH/Xfyl3Xjl9XLBKGlCoELgnPBxLPjL
X-Gm-Gg: AR+sD10oH9LbRSS9SnZJa2KhqjoQ8AorYFK4kSJpILvIN2kgrT9BBlGr9WCDSyAKmo7
 Jq31V6cE+38K1yet9AdvroK0vVMbbpvB3L7REiiLzTHdSutGPXtJKg7qF/IDp/A3bcgVKdnpNvX
 7H0haMBrGEiXaGa04pNFNGBbNWcGgqfQGNczjH3lC1jgodKi4PwU3a92jnUXlem4J8uhwt3swy1
 V92bcTLUTGfFPDQPjnYa4IIV3gql7db+0lHzYvEoVKALQ9AY6mRTlTgw+la5chTqW4t/YS89G2M
 X1QCr9Nl8A4d8hBELGb7lBWrz6vie7J07dzqWohXDoNP7GSfbSy+LVSmfAhd0EXw1gvc0oHXo3H
 PgiVRtF0/iilAiaBkNeYpq1LCP4V+oGUaWv/uQ2JPecNnF94a0D8dJebgX2jpbkOBYIpPQ+pkIq
 /0ex3kHcISxqZ99VR2rRg3ynXsjQkhQcDFpMYrSHqmN9QNAUPoXA5f268y+ghQX/HfSQ==
X-Received: by 2002:a05:6a00:4f91:b0:84f:37c1:f887 with SMTP id
 d2e1a72fcca58-84fddfdf5b0mr29235781b3a.12.1787029939441; 
 Mon, 17 Aug 2026 22:12:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:18 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Subject: [PATCH RFC v2 00/13] vhost-user: isolated memory
Date: Mon, 17 Aug 2026 22:12:15 -0700
Message-Id: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK/pg2oC/32NSwqDMBCGryKz7pSYiNGuhEIP0G1x4WOqA8aUx
 IYW8e4NOUCX/+v7d/DkmDxcsh0cBfZs1yjkKYNh7taJkMeoQQpZilIUGGbrN3zHGbK3S7fRiIa
 MdV8UWtBYVEoRaYiAl6MnfxL8AffbFdpozuy3WE6HIU9RYmup/rFDjgLLvtZDoWrqZdVMpuPlP
 FgD7XEcP7xLo0DJAAAA
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=9629;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=mw/NOsJAc5c3oTLsgT3HVoifVskWtAB9BaIpmPIXu1M=;
 b=6dagyY53uaZiuyJbepRPFr0QSnVBXkRD7WRmxIoBDFSgXL13glQEHSPvbZdCwiKqm1ySTY3a8
 LsvNRUiocxmAIhYpC3IP7HwrC3pwQrCIgsbBTxqCaxSLDec/1a/1+WR
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch series implements a memory isolation mode in vhost-user. The
purpose of this mode is to provide the option of additional security by
eliminating direct access of guest memory by vhost-user devices.
At a high level this works by:

1. Adding qdev and qapi properties required to enable isolation mode for
   various devices.
2. Allocating an isolation memory region in an anonymous file and mapping it
   to host memory.  This isolation region will hold the bounce buffers and
   vrings necessary to move data.
3. Using a vhost-iova-tree to allocate and track the mapping between
   guest regions and their corresponding bounce buffers in the isolation
   memory.
4. Creating shadow virtqueues to intercept request notifications.  As
   kick and call events are received by an svq, it copies buffer
   contents and descriptors between isolation and guest memory before
   notifying the backend or guest.   

Note: This project is currently in a partially functional state.
While the overall method will stay the same, the implementation
is planned to move up into vhost to simplify some elements of
initializing and using the shadow virtqueues.
However, the desire is to make this work public at this stage
for comment on the overall approach.

To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Raphael Norwitz <rnorwitz@nvidia.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Milan Zamazal <mzamazal@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-block@nongnu.org
Cc: virtio-fs@lists.linux.dev
Cc: Gonglei (Arei) <arei.gonglei@huawei.com>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: Alyssa Ross <hi@alyssa.is>
Cc: Demi Marie Obenour <demiobenour@gmail.com>
Signed-off-by: Connor Kite <connorkite@gmail.com>

Based-on: 20260817233147.2867623-1-connorkite@gmail.com
---
Changelog:
V2:
Series:
- Updates to svq address translation moved to a different patch series.
  Link: https://lore.kernel.org/qemu-devel/20260817233147.2867623-1-connorkite@gmail.com 
- The "shadow vq cleanup" has been merged into the earlier patch
  handling svq setup.
- Link to v1: https://lore.kernel.org/qemu-devel/20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com

Individual Patches:
vhost-user: Consolidate chardev property definitions
- Patch author updated from ConKite to Connor Kite

util/iova-tree: g_tree_foreach wrapper
- Added clarification comments about the function passed to
  iova_tree_foreach

hw/virtio: iova_tree_foreach wrapper
- Corrected comment about GTraverseFUnc end condition

hw/virtio/vhost-shadow-virtqueue: used callback
- Changed name of "used_handler" to "used_callback"
- Added handling if callback returns with error value
- Comments added clarifying callback return values

hw/virtio/vhost-shadow-virtqueue: specified vring placement
- Formatting improvements
- Change hwaddr to void * for pointers to host memory
- Bounds checking added when allocating vrings

vhost-user: add memory_isolation to VhostUserState
- Updated net_passt_vhost_user_init signature that is active when
  !defined(CONFIG_VHOST_USER)
- Comment updates for clarity

hw/virtio/vhost-user: create isolation region
- Formatting fixes
- Many comments added
- Read-after-zeroing bug fixed in cleanup_isolation_regions
- User-after-free bug in init_isolation_regions fixed by removing
  duplicate calls, and consolidating those steps in
  cleanup_isolation_regions
- Data unique to isolation mode consolidated in IsolationModeCtx struct
- Vring memory size calculations now only done via an API exposed by
  vhost-shadow-virtqueue
- Isolation region memfd file given a unique name
- Iova-tree IOVA space now starts at 0 + page_size to avoid exposing
  qemu addresses
- buffer_regions array moved changed from GArray to dynamically
  allocated array of predetermined size.  Avoids GArray formatting
  ugliness

  Note: Devicies implemented with multiple vhost threads, like
  virtio-net, are not currently supported.  Work is still required to
  update the vring allocation code to run only for vq_index=0 and
  propagate to the other vhost-user instances.

hw/virtio/vhost-user: send isolation regions to device
- Formatting improvements
- Vring region combined with contiguous buffer region in IOVA space to
  avoid wasting one of the available region slots that can be sent to
  the back-end
- Traversal callback for filling out msg regions renamed to
  vhost_user_fill_msg_reg_from_tree and simplified
- Check added if postcopy is in use as it is not currently supported

hw/virtio/vhost-user: add shadow virtqueues and eventfd intercepts
- Vring mapping now occurs during the vhost_user_set_mem_tables call,
  which means that vring addresses can be sent to the backend when
  expected by vhost
- The svq's device-facing event notifiers are now cleaned up in case of
  error or reset
- Bounds checking on vq index added in various locations
- SVQ cleanup code added

hw/virtio/vhost-user: handle data movement with shadow vqs
- Removed unecessary changes to elements during handling
- Fixed incorrect memcpy of used buffers in reverse direction
- Formatting improvements
- Bounds and error checking to handle mapping failures or buffers with
  invalid ranges
- Add error if isolation mode is used while IOMMU is active
- Add error if isolation mode is used with packed vrings

vhost-user: Add memory-isolation qdev property to vhost-user devices
- Patch moved to end of patch series
- Fixed overlong lines

backends/cryptodev-vhost-user: add memory isolation bool
- Fixed style in qapi and added "since" field
- Clarification added to comments
- The memory_isolation bool can no longer be set in vhost-cryptodev once
  initialization finishes

net/vhost-user: add memory isolation
- Moved to the back of the patch series
- Dead code removed by hard-coding memory_isolation args to vhost_user_init

---
Connor Kite (13):
      vhost-user: Consolidate chardev property definitions
      util/iova-tree: g_tree_foreach wrapper
      hw/virtio: iova_tree_foreach wrapper
      hw/virtio/vhost-shadow-virtqueue: used callback
      hw/virtio/vhost-shadow-virtqueue: specified vring placement
      vhost-user: add memory_isolation to VhostUserState
      hw/virtio/vhost-user: create isolation region
      hw/virtio/vhost-user: send isolation regions to device
      hw/virtio/vhost-user: add shadow virtqueues and eventfd intercepts
      hw/virtio/vhost-user: handle data movement with shadow vqs
      vhost-user: Add memory-isolation qdev property to vhost-user devices
      backends/cryptodev-vhost-user: add memory isolation bool
      net/vhost-user: add memory isolation

 backends/cryptodev-vhost-user.c      |  28 +-
 backends/vhost-user.c                |   4 +-
 hw/block/vhost-user-blk.c            |   4 +-
 hw/display/vhost-user-gpu.c          |   4 +-
 hw/scsi/vhost-user-scsi.c            |   5 +-
 hw/virtio/vhost-iova-tree.c          |  15 +
 hw/virtio/vhost-iova-tree.h          |   2 +
 hw/virtio/vhost-shadow-virtqueue.c   |  80 ++++-
 hw/virtio/vhost-shadow-virtqueue.h   |  25 +-
 hw/virtio/vhost-stub.c               |   3 +-
 hw/virtio/vhost-user-base.c          |  14 +-
 hw/virtio/vhost-user-fs.c            |   5 +-
 hw/virtio/vhost-user-gpio.c          |   4 -
 hw/virtio/vhost-user-i2c.c           |   5 -
 hw/virtio/vhost-user-input.c         |   5 -
 hw/virtio/vhost-user-rng.c           |   5 -
 hw/virtio/vhost-user-rtc.c           |   4 -
 hw/virtio/vhost-user-scmi.c          |   5 +-
 hw/virtio/vhost-user-snd.c           |   1 -
 hw/virtio/vhost-user-spi.c           |   5 -
 hw/virtio/vhost-user-test-device.c   |   1 -
 hw/virtio/vhost-user-vsock.c         |   5 +-
 hw/virtio/vhost-user.c               | 657 ++++++++++++++++++++++++++++++++++-
 include/hw/virtio/vhost-user-base.h  |   1 +
 include/hw/virtio/vhost-user-blk.h   |   1 +
 include/hw/virtio/vhost-user-fs.h    |   1 +
 include/hw/virtio/vhost-user-scmi.h  |   1 +
 include/hw/virtio/vhost-user-vsock.h |   1 +
 include/hw/virtio/vhost-user.h       |   6 +-
 include/hw/virtio/virtio-gpu.h       |   1 +
 include/hw/virtio/virtio-scsi.h      |   1 +
 include/qemu/iova-tree.h             |  21 ++
 include/system/vhost-user-backend.h  |   3 +-
 net/passt.c                          |  19 +-
 net/vhost-user.c                     |  11 +-
 qapi/net.json                        |  16 +-
 qapi/qom.json                        |   8 +-
 util/iova-tree.c                     |   5 +
 38 files changed, 903 insertions(+), 79 deletions(-)
---
base-commit: 88aac004fb1bef50277d8484f4aeacf2e8cb9e38
change-id: 20260604-vhost-user-isolated-memory-070ed4833ee7

Best regards,
-- 
Connor Kite <connorkite@gmail.com>


