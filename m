Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFCBD68BFA
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCffA-0005xm-H9; Sun, 17 Nov 2024 08:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tCff8-0005xC-Fq; Sun, 17 Nov 2024 08:50:02 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tCff6-00023e-L8; Sun, 17 Nov 2024 08:50:02 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53a007743e7so2395566e87.1; 
 Sun, 17 Nov 2024 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731851398; x=1732456198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hQmuiHYA/hhqCVxwD2C2oGlSh3k9WVXtPYarRqLv9pk=;
 b=h2z0t/m+xSGLlqCaqMGS7toS4YcD+iZI6G2UCq1xgtnZazMotEL1RoCyRoeUWpPAl0
 hAIOdCk50XK+1coaGuiOUK2aUWW8/pZON4zL+NMmfcBWyjgKN38EBC7Je7c3uS3taIne
 +NFLWChm2Lsx4/SvH93QW7eddKDoa9l5KUTJbQRh0IsswTbuZ10VoQzDOrxweQWvj3oy
 ardsC1u/qWacFHKA6VnXky0oUUlFaJMaZlQVUXtTDxzKKfYz9c1JNt6t6g67AmKnXJFm
 i9RoH9bsko2J8lXb1qMr4nulnynUYD3H55Ntr5DkFGKou4XmbZOOOfa+t/tSIaNAqEMm
 kz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731851398; x=1732456198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQmuiHYA/hhqCVxwD2C2oGlSh3k9WVXtPYarRqLv9pk=;
 b=FaO0Zrr0p2PWqv5MQlvNLEplE4CsQH9cAseqSuRZJ/fcx3hkVu4vToc8b2DfPxJx84
 Q3b9qAvXe4SeVRWgSCicXORYm34sRpbvtBghR4uMLzxdXNc2Wv8j+QBJnzKeRuPdyPGg
 xDTciaC1cceSY+ufoLnu3MDhCNIUMYW9N6BQ8TFdDUiEj/0ggDm/ijyvns5m9LYQOBct
 /RBtBe9yx/0oT/bQHwnURHCG6kiT/uX2pwFNGy00SjW6EBPqDxfVuCye0o1yPASASBAe
 PTF/DNIvZEmzibGo8sLIzCahZ4QlWKW1K+F4O9kySIz4tqMm/MzzAFPJJsmNu2yQJT42
 v13A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3lhiGmssnYukIo6fklcXr3sbHvMKeHyeKmIk1L0gpeACRfvN38XPMLopm4/VhXltIOWskJaurc7wH@nongnu.org
X-Gm-Message-State: AOJu0Yxb8cdzmMIqUbJCbOh6HHViF4pcauxrPGiuEiiJNUOIDryZx0e+
 pvgxggazqlrgRdkEkcyk7s05vA/4liULnhVJMeY3pz1R2FykHt4U
X-Google-Smtp-Source: AGHT+IG8bAXlQGZ09lY6rFQBWSaJ626CCMZE8+P3QwOyrbeA6VelsTHBBwiCsn5Tk2drxnDPnfojeg==
X-Received: by 2002:a05:6512:3989:b0:539:ddf1:ac6f with SMTP id
 2adb3069b0e04-53dab3bf70dmr3419722e87.46.1731851397467; 
 Sun, 17 Nov 2024 05:49:57 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:d00f:257f:ffb:ac70])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da654e33bsm1285366e87.276.2024.11.17.05.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 05:49:56 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 0/2] arm/ptw: fix missing sctlr.{u}wxn
Date: Sun, 17 Nov 2024 08:49:31 -0500
Message-ID: <20241117134931.37249-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

We observed failing WXN tests in our OS which we tracked down to missing
WXN handling in qemu.

The problem was in that short descriptor format walker did not respect WXN
bit. To fix it, make it possible to call get_S1prot() from
get_phys_addr_v6().

Tested localy that all permission-related tests in our OS passed on
following platforms:

- arm64-virt
- arm-vexpress (v7)
- arm-virt     (v7)

Changes from v1:
  - Fix style errors
  - Add cover letter
  - Use get_S1prot() instead of open-coded checks

v1: https://lore.kernel.org/qemu-devel/20241114165900.6399-1-paskripkin@gmail.com/

Pavel Skripkin (2):
  arm/ptw: make get_S1prot accept decoded AP
  arm/ptw: use get_S1prot in get_phys_addr_v6

 target/arm/ptw.c | 54 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

-- 
2.46.0


