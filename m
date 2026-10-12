Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EFCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDjo-0005dy-6j; Mon, 12 Oct 2026 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjd-0005cX-Ar
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjZ-0000ux-J2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e6038cebefso13673325ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802700; x=1792407500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0dqYzNApRQoNNC0uAX5q0N9WC/lz55+6Baf3QX6PGPs=;
 b=sUzJ44YLXjUtTIuoIziuK9ZZGRVpgLyPcCSfLAnhMnp2/8eJjqPILtUxkdO4EujGln
 WHIi4SyDU4xqIKL2/hlibXtZJenpNpQ/lnMOBpizjo+A+TqZ/hsk0JgfVqwloy2Gv9Gx
 MY6xtdcasFxAY22BNQVycdByWsyjAXi2LanTPZoU6td0VIkuXQDtemuWtMI+7wUkyYYL
 PNI3GQqF2DfGzWiyQrzS7n3G6j8YFdGk/T0wDvjbg4kpd4Mg/t+TBqPpHfYb2bKkeSFr
 RQKJa14bApR2qc93r0gjVjJRcZvDpSXFfS42Du2GONrfJkqA5bupRAtMMnu96cyttjCr
 MF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802700; x=1792407500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0dqYzNApRQoNNC0uAX5q0N9WC/lz55+6Baf3QX6PGPs=;
 b=l8TPOlXbRI9KPHdTxGeVXvwyyE/rqgN5bMUtN0KQSMCWRKXRnG85TfsEme2tjx2HKr
 MIOnwolV4XWjE2S6paYsnQjzAhUfriJipzmNkG2bBqfXXgYBYHjlgT0H1rknhCH5iQrV
 a9m1l0HCAuQQUFQQOqzHiyTywn8YIiJ3TCplb0PgM6m96g7SfJholG5JYY9//2/kB/MK
 5SJ9LUSPagppbNwjFiV+NB4ANEuBPoiMuKAPRay1R6EBvS5V24rRcPi4h6txdNteBeKb
 3J105P8tTb5Ipui760EpaIZPnEtNl1n+u5Uy5Z2ajj7UvHneojJSPBQg4K6nMN7rUHXP
 50Lg==
X-Gm-Message-State: AFq9FYL7994uhOhBk64xhQAZKWAAuL2dk6xB9+iHtQ0NryC8WCbSYYrN
 l+dHM1oGexbVsEh8fBjl/Xd1YAyytgUUxLvIi5yj93hUvVYlTGFTrfMo4pGKJA==
X-Gm-Gg: AYBFou2nhOtEyvtimJJgvgwA4I9/8GeC0iSuaa3pw8PW6QWG2BwzNXWYaWxeC9IALmi
 HHi9U5/CV0z3lbvQB6w+EmCKuQGXonAmHq6XuM01YGaXqZOqU9DEDl5MKgpG+I1U3e0XKktamVc
 zdW8hSAxv1JZEp1yMoMFL8pc9ffpAp2BzGz+pISWbps9r6RNx55qoD8p+zxyAAeg8pXsw7r3cjg
 ZaO8khdReLH7LU5E4Mr2JwO7DLk3K9JX5A0uOlRZ+TkV/LKMv0ZNPvdQbemU3Hgm5xIcIVGl62G
 8/j0MtHbrRId7mCx47q8JPg2ofVj6TvZ86/21hDlvWEDGEmhr4NqQwU+s7C+5VE6nmMLJ1kuG2S
 nUusvbIbqYk2bKhLy7A8KqnhYCY7YbjFSPEqrmM6fbfgdbBDwx+JlEGEEXOExtgk8tutfhoqHLt
 ynaz73uUKPBzReB6xXhEajVcu3BK8Wf6Ta/kDhDFOxKyWpjhcDAIykeHnGP/dwS+yAj6b4PKw20
 JM=
X-Received: by 2002:a17:903:1a0e:b0:2e8:4066:d247 with SMTP id
 d9443c01a7336-2e842ab27c7mr78449285ad.33.1791802699836; 
 Mon, 12 Oct 2026 03:58:19 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:19 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/5] ufs queue
Date: Mon, 12 Oct 2026 19:58:02 +0900
Message-ID: <cover.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20261012

for you to fetch changes up to c44c626e28f1c87e89decaa73756d081f069b9d3:

  docs/system: Add UFS emulation page (2026-10-12 19:50:56 +0900)

----------------------------------------------------------------
ufs queue

- Track and cancel pending SCSI requests.
- Add QUERY_TASK and ABORT_TASK handling.
- Add UFS emulation documentation.

----------------------------------------------------------------
Stanley Jhu (5):
      hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req
      hw/ufs: Support MCQ runtime interrupt and queue status registers
      hw/ufs: Implement Task Management Request (TMR) handling
      hw/ufs: Skip nullified MCQ submission queue entries with OCS_ABORTED
      docs/system: Add UFS emulation page

 MAINTAINERS                      |   1 +
 docs/system/device-emulation.rst |   1 +
 docs/system/devices/ufs.rst      |  88 +++++++++++++
 hw/ufs/lu.c                      |   8 ++
 hw/ufs/trace-events              |   2 +
 hw/ufs/ufs.c                     | 268 ++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h                     |   1 +
 include/block/ufs.h              |  17 +++
 8 files changed, 382 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/devices/ufs.rst

