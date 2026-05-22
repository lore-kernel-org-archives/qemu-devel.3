Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DBECD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMv-0001WF-0e; Thu, 21 May 2026 20:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMt-0001Va-AB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMq-0003FT-DU
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:03:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso65840195ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408234; x=1780013034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbJviW16wrS9UjnUJMMPqymoz8aG3OXb4ujxYPloMrk=;
 b=Ig5ENBcjPYrgpCO7xjUA9cqnNvSTeqmtRlg7BBrpkRI7k6axsZt4BJE+mXVfYYfMH1
 /sfxdCwclvUZuiyhrnKNhkV+ONTNH8FOyjerhnQvvAUnUfUX8+eFMmMz/xk5SvQxoqN+
 6F3oEfQU+xpKf7CQrNqOeKj9uXUjOK1YBBh9I3nRJf0IWs8sktTquKr2ZCUzZEoN0Plq
 I7kLv+2hk8jh+xO6VlkQZnvGhrDOCoT/1fTZZVBU476TFXGUz73qoQoNVEoQlMOPWOWm
 waIpRaaFLGgmzBBP5z+0Fknyl3gmXWXjdYAV5Oy3NP6VovH701UfLUYXJ9QbuQnTY2e2
 dhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408234; x=1780013034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EbJviW16wrS9UjnUJMMPqymoz8aG3OXb4ujxYPloMrk=;
 b=jZ+dfFU0V6sCkvN1AClm4z03fo80xQcagDYnN6h8w921DijmCbHyOcsvwIVbjSsQJa
 QBzNfkdQWqkHnzOhl7DoXE3WXvMRb9x9AcKQSVUyELiOnAQYIEa516XFBvFbTM/fwIBl
 rSvrkHvI+2hqxHbyH3lI8l0YtiBe6dr4296iO83RzUa4LbjENja49b3VGTXrN16i0HuS
 Qa+/RbavLQIpqTEVqDAidJxV22lq1xdbn2HLxd+NVs0JcEu4MYiWMr2DN0ZCJk+CUchK
 scCwGjO0/B7CyAjNQsIbWdf7nbHzSJpkDnbsNdM0MN0Crp1YxovflVpUkO3pLn2RmDNS
 Nrog==
X-Gm-Message-State: AOJu0Yx+cobjAPH4irTWU5VK++VyVK9Z5cX8M9uUOinTk6cEofsCxiJH
 M5FhACn5qB9uvmLSH5rmzVsIRSMowF32hmACXPVXKrOcwhgJdgeQBPKpmSR3YO57
X-Gm-Gg: Acq92OFedJwc7B1WHQQRP4BLsGmx2/SGA5F0U8SreE+hP/cNTGcbCdYTBK/eHl34Fo3
 u9+s8WO8x4X7WmsJo2xhmJ+jQX28YyNxFXSOwx/npNyFgzHxeKyEC0LN7WvxLyL2MT7nHpUEd2P
 rO2kSlh5s8A6hAFPrhEUdgNPE/fCFE5eqGQtE02IAPxw5sgO4IWEp32M5oJCoex1HIWMlRBAipu
 O68HzWscOUCzGEN3qZGhOXLFopxCzpZPYKmtiwwngVROuObDlO9Yqban4/aXoCQTHOsrDzOA0sg
 GztXW0ySIC7LETl84k90P78JZKdG2XcS+weD7+utCIwpl4Ia9rLErYrO54p2ifAdvvrUF/Tg3xh
 lgSYxZVyohQcp+kpxEjL2sBntodmKnqHJvsjNyljGmBrmZWN0KOFJltQIwzWe+9kuO5fQ1NIbPG
 HqhBNnNIzmH0oCLpQi/z9lggKmzvnJE0thKg6bE9lBRg==
X-Received: by 2002:a17:903:3c2d:b0:2bc:7d4d:3520 with SMTP id
 d9443c01a7336-2beb067ac30mr9660525ad.40.1779408234366; 
 Thu, 21 May 2026 17:03:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/48] roms/opensbi: Update to v1.8.1
Date: Fri, 22 May 2026 10:02:42 +1000
Message-ID: <20260522000324.23255-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
version 1.8.1. We're going for the intermediate/bug fix release 1.8.1
directly due to a PMP related fix that was impacting QEMU profile CPUs.

Changelog for v1.8.1:

* Typo fix in comments of sbi_hartindex_to_hartid()
* Fix hart protection abstraction for platforms without PMP

Changelog for v1.8 includes, among other things:

- IPI device ratings
- SiFive CLINT v2 support
- SiFive PL2 cache controller driver
- SiFive Extensible Cache (EC) driver
- SiFive TMC0 based HSM driver
- SiFive SMC0 based system suspend driver
- MPXY RPMI mailbox driver for voltage service group
- MPXY RPMI mailbox driver for device power service group
- MPXY RPMI mailbox driver for performance service group

Check out the full release log at [1] for more info.

[1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.8

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108160825.171794-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268752 -> 270384 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 273048 -> 275928 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 02be3a72a8..530709633c 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index cce35c65c2..fea7d35cee 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index a32a910691..74434f2558 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
+Subproject commit 74434f255873d74e56cc50aa762d1caf24c099f8
-- 
2.53.0


