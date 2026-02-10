Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF2EEB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 22:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvxG-0001Kg-DC; Tue, 10 Feb 2026 17:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpvxE-0001JS-0y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:11:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpvxC-0007S0-B2
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:11:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso5144123b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770761489; x=1771366289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BkvOn4Yd5vMUv0tl4E5R3qydMJPmWHhQt3mq9OTT3LA=;
 b=OKjWnuRiuRa+M0vshjxBba1rygwGQ+KEGFA9qPv6esD8qzzUWirF+aXCzdufSw/FdO
 Mtud2kscaqyt2VXH+EMRRMYbM/eVwkA33GCLA/jpmo1/jEjc5q8lG0l4Zyyfcmb4kbLS
 ZLIVwAc4dg4pYADy7Sxow2BHzMZN7V5HsKSnnu044FGe4U3k2BflixNH/MLpKSFNMnCZ
 SrrsLoBBi9Pc3z+g1r4d6smoH6oRa2N4EgvJmmhdBJ5FPV2IiNJ0ZGcF3L3WcojY60U2
 32aaARMvGW3mjHJ2IWrfCpHkhNQyr97smxupckllrJjfbF+d8WchKDUiaD9lJIrTs5EY
 nUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770761489; x=1771366289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BkvOn4Yd5vMUv0tl4E5R3qydMJPmWHhQt3mq9OTT3LA=;
 b=s9YMcu/77WmOHNUjFRiQ1me6/4gS3ZwnYbnWmbqdzFl9QAuRhFsxIsGtTRppa7V2VV
 N6D+pWl0TyVtHhRg/46ClfPNN6stkG8wW9aNCuM8EupmQATHgcNuX1o2Cb4z0xUYLs4w
 i3LSygkd8Yf3h6rruFN/s9f7zib2EgjPcoEhsWBZj6BojMClKK4myfYnauoriRa+gOAJ
 7VUhIUiH7EcChqsZEZ4p5VrUuxNBUEU/dOic+rPDslm1zfdVVS41qx1Wd7aJ5Jq0xY2Y
 cfgxAkfu+IEcf5x43cc1uom3l/Kv+pbnsQdzAC2yM41bD1XqlCGN/6THpxnCmjzrG6YN
 VcAw==
X-Gm-Message-State: AOJu0Yx23QmxBSE2HCjtni2aJld2XVE7ccKzW3FO2B9MRMFvxfnnLoo9
 OsCSKs1t80frurF86rWDcKFWPUuwI/ESPKtr4rh5viMxV1D85xEoYyO/UGBLwNjjwzn4WXXsU8g
 lUOUp
X-Gm-Gg: AZuq6aI7lDnlLpzb65GbQ6QlBvYivQu3AcGrlnrJiaLZDRjLya0qLdkzIJ8fnfTLkrY
 rkYLpmEQwROPtFs70/QlCd3zUO9gNqFMlkcseEjyR28i9B0e8xLFMVtaV+P35n6jzY6Y4nzGZkY
 dLqRXr5godGGgNp6d9L4PaGl0NuWNUuoPN4mQApVZivsWysywlahJGXKExCKxtCsaDAekul/3pW
 qhjCIRxqJ7hHykTdvIbUOYirAU3qnJCEM6wmzN4OiYpuxyVYQq3oYprQgS3rL9ldl7Pux9CwUg9
 Bb7h7bNSp4h3qs/Jj58v1n/+2mnjuTqKZjm997V+IwBTQsknTTTuXXrdTVDyuhBGZQ5d8PAYI3t
 jgKXRj0BSHlAbRPzpxvBE4yrGy00dhJWyDDtlZ6PpiXf2+t5OWsHRPz/LX7pSYyp7Rxl5B5X5iN
 O4SK3SqJ6QIcHTLJZlA+Ht+YCHBSdm7EDjRcI3SrFrZXEM8hvlDNK501iaTsSIg+g/eDRFVQkST
 uaV
X-Received: by 2002:a05:6a00:3d47:b0:823:5270:ef48 with SMTP id
 d2e1a72fcca58-82487a7efaamr3398953b3a.33.1770761488681; 
 Tue, 10 Feb 2026 14:11:28 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e36809esm19382b3a.7.2026.02.10.14.11.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:11:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] plugins: fix cross-build using LLVM for Windows targets
Date: Tue, 10 Feb 2026 14:11:22 -0800
Message-ID: <20260210221122.1494473-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210221122.1494473-1-pierrick.bouvier@linaro.org>
References: <20260210221122.1494473-1-pierrick.bouvier@linaro.org>
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


