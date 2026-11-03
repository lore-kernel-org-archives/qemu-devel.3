Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B5606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LYwMfSjF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIFb-00071y-VD; Tue, 03 Nov 2026 12:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFU-00071M-SR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:41 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOIFS-00068i-VD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:24:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so3672934f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726676; x=1794331476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xMCHwKnN4nf56y+k3okWy6Tb+1Onlv15OMpHXyxcD80=;
 b=LYwMfSjFV9YFoWCO52c8sBT8unmz1lZuuqq7H0Do3+KYao+oujCyfTKu0Daepj0TPF
 ccIs4mJZvqpMqcYx6XpXtbIENaxwuKmiMRQeSiNK+BDfG8bLkNX8Yq1PgOTZf9pCJV7w
 Bedpsg8GD27T/7q5heahSQf6V8pFgKzl9xq81MofneaL6FoadpkzKfUIrJoU+CYoLFkp
 68OjDQKn3RQXLC3s1aEQ8keiPXsmnIc2WWgng7uWCcIMK0sU7Ll2tghIYAVb9yFjCie+
 AVU+Oz+DRG47IhzDQnfVM+Cz3tc6Yv57zjysQs9adNsBzh7RNd1rSmN9jLElSFf3aNbH
 Co1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726676; x=1794331476;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xMCHwKnN4nf56y+k3okWy6Tb+1Onlv15OMpHXyxcD80=;
 b=h/5wGv4tfWL0h5MmiOKOULRiYim3uVGUdBd3jL5xeCAkiDf+X+y7P9oKbftVhEnLJa
 P5/rRKJSzbH3YJIUpWnXAM6jkw/owzkO1H72HP09klvZ85bGznckGbUNdGKL2oIr+NEt
 noh4cpNAHrFFWIutu0KBSuF8f4oVnhSiO+PcaJPeSaFRAHKaH92Rq6cAp84kYV22dwqM
 Z7V33Yj4FltGZY/xQz5hdFzvLbqPySJDKQho/cVXasfBhJrFAPeEbaxf2AM4VNdMl5DP
 J+nrxaqPpcV9I0I9I6+4vuybzGpUvlh3TBHvkqq3Kz626SdoTEJaYM2O9VTvkFlHYHJI
 gJkA==
X-Gm-Message-State: APuU4Z961Jus7jL2ctHZAIW93dSroHbqyX5Jf/NkXd2I6nHgVZ6mkA3p
 5uY5PZ/KE9Rga7b0vr6LOqe+omJzQWKYcjfWLwhwcIGrd54FpkDSmyC+JSS0k3/lpic4xVo38Mo
 kA7MG
X-Gm-Gg: AYBFou0ZioRsx8gTcmRQ40Y6bZzvM6w/Sh/zR9lzMX8J949THEMz5fd83LsMwZ9KfRW
 3OEiMPgoF5j0fgjJlGJ/c66ZBku+O2XB/ns6h5JWUr1B05awbkcnmrs31cnkUe2Jv+O/2EHmWml
 zoT4XcSfsSxJi6O5KPS3zVv4BdAdVM9v0Y3AZrlzeG9KENEI5nJ99T8Ay6FdC45GV7bUXFftR05
 hKk1FM2f+oXJPvmyUV0e9mSs1m43AitwC7arL8anQOzaluEGDx2IM5Iv+EG/yvVFmb5I9fMrOb5
 qCFeOxVYHdmasvW3Ngq49aBAlD3refKO+cOkeFzcl/X7yk/Y+c6IWXz9v2Eb7E2driFrZqHxq/u
 hv7zJWFD8zlqnYAlwMRGhYD5uln9jASJY4BOMMxODm+vFc+AqDj5o2ekiV0ypbta/H1pXhNOCDF
 u0RFX8EUIPhUg0tU3+6JOohqH5GGo/ABgqKEzU9b/SYtNDzhzUu1QQ6x+sqDSx+WPgQmA5StD7m
 f9rFttFLoXkGgHEEUFbfUiSP+F71iHzE6FNdiwjxHIJylaGhZa2ukorFRI8+F0lYrY1MfQvP+3p
 Ohs0uHOCcShRy17bB9i3aV8DK9+x
X-Received: by 2002:a05:6000:4312:b0:48d:f02e:f7cc with SMTP id
 ffacd0b85a97d-48e6e2ef791mr32694716f8f.24.1793726676228; 
 Tue, 03 Nov 2026 09:24:36 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae0f4sm23338264f8f.58.2026.11.03.09.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:24:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3247F5F8DC;
 Tue, 03 Nov 2026 17:24:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 1/3] scripts/checkpatch: validate fixes against upstream repo
Date: Tue,  3 Nov 2026 17:24:29 +0000
Message-ID: <20261103172431.1180482-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103172431.1180482-1-alex.bennee@linaro.org>
References: <20261103172431.1180482-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261030183054.2875292-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 82f62f60212..e7514a4a9f5 100755
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
 
@@ -1913,9 +1944,12 @@ sub process {
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


