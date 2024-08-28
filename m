Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F3C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjANZ-0000Rv-Bs; Wed, 28 Aug 2024 00:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANU-0000JM-6d
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANS-0002dM-Nk
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-202089e57d8so1449805ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724819629; x=1725424429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmKSAgPdEuaidN129B+a5rF+PXzuWPo3dTfBM5ZgjWs=;
 b=kQt11aAOScD633YQwvKEhRWWGmXj65F9S7g3TMhgNjzdS1w6Lcvr//hhs/iyaA27lQ
 O/iosPwMcCQVW4OAlTubBpJArXJmyfMaBmt4hmOWJyWjQKWbkh8v55GyAsD2tPmCGljp
 7qRL2qPi9XWf0HXx7ppS/7yWpy3mugpxr+U5MWB2uL8XmxiOeZ03hPJ9ugeQuadSjuud
 q8Oas05tTMuFAA8KBlKfwjD94nzK0wcCUmkCF084vg8J4Y1sJspMwuZWLISXk9ED35aA
 +dhBuRj3RVKGXlzE4E4QnOJ2b1PUNdSAuMsO22M/1qINFUr9GMUvhOBcuv4zPxzxy/3d
 wFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724819629; x=1725424429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmKSAgPdEuaidN129B+a5rF+PXzuWPo3dTfBM5ZgjWs=;
 b=RVIOwGI6W4lFZxW9j2FH8M/kiATygiHAUcAxcnlYTizbU7d302QRXr3oK0N1w+7t9i
 DZMVqp/vDxjjBccSV47cs7EPS3dsmCvs7XiY9rsSV54Z9Jtbi8acfX7I3I5NCEfunLPl
 jSq7fAsx5I8wGhoU+KEYgwKhoQH4aLJPBx+TDU09ht6SfZ4U7CfdeZxp3mkPTldierh1
 dfKl++I1Vo4V/cFahAsDr3pOHKlR8GdaVqWudic5p4Mrh+9ccz7AmXzFCxV8phxfD6p2
 +fdg46XwDBZxYRvhFsBDjLexw7VYtVpsWBtIE8CzqcoSNEXrZgo4v8p8JLdZtcxBqaOX
 Eihg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7LF9SB01FGFeiyUv06Jo2fBuLd2eAI/g/Z0zDNlKcZru0mNWtxmAqKG8/Ad/NaRCmgbtkipUXT5VA@nongnu.org
X-Gm-Message-State: AOJu0YwNzsJcml7sVlzzWsdyEf+Wb47XgAG19dnrPuykaI8P0h9H3cPP
 E1LpGKgGwwBAidf+kJrdmv0WEZ0klhIXomzg94JOuR88U0VEO/Le8wcHxg==
X-Google-Smtp-Source: AGHT+IHQ0pMWGdx7R1XbhTeblGbSI5nEVdA5B7wefCynXbSADfKkbdv3jVHfz82jlKKiVYNmtui0Tg==
X-Received: by 2002:a17:902:e542:b0:1fb:77e7:27b2 with SMTP id
 d9443c01a7336-204f9bd573bmr11133225ad.18.1724819629299; 
 Tue, 27 Aug 2024 21:33:49 -0700 (PDT)
Received: from wheely.local0.net ([1.146.81.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f093sm90342325ad.63.2024.08.27.21.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:33:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] chardev: Fix record/replay error path NULL deref in
 device creation
Date: Wed, 28 Aug 2024 14:33:34 +1000
Message-ID: <20240828043337.14587-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828043337.14587-1-npiggin@gmail.com>
References: <20240828043337.14587-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

qemu_chardev_set_replay() was being called in chardev creation to
set up replay parameters even if the chardev is NULL.

A segfault can be reproduced by specifying '-serial chardev:bad' with
an rr=record mode.

Fix this with a NULL pointer check.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: Coverity CID 1559470
Fixes: 4c193bb129dae ("chardev: set record/replay on the base device of a muxed device")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index ba847b6e9e..47a744ebeb 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -721,7 +721,7 @@ static Chardev *__qemu_chr_new(const char *label, const char *filename,
 
     if (strstart(filename, "chardev:", &p)) {
         chr = qemu_chr_find(p);
-        if (replay) {
+        if (replay && chr) {
             qemu_chardev_set_replay(chr, &err);
             if (err) {
                 error_report_err(err);
-- 
2.45.2


