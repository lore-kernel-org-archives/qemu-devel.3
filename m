Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A0DCA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhk9i-0004nh-C3; Mon, 19 Jan 2026 02:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhk92-0004it-Tx
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:57:55 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhk8z-0005V4-GR
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:57:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a1022dda33so24380565ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 23:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768809467; x=1769414267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DxscA+wGo/cchUM2meoIi1dB7Q33+KwYAm0e6cFjx5M=;
 b=kD3ytv7b9hOVOENXPFSXM7FT44PsO65nUDDkOmoLELvYFS4KBzYA/ZLLICJ0fK3xow
 HgW7g05cGlYxAxq12ClzUyDBsV4GOZycMqTPJ0mxNNkiUJuAn2jUcQXJ7nBF2SPTDe8R
 BdVxrcENoxNQKd9hjIeMNCIH5IdZ3JGZ1Qdx/r9q0Dt+skMuGVtwYNNvPtCP3HJ32/Bp
 XjyI8iKQsJ44uwwYfe0Loyaaub3iJ/Rz1cKABtKZAjrFuOoqzFuTjacVGoBSfBT2n/qO
 G3rXxt1Q6ztfmRdUrEqkyMcfsZ9AFqJ8piLrkaD20OQ1wHStPrAg7H8f2aw9sVlrX+0o
 iAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768809467; x=1769414267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxscA+wGo/cchUM2meoIi1dB7Q33+KwYAm0e6cFjx5M=;
 b=Qu9YXhaRAs+6GP12RFsXHiBkDeInHpi60w/VWp61fMmtPbNG62PKVZhtTZvAimtFJT
 kx+XwCQQcccYGVRMxYDyiANm/lbMrDmjbRY8FmRsnEPymuallD02y7VdOzsf+8LXNq6j
 Lrzq6AFzSJCS1CYkeJtMJIvTcfBC1ukwc+BfkVtKVmjyI+4n0z+ft1CRoOZ3r4WDyzTq
 MQgZiVMqfai+njNA3I9HuUTT2v+nfoB7knMBtW/OpZKJp/0xQpb0seNhE1fRuitdWmjX
 QbktujA3n2kZdIrb7Os8NBhvO3QNvvfKweazPUI/PvB4FC2mZ84INTPE2Cd6mqcK8jJB
 og8w==
X-Gm-Message-State: AOJu0Yy8iA+RSV5ImU7h3qa/2XgJ0etS1gv0MYlrXAnBCcZFh/jCPw9y
 Kmh1IZBfAqztdlbmwr3JjFqkdNh8wWPQlkb9Y7va+q8u2hT6kZKNWaulbnG67nGTifpDDc+Q8LG
 8W7on
X-Gm-Gg: AZuq6aJHZToIzxMSI9RKhjVl1BOt4cqTSFbniysKy9mYRA4is1Q+sa65z9eRNQH9FT7
 laftTIN+xsLRJsEZmR8TGGi8M0CEA46qyQsk1M7xOzgNDRHlgzT6kpm2C3ViBCHAaDISlQoy0dn
 GPjGtUpe/90WRwmOnlRXAume9rXvZcgA6gE8rgSNAb6J0F56XIMGzmnx5YzvTuf8wqtwX6KCFo3
 hsfPYDvYz8VaM4Www86/U/TCwbYMnqsBdFddgB/Qle2qNimrAOZagl8A/wINvSeo8m0bMGp/h9O
 UAFg2SZf0ETH6Px7PtGjj04irpbYTjs0M79v6GALBk5WYx51NaUNVhOS0APn4WOroecNUUQCx/H
 92yvsp2yNid00oL/WR1dZAQ9DtXvhUd/fGj2MOZiJ1mf02vAL87u9DKafTOEh1mReNSBO/dirBa
 hrdd4N8qmgelt/hDtqXEI+GY6vZks0envvyM9NAiEyAOqET7kZe4cjsdc/T8wyNITA4TEAUXnhc
 6s=
X-Received: by 2002:a17:903:28d:b0:298:efa:511f with SMTP id
 d9443c01a7336-2a7176c5c7amr106722525ad.39.1768809466873; 
 Sun, 18 Jan 2026 23:57:46 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941d636sm79213985ad.96.2026.01.18.23.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 23:57:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, philmd@linaro.org,
 richard.henderson@linaro.org, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32
 bits
Date: Sun, 18 Jan 2026 23:57:38 -0800
Message-ID: <20260119075738.712207-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Commit 369c1ba2b changed the wrong conditional "#if defined(__i386__)" to
"#if defined(TARGET_I386)".
However, TARGET_I386 is defined for target x86_64 also.

This commit fixes it by identifying correctly 32 bits target.

Found with:
$ ./build/qemu-x86_64 \
  -plugin ./build/contrib/plugins/libstoptrigger,icount=1000000 \
  -plugin ./build/tests/tcg/plugins/libinsn \
  -d plugin \
  ./build/qemu-system-x86_64 --version
ld-elf.so.1: /lib/libz.so.6: invalid file format
cpu 0 insns: 59746
total insns: 59746

Fixes: 369c1ba2b ("Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 bsd-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index c49be32bdc0..cc4b484f3ab 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
-#if defined(TARGET_I386)
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
 #define TARGET_HAS_STAT_TIME_T_EXT       1
 #endif
 
-- 
2.47.3


