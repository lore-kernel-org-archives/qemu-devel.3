Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873C606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=bCMQeSox
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb4l-0002C0-OZ; Thu, 29 Oct 2026 21:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4Z-0002Av-5m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4X-0006Do-7n
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so78736f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322379; x=1793927179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WN1TEIh+MQULrjFV2jlh/eYakp5ID90UfJMb3juTMMk=;
 b=bCMQeSoxuEzNy0OAFwEM+LhDgqOxAXGlD9u7C/BBQiBodwaJ25wOqVawcRyqEYwWU5
 WDuB71jWdspB7mwcqP/8vZ+HwnHSZ6xaguY0Sruy4o+7agTgU588TQWm/2lgHLHY8FII
 ZwCVREH9J3fWvYq8Ux7iMAHzwFXpWyI1CLmYNO3r27N2IM1NspUbRoWdVa86xmoc7Hqm
 IWzfXLWL6h9lWBjONhhiBj6outeQDRX6GlzzXOx1nT6Zb0cAGiaHg9wWtRaHAm/je3pY
 lcUSMdOJ601Mbye2YVwhw1PaYvg7mARijqEurELVEl27Zs7I8RCRjQifXl3kzE3jZ0bC
 gqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322379; x=1793927179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WN1TEIh+MQULrjFV2jlh/eYakp5ID90UfJMb3juTMMk=;
 b=upi2PblcxQMH8WzOMjfepM6cpwIL7QB/3D3h/Y1fpqn+RGochPKzgeRDLP0p2Y8Kcp
 Ea1tDXnh6BpJUxmvkQSLoNutaVtrWHWPxuWeMOmbe8oWEQbine1Yi9ktEa90EeFrN34Y
 rPG7t/+Iydi17VNQLhGpVEyB4ehOofKBI5cXDtwa8RYQirOx2Dic6HMmUxVcUOWZgpmg
 iEz7WIUoezsF3s77xUdlC7OCxuN+pAGxuTexxS9rJt/EoxOoRrUbinDxGrpyAW1Q7oa4
 s8SMfgZ3qaZxzHsbWdGTPG+Wu2FTahciH4pks6cirr/+SXoL/EL59hWItkFkxDek52Cu
 sNeA==
X-Gm-Message-State: AFq9FYJkRZcdBaP5ME9ZegziCp7mNPNJLxewX3P8XoONZr+8kL6iixQK
 xhkikkFBKgI9AdYKrmWOSKeZt16ukTyeKqqzXQPiVadqgumFK7bV80XSMs1ATqG3804OdmMF1QD
 FI7up
X-Gm-Gg: AYBFou1SCPAY4PItjO47J+invfAnyE/O54V+Xv/8Rrs9hSg4GEAbrC7t7SZ5kl976Qv
 weApo+DZ+r7uQ3CeTWsNJCY679idYiEC55ZUNksRP2QDG3C29hdCpekApI6ixzA3mTeVz/f/Tz+
 ma8MWscIiE7/ieXcV/9A5b2Z5R6wmWAwJYkFGvaV7jDvRsv3Zbf/iQ1D3qitC4OS66Hh4ws9PzL
 7GiDVmoEOkEzSta/pj8DPOITs81ek35iMLthFK7P3cdb+VUEZ+a4e7Yq8DW1g58kbTMBIdYFI5g
 xkJ1tc8ilWVKxL+j+GtoNsrtsENYC2hsOPKPDdGMxlv82Y8sOMJIoUoNzZHpIIC/z5WJiOxTrHZ
 bO5c0Xutd2BP43zEkCiZkD6E0d8ppj/KbG8yG7V7VbVCOEQlfvx9kKwcrBYlK9aNgyIo8Weufd9
 SXMOkdAG0T9ZEaOBLrOp6isS12abQdb7HLiy8GBBppIMX2cVUOS9iAkGKSyyCrSCulai784wQVS
 BdH21z8+yeaxYE66gyL+ZYrSEPf40K91Figer8bvU2GFCNqn3xNk49bC527kbbFIKllQolXQds7
 +p2q4iOhgaNYQi3pzg==
