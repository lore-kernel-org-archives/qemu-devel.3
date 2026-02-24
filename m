Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7ADF4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux2J-0003jQ-GK; Tue, 24 Feb 2026 13:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1y-0002kq-TV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:11 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1x-0004GM-2l
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43591b55727so5678964f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957266; x=1772562066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ndZhEXklanhfF1d8E2JZbQXw44iW1FlmaDAapkc83I=;
 b=pwlF0ViNrdpcWsrbSFho0W8tDL0ama4IZT0dOYPU6W54PkLpFUg58Hu7GeN0MHSRlt
 agZxk8VWifHCtQ3ki91nK3uLhDX2nwCzWgqNCPgxhAOwSX6tCIxcfjsR6imM7Qz6h4JQ
 Go4NvCJHNRO4+kiIk3EJAdNffXAmoEb6hEJkyjIfzy+CcQw3mCo/OQzW369iieJiBBFu
 nD3KYyRJ0obT1wpQD7uGWmmHfMTy5f9QypJkPlB0Ouj/G5J9+HDsLBJH0+R4bRbFBsgn
 FDQgjBPU1jOr+z55j2IA2kntufSfXqMBJLqACUCAgib69Oy1H4u1ybXnD5zgnmrnwxA6
 dktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957266; x=1772562066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ndZhEXklanhfF1d8E2JZbQXw44iW1FlmaDAapkc83I=;
 b=HW1d6SQLd8gAicWEKsQipMngDLpU3mP9vk73OZUlFFn571I26dGX39jsT2Q7r3WvLO
 EPck+x9Cgi6ITjVV2WCMxP0peXFdvifaGa8idO6vK75vjrf+XrOqswsztvHR2cp4Y3Nh
 SFs/Z8VUKY6olZNrahwkPkdlxDr/gZly3hORUaAcQsNkEiXrzrMOjVuOmw9ku2LRfOUj
 L/QCH0/eobxAhZ7ovzLiF7mRjaqclrhlTXKheezq879ATv2I4HbdpujiJSUY9TKCrkVE
 O/pqGW4tBa7JPvFpxVbLqnV10fBukoH4t9aNElLsY9yCTh3MSheQgFXQXar0020l1SAd
 dmVQ==
X-Gm-Message-State: AOJu0YyYG2uzWqPKoNUnQBYF1v5NkNp+ZaP5Gnm++K8nRubnRv3YFBCQ
 yVN1WuUs2bWfIgbApTriZFARCxvQ8lv86hZUbw94Jg8m3f0YDgrcdfw4QUMa+0QtGDvwzOX2fuh
 luu4f/hk=
X-Gm-Gg: ATEYQzzgCcS34G6wIQ5Pnr5e6frM1VyCmvpm91UYblsiNf6pDQg6CdcbQBdB8eoce5k
 hENRzDCHUSo4GIk2VifXfNmTW4bc0wbwTo3PgOZCxeTVa6eroikpFlZ/ToqIPOcgCN2v8Ry2+90
 g9EfIflEkhRc0DYdfAtxsKbjKOfjdjewt5Lj8dqc1AYZB0kb+fCFfm1p71lx1YaAu57r/YLaaQF
 XPgy5lzWQ2LumJfXXMxa2ljC5RTiQbi3o7/PzyfqbVC4eOTmxei7MUbrQ3OHIdBSYjZ2kkKLWoR
 MrqqP8imN2zh17yBG8H0JQCHG3IqcQf1w/DSOwDAUTsxzif2Yy9LKRDdqGr/xaEmcMN0sFz5qBZ
 2+lNA/qVcegpEDmewW0bFHbOhAYsuKpr3kJk2eVrtMOsNe86xohb7DJwT3V9fO8lxcuDceRHSJZ
 g6xqhdLl235KifKjI9V0IR0aqYI1bOngI5zDwEAtN9x7T0N1C+k3d6D68dUnfx/HkRgwuSdZDuf
 lCb/Monb/U=
X-Received: by 2002:a5d:5f89:0:b0:439:8bff:3635 with SMTP id
 ffacd0b85a97d-4398bff3672mr3048600f8f.28.1771957266530; 
 Tue, 24 Feb 2026 10:21:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff6dsm29922047f8f.25.2026.02.24.10.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:21:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 07/10] hw/net: Build stubs once
Date: Tue, 24 Feb 2026 19:20:13 +0100
Message-ID: <20260224182017.99865-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

qmp-norocker.c only contains stubs, rename it accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} | 0
 hw/net/meson.build                               | 3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)

diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/rocker-stubs.c
similarity index 100%
rename from hw/net/rocker/qmp-norocker.c
rename to hw/net/rocker/rocker-stubs.c
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 913eaedbc52..4ee09143165 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -67,7 +67,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
   'rocker/rocker_fp.c',
   'rocker/rocker_of_dpa.c',
   'rocker/rocker_world.c',
-), if_false: files('rocker/qmp-norocker.c'))
+))
+stub_ss.add(files('rocker/rocker-stubs.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
 subdir('can')
-- 
2.52.0


