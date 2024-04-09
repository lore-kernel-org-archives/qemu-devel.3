Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBC8C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5xv-0006bk-JC; Tue, 09 Apr 2024 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5xt-0006bS-TR
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5xs-0001bS-CB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=yN25dNjIRJzP6mehu1GsBxm7hv+uEe6Eqr2axuzW8YA=;
 b=VEWLcrXPVNRmhEN+OO6MdWDgngo7Txknu4izNgj8KkzlKvPIOJdcSVxH8/rV1y1BaNI9Ea
 KQzXSDoTEBJ2aEnBRj99xiOMUImBex24mWf1QbNTjn/EmkJt1ITON59QB/9In9qSllJME2
 oTCtWoyr8NrcyeQhzLwXHM6vw2Szwj8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-8wYkyDp1PBOymE6Gsj7rWg-1; Tue, 09 Apr 2024 03:32:17 -0400
X-MC-Unique: 8wYkyDp1PBOymE6Gsj7rWg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56c1ac93679so3712773a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647935; x=1713252735;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yN25dNjIRJzP6mehu1GsBxm7hv+uEe6Eqr2axuzW8YA=;
 b=wB5GH7ho+KCY0qahTs4Fj4TH1RNQH+iST6rD3tP4aCHMgpBTp/T+oAUwJdM3U+525C
 HhLxWRICS0W/YBtOHiA28bYmc1AQ17FwwCO5cOkbR7OmFTdrI83SINaNeiAQeCX8kfJl
 hCZUOKfsEhP0/7wS3rFPKUbwnZyqgZ/qAGG90fpMCYlBoc/clNa/gVoWza6AulKdZr3x
 CblYBNcRAXzpJOhl7D8Lt0/h9g/oP/kOMfS7lpXNUMily6Najd8I55FLOJ9hpqzt6zLF
 UdC/KU2Z0aKHHOuFsoTthraG87MDPTZCEpJpFcZQ0mUf2eSUm6PmeqU3jmfy1gj6C3gW
 wmiw==
X-Gm-Message-State: AOJu0YyhNk5mdujx8eqgqcnnqdYzX2mYM7B0rs3a+Ky1AmFQcsSOZsZg
 vD9ZlfErgQN3IYVP4WlKOkiMbXA2ErdwpTZppeQr3rzs5l/PQXImUJL8uYklHuPkQlxEefGc3VM
 tEH0Bxgu9e9GOCK6h04BYkGp1yrXQ6yG6FpqHGi/rovtBszJJjKKtzH2WKAi61dPcwnzi4S+Zxo
 XhYlZvshV6M/L1Mw+OQD78nJdxGVePpQ==
X-Received: by 2002:a50:c30c:0:b0:56e:2d0e:ae4c with SMTP id
 a12-20020a50c30c000000b0056e2d0eae4cmr7910155edb.39.1712647935239; 
 Tue, 09 Apr 2024 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFefUWfpZ3fnmPUx5AxbgvyDhQvryh8G/YV1Qku0AcRUniFXN9cX1az9h5ejYWjQJyO2hmj4Q==
X-Received: by 2002:a50:c30c:0:b0:56e:2d0e:ae4c with SMTP id
 a12-20020a50c30c000000b0056e2d0eae4cmr7910129edb.39.1712647934636; 
 Tue, 09 Apr 2024 00:32:14 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 fd21-20020a056402389500b00568d7b0a21csm4892084edb.61.2024.04.09.00.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:14 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/7] virtio,pc,pci: bugfixes
Message-ID: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:

  Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e1999904a960c33b68fedf26dfb7b8e00abab8f2:

  qdev-monitor: fix error message in find_device_state() (2024-04-09 02:31:33 -0400)

----------------------------------------------------------------
virtio,pc,pci: bugfixes

Tiny fixes: important but mostly obvious ones.  Revert VDPA network sim
for this release as there are questions around it's maintainatiblity.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Manos Pitsidianakis (1):
      virtio-snd: rewrite invalid tx/rx message handling

Michael S. Tsirkin (1):
      Revert "hw/virtio: Add support for VDPA network simulation devices"

Vladimir Sementsov-Ogievskiy (2):
      vhost-user-blk: simplify and fix vhost_user_blk_handle_config_change
      qdev-monitor: fix error message in find_device_state()

Wafer (1):
      hw/virtio: Fix packed virtqueue flush used_idx

Zheyu Ma (1):
      virtio-snd: Enhance error handling for invalid transfers

lyx634449800 (1):
      vdpa-dev: Fix the issue of device status not updating when configuration interruption is triggered

 include/hw/audio/virtio-snd.h               |  16 ++-
 include/hw/virtio/virtio-pci.h              |   5 -
 include/hw/virtio/virtio.h                  |  19 ---
 include/standard-headers/linux/virtio_pci.h |   7 --
 hw/audio/virtio-snd.c                       | 129 +++++++++----------
 hw/block/vhost-user-blk.c                   |  11 +-
 hw/net/virtio-net.c                         |  16 ---
 hw/virtio/vdpa-dev.c                        |   7 ++
 hw/virtio/virtio-pci.c                      | 189 +---------------------------
 hw/virtio/virtio.c                          |  51 ++------
 system/qdev-monitor.c                       |   2 +-
 MAINTAINERS                                 |   5 -
 docs/system/device-emulation.rst            |   1 -
 docs/system/devices/vdpa-net.rst            | 121 ------------------
 14 files changed, 97 insertions(+), 482 deletions(-)
 delete mode 100644 docs/system/devices/vdpa-net.rst


