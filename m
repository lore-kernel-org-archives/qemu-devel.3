Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1ACC369B9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 02:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4soT-00026F-RP; Tue, 15 Apr 2025 22:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u4soR-00025T-Lt
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 22:47:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u4soO-0000Vw-UK
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 22:47:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso5429291b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744771658; x=1745376458;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRX5DWX1J5odec4kJXVIOK1ovAUrij3fW9QCY2FCljA=;
 b=xgmcCRfB3eJhh7yHWBLnGHe/o3aUb+hVNPtQuQfpKr6obg1o/w0ysM9labeXjVE7Ld
 BYc1uzuFwHSMZOEJlp8Fq4LpB3lKYaWXKJxuciKJzFLk4vZu9Mp79DbUpvW3ndOakUZ2
 heNIwy4XNkM5007XsIGAy4/PAcK5HnnP3vBPFCZCQe9wX2X+0sXxOIpqeSNm96koD9DI
 zi3aozU1OEZQ0xyGECeKajjQFSkNGDdtsYCUsxYxT9uMg+52t8KEvbzPzWikWyTXZQs7
 DwJA44I40lUpwsXRhvc5SASk3KzEL34OscueY+/Ps023eYBHzQkpx0SPrfj7TSl1OBHo
 l6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744771658; x=1745376458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRX5DWX1J5odec4kJXVIOK1ovAUrij3fW9QCY2FCljA=;
 b=Fnc4yrYAwdg10K0vfAcyH8daaI31Jnxu39qgFVXpgMchdkpPehQrkUxuZ9t49/euyx
 ZmKDE5R53Z8GDVhOxj9sTMN3tpIvrSSL5JTn3Z+JcgqIaa6pjq+ZSUKy2TgL0sgFeV6s
 GT/C0bdjNILyDOCmNL7zJTe40QI5DZ3PaQmha9Yc8sEJcTeLgFkrZ0m2sG53emhj4HIp
 Vjsj7cXahfw3+8N4uSzbNUwEyVN/K+XA0BjmyPW0DsG+x/juidAFNUR6ALRqenc72T/r
 9mgEDoSbe3Kh3vEkZ2O/gf73PYaYM6CuYHD3v7fIWPeefBVOnNNsOSSsRvynvnLdvclR
 ZaPg==
X-Gm-Message-State: AOJu0YyqhoY100SuLxyP1xiO8lviFrsaSnuU5FIRWP/Uh6K4FlljgVsz
 z3ScUWE+aP/AedOZaySMsXSJ3wAY2r+q5275gZV4skupDYzifD/6xCOs+aqT1XLfD5cUYmJd9NV
 sdnM006lY
X-Gm-Gg: ASbGncv+MBFey4Q3ePYnuuNEMoZGASXu2MBxAwstA67Ru/YfiJGGdvmpcGSKZAV08YA
 ddHRo5PLwl5FwKuJQrPUMU4SWSnoTjPNRAzN5bEiB5rE485Z+6PXBT/le96bn5EkUjQz0kqGYLS
 a99Q10CWzLPHjw3tlcYPmc/U7YgsIF82srF9YEy6OiV3l6StJPZXMYFz1/AyrNxuuxod8MNV/0T
 4FoWwNuRpE7gTfg619BeZCIrUR+isgRRVa4J2P8159u6pBC14HPp7z7nRALfJn7xKcPwkw7Mj6v
 r1Qxy19Y+DpXmXZRRC9PJTiVg+ga
X-Google-Smtp-Source: AGHT+IFQ3Ao/ER1izLhaTk7KQcVPXoZa8L+TTx/4F/2fO2nY6jvI66RFkQ8vXvNkel22p+27sLcSxw==
X-Received: by 2002:a05:6a00:4ac6:b0:736:9f20:a175 with SMTP id
 d2e1a72fcca58-73c266b5fecmr186298b3a.2.1744771658087; 
 Tue, 15 Apr 2025 19:47:38 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e305sm9624958b3a.140.2025.04.15.19.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 19:47:37 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 raphael@enfabrica.net
