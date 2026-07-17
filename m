Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B8BC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmk-0007JV-7r; Fri, 17 Jul 2026 04:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdmi-0007IN-6C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdmf-0000H4-MB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:19:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so2119385e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276340; x=1784881140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7tS5r3/DAfACBegouwizOa65kFVV2Vd21tyezne+TO0=;
 b=r7WmeK54L384yZH7MW0Vwb4RQVutKoEoMa1VrAtCbCb3pN9bt2MU/3ENtzhoki4Wkv
 NwzrIoPAU6skfPl2mLOfb6sMP2u+4NLG5WPqoaX8XbJI7cHZc5UfBoLOXJmLTIzcfaqj
 zyhY1s99lpQtjEnjTFnE/jWEGvyA/RW2IMOyQAhLmtM/53TR2WcQ+UEm58PtfekOiMEV
 JQWb9+T6qduJIDwbz90cPjkdjs/Cq+ilH87fp686vHNJnTWIV0696NRHKUqmze7RvMuG
 0fxBYhoE9In3z00OEqA8hcNXffW5L+wl1ulF2btThrAT0T4nWY3H4q6fiFdHHBtpKq+G
 AgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276340; x=1784881140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7tS5r3/DAfACBegouwizOa65kFVV2Vd21tyezne+TO0=;
 b=abC1ClNHv/M70T87P9b2DxcsCM/6jnge7oZrbiRPGYaBgHdcW5blmIanoVSnJx4bb/
 znzODMwy3UvE5PwNkyEu1NXu88rk4xFViMsKUnI2/U6jCa8RQzSinJoSIEYuUOLUT8aJ
 9kp8ec+p8kDkWZb3gmj5b+462yTSBWIvFrAauPBTMqnzl8rGW3FuX7d7Sdd72oz4yFn3
 EQeiR4h6kES0lZ+9Di1jPwDL040OUI3uC7lQ10bQIMp/Z/jLZbNG4W73aIQfBwLJ1fiF
 XUIc3Dlvmid0Da22cJqKAy2jKk1CR+wbh8pqcXYdmmwo/hlQHGH2ypAdDHhomrCpAb5w
 nGTA==
X-Gm-Message-State: AOJu0Yxln4eR9zRTTJbbssitCnswgZRQdYkGvgz/vmZqzM/tbvIglVsh
 +s8QoPiUb+NJQuMs4w9MziywnoxUAeaunV7fuZWdQalIV0T5fjPM5H91i99GhDco/58=
X-Gm-Gg: AfdE7cllz8M9Ke3nbLOGpt3d4ETiKfR7xbUG1d3jg9uMez3+LkKDRTWJbTMiUcDAoRn
 rxTLG8Uy6b6euMoowxsiH75ccN0TmH3NnAF5UP30Nd9opFZZ8mGxX3N3YVwaqb8kumG0us9dUdU
 pDhdmpksrtpWNEg6HJsUInLUqmUfAXuLtABD2G6QukSR+AzBT33lgmxkteQD0hgcaXzfpS38wON
 zAySXDLQHe9e3bo2FnIWfTJGdwsgxJvXRLxTDsXSNSEnTCfXhxSKUR+Zqc9NkKSnkLACe+5kd5x
 z1jTmB8J8vC+oMeKWx8/AtBPGrc7luIrRnF43gm3xMILqtAwQApt6hzlSvYaXTGnDCPWhRKt6AU
 TMkIeKt317LwySojto4Ol+MnA9s2VsSupBDkphQtSgvNblH/Yxf0I9jxCwDziAXkkZicWABK6bu
 vgZouAlGp1Wzh+6Tvuu6saBUTThFiTwhjE/gmijvFDJqihYj/P1pFuzuV7jkpquS1QboqLln972
 setkmPUdVOikAlXjVssHKf5bnFsmc/FMvf1aAJnf5jOByjoFJE=
X-Received: by 2002:a05:600c:304a:b0:493:af56:8e64 with SMTP id
 5b1f17b1804b1-4954a40ff61mr12696445e9.32.1784276339272; 
 Fri, 17 Jul 2026 01:18:59 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm36504285e9.11.2026.07.17.01.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:18:58 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 0/3] tests/qtest: make PCI tests resilient to a compiled-out
 i440fx/pc machine
Date: Fri, 17 Jul 2026 08:18:33 +0000
Message-ID: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

QEMU can be built with the i440fx/pc machine type compiled out (for
example via a custom --with-devices-<arch> configuration that only keeps
the q35 machine). In that configuration a few qtests fail because they
hard-code "-machine pc" instead of checking whether the machine is
available.

This series makes the affected tests skip the pc-specific paths when the
"pc" machine is not compiled in, using the existing qtest_has_machine()
helper. There is intentionally NO behaviour change for a normal build
that includes i440fx/pc: the guards only take effect when "pc" is absent,
so existing CI coverage is unchanged.

For device-plug-test and drive_del-test the guard is placed inside the
x86-only branch that adds "-machine pc", so coverage on other
architectures (which use the default machine) is preserved, and x86
coverage is still provided by the existing q35 variants. For pxe-test the
per-row check mirrors the existing per-row qtest_has_device() guard, so
q35 rows keep running when pc is gone.

Tested by building QEMU with and without the i440fx/pc machine: with it
present all affected tests run as before; with CONFIG_I440FX=n the pc
cases skip instead of failing.

Rohitashv Kumar (3):
  tests/qtest/device-plug-test: skip pc tests when 'pc' machine is
    unavailable
  tests/qtest/drive_del-test: skip pc tests when 'pc' machine is
    unavailable
  tests/qtest/pxe-test: skip per-row cases whose machine is unavailable

 tests/qtest/device-plug-test.c |  8 ++++++++
 tests/qtest/drive_del-test.c   | 16 ++++++++++++++++
 tests/qtest/pxe-test.c         |  4 ++++
 3 files changed, 28 insertions(+)

-- 
2.47.3


