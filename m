Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ck6MtPMo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrNj-0000o2-Hu; Fri, 30 Oct 2026 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMrNe-0000nc-2U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:31:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMrNZ-0002jC-UK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:31:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so7057715e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793385064; x=1793989864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0fnUkp1wZhJNe3Qgp610SARInoWUVhgT3OQSHF12bJg=;
 b=Ck6MtPMopb7WxIgKy8YWv1a2wsXBdfZFLNsghVi/qhBkqT9nLI8lUwSVL/yEROMc80
 DT8gb698xVkqU9keclgfyME068imOIJyBMRLkLveFLibiKctx1J8qTqiNtYvG4qPBGP0
 lPwZixwPm9YfpxLEj+UVBZKLHKU9fsDgarXhwfrjYIO4hAuoGYE183Ns7oX49sMrD9cz
 RnUJ/0IrgljeIF3eyNSDX1ykAS5EY3zNHPSAA9vL3pqVswyoTMeS8oCbPXypw4a7R4Rn
 n6JwRpqMnFKLPG/T2UIZxvFHbjshyFRO/1CFpioi46KospSeY77qEwOG3O7iXfgYMCWG
 tAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385064; x=1793989864;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0fnUkp1wZhJNe3Qgp610SARInoWUVhgT3OQSHF12bJg=;
 b=ZAvsD3ZQasutL4gWxxWZ9LkpBcKE4eK8BEXdv3C6W76VBnaog0J8sJy00rULxfdTK6
 kcx2P+qvuJNU8jtadK4nok8O1u8Lk/1v/lXwrZBGchcijbKWtY2KtPwjXJnxoG5HZ6ks
 u6ng0kiMSp8eIXR7sTQy9jf66yPTRtdBI18Y8jdfg9fcZF7iW9SrDTQm1ahtU3kQldzt
 E6h3vcpR/JzCSglvmH/JOX8Eef6TNjq7coUGtLABlbHW2JD94O+0dEDa2SGXvtkA3g95
 VFSRr6eHHA9I5IkaaZbJ0td6f0wsFqCXN6Jl7iEX4od/T2PZ4k/R8XLxnMyxHrH9HWxe
 /UCQ==
X-Gm-Message-State: AFq9FYKcPlt7fio393H1rxpa5RP0JF1fFXnnUpNuIefXjeCGzK/Ve0vs
 EOA5HzNbrokfEnUHGTt3Kqp4hiSUTTzybYe/3GJ2Yv7wCSZHamDXgyMstabGfFnGWMY=
X-Gm-Gg: AYBFou0GMO1Sw5K6dvqjLn+maLUmE3tw1RGfkuylaIjLhg5GbPedLcZvX4XERv9Rkp3
 A6xxQNL+HhE5+e5SCXonbC9qIjjltiC1T4QQwOWjB8XbVrf8oKE9W9TpohgL+QP/y/LotCd9RX1
 XqI3cZxQawa90bUu5TFpU+nTOM1FvoBj2N4ZulukFoigtaSULbEfwU30uHclGidN1uIpggPxuIP
 /5aX2B01ej28WVnBry8XOwa+JX1HN00pSb7J33ZZ9N7KCAAHQFhHMTPW1hxjyZXDsC5RQ3kzsOD
 zP6++sxUy3fl7cwUFCvX5K/qTUwygtLeAXgXRJcqMLtiLp8KIEvAJDun5GXInhO5XDzUHJ9gCl8
 0lm94QdIr9BhaSoPhnPRbwqKWcttAPLEnP+sYh2Cru5LY497CMB61KuoUFmUl9zPj7ojJc2HitL
 JkIVGgEHY0PC2Pe4ib14vRg62mWst7nZYKQNlwJezAuB4Zmj3yutRtm1tB8llHQh4pCnL3kStyU
 TD1onqDQEV/uObVFYPRaXrNe4fycFu8wfmA1dJw63sYbN2g3lKskNRON6UWLUWrGyliL/LPrYDx
 SIFqqZttI4gViQCC5tOmCdk+T2Ny
X-Received: by 2002:a05:600c:4ece:b0:4a2:40:8d2c with SMTP id
 5b1f17b1804b1-4ac17b2c396mr68770795e9.26.1793385064136; 
 Fri, 30 Oct 2026 11:31:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723bfsm4423079f8f.15.2026.10.30.11.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:31:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C26295F7FD;
 Fri, 30 Oct 2026 18:31:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v2] scripts/checkpatch: validate fixes against upstream repo
Date: Fri, 30 Oct 2026 18:30:54 +0000
Message-ID: <20261030183054.2875292-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current check for a referenced fix commit relies on the developer
keeping their master branch up to date which is not always guaranteed.
If you create your branches directly from the upstream repo this will
keep failing. Besides the local master could be anything.

Improve the logic to divine which remote is pointing at the upstream
repo and use the remote master to check the fixes.

checkpatch complains about the line lengths but this seems to be
standard for the perl script so I didn't try and fix it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
v2
  - drop hard coding of remote in favour discovering it
---
 scripts/checkpatch.pl | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4984a258ee5..cc311684d66 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -586,6 +586,37 @@ sub git_commit_info {
 	return ($id, $desc);
 }
 
+my $git_upstream_branch_checked = 0;
+my $git_upstream_branch_cached = undef;
+
+sub git_upstream_branch {
+	return $git_upstream_branch_cached if ($git_upstream_branch_checked);
+	$git_upstream_branch_checked = 1;
+
+	return undef if ((which("git") eq "") || !(-e "$gitroot"));
+
+	my $url_regex =
+		qr{(?:gitlab\.com[/: ]qemu-project|github\.com[/: ]qemu)/qemu(?:\.git)?$}i;
+
+	# Scan configured remotes for the upstream repository
+	my $output = `git remote -v 2>/dev/null`;
+	for my $line (split(/\n/, $output)) {
+		if ($line =~ /^\s*(\S+)\s+(\S+)\s+\(fetch\)/) {
+			my ($remote, $url) = ($1, $2);
+			if ($url =~ $url_regex) {
+				my $ref = "$remote/master";
+				`git rev-parse --verify --quiet $ref 2>/dev/null`;
+				if ($? == 0) {
+					$git_upstream_branch_cached = $ref;
+					return $git_upstream_branch_cached;
+				}
+			}
+		}
+	}
+
+	return undef;
+}
+
 sub expand_tabs {
 	my ($str) = @_;
 
@@ -1914,9 +1945,12 @@ sub process {
 				}
 				if (which("git") ne "" && -e "$gitroot") {
 					my $hash = defined($cid) ? $cid : $orig_commit;
-					`git merge-base --is-ancestor $hash master 2>/dev/null`;
-					if ($? != 0) {
-						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
+					my $upstream = git_upstream_branch();
+					if (defined($upstream)) {
+						`git merge-base --is-ancestor $hash $upstream 2>/dev/null`;
+						if ($? != 0) {
+							WARN("Fixes: commit $hash is not an ancestor of $upstream\n" . $herecurr);
+						}
 					}
 				}
 			}
-- 
2.47.3


