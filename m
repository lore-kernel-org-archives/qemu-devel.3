Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11985105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GF-0005Tk-9t; Fri, 13 Mar 2026 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fq-0005QA-RX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006KP-Q1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so1603616f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411144; x=1774015944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqEgCTohdCQ4MG+mvo4UTLutrABkzWrvkS61KwtZXxA=;
 b=j50mq47njJEY+5KRn0tM0FkPBch2Resg2LlfD1TkPLH6yakcvbZO1mvOXlaGVIkkDH
 8Eu5HOd0IyA3ZtCsOzeV0aFWQX/b4f88mwISrv/EccinuU26BWpEcUghOTKEGmgr3zLr
 ZJpxe6xtinEPUxOTmvRNMpt/lwDnTjTOmh96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411144; x=1774015944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqEgCTohdCQ4MG+mvo4UTLutrABkzWrvkS61KwtZXxA=;
 b=LCk/HWG/7SgzaUJOJ0ooPds7z7llYBSAmkSTrsTFV9YyflE6VDyFQc4G7TlrVc2nZa
 vBPR03pQrRJqBkJle9WqTse8aJw0YPiFMz09F/lOZKpYDtEm+IZtqYxWN8BGpNDBOf/v
 0E1UT2DeSihz2pv/ZwiyC/6x8eMH7txZPQq9Jcznm48yKnlmzZfuO3o2zr7CskyS9xiO
 1kKexOeSaJ8wQ5DbfoWngl4OFAHF8OKuXWVW+DiAj/UG3KNzpt08Zc/Xk25NbuGVyyyW
 lnm7dQ6WtfFmpTr7nSGISiF0sX82GetDAGsAHOJOYI7IYaL9JXaSpjYAXXngjIngZw5K
 uEIQ==
X-Gm-Message-State: AOJu0YxrQheRDCwSmWt1FcLFkz05L+vWCziV4PGsBh0kWaTvEZH6ZPQt
 pW85918qqkL2BIE6MmBWctxYveFMLBu3x36hsRYUmYsGfV4v/l335u5b6CpNvgCWs/ekdapHF94
 sm0z4jkY=
X-Gm-Gg: ATEYQzySrCzYSLdEfPQihOdo2H2V0gQusyVn/RYzpPObhhimD4eWMoe4fMxKjelkrRy
 ypvcuYFG9S/0+Iu1v5e0OlGZOsdggVms9E9gJcZ6Cl+ssuCFTYq/wwqUOFQis8rCnG0TMqg4V+m
 epl02q/H94VhXeXbZ8XZqQiVpB/m2ggjW5nuzkxNYiXF0QjQoDFYFq7hL/1Mk7H1KV6+BgG0708
 oG3Ce+CiE+WGcjwnkKCRhnKA/SCGXzDF7LDWQrV89ZSjZod3ik+i+GtsDdkUeSbFcLsIelWyhVW
 INQv+t1W3PM1D5OrGXuXRxp0uVwYUeC5SGykKYtHTOoedv3akOyhaow6gR10ohLM6VhHjSlURH6
 WHZLUiwp4sXUtvGFLtkrjgFN+UG335X/JPXCeInPaEfQ2voukTIPsy5mr6P8lEXCbf2Z6PmxnUA
 GEFe2nGp49WpT7XVs7iMYw+rCSjkGIe2eraUxjx8dE2oTWevbZ+2uLo9xfMukElnrTZo5/D644A
 HQAajQmol2RUPHJ0wRbT9Q=
X-Received: by 2002:a5d:5e01:0:b0:439:bc2b:cb50 with SMTP id
 ffacd0b85a97d-43a04d70f87mr6523852f8f.4.1773411143759; 
 Fri, 13 Mar 2026 07:12:23 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:23 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 0/8] hw/nvme: add basic live migration support
Date: Fri, 13 Mar 2026 15:12:13 +0100
Message-ID: <20260313141221.359503-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x429.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset adds basic live migration support for
QEMU emulated NVMe device.

Implementation has some limitations:
- only one NVMe namespace is supported
- SMART counters are not preserved
- CMB is not supported
- PMR is not supported
- SPDM is not supported
- SR-IOV is not supported

I believe this is something I can support in next patchset versions or
separately on-demand (when usecase appears).

Testing.

This patch series was manually tested on:
- Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVMe disk
  (root disk was virtio-scsi):

time fio --name=nvme-verify \
    --filename=/dev/nvme0n1 \
    --size=5G \
    --rw=randwrite \
    --bs=4k \
    --iodepth=16 \
    --numjobs=1 \
    --direct=0 \
    --ioengine=io_uring \
    --verify=crc32c \
    --verify_fatal=1

- Windows Server 2022 VM (NVMe drive was a *root* disk) with opened browser
  playing video.

No defects were found.

Changelog for version 4:
- vmstate dynamic array support reworked as suggested by Peter Xu
  VMS_ARRAY_OF_POINTER_ALLOW_NULL flag was introduced
  qtests were added
- NVMe migration blockers were reworked as Klaus has requested earlier
  Now, instead of having "deny list" approach, we have more strict pattern
  of NVMe features filtering and it should be harded to break migration when
  adding new NVMe features.

Changelog for version 3:
- rebased
- simple functional test was added (in accordance with Klaus Jensen's review comment)
  $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build

Changelog for version 2:
- full support for AERs (in-flight requests and queued events too)

Kind regards,
Alex

Alexander Mikhalitsyn (8):
  migration/vmstate: introduce vmstate_{load,save}_field helpers
  migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_ALLOW_NULL
  tests/functional/migration: add VM launch/configure hooks
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  hw/nvme: add basic live migration support
  tests/functional/x86_64: add migration test for NVMe device

 hw/nvme/ctrl.c                                | 874 +++++++++++++++++-
 hw/nvme/ns.c                                  | 160 ++++
 hw/nvme/nvme.h                                |   8 +
 hw/nvme/trace-events                          |  11 +
 include/block/nvme.h                          |  12 +
 include/migration/vmstate.h                   |  81 +-
 migration/savevm.c                            |  26 +
 migration/vmstate-types.c                     | 102 ++
 migration/vmstate.c                           | 138 ++-
 tests/functional/migration.py                 |  22 +-
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 ++++
 tests/unit/test-vmstate.c                     | 157 ++++
 13 files changed, 1674 insertions(+), 77 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


