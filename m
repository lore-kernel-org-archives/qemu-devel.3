Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F03FC6179
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 12:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc12d-0001OY-Bl; Sat, 03 Jan 2026 07:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc12b-0001Mo-3K
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:47:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc12Z-0000EZ-87
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:47:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47755de027eso76034165e9.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767444449; x=1768049249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KkhszMvsC+ROVSe4HVIy9ZjAjLe2Ez/m4fpkirhm3WI=;
 b=PyAIH6W8LMMmzpk/SU0H+MU1Xxi1dLiJs/yG+mR1vvYp39eeQkf7LtxHXen4hljWgr
 McEXMjn18dHlJ5oTDlixfJ2CkR64E61wpjpswfEOPMegKXcKDAXmmhkQSlQPyQAb8Q0S
 zMki+ISEQe+X+0GopHqDBVzcj6axpUx182c4vd9SOR2hSEt1cTW6bl/Xev4WGm6KsfpZ
 gwLWjGTjaiEatJPcl2hmJz5BP6Wxhb8ciX5NVlHUrUgX3lbxmYXkbJ3jxMZ3/TY0huCJ
 frfOroPbnxJ9SrmChZWAIyfVrp2+TRA7Mz0R+ediRZob9eDtGVUcDZHJGoE7tjM8969g
 lRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767444449; x=1768049249;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KkhszMvsC+ROVSe4HVIy9ZjAjLe2Ez/m4fpkirhm3WI=;
 b=ZWfdDyVVIovifpDaq37IzL4+1CozeXNNI21drc7lAaD7C4Ev7WKfp4T3Xp/82Re/EL
 rVlYPEPzOSYqjicbvTNA9QYDQGp9VK61afdlYdewEIvH0OU+sDkmgVbvwT8rGK/d0vRf
 yeDRZrBSVbU2FZ+pARNxCIUrA9GzkYh9PEqhKi2Szjs3kem9inHqcvNKh13Xhw5rNSnY
 ZkR01F65xhAmU9nY3Dszs3LMS6QczkcN018IfvBbjhusA7FAARyuQi6O4wAeLcO52bI1
 7MQfpgvt59RlyifjEhncWALprZ9pBHrboIVVkTqrsPo90I87OHctr9socto8kuoX5ABA
 SRQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK1Nm9ACvhyoz41Mu5GAPXrmC77p9RTEqAAmez4neJtLdqC/iY1ss2nsR4CfTDUI6i9x70IPY4q4vK@nongnu.org
X-Gm-Message-State: AOJu0YxBULZ2Zq+0s2sZr8gqABptWKXaT7nvxlSeUDQZrxm3VDPlUPzw
 eJiTq3LHeD4vw2XlewKMH/BjY5RzgsZ0oo6DmxJymgQ1adossdDNpx3UuHwnyhPpiWk=
X-Gm-Gg: AY/fxX6l3TKukMY+HNyF357onIAW04GAc0ByMq0I3SLXEotEAfmG2apCTe1O4NOba9s
 6yByE60eBPB+NeCA2GFhKyPTaUiAJlTKYdicnwBAjRHXHDn2cPqodLJg63Henx+3RaeSl3JmQ1a
 WOnBfNGv98vX0SbT2XfxJSTVTnTTDp/ZzP4w1Zcx1wz38FGAih3zRv/PPCOtSIV742YSkkOAz9n
 we3ZoDu5LUHucqgBlXPuavNG1Jkpml/7ZITFyG9NmxAfgZv+4LmhPfMaolLT7KuQJvclkg3oMT0
 yi+P4DTz7Tu4Yvu3NhqaWw5TZ1N7qLWlIQW38ap5jxLs+8JqWQOyxGmurSCPmlhKz4uT/e9N/XJ
 5IFmtSDmvhcZ3uv8yAyaio6IvCs2iHq+PZY6NOZ1JOwILTZpPSim8xyMkWjKZDsTYJEEZJq+PZV
 GSZxjfZo6S3PpsdqBoSVrrYdcfInH1frSMIh2oBJcpuQFAJd0WfkGL+9MpTKgfvmot4Gtu5A==
X-Google-Smtp-Source: AGHT+IGaj8gAFaPl5gwCQKyHkOHUgxTsHDeW1ze0i/uXtLwcCs3YhMujbd7zlB5oZAiSm8Gs0n7fbQ==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr618630535e9.4.1767444448783; 
 Sat, 03 Jan 2026 04:47:28 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d145162sm37133425e9.4.2026.01.03.04.47.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 04:47:28 -0800 (PST)
Date: Sat, 03 Jan 2026 14:46:12 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 01/11] plugins: move win32_linker.c file to plugins
 directory
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-2-pierrick.bouvier@linaro.org>
Message-ID: <t8agv2.1l55lm3cc6442@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> {contrib/plugins => plugins}/win32_linker.c | 0
> contrib/plugins/meson.build                 | 2 +-
> tests/tcg/plugins/meson.build               | 2 +-
> 3 files changed, 2 insertions(+), 2 deletions(-)
> rename {contrib/plugins => plugins}/win32_linker.c (100%)
>
>diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
>similarity index 100%
>rename from contrib/plugins/win32_linker.c
>rename to plugins/win32_linker.c
>diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>index eb944b5159a..6f72b2ce0c9 100644
>--- a/contrib/plugins/meson.build
>+++ b/contrib/plugins/meson.build
>@@ -10,7 +10,7 @@ t = []
> if get_option('plugins')
>   foreach i : contrib_plugins
>     if host_os == 'windows'
>-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
>+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
>                         include_directories: '../../include/qemu',
>                         link_depends: [win32_qemu_plugin_api_lib],
>                         link_args: win32_qemu_plugin_api_link_flags,
>diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
>index 561584159eb..a6e78438510 100644
>--- a/tests/tcg/plugins/meson.build
>+++ b/tests/tcg/plugins/meson.build
>@@ -2,7 +2,7 @@ t = []
> if get_option('plugins')
>   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>     if host_os == 'windows'
>-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
>+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
>                         include_directories: '../../../include/qemu',
>                         link_depends: [win32_qemu_plugin_api_lib],
>                         link_args: win32_qemu_plugin_api_link_flags,
>-- 
>2.47.3
>

