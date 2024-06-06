Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFBEC27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXh-0003tX-Rb; Thu, 06 Jun 2024 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXg-0003t0-2C
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXd-0002yw-AA
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52b9af7a01bso980027e87.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670419; x=1718275219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMtQclkfQ+tzZ8PXSD+8zjanVSPJ3R9g60tZMLUUdbU=;
 b=qRop8QgJAGLU5YkbpKacQvzQHmJ8spa5rX0r5jtDwrrPCmqxhFAhLd12OuqtTz8Vkq
 hcTwHlK30dCirJ2BA2UzFxGYSN7SfBdwYJseAktqODEm0bj2KQXrMHCyzClEtoISO5FR
 NJjhePEKngBNPuRMlSbq1ed/pZQO0K9495ecNnpSLxP/FYbdKXZUpNJeHjY52ioc7ufL
 a1UApRxddUcc6mNqiQdMPsGDaa2HlkNRp99pVI2cudfLDWBFdg5LGGW1S2+HvzkuapGm
 VprW+5lafx1ptg3PULfeWyTf7IIsk/GlBYgeDYXEpRqdgjqIiluOX5cmLHmzkTREyhqv
 +Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670419; x=1718275219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMtQclkfQ+tzZ8PXSD+8zjanVSPJ3R9g60tZMLUUdbU=;
 b=hazj2t1Ly6kwZRX/eC1kEzufsL9IzNyVk3EmXwe1SOx8AokANBXEiVRY10R+QXn1uN
 PgGMDAZFEl4u9DCPFRRaEKIaCy72+n5XNJYEdScYC150w4PFEFI/Gl1KuKQC8fFhTfz5
 GCDvkmJqtHa6nqUN14yaKZ+C4/SdVCsnxcI9vBK06DFCK62FuMIUT+fxlU95aQ2XfvjR
 9xqJZYmOkC1+bw55XKeSoIP4RN6qSo3WPBJ6NHt1DDaJo8EeP+OUiPg1L1MJhB5gGkkj
 jYNhC4Bb9koyGoDSRoEaKKxXHFvtsVIWZkQ+erOlfnCof6tMHKN6M/DnvwI+qrO0e3b0
 Epfw==
X-Gm-Message-State: AOJu0YzR6qRV5VCUZwP4f+rGXb6b5Ce+kR1pR463wogUjSPNgFaDfcNV
 JDKmZpudYOmqKKHBjOIQyW+AalSTgXEKsK3h+41Aqo+jj0TITvhEaRcYOzj40RdqE/yngBNxMEa
 e77c=
X-Google-Smtp-Source: AGHT+IEbNR8LHVKrJlckZeaPyQ5urxX7BGDye3sHYKEAxrx9lJ4V2Zb3B85UKbn0B4f10r9v/PG4lw==
X-Received: by 2002:a05:6512:3f09:b0:52b:9c8a:735a with SMTP id
 2adb3069b0e04-52bab4dbbdbmr3927067e87.40.1717670419082; 
 Thu, 06 Jun 2024 03:40:19 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm17724945e9.8.2024.06.06.03.40.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:40:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] tracetool: Forbid newline character in event format
Date: Thu,  6 Jun 2024 12:39:43 +0200
Message-ID: <20240606103943.79116-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
References: <20240606103943.79116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Events aren't designed to be multi-lines. Multiple events
can be used instead. Prevent that format using multi-lines
by forbidding the newline character.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/tracetool/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 7237abe0e8..bc03238c0f 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -301,6 +301,8 @@ def build(line_str, lineno, filename):
         if fmt.endswith(r'\n"'):
             raise ValueError("Event format must not end with a newline "
                              "character")
+        if '\\n' in fmt:
+            raise ValueError("Event format must not use new line character")
 
         if len(fmt_trans) > 0:
             fmt = [fmt_trans, fmt]
-- 
2.41.0


