Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4BEF46C5B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9nG0-0008Dj-HV; Mon, 06 Apr 2026 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9nFy-0008DA-Do
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:56:58 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9nFw-00052M-LN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:56:58 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b941762394aso537162466b.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775494613; x=1776099413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NWJmgVlUwE1qFAFJNqae54bpxScrAzjgMBEIKKHBwO4=;
 b=U3Bb0wDpqK4qegD/ypIxjebYn56GlUEHkZbktnEwbOOLzeqTqdMRD+x95gQrPS+BZR
 SMBmu1hJfZRBZ06i/eVLcTU2rHkkzSwgJLVd1bdZnCYaPQL1K39MnJ1WApVDrDWnBuTL
 ThNVC1nIwJzY0BVCMcCqGK/H17YF64PuZD435IBsvI10BBojbf47quocyNHV8mVki4K/
 osb9/TPFREkIXXfwwKrdGa+zGSmIY92SGjrZRFir+KocNjxM8m7dco0xoFqDeeVMTTBn
 TTCqSaakYLBnaZYtOppE3VDohj2Il5mZbDCUqgsJz76dDBF84KjqfrTmHFxAz26OyD/M
 OuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775494613; x=1776099413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWJmgVlUwE1qFAFJNqae54bpxScrAzjgMBEIKKHBwO4=;
 b=kDwmXweLjvTb5dAjfbNwaTAuKXsS5chDBbpmq+tjr38VmC1XSYGqnq6+J5mt7nUvQD
 u1FdXdCf8CffgTVjLZzqI9GFBM6UV7qC9ikaM4Nvl0rbj4gA0Foa9ceBOhSTilWl0QX1
 y+D3pTaFvW+2dr0dU7NGpWeucVXOOL2A48LHn/rH3l/NlWiNB57Tx06Emkbb0fckF9/1
 3tRJhKUeGjxP7RTbHKFqYikZ1zQRhbfWvcLLaxWdcPDCMLbUiFvWmnIEXangXcIsBM9K
 0AcJYlLJpWyfy+0YMzpjPKmClJ72BdjGB6XXQWixyfxRPoa0F2UYExvLvsvYJqTGODUW
 V8fQ==
X-Gm-Message-State: AOJu0Yy3kI0J2bie4BJ5x9J2/rB9YvH5Q1sLOw+yMyckBksVPN+aKAhb
 PrCKVrKNOChuKmCc7iTXDeV6HPdHLrUofzd/eA5SSTsxvUDrbIadwaFot5BRpiUyjPCTumMI6pT
 w4gQ218w=
X-Gm-Gg: AeBDieutRuK17Sgly13+wPgtKzfvUObj5aUqXBXKkvl93Et1fIznIaVl8DnanzZcJek
 MYzQ0qrUfuRFbFjOXJ8wuQJLUZ8cURtYnl5Tr4dhidYIvdpLDS7zj/EyXw0bV3T3jxGJIpq20V3
 mSeLhHulJVzTHol3v3ZfgRrugOf9agyKoDgJz7BqAqdaSesH/XQh13KxDtFnl4jM4whubRPjbfN
 BgC/+B5kDQp/O9aswlWa/03von3L40FsKY7nz5st9huhuAUS8xjD3+KRaFKWlKKZIwHwPXhKUxW
 KjH8Fk5+IqFCicZJmN4vTTL2w2zJqmmvufYwbIOol3FwV1XBuRhIURjMzz9RWIUDu0GyUMCYa12
 uCmceaTS7kVbnpUgP3HDnsTCeDEcvaC8ZIXYbElcGtby4DucoXmO89yKjSqh4R5WKPVvfnsWV7a
 96NNRJkVZKh8dTzHjQcAJHOPQ=
X-Received: by 2002:a17:907:d87:b0:b9c:a063:ae2f with SMTP id
 a640c23a62f3a-b9ca063b282mr398164566b.41.1775494612970; 
 Mon, 06 Apr 2026 09:56:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c99fc14sm489461666b.19.2026.04.06.09.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:56:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DE355F920;
 Mon, 06 Apr 2026 17:56:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] docs/system: remove extraneous sentence
Date: Mon,  6 Apr 2026 17:56:48 +0100
Message-ID: <20260406165648.997995-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Lest we confuse the reader about something we are no longer showing in
the example.

Fixes: 132f8ec799c (target/arm: change default pauth algorithm to impdef)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/introduction.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index be387a66458..bec7291e476 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -165,10 +165,8 @@ names so we can override the defaults later.
     -m 4096 \
 
 We then define the 4 vCPUs using the ``max`` option which gives us all
-the Arm features QEMU is capable of emulating. We enable a more
-emulation friendly implementation of Arm's pointer authentication
-algorithm. We explicitly specify TCG acceleration even though QEMU
-would default to it anyway.
+the Arm features QEMU is capable of emulating. We explicitly specify
+TCG acceleration even though QEMU would default to it anyway.
 
 .. code::
 
-- 
2.47.3


