Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10576C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qU-0006yU-9A; Mon, 22 Jul 2024 17:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q6-0005QD-Uk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:03 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q4-0004Na-I9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:02 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81a90913cc3so123678839f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684699; x=1722289499;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x//+WoaO7Dn+k8eyr+KqgxuGF53Mml0Sq9XIPzmFBuA=;
 b=1hRQ6M5FtQxdbEfOnQ4HYyEAwt/YZDR4d5xUArTWqT5pP6kBh3yDidcED/d9zsVnh0
 wH8bBZH9zoI7EoDclIJ43/5yBdHN1UmIqJy6kA3e3E/1BrO/ZHcHJrkQw5bXDlLrxMXp
 6UWxZwmmj3FwkMCoJCTmLztvdA/mlMtxx7MBFsQVl/QtnHVt4yVEdD76JCMeqYEDXOfE
 w2Hk9sRnKwevAGMZehQ2RZ6AS1OneZ13r0kz+lnVCehzj6Mpa9KmOX1Oi3r+x932XGYv
 iw7ba+fEdTptdWpTV9wJZQu6o/alyTZt1V6kVhMkqD1XQIfn79WWQqm3B59nHBXC1KUw
 K5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684699; x=1722289499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x//+WoaO7Dn+k8eyr+KqgxuGF53Mml0Sq9XIPzmFBuA=;
 b=bN2lo0OBGFAABNqqSMqxrTDBicknMA9bLRi7NXNbC320U6mSDI9mfaLfqpUCspJxxU
 1xC0xbm7csz/BAWdftNtyV3MHKenzAWhdldH2+65JYqiye4ZManCHB6lmaRgcH3S2Psj
 AvpXy6UhLfHUQyUUqEdfIxeHFwjHeKWUDF74vVq/ty4/xBa28OVkXJlQxdzt+krki57A
 sfZFsWgs2n9WTpdW3bimDmxZpVKPbUQHMoI61UXciE7EvH6ChnJ1T6wYoAvWXIqHZLwd
 0jcOfwM82NY/JK/WonHljwyyyu5P5An2cDn3LlSMJ3DY/jSzzq/mjtC5nw7dZ2eumF53
 FsrA==
X-Gm-Message-State: AOJu0Ywru6Ea4l4I20totOR0pJ1UIRF7wmF9UQa1l+I5S12U0PSXu0rW
 n0sz0I0/Q50OrRGo6+iHKaD7Qti4byzNU+X3aVq7uwTDBBwPfRqWu2pOJA7rhIxlekArIBBfLcP
 FGuE=
X-Google-Smtp-Source: AGHT+IFaAOo6Sk/ZctkoR1YnXWNYBYCD6WfGAXV7paBpQmTybnbVUergi31F4i9WnVNYRWvFG9EouA==
X-Received: by 2002:a05:6602:482:b0:7f6:1cd3:9659 with SMTP id
 ca18e2360f4ac-81b33edfba6mr1400411139f.6.1721684699006; 
 Mon, 22 Jul 2024 14:44:59 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 14/14] bsd-user: Add aarch64 build to tree
Date: Mon, 22 Jul 2024 15:43:13 -0600
Message-ID: <20240722214313.89503-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Add the aarch64 bsd-user fragments needed to build the new aarch64 code.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 configs/targets/aarch64-bsd-user.mak | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/targets/aarch64-bsd-user.mak

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
new file mode 100644
index 00000000000..8aaa5d8c802
--- /dev/null
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -0,0 +1,3 @@
+TARGET_ARCH=aarch64
+TARGET_BASE_ARCH=arm
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
-- 
2.45.1


