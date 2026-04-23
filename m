Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0799DF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquc-0007h6-Q3; Thu, 23 Apr 2026 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquJ-0006mz-8P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquH-0002Tj-CK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so3771486f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938615; x=1777543415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8wBP9zwQSa8bR4IBfzsBFbe2jBjlLM6vVm7DD/f/N9k=;
 b=SeM81G9STGiqmIGbm0xbQOZ0o0y/1egoaYzEwb1533GhznVAzHM+HlGSV65CRc4Iuc
 u9BreKk8Zl/ToJ5rMrE3+3rS6m2PuStOMzL7V0nL9/dQ0gTXtmUGfOZgd4n+1soHFqFP
 zXFA6B8qhdPZEeSSNV5199LGAb1T9LeKMv6uLd6IF8sCokpQO1yHjmi9bKnfJyvu5EMx
 8XVoQKTkKLXHzk336QkaFpwt+iDPK4KGG170W3vCmzYrgibzVwbXRrWTzQAigwTR0C5A
 JQcrG/yqVf50qFtJL+VuBcHSJ/mFWkH23Llsp8deo0IOopYdo/nSEv9D12EkiZcEJgB7
 zA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938615; x=1777543415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8wBP9zwQSa8bR4IBfzsBFbe2jBjlLM6vVm7DD/f/N9k=;
 b=T6F0Gzbdi3VAFoGLZ9iWPAi64bZhdhWT33r3htD+B8Lzrm3HTVdyQWf9RXjd4iC0j/
 gPF+jAdANzsGDqlbGgAUJvnNIQ8SS7R+UajFzD5AJ2F4KWtb58xGj9WBawSnCG78EJ1L
 4dqaiYBSY2w18834gnwwEzEc4oN9gcqzLaQkgByfSHZRZbeu8XEqQh4/BYnF1ZnnkUiy
 gilrufNvUSOVx453xGaelGIa5JlSiFKqVR94leUobiSpv3LIN/GOyG5QGFUeGAo3p5Bj
 kafbKpYqtyiSprnoergA/2L5XijsI4iUk5FRUNhz8V0do//UxC8knYwSj4XwHpCQK+d/
 xJ7Q==
X-Gm-Message-State: AOJu0YysJaVGVJ1pZUFCILnvPtjjGeWlND5OW2VCYoPKoWKd5YhEfDK6
 FXYFjjD2xEE4MfAcy7VDMxoAc4YA5v8rQTAxzqooKfPRBoqOIAzxqvWYRjenrB4wr634XEJdssk
 SUZwp
X-Gm-Gg: AeBDies62JyRj67xiqKBsI55uesFGh8jmsd4/Tw91LGCib5zNPYN4yvlSMSRjSp84U1
 XClLqR2sqq/EcvlEh5dZXxWvMPUT1H4cGtJjZZFl5oLnFkFJOTksfekkGyjNCJTJ57uy5+QisGY
 51Q/v+trymVHUm+bqYtuuSpYYbhsRpIoccrTH1n/Bbw/azxf5dFphTy7Fgn4SgQiNUicoj8y95k
 Mh2eifhm3FFP8nPXq9dY/UPjylTv4Vqb/V9Yi23gLNbriVkUrxYomU5QzArY/9dKBxyvDUgSnch
 yKiesqpGhWnzAn5wrowJ5icnGLZuwmUtFP8tkE59tLJXEDa4xZKNZ9exZEn2md4/lwuLano72/W
 NgRkqGkx1i6mwaPvslu0DQ8LHgr8DmtaTqHqSnNGj0CtdZHzovO7g/7fd5CwOCRoEltvg0WfaTK
 JoPvsmEc6KlgV9l8Nc6IpdHzHm7oplXyrOWG6keYFMQzWkMgypkEDa2LuYbmyTir62etZZoaCAM
 RsntjkkRAa0CwSma0++/csD9rduW4kWaEl8DjaiIVqCuhMNXCQu
X-Received: by 2002:a05:6000:26c6:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-43fe3df24f7mr39502522f8f.27.1776938614699; 
 Thu, 23 Apr 2026 03:03:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/59] MAINTAINERS: Remove Wen Congyang
Date: Thu, 23 Apr 2026 11:02:27 +0100
Message-ID: <20260423100229.2941820-58-peter.maydell@linaro.org>
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

Wen Congyang has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-id: 20260416091654.316158-27-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b3da13653..55fc63d298 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4385,7 +4385,6 @@ F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
 
 Replication
-M: Wen Congyang <wencongyang2@huawei.com>
 M: Xie Changlong <xiechanglong.d@gmail.com>
 S: Supported
 F: replication*
-- 
2.43.0


