Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9994F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRfd-0001LK-OJ; Mon, 13 Apr 2026 20:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfY-0001Kf-OX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfX-0002oe-4V
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso61863715e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126617; x=1776731417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
 b=tOCRO8X896QZGcamXX/PQvFBRb8W0vsXU9UunOpHZzt86rhz+QrlFokqnsdxEcRKJl
 7zP0wt/iIh0oPHLXBsHI+Qvzio34eIq3n+BkXa9yd+71Hjvuc+C424cqLsngRzQfpKd/
 3uBKJQUQH4CTF9xRMV7LJR2skcx4o/9FXF7oeVdqHZnv9X3XbJRYTK+Sv6QtdbKtW2vY
 C39dE5Sgc4i9ppiK5ZEBWFaTBTQopkhoDLlXP1rsnRMoUkITukAGeZ0ZYg2B4JEVzWr2
 tsKy16Q8EeW8wbYuSEsCsGTeI12hLho8UMzYDF2SdoHHk1WSckckz2Auo0sd9Ah6CLzA
 eP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126617; x=1776731417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
 b=FcKbSaLdYwWWofXiU2JYUurWht8wWT6Qj1cp1Lf2pc5raDp6nWfBcGp6DQ5FbAe0+U
 1oLX7zagyH40FoSgxLheF0+9wjhF8s8oszMniiD1FTVfTvtaO7zGnbbIRzRddMgSP1F9
 aR1HRWiAbNF25ic/ev0Tcuj70mu+n8OZ4oAgafU+uCdd9jhXTOlqP6AyQfzgLUSNLxnp
 1IxtOV1YPZaMfU8/Ttf09Z8YNisBe9DBuQ3bNORBPNiiYahSSlcockBEx73gkMk/Kbel
 nqX+3Rornl6MdVnDFM/qjSkO0fCuIz/qjQlkUc/nD0weJsS2MvAIwAonXexRTptGbGWA
 S/PQ==
X-Gm-Message-State: AOJu0YyxI5pi6TBU8OCfeP2N/uLPGkBBQgEdTaxH77TyoB8ANO+FVdmu
 3bnhah7N+VmL2FGuSpZ8EMNnb/zwWJhMXjAslNOgOQR4LZwaZW/hPiz4OmGjpTU79VakQldkHUw
 DBXGM/K4=
X-Gm-Gg: AeBDies8eSK/LTcOlTBJkH05Ij6dzZeu4lL3y3o8CwDbBRraf3h4qhHbAMTTmjdMRbL
 YQxv6+Eu9feMHheMeR7N3e/KTE6T36ZEAF+7mZn2AUDLKA0pwfMesbsMz5vkv1jOSc5S9iBZW/2
 jjbB49J0WeEhPi3re1I8C6xf4SmVhTcoKTMGwqA0FDMMdIj1kdjcfcUYv7Tqim6QSImyz1BxNw5
 iNZbWSW24YZn6LU8E5G4pJWWgGB8ptWt4aj9KmxcYv2+83Nxyn9F3XaFQwuJalT5t+Ici2ufwYD
 +PtNmI0srv/jDNaSNncfII454Ul/HZG6LH/zM4pEcmESg4m4r0MqaFhOdS/hY9ztl4He3D1Gc5q
 LalK9ZLh/QAaq5/Qt90viUjSNo4DskySxEHx9F78l2wnJ9RjZH34tJbHgIa9VNS7zkZkv8TLvyu
 MR0K3gjBBXB85ZzIA1x7ni7NjaPS6Qyl3mIp5dOkfSp21NA8/4VFA9ev4A+LaXce1S1nIzgTBi
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-488d68820abmr222091915e9.27.1776126617313; 
 Mon, 13 Apr 2026 17:30:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e217sm10743045e9.5.2026.04.13.17.30.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 02/27] monitor/meson: Use SPICE with migration HMP commands
Date: Tue, 14 Apr 2026 02:29:34 +0200
Message-ID: <20260414003001.97571-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


