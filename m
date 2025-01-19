Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C1C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsQ-0001Eg-I1; Sat, 18 Jan 2025 20:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsF-0001C5-Fg
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:11 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsD-0003BB-T3
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:11 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so5844090a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249188; x=1737853988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxNb4rdhTbxXkgYxdIx2H3V9pCkfROl+Bmd9x0HWUXM=;
 b=ASGAV+RTqh+puf+3iArux3iNtiyPUpM6anvCo0iSXf2uiRPgZ53cTA65Z0LIlu+kYF
 EBsLiBdXGWC7XCeRiXBIkSSay9maIsyX4WnOkVly/2s0mcovHKP5JiGI72Q1F2cm+yp5
 iJk9JBz8Jyf9YV7rarpbo2pspyemWWEoTYCoHgAE2TUL4/p/H9q3zReJlj0HaivjRpHs
 72SCgLG7ORkFwA5hxSr05pvWTccjq0+azqSEk0ol6hBa0/01X5hWZ+tlL7e9l57iBlEU
 m7b1KJPDteq3efYrqGuTO0/DZLdt9SlF+y1BeEGz0hNe1XLvouSszdPdN5sCM5LNWbCd
 Zvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249188; x=1737853988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxNb4rdhTbxXkgYxdIx2H3V9pCkfROl+Bmd9x0HWUXM=;
 b=XqtHBAkyADBvgwba55QrvUOPAnFu8aCLwUI6BUeaog+ZLOVX1SKq2SGVgGJBle3rK6
 jrx7YwGipCiL78h69OY9DSMEgaT8w3hg20WRS1cn6apynTsN9x/6OJU5bOEm9BvgycX8
 LKTZtJO23gZYBPKJUboGtgmbrOqEFN4EIKtSCR+SK8vFJDSOtoBxR5lAvk8AHK1UqIZn
 oQaZP2V+VBfMNBqO0LXD+wMef2yKvB7/0TmIKwvBsrqIVzWCimSCUH/KU547fAfKi5pN
 3x9raSvar4b5OgOUbGruf0bFxEUnpOpMiuc4aZZtoKWacACmCOHTPMV5aX2olrTQ4RtX
 GdHw==
X-Gm-Message-State: AOJu0YwI38rW9qNNGv+l72yWkK2BVt8Hs4r1aSLcvmXWSfah5ZJJHXcx
 s9Tc0M9S4yviRYvoKjgJGx74z4aCn2ssd4BH+9RxjWULaLseZeyFriMab+tN
X-Gm-Gg: ASbGnctlX5raVA9TcEWfQjP2Jnz78Cmkoo4SQrnY8MVReM7fpCreyp7k5WdyYFgggGg
 ad6nKXfcRHXQqyo6ygYIUkQvuLL6jRcW7NEViaKlrBn2O9JZw//vh4Cni8QSrY4J9XximnMexdb
 +uMarQ8Ds6uXLQkh+Yj/0L4nUM5k7avNNcfC4FKyuBNJc366qO2hROAtFuEZ4nP8QRU+pxscezF
 8t7tJijeCVxDcZ0AEhNLkBPS07ub7+XxiIup1NSbwRBjQys7O9HD75iV53++PNCV6uiifNTj6X6
 5uczApGu5QOd8c/V7xWdi7I9jljROOLQf/xvWIEudSv9KOkGVty3MXk4CAhfsEG3bBFVpF0eqA=
 =
X-Google-Smtp-Source: AGHT+IE50j2EzlpfEnQu79zzpAAAlFq7+ahwCqY1/HlO9TtgR3HSn9+bccRovNB2Un0ekoLNY63Fww==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:6db1:21d3 with SMTP id
 98e67ed59e1d1-2f782d323a6mr11378444a91.25.1737249188429; 
 Sat, 18 Jan 2025 17:13:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 09/50] target/riscv: add shgatpa
Date: Sun, 19 Jan 2025 11:11:44 +1000
Message-ID: <20250119011225.11452-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shgatpa is defined in RVA22 as:

"For each supported virtual memory scheme SvNN supported in satp, the
corresponding hgatp SvNNx4 mode must be supported. The hgatp mode Bare
must also be supported."

Claim support for shgatpa since this is always true for TCG.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 382 -> 390 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f58eeb689..3e138572d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index fcd9c95a6a..695022d56c 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


