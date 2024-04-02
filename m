Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F21C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcMY-0004RQ-Q8; Tue, 02 Apr 2024 07:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcMH-0004O1-5t
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcLc-0002ZF-V7
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-341cf28e013so3585291f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057433; x=1712662233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+M7VE8UyCnF1C5D1JDY80BLUCW5k0rARqWZanWRzHc=;
 b=vEbSjtvH1B/f3p4NsW81AzUDPJoabZ2DW3obI8YSSeA6YmVcNgZAklJnrscd8tS/ye
 5maVXW3S3y0KlbDkSkNCLBScHh8Y/jFkqBx35nNHJVKFjM+lWDYZLFBI4chmubvv9qpH
 kn5wfc9/pGBZLbM/1siD4bDmsq7cKuBhE+KVnfRwbsKGrxUPh89PKf0yHLdyA2nvnXwR
 z/DqU3XqQq/tbjwAm6wQ5nC7RckKxn+DsTUUvAQfGsCmUweaKlKij9LSST4muaBiWmsD
 7x4y08JqlSGRmcLr6xuzhXc/XOq8nCpQ+DZpWiTwhWWtFJjo4fQ+SX+PGvbNa81IaUUs
 y6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057433; x=1712662233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+M7VE8UyCnF1C5D1JDY80BLUCW5k0rARqWZanWRzHc=;
 b=APTJETtZhSKrvGfCvEJwyozy/egzzMkkawRQLNR1Hq6iDbbJT07h3Gn/Px/EH6ShhD
 yvw4oT7VJrWigZXg9wcx1NViC1opWrp3ivsFjNXtagrhIF8AVw7//2INgHOhETql6xCV
 +6tiT/ZqaKKj2CbUyMTYMx5N1TGxoTpEsWo9yxaeH2iwVmJE1zyNWzU+IUdQrWzs8jgX
 9WjS6pSmo+YC1QUkPqXZbqVTLtwqxoO0WB/T0NHm6X42iTPUS6w1HyZylP8zxZZKI+w7
 cn9nsHNAqALqi2YUY9ZA2dxYJU5kUwpaw8hXz8ZXVLn6BzsnFxG7VZleBxy62mX4rHCZ
 qEPA==
X-Gm-Message-State: AOJu0YxrdhAnMINVPQ6c9sLPaNMYvU5a40Y2mpmyjpU+/2kj3MQ/d1z6
 C1SEpW0ZMB2ukU5f6y7hbyPK76okwU5mK5zHwIZQqalgQFQUCXJCk/TUsXqcXOzyI2HlZ5NTWxX
 USWg=
X-Google-Smtp-Source: AGHT+IGwAOyew2zM2o6o4y6ugSXEp463rpEYICa7IT0aZPARM0pUNK2vE1GTENBGCuIAyT3zsqQd2w==
X-Received: by 2002:adf:e253:0:b0:341:8974:9bae with SMTP id
 bl19-20020adfe253000000b0034189749baemr8793314wrb.19.1712057432915; 
 Tue, 02 Apr 2024 04:30:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 dn13-20020a0560000c0d00b00341b7d5054bsm13997793wrb.72.2024.04.02.04.30.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 04:30:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] scripts/checkpatch: Do not use mailmap
Date: Tue,  2 Apr 2024 13:30:14 +0200
Message-ID: <20240402113015.66280-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402113015.66280-1-philmd@linaro.org>
References: <20240402113015.66280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The .mailmap file fixes mistake we already did.
Do not use it when running checkpatch.pl, otherwise
we might commit the very same mistakes.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4fe4cfd631..234d566172 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -435,8 +435,8 @@ if ($chk_branch) {
 	my @patches;
 	my %git_commits = ();
 	my $HASH;
-	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--format=%H %s", $ARGV[0]) ||
-		die "$P: git log --reverse --no-merges --format='%H %s' $ARGV[0] failed - $!\n";
+	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--no-mailmap", "--format=%H %s", $ARGV[0]) ||
+		die "$P: git log --reverse --no-merges --no-mailmap --format='%H %s' $ARGV[0] failed - $!\n";
 
 	for my $line (<$HASH>) {
 		$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
@@ -460,7 +460,7 @@ if ($chk_branch) {
                      "-c", "diff.renamelimit=0",
                      "-c", "diff.renames=True",
                      "-c", "diff.algorithm=histogram",
-                     "show",
+                     "show", "--no-mailmap",
                      "--patch-with-stat", $hash) ||
 			die "$P: git show $hash - $!\n";
 		while (<$FILE>) {
-- 
2.41.0


