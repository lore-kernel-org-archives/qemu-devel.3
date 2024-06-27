Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BF8C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsIN-0002PF-7Q; Thu, 27 Jun 2024 12:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsIL-00027P-Fy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsIJ-0001II-K3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4256742f67fso5282285e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506902; x=1720111702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XPfbsngGwyqGCSepCuHgwTNIJlNkKqJ4vIpzLqZ6/LY=;
 b=rmDKoPgUdUaljfXpLtQFHepSe8+VwhH9j837P9cs2jGbm4ZAuKd7BPpsylbwKzJ+Zx
 3VzsLBsLOzzBXmS1QHjk09qOZqM3onCeCeAOQ09o/ng8rFZN4IoxKQi2JETguFNbx9/3
 mrq7LK4ybm4zbAWGJ2//8VNu7hWV/McJ/9uA+D2/ey7w2q5jMV/Vhz08vw/v9vQkQb8f
 sxTHBQRHAP0cRH+9SXap2878cSWZbUn7TlqmrrfKCE1PkAoIkcn88+4Bebkjuqxi+sYE
 qEKC90/twzM1qo5JXvDlXYSRavZfYqqmBIeOZiZkqVqPYGRmqHH3q4lGAqAhzW2UPVXB
 2hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506902; x=1720111702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPfbsngGwyqGCSepCuHgwTNIJlNkKqJ4vIpzLqZ6/LY=;
 b=FsNRzgMEmCIz6Yy9SedMfKmyaE2Ss4khxyoUBWHycNHjymsxsF+Kcdy/bR6ofX501o
 slWwmI/ThyWvHPG3pYMZTShXDn07Mzb9eDKN6X5HGpe8Fv0ED+kHGrHHz6WEd/F80uq8
 si4eTvXsPTie8XDBNi/sFPYRfVQqyCYbMryXNB0C+mRWCitbilBy/PGZZ65iD0UwnZUc
 eUtYZkFTQkIuqHj57/gTCdrF10ZNrKG9U/QW3lBc6IvCGTpoqEpWJtCYnN3GKs3Ms+i1
 PuVZX80+53xqFxI5lVLVSX/S9NjqRHO4gM0vREaBtl5QtBwbwHLWo6RYWuLy1TBG5gnb
 S30g==
X-Gm-Message-State: AOJu0YwqkQS+XoYqnJpNRerjf1FZzFY4Sj9ncSMLGevh2CKeSTp6Z6rA
 Lol3bypnQWlxhpEqNrgdzyyTs7KUO0rv1BGMzDLbWm+g4x28rrN5Aq/bsKleikjrevDrfHSL5zQ
 7Uo0=
X-Google-Smtp-Source: AGHT+IG5MDj5bFj+B0TegV2ubpXpHfEt0TvsI+7Jt4AbeCQOzIBWwPYSZao4YaB1h+ARD3AJ24MRfw==
X-Received: by 2002:a05:600c:257:b0:424:a3d7:2a86 with SMTP id
 5b1f17b1804b1-424a3d72b8fmr52182375e9.1.1719506901792; 
 Thu, 27 Jun 2024 09:48:21 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6d4asm38478555e9.36.2024.06.27.09.48.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:48:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 00/12] hw/sd/sdcard: Convert ACMD to sd_cmd_handler format
Date: Thu, 27 Jun 2024 18:48:02 +0200
Message-ID: <20240627164815.82606-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

For each switch case in the big sd_app_command() function,
extract the corresponding sd_cmd_handler.
Few housekeeping patches at the end.

Based-on: <20240627164345.82192-1-philmd@linaro.org>

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Philippe Mathieu-Daudé (12):
  hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler (ACMD6)
  hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
  hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS handler (ACMD22)
  hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT handler (ACMD23)
  hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler (ACMD41)
  hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT handler (ACMD42)
  hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
  hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
  hw/sd/sdcard: Remove noise from sd_acmd_name()
  hw/sd/sdcard: Remove noise from sd_cmd_name()
  hw/sd/sdcard: Remove default case in read/write on DAT lines
  hw/sd/sdcard: Trace length of data read on DAT lines

 include/hw/sd/sd.h |   1 -
 hw/sd/sd.c         | 256 +++++++++++++++++++++------------------------
 hw/sd/trace-events |   2 +-
 3 files changed, 119 insertions(+), 140 deletions(-)

-- 
2.41.0


