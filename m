Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F77CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7I-0005mO-VC; Tue, 29 Sep 2026 11:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7E-0005kr-2s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:36 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7B-0001QW-0K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:35 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so41022215e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697091; x=1791301891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pDEYfeYWnDK/VYlBPQMaQGpUz9FC3CZQpV/93VvCo1c=;
 b=NJCVoX57/CABFFAzs3qbFM/mo9mm1qUzexNr0PTcf+v6IyD/ICbN3+XaIWll4Dp68N
 5X3ZPsqO45n1u6Q71qID6uIk03zG7AlrysnDepBpPyOVSY3xA0KdV1jsVdakE0ap3zbj
 5JXECQMfss2ZdoF+BZhpkGE9OHZOG4J7Y7Wp37/Zzfddk83yvsIsG9VKf5g7qkD4mTY0
 TY/zFpVHObGbm4DCvRtAVVtvSvoS8WlOD+t2UTzDVJAf1TV9nDthjeo8FUUzG2cE3NJi
 4NQ6ZcgW2VXwSUY/cyP9IX9843enVKjdWUvOb64+Imt9ilOnoHUNZuiUtbQ/PDBOdAKp
 moeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697091; x=1791301891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pDEYfeYWnDK/VYlBPQMaQGpUz9FC3CZQpV/93VvCo1c=;
 b=h/KNSGzvAOw5TO29F730xYM27cMBNjSjDjMKrMP3X9Xc+mdLyt60uNt26WVoIs+S1U
 6nRGOanrLrQ52W1BGMfLZxG0XmRsZNSDYP7LVhKT6LJCxad19D/GfUhKoiq5ibdy9/hS
 fQlFYB4b7sVdjR0xpqUbB0K3kX7avqmnqpgAKfSzE8seFkw+cPUq4Sf5ZCv/0/CrzNrD
 1E8fW+DkUwHM8/3uLfx0pvmTisFveOnDAosSeV+17vcMsG0U/kJ7RuPudDLcgIT5dr+/
 roJdlN6jhKO4JkJneRn+2RIEYP3hSOTlI9LMDwS3FzIwfSpZPZhP+3kaGl8IhZQHtkMk
 +GBA==
X-Gm-Message-State: AFuF++l+o40iBaiJmwup5HHQ+T+D0OHwNHmhd67fTHbLAHzRf8PuT94a
 XDhp18YEUvDcePHI69kF0ljku7f5wlDxmVbUKU5ryCos1v842Lc4x5tnjpNvPj9YBO8uaUMcwjC
 XhP5k
X-Gm-Gg: AYBFou3yxwhGfG3NRbejxeU7ah9K+6DwLssu5NvVjqcoaU6MPXtfs4l8397tfnW8E91
 PV6VlUfm75WYGDrOnAPMU7Kb/vwrZ+4s1mzRQgujrWgWQ6SDFL/6VRWY8xttPaitpsIMdkWPF/0
 fUgSPPy/ZWuvyJwGvBD0+aiS4rY6PaIR6dP2rrvFyXYhLFu1Ud6ZNjUWj6cIzleoh/9w1NB+Vho
 6ozCIzFZzY4daIx+HN2FZKT3H7iKlovxB5BxCyS0Ts6ROQxvexPe/FsrhLy1yCkefqTooks5lV7
 Ux9hiKOZsWGk53W5Iw91m/kZ/Dv1pQcDgdrV9jQ2EYfENZLoltCkFxwawi5ys+hJu39OrYMtyha
 2WvMk3yZiNRdZqrGuJMwhn14fZUzAHriEv/2LgKvGj3ZIkcD4YU+tX74wGAjcW08HOxyDkAMdQA
 s5La0033Wmi/3Kn0higxY1izxf0MS+53Y2+HU2vyHKDUhXN7QMePaL5aJKvg==
X-Received: by 2002:a05:600c:1d1c:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49fe66c9ae3mr284038925e9.3.1790697090708; 
 Tue, 29 Sep 2026 08:51:30 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 0/9] block: cheaper zero handling in backup and commit
Date: Tue, 29 Sep 2026 17:51:16 +0200
Message-ID: <20260929155125.3151111-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

v3, all from Andrey's review of v2:
- 3/9: the commit message says which permission stops whom. A device or
  an export asks for BLK_PERM_CONSISTENT_READ along with BLK_PERM_WRITE
  and the job withholds CONSISTENT_READ above base_overlay, having to
  share WRITE or it would block its own writes to base; a job target
  asks for WRITE alone and is stopped by the op blocker instead.
- 4/9: assertNotIn() rather than a bare assert, and test_bitmap_straddle
  checks the target map, not only the content.
- 9/9: zero_widen is a bool again. A task widened before another task's
  request was refused reached the write loop with the chunk still at its
  full widened size, so it wrote the whole range as one request with no
  BDRV_REQ_NO_FALLBACK, against a target which had just said it cannot
  zero by metadata. The chunk is now bounded whichever way the flag was
  read, and a request carries NO_FALLBACK whenever the target is still
  believed to oblige.
  block_copy_chunk_size() is called under s->lock, as its own comment
  asks for.
  The commit message no longer says a refused request wrote nothing:
  bdrv_co_do_pwrite_zeroes() fragments by bl.max_pwrite_zeroes and a
  driver may refuse a later fragment after an earlier one landed. The
  range is rewritten whole, which is safe because zeroes over zeroes
  change nothing.
- Reviewed-by tags collected on 1-8.
- rebased on master

v2, all from Andrey's review:
- 2/9: holes spelled out in both layouts, and zero runs added, so the
  write-zeroes path of 3/9 is covered too
- 3/9: COMMIT_ZERO_CHUNK has a comment of its own saying what bounds it;
  the cache check drops its dead half and asserts instead
- 4/9: a Case namedtuple pairs each size with its layout, and
  create_image(), write_layout(), dirty_layout() and backup_and_check()
  take out the duplication
- 8/9: g_assert_not_reached() for the sync mode which cannot reach there
- 9/9: a widened write-zeroes request only pays off where the target
  zeroes by metadata. supported_zero_flags rules out the targets which
  cannot, and the first widened request asks for BDRV_REQ_NO_FALLBACK to
  settle the rest, since a driver may advertise it and only learn better
  from a failing call. A target which would write the zeroes out fails
  that request without writing, and the run keeps its requests at the
  buffer chunk size from there on. With the size question settled that
  way the cap became BDRV_REQUEST_MAX_BYTES rather than 256M.
- rebased on master

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (9):
  block/commit: pass BDRV_WANT_PRECISE to block-status
  iotests/040: cover large and fragmented commit runs
  block/commit: batch block-status queries
  iotests/124: cover backup of zero clusters and holes
  block/block-copy: don't reserve memory for zero tasks
  block/block-copy: extract block_copy_set_task_method()
  block/block-copy: track known-zero source clusters
  block/backup: pre-fill zero_bitmap for full/bitmap
  block/block-copy: coalesce write-zeroes tasks

 block/backup.c             |  93 ++++++----
 block/block-copy.c         | 300 ++++++++++++++++++++++++++++----
 block/commit.c             |  58 +++++--
 include/block/block-copy.h |   5 +
 tests/qemu-iotests/040     | 102 ++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 tests/qemu-iotests/124     | 347 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 8 files changed, 825 insertions(+), 88 deletions(-)


base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
-- 
2.53.0


