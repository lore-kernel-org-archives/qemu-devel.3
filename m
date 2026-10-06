Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2436CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMws-0005qB-8n; Wed, 07 Oct 2026 04:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHNt-0003ex-3n
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:28:08 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHNc-00005B-Nd
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so5975082a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791339885; x=1791944685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TZOfmi5mG5OCAxMHsC6zb/xNyNb2wNZaVrEkpt6l/4c=;
 b=QzE3sNNJDePsXU/1HMLjqEFOS92M3hOc05Ho1BkPnMo1QfgGjwshYsikD7H/fBIHY/
 1fPLFjXHgyjFZiBSvKwIQ0LeU/q0Yu2z8PBA6x/AjME5/QpRvRqzjVdeaOmE4biVGo2Q
 X698dW87WP0vV6JgNHh6v6jsqzkFeZXBE8pe2a6TGiC4xlEw+gVRB+sVTs8lPWcGz3At
 i1PD5hCMER8tl8BLHoUiX3JCw3FhcDegLH6EmeWggO1NpMHfSChlT7CZOlEENYrpVxnz
 9RsBlrACsa5fTGGKXCYzE78b0M8+U+sQocytFY0+Us52I/j156DY8ADZI3/0iZ37IWLt
 Ku5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339885; x=1791944685;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TZOfmi5mG5OCAxMHsC6zb/xNyNb2wNZaVrEkpt6l/4c=;
 b=lHhEu1uEDepV6Z6Icc2L4w3uQXbiUk5uRwMxxekMlBGPef4/ls/h9s5kalCc7HM3rK
 lol+GdRLyaDWBDjAPJdY+6ctgZ5JaiBd4gtEWFnwdbutakIhH7UV4V/J5THxzEK1FuK6
 s1Ix0zFYCV88FQuq2TBLs6BE8+EOe3cmXc1P9PGQoNPMqv7rGycysGy5XpwJbpNgB6jJ
 5c7+GPSjxtilFs8hSiMeD4GwyfRx+i4geh9Ba1YLtRf+gkCpUhArIG34cGa5jFQF0QCm
 Tla+YcAUBE2fvxh1Cte2825xRe7TtcgAzZxZi5w+hlS41CU6YWC6zlu6yvpyWuyFHzHZ
 p8yw==
X-Gm-Message-State: AFq9FYJI78aU1rl39oe0CRYPWzYDTI3/H4MR+nLJFdkrj0DDXVRXvxen
 vlNtQS6UroWAXkFlciOdUKW9sqGjWRXHAx5o6JRn4ft/Ghk3BUreKWDg4OwXuQ==
X-Gm-Gg: AYBFou2by4MYDIRO31V1gY45qviZl/DpIYUVswAEvAZKERadHXIbRgPXQZr+HQUPEsl
 UeLkx9fYqHaS0Kd8KyBdH01uh1OemKaKsUDZBKUKNFXKB4HXDjbyZ4XVT7xcjDFOHPGqwTO3Ess
 akStmcrhGWN6c/ph3a3zcEePPqaG5R3wMxxFPx454aLza6Td4tOBlKUzynHbA8IYExSaCGl3A9z
 XDCXdSc00eacEz7rwSIwWkYDVPQujjU1+oRmcnhVHiU9pr9zAh9TLPmX653kQ/90DH8bzqrKTDv
 N8DWJ6Fl6aBS1UbqxF0IRnV4qRenaqpPI3CzoSVK9OazBZBjWNaoR1zrIvboLZTyDmz/R6KgYtz
 rrONN423+GSl4K6fPCR7pqJ70sPUlmXm6+5DdFEeZR+uBk8yaes4H0kJkVWPlUCJLuJbG39ND8O
 SbSUJ+6OdzwYikmjxOJrfE54pvh2XHM4tZcFpX/4xVscbtIbOK7LlfkgpgnfSQKzrDiCoiXtYuO
 F5Q1ly0SieSiMv63vkUwEP5Lm//eK5xcJr0PA==
X-Received: by 2002:a05:6000:490e:b0:487:2777:6354 with SMTP id
 ffacd0b85a97d-48c4800db9bmr17057925f8f.48.1791279904211; 
 Tue, 06 Oct 2026 02:45:04 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:03 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 0/8] hw/sd: Improve performance of read/write/erase
Date: Tue,  6 Oct 2026 11:44:39 +0200
Message-ID: <20261006094447.43491-1-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

This patch series improves the performance of read/write/erase operations=0D
on sdcards.=0D
=0D
This is done by increasing the maximum buffer size that is worked on.=0D
From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512=0D
(adma commit).=0D
=0D
Testing on my system with fio I see the following rough performance=0D
values in MiB/s.=0D
=0D
              read write readwrite=0D
       master:   6     6     3/  3=0D
 first commit:  51    43    23/ 23=0D
