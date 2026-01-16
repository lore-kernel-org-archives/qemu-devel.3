Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC28D47CDE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj91-0002xk-4L; Fri, 16 Jan 2026 07:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7i-00026i-U5
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7f-0004i2-Cs
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso1073941f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567213; x=1769172013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSKck+G80/uzFXWf7uvXDLCttSCHbaHtXMlCJXMft04=;
 b=s3ImtIfYsTPvRjNZ3at+H2fvQrxaUl6VrllCz/u1znzN1Wn/Sar1oFqKLqzD48bJ7+
 7pD6+AqykVtKIA9mc+zGg4x1h2aHBxa3FBrV4cB77Nfi+IvlLIlkBSaHXAKORkoQPP0/
 DT/ByfeKC704LxazxLlHJROUTYO78O5cgCkCe/yRTdGc6qDEySXk1gp0ClCEslF3MCXS
 CqF8+lPILhkEGfEJild5siEoMztFBBLmfnDgtZlDr8QnbP0DKiBMXuGTD5CMKgodCd43
 X+sDecuD71gtfG1iZSCTnXAt+4mYeWAbCh4Upq+GOhI/CosDMq8Izf1ZKba/wYbTXx35
 oxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567213; x=1769172013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XSKck+G80/uzFXWf7uvXDLCttSCHbaHtXMlCJXMft04=;
 b=Hi5nj/yiJWf6f2tMejR1qiKo4uIoUXvluC4lypOIcsMzcHgjNOCzi5AKmdT7wfiVl9
 pbt58yFJXP/qcv3nHX9ddrz1LzoTH32oQOl76PQEDdBk9f+4KiUTIoPRn6NMEOE4mSPB
 rGw7JCPrzfQzsezQmLgsUk+rXHhjR3lj3m2An2e/9Tgi/NUnQ2TmMVhk1dRmAddK/Qpy
 nvGA3oNE9tMa2WWILOAsU8lw3o6eZLCXc6Ct2alVbUzhF6PmNpO72FfrLoYwqbNH9YIX
 vR4CGA/lc5vv2R84RbXiZ3L2AoEWdKZEDn99qSa+Ll+cKm/LmudID9PSlx1pN6OenE4O
 /Yew==
X-Gm-Message-State: AOJu0YwIniNtv3WDqs7OAl2e8/FmdBuslvGK9GzLUFUxax8dalKMA5k0
 +7jNzPwpU1i36MRzwpF8+m++okjMjfbg1zorx2p5HpshqnpzO83f/Tn+FAk1ynLFCpEozIcrd3I
 Dfri3
X-Gm-Gg: AY/fxX49p41WUF4rvaO1PXP8ys7FqzK9ECRF3Iim64//cnxsQSwCImD5CLYJOMScH6a
 AdOuryRz9i6RHwxbqzsx2MnwV4zUAfly3/jhgPrM4jazPJG1s+5XsD7Z3CUQfRanpTiv4y5hwGL
 0ZEMr0t5ksQuPqAcjB8SWynF09cTo//t37SJEsYBmcxyAEeBAOKiJs48C5rHy46hh3fgTssW+ZH
 +Xa9HNZXmjW3YR8JjHRTRcIraXynoyZcrE0B9eRdVbWoSgWN5VDytR9io5D1xyobDWTdqyligOU
 GZTt7ZQ+yErrzJ5mKzK5wCnLTNeyweAqXmmG1PhAKBd3b4y3o/6I9scokelXVTdSab4p0PaMYb9
 DTJ8MdeEdzfsOwDCzdJzEi8ATGMg0PPHld2mbvLv74WGGMPEpKvyUaiZsNXPkG+lMzJYqvl0zvI
 00r0wstHFJTEnwE2Fp+injoPrS9QQW4rtwt9XmNWc3xDnU9midSEjfWsA0UCYY44L0DrTg/c+mK
 l9WgyOaunRB/EEy3h8HYGaef/FGVZX1qntjDwWrS3lwoQ==
X-Received: by 2002:a05:6000:1789:b0:430:f7ae:af3c with SMTP id
 ffacd0b85a97d-43569bc1801mr3473364f8f.31.1768567213251; 
 Fri, 16 Jan 2026 04:40:13 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 6/6] scripts/clean-includes: Update exclude list
Date: Fri, 16 Jan 2026 12:40:05 +0000
Message-ID: <20260116124005.925382-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
---
 scripts/clean-includes | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index b16eec0a5c..7e3347f261 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -115,10 +115,12 @@ trap 'rm -f -- "$COCCIFILE" "$REGEXFILE"' INT TERM HUP EXIT
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
@@ -126,15 +128,28 @@ grep -v '^#' >"$REGEXFILE" <<EOT
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


