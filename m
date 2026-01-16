Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D84ED48984
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqq-0007M8-Gu; Fri, 16 Jan 2026 06:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqo-0007Kc-OM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqm-0005jU-SC
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso12878225e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562323; x=1769167123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0HpoXgcBtw/jlAhT3nBU0eOAguVGh9HBtx5DELtQlEQ=;
 b=hO2Yoh7hX/3IJ1RkGzUEksNSeATaO9oyjlvkbyuW7dTEgbU87o9QW9CfmenQdTJjXX
 Kfp0LGqA38d0hlU1wxb2Umip8VSG0haXawo6fjajm0+vU9mr/h1oSf31G528Lexw4Gpm
 WXj7kLbJoNHOlhv/dxfFWlioxnzzLLsrkNSkIcl1kb84h1r/V9oQFPQJspxpW5sIArkU
 Zjz3Bs+sx8IzizDp/KsADU/gvslKSl9FBuBsdpx7LfVhiK+LQ0r71eHKUic1HMJLFBkg
 XZULvS4+ShYzHMgAkATpndn/gKgWQwd6RNMRjn9i+NdGAXGCgIowowRjIC9k5+y0Yx/m
 zecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562323; x=1769167123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0HpoXgcBtw/jlAhT3nBU0eOAguVGh9HBtx5DELtQlEQ=;
 b=IF10YPg/rQpZUZyTUb1FbtE9Zs8RhUxYGgHWGDH9Bl+Zt25Jiopn497uzMv9eAq5Xm
 yJRr+/zqv43ilue+kjeCwbOWFKG3heNWq+e2rvoDkv4K8XP2vCRozV7K8oGQMql5Fl8g
 Dx+cM0mZCm1u6+Cft+NgTandjSFycRIF0/uN2nzCp3fuMWq5BDszJS7do/5WFX3GNduW
 zn0UYDmlwS8WbfUKenC/Q9+TuiIBQLQPStuqmancqHzRDmT9c/M8W1cRThMw4gqT9tO3
 UE9S2oPF5i8iNwTyv63g7Q25BpbdJoB17wkqk4i18mERD3KwVSpg8tsqY1XHvzKIiFH4
 p02g==
X-Gm-Message-State: AOJu0YyHoC+G975LJBDto7BqkgBA3udKGOIFg38TEfJH5/DKETctgIih
 LboDcIuohgmnVsafVaZ8eXflr8O5y5VXLhf9SXM/ET+Rp6ZdyBEmoPD2YzcQWbDrYdfNy0bAscH
 ukVYt5yc=
X-Gm-Gg: AY/fxX6X7u87MwLuSIqNx1qNAREURYkMPDU1fwWx4OGmixueZm/H0oBcOnp+3AKQzEq
 I3GGC2DLeCYtrgHu0l8MHKPMEB+lt0Gwlg8HzlmDkeNWuUCIPYy1HuavBe7oi2Yhg95F6UA5vbD
 quiXCfu1QvCKdkmAKR+9mNasP/CSgQOcyQG+4l2A7vAH22eXPwoDWY6pHJZbljezo2KMA+zVa2l
 Dn1Yi7+NnPPgLQ0dEoYH1rQJ96Wi7YFpuQIWnsVjCNwvGmk+WNKk0WnaqzJ97Ecd0DnCTluWHkp
 pScrN6QRfAqasKANstRzc0zcDRUx7cnrms5A8kVan2CuSIZ6/G63Gzl3dU5iVIAxEI3tKSJ5SeV
 AUOqVmT+HxTTbbF2EkFCU4k9OUIGL4srPu+wwHEFmDtCpgk7hbktX+L7QkMQki+K6vzhsFVZHyi
 44+T8JRJB6QNHTZVGH0QMm4LK1r3rIYJS3hP0ZMaeF28tPH2/KwwV4XgDJdPyk+WHNvWMJBYM=
X-Received: by 2002:a05:600c:1986:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-4801e30ba86mr32838625e9.14.1768562322648; 
 Fri, 16 Jan 2026 03:18:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e79asm4682308f8f.33.2026.01.16.03.18.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/30] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Fri, 16 Jan 2026 12:17:42 +0100
Message-ID: <20260116111807.36053-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Currently there are some engines that don't support wasm64 (e.g. unsupported
on Safari[1]). To mitigate this issue, the configure script allows the user
to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].

Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
this flag lowers the output binary into wasm32, with limiting the maximum
memory size to 4GB. So QEMU can run on wasm32 engines.

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2f068c7884a629fe3e4b297368d70b0956ab048.1768308374.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 92bfc5f9765..326d27dab1f 100755
--- a/configure
+++ b/configure
@@ -182,6 +182,10 @@ EXTRA_CXXFLAGS=""
 EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
+# The value is propagated to Emscripten's "-sMEMORY64" flag.
+# https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
+wasm64_memory64=1
+
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
 #  * foo=""    feature will be searched for, and if found, will be used
@@ -239,6 +243,8 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
+  --wasm64-32bit-address-limit) wasm64_memory64="2"
+  ;;
   esac
 done
 
@@ -521,7 +527,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -779,6 +785,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -904,6 +912,8 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
+                               is to use the whole 64-bit range).
 EOF
   meson_options_help
 cat << EOF
-- 
2.52.0


