Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACD3FC617E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 12:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc13Q-0001ez-7f; Sat, 03 Jan 2026 07:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc13G-0001e2-7q
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:48:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc13E-0000H1-G4
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 07:48:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477632b0621so79618855e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 04:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767444491; x=1768049291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1EQM/1pB8nuIdqmtXCI3tpZdZIjLoF10ZHaTJ9tFD7Q=;
 b=qd2Ba/4riayC8rzPxOVh1a9R55ENdxUWbsnsM4hnOsH+rerMqfa0w8YpgggaZejQUK
 UpckbjIM8uu2lehRgbw2kPI803YVpcH/ezjn3KzR4itgr0kqOQkqtnr1xbGpVSIUAuAe
 g5862EKjMrk6SKfPwUM6q/UhyDyDWT09fr71t3U0fpCoLBprSH9ZVhNTCEwWBBOLU78Z
 ReFmKag+iVxgqyKIi2+B9D/riReM8YPIhj9NoQORM3vXtSU3hTTV7Z6KCe576AaNGTLr
 tAH2E0XpmZLN6mLi6YyVqFZ/hnw2Nru8Olx0rMidsNJuGBqKgYdUszM7BZWzVkXP7DB1
 tx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767444491; x=1768049291;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1EQM/1pB8nuIdqmtXCI3tpZdZIjLoF10ZHaTJ9tFD7Q=;
 b=oew3psls30vRP+Y60JIiMCvKi2bWyBr4M0g7s9iMjdskYAmJ5mxXyv3k+3rFr9ualS
 yUe8aC3Y3wVd/o6jRT+wsj8JhverY/tB30eVJlEKixLPt72hTYS5IegWNdsdnPiR5oca
 xqeUx2F141VerGItCnU9eB/TbFJ4HNhUsq11FLXwJ2oAJvewjC0aYL70AzjQ9eq1J8HQ
 ltJPHyc4iLNj6V6HR4zM1LGJ9WSZ5nusnRxrhiwqqsEe2VRzs7azMxTH3gIHaAujB55S
 mGlFicJtofyChVUXarFphFCVagFBxKG6tgZ942zdFZ5qYKrw/Rv+NNLnxGkitSED69RV
 zFkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9SEvtuCJZRkP/GS5wvf50M4pE87Y2x0ghRor4pTy5m68uFoTozTv9sy9XIACS2r+aGPh5MI7RTkd7@nongnu.org
X-Gm-Message-State: AOJu0Yy6afuD49NcxtqizUI0SUBWB9b+nDWbfTSG2DpecwIv4/YhMLsn
 AX3O9bh6spDQx0bpjT3xJxFtzNfzAagwAr/V57pLcq0L7Ugr3MCWKpjA4Z0yu5IHgVI=
X-Gm-Gg: AY/fxX4iKD1zYeWtEPKN21Ic3otG5evZ9FR29Bl2eeNt+J2Z3LWd6jmqjm2h/pokQHQ
 BgM1vYn9/a0D8wv5+6vt/n8NL3S4oXno8BVrRliN23hZOlK9XPMTYD5FJiB/uhc2Z5jYdo2uhl1
 nif5CGsXkmwMOQtCzfcjhTAoAojbgiiD1b24+8QbUyQ1crEejBIxN/Cnj9VOfr4IaC+06gfl0cn
 uZbhu0Pv73V6miokH5gYHyG46EA2dze+Bymr44mUBfAN7rfYhl5LqezYtLvlXAT+0lxMmYCmHW8
 zCXSVeDmpdOVpoJCBoTD6exPl1ycG6feKusypbSM3Zz9VTegNK2cgFIpO8XpCM8ZE/aDFU9HQLg
 791JBrKP+T/vqCbSAGBNdHnVtsSB+DyBHw8R/Rds+0docBG2rKSqkmaZ7Tk0a8WVwXMWTMZNbcH
 OmJ97w/M3D2rJ1iIiGUDk+Tq0YLG7U86uOabF99tUEgTV4M0bC2M8svVza9I+suOP9buPdFg==
X-Google-Smtp-Source: AGHT+IE1eaLwNKTR5R/6jE93aI3eLfrOaTJhuEyPIA4QxZkGD+ZMuvB1nsBMlAz+jWbEsK2dPbjjhg==
X-Received: by 2002:a05:600c:1389:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47d403e4fd0mr331174585e9.10.1767444490725; 
 Sat, 03 Jan 2026 04:48:10 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d33e351sm35901805e9.10.2026.01.03.04.48.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 04:48:10 -0800 (PST)
Date: Sat, 03 Jan 2026 14:47:37 +0200
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
Subject: Re: [PATCH v2 03/11] plugins: use complete filename for defining
 plugins sources
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-4-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-4-pierrick.bouvier@linaro.org>
Message-ID: <t8agw8.3rpi6u60mshfw@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/meson.build   | 12 ++++++------
> tests/tcg/plugins/meson.build |  9 ++++++---
> 2 files changed, 12 insertions(+), 9 deletions(-)
>
>diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>index 8f9f0257ee5..3d2d7862e0c 100644
>--- a/contrib/plugins/meson.build
>+++ b/contrib/plugins/meson.build
>@@ -1,16 +1,16 @@
>-contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>-                   'traps', 'uftrace']
>+contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
>+                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
>+                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
> if host_os != 'windows'
>   # lockstep uses socket.h
>-  contrib_plugins += 'lockstep'
>+  contrib_plugins += 'lockstep.c'
> endif
> 
> t = []
> if get_option('plugins')
>   foreach i : contrib_plugins
>-    t += shared_module(i, files(i + '.c'),
>-                      dependencies: plugins_deps)
>+    t += shared_module(fs.stem(i), files(i),
>+                       dependencies: plugins_deps)
>   endforeach
> endif
> if t.length() > 0
>diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
>index c58f2e382ae..303f97f9679 100644
>--- a/tests/tcg/plugins/meson.build
>+++ b/tests/tcg/plugins/meson.build
>@@ -1,8 +1,11 @@
>+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
>+                'reset.c', 'syscall.c', 'patch.c']
>+
> t = []
> if get_option('plugins')
>-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>-    t += shared_module(i, files(i + '.c'),
>-                      dependencies: plugins_deps)
>+  foreach i : test_plugins
>+    t += shared_module(fs.stem(i), files(i),
>+                       dependencies: plugins_deps)
>   endforeach
> endif
> if t.length() > 0
>-- 
>2.47.3
>

