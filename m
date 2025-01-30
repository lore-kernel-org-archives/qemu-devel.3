Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75FC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRvT-0003ca-TQ; Thu, 30 Jan 2025 05:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvS-0003c0-Gc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvQ-0002YE-OJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43635796b48so3581935e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233450; x=1738838250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vJAhgdvuaUzoP5rhYvCoy1R4+PFzIiikeM9bnH6e+vE=;
 b=f+0Twg3oO/F5bz92eCoxLm1Xo/2Ybc3vnJ0BY7wle6CTPYFQyZdRzRJgx7SWRhFiQD
 31+pZg4TfBvOdohMQscblHARw+Nc/plmOrTdhW3mkw8SGQf7ataID1MOZO2PLjraa9DV
 azrLNREyp3ilMkMVv96iaEnBTXQuXCdstCo3Fw2Hr2p9ktdlki8DzJXpxrTKBd3+c2o7
 I49nOwsI3RaoL1UMHc8nAFcO17TXx66OZX5I1+GOhLgu6FgbGXJeg4JAZuDi7bgd4ruz
 ex8Fdp8lR/8s4RxDt7ziq+dlB4og2Iq6IGlzFxHbmq/a++p2GDbC3rstRSw77kkDaW06
 kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233450; x=1738838250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJAhgdvuaUzoP5rhYvCoy1R4+PFzIiikeM9bnH6e+vE=;
 b=PJB7ZXjvonffc4QCpX6YutqG5VeNDtMBTr8pN+0aL/AnwCEGIUdAbD6aaxFkd9E1/i
 peTbIr6Va5lXpDrFO6hq6rgrx33VUuGHwpDTjxKeaEhLfrF0Cz5f9qxNKjtjE3qUqLb6
 8gGqIpZ4CX+7d1lp14HJxp90bK+Whh7ueqc6QAtN5tU28dMaXXzpugUu7r/nhRovWTyT
 EcJsYPqAwLJz3btuADGKwhVbxPXVNFP1jgRtCISJLlUyCp23FV0wEvj+5FgIoRBOaXPP
 AhG+hOKoFxjAbn9lRRWcRbzJXsRab6Y5z41IiBjpc+nVi/ikIpuUllJbyhMyfklK5PyN
 fQ8A==
X-Gm-Message-State: AOJu0YxiHMJejUbou0/WEBIFmViZk9ip5P4S5I7SUlBYs0/LiQgrpf5z
 QaHb1qDzW8pF+1Qy9pnl16mCFMvwolFskiEnRW9o/9JrtQgZS0GJ+GKR1TQa3BPfRjYqVos7aHd
 kkW0=
X-Gm-Gg: ASbGnctPFK4HHbCwFO2NiJncFHuHYWTPqztFQa0hRlO1r4cV5aJ++wTsKznfbCwHoeS
 eABjhk0IPmNN6rVCg7HcMVQGYcIkFh0hI5QwbNFhmTmUtFeROR30hTUhx/Ekz10QPRPrcDW5UiM
 dYVvDoHLM4B+iRgvraqVy/vquiJkm2NiX78B8Fv8Jtu20lPIEskCpO9VAIEufu9Lye5wUkEcK5m
 nmXKU4M5Un+4bgO7h7hOi0UWOAiWw+N9UY8b4DIMIqOFEeyScRnNJGuH17Lx0lk0TXh92XlUb5Q
 BcPuylLNoLN58hvVMoOImvPHoBL7QMMVVYD/vmSNoeFQw29DGquzc+zOAGs5UUDWEA==
X-Google-Smtp-Source: AGHT+IGK3HLzliP+MhxUr7psmyi6DTayWfInVMx+k7v2EncKNgyMI2rVs1CJKECTEksKE3IWOylWxA==
X-Received: by 2002:a05:600c:3d0d:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-438e15ee1cemr21636335e9.8.1738233450329; 
 Thu, 30 Jan 2025 02:37:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23dea58sm18398835e9.15.2025.01.30.02.37.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 02:37:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, xen-devel@lists.xenproject.org,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] tests/qtest: Make qtest_has_accel() generic
Date: Thu, 30 Jan 2025 11:37:26 +0100
Message-ID: <20250130103728.536-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

(Series fully reviewed)

Since v1:
- Use g_strconcat (Akihiko)

In preparation of running QTests using HVF on Darwin,
make qtest_has_accel() generic.

Note, this also allow running other accelerators such
Xen, WHPX, ...

Philippe Mathieu-Daudé (2):
  tests/qtest: Extract qtest_qom_has_concrete_type() helper
  tests/qtest: Make qtest_has_accel() generic

 tests/qtest/libqtest.c | 110 +++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

-- 
2.47.1