second commit: 392   180   144/143=0D
=0D
Tested on a 2GiB raw image with:=0D
  fio --filename=3D/dev/mmcblk0 --direct=3D1 --runtime=3D60 --time_based --=
bs=3D128k --rw=3D{mode}=0D
=0D
The adma values are somewhat unstable but always >100MiB/s, I'm not sure=0D
why but I guess it has something to do with the host side caching.=0D
=0D
The fifth commit fixes the DATA_STAT_AFTER_ERASE bit in SCR and=0D
introduces an option to allow to erase blocks to 0x00.=0D
=0D
The sixth commit optimizes block erase when erase-blocks-as-zero=3Dtrue=0D
is used, by passing the zeroing request down the to the block device.=0D
Erasing 2GiB now takes 0.1s instead of 26s.=0D
=0D
Signed-off-by: Christian Speich <c.speich@avm.de>=0D
=0D
I'm picking up this series with the changes indicated in v5 below. Please l=
et=0D
me know how I could improve attribution to Christian in case I missed somet=
hing.=0D
=0D
The last two patches are new and are small cleanups.=0D
=0D
---=0D
Changes in v5:=0D
- Rebase onto master=0D
- Split patch "hw/sd/sd: Use multi-byte/block writes for block path" into t=
hree=0D
  (first three patches)=0D
- Use sd_blk_{read,write} with additional parameter directly rather than ha=
ving=0D
  sd_blk_{read,write}_bounce_buffer=0D
- Drive limits and write protect groups are preserved to be checked on bloc=
k=0D
  boundaries only since these checks are redundant in case the SD host=0D
  transfers one byte at a time.=0D
- WP_VIOLATION is only raised once the first protected block shall be writt=
en,=0D
  rather than immediately at the beginning of a multiple block write which=
=0D
  starts with allowed blocks.=0D
- An off-by-one error has been fixed in the same case where one bye too les=
s=0D
  had been written if a write protected block had been detected.=0D
- There are only two rather than three code paths each handling the multipl=
e=0D
  block optimization.=0D
=0D
Changes in v4:=0D
- Rebase onto master, no changes needed.=0D
- Renames:=0D
  - sd_blk_{read,write} -> sd_blk_{read,write}_bounce_buffer=0D
  - sd_blk_{read,write}_direct -> sd_blk_{read,write}=0D
  - to_erase -> erase_len=0D
- Extract erase logic into sd_blk_erase helper=0D
- Enable erase-blocks-as-zero by default. Add compat for 11.0 and below=0D
  to keep it disabled.=0D
- Add cleanup commit to update trace events.=0D
- Link to v3: https://lore.kernel.org/qemu-devel/20260204-sdcard-performanc=
e-b4-v3-0-dc1cf172ee57@avm.de=0D
=0D
Changes in v3:=0D
- Rebase onto master, updating read/write path for newly added RBMP=0D
- Split up commit 1 into multiple commits=0D
  - change interface to allow "short" read/writes that are continued=0D
    by the core later by calling again=0D
- Link to v2: https://lore.kernel.org/qemu-devel/20251202-sdcard-performanc=
e-b4-v2-0-d42490b11322@avm.de=0D
=0D
Changes in v2:=0D
- Properly set DATA_STAT_AFTER_ERASE in SCR=0D
- Add erase-blocks-as-zero option to allow the user to switch between=0D
  0x00 and 0xFF for erased blocks.=0D
- Link to v1: https://lore.kernel.org/qemu-devel/20250919-sdcard-performanc=
e-b4-v1-0-e1037e481a19@avm.de=0D
=0D
Bernhard Beschow (5):=0D
  hw/sd/sd: Transfer up to one block in case of multi-block commands=0D
  hw/sd/sd: Add buffer argument to sd_blk_{read,write}=0D
  hw/sd/sd: Use multi-byte/block writes for block path=0D
  hw/sd/sd: Retype state attribute to SDCardStates=0D
  hw/sd/sd: Remove unneeded forward declaration=0D
=0D
Christian Speich (3):=0D
  hw/sd/sdhci: Don't use bounce buffer for ADMA=0D
  hw/sd/sd: Add erase-blocks-as-zero option.=0D
  hw/sd/sd: Optimize erase blocks as zero.=0D
=0D
 hw/core/machine.c |   1 +=0D
 hw/sd/sd.c        | 230 ++++++++++++++++++++++++++++++++++------------=0D
 hw/sd/sdhci.c     | 102 ++++++++++----------=0D
 3 files changed, 225 insertions(+), 108 deletions(-)=0D
=0D
-- =0D
2.56.0=0D
=0D