Cc: fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH v5 0/3] vhost: fix the IO error after live migration
Date: Tue, 15 Apr 2025 22:47:25 -0400
Message-ID: <20250416024729.3289157-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250401151819.1526461-1-haoqian.he@smartx.com>
References: <20250401151819.1526461-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=haoqian.he@smartx.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

At the end of the VM live migration, the vhost device will be stopped.
Currently, if the vhost-user backend crashes, vhost device's set_status()
would not return failure, live migration won't perceive the disconnection
with the backend. After the live migration is successful, the stale inflight
IO will be submitted to the migration target host, which may be leading to
the IO error.

The following patch series fixes the issue by making the live migration
aware of the loss of connection with the vhost-user backend and aborting
the live migration.

---
  v1 ... v2
    1. Fix some grammar issues in commit message.
    2. Remove assert in vhost_scsi_common_stop and return error upwards.

  v2 ... v3
    1. Added more detailed comments and commit message.
    2. Change the newly added type name and parameter name.
    3. Remove set_status_ext, change the return type of set_status to int.

  v3 ... v4
    1. Call set_status() only if the function pointer is not NULL in the
       3rd patch.
    2. Add the more detailed commit messages for the 3rd patch.

  v4 ... v5
    1. Fix code style issues in patch v4.
    2. Rebased on master.

Haoqian He (3):
  system/runstate: add VM state change cb with return value
  vhost: return failure if stop virtqueue failed in vhost_dev_stop
  vhost-user: return failure if backend crash when live migration

 backends/vhost-user.c                  | 20 +++++++--------
 hw/block/vhost-user-blk.c              | 27 +++++++++++---------
 hw/block/virtio-blk.c                  |  7 +++---
 hw/char/virtio-serial-bus.c            |  3 ++-
 hw/core/vm-change-state-handler.c      | 18 ++++++++-----
 hw/display/vhost-user-gpu.c            | 12 ++++++---
 hw/input/virtio-input.c                |  3 ++-
 hw/net/virtio-net.c                    |  3 ++-
 hw/scsi/scsi-bus.c                     |  2 +-
 hw/scsi/vhost-scsi-common.c            | 13 +++++-----
 hw/scsi/vhost-scsi.c                   |  5 ++--
 hw/scsi/vhost-user-scsi.c              | 18 +++++++------
 hw/vfio/migration.c                    |  2 +-
 hw/virtio/vdpa-dev.c                   |  5 ++--
 hw/virtio/vhost-user-base.c            | 23 ++++++++++-------
 hw/virtio/vhost-user-fs.c              | 23 ++++++++++-------
 hw/virtio/vhost-user-scmi.c            | 27 ++++++++++++--------
 hw/virtio/vhost-user-vsock.c           | 15 +++++++----
 hw/virtio/vhost-vsock-common.c         | 12 ++++-----
 hw/virtio/vhost-vsock.c                | 11 ++++----
 hw/virtio/vhost.c                      | 23 +++++++++--------
 hw/virtio/virtio-balloon.c             |  3 ++-
 hw/virtio/virtio-crypto.c              |  3 ++-
 hw/virtio/virtio-iommu.c               |  3 ++-
 hw/virtio/virtio-rng.c                 |  5 ++--
 hw/virtio/virtio.c                     | 22 ++++++++++------
 include/hw/virtio/vhost-scsi-common.h  |  2 +-
 include/hw/virtio/vhost-vsock-common.h |  2 +-
 include/hw/virtio/vhost.h              |  8 +++---
 include/hw/virtio/virtio.h             |  2 +-
 include/system/runstate.h              | 13 +++++++---
 include/system/vhost-user-backend.h    |  2 +-
 system/cpus.c                          |  8 ++++--
 system/runstate.c                      | 35 ++++++++++++++++++++++----
 34 files changed, 239 insertions(+), 141 deletions(-)

-- 
2.44.0


