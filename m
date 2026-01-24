Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB4D715E3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOE-0004Pb-T6; Sat, 24 Jan 2026 13:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOD-0004P1-Ct
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:41 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOB-0003jG-V9
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:41 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso1284611b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279378; x=1769884178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Mi8rY7gk+YscQ4AFNAkDrZMLR9/cyUEzUPrzIbWCiw=;
 b=NyY0RyoGBf/RFTxzMmEgXOw6IaIXBMRxKM0ucfwGtGiycawXSpYez5LQ/4FWVXoCkQ
 jdVMrpbFvH2RBZpwTIxAF/UZMk79ps2U20tvZ8CgcnQzwT2EPR/bJkijy6v/LrVR3fmT
 nf1qZwNOhH+sxHwRgAvwrF5hA/GALNfFZzwdxlqhCXvArtZ99ymn66d8Y1tEsIBt1CdW
 NQnPotZ0gw1UBSjhe06tdOEP3RMeNoU2iCPWuzz3tTXkcBd2WqUUlUtWxYhtvbI60QNF
 Qe1fjSxHOkuSe2CZ7MaTu/Y6V6VRooQfnTMkdgE37bTg3E6kRitkNd0TN/VsTRBOP4cD
 MvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279378; x=1769884178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Mi8rY7gk+YscQ4AFNAkDrZMLR9/cyUEzUPrzIbWCiw=;
 b=xNG2otAUgAPlS2XWl/xPCeR/RKdQiOjnMxwVO5El1g3iSBD4sl5RM5WZdGnc/vh6hP
 PUjDW7QVW/Y8L7t3Grf/SXRlPsN0fihLsmdZIk8MxIqInD/5+IGmdFgR7AwUSfZxhDmS
 z168KQKciQHXzh2IROTKxZcT8mND+WejIHQueGCa44w+wGQnmu8pJZlD5wXWFxo4iczL
 Ap4Sj2SW0AInXR7vRiSI2gOxoXMMky7EMfp8KqA7ci4KGcTqbt46QxoGHr4LNL9aQ/bk
 32zyJc+/HQWL2Q93Nfh420Wv8ffvoYKUbniYFsm+FTtqRLT0xZH+XnAr8aH6Cp9ISYAg
 giKQ==
X-Gm-Message-State: AOJu0YwAEsh1+VSfeQYuARsVdRlWaUA+ASrf0ZaoAa9QpiTUs/1rqxfq
 YYrkF7SLWneyzMgjdE5yibtPo96xBkMpjEeMAx/xXVFvGL/sbHfmywKF6gHaNT8m95b+c6K0Uey
 Y/7QG6Jk=
X-Gm-Gg: AZuq6aKgYl8aWUpigS6X5Aebj7ne3OLRzktLe79C1DxqTYWCvQsZQavzMrLpf3ijpCW
 ojqnTqInmBgQw7QqzCM9eKFjUAn82GVwTjCQGzzEWDu4noJUP6wtnOtZend2pmz76iO/dIc34eA
 SP5ZhxHofzBXe75EauGNzHnKrGzzGXeiPu1Uw3D48UMcJgiuGincivA30fyI8ORwSDpjvxQJ9Rr
 IAHX+s0k6k7c9/DPallRHGpRM2JWbVxRU6a9/W99lpCOWRhGmpPns5zeqGnzan2rKcDSU8XFYcA
 7sUepzOMOdie8WeM7QwZ8zH2HJaYsVjhmWccFFvdOWN6cbGuIPywY5j0WGT+6jUN5n9Tuoxd5yY
 ruIah+HjoouDdAPj/bkoUDQoN1o27PmnrzMpRDhwZsRPdE2B4xoMBAAV+i38pmofjsMiSYMP79V
 Kt//hTS2g02dZliFzqzheZoad0M6mn+xjs67Sr62mcJw+UccS5eBckNvH/XxDe3qeb
X-Received: by 2002:a05:6a00:2d94:b0:81f:440b:4f61 with SMTP id
 d2e1a72fcca58-82317b5f46bmr6440977b3a.35.1769279378523; 
 Sat, 24 Jan 2026 10:29:38 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 10/11] meson: update C++ standard to C++23
Date: Sat, 24 Jan 2026 10:29:20 -0800
Message-ID: <20260124182921.531562-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

C++ is evolving faster than C, so it's useful to enable new standards,
especially for standard library.
Update to most recent standard available in our build environments.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d50f9b502f3..53ffac02da5 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
-        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
+        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
                           'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
-- 
2.47.3


