Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F00CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZY-0008Bx-Q8; Tue, 12 May 2026 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZV-0007sT-H9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZT-0007fG-Tj
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b0046078so42222825e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567182; x=1779171982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XA6XU+mWL7el+eRZO54pQpgH1NRB+GKgyK982sGAvAk=;
 b=cHqUbN36VzdQ60PMXASTUE0EjVmeLf6L44IFJDi+vky2YQnAghCu0QzP9IRxiMwOhi
 7CY4ikWnNVoH2ag7eBtm1lXgvsfHASQxeQj6fYZWu180DqBe0+5XO994Jw6c1S9rt4SX
 K0tGgTbbE/x9wuxPDBowlWNgjNU1FuGzIVDr7HEHk8dwMV5WelQnSq/oWjaevf03WvFu
 9bqiOMbZll2d2WTcC2rTv0Ugm/XFCE4guvYfTX6gdByLus6seaEy1a3ueC5oVDT7LoHN
 6ur2IDiEfSbbpMwbw8pjjP9eJk/K+I5E0jv4GuIjgoRdXWUV4DCOdgRsDF00L8yRMOpy
 fOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567182; x=1779171982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XA6XU+mWL7el+eRZO54pQpgH1NRB+GKgyK982sGAvAk=;
 b=j15LQNP2MdZ3UbbIGw44YznRL+3qk4ZNPUg8Nw01N5hdXhqCMtWFVlWN0lbEGfuV2b
 NT2Du/iSbZ+2vIHEo48e7Q1FGJmqv2gMTaS4KQFf/zRj5uzqyopjHWW8OeS1ZbPM0/9H
 0N3ZhqyzyxT7XjS+wDCdsdx6S9E+6KqO+y9R5hWgCb56RbheuU5+NaAGqyubAtp4bg8f
 jI2fFvVachnhReIFV8SkBA09sFxn9Vbz/VKsKPvqIYFkmNHx362SISJF03gM3aB+A0fI
 SGUGYA2B8HpIwc5oc7/Ked9J7djJq05L7LKxU1FWnr6O3NOH2QNR/USgf32xGzEyaut0
 3OCg==
X-Gm-Message-State: AOJu0YyoYfNBdMuFyJZyj6A5R6xUy9XAbei3e0DL9L1Etxo6qF+Ce61Q
 JIsqNd7dlmGRutj7FqyrvaDHz/b4/7pqR2pGKK1Aiwt64SoDPGnwIUmW4AaIFh90fWvdv6QWyFS
 +/n+zRMI=
X-Gm-Gg: Acq92OG5SlMGYlVsxsZEBYLFT2wJ5Bkm9XfbLmchhir5QDhhGxocyTIWNooHS7cmOjH
 UWFXuULhyQ1iHML5xZTacZBMLLYhDVajPHDrejPHnfZn0vtBVvTNaojtg8etLmLp8v9GRDPeGuK
 uWPXQdBcXoCQuXZs8LWiCf2JDdrnGGrU5g7Yp1RhQeRyygmfDNKI/Gpbw8RQcwKL15uC+/8b0HZ
 r/MI94ElSeoWcncvkhDtO3Bibil+K1Ka8RgdN7/DGDZSKFeLTfZS6Ha1ES/EmT3bWUE0oJE6by/
 QXjculbgv9FJgxmlnU3raXszZV7SxgwFhIhb7KhE1xphRUdIwvJkLC8O/mXalVW00IUazmY+tj6
 v8qJSBsPwkC51dBm4sanfCrAMa1+ZED42Lvahn/8BYJNoxHjtzGrXMlL36b9nQPJFbieOjDG0VS
 ycfylUdsVUrijSXiO6PajrVLcmG7PxOLXADZOrs0zuIPAnnmWXNJ8rIVkR2CVF1g32AVBDcWxl
X-Received: by 2002:a05:600c:628b:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48e706cd77dmr214216525e9.23.1778567181857; 
 Mon, 11 May 2026 23:26:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908d2c77sm23730785e9.12.2026.05.11.23.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] MAINTAINERS: update HEST maintainership entries
Date: Tue, 12 May 2026 08:21:40 +0200
Message-ID: <20260512062142.67998-40-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Mark HEST code as maintained and assign them to me.

While here, add a "L" entry to EDAC ML as RAS discussions
usually happen there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <6316f5b788cdc6b63e808606649dc5862271b22e.1778075257.git.mchehab+huawei@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5d58d58646..0790d13505c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2236,14 +2236,17 @@ F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
+M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L: linux-edac@vger.kernel.org
 L: qemu-arm@nongnu.org
-S: Orphan
+S: Maintained
 F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
 ACPI/HEST/GHES/ARM processor CPER
-R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L: linux-edac@vger.kernel.org
 S: Maintained
 F: hw/arm/ghes_cper.c
 F: hw/acpi/ghes_cper_stub.c
-- 
2.53.0


