Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1014BC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qu-0002uL-G2; Thu, 09 Jul 2026 22:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qr-0002f6-Pg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qp-00008N-QJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so284172b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652258; x=1784257058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zDdwLkQCOfTgDRIqJwe8VKyrIWC/vnGKmGbmRukuEY=;
 b=Apbp/zinbhbPKaBwK+9R68xYHd8rcOqpm8p4L6o9M26BM5JZZ/Tw4dYMm63AGyT3J/
 DzxUPIMzq6e5S8ajN2IAqhamxMda8E1pkxoXvFMoKYbdB34vGNAl/vWVMTTre85MAr+f
 wAJqs8eXGjqWpqrZIKgRkq5ASnmqC60Pebji3owovrqW2c88I+L4VFWTeKzsEfXWR/ow
 oCCl3IBW7t4TaayOEjQbp9rmVehsS8UyGnUbcpC4Tb+14953NL3bm8NsR1F4aCpFV0OL
 MK9OMD3sysEaS40EFIfKRtyD2cE7IoLU//7/sWY2rNeZo50wXDZ/gpnpRhcT3RhzowdE
 VU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652258; x=1784257058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8zDdwLkQCOfTgDRIqJwe8VKyrIWC/vnGKmGbmRukuEY=;
 b=QHRYCPM8uLnNZtOzlZeH8LoVN4pHQ8dvJ6H9EQlj66j2qi8uTNuZft5FFg6+mPPi6H
 vLHj9443cA4J23slHKxv135+rrXmqq1kyfKkK0xxGsajEXFb/xK4MsCLW4dWAmF6P85U
 nYw3WIHq+JUAdSeGxjSs9XB7GS0gG10B3jAGgJR3f9caTi4XgnfMw2wFFntlOUrkNkSZ
 OF0M0kq/EQbAgnd3Zmnh08YO7PoRE7ZPAh6mdFVvjCgI+kskBeMpenFy2z62h/t4cU9X
 HinuwT8vIEImY/ALrhWVZJxY5l+zclLENJekoz/cVG0g1e1mkyb7yWXIHE9rjGUBg3GX
 P2cQ==
X-Gm-Message-State: AOJu0YzLStTT7aWs9hH3R5w8YnLPP38N+Vf4cZAf5YOqdK4Ab7cXQYQS
 FwGS2HhDz1rP0UUvcVmOMj0WNZRxxSJ7nNmCqF//zgMRUuyDnsLBwlwMHF9zXg==
X-Gm-Gg: AfdE7clqV46fBXAeXi+K6yj7+2Fc742yLPVW4mMEJw3PZpfBJwfG4EiiBo9wzKQx58u
 CdRTqcCyvDMZXZRRe126vbzUY8aQtbjgmsDDwW+In1Ve+mdHXoG/U7ykSNJuhedvVcDjTWtYfVJ
 YchOTNcgByzMN2iKiWVPS5xriNAMNZI+6tb2O7fEdlo6AiPy9gyxQ0+1h1FT5qXTaBn/LdSUEV2
 XozqF4Vc5wI0y0aOX+ad+B2eYPW2zM7Z0rSP5h51BHbkM6hS5APpleGBuL0w+K7paLsrzAz/oec
 KHRsNPUIzFpQLpmwjyBmpdjQUcSc8/nIq+hCjYjt/NzOFQZ7YnszJ8AzrjCA1lXGs415spXSyCj
 5xzggHdUjVESsKynSIpzHf0zWvc7x+lPEGQNcLFA+eNtMPPqM5QOVJ30ca9ucKhXMwGD1TB70rf
 FpaGj5O3E/1PT3b2CAfIpzXdeoSh2PDrE=
X-Received: by 2002:a05:6a00:2350:b0:848:6ef9:f5ca with SMTP id
 d2e1a72fcca58-8486ef9ffefmr1949826b3a.63.1783652258350; 
 Thu, 09 Jul 2026 19:57:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/40] tests: allow differences in SPCR
Date: Fri, 10 Jul 2026 12:55:23 +1000
Message-ID: <20260710025525.1704417-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

For easier bisection add the SPCR table to bios-tables-test-allowed-diff.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705063147.199732-2-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2c7086d9de 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/SPCR",
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.54.0


