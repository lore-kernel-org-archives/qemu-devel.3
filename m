Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D0CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4C-0000qp-Go; Fri, 08 May 2026 11:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN48-0000pe-Q9
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN47-0005P5-4A
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso1322522f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253874; x=1778858674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpLJQLzQGNrEuct/OLtaCCU9euBc7bknqLHrjXvtHEU=;
 b=xi4vcp5MdWNZjZZXJ1DEBeZZrAmm+mn3yZ+d1sDQaccL+kY9DW5oLCL2ydhfn9LJcJ
 aG59u2OHMtURsaOiaOUdrg7kmeKl6pYVPbyRpj4TDoUJS8IsvdGOHCa5wgIQvqpRE99a
 dzfuBgASEJ9TPdpL2Shf8UIbILOmBLgx42+CWngRg6Rf0cNpAWNnABIExXpmjhDTpWC1
 KbH7wixNf7Ew4tqs/Nyko4tXoio6R5NP+uTCh1rYSIErqnL6hgAaib4nkdEwZ6mWkACe
 9PRlQrhSyzicDUSlNfu+pcN2bma1UCFdElhUmJgP9XAfqCg5KVNmHEEUsrjp4rhGzUxl
 Aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253874; x=1778858674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YpLJQLzQGNrEuct/OLtaCCU9euBc7bknqLHrjXvtHEU=;
 b=Hgdoca+WK9GbbfXCaaXfchvuGBlVMdsWz8pm92MSZc/HFOZZvTpzVumyrmP2bSiqcF
 JxeOXRCbMKjbrof8pLwyqT1lRAT5aKjDQYF7Uys/AXbapNdEcnKfVsYu1bDa5bkqhIes
 djveh2wkPd+Sf0MRTtO9dFiCW1cREEliIAgqoaqh+JKUOnSOxgmfP3EW2C8dpYV71/ii
 rx0UgS/FaYhMeu0Tz+mlkMVJGm5OCulJhttYZj/MZnz1AlaEBZNoi4v76BLZfFZOFNXK
 hjIjiKSaNaEbWjlfCz4JqyaMM0dwvScl9STW8od1ewiGLgGeXsuCXF8W0K0JxvLFw0HX
 szIQ==
X-Gm-Message-State: AOJu0Ywvmxdxq4EBKiP68uDyMHj50nBEA7s6xQo1d80U+MWxY2X+9YhG
 fTfBixy5zO+HCCVxeY6fnmJEWtTvGcmpBgy4KnavcuDkrWi3qpm/LQC9TK6H+4dsh/ol0jO0jLF
 eodV6
X-Gm-Gg: Acq92OFmQyuaSPsSUd/nxcL9hwnSsbeYN8IY+su3Ilv8/QRGzFRkYwXL4qURtza48g0
 d7ViD/LPrZs72AP+YSEPKfY2eFu7cOc9ys+nEHAFLsTlwPJJvBqDZ2qosprSX5Q2phAOyujdwp/
 1HX/9DayDdYk6KUZ5r8WoPfXWpypjTpYjCLTn1+jW/NvTXhUf93+Wyf9GLLpcK/EK1HMawy6nV9
 P0SFnTrCMj3EetKtyy/pxz+6c5iha+PpZKY/ivUR0E46/k0+ICYKJqPy9584HtK9uSlXzoXaZ33
 rfZfSlumxMXrbLKtgK+BVeOXrKPE9hJ03DGYeeyEgEmwEfIyFfsOI2dn/MRoHIRDEGOraDt9XJF
 AOdZhwxtJ4WWdK8WCMk6ENv8M+gnw5PPiYTNo3IH+/pfMyNaC2kls7lkjAudHfi3DSsmCyqplk1
 wtaS4NsV3rpH9RqzEniOvPWP+3638jLqNXFrtJpwTsA/9Nuicgy69J0E/lyYlBiAIdPIjRTNMIK
 N0zFeF5T11/nxhCqWCTmNM99n3yk7C/cWt8HIKPNA==
X-Received: by 2002:adf:ead2:0:b0:454:88c:589b with SMTP id
 ffacd0b85a97d-454088c58c6mr5454773f8f.5.1778253873557; 
 Fri, 08 May 2026 08:24:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/9] tools: Move qemu-edid sources to tools/ directory
Date: Fri,  8 May 2026 16:24:22 +0100
Message-ID: <20260508152428.2648560-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Move the qemu-edid source files into the tools subdirectory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                      | 2 +-
 meson.build                      | 2 +-
 qemu-edid.c => tools/qemu-edid.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename qemu-edid.c => tools/qemu-edid.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06d703d422..cd53604f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2841,7 +2841,7 @@ M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/display/edid*
 F: include/hw/display/edid.h
-F: qemu-edid.c
+F: tools/qemu-edid.c
 
 macOS PV Graphics (apple-gfx)
 M: Phil Dennis-Jordan <phil@philjordan.eu>
diff --git a/meson.build b/meson.build
index b7b260e40c..d4c16b394e 100644
--- a/meson.build
+++ b/meson.build
@@ -4545,7 +4545,7 @@ if have_tools
 
   subdir('contrib/elf2dmp')
 
-  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
+  executable('qemu-edid', files('tools/qemu-edid.c', 'hw/display/edid-generate.c'),
              dependencies: [qemuutil, rt],
              install: true)
 
diff --git a/qemu-edid.c b/tools/qemu-edid.c
similarity index 100%
rename from qemu-edid.c
rename to tools/qemu-edid.c
-- 
2.43.0


