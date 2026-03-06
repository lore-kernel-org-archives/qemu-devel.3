Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3811BF0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwj-000132-NL; Fri, 06 Mar 2026 07:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwX-00011a-NC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwR-0005NC-8e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so74671585e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798761; x=1773403561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eEdxHx/MYaylIgCmT/PvE2eA6pbDzqqZ9LnFxyLu8WE=;
 b=hoUC99M6v/DcTdYzt4grRis/IgoI96lEsoomhJuviFhjxyeyLIsHEAkzz/+HdUgvN/
 1ToEmHH6LwQVVKASjEEVH0Sjulpv6NNZWWYB8sK/UTmi6haq1wf3UgpsSHkXhJLN9fCT
 eXKD+oeF7KX1HUWIIcC3U+VM9YqvPrdmTtRt/ufSLXc6KWBo6YINbn08cTMXP4YAVYTd
 ln7zOjQO2AePN0GYsYe/NeCy9HyImfzXxgmkGckZMUiaMVbkIFTGebnAqTv80C0rfjvI
 kwgFUwI33VCMUI9SmiB2l3u6kZ5zPsobLvwGq2c35oC3/DdWO3nlcT5wWRs410TU9kOk
 uyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798761; x=1773403561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eEdxHx/MYaylIgCmT/PvE2eA6pbDzqqZ9LnFxyLu8WE=;
 b=ibnkoud31eXTcHua1E+YDEaZYzOCRuQo4ePTQAnTBnycYRqjgBgrFZOCzmeym/WDZh
 IGHMS1YnGLBn3DzUg6Gm9SEahEQgyO6O81D/35yPGcG9d1hHVBi/ftJ/QfO8eGxx4CKY
 kNcx7sxOVWNKEBHwHjBsPwHYCskMiC4f+4mOjsrWwcLZIhSZWrykN7a00uCqFQUSxu0O
 44jQUsMcjxSDxf1w58aWOdSS1mINOVl6kafl9mKLd154iyQE4pgSiz8W7sQYxn2EhLOe
 cRcY5e1TfbVWo3lHvIPqDx6LWn/45YGRjumMtcIZ0ghSm1dj5u6jK50kOGO9liL/DQqI
 0D8g==
X-Gm-Message-State: AOJu0YwVmrdflSh1NTR0roiHKgg6186tgDpJL8ejBumKD+7nJg2MWLkl
 Lsa2Q4cAev5890rXj+RibmN6LR0Co5vsTx2VThikotrBru99zfP8zKMxD9qKReIgY4l4jOoY2y7
 xXKBA
X-Gm-Gg: ATEYQzxVmg+FvIqn1YhYP5vldJ0SApd1Z6PiFo5mLknxGJipr3Ge8shbwZ4qxA1n3r4
 N+LiSKoMtn+xkOUFHFqZqf2hE6KY9uJMsCxO8y/VuLTr4seMCAarEyqazANbVeuai8Y73oe/cZf
 Rdfpud2FNuRWdhFWjWF7cziT+SQZ8HKJV/z/JOSL/ZzkVKHXejbSripCrsMsRi2xCd5errsul8I
 vPN6lH6kqkliKcNesqYNl9q7C+jhc62yNmX3N+XKnfDWsRIISFiTs4Ct5rmA/22uHwiQt3yX/Dc
 zfQYumexp/YWKX/K3nIvfXkxqUKBxmsh6x+H0J2R/zYVQll6yo12/f1BCeMWYA6nlaqXmvaVmsF
 mc0yP124SflrpNtLJkzvPXTR+YgtMnorW+yzyD6CRSVO4XVjbTozU2B38xe7xQDlBrG3mJRqiji
 GvVWnsIwa9hndyT1i0ZBZIr21WPLGuwNyhKbbWsiCswgenuz1CEtIGlp376EMEEkDQqI1hpRM4x
 NGbFZudmnb0Pa0DBA1S0a8frLbMWUI=
X-Received: by 2002:a05:600c:45d1:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-4852675e55cmr30337295e9.16.1772798761435; 
 Fri, 06 Mar 2026 04:06:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:06:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] MAINTAINERS: Remove Andrey Smirnov
Date: Fri,  6 Mar 2026 12:05:54 +0000
Message-ID: <20260306120555.2035421-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Andrey Smirnov doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8f68781df..37c93f0611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -913,7 +913,6 @@ F: docs/system/arm/mcimx6ul-evk.rst
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrey Smirnov <andrew.smirnov@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx7d-sabre.c
-- 
2.43.0


