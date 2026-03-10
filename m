Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04429EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubt-0008Uo-0P; Tue, 10 Mar 2026 06:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubg-0007un-Sa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzube-0005ua-RW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so37553555e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139589; x=1773744389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N0u4Xn5z3Q9+ztJfTR2RmRtVJ7Y4IO/aDtYCPfhbr28=;
 b=QsYr3BI8z+LueMRr4YDhScLoshufKwMsx0CiMYaDvc4Zzsyb1J2Ovf/vgJenGK251u
 RPlbH97/B7Z/LY971k8S4/WkwMgRP36gKGYyS+fq7dfKeGhm3BCO1UmtPCrI26pW5iAA
 J24w6SC1JVxVz6L5BtdsKoJgOfQL6d5kB//FO9PBEUWTgyv12gUSw7mpePJp+YK6f0Gh
 8VTShMVTBenmyFwLeQ2hwD/jBMpSo60iH5/o53hrQrLlt1D0850E8JlGKqxGXDFgvtBF
 GOzeQtzyqs5VAix5O2eYr1JHCUwtQpqIkCy3mE0qYtXHS+5CYbtjR5/rSGTjszHBK9uK
 9/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139589; x=1773744389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N0u4Xn5z3Q9+ztJfTR2RmRtVJ7Y4IO/aDtYCPfhbr28=;
 b=gfIXyNYEWxKj+lXZyrfoNbXgCxDsb5RNhZuUc1L7ZIib2dKoqrmhjxOsXMX8GjYRP0
 xNvAFzAHpc2TjmZTJbWo5cqcbrAy6H1ulXVgglMwT/x/Gt5dAGb4ODbkoUydrTfT7M+a
 53FHz+13t+j4FXRqD1WqD9s0G9vN71pDJIU0vEOgjsFp3KLi7DTASzHO6WMNznh6pb0O
 AUp94w4J7OS5rQnj93dI7XN5k/lj60bSInqx/23HTXlAaG/Y15vbS0b94plKpwFtTKJ6
 +fvPY10f4DZLn/h9rZw7IQL4me/B8vj+6bnbO3E05QQZuy+MjxS/xIuFnTEWq3W2pyGI
 MnZg==
X-Gm-Message-State: AOJu0YyAbc1vGDmTxCekiFRWSgzR4gWBbZvIuTeUIj4fF7DbM8SRuyJy
 HkvQT4RE1lIUkVP75oO+2nVmv+6ZD7kRTwA3cM2GQw2lFtW+yUHPcMgy/lT9bbwEinbPVOF+BdY
 EqF7DaHg=
X-Gm-Gg: ATEYQzw6O+DYsBotKYZNS+pZ67y3hXx7qN9Y/V4QLVc8KNRBttx/e17Ju5e4fO1L06H
 pR/0TuADOxDFVEQ5Dn53lv/hI8FyANTEbou3oM9dNEiygxu4ZU9itvR1TDFdeFZgHs/GGDsQ8bf
 Fr66KcbMMuyN4lam8RLKYZEKYLl2EejMQ516EtgoengIP42a0PU1V88mP1aAwtb0qWQcldZAC6R
 DsGPAQVUAlU4uSrWW02lKfZ72ZcUsRw2t2DvbPsRwSzYx6mMivtUIeYxs09JaYMM3R5GfwbP60h
 6ShjpIWBzrHnl/fVHyRg3kiWWoKzg5AnSYfG3m5kXdNWyfpxRq7FXycGae93OnjMz8Syq7POS3W
 pCqQE95hf7btg/RQzrylk4fZWDGFO/GrlXrRGg9lNiQ75FvJF1Hl+ffWBGI7DGvEeE2vmnJ+bPO
 UNvEKTAwjmn95qJPFyfaccwaySUsECL8MLkmgUmnIJ4KWCJuVdsg5cuZy741YJCc/iMmPSXpvJr
 LxttjieClI=
X-Received: by 2002:a05:600c:4e4f:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-4853f4214fcmr81891135e9.0.1773139589026; 
 Tue, 10 Mar 2026 03:46:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dd017sm115605395e9.2.2026.03.10.03.46.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] accel/stubs: Build stubs once
Date: Tue, 10 Mar 2026 11:45:06 +0100
Message-ID: <20260310104511.12670-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225044225.64059-1-philmd@linaro.org>
---
 accel/stubs/meson.build | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 5de4a279ff9..ccad583e647 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,11 +1,10 @@
-system_stubs_ss = ss.source_set()
-system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_NITRO', if_false: files('nitro-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_MSHV', if_false: files('mshv-stub.c'))
-
-specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
+stub_ss.add(files(
+  'hvf-stub.c',
+  'kvm-stub.c',
+  'nitro-stub.c',
+  'mshv-stub.c',
+  'nvmm-stub.c',
+  'tcg-stub.c',
+  'whpx-stub.c',
+  'xen-stub.c',
+))
-- 
2.53.0


