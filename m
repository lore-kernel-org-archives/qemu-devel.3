Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C097DF30271
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oxH-00061v-18; Sun, 15 Mar 2026 13:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxC-00061I-5j
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxA-0007Cn-Qm
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:08:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483487335c2so36301905e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773594515; x=1774199315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KqnHJ7APlA/JTeEHW2xVuKwRc5n/Bg3jhEZFOK5PiDM=;
 b=JXkTSmPixEAsZKgTcLwB0bvSc83R74q5JUBkg8t1xk5SqVgMIa+qSMTynxxFRy1hPK
 94ES5Aq9nW2g/1IIt83kgtVu6Pxj8ConaqcSqwQli3Xar/9KhK7ZgEejuJw/1Ra/5jx9
 03/PzYJOSQzKPVGIDfCBKO4EfgL9m1C66CU6pw4HUIauYmb3dsAJ1qQEf0+CP2gKgP6b
 OuGmyAUsfKqYT/FxRwxhNeeexwI6bTzIJXDqfGBCXFvjGSZNZpraED45mo364iAsXYMu
 fMM8lFCLMLuZQyaFBDZnOIV9KhEDIFx9Qt3f7moQMJhT7t9W+2jQK52RojQXbBj8BTpP
 XSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773594515; x=1774199315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqnHJ7APlA/JTeEHW2xVuKwRc5n/Bg3jhEZFOK5PiDM=;
 b=By6Blqi08fcxsINFizhxKd+eL7c3yURyeV+C4FHtHDYLVP9o0coznPJRij+sSH2OFj
 gbpyTrDEET0rLcUuHSVpsF+vQ9sSPrZuQB3PNiRoq3Am9Dm3amg5+9IP3OqUPIjX6msP
 I2usLJ8Dm7mqab090Slsfwc9ytezpjPI1B/D0+iuVOY9Uu5bsLK6ZUX3/nQwcno1U0L5
 9TB+3IiUB7llCTdwZPagqC2wd9mBbJ8ad3IyzyWYvKqXaZxRMxO8Ye9hx+y/+r/kzBZA
 xD8WexE+7kE2MCphX/vcROfPqM3NeRYccBa4xPuhAua1s00Oh1nqOuV0YJJw+meewEHl
 uFMQ==
X-Gm-Message-State: AOJu0Yzit2dyZeqQX2NBzdVL4kd4c4lTE5zX7+cMPjEd6dNzeqtGjLcp
 OF7V9ju9RuJnJmWhVazEeKtZVe+FM9cAL9AQvnTJ2lGq1vws+xM8KRMIca/kWZ14IDCUXNI9eRK
 YBaQH868=
X-Gm-Gg: ATEYQzys8PIav3uaKmfqfXJxcKJ1CVT+2/1k8YAMWhkL1iaParGv7zBS5BqlEUiDoAP
 8U4alb5TzR+5u7H6fta5+d1tBQv354+yiWt+PgqBU84WcEZqscr8HU5Q0YWj0bnB3bxwDmbuadj
 FqfTk3wXXM6YlgPtxciWrQIqSr2r3EV0KCKVtXfOrt3JI54Wsk1CsH8xZ5xRkq0+yAX3DvFZUoA
 SKy3HrM/bICcRY8GSyD6drZkaQBxLKvYv+TlyV/Sm565aOJuFseUWY/3nc8lXBAIFvNkH5bcppL
 QduZG4JO7p1K2sDFRNdIy6da6vP90zM1UTJychmBELHm4DLBZ/4BKHE+a6sf7We9dmtIcwulU5W
 z1lYWgLnuHoRo4AZxKV0L2AMe9jeIMMkcnx1A+5KLXIRx95G0Nebzu70XMwVFE17isowj3jHae3
 GKMMY+x+XKOz0rBqPpMNZ2+5dWfGb8lWgtLMLmnOxd8PRHBU4jEkMpErBZ2bGSyAhp5U9OaP4D
X-Received: by 2002:a05:600c:8488:b0:485:3f1c:d897 with SMTP id
 5b1f17b1804b1-485566d2fdcmr157852875e9.9.1773594514830; 
 Sun, 15 Mar 2026 10:08:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563903bbsm117030235e9.0.2026.03.15.10.08.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 10:08:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/ppc: Replace target_ulong -> uint64_t for
 TARGET_PPC64
Date: Sun, 15 Mar 2026 18:08:28 +0100
Message-ID: <20260315170832.40331-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'target_ulong' should only be used for fields when have
different size on 32 / 64-bit builds. For fields whicn are
only available on 64-bit builds, directly use the 'uint64_t'
type.

Philippe Mathieu-Daudé (3):
  target/ppc: Explicitly declare CFAR register as 64-bit
  target/ppc: Explicitly declare 'cpu_reserve_val2' register as 64-bit
  target/ppc: Explicitly declare BHRB related register as 64-bit

 target/ppc/cpu.h       | 14 ++++++-------
 target/ppc/machine.c   |  4 ++--
 target/ppc/translate.c | 47 +++++++++++++++++++++---------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

-- 
2.53.0


