Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592DD4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj8p-0002hm-J9; Fri, 16 Jan 2026 07:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7e-00024l-BX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:17 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7c-0004gN-Ag
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:14 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1092171f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567210; x=1769172010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KN+lrDtvcoD0t44FkK1BzJ0aGWxVs9RvRDJZG5q+Rs=;
 b=ImP2sMAXKoBcGyawuFj2ryE7M7UYP7bu4KAU/4kltcYlvD0FZX2W0BJc+zGrsWIUSX
 lQOyiFnd24xhP40TfUqwVQcp2EyND9Aj1ZzuRBrhPmkvYdWDnn7FlB9Q8w1BET6sMAba
 VcyithCTzMOkGhg0EGbPVfyOLiN6Ximx2h/x1W3OF9byyKZ3LHgLCYZBciwUMMy3+o4F
 Pj9PuvhnRlQ2a8b22g7fGfEGwTdX4QyYpWAmi+kIZVtUZpkNm6MqHahKZjBQ70myB7ci
 jqtbVM+rwUSmRcxQJ0R2IViav4yNFdhB5yb7UYFdwFczVr5hCFUHd3LkUT26+OObYnr0
 BrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567210; x=1769172010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KN+lrDtvcoD0t44FkK1BzJ0aGWxVs9RvRDJZG5q+Rs=;
 b=CUs9VV+VIc2SDGH8QoLi22YvLavkCiG+i+AkNqTg55lPuCPY//DKOCfWCBRL3GZG6T
 xax38Egt/zt0IwQLbn0Y6lLwMxQWLT8I5VTtlZjsPiX+gUdMSBpfL1z5ls3h3LE4vG3N
 vvP6qcWB7EcSL5yZXuigoBbIcr470b+KOcwQRCNVXm0ZdVbwqc1uSR0nFx6JV8aGMjry
 gVwBz0H/5+YYibctKO0WqvZxRrdti8Bb7my4v4wfawzbnzUsagMSshodTKvRI/wKyWX2
 mWa9gvAWDDOKkJJWlQ3RtUpm8jmAePj+WTFX1CDJ4D0CsZIwvvrnW3aZCARhAllcvZ5E
 1iFA==
X-Gm-Message-State: AOJu0YycmwKpUM7B01glfaNxAOi51jqfYZownQTx6GoLAkfYh/JwtsBm
 q3vfPHJ868QQ4zP+7TIgZQDQxEMN/+Lxgn1Z2KCpg0jlHie70r5HiCNw6J9JCQNWehjE+nizqZX
 EKvaE
X-Gm-Gg: AY/fxX51WEzocxu7SRe63hff13SGrvh5ZXZ+8DDC6CjcUEcO22PXQZiVd2AbCGPduyL
 HUenl7ZHqlmfu/rsGORNWuIbIucEwTOVGiqI3ktJ6OjdbjrFJUgMlXInj8ldJPQ4THmmZ5j3IYK
 sQdC2CQPo58W3Jkn1J6rawSoExCQH3T3Zu3QDtmA1F1tD12iGQsTI6FIOTuYGocL5+kDakIKsRO
 tPbRwZ2d4NsOdInmt2WHciA9M8YiYjOMRguXCX7oA89cJWzLtZoB6sQdQbGxK/Kuu26kTXpQF/7
 TNUi83d6dHbcje3vYQvzVfWPqAm/uU0msJ1rWXDC30eZ05MttDLcFpM1t00050FDqUxrpE8nbhd
 qoF+BC6fHmtUpvpQRNpF9PHQmI2WSmfq5E8JovXiYOYwT3st3ggNY0+Vj36OoOCocHBaeH5pQAM
 0PT6uUz0lol249Zd4bCWVFKOXIuYq7GmPgZ+szNjIw+FerecXRuhdf/rJ+mHMkd/VQ5uNqAlhma
 MlyAqjyF03G7jIBx2B2v+dc2+x6+wdEiKY6U0P/dGVbcg==
X-Received: by 2002:a05:6000:2004:b0:42f:b707:56e6 with SMTP id
 ffacd0b85a97d-43569bc028bmr2903703f8f.34.1768567210540; 
 Fri, 16 Jan 2026 04:40:10 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 3/6] scripts/clean-includes: Make ignore-regexes one per
 line
Date: Fri, 16 Jan 2026 12:40:02 +0000
Message-ID: <20260116124005.925382-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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


