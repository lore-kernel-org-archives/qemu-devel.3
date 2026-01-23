Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E798ED74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIoM-0007tR-Cs; Fri, 23 Jan 2026 10:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInI-00072j-2s
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInG-00033R-AU
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso19861425e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180989; x=1769785789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ftyJkzXc1aEPf2Cr4rOQCy1QIrr3zSHt535wBH/zjVs=;
 b=G8SQjkBt/bOVqPzlh3qoLmihxGNUiKVgfuzdojRiWqE8EVVNtjFR3z6lPccsQzNpCC
 C//7ib1nP8vF09KuJZNjby3Ls3q4qsVMtNEPCcw8EZLwm9I84SJA2pUk+pSgoYLjO2S2
 QWIC4t5XXItFMkaECo4elT+hGP3zPC+3Q5B4805gPy5BUdPNKWv7l9DVBMfczPlyGz4i
 kGfZ1lFbIb+b0GbxWA2LTRzXARufai0qfHhzInjd3d8wfEUCq7ZtC/A/hLQ2J9BX9VkZ
 qu67vdYvnrIjQubCswFMWyEncXYE6jpyyAT6nHY3G5O2SRw0BOJHQKUadhLwbWiEI17d
 wkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180989; x=1769785789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ftyJkzXc1aEPf2Cr4rOQCy1QIrr3zSHt535wBH/zjVs=;
 b=LU5cWHiMnSS0qaVX0DWSgfq9KD00aT57/b54/n1Xs0DtwheEIoiA8pfoG8XevKfIms
 o21p5XaEp3W19Eie4t6FX/nVRqdvuxRzTwyjy1JOuHVUTOY6c7myRZ+dDHGclA65qkBE
 B9d1s7Y7n4xJ5Q4Jm9YiHEModdBeKibg24/YaF5TJtEqU2+FonWbs2GcMK5LHZlnx5ZK
 i9Btwx9hEVO6W2EPyheZLTXZG/KVBHWe1lWcVC0ZtbKZDaK17GkwsZKxtWkj/DT8JfAz
 WmAGm7tW7NGEL6i0oB6ZSD4qC7ByVELA5VvPQCtBJHBBSqFEU95kQwyC9OvcOte12NQS
 bJvA==
X-Gm-Message-State: AOJu0YzMvCxMWGtLVPkfWdNQVSj6IB8xZ8C8SculjIEGx+rCHMjH5uST
 iLTJRCBPmJkSsOFGofgZzvWPlREHyqCznlAAda/wcThW8+liO6UDDcC2AgEJIMm3Kq7NctvBRFi
 WL5cyHVA=
X-Gm-Gg: AZuq6aIvJHyY1CK/RQd0ya6K3ICPM3/9vYtERKv62TgpEmIwHtVOx0X1exjOiL+WrMH
 mb+koRhbG+mSw5GauYrc/XznQyD2ZFxhTf81CZ4OuLqrlWr4xDHu5Ay94vmon8zRN6KUl6M193F
 Anh0AEN1eMusW0veCznvwDprjRSP7B1xi3ExLoqVrsUExXQg1mg4ISigdQm7789mtJ5aGfhHE4S
 8n6J4vuJx0DCkI8/cuga4y74u5XGj+yN5FREoozJe4qqWEm9AE0IHIlYWU5kOH2DC9gXABhkgoK
 Xtc/G+RzcaHdx7A6ZYshV+bPXHUy8OSu6VbcF3ziKwmJdvKcXKB1WemO/FtJuSgPmpFwqQC0vKx
 DRs9xvZDphST2JwljwOgFCBgZ+lJK0bgZjq9iuC0qdPNUIwdkclj1u00G2diPTPint+E5Ddy9Qs
 n4VtKOSVqRlpFGA/goj0LltFe+rfJwkyLEkqlZcbhHIixYvrtcb39F
X-Received: by 2002:a05:600c:1c05:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4804c944fc3mr60269745e9.7.1769180988787; 
 Fri, 23 Jan 2026 07:09:48 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/22] scripts/clean-includes: Make ignore-regexes one per line
Date: Fri, 23 Jan 2026 15:09:25 +0000
Message-ID: <20260123150941.1877768-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Currently we have a single extended regular expression defining
files that clean-includes should ignore. This is now very long
and awkward to read and edit.

Switch to having a list of newline-separated EREs that we write
to a file for grep's -f option, so we can express them more
legibly in the shell script. We allow for comments in the
regex list, which lets us document why we have put the
exclusions in.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260116124005.925382-4-peter.maydell@linaro.org
---
 scripts/clean-includes | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 568033ee9c..5ab3b07196 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -42,8 +42,6 @@
 GIT=no
 DUPHEAD=no
 
-# Extended regular expression defining files to ignore when using --all
-XDIRREGEX='^(tests/tcg|tests/multiboot|tests/fp|tests/plugin|tests/uefi-test-tools|pc-bios|subprojects|contrib/plugins|tools/ebpf|ebpf/rss.bpf.skeleton.h|linux-user/(mips64|x86_64)/(cpu_loop|signal).c)'
 
 while true
 do
@@ -83,15 +81,33 @@ if [ "$1" = "--all" ]; then
     set -- '.'
 fi
 
-# We assume there are no files in the tree with spaces in their name
-set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v "$XDIRREGEX")
-
 # Annoyingly coccinelle won't read a scriptfile unless its
 # name ends '.cocci', so write it out to a tempfile with the
 # right kind of name.
 COCCIFILE="$(mktemp --suffix=.cocci)"
+REGEXFILE="$(mktemp --suffix=.regex)"
+
+trap 'rm -f -- "$COCCIFILE" "$REGEXFILE"' INT TERM HUP EXIT
+
+# List of extended regular expressions defining files to ignore
+# Comments starting with '#' are permitted
+grep -v '^#' >"$REGEXFILE" <<EOT
+# These tests are generally standalone binaries
+^tests/(tcg|multiboot|fp|plugin|uefi-test-tools)
+# BIOS sources and third-party subprojects don't follow our rules
+^pc-bios
+^subprojects
+# plugin binaries are standalone
+^contrib/plugins
+# the ebpf tool is standalone, and the skeleton header is autogenerated
+^tools/ebpf
+^ebpf/rss.bpf.skeleton.h
+# These files just include some other .c file and have no content themselves
+^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+EOT
 
-trap 'rm -f -- "$COCCIFILE"' INT TERM HUP EXIT
+# We assume there are no files in the tree with spaces in their name
+set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v -f "$REGEXFILE")
 
 cat >"$COCCIFILE" <<EOT
 @@
-- 
2.47.3


