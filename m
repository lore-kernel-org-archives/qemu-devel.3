Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2D5D46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtK-0000De-Tc; Wed, 28 Jan 2026 20:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGtA-0008V9-KD
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:05 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt7-0003AZ-D4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:03 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3530f597ea3so158544a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650320; x=1770255120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE7UdsopvEMPmtvJtt13JOTPWrtqnTLsVWWFeGGWs60=;
 b=dUGiXkdv0BXkQIIUBbPuRhKpK9yWFWv+uu2XqWmfsjCqhfY1x5cuVnIrA4p+3a8RDW
 4Yv7ZSuiv6aHisLApsx8yunlnqYTOWX3fiorx7HFMdbg28t7jqVXZkRv1cJw3MeK39Es
 N8wjImBPNNN9ZqiURWdJxTxhthox6ZPozq83TlKYG0GpALOFRhlHmKoXgplqmdS0CaC8
 OzEx6l1IMOYFfN9GD7sY5EPtGzFjCVD0DX3OJ+TgVq0fmdaQ9s9lX+qr+rFacpiJHGQ1
 hEART/BYoqPu+XS2jjUIwhvoDuNyi0+T8PHWBhvibgL6VETEXODH1TMgnpAcfD5NipzK
 WLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650320; x=1770255120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dE7UdsopvEMPmtvJtt13JOTPWrtqnTLsVWWFeGGWs60=;
 b=iDwPD+edcTuFNW+3kN0zjhnvlnhgv7V4CMY56SAgo+OFytSlnNHBzBPJNVmwsVd5WQ
 4FUgBhcG2cd9nCNPTivJMywEc5DYDe2jLqQpwrZH2eFDQy6LaTZo+7dRxQdE+oG115Ze
 py0Ci7MxeWkcrFAqSl9ClvnxMDMxKQkbNaiBZqclLCCmavbeQmfLclDIEC0/VGn9iLbt
 ByiKB9A3Nw4ovn8Ih/1p04PexgQpxMTzjuUItdovPHfpJ3dmSTL8OGptOLQBDTlLPVGr
 m0lOQWxzM9DyAWhR/quxEtRDrmAbRz+KGQoQ52JdU/15J7CMBoReAFZ0E+VCv/bZHPGH
 zbOQ==
X-Gm-Message-State: AOJu0YxnWFX+OhEV/kZDSFNBKzoa05yVP4kZ5msaByJG+oDuH+vgfBH5
 27k+NI7E2Y8IZICnSDTMa46qtDLQJG60Kr8pKMwhtVSGMkEv+rKgL4EbSjZMVALLSno6tZTLJjK
 3mcmb
X-Gm-Gg: AZuq6aLg5CAS2o7K/uQ5oNW7QM97toy6Iaw7B67kgDGG5E/PUYXrWF3Bhg5HSgC5d9P
 9XDiMoo/AxfOU4t5zcYeE9tzO9SMMKtoQeR6V0liCOwdpvgyMyUTonNb/LNGOKyMlSlXC5jk4IQ
 9mxWmneIPuojuXAh44u45zGRCLPNuw8M7X0aurMNFzTUMUVnD9A1vwWmYPA07MBGkzVm4cIlxrt
 eS2hkPvQaP3dhxgUPD31Xir6GUipcez568hnUOghyORi+3P6nZPomWiGkRz08g7QHZentbxxxFo
 CNKpGaWSDE+RoFX0zmdNAXIskZTiM1UTcimC9CwmZHm6URBhr3VKO7cZyKmTDPv/UoqB4K381GC
 j1E6l6pkAm23stgd+6r3XNuVMNUXtWoIu0jEB7Dq6YIJ2kUDMRYq1kFWCofYZjpdpqHzLK8Zi4q
 +GHgFnncHfC/TE2MFR1Ohcs1gKoTOb/3ae5T8FI6aof2h+e0HSm+QXs+NP5R7QkoDf
X-Received: by 2002:a17:90b:5627:b0:34f:63b7:a1f5 with SMTP id
 98e67ed59e1d1-353fed6e348mr5681954a91.21.1769650319991; 
 Wed, 28 Jan 2026 17:31:59 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 18/20] meson: update C++ standard to C++23
Date: Wed, 28 Jan 2026 17:31:32 -0800
Message-ID: <20260129013134.3956938-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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
index aa35b8273c9..395f4d56193 100644
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


