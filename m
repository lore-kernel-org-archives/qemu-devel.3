Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05AEFD874C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2T8T-0008KL-MP; Tue, 17 Mar 2026 08:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2T7x-0008CD-Da
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2T7r-0001Px-Sw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so3649745e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748937; x=1774353737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eEMVLLP1U//JG1yL/MKQCMAGHc16tRv91hnW1ImxWr0=;
 b=Y417AQF5ASIKFM6g/29AqwazuZC0gnar+Jg+Wn+7qkphadUxpfNmdKlRNUY82phjVW
 NPHpMtUNIdjR1D3pEDxxHq//ASTTWtqd0BnOPrQGBZhXozGp8MxPmwL+wOdbuC2QmKcT
 RkCaKCo242SRJ/6M3cKzJaloKvjilYEtIGqThy/C/AFlpe0F+NMl2uUDe1leLWHSd7PG
 mZU8xPXKoYi9oYm/sPK1+3szeu7tbCUYlH81EMwdupnu8tKPB2HE/L5EyugvBFTneVU1
 gtmL613RkkHzIndvoDuCvvwtKXbm+5eOkCZINe9jhuBTSu8Q/BZafCU9oJZ3XyHh6Gid
 G7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748937; x=1774353737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEMVLLP1U//JG1yL/MKQCMAGHc16tRv91hnW1ImxWr0=;
 b=PVCche13n096rYBa4ROmbo3MYYqqfQ2i1kxLCJRGqwRSYsnug6R62U61xR+I8TdJe7
 5xIq3WcU71tPDqZOc9HTpF27MFoxSJRE1B7SJUkl5fm5MJylJZlAJdFL5n4rgsmeYWSY
 PXYlhFcTegSUptGS9rsj+U57EXQ7C8KqGs9ebg2BybmR53jJAMtvSQOZ1c7i+dbxwmUG
 dd1FahV7nf3yT9PDctStJ98LjEjdXbK/aeMj/gXC3kSMrHer50CSvmqdozteb2gY7BQa
 s2SIcPD9dn98BcS6QFJ2qEi0pslWOxB8PTFcVh7mWPWvZxwp45HIxx9mQt/dqYJi4Qm5
 6fdg==
X-Gm-Message-State: AOJu0Yxmt9av36OdMTOkc+ep/sHVvcbzI+H1DGC0m5chREHbdR17Lauc
 is3dbIiOpyCsIBWo1FnoGXJbO3UVv1rTy612Z1ssopIl3zQ1JRFQXYkAMDX5b3HcYKWvFHvhq3c
 KZ4U4
X-Gm-Gg: ATEYQzytobyFczJ6HzsXft0XlPvGYfgB17wGz0ts/K9tPn2SJpQjDpLrFsVtc2S/bjT
 p2FiyJxZcR81ORJenxW5bKMTXXKyAz5Zb7J7f2rbTA0hSc0ylREFXtcAcgUp535w/7pniFs8ePu
 U6eZ0xehuZcXFp9Ipo0KmRAozvS+2vTXgOV9gFEDUa582cntTy3mWr4reuLKbA7u2vzL2qDdvT3
 bKdmoT/xDfd4S909DPMkYAS6Qki39vn+qT+yanNix5eXGWXjkIVELHatUBMkr2AfwUJBslL7gTG
 ZkjhzSVBT5gv4kWshY6uH2oqsVnQM8bkORvApvgAiMwldLzPcZPH1VSL8tiye4SkPB5UfE/BdL+
 I1htGLfOG2v/0JSXbjNS2ddf2xEk4c878oaotMigGKqCchMnhkX4evj4c+5bCz7y7gr9cyIu7bG
 vMF+VoXijuEwfugy+zzXlD9HNTYYgxQYd4J/sUaTB55QTo+bECdKn1cuugEp5w8UuNpNI6BvmGU
 8isDlAZkIMKcpqP8ZtS4TjqkIQtUG0=
X-Received: by 2002:a05:600c:4592:b0:485:3dfc:57a with SMTP id
 5b1f17b1804b1-4855671044fmr284103325e9.32.1773748936871; 
 Tue, 17 Mar 2026 05:02:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3037sm63596795e9.11.2026.03.17.05.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:02:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] configure: Remove unused variable default_cflags
Date: Tue, 17 Mar 2026 12:02:15 +0000
Message-ID: <20260317120215.2075164-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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


