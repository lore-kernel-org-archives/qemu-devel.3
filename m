Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BEEF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqug-0007x1-8X; Thu, 23 Apr 2026 06:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtq-0006Tt-Ao
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqto-0002BV-QP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so5287756f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938587; x=1777543387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TDooCHYWgCENYqNshKAbC8XC1BQYUyuqsIfC7EpWfRc=;
 b=pDFLn34b5vVzXn+W7WzXghFjcsakPURNfMXR0d2THSGafkgT9CJp2gXLdyx8ISdX7z
 efxpSCIIgXuem5JKgaTcsLNo/WXQUybse9qV2+svRp5AldqnZ8O77PBDfjTs0NAZZ1a9
 hnPaMWL0FE3Vbqc2ysrsnhOviXB3xObyG6V7alUPURmm4q21nBHMZLs0hkC8UutV6Ojm
 gH/P+29RdJKO1UQ+Pio2JZOBcz/646wqpirm1XNusTlz71MzfS/RBdyFqiKFPlSNsky3
 iV1BXd6/ADyrqlEyn2jlKvq8e0Bo1xCxuP0KNQwWWbPAD8ehv9V2W7vcIY+reM7m0Njh
 U88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938587; x=1777543387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TDooCHYWgCENYqNshKAbC8XC1BQYUyuqsIfC7EpWfRc=;
 b=mglPI/YV10Iq3OJqM60QVLvjWyXdm6V/u/sP4+Bl5YdImEARtZEsaOXOqY6Kv6hLoo
 xVAPWkGLE/UyXMGFUoEcxmKAJgEdIw2hOikvpVKqdPfV/NwH1itXjschXyzb9jInRb82
 0JxYmxIGWbtVg9BBhgu+WhUapmiNBrOSUo+jtCRk8qMwLM0UvowtsQlx3JIYM89A+pIn
 GF1FwoLwAoIzY609Ug6GHP8IY1LqiuBfGetpdowlfeD361myuCxPRL9kjFaiaSgFTteO
 0/pd5WiMB17XG74VmLmjCjlUHHCzRYLVCOa+K7bqPLzYXp0u/dMRkuicwcObXmSxx1wi
 fvvg==
X-Gm-Message-State: AOJu0YxUe4F13r/IQor43SCRqxSPdWn+g2heo7ukL70w180tGJnlN2f4
 MYNTbnRm2aFeJZC2Gykryxyph2wVCm2RXIz2g0ZKzeZCbYDDOa/1dSqG+MYMsSX3ZaeG10BDWCA
 mNX85
X-Gm-Gg: AeBDiesyVLhFgNeCy1XA5gGaagOSJCL+Nti4fvyW6WVJEh8HQzRH2bjfY2yy2PupdjK
 jxLwG/dSTQOxJB/vHq7dzrWNPm/074lv3RiJZlLaNmJl5nBkPwNPmmM8OWpAMmXW/AGmi7IirBt
 k41MmPjCa1/TIfKb3W+I8h3QVoezPQwpyLwdM/cGH/hbOD3fj38sUdFeQ03BXYYpkmGb0PA5+Et
 Hdig+AA7GA0qjLYa8WlaGZ802vIxrOUPRl+EAjOh+6jgGEf3PwUueIm8jBXBmJXAVjZa+KCj3xO
 P4b92ULFSst54OSLvY7kYkhES6xT/S8k2tUXYu+yy/yJMuLYupQGu5iyrKzSkgE+q+YQnUH3fWy
 tp/pMSdcmJelT4by7Bih5BmvY/M8Mtn8/8fv/x06zMJpJAVDmAA7a3qz8MvP8wdvZISv0R9JESM
 L1nFS90o3wJxJeBDYltiHMclwQQC6QGHZ5NmWw+axpJVPwNUfw8V+lHmrCOZ8OGioIgSIjJxXyF
 +m4WZgQw9xWXDWtqz8LoazIpinT7tbUpepB6WHdcg==
X-Received: by 2002:a05:6000:184d:b0:43d:6fb7:fee1 with SMTP id
 ffacd0b85a97d-43fe3e23a59mr41467045f8f.46.1776938587165; 
 Thu, 23 Apr 2026 03:03:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/59] MAINTAINERS: Remove Ahmed Karaman
Date: Thu, 23 Apr 2026 11:02:03 +0100
Message-ID: <20260423100229.2941820-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Ahmed Karaman has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Performance Tools and Tests" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-2-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a90204ae9..2fd2a5ebd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4634,8 +4634,7 @@ F: rust/wrapper.h
 Miscellaneous
 -------------
 Performance Tools and Tests
-M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
-S: Maintained
+S: Orphan
 F: scripts/performance/
 
 Code Coverage Tools
-- 
2.43.0


