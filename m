Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DDCC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wmq-0002BG-0Y; Mon, 06 May 2024 07:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmZ-0001rI-18
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmW-0001vv-MY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WY+P13fomWYQhB4vSdw0hSoUKVFP4d5TPh/QOK/Wn/k=; b=K9ZPkyZsqvYWsK2zaLTiGRAzig
 2kHrJhq6lbY0E0+hiJz58crO/lMtfjCOpfg/p6f/vnYGh6LkHwDKZTAqK/xLAZytkA9inA8NCxTvc
 TRtxJ1698Mp5Y4vM3ojy1fEXLn0epgwdQwG0JONECIe6pCLiZ1vab/Feqc47tBmUpyERYSi/FUo/N
 PdyHzfHu7xqUITND5F8N4UerS9ulXb+MtOCG6seMiXF/0HBujrf/ETbAXxIEKJuj+jB6cPl+TSSKw
 zFP0h6gx+c0ar9evMF9mJ31oebfKFoKBiHz7jbBGtPkdf4sY0/AfmSrgdapXE5pnhfKabBFShGvzE
 JmMT9KpG6kSZMPzPn22vTpL7MHaj04lN/SrB0VZbu7Fzl5Ltl7cndqACJ5MDX7FIYkrAPI4euY1K9
 firCKmaE/CUiizsyXYkkq5Pz+tf3IdZyWNiibkqYKROSgtaazrVEsmP1UBgQms1KD5b0LA49FjfXf
 KoS1awX5F53FAJvxF4S5vYDm7yJd9XUvLJq7ZmPsSnRWICL0w2u8qMI1umE42KLHrZAsbhvAPaOwO
 3n1viGiofnVRfDOXH52/rizDMJBN5wNWhvy2LMzHrv5NqdE2rK9jMZg0SyZWmgkUuXxKXdKqCpQVR
 pTmvJa3qwkMvpXZxkEtfU3a6MF0Z9BGMmNXq+UHvQ=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlO-0005pA-Ow; Mon, 06 May 2024 12:44:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:43 +0100
Message-Id: <20240506114451.331311-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/12] docs/about: Deprecate the old "UltraSparc" CPU names
 that contain a "+"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

For consistency we should drop the names with a "+" in it in the
long run.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240419084812.504779-5-thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b8aafa15b..03f8b1b655 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -194,6 +194,15 @@ in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
 an alias, but for consistency these will get removed in a future
 release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
 
+``Sun-UltraSparc-IIIi+`` and ``Sun-UltraSparc-IV+`` CPU names (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The character "+" in device (and thus also CPU) names is not allowed
+in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
+``Sun-UltraSparc-IV+`` are currently still supported via a workaround,
+but for consistency these will get removed in a future release, too.
+Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
+
 CRIS CPU architecture (since 9.0)
 '''''''''''''''''''''''''''''''''
 
-- 
2.39.2


