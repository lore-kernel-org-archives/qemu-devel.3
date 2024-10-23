Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5425D2E01E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Vxn-0000dg-Hv; Wed, 23 Oct 2024 03:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3Vxl-0000dQ-RC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:39:25 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3Vxk-0008Go-BV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:39:25 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5e5a0519d00so2898660eaf.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729669163; x=1730273963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MYNp47PXrBodBqptWa1AA6ppu7TdaThxK1XLbilfYis=;
 b=zqZ82IfyZKndsLaa4DMWVGInyQk3dyXE9KDc50XIUB+qteV/gz22PEcmlO0b80KMfY
 xoPAWVlLWrzL6GHVC8tqtMIuYamDKrAaBLSwOlFziH4XfhfgDQWTwC7qd1SRTUV6veq5
 JUNVdRfrVAQ6vqmXd/caw9fV6LUHloJr+qLVD2Bo/QoZWYeigcbLUHXekbmhBRc7/8Q6
 RB/FAJXh/OCUtCdEIXOOghu544siiZV4FogmAX4UDwARD91DFkzpSzUnZ7sLHw5g012r
 +iCm9sSg0drBQpigZO3gxR3lX1yzCc2dH8CHh+B1UoXygSs1aJJyF15LWC2lHZDjjuzA
 E3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729669163; x=1730273963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MYNp47PXrBodBqptWa1AA6ppu7TdaThxK1XLbilfYis=;
 b=d1VrsFcitT9aXlCBCtyfJDpspIuth7P7fneo6RywvnAAJb6NTlwU23YPDYxPz1xkTX
 bc85RP5/91EF0YIZvepGP2ljgu1eTZG58uKVu02TnP4+4In+xfIMxmKVt33N+EV/yIND
 71fYy2+5cN87+/+4n9bjZAe5nevIEJLwcOJr/6uUgbgJ0hpnaMUvScllaZfg13td6M4y
 Idiht8uYs1mbhf53FLL+JyobABsvl05166g+muqi7fAdnHcWBTcrtjV46N6viYK7Gz6g
 zH1eRZyVPOSPYkQpKKmF1H3cMmjVKMPFwSstcfflrCzQT/RYrdXjVWFBblWfT1qvx6BC
 gCEg==
X-Gm-Message-State: AOJu0YyHBifd5S/6K79z2lg0cJq0IxiXkaIHVa6x4gS8WlQuAhJHvBqE
 v2DXx83Nhj0R22VBtug6FLRKh4qCcw7pOwyXH/14SSr5mUYA6mFGsTMaK+sxmh3lcFLOPWTqAoU
 3cSryyw==
X-Google-Smtp-Source: AGHT+IEcoUzhx/Y/RLMI/grLfq2HQXRLp2vephQv8nDF3XtlE/KvDgtXFxFxIEr3stAHSXv1LoL66Q==
X-Received: by 2002:a05:6870:d888:b0:288:716b:142c with SMTP id
 586e51a60fabf-28ccb7cdfc5mr1954758fac.18.1729669162659; 
 Wed, 23 Oct 2024 00:39:22 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13ea224sm5737564b3a.160.2024.10.23.00.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 00:39:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] scripts: remove erroneous file that breaks git clone on
 Windows
Date: Wed, 23 Oct 2024 00:39:14 -0700
Message-Id: <20241023073914.895438-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc2b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This file was created by mistake in recent ed7667188 (9p: remove
'proxy' filesystem backend driver).

When cloning the repository using native git for windows, we see this:
Error: error: invalid path 'scripts/meson-buildoptions.'
Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
---
 scripts/meson-buildoptions. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.

diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
deleted file mode 100644
index e69de29bb2d..00000000000
-- 
2.39.5


