Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09756D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIoP-00080S-IQ; Fri, 23 Jan 2026 10:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInK-00074h-Ss
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInJ-00034U-8n
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-435a517be33so1441102f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180992; x=1769785792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/RF6pl6Z24KJwErQfhxFPKK9HJeqT7Vndl2qEdlgPW0=;
 b=CmiNpXMker+Yw9RGURhvQKSgkRp5sRzEEUMlnvrcKn0vfAPqBl5gBRT/mZcDrTl6Qc
 bTEY6XtxiXJzY6cD7zSCaxqimXkuZ0pc1G0WvzjJESAuIRZ8aYtLpq1bj8VGQbjJfL7o
 bXhCXBs6+0TP8k+XOD6GJ78zUcS3OmFGV+T0FJRH+cIKp6bYz12zTkE+vBxQKx52KHQC
 WDEdcTg1WjdJfvFOIF4otoEQnFHynhVFezOlforlXDwlZogN1DGswNY67GwGloP+1JQ3
 PncWoA2B60wKIgwY/7y2ek5OSx4VJX1YaYr0dyLBSDCOWCxegpcSTXWPwChqgF9de7n3
 srLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180992; x=1769785792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/RF6pl6Z24KJwErQfhxFPKK9HJeqT7Vndl2qEdlgPW0=;
 b=F5fPDkn2iq7cJPiDdRFsNpU82djb08VA+V6kUz6RexV4taXZA4vkSTyaCd1A6eWMx4
 tSY6BI43CKhvk6qpy6fKhUO/S3Q/JsG/CpIzQ9LCuZpXo7TFaafAYFDM4Pd+YpMPTM9e
 bPT2Ry8m/q0u40VWmruw8dhzW0If2NkVa1RQTi3noIPAVWRZjS41jZnfwLXqkednn9oi
 or8USTTp/OXq0WcCh/hEHTvJlvSGH2Vfrw8WDYRszuQA47e66ncLL7HmckVhXO3dzSL8
 +gxsNHeRw4Lq7xunKOh8229alggIBa5Gyzv3aknZEjRa8Bpyf2yknGUWeY2OJnkuyN9w
 je1A==
X-Gm-Message-State: AOJu0YyYG5amlO8jBjIAqgd1ONsIhCGgB7xHaaL/EHosrwqKRpVPuj47
 F8b1NX+OFBr3PS/UKWN4P8oSwB2KguZaMQWCNp7CfwhAIwG1KP6oTbOvfOJzbXpkBUb//ojw7hV
 aoWrKvGU=
X-Gm-Gg: AZuq6aKU/QNJugJYmMDrd8NCV7wVvYP9pgtXs6xxWwxKopRk6QumwBRilD2f6GGiiYs
 9ft9ZS1BorOHvDujZ6/C5kb8jnKTjoSqY1xgJR3dAMyx+Q6IzKRnRwlry0MQGYoDTbyEZHDNeUb
 BRwnzhoka97oVq8v8ImgSJDg1Y8TRLntNEzwqdr9BhkirEbY+tuUsqLQulJlInveZCDVZJzl8mb
 GbWGjqMbt3wEaTLooeDOkhVztW2Yxiol6qqo+xI4XdiO8/qlyST/RZDCr/1DJnS+P2TShMXrAF8
 0HCQl2p/6bDNFAEQHKPXlD1Jju3c5HDO3NqNZjv48mOl8PSNmdr7r6frvsh0G7cIQK3QY7eO0kL
 YA5oVCqhCbJHevnqeWNFw9wzk/WclxTXQYKo92lsJLsRAZM9Uof/kXoQHCkiz4ESIYcdrZnxhlj
 OcJBEiuJmalvhzaOVpCmpi+BIN2l2Y40xnn9lzDlkHVp8ANMG10lWg
X-Received: by 2002:a05:6000:4210:b0:431:104:6dc2 with SMTP id
 ffacd0b85a97d-435b158d740mr4706845f8f.8.1769180991597; 
 Fri, 23 Jan 2026 07:09:51 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/22] scripts/clean-includes: Update exclude list
Date: Fri, 23 Jan 2026 15:09:28 +0000
Message-ID: <20260123150941.1877768-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Remove from the exclude list:
 * tests/plugin, which is a non-existent directory. This was
   probably intended to exclude tests/tcg/plugins/, which is caught
   by the tests/tcg exclude pattern anyway
Add to the exclude list:
 * rust/ -- the headers in here are purely for input to bindgen
 * target/hexagon has some standalone tools used at build time
 * linux-user/gen-vsdo.c -- another standalone tool
 * linux-user/mips64/elfload.c just includes mips/elfload.c
 * scripts/xen-detect.c is feature-detection code used by meson.build
 * tests/tracetool/simple.c is autogenerated
 * tests/unit/ has some "C file just includes another one" files
 * include/system/os-wasm.h is like os-posix.h and os-win32.h and
   shouldn't be adjusted

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260116124005.925382-7-peter.maydell@linaro.org
---
 scripts/clean-includes | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 064e532037..874dfd0974 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -113,10 +113,12 @@ trap 'rm -f -- "$COCCIFILE" "$REGEXFILE"' INT TERM HUP EXIT
 # Comments starting with '#' are permitted
 grep -v '^#' >"$REGEXFILE" <<EOT
 # These tests are generally standalone binaries
-^tests/(tcg|multiboot|fp|plugin|uefi-test-tools)
+^tests/(tcg|multiboot|fp|uefi-test-tools|qtest/migration/s390x)
 # BIOS sources and third-party subprojects don't follow our rules
 ^pc-bios
 ^subprojects
+# headers under rust are only used for input to bindgen
+^rust
 # plugin binaries are standalone
 ^contrib/plugins
 # the ebpf tool is standalone, and the skeleton header is autogenerated
@@ -124,15 +126,28 @@ grep -v '^#' >"$REGEXFILE" <<EOT
 ^ebpf/rss.bpf.skeleton.h
 # These files just include some other .c file and have no content themselves
 ^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+^linux-user/mips64/elfload.c
 # These are autogenerated headers
 ^include/standard-headers/
 # osdep.h itself and its friends are expected to include system headers
 ^include/qemu/osdep.h
 ^include/qemu/compiler.h
 ^include/glib-compat.h
-^include/system/os-(posix|win32).h
+^include/system/os-(posix|win32|wasm).h
 # This is for use by plugins, which are standalone binaries
 ^include/qemu/qemu-plugin.h
+# standalone tools used in building the hexagon target code
+^target/hexagon/(idef-parser|gen_semantics.c|gen_dectree_import.c)
+# standalone tool
+^target/s390x/gen-features.c
+# gen-vdso is a standalone tool
+^linux-user/gen-vdso.c
+# feature-detection code used by meson.bulid
+^scripts/xen-detect.c
+# autogenerated by tracetool
+^tests/tracetool/simple.c
+# these just include another C file
+^tests/unit/test-rcu-(simpleq|slist|tailq).c
 EOT
 
 # We assume there are no files in the tree with spaces in their name
-- 
2.47.3


