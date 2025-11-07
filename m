Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF0CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqM-0003Sr-Fz; Fri, 07 Nov 2025 09:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqI-0003Qi-JS
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:34 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqG-0001ti-VE
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429bf011e6cso839038f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527210; x=1763132010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yp8KMMgUvKnxKtL9QZHGuo+bT1CzG82i3SYFL2gwN24=;
 b=KY2UOA0ykEVOawt1gTPjQvgDRD/X9uU0F5Umdo6+Y+dyc0DCLUk6LxZ9jkWBDuC7cN
 DbqJ4ILAFl4e20rK55A0A2zy/I0+d23GFcqmZqurRVbEnDLAR6PQgZXGz1R8WMFs7teH
 YLCrka3Q3SdoFoqhYzP+eNsO8bnRCV+tG3tNlPL4irgrGkNRx+Xm7Kb+3G7IWQ5qwyU0
 pxipU0aIJva4GmRSevhynyhgRZNGdIfu4ignu7+3FEb56Z22qsAvHF/NhkiCwDK3iuzr
 obnmTsOcQvvxU+M/siRAihCj1WdzpYGdiB/pNcWLVC5zephaW1RoFOE3nsOISVo+KQvP
 p/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527210; x=1763132010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp8KMMgUvKnxKtL9QZHGuo+bT1CzG82i3SYFL2gwN24=;
 b=h8jqDJ2KYnVPKZJOvP10QxpkM7W+W/m/XGGtwyzSXWBUI6+9HnDoWB+t5HBJ8PYLh7
 oX9j/gjGA6Xy0fuT80N9SK2HNlL9owVYiTNvUgjKMUVnwaWUZDJO6s6HJ7RPeVnl8Y7s
 4EhjK8NuSp7sl0BotG7B7WmHRoXsUU0jgiBHltmesuH7uxLiXmhb9sL6fTEtIVYxVLPH
 WxdRKe0MgSQhPiA+mrdUWla8VKRH6A0YJIxIKijjoWdLTQvObjxXZ7s1uPZcEqV+X39H
 5kUGeb9cpJVEIOzJN50TRd383CVhcpQTVBcmI0k6yijqDGVnUdZZWLUDyLFHCv6W5zu0
 lfdQ==
X-Gm-Message-State: AOJu0YzXypkC5YQMjmh4R2/0wJObMw2g2dqYh/lYuQSSaoEorkRT0nrE
 UkVGW3rlCNblGKH4U6X99IIA/XSKWWIbEQvXgPxKFs082x1WZm734n3yVjmguW4jKw==
X-Gm-Gg: ASbGncvDFDlNzTaWl6S0kw7UZ2a6TXSzblczFQ4OBFRM3vz7WHZTCOg5ubeUR1Am1qW
 aMBmq4igo5i05yc9Yros9qaY1o+hJFyIGnJTlimSFI+nJNs7QoljCIO7KhCGDPcOKdrsM2xxhaM
 XAeU8NZut2qQv2Q5ritDuPfSllxn3kDaj+XtOYh6fHOmytVbHzFgIfvCuvKVe/0knFAASvfbZz/
 1d5/FY68NYeqpCvAFYFTae6zfe5rcnubUeFUCD598KlX4HVOeU0iy92OXwfFnkxl7jdM9vJtlQb
 Q9oTN02FV7CPq0ZBSe5vvTzaHZwtxEnZfO3TRsyk46UCsl0A2nPqVWWHXZ0Ybreb0PBobjFAGys
 vY+/TtiuecI5n7I91yY6ds3KCVPeOoqOd/zuv8Hqx1/rhZJtC2TQglj2OrMJR2cR7XaUmH47SX7
 rrmjtm0HE5RIzToCdDKQ==
X-Google-Smtp-Source: AGHT+IHDNaymfK26JdBKgkh/r0KSyFZ7NKBOp8Aruazz2+D4HabuQDffGuq5jfeEawU/uK3GNbWeSw==
X-Received: by 2002:a05:6000:220e:b0:429:d3e9:661 with SMTP id
 ffacd0b85a97d-42ae588157fmr3089086f8f.15.1762527210369; 
 Fri, 07 Nov 2025 06:53:30 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:e453:acd:db85:b66e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm5922435f8f.20.2025.11.07.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:53:30 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 0/5] block/vvfat: introduce "fat-size" option
Date: Fri,  7 Nov 2025 15:53:22 +0100
Message-ID: <20251107145327.539481-1-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x429.google.com
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

The main goal of this series is to introduce a new option "fat-size"
within the vvfat backend (patch 5).

This series also includes minor patches:
 - patch 1 introduces another option to create unpartitionned disks.
 - patch 2-4 are minor improvements easing the introducing of
   "fat-size" option

This was tested on with a aarch64-linux kernel taken from
functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
workaround, not included here (the SD bus must be associated to the EMMC2
port instead of through GPIOs).

Changes since v1:
 - patch 1:
   - rename option "partitioned"
   - add qapi entries
   - add option in vvfat_strong_runtime_opts
 - patch 2:
   - make FAT12 1440K the default instead of FAT12 2880K
 - patch 3:
   - introduce rename VVFAT_SECTOR_SIZE
   - replace BRDV_SECTOR_SIZE as those are actually VVFAT_SECTOR_SIZE
   - introduce VVFAT_SECTOR_BITS
 - patch 5
   - rename option "fat-size"
   - add qapi entries
   - add option in vvfat_strong_runtime_opts
   - replace floppy 1M/2M size limitation by 1440K or 2880K
   - correctly round up when "fat-size" cannot be expressed by CHS values.

Clément Chigot (5):
  vvfat: introduce partitioned option
  vvfat: move fat_type check prior to size setup
  vvfat: add a define for VVFAT_SECTOR_BITS and VVFAT_SECTOR_SIZE
  vvfat: move size parameters within driver structure
  vvfat: add support for "fat-size" options

 block/vvfat.c        | 353 +++++++++++++++++++++++++++++++------------
 qapi/block-core.json |  16 +-
 2 files changed, 273 insertions(+), 96 deletions(-)

-- 
2.43.0


