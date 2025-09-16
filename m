Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1E4CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZ1t-0001Rc-86; Tue, 16 Sep 2025 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3e5fJaAwKCh4H45CB8MN894HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--nabihestefan.bounces.google.com>)
 id 1uyZ1r-0001RM-K6
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:59:43 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3e5fJaAwKCh4H45CB8MN894HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--nabihestefan.bounces.google.com>)
 id 1uyZ1q-0007uQ-2a
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:59:43 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-32e3c3e742eso2046725a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758041980; x=1758646780; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uo0jnLsh0CTY23ZcYpeRBDnkRUdvhcZDFacymbbQOK8=;
 b=xCcqSK8A+++K3/qba3gB0Ex1NpU9w1jah87H2vxttZ64o0jyZJVFAtRZMPaxSa2hGq
 pJtrmpbqj3ugEx5O0qZhbxjCH26hBhJs6YD9vV13ATV91jwk74lOcaum+xlcpFIkm6oj
 2Dtp7/DyKPhmE9s2z+qBsw6qqF4Ao4y3gLqa3zPEECra2E1MzXmdeUwTJ6X+m6IPLUbd
 txyqIQtVuRNQBR0ddO0zPyhDQh1C6cMKStOX0qEsc1QTZlUsqHGnj1xRaAC3vw/joqha
 BJ/waqNMkzcshCRdya2JqMnxKHxV5vDFdrAlWvZlIsQCBZvmQgCzvDpl39I/RoYXCA1C
 M3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758041980; x=1758646780;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uo0jnLsh0CTY23ZcYpeRBDnkRUdvhcZDFacymbbQOK8=;
 b=EfU/yCO7Ex9f7IAfMKQLP1FPUV9WFZPXtki24678LxxTkIStmtFZBwh9jZjl8TmObu
 5ElFMJqRy4bjxbC7eunJ1v7bRY8+zghN4Sl79jmP/nmNjEvrT3mchZyyYnI0P2NHx1ZE
 4RNoPhNF+Yr7uhTHpkNb/l5hCa0PXWJLKjuop9qgyBMI2+Xx+THXkmVHuIa24RcIGExX
 4zmV8uGrhZvssh279zWDA5uy23DGUX+Eo0Vhi993sp+O/vNAx+dnDPa+xoMKYCCfopas
 GkEsINT9NBfv4lNseT/Zh1S51aXk3DyRMoND2JgzumSFpGGu/jtj3Eta5nMuETqGZmwT
 yC/w==
X-Gm-Message-State: AOJu0YzRvODvXCRG7J0VDSHcvNIVBf2l41EyyjEoXb8uWOyVDIr/jxm3
 TgWEibEEs+Uj6cGnGAt/+UT2pvvzCj8L8gxjTPJGzF+hj1Qva+wLxBXbiX8/nfAJTdXki0BNC5Q
 lA6Pmc724zLVC+3H+9fLAsYFvXWWEy3nafTgC8e/CiatPHf9lIrOA6z/058e0OS5iRxus8alL8e
 lJckjQbIAxW+xqHx6BbBoUfSnGn/bM6I7ZxnDna3Ujk3V1wcaictkvbk7iZFHXjRoYN/Q=
X-Google-Smtp-Source: AGHT+IH0LDz97ySoJM56e7/ZhtjWDG4FspFSjfBz5DopiFqIRb+8Xp88OcbLcNmtAU9po54QwG2yF6gxdU9MaQa0RVA=
X-Received: from pjll16.prod.google.com ([2002:a17:90a:710:b0:32e:aa46:d9ab])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8e:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-32e64caea02mr10935223a91.15.1758041979927; 
 Tue, 16 Sep 2025 09:59:39 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:59:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916165928.10048-1-nabihestefan@google.com>
Subject: [PATCH] checkpatch: Ignore removed lines in license check
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org, --save@google.com
Cc: peter.maydell@linaro.org, berrange@redhat.com, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3e5fJaAwKCh4H45CB8MN894HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

When running the license check, if we are updating a license it is
possible for the checkpatch script to test against old license lines
instead of newer ones, since the removal lines appear before the
addition lines in a .patch file.

Fix this by skipping over lines that start with "-" in the checkpatch
script.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 833f20f555..c57a423f9f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1813,7 +1813,8 @@ sub process {
 		}
 
 # Check SPDX-License-Identifier references a permitted license
-		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
+		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
+			$rawline !~ /^-/) {
 			$fileinfo->{facts}->{sawspdx} = 1;
 			&checkspdx($realfile, $1);
 		}
-- 
2.51.0.384.g4c02a37b29-goog


