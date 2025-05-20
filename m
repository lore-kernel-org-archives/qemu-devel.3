Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E30DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRj-0008Rn-AA; Tue, 20 May 2025 13:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRd-0008OL-N4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRb-00014s-L8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BSChp/yWLfyXdo35ujhhjyxtrDWB+YIA7jVW4YRKwBU=;
 b=gNys7Xxq40mAC6O5MwrzaHBlMHh7iZNHo8KENARz0nSONqPV+tCY5e+DHV1DXgJjiBySeZ
 1tyDlE4kiPHCUdTJTwj+HBRqaaa4hWtgLqM7J7j+SF9Niagmf837DxC40qS/S5y+5p/G14
 Ke3jUxJBytfIONskTBqItz76QdHIzbw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-sKzwsujMMXGbjl7khoaKHA-1; Tue, 20 May 2025 13:07:55 -0400
X-MC-Unique: sKzwsujMMXGbjl7khoaKHA-1
X-Mimecast-MFC-AGG-ID: sKzwsujMMXGbjl7khoaKHA_1747760875
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5b9333642so679823585a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760875; x=1748365675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSChp/yWLfyXdo35ujhhjyxtrDWB+YIA7jVW4YRKwBU=;
 b=U0yhOSJFBZtscZrog6lIl82Fu9tP7AfIhsFthClPmG6BzJxxwCzFoG434ebunXDu6g
 qiuQLPP/CRsp6ys4oJ1wbq5lsR9+XrYQQrv4PHnWZSes8YgqYWFtK+RxXtb0gL1CCKCJ
 aKtVduH/XGlchY4l1MhYl42IQdNtF67vWTiL3glVedtrnvDoLGCb9Zsa73Mv08ntvKjR
 x9x8faED4vCwtejsQCzOzRUaNHubnzAT+7B6ip1BmD/bMxM3bh7K6y3Es8ENylXGmSIg
 5/GDSBiM2Aiqn0lYsZz1CmTI8ee7LNfnAv7GLZ0f68UKkUSj1xR3HNQdCGMyabXEv29C
 H5VQ==
X-Gm-Message-State: AOJu0YzZro1lnllh0X/7UenWXKc8FUdUIYnQprbT2P8w6v+sbao9CuIB
 gee9ZxnnG83jqCvzqaYqn2+UpE6j/wckVSYmlxfUWGt/YPZv+4eQKdolk4InF2zYAnjiSyw+4Xp
 L/XBhnFV3JYBTN3c4zsBIMUi2r02zdPj0XDzsJQ4OIfYOHJmkn8mck0slfxnitmit0TsXA1HWEB
 ls5DMSDvLHPmv8K5Lcsg3CbPEd8rIQzVg63/UjmQ==
X-Gm-Gg: ASbGncs4Ld5iJlOQrJzw1WIRuUoYuqcqMeZIkrI532o1CbCAt+Bqhe13TKVwTn1Ry9i
 /qlsPsZN5O65z4F9Y/Ce5Hupk3BL7HXJ9ytcxhFFy+Pcu9TSEk3S3TbJvNn6HqiCmAHn/r3npp8
 VcsO5nA/I5IZCf4eWw1lpezxCUvYhwhsPe08gq/B15wU7c1rH8EoTgSDF8ew8nEhFvgKYVd6M2J
 8iuFq4rF6bVJzYjMBKEmWVqegP63+RTQpXcvxhNVt+rNx31DW4n9dbUrP3bWJbt7i9hIGmBp0JC
X-Received: by 2002:a05:620a:408e:b0:7c5:3d0b:a565 with SMTP id
 af79cd13be357-7cd4677d684mr2587654785a.46.1747760874924; 
 Tue, 20 May 2025 10:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpuWfLRORU6oytwGXYn0r3gOmzpFpEFc7c1dGoG9mIQQQp+XdYs7bimh57NuJqFRtTYC/qtQ==
X-Received: by 2002:a05:620a:408e:b0:7c5:3d0b:a565 with SMTP id
 af79cd13be357-7cd4677d684mr2587647885a.46.1747760874283; 
 Tue, 20 May 2025 10:07:54 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com
Subject: [PULL 00/12] Migration 20250520 patches
Date: Tue, 20 May 2025 13:07:39 -0400
Message-ID: <20250520170751.786787-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 2af4a82ab2cce3412ffc92cd4c96bd870e33bc8e:

  Merge tag 'pull-riscv-to-apply-20250519' of https://github.com/alistair23/qemu into staging (2025-05-19 14:00:54 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20250520-pull-request

for you to fetch changes up to e09c6d837593aa1e12d92d7031c65a881eb2eb27:

  migration/hmp: Add "info migrate -a", reorg the dump (2025-05-20 13:05:57 -0400)

----------------------------------------------------------------
Migration pull

- Peter's vmstate static checker entry for recent hpet change
- Zhijian's rdma test patch to properly skip tests when locked_vm too low,
  and ipv6 test
- Fabiano's few CI changes
- Prasad's last patches to enable postcopy on precopy-multifd
- Maciej's fix to disable multifd zerocopy for device states
- Peter's HMP change to "info migrate", plus a small fix on cap set

----------------------------------------------------------------

Fabiano Rosas (3):
  ci: Re-enable python subtests in qtest migration suite
  ci: Fix build-previous-qemu when the version tag is absent
  ci: Reduce the size of artifacts for build-previous-qemu

Li Zhijian (2):
  qtest/migration/rdma: Enforce RLIMIT_MEMLOCK >= 128MB requirement
  qtest/migration/rdma: Add test for rdma migration with ipv6

Maciej S. Szmigiero (1):
  migration/multifd: Don't send device state packets with zerocopy flag

Peter Xu (3):
  scripts/vmstate-static-checker.py: Add new hpet entry for num_timers
  migration: Allow caps to be set when preempt or multifd cap enabled
  migration/hmp: Add "info migrate -a", reorg the dump

Prasad J Pandit (3):
  migration: write zero pages when postcopy enabled
  migration: enable multifd and postcopy together
  tests/qtest/migration: add postcopy tests with multifd

 migration/migration-hmp-cmds.c            | 186 +++++++++++-----------
 migration/multifd-nocomp.c                |   3 +-
 migration/multifd-zero-page.c             |  22 ++-
 migration/multifd.c                       |  14 +-
 migration/options.c                       |   9 +-
 migration/ram.c                           |   5 +-
 tests/qtest/migration/compression-tests.c |  18 +++
 tests/qtest/migration/postcopy-tests.c    |  27 ++++
 tests/qtest/migration/precopy-tests.c     |  83 +++++++++-
 tests/qtest/migration/tls-tests.c         |  51 ++++++
 .gitlab-ci.d/buildtest.yml                |  27 ++--
 hmp-commands-info.hx                      |   6 +-
 scripts/rdma-migration-helper.sh          |  57 +++++--
 scripts/vmstate-static-checker.py         |   1 +
 14 files changed, 373 insertions(+), 136 deletions(-)

-- 
2.49.0


