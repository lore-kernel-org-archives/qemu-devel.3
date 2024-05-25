Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4BCC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 03:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAhqq-0006eN-Dm; Fri, 24 May 2024 23:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqp-0006do-27; Fri, 24 May 2024 23:13:43 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhql-0004ot-Vh; Fri, 24 May 2024 23:13:42 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d11ed39dbbso1163009b6e.2; 
 Fri, 24 May 2024 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716606818; x=1717211618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MdGslxFncdrvTiM0liy/cphIP1pWwnJLZ7T8UacVFWE=;
 b=lLH4LxjOuyG/yqGu1n8cgW98TpySf3y/Z6/lSdycXAyYfFP1kJjj/odayBPx5CfbhB
 PzaV5JZWAORyocsvx2vi08kBsEZzmG7pr7pj1Emc52vqFMh1As7JmNWx0b0hQ6ZOl9hw
 4aQTJuiR7G8Iq4NFFenL7FKas91r4lB/PQNZTwGAhq2Eh+xZJlOivUBskZp40iIAdKxm
 4nb2VPcYhOSTI1prqvWon/dfrk65wRaO9qMIiZZt+iYUc9U8A/8BKbRPbq6TSh7lCXTm
 G/xULRQ0WvzTAz2MSc8P8TnMLbdPilBoToogwN6SEQCfX+TMrjYvmAjkdjLe51ggjLJF
 PmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716606818; x=1717211618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdGslxFncdrvTiM0liy/cphIP1pWwnJLZ7T8UacVFWE=;
 b=ELQsORXzC+ev7e8u1rFGoXKn2bV9NLce2YlTllXU6/BX5fMq0a/+1t+wdzzcChZKg5
 IwXaedba6TDYOtl6YbwGjKn56YboMed8hUuY6ENGGtFawjYCAeYI2psyMvAzWDRg10MP
 /H/PoFcNSMr2B/YxrEqzwBLiRskq5w7lWp2oD2BJM3IfY6dbZS320Bj7YcJMxHcsIqzs
 bNNinV+ey/YsxgAGuazEIPoTDPz08YVb3pJKxuhCeHck97NMwR8ID5gdKHh05Q/sp4AP
 /MEJwwm/Jq01GKSkqIrx8ygdMh3J179R9BDzeZbe3lkDjKIHRFgKDy8NMr7p8Rl/4i98
 3T8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeOSyvpIxMzkua8rOXFn7Srjw01fK23biy+c5OztPJWIDn5U6U/Ww7J5d/VdiCOZ+QnRA4VldvviHTygoXDnCcpCcTk4SXlHiFutoe7JvBsd/D0+Ox9mBx0WU=
X-Gm-Message-State: AOJu0YzJmtEzR9j9wIN1PjnW5Mt7YlPKg3G7gbacN6xbBzK0Hi+hB+He
 qNpn4dhoZpt7QWAiFsRwdT80SfTD/b/1racJZD7bG4/H4XyJdyHu
X-Google-Smtp-Source: AGHT+IFthOFirleNHauDskkMtZWLd9d72MAU7cQpLjX2dZi3C9nojpOYKRDPo8na7NbhIcz4HZKrLA==
X-Received: by 2002:a05:6808:c3:b0:3c9:96d2:fcee with SMTP id
 5614622812f47-3d1a7b35ccdmr4075257b6e.58.1716606817990; 
 Fri, 24 May 2024 20:13:37 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05a363sm1744306b3a.64.2024.05.24.20.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 20:13:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/3] tests/qtest/migration-test: Improve and enable on ppc64
Date: Sat, 25 May 2024 13:13:26 +1000
Message-ID: <20240525031330.196609-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x236.google.com
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

ppc64 seems to be stable now, only problem is the speed, so I
rewrote the test to avoid SLOF and use special bios blob like
the other archs.

Thanks,
Nick

Nicholas Piggin (3):
  tests/qtest/migration-test: Quieten ppc64 QEMU warnigns
  tests/qtest/migration-test: Enable on ppc64
  tests/qtest/migration-test: Use custom asm bios for ppc64

 tests/migration/migration-test.h   |  1 +
 tests/migration/ppc64/a-b-kernel.h | 42 +++++++++++++++++++
 tests/qtest/migration-test.c       | 53 +++++-------------------
 tests/migration/Makefile           |  2 +-
 tests/migration/ppc64/Makefile     | 15 +++++++
 tests/migration/ppc64/a-b-kernel.S | 66 ++++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+), 44 deletions(-)
 create mode 100644 tests/migration/ppc64/a-b-kernel.h
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S

-- 
2.43.0


