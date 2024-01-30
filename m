Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71245C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUizK-0006bH-0s; Tue, 30 Jan 2024 02:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiz8-0006YS-Cc
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:46 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiz6-0006q3-Oa
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:46 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5111f9dfce5so95381e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601402; x=1707206202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mg6TyjShrpYfp/GTDz24AlcIXELpEOEnU861NNLRkZs=;
 b=d4ZrMkXyoYlgIuTYX6dClIiGRF/Bmn40CV03uQMsMdEJz06C8d9x7znqJjq92soX7d
 jdn8ikQXtu0XtIZPmGaT+5oReg9L7lB73teBackYHaouxjm8PvMYRP/nd5TCqFSuw5GC
 y9GS3dGvcbiJd4iCjrsrIDyseoHUz6gnTB4SqTPFFkRNdD1ooPcHyztLhKyyXcCYR8e2
 Og2XKZY0JoT9YpwyCAhIZyeJVyvY5u18CfmF6uXBY0cyin6NdzWpN8jWzyJnYmOa9s6R
 n+/hUMUIn/ZRzzW6PupphhEjU+tLl+Op6YExiJr+r2y31Orzm8HpjSuufJTTY3XzSye1
 17dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601402; x=1707206202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mg6TyjShrpYfp/GTDz24AlcIXELpEOEnU861NNLRkZs=;
 b=bdQ93q88JqySDqqb83y+6ZGFm+jaHTR5ec5S2aacwkjD1UL2CLHpKCwbYSIDoXrzfy
 h9Ib7fWHqMJkG0QSRXUOa27r26/4rkjaVx+dIszqAUoCevXBjSr6kSy6fxP8ejwMeaT/
 JC3nPJmreuP7eX5r0+7zIBVYBa1AcUjIuGwl9rJ1iOMeOvUVUZMPA+RuAzucSczFiWRU
 u61/8tEXCIkksJU5m7DngCs6KBrGheC4rGT2qdkSLnf3YRS83Ja2zXHgrr+uIZaxv/E3
 tn/qk4A0q/1uRpORA2C7Xl1Zf7ku4o2uuen19OrbMNYX2bt5uqaLwFyoo47LIr2OmGel
 QbGA==
X-Gm-Message-State: AOJu0YwWTMSD+GveKj7CE3ILtgOE6zmMODsIxhYt2jSKOl3J4hJsCe3J
 fOcG6tZ9CA6Pl6O+igSVTLTNyw44njqld5tJ+d575Ch9im8uZd6JuErWbnEs34gHSUfdEk1VDMX
 BSrM=
X-Google-Smtp-Source: AGHT+IFR5vb7X49oLy8H7v8znuco79+GSYCM+6dH1z2l1+vjPkwB6R5U6FIJmAIXi/k7kMrFsjykQw==
X-Received: by 2002:a05:6512:2209:b0:50e:4098:3798 with SMTP id
 h9-20020a056512220900b0050e40983798mr5936742lfu.60.1706601402146; 
 Mon, 29 Jan 2024 23:56:42 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c138b00b0040e76b60235sm16133400wmf.8.2024.01.29.23.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 23:56:41 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v1] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
Date: Tue, 30 Jan 2024 09:56:15 +0200
Message-Id: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Check if a file argument is a cover letter patch produced by
git-format-patch --cover-letter; It is initialized with subject suffix "
*** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
exist, warn the user.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7026895074..34f12c9848 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1650,6 +1650,20 @@ sub process {
 			$non_utf8_charset = 1;
 		}
 
+# Check if this is a cover letter patch produced by git-format-patch
+# --cover-letter; It is initialized with subject suffix
+# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
+		if ($in_header_lines &&
+		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
+        WARN("Patch appears to be a cover letter with uninitialized subject" .
+             " '*** SUBJECT HERE ***'\n$hereline\n");
+		}
+
+		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
+        WARN("Patch appears to be a cover letter with leftover placeholder " .
+             "text '*** BLURB HERE ***'\n$hereline\n");
+		}
+
 		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
 		    $rawline =~ /$NON_ASCII_UTF8/) {
 			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);

base-commit: 11be70677c70fdccd452a3233653949b79e97908
-- 
γαῖα πυρί μιχθήτω


