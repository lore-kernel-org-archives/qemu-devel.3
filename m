Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7AAC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoN8-0001ez-Uw; Thu, 09 Jul 2026 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoMu-0001bf-4h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoMs-0008Vb-E4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cca24023edso12326085ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783602040; x=1784206840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r89eZtUddyrsw64I/1ccbTZ9hsRKBeNUmCpwWMn2aiE=;
 b=RPN/20qx3i6bVJWF6afOZ2Btmdveh5VER5cXiUuEaiV7lU8FA/7U8+N6qURFK7LVs4
 /QpFhQFNR5cUeDHolDNdnDVM0MQh67v/Tcc2imeX+mYS6el5lTt+GWFnGtoQ5PxZn11W
 X/BnmvpvsX1mXuPIfPwzNihfPvypvF8lNBks6DmnB/FUSJtmueutQF5HN5YsCk1nXKnN
 0YTtXQnRrhew1ijQXPw5bdcnWHY016ZU1S8l4av88RjU2+b5OAArHZAy36R6/ZwonpY8
 2F82/iSBEz/hrhGYu3tgtnZpPjFErwSq+RUSmhk8LiN7zaLUKrmh1RPFf50MmgmKX39W
 zU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602040; x=1784206840;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r89eZtUddyrsw64I/1ccbTZ9hsRKBeNUmCpwWMn2aiE=;
 b=UMUlr44PVdEa3vVAS9+I9PLWf0139sT01DFPtzyvLh3J2/KrwDcn1GvkJSOWfuE6ep
 VOeauNgi/K7Iob/tKyf4ICKKLviwz//WWJPlkMOyI8Xf+N1tHF6Tl5vfdeg7wD3Kgfxa
 b8pwepFCn2ECUPt2ItukJBG4qrFG8rElGUHCKSqfvsSY699eORGU3wHuqJCqywAjAQv1
 27A9u3Gx8uzYD74lxhJq/h+sBYcNpDzFKKvZ2QxrTnR5MfyI4k+saEF6ueGI0mNrz1Yw
 Q4bVtKJuSVq0Oje0uwWxzhes3+YWJfLh/aNF2ClAxGgOY0tZ9FyiOPILVVMrljP48Bf/
 yxMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmRNnBHqmIQllYCN8StjcJOCUuMy66OUSc+OJPOpo0YEo4HNONvtNYlv+L76ImzcD6FFTB1FQ6P+Ch@nongnu.org
X-Gm-Message-State: AOJu0Yyau37oPffSD1a4Z3c8IHLj1+XOz/uDRZQN7+NDFvTjFWEsIP+r
 b+Ii+Ih/iAbnKkSh3lh4jB964EFa6kXleB3MlgjRHslpPfYShEPTHbHk
X-Gm-Gg: AfdE7cmWzXXYnxGXCwGWKgPdU1RlSGGBl9Zs8DkBBpXjZ/ld5/cDkx7QQ9xIei/GDBu
 MOvNZfumj9ZRMAgLu81M48FzgJHVzGe/+A7LiW0HvB0vTIhbRQeZobB+sii2QbHjggkBRZ54eiv
 UxFi8KqqPolpw48Iwv6uKtv5KujnhRPgafEr7ZbzMKcoEoJeVRyX6LZe+mCc9hW40oWzo6pv9/3
 NQ0OE5TI0JS9d/ZHciBq1+tzlqmf0AMa9dfUlRw0z0aiL6FPa8vhbhGSOntgHlCZXd43uGrU0MW
 znUmsMJfBFaLiYfPfU0s7XrL4SWMtoh/o8AU68tB3KjSe2BwI3qH6mBJU5dB++Ae1u9ra//+xS1
 aRT4O66o5aD8W5NF/PALBNn+hiVgzBLXU8krmvcAu4mc6tK2DsLObansLhX+uGQJ2N7HsXAjcwg
 zbx8glOvvJSO8B2e37zkqzq9pji/WM4mOiHG/XQ7YYoCHrDZEl+B4VXFHB
X-Received: by 2002:a05:6a21:6494:b0:3bf:6c08:4ec1 with SMTP id
 adf61e73a8af0-3c0bd16300fmr8663462637.54.1783602040106; 
 Thu, 09 Jul 2026 06:00:40 -0700 (PDT)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([111.223.92.222])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm32908611eec.27.2026.07.09.06.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:00:39 -0700 (PDT)
From: phind.uet@gmail.com
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3]  Support chain migration in test
Date: Thu,  9 Jul 2026 21:00:24 +0800
Message-ID: <20260709130032.58667-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x629.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

This series adds test infrastructure and test cases for multi-hop chain
migration, where a VM migrates from host A to B and then from B to C.

The migration test TODO list mentions ping-pong migration (A→B→A) as a
desirable scenario; the true ping-pong (A→B→A) would require the original
source A to become a destination for the return leg.
This is not possible: a QEMU process launched without -incoming cannot
later accept an incoming migration stream. Instead, this series implements
chain migration (A→B→C): B was already launched with -incoming and can
be re-wired as the source for the next hop, while a fresh QEMU instance C
is started as the new destination.

Nguyen Dinh Phi (3):
  tests/migration: Factor out per-process launch and setup helpers
  tests/migration: Retrieve serial path from QTestState
  tests/migration: Add chain (A to B to C) precopy migration tests

 tests/qtest/libqtest.c                |  16 +
 tests/qtest/libqtest.h                |   8 +
 tests/qtest/migration/colo-tests.c    |  14 +-
 tests/qtest/migration/cpr-tests.c     |   8 +-
 tests/qtest/migration/framework.c     | 475 ++++++++++++++++----------
 tests/qtest/migration/framework.h     |  21 +-
 tests/qtest/migration/misc-tests.c    |   4 +-
 tests/qtest/migration/precopy-tests.c |  51 ++-
 8 files changed, 389 insertions(+), 208 deletions(-)

-- 
2.50.1 (Apple Git-155)


