Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7467FCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2hs-0006i7-Ow; Tue, 23 Jun 2026 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <386A6agcKCngfndehgackkcha.Ykimaiq-Zarahjkjcjq.knc@flex--jrhilke.bounces.google.com>)
 id 1wc2hr-0006hz-Ex
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:31 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <386A6agcKCngfndehgackkcha.Ykimaiq-Zarahjkjcjq.knc@flex--jrhilke.bounces.google.com>)
 id 1wc2hp-0006nR-UA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:31 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-84256bee9a9so25522b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782227187; x=1782831987; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B9oqbez+uHVoqTE/liBSIPZfj6UafgqTXlaZXLuAAxY=;
 b=cGfNdBDbmFtLWQQYBr7+JOjCkEnAAyn4/W710SZtyd3OZXIaqNM3OPydGzw3MENMHP
 lBe9tnDbZ131srovO7fgWeWcnXlgRXIHLhXL8hkyrXlqfxLk0A8vFBdl3qF8xk8q337/
 maVzuthQPDwKykZ6ZYdK4GFrFyxDaJJlE3wQQDwM+wWUlbGlyiFK9fIr0kAswMPDTKfa
 Jpd+9C88tgD4mYD3LhDywtiw76Fx3ZFIGf7WwscNY/5CWr6mN2pqXrbSbBWT4q1bv3zY
 L6eyKVqLjZa2Ip/KOoA3CoI/MAD+Pd3+/2AHxQfao3znZJDQuKcqek3iHoJyjurrOwbA
 yJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227187; x=1782831987;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B9oqbez+uHVoqTE/liBSIPZfj6UafgqTXlaZXLuAAxY=;
 b=ci2ioUYHNT0z0puHUN6eIXa8hmFYibR0V3CVu9jUSzUQwMYUaawoujfKrXbGaXJWNV
 bIwxYSJn5Rb4hWSgGTkTeLQAarjv4l3eAYdoyXumxU7up55iwEyfodwJWqjGqAORwMjQ
 27JFDHvcslvRNAazA9fZl7uFYDSJ4Xqg+HnmZ62n0nIbo5261qiR0S/Jn9J9NpXLwzqg
 b94JGpfCgpKskOToOwMWtz5uNCieRzadJIZrTa6hhEvspP0+Qq1xbRB0kXAE6pC3B05/
 YDpcHYyIQympj1U/bsTiT7/GU5hpqeDGi9Sr44X9kk9uSp0D6DHh9kc/mrkfgtR2TGom
 aoZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8q9c+Icc5fTp3d4c25M9FXaeSVwsRBu2e+GLbzO52OZR42x+F91x3XoyA3dQ7F2xCA9PI8TfrQeLVB@nongnu.org
X-Gm-Message-State: AOJu0YwKRFjg7uX0n+4peo89RD2DoCCZ4UZPtr0525W/vbsgKcYRBmb3
 ORj8rVNtXnFj3CaDyDSzT0AxVWVORGNOYEgSa5f5MCyyvGuhmbl66m8lamS3GKmrzF8dLElbg49
 dA0o9xxtE
X-Received: from pfbkq19.prod.google.com
 ([2002:a05:6a00:4b13:b0:845:41e9:27bc])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1483:b0:842:74e3:48a9
 with SMTP id d2e1a72fcca58-84597066c3fmr3780843b3a.12.1782227187037; Tue, 23
 Jun 2026 08:06:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:05:58 +0000
Mime-Version: 1.0
X-Change-Id: 20260608-igb-trl-19be198da6f2
X-Mailer: b4 0.14.3
Message-ID: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
Subject: [PATCH v8 0/7] igb: Implement Transmit Rate Limiting (TRL)
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=386A6agcKCngfndehgackkcha.Ykimaiq-Zarahjkjcjq.knc@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This is v8 of a patch series implementing the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

v7: https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg05440.html

Changelog:

v8:
  - Fix extraneous whitespace modifications.
  - Use muldiv64() in igb_trl_calculate_delay().
  - Fix comment for rate factor in igb_trl_calculate_delay().

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Josh Hilke (7):
      igb: Define TRL registers and core state
      igb: Add VMState support for TRL state
      igb: Implement TRL register write and configuration
      igb: Refactor TX path to return processed byte count
      igb: Implement TRL throttling and timer resumption
      igb: Add QTest for Transmit Rate Limiter register multiplexing
      igb: Add QTest for Transmit Rate Limiter traffic throttling

 hw/net/igb.c           |  43 +++++++++++
 hw/net/igb_common.h    |   1 +
 hw/net/igb_core.c      | 142 ++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  12 +++
 hw/net/igb_regs.h      |   5 ++
 tests/qtest/igb-test.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 404 insertions(+), 5 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260608-igb-trl-19be198da6f2

Best regards,
-- 
Josh Hilke <jrhilke@google.com>


