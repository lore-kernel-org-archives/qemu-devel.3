Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E376BD2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTI-0000sk-PX; Tue, 27 Jan 2026 06:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTD-0000nG-Mt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wg-R6
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so1151245e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514168; x=1770118968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSnARtBEbX2liwc1Csqs0ObFVRiH7iXd+t4XThmrYOE=;
 b=jbn0Jq96J9se9a93Wt37NVImVhsqxBVs3z/zSAuWqEeKdi1f8NOap3QSJJ2tI8XUFT
 JNjekuLcG4pWqFeMvoEzJTDz0ZeApiO2JapCsIz0lnY62EcaYraw0nvRNqfXIvGhqPZh
 pQkDkvYHYJ8eieHLWF8Hu3W23hb9l2jFLCq6N2Ta/+G1kVGp7LmG9BKooppQ0ZRgEbmT
 gmKa1FuWvysT2ziaR+0dxPgM+LjOIjsotrjbJEXhPyhGXZJlGuddU/wHu2oUjSHB8zPs
 FTfrH344Zr0mXOyC3Mmph7SkK8ZeK0eC7OoNlAcl6R9N7h1Rzc7TkaHiXuwWsiQAiTOl
 1wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514168; x=1770118968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSnARtBEbX2liwc1Csqs0ObFVRiH7iXd+t4XThmrYOE=;
 b=p2ACSFdwGaOCZWB90WbPrtRcVx+8bfU5rZeIeo/gO903Bea7HNjFBrFBl3UGi4ZnF4
 tWPr3cZy/zqAMc3KmT5lZrugKx4TShlDpelrJ4MTZm16BIfBO4yA4yWvSTuYhr1J8KZS
 i8qgs/Vck5j58isIiI+7HmI+myLZBd5en3b2K/nORxijJfD1YoVZogU392MEsPJnzSYS
 xIFqHHDBCftjDSVwd+0NO6tFGBb8WL3E4/JT4VOK/MjtFbCa8YdgQ+PHVEfDbedaOgrc
 re5ixHSt1iP7yBXSYJIH0UGNMQ6mU9lA/RbuF5i2SYPQNMHTzjn1YKbgzEwmxenm95hW
 2OrA==
X-Gm-Message-State: AOJu0YxSmTsK3Z1YjakMHErQYHf8pfOp3L7R9+l//aUN2hUxerMEXkyT
 sTikpYPJqD9m2+Sn/ZsRsGtT/3pqVHuHOq50r9ek4lKFn+ThQWbmZ9toMZ6IyhkvMPM=
X-Gm-Gg: AZuq6aKRoy7cI0Dm62eEAEh0mD5T0g88qhwVlJIWwkZC4ycJcSWmsaBGX4AVseOGluZ
 5W+h5JxR5eMv271hMLBxXBhaTF5/tsU2/lWjAlIjJbuNQGps6A4VIOAnl47BS1t/NhB1rUfizHv
 Ic5NrZxwH+fq/qHlIvt+NCfW+vuMA782GbpmF58HnNd0fKIZYUUvk9CL6cJaWx6LdXO+zk5pXXM
 X5GKwJjvcqACT9LUVt2g1TiG5hO+phFMNLe54gBEE4QGAx+V5QLFxDW+Yt92lp75iW6RPUXofH6
 13KCnnO0XtDfJFwRJVuSB/39Sf3BGsJkz8Vjh8jBoyx7f83BMhkH/bPqqexs3SMEPymQ5tD/STT
 xSzXBhenvZSRFzpb5IZoauS39din2JiAvndrlLj1cyJdJgMO/V8MxcttoNQkS+Xm9NG+rQ6Nd5T
 AvyyKw+wUDufg=
X-Received: by 2002:a05:600c:524c:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-48069c2c45amr21202565e9.7.1769514167579; 
 Tue, 27 Jan 2026 03:42:47 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb58esm57236305e9.8.2026.01.27.03.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 259065F93C;
 Tue, 27 Jan 2026 11:42:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 8/9] MAINTAINERS: be realistic about *-user
Date: Tue, 27 Jan 2026 11:42:38 +0000
Message-ID: <20260127114240.3009791-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Looking at the merges for the last year:

  $ git shortlog --merges --since "last year" *-user/ accel/tcg/user-exec* hw/core/cpu-user.c include/user/ scripts/qemu-binfmt-conf.sh scripts/update-syscalltbl.sh scripts/update-mips-syscall-args.sh tests/functional/arm/test_bflt.py tests/vm/*bsd

  Richard Henderson (4):
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-tcg-20251019' of https://gitlab.com/rth7680/qemu into staging

  Stefan Hajnoczi (12):
        Merge tag 'linux-user-fix-gupnp-pull-request' of https://github.com/hdeller/qemu-hppa into staging
        Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-loongarch-20250424' of https://github.com/gaosong715/qemu into staging
        Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging
        Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging
        Merge tag 'hppa-fpe-fixup-pull-request' of https://github.com/hdeller/qemu-hppa into staging
        Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/stsquad/qemu into staging
        Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
        Merge tag 'accel-20250715' of https://github.com/philmd/qemu into staging

None of the pull requests have come through the maintainers and while
there are a fair number of commits overall they have been mostly bug
fixes, re-factoring clean-ups and the occasional new syscall/ioctl
handling.

We should reflect the current status so users don't have unrealistic
expectations of how quickly things can get reviewed and merged.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-ID: <20260123145750.1200879-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d887a5c19..7d346cda1ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4017,7 +4017,7 @@ Usermode Emulation
 ------------------
 Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
-S: Maintained
+S: Odd Fixes
 F: accel/tcg/user-exec*.c
 F: hw/core/cpu-user.c
 F: include/user/
@@ -4026,7 +4026,7 @@ F: common-user/
 BSD user
 M: Warner Losh <imp@bsdimp.com>
 R: Kyle Evans <kevans@freebsd.org>
-S: Maintained
+S: Odd Fixes
 F: bsd-user/
 F: configs/targets/*-bsd-user.mak
 F: tests/vm/*bsd
@@ -4035,7 +4035,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
-S: Maintained
+S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
-- 
2.47.3


