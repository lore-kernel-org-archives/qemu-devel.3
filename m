Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68A0F94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZu-0005JQ-OK; Wed, 22 Apr 2026 04:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZt-0005HN-5b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZr-0001EN-ML
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso46946955e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845094; x=1777449894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXaLJbDVyIzdgefIDQ8l6ocEkttb9assq/0PFVw7jdU=;
 b=Zf8xopgIQcxNdwZOfjBvs1W495pLi4DzEtXDAWa1G8tuA1oPAYf9vuz4M/bOfNVgt6
 2VkxtS2fiDXU1KV5LYVZPs4OOhcxv7pz8OAglw5JX2naWnN9u8bug2RkNsEHSXqQvMkn
 on+8rGsVSduYUjYaZFuFKMmw9xt919B/hbZL2lq1qit3Yg3pFaHcfSuL9W/6+9TljnCr
 plXEJY420xBGRumkfxb52C6X0ycTj0YP/GDuCkLMK0v1ROSJn5H6BOmJp0cfSYzTu+Gb
 o4/2E0URUXexp6mgJqyPVwQjm9Bq4AkriLTleLDPIUTwwNhNYnDiz0QHXcl2CTRCXxik
 Gy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845094; x=1777449894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SXaLJbDVyIzdgefIDQ8l6ocEkttb9assq/0PFVw7jdU=;
 b=UoSkWUXVzk8ig682xSqim65Hv0sWaCr7/E+PXDf979PpAi3on14rtzELlZ0SMldCPJ
 s1kbrl/S6pxw4VsHPDxBRitWV7UnbQjfLNio/zUCTGltlkNfIpH9H0ClpLOKomJf7PPp
 UPRRTcOAsbWDUBI7dVn4CYeIlrtOSIbkM6dfr14zSxps7Q1ju3pi45bzuRDW1ZkGEQac
 01vR4HMGtmmiwhoUcNQt+ucN2kVKGDvDBKS6Z8WAyj+o1JA4LLm7OtBkHOPGLbd07qOX
 zHKJAWk83u141UjtfbbomfamJhH5aAsxxlcz/x+yp2QYa+GEuH/NSjqCn4GoZ/LdTEXs
 DNMw==
X-Gm-Message-State: AOJu0YxGb3mjCw08LJxpsl8sggZTFWTaPJzWl4J6IY04I6d5Eeg40fko
 b5RdnzdPUwmmnNo9Wu/rkVSizynLbqj+RibDXSU34UqoBjdqiM8tYf9/D+btTliSiGAIVO8DARn
 3yljdZjI=
X-Gm-Gg: AeBDieuPNTw1vvNUUH/4tQZ+J3oZ5l0QUhr/+gl81GCZqSPrrLQWPVh1M/FnVKIe+kD
 4YwqQf4t/OFMx/0B4iDwcBaGllJFOY6B2lWguGVtPeE6aayVmypcRkKbNReFaF63UonfhmnT9wH
 tJYsQpjY3nD3qsq7fQxNtvx1/D3DbpLRVwMmo4iJLSYF7teMpuMxooBw3w4A/UmAftcOmJumKdD
 0RIvLFLJoXOi3N8bF/GTEGhKoYECwCJCbBrrvWZvxuJ/H6kjndUuufGMq/KBntI+Le2bDw2jb1u
 6+vpYPsT7IPY+BYnkH/btbM6bPKKc8I9cNW6g/z86TEQiVdsRQC/i4tFE5iWM3xDUnCO4UDY0Xy
 xVoM1ii60Y6xG4f8QkESHMsA2RhvB6FefZiHFulikQfmewQ4InfvCEOe/J30RO88+Jl5JDI/F8j
 rX7yT1nfmAUEEm3OSBTP/xnoi4uuAkrFFkZ2CKYNKQvL12nZheNhp6Oq03r5LHFBt+s+gxYw/5k
 6ih0skhl2g=
X-Received: by 2002:a05:600c:498a:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48900ad7b76mr142104505e9.24.1776845093534; 
 Wed, 22 Apr 2026 01:04:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm406372845e9.1.2026.04.22.01.04.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 06/10] MAINTAINERS: Cover hexloader tests under the Generic
 Loader section
Date: Wed, 22 Apr 2026 10:04:01 +0200
Message-ID: <20260422080406.62638-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Drop the orphan 'Intel Hexadecimal Object File Loader' section
but keep the tests covered under the Generic Loader section, since
both loader.c and generic-loader.c calls load_targphys_hex_as().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17599636ab8..7e3bf662561 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2710,6 +2710,8 @@ F: hw/core/generic-loader.c
 F: hw/core/uboot_image.h
 F: include/hw/core/generic-loader.h
 F: docs/system/generic-loader.rst
+F: tests/qtest/hexloader-test.c
+F: tests/data/hex-loader/test.hex
 
 Guest Loader
 M: Alex Bennée <alex.bennee@linaro.org>
@@ -2718,11 +2720,6 @@ F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
 F: tests/functional/aarch64/test_xen.py
 
-Intel Hexadecimal Object File Loader
-S: Orphan
-F: tests/qtest/hexloader-test.c
-F: tests/data/hex-loader/test.hex
-
 CHRP NVRAM
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
-- 
2.53.0


