Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E250FD5337
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuo4-0004MC-Mn; Fri, 27 Feb 2026 05:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuo3-0004La-46
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:10:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuo1-0007KT-Jq
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:10:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4375d4fb4d4so1150262f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772187043; x=1772791843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRXhP9HXG0J2RH5T7pKqGuKCiQtRSCqGfZkmgmyLmPI=;
 b=Rd6E7iMwBUpajBQX8GhOUdxBLoIAb1O8KQrSBq2oelNPZGRMx202O+voxWa79Te5XJ
 zhQfDY1ZKqHtKwwiFz0zuXQuzWtYwpYxmyvxu8t5urAoHXsrGZIiSabDbmOPeTvIDmEY
 29aajn+nMhY4rkk33Vzr+xCWBK4RmlaRh2FULlT5n1MPD52/6WYVvRA6YZGKpo1CqLGd
 0jdwg5S2DUkj17rqHx5Tcghi/UORfLHKXFGP720XZktgdClUaOBrPiDJzHYSxqN3Zu+w
 bxRFF5FyzFQpOKZrGrUK+g5epq0kntabBgGHHQY/zoEELv6wtiKA+40+1zPK2UGm8xEt
 W61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772187043; x=1772791843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRXhP9HXG0J2RH5T7pKqGuKCiQtRSCqGfZkmgmyLmPI=;
 b=l912OOwiO0mkkicdxZ5XyuGcUX+V00LieVOCsDSUC5R5zXC1pNY/Lum+YH9rxK6zOC
 9EG1Y9yC1fbYklBEOSgVG+F75uqjyNAhWKj3Sr8KqiLSJMFsiRQ/plr1evLUu0AjBuQU
 QYLH5pS89JMlWGEHEyhAIJO7rw5LYa8zejoiQZAS5vOMZjpBjR0HBpru6i8XEFfrGumJ
 8laK5l7SeGrm5ZKBLFXLwVd5NwVFY4loEeQRRLezgIRQp9NsPEi2whD5sKN1HRGf4wrN
 ZWosDzujPkERYynPJBguNg6PN8x7ho4UxiErKHIyTcC8LxMMas25ejo50aXRL2jgAguH
 3whw==
X-Gm-Message-State: AOJu0YwJY+tMtGy4sewvxlj2TP3EGs3D20Pl/Rz6dpMRWXgDgw1unccG
 Py9JUp+Krar691LpIAzBLXOfSNkTirpQCR7MoXP/jbM/VB5LeuYFLxbInkaMWe1S3cMRAN8SmEc
 3P/8T0Mk=
X-Gm-Gg: ATEYQzzBD6e+VXXIb00/8x8Rx15QWOgl9rlG2rrmx6WLGpcE7R3GDiGdZmTVWv1vSLb
 CNFB3ElmnmsQ/lgI13v1XiZ47duEZjsvsEqUI3iLN2jUVv5IbEfFTBep9P0kYSbftl/tJqc5UG7
 cbuMsCKBJlzLNOSdEIDl8Wkrxv2KOuxmOwnh5q6QbnCP3Dx2Jg4XIbEzsZOVwMnuidKpdKUGSiJ
 qP2Y5QGwwfpqM/1ox8yJCQ3fBa3T1j+tTxDEcQ5NlC9Ei43lwlEg67bk5H+3his5aUQwZWDcdZk
 UT+LcSNc3ehUl3DVmlmXFkjyvJ8KBNHvTfCFm1+DqXPK2D/P1NnLduKCwAu3rFpkfuOpFHB52R3
 LtY4Jou3Fjs05ZzunkaAafnnr4TuNYSkybQ/tInJx5Flop1cjJWMI+jf8oS8xMUTxU85GbZWAgO
 pvYjpxjkaThAiMVytBStdiDj14HCv1/8tm4itq9ZnWSgmUmD+b+Brru5Qj8YWnKrzJroM1+7XrD
 nVKcLB7fiA=
X-Received: by 2002:a5d:5847:0:b0:439:924e:c3be with SMTP id
 ffacd0b85a97d-4399de2cb82mr3772122f8f.50.1772187043316; 
 Fri, 27 Feb 2026 02:10:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c6100b8sm6950540f8f.2.2026.02.27.02.10.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:10:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/2] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Fri, 27 Feb 2026 11:10:37 +0100
Message-ID: <20260227101040.70763-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

v3: Restrict meson to gdbstub/
v2: Check array length

Philippe Mathieu-Daudé (2):
  meson: Restrict gdbstub to user/system builds
  gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

 meson.build                               | 12 +-----------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 19 +++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 20 insertions(+), 13 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

-- 
2.52.0


