Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC04AD1D480
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdscj-0005my-S3; Thu, 08 Jan 2026 11:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscf-0005W3-6P
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:29 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscc-0002on-U7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so36739575e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888744; x=1768493544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TWf1YsTNOGBRap2O9zx06R5Wb+jZCBiTTeZJPlA/2aI=;
 b=WT4Yq+M/j7DX9f3uILql2VXHaCEzZhTl1v6MYAAzyZUPSPG+ONL5hYCzXpER4B7LWl
 06pnEe5sLfKRCFA16vomUJh6ukls3T+ucrqQe2jHWbHEzaP8brascE+Ss53l8lMOHK95
 3nuPNx+OgW5Vd/+/6HOfc81h4yFqkFpytIGv1o0ZUt9N24ksmswXxOtflIaz3VQ9tkhs
 rAPDUB8h6GP/T0S/ebL/Vcgmodxdok6nwQjyZw3WRgqrLI2OKl2O2vtJz2elqMufUMbC
 w6HABXC4LuGwb6BOjZPnqurGtEK38vpB7pLk7lW5im2vPOzt2jcelZEFURcf/w/VyRSd
 DfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888744; x=1768493544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWf1YsTNOGBRap2O9zx06R5Wb+jZCBiTTeZJPlA/2aI=;
 b=U/a2MRfxKpx8ag/dzIiUL1KgPAoEUA7Q40yQyhzXJ3JNsyyl729TlE+2/9QCjZCFmk
 FayXhOuJBtKeQBWOCaCCZgTE01kAKSZIrOJrCojGW3Dco8lmLA7Whfm04UXTJMFHfcKl
 ewTLQfwy/NWrxJNNNtY8J5wwaNCGqxEsXHfyir8sa1lfcaB3AKQ3ryEyz1m8hZ6uYQ9B
 eQ4wrab62UJzkb26osC4buZhml8eUVC0i3EbmnlO/VXUP6GczC1JUaMLtvCwHLsi+nsu
 Cd6257ks4mvAqZ2jPHnDOYZN16qES+EaewXyjqwK+7ABgM9mDYUrt+DfhgDy0ysvFglO
 kp4Q==
X-Gm-Message-State: AOJu0YxT6n4+u1xXIkheturoEqTcgzb/BPDoxNlpFTW3w20HO0hs8JLO
 +SNfHKW+Y6VBHKhBIBXsapegyZ7tBt9VBDzf8HszDqL8gP1kkr0lToAqpnHoSjDhHsjWkkt5gUg
 mdN3dBSE=
X-Gm-Gg: AY/fxX4FO2BQ8j18Ph3B3jpyznRB4+yegjImwQ83VjLr4rK+6gLe8RIgDziLQ2+jw9A
 c2bNNinfgalTVf4JvJoNG9EX+11AbpPAqu6vopMe6eKoPgmX3bHRDr8WNgQQT8DZCT0n6H8dPxz
 zwaqrSOVxrXKd4U66vJ7tH5UKHeSgSl8XjHQzwenEh/AaHyNNvC3pn0ZtDOtnTWvVi66Nr+Sl5N
 JoiUKo0fXyOxAWhymTzKzBMezH4S3991up8RRrMxJce2FYHvLTd+zFA3V2XgWTTPlSydxPByq09
 2YV5Y6K3MWc6swmciuOb3LSvgqKv08rVtboQPXQiIRep4ec2eG38PdXeoxgAqEtK8GKC9fiyYLe
 hzOIORlxLabjR3M/x/ck/FlboyvJRqZjvi0MANi2YcMXGg7Kb7V/2tk5U8hMPX8e18jpWGzzkpH
 0DJ8SR/nwMeiu5O4ef3Fhtns6zF0N4U5qyW++ebr7NLU4ZcrmabfTDhYMLZ48XsmB4Jg8OPGM=
X-Google-Smtp-Source: AGHT+IHzV3hPba8HvDtTmpFDHsnd9FZTDtpW+ben3Xshu9Q5cc2ka0jUKtnuoOyjFLeQukg09KbN8w==
X-Received: by 2002:a05:600c:3556:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47d84b086ccmr85039315e9.1.1767888743920; 
 Thu, 08 Jan 2026 08:12:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8718b995sm38946895e9.14.2026.01.08.08.12.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:12:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] dump/win_dump: Build almost once
Date: Thu,  8 Jan 2026 17:12:15 +0100
Message-ID: <20260108161220.15146-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

v2:
- Rebase on Nikolai patches (included) to avoid rebase
- Add Kconfig symbol to only build for x86 targets

Nikolai Barybin (2):
  dump: enhance dump_state_prepare fd initialization
  dump: enhance win_dump_available to report properly

Philippe Mathieu-Daudé (2):
  dump: Abort in create_win_dump() on non-x86 guests
  dump: Build stubs once for non-x86 targets

 dump/win_dump.h                     |   2 +-
 dump/dump.c                         | 138 ++++++++++++++++------------
 dump/win_dump-stubs.c               |  21 +++++
 dump/{win_dump.c => win_dump-x86.c} |  37 ++++----
 Kconfig                             |   1 +
 dump/Kconfig                        |   4 +
 dump/meson.build                    |   3 +-
 7 files changed, 127 insertions(+), 79 deletions(-)
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (95%)
 create mode 100644 dump/Kconfig

-- 
2.52.0


