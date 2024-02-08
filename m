Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2867C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYA46-0004Fw-5s; Thu, 08 Feb 2024 14:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QCvFZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rYA44-0004Fc-Eb
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:28:04 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QCvFZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com>)
 id 1rYA43-0003ox-0f
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 14:28:04 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc746178515so277616276.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 11:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707420481; x=1708025281; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=92fOOnHCkanWg80V2hAwSCwodLG+3/RgTATFlOBrVEc=;
 b=Si+DT/TsNnB+gceUhWVFQ13jUmFM/w63Zd7k9Ybz7wt9ELXFmqkClrI1j81GJgaG58
 ot8pL7suh857pkrxOq76oXE3eXf5eIeixdKRVB1d0koieX4kQXmn02qm54EGZLRntFqd
 iqLWLSqMHBGIhC7DapACmfyOGyer3PfagjuC1Tv2ecxQkEvAd5pJXebjkudSBkh6Bp6Q
 bsQJUW49Juk67h1s11BRileNT7mKV4hgG84lKbqP0JEwzJkWojxcOR6c0+gAp5U7uzVM
 SAJFEkyG6sdaP95ZUyOaqpTk8AFQtbyU9JZRdiRyJUGy1/bO9aNN5MKym/lCH3YHJaax
 iUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707420481; x=1708025281;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=92fOOnHCkanWg80V2hAwSCwodLG+3/RgTATFlOBrVEc=;
 b=QB9j9dxccOh4B2rHL4O6yT1kBgowGaLaPZndPYOPvCZ5ueQVwWcA/vMFI6sJBxEGKU
 pu/kfO41Y+kPRy683GZ5SL1UhG8Zg8PhFZaye7aiGLD8rbd/h633hwwfzh0Y+ysIMgN5
 zJ6sFRDEv03ZYaNdP2nkn621LXwR+QR9qU1Am9Jc/ASReAT07bOE9jREZVbsvdiu/ynv
 DJZaSkh+w05HcOEWYtIAe6+0ePrAb6+rK6lVaz+5Ku7oCzpSTY6lf5HfY9rDrA9FLzo7
 RP2V9LrrzS4pcu1RSAsixuPXGr3zymHSGEYfAqepfY1cpfxuQyPAs7uS8uKZqPZdh5HM
 mzwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu15X+f6YAgzzL2YLK/VQxXsS03HMDZnhUViB3XMNHwQARaOOeXZkeiuPXKnT6aTsatgaUm5RkoEPb8b3PBVsIKYp0UCI=
X-Gm-Message-State: AOJu0YxbqOBGkKmItp1RCZGU4QEKB4c8geaHI1jBoRwYiHmibKtraCMc
 uCtLLFlYAbWUB5ACuBBBv6kT9vK13LjGtCgvehmeRIBLxvWrjubtJk/yhbiQsVSnDM+OtDb1BNa
 Hl6B+BwQXX8VBjbIxWV6RtsL89w==
X-Google-Smtp-Source: AGHT+IHJ6458YgKAEr6xMRHroxpGBQ8Ylo+d9DllXZaHbyeoz2gWavG9vvhPRoeNVbrtZiI5h6bSU1cvwkYY1gI6aw8=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:70b:b0:dc6:55ac:d08d with
 SMTP id k11-20020a056902070b00b00dc655acd08dmr104748ybt.5.1707420480860; Thu,
 08 Feb 2024 11:28:00 -0800 (PST)
Date: Thu,  8 Feb 2024 19:27:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208192754.2774311-1-nabihestefan@google.com>
Subject: [PATCH v2 0/1] Sending small fix for NPCM GMAC test to properly test
 on Nuvoton 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3QCvFZQwKCt8OBCJIFTUFGBOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Removing testing for PCS registers since that doesn't exist on 7xx.

Nabih Estefan (1):
  tests/qtest: Fixing GMAC test to run in 7xx

 obmc-phosphor-image-gsj.static.mtd | Bin 0 -> 33554432 bytes
 tests/qtest/meson.build            |   4 +-
 tests/qtest/npcm_gmac-test.c       |  84 +----------------------------
 3 files changed, 4 insertions(+), 84 deletions(-)
 create mode 100644 obmc-phosphor-image-gsj.static.mtd

-- 
2.43.0.687.g38aa6559b0-goog


