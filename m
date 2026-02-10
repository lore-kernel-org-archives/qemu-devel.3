Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1524EA3F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 22:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpwZb-0003tj-GR; Tue, 10 Feb 2026 17:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpwZY-0003sz-PY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:51:08 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpwZW-0005jt-Sk
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:51:08 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso6239035ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 14:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770763865; x=1771368665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkvOn4Yd5vMUv0tl4E5R3qydMJPmWHhQt3mq9OTT3LA=;
 b=iXb34YWZcadg3k24gJHHJrAqvTbGOvHMC6LmO4vxEwjR9rdJY2ByyJ+SQw3AUN3GeL
 SchpoXST6aQD5B+8FBoStPmlu3aVIt6wN6OQlakzbpxau+Hd6G9zgACFoyXNhe1Kxsvm
 PNRroQv83DI0RGZ4w1hV7IcnaJvAuzU7nKAyWiGhGUgTjpFYeXKBoxur+c8csDhwaJGd
 bf5V0EHKaAR+jXXDfF0SFhU/RvJQ/BNtjLds+OtcNBsDQ/7G2Wz2V5SKZm1PatibUpTA
 jjAvV3nbkEj/e5jw4bEVw/TvBdh/Bx7ur3tyAC7prV3F9lgFupn/Ll/9TxXqR4yVQHKI
 fWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770763865; x=1771368665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BkvOn4Yd5vMUv0tl4E5R3qydMJPmWHhQt3mq9OTT3LA=;
 b=jek3VcQzMaAxSE9f//U+5+4Onp6jVOG+0CKgwsBGsbwvG9ZGYSGRpfDed8q2rJdd8D
 KZuZz10Dr+qmc6nnOdms9LLGbFmzvIEKa4/Ad9NPP72qpIwUHeyMs4jTJswBdncZYGOH
 zqS9hpoZT8/rPWc36cOPZGpIzjtKQxXza2ScGoZaCFbreEvIJcFZ/sGFlyJ6xvvy2lEx
 Hnn92HGmgmc2FXpE5YpPqxXiN+4VSqQK0qxQl41A+nFooR3POmtQRWd6JMoHIMOCcakL
 G2LAkKsTcPX/h5DPYD+Dlm7Ucnk7rVYxI+9o51+kkKhNCC1J/Te7Tnp8wdxJ9cogFSJS
 kQpg==
X-Gm-Message-State: AOJu0YwWokzpUYL6BSR9KC9YyM+fv31LtC25RPej2sDMvpq7GotDy0u5
 tuKpuHtlYobEDyPsQI294nN25+h7yY37/5f7PyTLrp4UHPqyCtIBwG3E5jcgNAWvoldRZczeywQ
 rJ2wq
X-Gm-Gg: AZuq6aIPgqanTvtq04Kn9Wk+44SEOIKy9cdB4lQqi8yJX55nMSH2DN8Zv5VmeoJB+qs
 DiHnzos2HG2kuOOS9/KWiL7nIdN2sLgIfwIWkfI2zfIhRfdqb0LEDuzE4V8rFzAj7R/Sl8dgT0U
 lI031K5lpoC9KWTOTiDY2GJiM/Js2Tzcg3voawENsZ532y2LB7bYXSCWVzcfibMrondQ8u9IN2q
 zoKvPcM61PJr2IPNcDGKs1yejI6XWHr/v2I25SsNC1K4PL95ZGby6zdJTrcxVgyuqaPqoKyRlRn
 MqluIS4HopkkugNxgG/hGPJeCJWxcVccaCp3qkouyxdSEk8bJFTNc0J2XTZxgHVvsN3vaxfAP8J
 93RjL83yF+YSf+up07uy5xLwq1AdPfMKNi/zer9RRqnIQrg69jYpdQ73tz9sZOFra0w/kkLu1rb
 vg8lsnVm84t1qB3MpfaeJF/CeN5IyjHeX8uNk6ZmkgG9f+/0ESouXaaBL/grHn9ab1lISgCOBX+
 8oG
X-Received: by 2002:a17:903:1b04:b0:2a2:f0cb:dfa2 with SMTP id
 d9443c01a7336-2a951625455mr144453585ad.13.1770763865252; 
 Tue, 10 Feb 2026 14:51:05 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29999ce2sm1197055ad.92.2026.02.10.14.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:51:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] plugins: fix cross-build using LLVM for Windows targets
Date: Tue, 10 Feb 2026 14:51:00 -0800
Message-ID: <20260210225100.1573968-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210225100.1573968-1-pierrick.bouvier@linaro.org>
References: <20260210225100.1573968-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

llvm-dlltool assumes that it's by default targeting the host architecture
it's running on. That assumption doesn't hold true when cross-compiling.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210040722.11375-1-mohamed@unpredictable.fr
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 34643e2cea3..9899f166ee8 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -41,9 +41,16 @@ if host_os == 'windows'
   # to find missing symbols in current program.
   win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
   if meson.get_compiler('c').get_id() == 'clang'
+    if host_machine.cpu() == 'x86_64'
+      dlltool_target = 'i386:x86-64'
+    elif host_machine.cpu() == 'aarch64'
+      dlltool_target = 'arm64'
+    else
+      error('Unknown machine')
+    endif
     # With LLVM/lld, delaylib is specified at link time (-delayload)
     dlltool = find_program('llvm-dlltool', required: true)
-    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
+    dlltool_cmd = [dlltool, '-m', dlltool_target,'-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
     win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
   else
     # With gcc/ld, delay lib is built with a specific delay parameter.
-- 
2.47.3


