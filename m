Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4E31061B1A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hjj-0007lx-E3; Mon, 30 Mar 2026 14:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjD-0007hZ-D1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjA-00039I-0z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cf5ad500fso1875967f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896762; x=1775501562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p8uB8xGKHFafOJAt7VvZZu5jT93acMkkOA2W6vmo5NM=;
 b=aP2GC6Syft03GqE6Dz51PNraQxzhHVwaaJVHGdVkTjTkeBpbeSWzsFc4vHlfhzrCWg
 +6v81YNGfbVmbgD07EVlvSORr/G8EC1AdOA1fghbyrB3pyuFkmLYg8M87vufuyPEvdCV
 dFxyRudItY2HIA88UL8lo6kx/qPVRWP40VulAu/j47q/2wOX253cb8p13nQp5XTJgUQc
 ArX/3l2ipb6CrXQSf1O49SblI4bxxQliBSh8/yDI3yB8nHC4gbsvBl5sZJ2wwMaoG+zB
 LNdD9OqkPRdIFTwegvPjwyGqMtmgupS4l+BPXrTuyhc/x1hD7lJUelpuyhUMMw4Tv3GV
 s5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896762; x=1775501562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p8uB8xGKHFafOJAt7VvZZu5jT93acMkkOA2W6vmo5NM=;
 b=VMWOgverhJ1AAjfTu5n8Bm4ahrvjTsbF3fvfC9wB99YRiTjesp/wBmM+jZHeIKM5dR
 mR9U5FCsptwACaH2q72dwyqO6+7Grhq1cVxjC1JJ7NJMPR2tnxf9rgxRnI2ewqMDwVS7
 5h+uufh6JlcgAJ3VV33V4gfZB5/GoK0yHSZulGjzWr53SWn0f5xypAfgKXlfzW1cuz3E
 98QXh40qcPRcnWOLvLSD8O46hAmlq2qvViiFx+ag++XfGBS4UYWCQD50YCnU7O5VcW+B
 bgyoPB1KQm6eLHzIdfbRHr3O1KhkJRkpLDqHlR5eYMILpS37e+HkARGAImoSLYPKiJEJ
 PG+g==
X-Gm-Message-State: AOJu0Yx3+FsjMJfMXFhyfp6u2bR730ljXU7hfmqqLNMnLSkQVK+hayQc
 nN6E8PgQhIIHRLPnCyfpdCKx4nfs4QlFsno3NT8jvbVfBRv6YWN/yeFxiEFivQOa5NGKWKizhfd
 EChD0SRw=
X-Gm-Gg: ATEYQzy9FJiURsWM8PxoyD/7SzWVOw8OmKudlmcI/GtMRHyAHLHvXcm6jmEjzv7Nqp/
 z1c6mdvyQExjcTUavLywH8yHq7eAPND/7IiDdpWYHQPw2NByap59gOs/RlTIqRe8DnEP/n/72sr
 g5awkHTY0xzNNja32HjkKuyNWlbK+q8BJwGzJDXKPdMd6a9W+f363qZD//SNYHjlTrgH2HGicxJ
 8078BZzZ5RnNY4BaKUFuF/WITVR2TSv6epvphN31eqiMwwFG2l05u4Io8q7ZKeh2J0TocpbeDmF
 mwjlVzvn8EezlEnSGfZxW1pOO174si/uiWA0toPW6X3Z6jqsW1sBT7r1MXYHv6JCCrsMKEE+plk
 ZR06ES+SlYLAk9lojQp14bJlckgmg4M9/2SnlkjHx1Omb1bk/bNn0iwLhTIcgdsnPObG+EoDKM5
 HVRrv1NGnJboxGE0AfSCCvtWT4fnmqbIqr7+2uhw17ve1ERE4dryZmCXzrHoJq4FlQcAf7rMSdl
 W2GVTRCerlNOF6jCbvtLzuXCSNSi74=
X-Received: by 2002:a05:6000:2911:b0:43b:9cff:e32c with SMTP id
 ffacd0b85a97d-43b9e99792cmr22652341f8f.18.1774896762100; 
 Mon, 30 Mar 2026 11:52:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] MAINTAINERS: Remove Riku Voipio
Date: Mon, 30 Mar 2026 19:52:34 +0100
Message-ID: <20260330185236.1905636-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Riku Voipio doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

This moves the "overall usermode emulation" section to Orphan status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260323134741.4114629-2-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb7132e39d..ae356d886f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4054,8 +4054,7 @@ F: hw/core/resetcontainer.c
 Usermode Emulation
 ------------------
 Overall usermode emulation
-M: Riku Voipio <riku.voipio@iki.fi>
-S: Odd Fixes
+S: Orphan
 F: accel/tcg/user-exec*.c
 F: hw/core/cpu-user.c
 F: include/user/
-- 
2.43.0


