Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0605D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtL-0000Ee-Ow; Wed, 28 Jan 2026 20:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGtB-0008Vg-Kq
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:06 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt9-0003Ar-0l
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34c5f0222b0so222712a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650322; x=1770255122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9g5XwC8X2bCijA/ZXO7zi5qSvvTibB1PBZ+Yqaq+PhE=;
 b=NW5385XnJwkLY1/Q+cpgwxB/mXbBKiUMH6Ff7UIE6Dmj/EaGBNnigaETQN1t5UNPWK
 6rDS0f09cIZZiSCg28mZFgSdfxplzyjZPmwYtDa4LSugq3iOUlFUNmcwDwZ6g6Y1WvvW
 O93hKf91NFOwz5XSv/1qHIbQFj19qBFGP1AmhUDWRJuEucpYHelIXlVi+9a1gWas1PwK
 gUR5nmOtfCRV01f/evSw1Q3226+F6UkMWHk+roWNbP0ypNsiX2gO7LfnGKHsGW8yaIie
 uMtNp9VEuxSsGhnus00pM14tkT4eYAcSeAHky3eVJZXwhM/Z4UTrJW0gpAlm6ndeTnOG
 1ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650322; x=1770255122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9g5XwC8X2bCijA/ZXO7zi5qSvvTibB1PBZ+Yqaq+PhE=;
 b=dOm4f8xSmx3UnHpdQIewnbsg6zAy0TgPE9f+yW9AEVhXa/tdGSve8VJb094b2TDy1k
 mWDQjfiVxzVEj3Fm2NWOTRu9N09u6SI5rXFrTtPJiHo+ZfxSx+/uUTBbv94WeeAOXguX
 39UwpRzsm7BCQRUWBoTG+EfgEl7s2jZJ9V6CmdUZbfNv7WY/VB45pdSlHkwelELE++nK
 VgnmrILI4ZxP3jMsc8ENcbglIC1PvXqqdwnpDX25P5pSyEyMixCoiMN6ketOl9AU9hlV
 sKUhFmyeOVuPb+3q/T9ehPoP5ZCpRdJ7shU/eL/ER9SggNgnxWH1O5bbZYs7Xl6l0Lc9
 1w3g==
X-Gm-Message-State: AOJu0YyMTG0cPM/A89NbSiqGCinMnMnaE1hwxYemjGfeoLa/Zvv6f6pa
 IZ0cKjalwRL6jsJwwBQPcWCCJyZeuIIt4ee71FxVkPpTbyfXqCSebIKjIPP0PMzkhqUKcZI0I2Z
 ineQm
X-Gm-Gg: AZuq6aK9hZWvwtTBqCYkWmHsOa3v2GswSdEuTZ+FcsyEvK+8ofOHiA8H/s+IF9kGfH5
 B9fTHnRx2VF95uuKtu/nLiPtIuTgQM64QPSeB/e/19psF0tWrxlURHnIZzIshC+faCS5bNGIWF6
 SQmQqAcxo+gdjmia0l89sSfz7dXAjLYvhXC+7pHAmUvTl+S2q4SjJlBXRgaSBCFI0ME9npDLk+m
 3UnzPlQtP9rWiU8MfiNWb0fpa0NDtDbQfkG5tjTw0zfocCIrJQXlTsn9QEoXAu2Fwvjl7yQd8Ux
 7i/JXHAUpiEWC53ndo39vVv9HrX720rLpcq51g2L8RidjM0+gLryXuOceXSpiwqV1w4WgLeljCq
 DcwTJpdy3LBpdFuyj+Rf+gy00l5sJUDlBk0tQIJllc2mtof7xhazP7AwlBITje+HaiEkr/g6RkD
 yA3381lN3i52XK9yCOgkvzhADNjPmCnaEDjI9cmUQjac2Oop64575nxav/xbYKkVv3vWu8t6Yec
 Ak=
X-Received: by 2002:a17:90b:2ccd:b0:343:684c:f8a0 with SMTP id
 98e67ed59e1d1-353fed8fecbmr6226826a91.23.1769650321647; 
 Wed, 28 Jan 2026 17:32:01 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:32:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/20] plugins: reduce source conflicts in plugins list
Date: Wed, 28 Jan 2026 17:31:34 -0800
Message-ID: <20260129013134.3956938-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 19 ++++++++++++++++---
 tests/tcg/plugins/meson.build | 13 +++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 53d52c97967..099319e7a17 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,6 +1,19 @@
-contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
-                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
-                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
+contrib_plugins = [
+'bbv.c',
+'cache.c',
+'cflow.c',
+'drcov.c',
+'execlog.c',
+'hotblocks.c',
+'hotpages.c',
+'howvec.c',
+'hwprofile.c',
+'ips.c',
+'stoptrigger.c',
+'traps.c',
+'uftrace.c',
+]
+
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep.c'
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 303f97f9679..c5e49753fd9 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,5 +1,14 @@
-test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
-                'reset.c', 'syscall.c', 'patch.c']
+test_plugins = [
+'bb.c',
+'discons.c',
+'empty.c',
+'inline.c',
+'insn.c',
+'mem.c',
+'patch.c',
+'reset.c',
+'syscall.c',
+]
 
 t = []
 if get_option('plugins')
-- 
2.47.3


