Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67603C3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjWz-0001KY-9E; Mon, 24 Jun 2024 09:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjWw-0001Jt-LG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjWu-0004w6-RY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421a1b834acso35123225e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234883; x=1719839683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jUiTjipz16kDFkSWdbtdxsn+m5GfMffXJu7+QAIykmg=;
 b=pz7rf+796BE+wKdLdwrmENElPJY9OpgPvVKwPrx3jPkjfth4kjmDuPsxI7XP6hKbZq
 t0C9NXhC2jPgkjTdBs528gzivOwpX3BpUe3H7592C9yZsGXHrS9lYS3sF83ZGPyqD9a5
 R4bAHRGgtBl2c1ujDII5DiR/0uuU1YX8TK2JxAwKLeI3DfhnX2wAYfz33l1kowaQcWQk
 BGNyqd+gvmyVvYiyAv6qZxkdCv9Zu7sJ//aaU+Qsrf+FArXNzVl5ugUwuqFwtYzdVFEq
 tjfoz+58vHMSNnnSa7EW2u44lJdlo8JbSWqQoJCaotvHxztHJ60WVM16pYpDab/Qv1P/
 qeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234883; x=1719839683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUiTjipz16kDFkSWdbtdxsn+m5GfMffXJu7+QAIykmg=;
 b=P5nmzeIAYGpDIC7sY0QNj7xrdxERDuECRBqYO1m1VvsfRB77uFFcH/IYT/gk68C+i9
 Swc1ad3EPKRn1BIPFr8LkuJsX+3vryIOJA9lEp7Dhhr0vtYidkFJdG7fTDfHbVzfgdNS
 WwRNF58AzF2eLajDZNxTxtYyozhmcTUt2N3V8NjA1LtdrtCc+jpfmycgwQGOUYEjKGgJ
 t7xcj+Nr7/6ygL5SoeQ4D/w+oLAx4uBW6ZNVwKRm1aQhZT7hPGObY67mEdk/CHXD1N0G
 lv0BervUqdB6BnrbF0uJa9Px1lxwSx2aN2p3sANmjswJw5oPxPiHwX/3qYnA1H+uC41u
 7NaQ==
X-Gm-Message-State: AOJu0YwOClGZv5BQYW50QUB7SjBm08AQNwj8DtNFC7uCbbbc3ekwr4A2
 psdr3oPrvs71LyF44TarpOf+AS8VXD+32P6nVw09jwGKBblwR1aB3GNkgshSzrcPPhKr06xeU8H
 7
X-Google-Smtp-Source: AGHT+IGFas2y4tPpFjSEHDizfW8bjwEtL2m4guQOmueLzGw5Us201/pws8QyGS4Y6dYbwimX0C6hZA==
X-Received: by 2002:a05:600c:4748:b0:421:8429:79ba with SMTP id
 5b1f17b1804b1-4248cbe1c56mr32946805e9.0.1719234883045; 
 Mon, 24 Jun 2024 06:14:43 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481921f16sm133366215e9.41.2024.06.24.06.14.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:14:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/19] SD/MMC patches for 2024-06-24
Date: Mon, 24 Jun 2024 15:14:21 +0200
Message-ID: <20240624131440.81111-1-philmd@linaro.org>
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

The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:

  Merge tag 'pull-target-arm-20240622' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-06-22 09:56:49 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/sdmmc-20240624

for you to fetch changes up to 76ae9a231487a2b127c90bcb657fd42a1f6c06f8:

  hw/sd/sdcard: Add comments around registers and commands (2024-06-24 15:08:40 +0200)

----------------------------------------------------------------
SD/MMC patches queue

One fix and various cleanups for the SD card model.

----------------------------------------------------------------

Philippe Mathieu-Daudé (19):
  bswap: Add st24_be_p() to store 24 bits in big-endian order
  hw/sd/sdcard: Avoid OOB in sd_read_byte() during unexpected CMD switch
  hw/sd/sdcard: Correct code indentation
  hw/sd/sdcard: Rewrite sd_cmd_ALL_SEND_CID using switch case (CMD2)
  hw/sd/sdcard: Fix typo in SEND_OP_COND command name
  hw/sd/sdcard: Use HWBLOCK_SHIFT definition instead of magic values
  hw/sd/sdcard: Use registerfield CSR::CURRENT_STATE definition
  hw/sd/sdcard: Use Load/Store API to fill some CID/CSD registers
  hw/sd/sdcard: Remove ACMD6 handler for SPI mode
  hw/sd/sdcard: Remove explicit entries for illegal commands
  hw/sd/sdcard: Trace update of block count (CMD23)
  hw/sd/sdcard: Have cmd_valid_while_locked() return a boolean value
  hw/sd/sdcard: Factor sd_req_get_rca() method out
  hw/sd/sdcard: Only call sd_req_get_rca() where RCA is used
  hw/sd/sdcard: Factor sd_req_get_address() method out
  hw/sd/sdcard: Only call sd_req_get_address() where address is used
  hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report invalid mode
    switch
  hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK macros
  hw/sd/sdcard: Add comments around registers and commands

 include/qemu/bswap.h   |   7 ++
 hw/sd/sd.c             | 245 ++++++++++++++++++++++++-----------------
 hw/sd/sdmmc-internal.c |   2 +-
 hw/sd/trace-events     |   3 +-
 4 files changed, 151 insertions(+), 106 deletions(-)

-- 
2.41.0


