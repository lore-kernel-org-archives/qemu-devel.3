Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E284ED46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtG-00008Z-VF; Wed, 28 Jan 2026 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt3-0008Rb-LF
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:58 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt0-00038V-S0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:56 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c6541e35fc0so220281a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650313; x=1770255113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=ZeszBksTqWrWtBFrfnyCmsxukM0ei6lE5S+70X6i8e36emgTeMvV+nAEIlvjKDiWlf
 yFzUwvagMYqW5rD98TqE4eTvKjVBtDJoz/eSRAumYHr4FBRZLozEql+NqqOlx05Rtd6N
 tqBul3znYkHAUu4CX89hUb62raSsNa9Buw7RYp+dR3/5c7kjUA+sYnLiSuTWYrUdkW0X
 I3W4N0ynWaRSd8dUjdffBc9wscMKOvD8PlkvrQJ+UIMOBenQjNuEHvBbbYOwe1ksNCBW
 t41EDb/2ekltahTiwKsIn7YzSyzh/eeCuHm6T8V+va5UQv493//0jex1YE2eGNUB9fGU
 +2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650313; x=1770255113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrBMb4pzsR09kFtei/WUANIUl/9qDP19I1CZ/cFKqvE=;
 b=GYcy8PKtFX9Li3lHCsF+nEcnAUSr4zZqw2uAXjiEfwtzT8+Uv305Uta1QJZ6J7+lVE
 Blp+qHEK6fE3W/MC2xPMrGz3jwbaBs3AMMguwsD5GZyibYoLhkkQspKrT1XgcEr0YaTC
 RWnIDGPWdrrRAEgYRLn46FNTTBPjaHaHRv9vNAADj9C/V/peFgfV3Ltn829y2Zh3bdGq
 eVSR6iFWZryaNq5z6hC4WNajcZqpM3KUyE7vrkAI8tAKTKgDMPDTPbjW58g+WC4aVXPg
 B9h/chehq6QWlPaDAaldxcOoqfpiWgiPLt86+8b7kTTyvTihlNdDeFfc18bdL+hZ46a6
 EJPA==
X-Gm-Message-State: AOJu0Yzmm+Ux2YKYlGvU704/rhHYydQmwlIKKfpCT/PwuG8dDHcYy5wy
 VMRkpXhUgDLcj0vc2hi6L0OHR1sgZUMnaFzEMRuhaJgmz5+nDIX1m/CZRbpE5tYXE6VIJ1ODNcn
 VDFxS
X-Gm-Gg: AZuq6aJUYCSuiOfPKWv3MWh7VV/Ko5iYkFE/WfcqYL0E8uB3HtR0VJg9+HGMADlEhds
 CFWovhjIc5VLhPzuejk5Z4hhEiGKhPJMkgXX223ZW31IZ8iEhtJN4QbTW1WR29Zbx+Q4rMkGvkI
 lP7ws1cD+9+f7f+Mib7cQ01PF+3eTKJWQtW6v7Fl3DUy/PkYYWko2Rccd0dTcAJEzcbsSpTR/Uw
 2TCz8XODVSYMKtx0sp/52h/RL25TeXPRqCFB9xNSOumF0doSuXsOonHG9Qf+Wu36NdPhiWf6ror
 kPgUEbsZS8eIGkMq0bdGUSfS5SN6GoneSuOfTVeOO1gzESfmsrbLrofWqy1fRwwavqxwqsVqBX7
 o/I72SBeVGbr86aPipofEms+LlQtvlOJhX5I25LzZEbjm213piEl8vAQFZbjU3jXTibTu9oMZMu
 NLynnIBqrISLAHtV9uEY0t5ZZjUcSBsZji/72dlGO8QNwAclft3JhkTqBRgjVFmMHR
X-Received: by 2002:a17:90b:3c11:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-353feccd236mr6318619a91.8.1769650312956; 
 Wed, 28 Jan 2026 17:31:52 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 09/20] plugins: move win32_linker.c file to plugins directory
Date: Wed, 28 Jan 2026 17:31:23 -0800
Message-ID: <20260129013134.3956938-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 {contrib/plugins => plugins}/win32_linker.c | 0
 contrib/plugins/meson.build                 | 2 +-
 tests/tcg/plugins/meson.build               | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)

diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
similarity index 100%
rename from contrib/plugins/win32_linker.c
rename to plugins/win32_linker.c
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..6f72b2ce0c9 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -10,7 +10,7 @@ t = []
 if get_option('plugins')
   foreach i : contrib_plugins
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159eb..a6e78438510 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,7 +2,7 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-- 
2.47.3


