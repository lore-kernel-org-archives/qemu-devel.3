Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A31FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0l-0006pC-J3; Fri, 02 Jan 2026 16:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzh-0006fu-8s
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzf-0000JJ-4O
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:37 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34e90f7b49cso9816439a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390453; x=1767995253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnAdkGiLfpQOWDhRaG+Ezymj+za6GSlpDviqh2IMnE0=;
 b=lUaHv3RQkestQoMtUooCobHAyQqvsgiK7JpqdBZskwDVwqXiWkIwf+iggy0ZX6l6ev
 JrzjtwHtOXWlGYC5QEDugEg+iB0gzvoKKBuHeXltAmKDOJRp3wgcT/TL8bfdGEcboYpm
 /MEd2sYhtBUwYIw2DBdMaIrtVrQ4ytUMVCFOBWhBF9yiIgkWrDp0ldFG2PN8xYrHCe66
 eLWKbjpObZTv4Gw8pn0yGpI1fldgwHCpKogabgs+M6KTJ+NfQ0x1ci7ZcvW7bAqbyaYs
 6uUgnsE/cB9+ReCH7tL6bxAcLjqyoJpnOR2DZ3xKf9V6wTK4SRXaSY0AYL2eAQWsESvN
 gU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390453; x=1767995253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gnAdkGiLfpQOWDhRaG+Ezymj+za6GSlpDviqh2IMnE0=;
 b=IdzywAyEBZIBu4LpGMsY0E4yBeCMQqEaJK/4ls3edGXtPlhrrbtfHjXslTosxRDKBM
 w6VfyxkTZcSy8VPVVVKBLnel0ZrajQd86GgD2BGg6n4RfhNjugrwEotP8m5A1XdCjLuH
 Piv2fHsJZlXMZQWMaqcyWkwwucS/FIEclWuhSdpDg7jLBdL1wMN65zABW7yG96yb4g/W
 muQPMWElAqvS5qZGwe5rJR/VfCMkoW82uiqFxWxALgkjQ/aC4FkK00ylyDFgw2sv2Kpq
 vmyMOt5NWKUUvpsb+X2n+WcesYeG4ywZuX7Fvnqrydm/Mer7C/0LXZLzEhwc0XQZhxw7
 5J3g==
X-Gm-Message-State: AOJu0Yw03wbPVxG+AI8SuCn+Dx5YMbsVUUjKlvoPRFnijljHj2HZyLLB
 GVx+pOQ0OQ3sVEhDgSwnVPBcdsRcWPc0RO9EOpXjGUj3PIxUCnGDSPFguiGe/688HkcHU3QM8mt
 4qaCe
X-Gm-Gg: AY/fxX7QQLCUZeMcKG4lMDINCv0GVKSJsFss1J+fOxwuZX/H9TXc6cqLU5LDBItQwj4
 wRJV/x/bPY4HvCTKcp6M1de5ME/mGcQDXgrNp5m4NN1fmXZP9QE1ShjSFy/IK9aHcvgZgQsK73e
 bFTGQ3Q30N324I8ibZ8fbdXY8KXg4A/DTCqe3XreskKXBrNzLrjcOqNyEjMWlZ/Y70uziEjo2cA
 3TzIP0WhF54Rnx52VVIeI5rlGCGnF46aTfwYkabYcniG8bKUUlwEhHbFZ6IBBg6bAio5KHS7MD9
 VBAPxh3Ktqvq0JoOXWjZTCKhi+/rVxo9m6i2QYfEtAg0yzmuyVfLBp6qLq3sxeZpg0dYhpPpX2T
 0b3FNlU+d0WdDHdBbSVddpnnCFj49OlWRPRZ+2U0eg892J1IlX/dSxTqMhvhsQUZlx4e151OMj5
 b8ocTVw86IM4ER5TwQEKTnOQ+xoyhyL33t9+zl5URVP0d7rxej9byAWB7t8FLnrbdF
X-Google-Smtp-Source: AGHT+IEN8L2XuOjcoyS7tXwkOQIatQi+evPwGqJDZkRO+ph6nGmm68q/cXCA3t9I949T2Fsr8AM0Cw==
X-Received: by 2002:a17:90b:56d0:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-34e92144e4emr36517270a91.16.1767390452656; 
 Fri, 02 Jan 2026 13:47:32 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/11] plugins: use complete filename for defining plugins
 sources
Date: Fri,  2 Jan 2026 13:47:16 -0800
Message-ID: <20260102214724.4128196-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 12 ++++++------
 tests/tcg/plugins/meson.build |  9 ++++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 8f9f0257ee5..3d2d7862e0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,16 +1,16 @@
-contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'traps', 'uftrace']
+contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
+                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
+                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
 if host_os != 'windows'
   # lockstep uses socket.h
-  contrib_plugins += 'lockstep'
+  contrib_plugins += 'lockstep.c'
 endif
 
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    t += shared_module(i, files(i + '.c'),
-                      dependencies: plugins_deps)
+    t += shared_module(fs.stem(i), files(i),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c58f2e382ae..303f97f9679 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,8 +1,11 @@
+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
+                'reset.c', 'syscall.c', 'patch.c']
+
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    t += shared_module(i, files(i + '.c'),
-                      dependencies: plugins_deps)
+  foreach i : test_plugins
+    t += shared_module(fs.stem(i), files(i),
+                       dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


