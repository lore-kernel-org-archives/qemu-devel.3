Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvMu-0006J5-3o; Fri, 01 Aug 2025 15:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtjv-00073k-W2
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:40:20 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtjs-0005lx-Un
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:40:19 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31ee880f7d2so2482093a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070015; x=1754674815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bO5ExTpEhSZOxWRSLEY4QbbnlYxukZDB01i45ppfzLM=;
 b=ojmpmSw0LAxpJT8V8cW8a07MY8E9Vj8LIc5ZreOPYqlXIjLbTp1FrdVLPwIY47QH5H
 7AXdj51I/TJQJp1IOiHA3PtmJu/37QTWojn9jOiAZEdM9D6sPpOeHOO2Vm9EM+hm3rP3
 i0lyVQ0V/WmoCD7AfOSg+Yuw9XY2ABKVPs1EcmRgZ9SyH++sc9IBR3D8OQJXxPanyTdB
 XPJkvE3I6c60PIEDPLFoJ02g+Ve7ZPrNdKANDLooXUDenUktcdzaAa32j6dK8JvYURrC
 SCngcNyc4YvmRWzi8XFaVjEUqb4QtmKJsWkpBl/qNQH0a2NY9lc1a17arup7YOu0iLX/
 arBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070015; x=1754674815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bO5ExTpEhSZOxWRSLEY4QbbnlYxukZDB01i45ppfzLM=;
 b=ByCj5/p9qSscyQjFiwfx8skGY/iHmfdwGzVQiMiEboCgUp/XODQ1ajzIC/pz3UcCbM
 UIRaxBAkdBoQUPLdsokBURNY+msLXgv+0l+JI5mF1HL9XUVuFSDR+jL6fcg5ipOMX4nR
 1h/NhOtYfhuS82bEjsRWtFntoSawOr7YE32PVO9e6KM5+eqdteAki+GdZ2aywwLpy0sF
 igljQT3BlzuYPAA+CaPJL/WeKXAJJKx8RM+zFo09qnIbTQEwBPBrkZnhwDOyLYTYCh04
 Wj5eUPQHFSVdLCiTeef/v7E8Dr5hMVJppYi8E/q36bRc0UbdoYcOM+bgYtFmD4R+KOxT
 8UKg==
X-Gm-Message-State: AOJu0YxdO4UN6WW+GIZoPVG9p/FihiU6/n5Zmh0ZiaNGIxsSlv1s0qqo
 ML5M0ScXHg1z2WyRhm5TaZcJFZ6/zueu6nvTNCD+P4GDjSeGju8Y0mwaoE6E/ChxgXKWa+CujdP
 4fyWtOFg=
X-Gm-Gg: ASbGncupeoFVtAmuWx7u5Oqzb/LwJElIEaNSTnHNEeYjBXPnI+yb0R3wSvBlHk0I5mK
 Kw6RWMgwas9LGNVvfVylp9IvbAeixsOAN8fwxMHGg+chPUiTHFqyadIPajkXHczH1MJUEBtlBFn
 5e3QbRHQDzFXlXT0oHnmvMvLhKNkWPOtxLm9jbFCPAzrskC8FF7UY5vVZO0e073WC+Y7ZUY3v4K
 PMX+b++CcsYejeWMp0IJFNv94WR9F+IHHGibSErjsTtqeDKcAb5Z9IDTX/IRAvPNNrs/SALs1ke
 bXX+wR4yR1UfEjpUEviHKxfFQRNrD2gOzEaSxCsPeREA/XVIrW8xxbxrf1yXFNbvYPb3L4zccMa
 gg0KdG3fYvC3aKTuJVmYpRQ==
X-Google-Smtp-Source: AGHT+IF2yx4ht9Zp907EoFeU/IVyZ58Oid51x1Hiq1N6zN3kP652BIEQv2O1TZzc7ptcK8fHWsIdZQ==
X-Received: by 2002:a17:90a:e7d2:b0:31f:485f:fab6 with SMTP id
 98e67ed59e1d1-321161ec318mr846231a91.4.1754070015065; 
 Fri, 01 Aug 2025 10:40:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da6141sm7972925a91.1.2025.08.01.10.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 10:40:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] hw/meson: enter target hw first
Date: Fri,  1 Aug 2025 10:40:05 -0700
Message-ID: <20250801174006.2466508-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

We can reuse target source sets for "generic" devices that are related
to a single architecture (like interrupt controllers).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/meson.build | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/meson.build b/hw/meson.build
index 791ce21ab42..1022bdb8069 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,26 @@
+# Enter target code first to reuse variables associated
+subdir('alpha')
+subdir('arm')
+subdir('avr')
+subdir('hppa')
+subdir('xenpv') # i386 uses it
+subdir('i386')
+subdir('loongarch')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips')
+subdir('openrisc')
+subdir('ppc')
+subdir('remote')
+subdir('riscv')
+subdir('rx')
+subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('sparc64')
+subdir('tricore')
+subdir('xtensa')
+
 subdir('9pfs')
 subdir('acpi')
 subdir('adc')
@@ -44,26 +67,4 @@ subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
 subdir('xen')
-subdir('xenpv')
 subdir('fsi')
-
-subdir('alpha')
-subdir('arm')
-subdir('avr')
-subdir('hppa')
-subdir('i386')
-subdir('loongarch')
-subdir('m68k')
-subdir('microblaze')
-subdir('mips')
-subdir('openrisc')
-subdir('ppc')
-subdir('remote')
-subdir('riscv')
-subdir('rx')
-subdir('s390x')
-subdir('sh4')
-subdir('sparc')
-subdir('sparc64')
-subdir('tricore')
-subdir('xtensa')
-- 
2.47.2


