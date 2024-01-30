Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F85C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl5W-0000ox-S3; Tue, 30 Jan 2024 05:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUl5U-0000kZ-UO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:11:28 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUl5S-0004P8-8n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:11:27 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so44792835e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609482; x=1707214282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5EUAE0+fS+8pdEoClgBwkEwH6Z06aSX0F0hkIKyDRD0=;
 b=l1/NR3NGWADkPC2WyFcswLp0HVUgb5Bx4OIwz+G8f9S6vi+doQaGB4ts+1ay9a1quq
 uZxvTKuIe9fLLeO8vVX5nE/rDFCDlycDihyBrVCsW+Ub6yRdi+c+TwpuYmYpFlTo1qir
 W+OFhw/NpinFB2LUqKd+wTvfHL6ufp6vbDcR+KRTduozk2C/qevXKKQYFSQGovhydki8
 raOHWCi3EL2v3ZRtCT2NL15Ho7LrXeDGz2B6ESZ0bktwJUQDhhoQ1MFTgmKtZO91PRYD
 YuUwXTj9CURSHkd1rVNqDTKwkZPR3Q5EAHPoGG1WMf122+cecKHeUie8kPrNniC4aD/d
 S2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609482; x=1707214282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5EUAE0+fS+8pdEoClgBwkEwH6Z06aSX0F0hkIKyDRD0=;
 b=QqKu7HJCBvDmDTa+pw4SaBkE+FvC/JvwirZoyrFugZTuFJhsw4BS4ZBLJuHRbcf1Vv
 BXUqTsLZvSWjUAKb9ajwftHRZOWqBNuWxUOqfvehilFxbU4fL0WtsLEz7NQ9EGEHOpmn
 gC6qV40C1He72F5mHJWT1gSisMsLcDBmmPRk/nq6/+331e6RvWnt3cOzTfAikSQFRx2q
 WADVrsSRypdKb5aKf0t3a0w/Bc0tu1TBUBHHGAt6OVsbmqaRMQFsJ1feIHkaQ65JkuJb
 8K9niFxIpBSCXB4PdjvAPR/LcMcBfwJnOnhprzzJeu3olKADYe0iY5huNyVScsUeVOEL
 qjbQ==
X-Gm-Message-State: AOJu0YwWYxs6maSLm4uVo7LR5fjBUROy2pwnxUZG1y/hRJZug7aX1zmA
 jHecSBFSVLhmCNRqYR7r/gfeFzqmCJKEVB92CK9tV56MflPI+qoiHXoq8vqc7XgaTnUiqazhRSp
 UK1U=
X-Google-Smtp-Source: AGHT+IGAeQrfCu9Yn0Nh7ilmryi3jGTNZzZaj/cOB38f82KA+fhXJYxDovzFQiJOgG/Yf+eR1nV0tQ==
X-Received: by 2002:a5d:59a6:0:b0:33a:fdb8:c616 with SMTP id
 p6-20020a5d59a6000000b0033afdb8c616mr301592wrr.26.1706609482160; 
 Tue, 30 Jan 2024 02:11:22 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 cx16-20020a056000093000b00337d5cd0d8asm10306010wrb.90.2024.01.30.02.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:11:21 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
Date: Tue, 30 Jan 2024 12:11:07 +0200
Message-Id: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
Range-diff against v1:
1:  64b7ec2287 ! 1:  9bf816eb4c scripts/checkpatch.pl: check for placeholders in cover letter patches
    @@ scripts/checkpatch.pl: sub process {
     +# --cover-letter; It is initialized with subject suffix
     +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
     +		if ($in_header_lines &&
    -+		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
    -+        WARN("Patch appears to be a cover letter with uninitialized subject" .
    -+             " '*** SUBJECT HERE ***'\n$hereline\n");
    ++				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
    ++			WARN("Patch appears to be a cover letter with " .
    ++						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
     +		}
     +
     +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
    -+        WARN("Patch appears to be a cover letter with leftover placeholder " .
    -+             "text '*** BLURB HERE ***'\n$hereline\n");
    ++			WARN("Patch appears to be a cover letter with " .
    ++						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
     +		}
     +
      		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&

 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7026895074..9a8d49f1d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1650,6 +1650,20 @@ sub process {
 			$non_utf8_charset = 1;
 		}
 
+# Check if this is a cover letter patch produced by git-format-patch
+# --cover-letter; It is initialized with subject suffix
+# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
+		if ($in_header_lines &&
+				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
+			WARN("Patch appears to be a cover letter with " .
+						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
+		}
+
+		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
+			WARN("Patch appears to be a cover letter with " .
+						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
+		}
+
 		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
 		    $rawline =~ /$NON_ASCII_UTF8/) {
 			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);

base-commit: 11be70677c70fdccd452a3233653949b79e97908
-- 
γαῖα πυρί μιχθήτω


