Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E1DF46C66
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oel-0007TM-JI; Mon, 06 Apr 2026 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oee-0007Og-Fj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:34 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeb-0002OJ-RG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c76af7b0f94so2719270a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499988; x=1776104788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=s60y2N/H6jG6VHNtPxQmuEc0yUdUVoC6NdXi5NFw0cmW5TD2G3Jf0yb9uQSmU9tWIC
 G74FhlRuZRziJ6TAJVhmLJopv1Zk1yK1VvIQqoLoQcPV4DwrnLy2KO537JCyscu8WLxO
 nL5/Am7c1VE2eey32lH8eUOdEqr8NBP1pS0gs2jWoD1QrAQghhTzLAG5epdZCgPbCTP+
 DAa5RrT1QQVtxN3y85mDBRzr9LJ6xZILteXkKQVIJ0EeQXEQTDY5Z6rlw/e9gyEajlfY
 c+uLgyCxDt5PD9Fb9fPihID55yQ5JhWjFfMNTSVCOZ/NIget+GmetsasgT69dF9feH1/
 KJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499988; x=1776104788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=NBY78VqKaJ1ZXpgKei0D06BEOHBcLdxsTSVf/DUeY7GVTsV5Vs3Ozf7/IryG1idMit
 JoC07b3Y2lL8r8gQyrnC4RWettBNBroFfTfCWf6gqJelhlZnDH9GAFSvRoOf22VuTyf0
 RkWhTXAdm2q/v84oYNB3f43zXsbp9Ift9D+OEPdWrcSZRIIjh+ELPazJmypCPL/C94fq
 xFhZTsNyLLFc7p7ugxHsX0VfZI1tS4p3kEC/EduSZ0oCwiLqArfCLp71f9F1U6nkEDPz
 E+vGycM8U23VeABtqdMxTZ09adkh+BPkl7CAn2Bigr1sagm6Iy9npziY4QT1VrvkW1ku
 c9bg==
X-Gm-Message-State: AOJu0YwwZOv86MpOQagvRqia67R/XjjLu+MTY67qtOL1D0fTv9m0+1x+
 t3T9vmoNOS35spSpLXKkj35V+Ah6FLiTiEV5ENeOe7MBGXRq6jPDk2RSrKvwDsbMocYbs9BztvD
 Ls5mgEBUBWg==
X-Gm-Gg: AeBDievGHjIGeK+MMiYZYqtSDS4Yk+Br0wYfnkNjHj550bGKlCoacT8Rr9TfmGuWl4s
 9YLKJgmGpTmUqkrrFVnQqjCoeNmTMXf5Pgvpq/OfJ0OEAoMJGngKwv1xiJAErz5ATakCPOQkiug
 iSvMSTDaXg2q0KAOYAJ8rgEtWyzihTFGooFa80HA/B+hcYprbLPhObG8bB+IiBglmxx0Mu/COT/
 LGautHFonxDQUNUdCs96txkjZGmhYDDiP9QR6u8+wYP98hSTvtwIm4G394SEmBIsq91rMnvr9AK
 WiQPd4K2jOhRrBqs3cNSOYMQQgNfPpD0uHbvOVoTnwhzj2C0Uj5vKIlqh/0594HXXO/tmO5ZNMD
 s8WGb+kayVZ+Ja+Zi5p7feyuaxF731pJ/FyDuWr8YQi7laFy7cJHElsHTGkHIXX/R18bs8OGWKj
 MZJ+a89pJOSJsoQZfJAbhnUE8VYZOsmOyI3JHMlob6vvSp2zI5oXXY7ggDJHXT88KMZSv2pYdrx
 F1xcXHgQ1DuBRA=
X-Received: by 2002:a05:6a20:9145:b0:398:71e4:6287 with SMTP id
 adf61e73a8af0-39f2ed950d3mr13989522637.10.1775499988369; 
 Mon, 06 Apr 2026 11:26:28 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 10/20] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 11:25:59 -0700
Message-ID: <20260406182609.193886-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa26670587..0740de92c1a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


