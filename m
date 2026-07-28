Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE3CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtR-0003Un-7p; Tue, 28 Jul 2026 11:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtP-0003U4-IL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtN-0002fz-RC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so11651f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253132; x=1785857932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5sKp2itri8XtEuW1d2au5iVYJlJl7pZfK+8vHK3lTjI=;
 b=KZC599tdYvcygoAiA4Dijd2hGDZZcryGvCNdHAJSxJjSUlBoLfmYoI54yCOUlHdZEx
 lCE/k+1OrCHZcvGVOWlDZtmx8CaQQqtsCpx0HnD3/2RW4hs/GAmvxGn9RWi9aTHsFgBK
 4CKRnSQd3QhRfrHL+E7bllZjlucLg++YILtHs/yjz4uwgbp3wm60pPpAGNGZwHqYy0BP
 G1prLBJtCoSLGfsDsQjGCmjskRmgvFDhSPbqMBfHeSGYCdxhYZn/vxXl2JR9gLY+NPim
 Wpx/GlhjG7ulEo8BwsGm1NtA3lxEGxxsn6IjdKqeccaKZ2jrrTwqyp1yIei/ZDRZvTYA
 Ilcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253132; x=1785857932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sKp2itri8XtEuW1d2au5iVYJlJl7pZfK+8vHK3lTjI=;
 b=EF8XTe1pqJE7+Wde/r7jLiXkkFtIQePB7i/N17FmnLrSn7KKdde/dA1x2E/0xm++o0
 xyBLcWxW8Ei0s8zxHjGJPSRxM1a4YjKh6F10rFjx3xU2QgAANpOvAW0GmushKxGVlNuX
 wQjYk8VVwkUG2Cs3GRCJnCunDX5n0Qli5wMaz7DdnCqj9CcMs4clQkgkgOCsRlHCZpdy
 AtQxEORd6SK+DE9Dswy2N5PY/4ic/nyW2EqODBmAUQfie+RFWn5tf84DVFWPOQ02lvQK
 1QP9YU+pJ1OCby3lqu8p5a+xQGkaGw9piF77hXNm3POOx53IpQ4bUVs3WlHiFmFay4H2
 wTwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/pPhb1YIU9xf5lNzvAZLX0mS4sfcpvtF+r3cqf62EKPPnIjf0zf9R7EjX4SB9Si5bsi2XoIvvIODB@nongnu.org
X-Gm-Message-State: AOJu0YwPQOV3bvv3l6eaRh7LHWg46bPvZzbwZufTiaVd0ksrdZKfAIif
 V16KvC6lefQaH4XSZMXSr8iirLOCfuwcV4SNu2Nt3XaeWa4gw0ov6auQSo9brkhguC4=
X-Gm-Gg: AR+sD12b/8sTnuvcitNXI3Ju/L8DDzlMe5i3McbBF37zRLwUEdcqEVr/aTM4jK13edY
 of1cZeOMOFxvTU3+EwbRHnf/2Er0j26Ty+rWguCX8DkksE2wRE0khXUYHUhZGnnBYk8dR2D2IKE
 kxgTvEAGgsPIqiDKTgCBtK7oxgXXOqfjivojUodxE+1UxBc44V+G15aEH5/Unw+1uv4OFYOOySY
 OwLv+gcBqAj5WNVREklA258Ay6UaBp90SXbg3g0A5SgutMuyUJqyllxOvHnceGL9gyabZhCGK0c
 eB6jK1lk6SHqYuAQ4fPYNnUpkH5xkoD/RYJov1WaonuNYDrJ3zfi1Kvj4LyX9Kgr7rNDGat/V+f
 amUgy5uGvW7lUMeevajfVWyBHPB25nFZ/iGQMU8bL9XmjaTuZnLz9wYGA+j+JfcMmWs0xGJnzaw
 ==
X-Received: by 2002:a05:6000:4011:b0:47f:4fbf:7b21 with SMTP id
 ffacd0b85a97d-47fb1ec8e11mr3662945f8f.12.1785253132236; 
 Tue, 28 Jul 2026 08:38:52 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
Date: Tue, 28 Jul 2026 17:38:40 +0200
Message-ID: <20260728153849.601939-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=den@openvz.org; helo=mail-wr1-x42d.google.com
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

The following changes since commit 6333226c2abb72f31648c251624c56e70993d625:

  Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu into staging (2026-07-26 08:30:07 -0400)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-07-28

for you to fetch changes up to 352587cbe2d4cde1cece16e2f6a9e1e4190a03e6:

  MAINTAINERS: update parallels tree location (2026-07-28 16:55:00 +0200)

----------------------------------------------------------------
Parallels block driver patches

- fix a reachable assert()/process abort on a crafted image with an
  inconsistent BAT vs. advertised disk size (GitLab #3804)
- fix related integer overflows capping the format's usable catalog
  size below its documented maximum
- reject BAT entries pointing outside the data area in either
  direction
- harden the dirty-bitmap extension loader against a reachable
  abort and an unsafe allocator

Changes since v1:

- filter out format specific info in patches 2,8

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>

----------------------------------------------------------------
Denis V. Lunev (9):
  parallels: fix integer overflow in header size calculation
  parallels: read header/BAT table in bounded chunks
  parallels: fix bat_entries overflow in image creation
  parallels: reject BAT entries pointing outside backed storage
  parallels: validate bitmap L1 table size before allocating it
  parallels: skip loading a genuinely empty bitmap L1 table
  parallels: avoid fatal abort on large bitmap L1 table
  parallels: validate BAT capacity against advertised disk size
  MAINTAINERS: update parallels tree location

 MAINTAINERS                                   |   2 +-
 block/parallels-ext.c                         |  52 +++++----
 block/parallels.c                             |  74 ++++++++++---
 tests/qemu-iotests/212                        |   8 +-
 tests/qemu-iotests/212.out                    |  10 +-
 tests/qemu-iotests/tests/parallels-checks     | 102 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  53 +++++++++
 7 files changed, 264 insertions(+), 37 deletions(-)

-- 
2.53.0


