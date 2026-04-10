Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B71F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwe-0002Ro-BT; Fri, 10 Apr 2026 15:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwd-0002Q6-22
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwa-0001xw-Nm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so1617494f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850907; x=1776455707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
 b=XR44ntTZGA8OiXTeDSwE4T+q3zMF+j8TDb+Ng4cU1eSMmgI8rNg3HzWndJNenAQLo/
 DbtDwaMpwKj8YQ8eFdu2KtTCf2s1iBIi728WMB9u6y2Lo4JwpMu2LACkS21B2o/azr58
 TZhBDa9Z6F8+pyV6GnE4TFHefUj9Vt7gEYIGa3KdR9pDBUB7i87X6ciAMEVGdR91gnll
 sO1a9/eXGX26qr0eYepo4/nenTxt8WykjlQjxH5NajTPCR0OTq+ERR3K+xRgef1obxgh
 BFaxALTvK/rYzAfLyED8M39As3Xls8pVWSU1chl1+j9yTHFnwaj4FpPj8NckN4O5tKch
 9yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850907; x=1776455707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
 b=tKffO2OroTHmUDdtfYS4VaOjQ/XYsfYXO9yrE8K/RPbJMaM7XeF+XjqrfaPiF3gmdb
 /8GSrpQg3hJwH2awsw8oG21ggIvbxewIxpGaY85O42QXx0mIlbWVQjV0KOHgtSaXk6/c
 uSTYHREAcbnE6RfxpGNl3skzHLIIbrkT2G202Pjwoo6DN7Bnf+QZIoUR7d80WKBr5plH
 QEWeyjqWuaUrziPnRamfvfdUCWzNBs9bB/l1/P1QlJZjqHVq0dOBjXQGw3f5B+vTWXwM
 VKr4y7dymmKShgNEF+LXEJxXADM/eom31i2rWHvHNn2ev3gRBeFWKvmiGz4F+1d+0yEX
 +VMg==
X-Gm-Message-State: AOJu0YzUyxjkSk1AOQO34K4MJZYMcIfrePJwUtPCtH+TRjVXyA3mRm8k
 DqOlHYW6Y7Wu3Aj1HJFfhrrjZ71wYO7PO0sUt9K2gUzoqMHG95uvnbRO2wnx9J3SBJvoWsZ8XxM
 SUepTgdE=
X-Gm-Gg: AeBDiesI6YESAamBSYfXnyVpxtBrMbL2q1CnFRncLf/h4ME8Qt6OoasxpeotD17+yo4
 D5NLGxsIE66lF9sqki0ImTWEB8uTKF1NXVJw81z5NtKbRM4gRM1Rtu3cf0PCneb4phFMEFh8nt2
 snnfnw67yRr52EZWLa34pp3QjMdT/lEBk5oXPG6j8O3NubXV0qswR1omVIJgY5duGmLt3I2DC5v
 Y4ptYCpQB+k1S5EskyHBqb23o+f1LSSxYHqMtMoYxBc8tyubfABrN8PkPVJUdcWoFEH6yPiGBdY
 QNj4hctlCdKHyHSVx9ccAUrCU5lcWu+xdDc4AxYxvBkywKJbVnT99Ja0SnSTtNeQ4kW5W/aQuxv
 Wt6oL4zRt41d/2GBKT/51VFIHaFMMGrkGOkXxbB5kEQDktKfjQB4VYPeCNZM2YyqrpMZhsMdEAf
 NwGe6jZfGs2jIPGf5h6LzxbSS3yuV28hpwbqBQvJTdFQyGO3rkwUOHEZ+536eKB3Kzyzr5vn3D
X-Received: by 2002:a05:6000:184b:b0:43c:ea2d:9c7a with SMTP id
 ffacd0b85a97d-43d642cc2dfmr7403832f8f.49.1775850906890; 
 Fri, 10 Apr 2026 12:55:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e468d0sm9671181f8f.18.2026.04.10.12.55.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP commands
Date: Fri, 10 Apr 2026 21:53:08 +0200
Message-ID: <20260410195323.17937-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

When moving code around in commit 27be86351ec ("migration: Move
the QMP command from monitor/ to migration/") we forgot to update
the meson rule about SPICE pkg-config flags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/meson.build | 2 +-
 monitor/meson.build   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index c9f0f5f9f21..e583822dec6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,7 +23,6 @@ system_ss.add(files(
   'fd.c',
   'file.c',
   'global_state.c',
-  'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
   'multifd-device-state.c',
@@ -37,6 +36,7 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
 ), gnutls, zlib)
+system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 2647100e04c..585251804e4 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -5,8 +5,8 @@ system_ss.add(files(
   'hmp-cmds.c',
   'hmp.c',
   'qemu-config-qmp.c',
+  'qmp-cmds.c',
 ))
-system_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c'), spice])
+                if_true: [files('hmp-target.c')])
-- 
2.53.0