X-Received: by 2002:a05:6000:4804:b0:48e:390:80cf with SMTP id
 ffacd0b85a97d-48e6e2fe070mr2027211f8f.32.1793322379243; 
 Thu, 29 Oct 2026 18:06:19 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v4 00/12] block: cheaper zero handling in backup and commit
Date: Fri, 30 Oct 2026 02:06:00 +0100
Message-ID: <20261030010613.1612771-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=den@openvz.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Backup and commit re-query the source block status for every task and
size a task by the copy buffer, so a long run of zeroes turns into a
crowd of small write-zeroes requests. This series reuses what the
up-front scan already learned and lets one write-zeroes task cover a
whole run.

Backup of a 16G qcow2 image holding 1G of data, the rest never
allocated, sync=full to a raw target on ext4:

               tasks    time
    before     16384    1.6s
    after       1088    1.0s

Such an image is the normal case rather than a corner one: a guest with
discard enabled on a disk which is mostly free leaves exactly this
shape behind.

Eric, this is the v4 you asked about on 10-28; please take it instead
of v3.

v4, all from Vladimir's review of v3:
- v3 5/9 "don't reserve memory for zero tasks" is dropped. On its own
  it let a write-zeroes task bounce through a buffer that s->mem never
  charged. Its accounting change moves into 12/12 and applies only to a
  task asking for BDRV_REQ_NO_FALLBACK, the one sure to need no buffer.
  Its Reviewed-by tags go with it.
- 7/12: each prescan step moves past the dirty area it searched, so a
  full backup of a fragmented source no longer searches the same range
  again and again.
- 8/12, 9/12 and 10/12 are new, the follow-ups asked for on v3 7/9:
  block_copy_is_cluster_allocated() becomes block_copy_scan_status(),
  the two prescan helpers merge into block_copy_prescan(), and
  zero_bitmap_valid becomes scan_done, published together with clearing
  skip_unallocated.
- 11/12 is new: co_get_from_shres() and co_put_to_shres() skip the
  mutex for zero bytes, which 12/12 makes the common case.
- 12/12: the serial fallback loop is gone. A refused task shrinks to one
  cluster and the rest of its range is dirty again, so it comes back as
  buffer-sized tasks running in parallel instead of one request holding
  off guest writes to the whole range. A task asking for NO_FALLBACK is
  left out of s->mem and of speed=. Widening uses
  bdrv_dirty_bitmap_next_zero(), drops the MAX() with cluster_size, and
  is no longer bounded by x-perf max-chunk, whose documentation now says
  so. Andrey's Reviewed-by on v3 is dropped since the patch changed.
- rebased on master

v3:
https://lore.kernel.org/qemu-devel/20260929155125.3151111-1-den@openvz.org/

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Eric Blake <eblake@redhat.com>

Denis V. Lunev (12):
  block/commit: pass BDRV_WANT_PRECISE to block-status
  iotests/040: cover large and fragmented commit runs
  block/commit: batch block-status queries
  iotests/124: cover backup of zero clusters and holes
  block/block-copy: extract block_copy_set_task_method()
  block/block-copy: track known-zero source clusters
  block/backup: pre-fill zero_bitmap for full/bitmap
  block/block-copy: rename block_copy_is_cluster_allocated()
  block/block-copy: merge the two backup scan steps into
    block_copy_prescan()
  block/block-copy: replace zero_bitmap_valid with scan_done
  util/co-shared-resource: skip the mutex for an empty request
  block/block-copy: coalesce write-zeroes tasks

 block/backup.c                 |  86 ++++----
 block/block-copy.c             | 326 +++++++++++++++++++++++++------
 block/commit.c                 |  58 ++++--
 include/block/block-copy.h     |   6 +-
 qapi/block-core.json           |   4 +-
 tests/qemu-iotests/040         | 102 +++++++++-
 tests/qemu-iotests/040.out     |   4 +-
 tests/qemu-iotests/124         | 347 ++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out     |   4 +-
 util/qemu-co-shared-resource.c |   8 +
 10 files changed, 829 insertions(+), 116 deletions(-)


base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
-- 
2.53.0


