Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF71606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cWl3TJGO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO9A7-00081Y-3V; Tue, 03 Nov 2026 02:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO9A2-00080f-Kw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:42:26 -0500
Received: from mail-dl2-x09.google.com ([2607:f8b0:4864:38::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO9A0-0007BP-18
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:42:25 -0500
Received: by mail-dl2-x09.google.com with SMTP id
 a92af1059eb24-1397ad3d891so709935c88.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 23:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793691742; x=1794296542;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cSV/luiiJAjYjkCeAEirIj16QItwEyOH39RoUcTYuyo=;
 b=cWl3TJGOHZqVgEm2+QqAzeF4yxFyMX4VFMh1bJYVcA/vjEyZ/C+cEPWXKsN8wefoBr
 QkPvUR2hOliGMpWNHwJB85yh3bZNfyqZWEDWPFZGeovZMiZfCkotX2SGnUCgEMxbvG09
 Yt7Azyki6j9GxPKa6dHNs+wlwU4iiSVDaFJTOm99c4awJ/uE4pTsTs8k4qXJ+BPrdUmW
 mfxT8aFFXbIKJ5097aIysrcqg5ibTzbNWILbH8qYfccF+ZjFUc7r80+l8VsOfWVIZ4GA
 e+3ak2cuVHF5scxtcVlhyBll3QCI9UCq+c0g0QsPyaiJy0PLqpwlTlbMwfnyeR/vtjQp
 ReQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691742; x=1794296542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cSV/luiiJAjYjkCeAEirIj16QItwEyOH39RoUcTYuyo=;
 b=1r1sjiN0BCc7SGGxiesKgYK+ApKe+eZYydxXuvMhezE55o+FhK6P9O1gniBemH61Ye
 Poo4z87ZSugZ2b3LzNbNuKdxXaPYfDqPuv7SkDBLgDGerzvjY64cauzWh/ylSTq13tYd
 VbuGgI2SatsPeTwctYGx2op0hX6gP7SvN/oAotZXVM0/6ERDOOujjO+WMzjFEezFPiHQ
 tg9avGgZ91EUsjy8KMTySncLdIbb1Bm/3PkHImAVhpFVtvE4Drkg7Xb3stWHNHHnrhdh
 oqkuVuISZgN4lJb7kx5ayoEtrMmBF3Pv3RR8IOKFew+9xktjpiUhOhIfq1fUeMLnJYOn
 zUng==
X-Gm-Message-State: APuU4Z/1bbepl6C/9DhpcisjARTgjdy1F6pI0apn+B4vCT6gtiOIx+lt
 x4kn+tef9x0hhifFb7XPUUCb3MA17E7eM8pnQB0PFD4oiEIFl7KkTpnp4fSOh1Jj0mWi+SFB5WP
 wZP9PuSe24Ciw
X-Gm-Gg: AYBFou0kh1eGWHVYP1njIyzD06LVZWjn0VPoiP8htrmPP6eTWdSsp5tHHrlFHM1/pKY
 S0MZr8m/bvNTHkvM7EDsTIOLhdhc0o5pB7FuqVDZSybbRvUiqElND0ex/6TB4B5sJ5T5CwRGg48
 0vWH8VsgKD4g89KurW90CwhcmdiwXbqlmPs4LIIrXEn0O9fC29iRXLYBsssLuHFmu8FX4e6SP7z
 XaaRXfPmIVZHV6+Hv+a8gwHO2EzBB4Mqo/7NdeVTYH/aaVKWVPkwOOojMAPQZ8H13xwWwsqdMej
 Q9w2xGgq2JzelwJKVCaMDr3p6GGxhzvi9+FYVy+52IMynog8MfoDMBCJZLGEFPkN0Ph8TUvuW+H
 x2lwrhZ9NMWprE1kp99uW7M6+AlaIKWU8ckrgnFl1uL5eR03GJHHFJw6u9xNXhaBws9Kp0jBW1G
 8weCkX3ah+XPNq4kFNrS2iOf23BoinoxbPJTOVilIz/dOYd/rqKI7MFVOubG2iaLxrXD9FaiC8v
 aJ3d3RiUxT1SYKnUj/e9u4FQNH3+ayrsuJ9CKh4ja9xtiDVToyzLSCBvKxjpAcqoR8RzKO++Q5i
 iPJfiHwH76tbrRj+8Uzftcsuq50/T9zwCBpYWStQ/2UPB6SgYzReYb/cJFwqEUTYEcxB8dI=
X-Received: by 2002:a05:7022:7e0c:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-1ac5f181878mr17754499c88.37.1793691741812; 
 Mon, 02 Nov 2026 23:42:21 -0800 (PST)
Received: from tewaros-MacBook-Pro.local
 ([2601:647:6300:1230:9da3:3d82:7292:c937])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c27cdsm68953076c88.10.2026.11.02.23.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:42:21 -0800 (PST)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: disclosures@theorem.dev,
	tewaro <tewaro@tewaro.org>
Subject: [PATCH 0/2] target/riscv: write mstatus.GVA on every trap into M-mode
Date: Mon,  2 Nov 2026 23:42:12 -0800
Message-ID: <cover.1793677945.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::9;
 envelope-from=tewaro@theorem.dev; helo=mail-dl2-x09.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Based-on: <cover.1793677944.git.tewaro@theorem.dev>
("target/riscv: fix mtinst/htinst for G-stage faults on VS-stage A/D
updates", whose hyp-guest.h and hyp-guest.S this test reuses)

Patch 1 fixes mstatus.GVA. On every trap into M-mode, GVA should be
set to 1 if mtval holds a guest virtual address and to 0 otherwise [1].
QEMU does not clear gva or set GVA for particular faults.

Both date back to 9034e90ad9. The fix sets mstatus.GVA from write_gva,
the value QEMU already computes for hstatus.GVA.

Patch 2 adds a test, all 4 pass on upstream Spike, all fail on master.

This bug was found while examining <cover.1793677944.git.tewaro@theorem.dev>
and writing a generalized test. Claude was used to diagnose the issue. All
commits were human written.

[1] Privileged ISA v1.12, 8.2.1, the description of GVA and the note
    under hstatus.GVA
https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12

tewaro (2):
  target/riscv: write mstatus.GVA on every trap into M-mode
  tests/tcg/riscv64: test mstatus.GVA on traps into M-mode

 target/riscv/tcg/cpu_helper.c        |  4 +-
 tests/tcg/riscv64/system/meson.build | 21 ++++++++
 tests/tcg/riscv64/test-mstatus-gva.S | 75 ++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-mstatus-gva.S

-- 
2.54.0 (Apple Git-157)


