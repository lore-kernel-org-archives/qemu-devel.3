Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED40C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjuY-0003s4-8j; Thu, 30 May 2024 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuW-0003r2-KP
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuR-0002S0-Tu
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f48e9414e9so11138215ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091389; x=1717696189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a4MeqareKGtE2HuqvJKUzQo7r7KOKpQtZ4BHRcp8E9o=;
 b=hD7zCwFlRe3noZjfBJnnSyM4ezot0RWDPA3raA+6q2B/sYq6ehh3UfCtw2+TjlZO7J
 M9QTisENX/lPriGjC3uOGDcVhlXsTJ5uX0MIIlwdNwohanYz6remozY9wI8bXot8eF1m
 lDUjltBAYDaIu+Qh7xwkN85540DYFvQtj9cIpjzXT87HkPPIxgfHPt5tA8bR1wIfnUzK
 fe/bBPiadXx+tIITGC6bv0oCPp6BQdgrjHT43YLaUiWw+090Q19wVHdR/T7bLHhzc0Pz
 CWiyrS80LSvgxA/lsOviXxvPk7mf6PBXkke7vogE7XSX0sJft7tkq0K27KG+/DguyG2H
 mprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091389; x=1717696189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4MeqareKGtE2HuqvJKUzQo7r7KOKpQtZ4BHRcp8E9o=;
 b=F6cO1s08ZAIH+ZhXBJ1ueR6ndo1kZixSi4tDh3j85vnQL6JTRS8U97aR59i8ul5DBT
 7srp+8MA9W3Asu2J7SG9GlJasWg1Iq8ujCwivzGR19dinmFTdqEV4Ukll6x/BillNcmQ
 ChPLFA4ldOkMMNXZeg9ay/Dp4i89jQ6tNiTFk9bUCtG0tLMgLSlKSoY7DWI9q5CPd4eu
 FTMjET+dNgGRhmIXpxHqf1j1O8wd6JV7ICTBMJCrLc/f7eXWfdjlI1FcTdCGYwohxMxe
 X5WaKTsp/r23y3zWSbbXb0YxbH1ABp5giAHOgoXU2VfM/h/b4L1nQJtG/1FMhO61fTek
 J7XQ==
X-Gm-Message-State: AOJu0YydTkk2YgacVKD2FuJVd/S9s/25diVKMVsrTFEVVc26cNu10WhO
 BL2JtPKdUgoJzd0cD23lrDbW+ynyBh/LgJrT1CNUbmUI4fvHygCOnnTzwdFYcwEiU7XC7v7rh+S
 m0Nk=
X-Google-Smtp-Source: AGHT+IFoOdqTNsToYAxGipKadYb0AGUPoFRSdQWYytDfP30eXlGJa8GFAONp71oFKbhioYPoVmmPHQ==
X-Received: by 2002:a17:902:cccb:b0:1f4:75ec:9968 with SMTP id
 d9443c01a7336-1f61be6be90mr40380465ad.16.1717091388788; 
 Thu, 30 May 2024 10:49:48 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323deb38sm590405ad.124.2024.05.30.10.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 10:49:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/6] Implement icount=auto using TCG Plugins
Date: Thu, 30 May 2024 10:49:33 -0700
Message-Id: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The goal here is to be able to scale temporally execution of qemu-user/system,
using a given number of instructions per second.

We define a virtual clock, that can be late or in advance compared to real time.
When we are in advance, we slow execution (by sleeping) until catching real
time.

Finally, we should be able to cleanup icount=auto mode completely, and keep
icount usage for determistic purposes only.

It is built upon new TCG Plugins inline ops (store + conditional callbacks), now
merged on master.

Example in user-mode:

- Retrieve number of instructions to execute /bin/true
$ ./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true
cpu 0 insns: 120546
total insns: 120546
- Slow execution to match 5 seconds
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips,ips=$((120546/5)) /bin/true
real    0m4.985s

v2
--

- Added missing personal Signed-off-by for commits from Alex
- Fix bad rebase in stubs/meson.build
- move qtest_{get,set}_virtual_clock to accel/qtest/qtest.c
- A race condition was identified for plugins init/idle/resume, but is not
  related to this series, and will be fixed in another one:
  https://lore.kernel.org/qemu-devel/20240529152219.825680-1-alex.bennee@linaro.org/

Alex Bennée (4):
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API

Pierrick Bouvier (2):
  qtest: move qtest_{get,set}_virtual_clock to accel/qtest/qtest.c
  contrib/plugins: add ips plugin example for cost modeling

 include/qemu/qemu-plugin.h                    |  23 ++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   2 -
 accel/qtest/qtest.c                           |  13 +
 contrib/plugins/ips.c                         | 239 ++++++++++++++++++
 plugins/api.c                                 |  31 +++
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                 |  11 +
 system/qtest.c                                |  37 +--
 util/qemu-timer.c                             |  26 ++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 15 files changed, 389 insertions(+), 39 deletions(-)
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


