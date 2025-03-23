Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45715C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 14:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twLu7-0007Yw-7O; Sun, 23 Mar 2025 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1twLtx-0007YB-LV; Sun, 23 Mar 2025 10:02:09 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1twLtu-0002ud-Qp; Sun, 23 Mar 2025 10:02:09 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso67384015ad.2; 
 Sun, 23 Mar 2025 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742738525; x=1743343325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aCN9wrgoEed0FXwY6ZiutUyfqoe3TrvANqJK6HEEXeg=;
 b=DlwgaYWcxv8BeBQ6KpbGX9flX28Y8mM2oihrqvmj6+ZIUD5OXl9VlTfBioFN+ZKBbM
 ReB+EBgv8nJIEUvPYPiMCeGT16wslz0C47QGW4/b0tNHL4P3M/ceboOw+6ukX48JSRRx
 bMd3kIk2LLfTO35kx66/HTpgu1Orv2ZjAmrU/wW26K/yvWPmO2A9AYr9KqroNltsuZic
 reTOK49kQYoH9ggu4o+9O8Z+IzSQIOTYFvgHIL8nYPjJxF+GTd7ImVaWi9pgFMIbfzWG
 SA4viEDcxEvxoBAxbiRpmPN8S1WGJB7UAn2zOw7kGH46eBcNkkusVWyslaYVqmdkDvF2
 vLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742738525; x=1743343325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCN9wrgoEed0FXwY6ZiutUyfqoe3TrvANqJK6HEEXeg=;
 b=pk2Gu2z8FmnnexqgaOab1D9cIDcIOeJDpcXYUC52TGYShLjWRfpvAjmnMon9M0HM2S
 H01eeOXcWL7LO8H92KBJoAU97TczpaDcAIerKvbexKRZ3i/YB7BJq5auRSeUpZK6u65L
 7b3YNPgdlC87UqJT86I8dp75LPBAz1JcGeyNFpivXCLbJ9ElM3d1sno2tP53tdGCWnQS
 sQFIZnBGJqNfpg744raQx8JDeHH32b2O+cTu1os2X3GQWSwJTeHdNHtyjZOBDTJpbt6x
 TQbn6flGWF4cALzcDCfXn/02bfv/zUynJOU+sJjE6JPdCx/F/MCZyh4UcwcQh86qy3Jv
 BDvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJPc9v9mi77SRsWQ3vB1P0LT5fpbDR9OpqAVzRLCIjxg9s2Ity7+EO/v+blfWsUilLWgUQoBYBxlEO@nongnu.org
X-Gm-Message-State: AOJu0YyWU+mTAqyv0QeTmY67benftP+fiDGZdb6ykMEcA1yRGO0AXM4o
 Py++/ZCF4L7KeUJK2oVOMefGbfkvrg3tuqHKtZv3SYuKJXQvJursiZB4/oPl4mk=
X-Gm-Gg: ASbGncuE1/IOb83RkSvqtpIEUwAJYpBHrQSphVh1jJwH72gVgho1cJLF3Xc2V1nRcf0
 zjR6r6QPp5r2PSuMR4o8jtQcpOgm1MPsSp7UASKXD37tSr/8Iiad+6zNcOdWcF0NPQI0VU/0Z1X
 RVARJP8mJQyRG51Pjmgy/TpnD87f/gUAVILSXiPF8f7qqdEl/LL06bBskP//MfHEGDR4U2hphHl
 YU+i4sDDTB9qvwrpHZCib9MBFx3O09uH3rAWli87naBNqalU37Nq8F+NpqFfJ9atdm462JZclij
 grx7jrkaRhUnO1nkm78/2MgjbvrMIpItRV0WdwCMAzpqdfZGh4c31tOUXwpktXUBDKl/rCv5ipz
 j5oM/P6qU
X-Google-Smtp-Source: AGHT+IFdKkxQ+8QyXih2iAV8+O7VVq8x8CCRlkQVtYVlD5J8SbOEnJcYgRcdBNY0YdnVhiJdF9IQuQ==
X-Received: by 2002:a17:903:3285:b0:223:5ca1:3b0b with SMTP id
 d9443c01a7336-22780e122c6mr132757465ad.40.1742738524482; 
 Sun, 23 Mar 2025 07:02:04 -0700 (PDT)
Received: from localhost.localdomain ([160.202.36.194])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811d805bsm51745675ad.159.2025.03.23.07.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 07:02:03 -0700 (PDT)
From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, qemu-riscv@nongnu.org,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Subject: [PATCH] docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS file.
Date: Sun, 23 Mar 2025 19:31:11 +0530
Message-ID: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=hemanshu.khilari.foss@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Added docs/specs/riscv-iommu.rst under `RISC-V TCG CPUs` section in
in MAINTAINERS file since
`scripts/get_maintainer.pl -f docs/specs/riscv-iommu.rst` doesn't list any
maintainers.

Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f470a1c9b..27f2cfd833 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,6 +319,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
+F: docs/specs/riscv-iommu.rst
 F: target/riscv/
 F: hw/char/riscv_htif.c
 F: hw/riscv/
-- 
2.42.0


