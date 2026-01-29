Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA29D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtI-0000BU-Nd; Wed, 28 Jan 2026 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt6-0008Sm-LK
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt4-00039Q-W4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c635559e1c3so192483a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650318; x=1770255118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QelvfUsw6o6LxVxWTbkblnaREhszkxjV185vVeRr2dk=;
 b=BVFSVVdDjl/OVBg6BU4ft24MyhHsqrTxRymCJNSNLuaLFiOHOfJ+L6xI3kOuwWIMRr
 DkX2BXndGGSZ1X7WFDaO1cleXuqSbpff4cBWo8dlHHX4XRB59yFo1pdxJPfizoEhhBia
 4SPWemU3ZiIsWcdWR/dBIiekI04HZoxxQIaCsfrz4tlXZTXIP0GAs6QiNSOuJkswCoQp
 NEtfovWnvrsQx01yDT7x36G5o5HTGuFwb9RbQgtFUEjAv4oVErE97v8JHT/EFnDmJDUC
 q5f79gEXX0mJRf1za0DHPWsxH70eA2TlICGEFHfUsBTMw2WG5xVdZi73BBarcuzvpWjg
 /kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650318; x=1770255118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QelvfUsw6o6LxVxWTbkblnaREhszkxjV185vVeRr2dk=;
 b=tGj8CvIEKhNmfq4ie60FlJE+aH4BNSCaDAtAyqSeFQlRO+BaJ1qAazUiFS6DjEmNdq
 QGvASGrogpfnfqX+4GpJQjJccA8j64524FPpmlLBScGiUojr9GOzcXcAADkMJebv1w+H
 u98pj6/F7+0sSCzdfelAxWIBAz+MdNdfG5bYj0CfLRe64P/Yn+W/ygIBcawb6/IjNivs
 lxfVwP9ydHUF2SH4w3T6bh6IFsEUN/b5ApuBXUHcxRF7L6add+aO/8hlpx8GP2Ne4Nxf
 fZ5TywXEa4NmzReF3/Ull9Kv128V+MitkwCNXl1gY+k9FkACi8/RsVutmraw8e8Nh7KF
 vY1A==
X-Gm-Message-State: AOJu0Yx+xWzRo58v3vwsg24vckkFE8JxWCddljycVMFJZXqwOiprqejP
 Ypv0rwBxCN1m/h5DrGRc2HsMs9wPsXXi/blptHdZE65AAB0Nij3UH9RrAmSxCSpJbWtitCnsm9J
 Le4i2
X-Gm-Gg: AZuq6aIkLL+w8LPHlMJIEi3+vSzx51Y7MqfsjvVML75LUglfNv/+yj8Qh5gR2snn/Bp
 rAMc0hv7T9mVfa6/HXioF2rULiA/nbIqCyRx/0aiq8SK0/XvJk5m27vJRWZasUZWYCyb6YHwAOV
 tvcuVp8iC4Osn4C7KwPMIevlfiYWcr68dWcXOfQbxKwtcK2wrQCX+NoDp2kyuxdCDu+Uxi5KDhF
 wr8egQI7ITVErgfRXg30N1PBB36o+uemlyPUrNWYcysn7qiQl4WY8MwLyWPEB4ZMrq9NizfXTFr
 ZQOO82npeN1IvYy+9GBolsivWhKL4i9F39c4aG7JTx/pvQlthEUt4iwAabZ7erommBTFksMQv/z
 ZLLxKRXC6QbE6uOv2cjHIq33NhcHHOsl6M0lHITPxwS+XSmXwcV4DzdIg1sPLwKfUrC3+EJRwsX
 2hMDgb4dGF+5jKPXq9IFAbRNa1tdAoCUsNbRD4Cg7qBQhU0BJRrhDdb3ZVZTII1/ot
X-Received: by 2002:a17:90b:4a82:b0:34f:6312:f225 with SMTP id
 98e67ed59e1d1-35429b0007emr965821a91.14.1769650317536; 
 Wed, 28 Jan 2026 17:31:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 15/20] meson: fix supported compiler arguments in other
 languages than C
Date: Wed, 28 Jan 2026 17:31:29 -0800
Message-ID: <20260129013134.3956938-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

qemu_common_flags are only checked for c compiler, even though they
are applied to c++ and objc. This is a problem when C compiler is gcc,
and C++ compiler is clang, creating a possible mismatch.

One concrete example is option -fzero-call-used-regs=used-gpr with
ubuntu2204 container, which is supported by gcc, but not by clang, thus
leading to a failure when compiling a C++ TCG plugin.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 951bdd9c54f..32bbd30bb9f 100644
--- a/meson.build
+++ b/meson.build
@@ -682,10 +682,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
     hardening_flags += '-fzero-call-used-regs=used-gpr'
 endif
 
-qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-
-add_global_arguments(qemu_common_flags, native: false, language: all_languages)
-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+qemu_common_flags += hardening_flags
 
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
@@ -744,15 +741,19 @@ if 'cpp' in all_languages
   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
 endif
 
-add_project_arguments(qemu_cflags, native: false, language: 'c')
-add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
+add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
+                      native: false, language: 'c')
+add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+
 if 'cpp' in all_languages
-  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
+  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
+                        native: false, language: 'cpp')
   add_project_arguments(cxx.get_supported_arguments(warn_flags), native: false, language: 'cpp')
 endif
 if 'objc' in all_languages
   # Note sanitizer flags are not applied to Objective-C sources!
-  add_project_arguments(objc.get_supported_arguments(warn_flags), native: false, language: 'objc')
+  add_project_arguments(objc.get_supported_arguments(qemu_common_flags + warn_flags),
+                        native: false, language: 'objc')
 endif
 if host_os == 'linux'
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
-- 
2.47.3


