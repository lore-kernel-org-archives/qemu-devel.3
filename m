Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4CCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1J1-0004sz-V6; Mon, 17 Nov 2025 10:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Iq-0004mk-5e
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:38:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Io-0005XX-F8
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:38:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso12434415e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763393880; x=1763998680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XSaA16vn3CbMGF8BDHCj9IKI1zIXr7noqygEHPWkXEc=;
 b=pQqCazSFZPJ29IqTl05sBXvcFeBjKrZ7uTLt/11pUdg5jIGqxPAwIMV3F4wNTWE2fM
 byCYa63QnkYV5YRI8azbzkyuMXQtCqEhvJ5lncnDaVAtjm4GUafGzksiHjC0Dpie/T2x
 uEUm1g7+U/s0abshy3JM4/gTuoz87t1ImA+ceq69O6crSpgfahf6i5bbAyVqdo3IxLI1
 k12bEWKG7JsVpwBv/O1MAGf04vLtnYDcGA6E+A1zWJeG/1XTw/yNfroPQnlPpbl4m6wP
 Ai/GaL6AmAjkdiRVEOx383nNHldwwM8ck37eVSYJua9YHTdv5kBQllxUXiVQgzdm+Aia
 fpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763393880; x=1763998680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSaA16vn3CbMGF8BDHCj9IKI1zIXr7noqygEHPWkXEc=;
 b=nZYixcylA1BQlbU10HgtoTbqmq9C+cEmCcGify5fbG/xQCvYsE3t93JmN4Tb/pg/Y+
 zMvHw7pFo5x6EcQDQI/CAglBhmidm+NIN30ga7CwHY2U1Ln5w2pvsaFlOT75l7AzI1Jj
 rjgx/+gCH/FzoWneo++88g1pWywHcgJ4UfbjdWZePFyctGft/F2SgYPwGUokqa+kFd6n
 YL7PWISiNVTNesAEhzFQW2ED4iwr7geHATbejAym1yn5OZDirUNdJdOGgZMQtcTdDV2j
 +3P2eeC9Tcem4cIHyUiDP2LmmlleuyvY5FD1b3c8iTa86InIyfVVF0flS1GQfnMO2xLF
 T/0w==
X-Gm-Message-State: AOJu0YwNwiswQiF5Xz6B8ApcSulJVAaM8a1ryWaRkl9curtPG+egpIJd
 UBzx/SKNmDXBD2GEtBsqLVIp5adQ188loo+d4r1TjWqKJWUBtER9XZ93I23KhwrqqMU67Y0bH0c
 D4q0n3iJnrg==
X-Gm-Gg: ASbGnct12L8atAjDy7mJkNZUfjtFquY2Vnr1oRSsIAd6gPKGqno+cn5U0VaEB9z0TsO
 md/KPxNa/RNtTJZ4dfhs/qV9ldmN1ixtOlUwhJonZ3RQo3o2ADjoF/IiV/rs2SQh3Jsc64b1p6E
 iTrMU7DJOAo7FgLmoXbyhaLEusaSrbh/JS9TC2LkivXqgc3XhrqtjoTfRLfAhzPm4ruvNqGgXu7
 H9TzjFVZLi0tijb1PO0ryipbYmiUA+9GbgqRCfvOoKmqbTw+Sczy0YNerhvvQxUTU/Oz2zFSTKS
 KTDiEFCNamQ1r/XnoiMndEE/BJUSxoW3HsIzcsw5f44Ed2ipW9A6uLSE7dTDJd7Vdfd/2G8Mudu
 5DU/ydtV72x24at64z6DdCI3RHb6zBnARf5a1m/P1ZVdOGIyveuPzE24yo152RAYoLY2t97zc9I
 F7wa+IhN4L6ZDVzUIpuNmKrvwOOQxTIO8KI+Mfpj+tbwTf+XLpwg==
X-Google-Smtp-Source: AGHT+IFoCA8LSiw/SG71MJp4zWMRe4PWK/H6Ll5vJXv8Lw5oRpWL8Eqkyi3YWleTCdCj6RW+824mIg==
X-Received: by 2002:a05:600c:a406:b0:477:75b4:d2d1 with SMTP id
 5b1f17b1804b1-4778bd13e4amr121413625e9.15.1763393879620; 
 Mon, 17 Nov 2025 07:37:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ca01b074csm6323103f8f.34.2025.11.17.07.37.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 07:37:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2] docs: Mention 32-bit PPC host as removed
Date: Mon, 17 Nov 2025 16:37:56 +0100
Message-ID: <20251117153756.78830-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
("tcg/ppc: Remove support for 32-bit hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 88ea0dc4edc..3ebbe9aec98 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -902,6 +902,12 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
+32-bit PPC (since 11.0)
+'''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.51.0


