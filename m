Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96FBEC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvf-0001rD-Os; Mon, 23 Mar 2026 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvd-0001pr-Vk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvb-000648-0T
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so30388305e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263273; x=1774868073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xs/B4YzHpjJ5hjN0zfMVmY19I76iyWMoSRLARmh3iVg=;
 b=NkrTub69bMqGw5LRhIHmar/3tKqCV2GTm9ObFUkLcsKEQaLKJgItecRJkhhjDv+v2E
 gcC+DoMVTwlG58DSgZkTgf46pgQVpUNLVPKUzuKl6RtSYmM//+djbd1qYooa65pqLPQ5
 dGrepk+QNlxDBwYfFYmOkfFExW1+axtvqWp7mqcqHKBrk6QRUo0BmpUgarNulPChamRb
 L6Dqcy4+BFPYUWuPBVV6VdaILaWLeruz9DHA4J8cNTaupUA0PZKEcLpbTsrR1/c2ks1v
 BrmQXx+ubd0M0I9AZo6KBGOWNKdmwCrDoQ5tPtJSaG80GKbWTn+gnAPA5+CPjHMwmy8u
 o/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263273; x=1774868073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xs/B4YzHpjJ5hjN0zfMVmY19I76iyWMoSRLARmh3iVg=;
 b=jsjaVtlSMtGL9PSiOnlmhP2gA9g46b4ACHGlyW+JcPMYT0tEu+qiVae6m2zJLgIqr1
 jt67BhQmn7eqQk9fb2/KTQPWNFXXZT2kvV0ZQWSSYTcRdAMZLhDToKKGPt9ON/XeCe0J
 fXP1nRruqFgMUkgEQr2RShoZIuLT/0rmGWAzk+f+ENI8xwMaWZc7k7kQAgf4FSQ0gNAn
 kX/o0K5gMwNOgBgEouWDhgDwO7kJtMjTc9clYT59fnoSsi70HhXTW/HkI3lBCOQ+13r5
 x9BTuzawVmsfh2fXpjIUcF51rBr62xX3qf2Lm9z2Y6PETZaB3gfZehPkTNicpjz3ayuT
 ItvQ==
X-Gm-Message-State: AOJu0YwsE7BikqIIZ90boZ2hMzu0jmYoVwUTpBZDw2VFdaa7kefYi8iH
 gieJov8TKw5qD+IJ+Eow8BFEv9AM/8SyVRxXWr+fRhCHqTDYKqv56IlA8uyhw/w+o+0hCUYPRad
 6JX4GKOU=
X-Gm-Gg: ATEYQzzvDPxOXXCYAEnSQD5stUyJHMLMwakwFo7SzwuknzI/KzUdcZGOw/PRik2zTFF
 abKDyjKm+phfGUZ5DSySnjyQGixRJ5CLtR0JEpl8Mou/5Ok+YBFWCdyxSUxDKgunOmPqqfVnF63
 L8iqJp8lkZeSwBrjfopHjcVcckqIOhIfiP+Ss+ewTb7lcQEJCu0w4C4P9a8yiQgwF0leCS25uE9
 bfz/k6CYeCaHzjo3FBQsrZE7BlYM03k52a+XC/SZ280yb/WLnnJa5SwNYfFlaRGMyXxHspnGPo2
 MrgJJmvzlLmcQl6VcxrK6DMBe6KZRblnNz1L74B1ZGk3wQby8Vmc66SD2GX/LeWg2Km80fvuRFh
 du/rF0JmzoVqPJIhAbG8BRs7k5lqzgN9g8PmHF3fRKapaJFkvN/6/+DMZPycPEAGloHoJJFctQN
 uhu9nZyT8Wz3MUWJWSguHY9al3Pyc0qdk0AMLP7j0NinwobtlS20RqGvuuygd++TBDos7+07gqn
 pznTwdf8DOFyIdvdjkA4KVSV4VW2Mw=
X-Received: by 2002:a05:600c:c173:b0:485:5981:1411 with SMTP id
 5b1f17b1804b1-486fee1a26bmr148657235e9.23.1774263272773; 
 Mon, 23 Mar 2026 03:54:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] configure: Remove unused variable default_cflags
Date: Mon, 23 Mar 2026 10:54:21 +0000
Message-ID: <20260323105429.4059580-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

configure has a variable default_cflags, which was originally added
in commit bafe78ad3bc4c ("contrib/plugins: use an independent
makefile") as part of it setting up the build environment for
contrib/plugins, which at the time used make.  However, we now build
the plugins with meson, and in commit 55c84a72aba4 ("contrib/plugins:
remove Makefile for contrib/plugins") we dropped the logic from
configure that does that makefile setup, leaving default_cflags
as an unused variable.

shellcheck helpfully reports this:
      default_cflags='-O0 -g'
      ^------------^ SC2034 (warning): default_cflags appears unused. Verify use (or export if used externally).

Remove the unused variable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260317120215.2075164-1-peter.maydell@linaro.org
---
 configure | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configure b/configure
index cd1dadd8bb..42c45fe47a 100755
--- a/configure
+++ b/configure
@@ -248,7 +248,6 @@ for opt do
   esac
 done
 
-default_cflags='-O2 -g'
 git_submodules_action="update"
 docs="auto"
 EXESUF=""
@@ -707,7 +706,6 @@ for opt do
       meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
-      default_cflags='-O0 -g'
   ;;
   --disable-tcg) tcg="disabled"
   ;;
-- 
2.43.0


