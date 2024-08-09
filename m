Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED0C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKKE-00036Y-W3; Fri, 09 Aug 2024 03:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKD-00032K-Uh
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKC-0002wQ-Is
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so1446991b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189451; x=1723794251;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9X5MTGvFI2Zv7GRoLtPnCYsPW7vOtW3PDqqslamyEM=;
 b=qVqSOtveCFyFC8Ol+qWsWAS2DNHcX9xTUF9uzWli685Lo8H616dVJIBt9R2b7+Jy7W
 JhRdffHnLARX2c/QM8c3vUfpbwbFDYRTKaMO1C1P15LJTaY8BENWw8loRgIn8pm7c2iQ
 TG8TO0hg0LEQt9FIOSEU1E5WCPGrFS2gp6oakoT5lKajNpRDBGaEq4D9zygU4RfykAto
 28PBIGvX2aDKia30pyiuWPqu8gxYjWG4YbGR8SJ8Iwu0nut063OjuFbmRSgfbpxcMoPE
 M5zZZFlDqKoF3M43+Q9lm2gUqZbIaVFf42AjxkQVJZ0EUZ3xVImBOruETTxFePhRivNe
 m8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189451; x=1723794251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9X5MTGvFI2Zv7GRoLtPnCYsPW7vOtW3PDqqslamyEM=;
 b=APnWMkKSmhpXGsw8JQS2slSD0wnoqEqCyHPdRQASjX1s41uaFy7hzLXrf/QgM+hm0c
 SurzRMG4Fk9yOQg50Xit5LFFDqMpPGDgyc82ppzFBME/muhI/l+fqI+Tf6t5/zeAstIV
 qJ/nGwsRyoFTVGQNWP5k0tJEFdMuxlxSLoPsOiWz1jZnvwH8u/73G2GGMv43NoW3o2Qk
 pF0X19VUTyOLhk1o2hdQkoF/+ZZIJoGX2TtslKikE1cUG4OeEXs4XJCewWkGukeQ8WQ6
 6ytKW/TeWWeXoofbTaRHFYiohvu7I+dGX17bAwXoqkV+Lj/qSFKHiKPGPY7CTrgrpCPx
 LO4A==
X-Gm-Message-State: AOJu0YyWBeZ5YSoLZ5OuOZD8VFF+F8iuir7ZytlRl3gF/DFwi/kM5oOG
 KXQU8SR2p/NBZkxlkEh3Z1tM18w+GIS5tOBVWRrSYzh4zOzIsVokawk2R1Wvw1mLvZ++o65Brv2
 ZypEvug==
X-Google-Smtp-Source: AGHT+IGGZEEVCqneji2kEnmI4knzCAXiPC4xOKXyPuVyGc+6VopQw4BFIwZAEPR+btBoRHfG55mmlQ==
X-Received: by 2002:a05:6a20:d524:b0:1c0:ec87:d737 with SMTP id
 adf61e73a8af0-1c89ff275b7mr947973637.23.1723189450671; 
 Fri, 09 Aug 2024 00:44:10 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:10 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 4/5] guestperf: Nitpick the inconsistent parameters
Date: Fri,  9 Aug 2024 15:43:35 +0800
Message-Id: <3db459b8f473db0a854127e4951607b65c744622.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/migration/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/scripts/migration/guestperf/comparison.py
+++ b/scripts/migration/guestperf/comparison.py
@@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
     # varying numbers of channels
     Comparison("compr-multifd", scenarios = [
         Scenario("compr-multifd-channels-4",
-                 multifd=True, multifd_channels=2),
+                 multifd=True, multifd_channels=4),
         Scenario("compr-multifd-channels-8",
                  multifd=True, multifd_channels=8),
         Scenario("compr-multifd-channels-32",
-- 
2.11.0


