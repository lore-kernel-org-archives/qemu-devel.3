Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D3DF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquj-0008JP-9g; Thu, 23 Apr 2026 06:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0006Yo-IB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu0-0002Jp-Ou
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fea39e066so5291818f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938598; x=1777543398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c36wM9GXpuhtY8lyA+CKnk1dts9o0aviDitOSmQhN5c=;
 b=KTLXs/pKMtnnbIfRx+l1R59CQkY40G89K3EmNnnjcHKexHTwaFZlUdmAL794ikU41F
 IM3lzKvFYoJH+xgBut/qMBvLpxRKLQv2BnUvXUhoJe5L7XkqX5AiDisraRYgVI953k88
 thB0RLn9+4ux+0jRF/tId5YhOG8tzO4WAF14ol4nLNHDiC7xtuxmMYtmF7qgnvNceDO2
 9SjZD8RJHbwePO8C+AOjAZvMw7lmDcjjrKTeTVVQNUDK5xhQn5gHP+G6SF7SqGs7kAxd
 yeWQzIRkNmKHbVC8DFGsDFPeBRuhHeJiZzlNxRSrKl+S1UuyrOTQdMXQgL1z8mJSng/X
 08xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938598; x=1777543398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c36wM9GXpuhtY8lyA+CKnk1dts9o0aviDitOSmQhN5c=;
 b=q7O3mheF8IPHQPDmE5lG+Z6PBcW4YvhS1+F6aGNcmbAUVbLFh+0Z+9yzwamrh2HXgb
 MVNTW5goJOjoMzCIIe6FK8uXuoeJDdXK78cqKF4BIatNe+iP4Lj/ilCpPO5yyc7IOrOo
 Y216eppaaBOM4Cn4oQNt8wCZhA9DKacaEpEfIku/1SfVlo4N3v3/rpniNyRFJUvzSQm3
 soq90JjcDY/42NrCxne9KP+6O4yJwhKIytruZhhLKLl+73EGkCra1/eFS6mwlELVk7c0
 aavB+cgVx5ArzMFgVBjXyLnvY3NbdJqFQT1qb9AtMpB63AkDhU//asaKk6Ur6sF0n3j/
 Y27A==
X-Gm-Message-State: AOJu0Ywb78eWNz2twaSHIXcUbVU7j+gCNqs4JcYxWSRh0+llAPoGqrPX
 biJ2spmOuOu4hBnK4q0x/sJWLSbWTRUZeTluoviakWBH3r7L4VPcaVUTWBAd2UKXcsrL0aT8FMe
 k/NV/
X-Gm-Gg: AeBDievIGoMg35yaX8u7+BZLtiGKekxQMuQTm0Pd2+sWVkK/8FXHEYfPB3cL+iGjz3U
 47Bwt9tKk5rl7EGWfsX8+5PF1L+DaNni3Z5lOTsO8EhLEzj8S5jM3EtRrkLFf7WgQSSCoGxqlWT
 qv25UEhlu5XvvSo7bfGtVw21OVbcSVVV2pmnX4U2mU83rHokSxr+1z95q9zk8F3pOpR/zWGEdm7
 iwiW8tpTJLzEx40BkoUukT+7t2JLIrar3DjgS0ZjkL6LNjW8RiiXWXMTuzkU71+iSNbqS4037KJ
 5Xt+ctOxjefEbkWwUzaxHdMApD5YreUAg3SWkSrano2j1sCyJS2kvBAz8xAxjKEEpFEAk/BcUlE
 2909DobqnwEv6XRmVBSD+ZIx/yJfhJeIcR/tJLOUe5O+UEwK7bas3ZYlHYyM2CsoknvNAf3d+AJ
 DUYXxvIDp/eEMowrukRqZvV4/6z1CISZrFM2qZ9/HOoDUmsWHpqgI/IGJWVpPNh0g/kLZ9YUG+D
 jwaJmDYwBd+omiaGdAHsSVJx/IN8eTGZQ77lBQ+BPY3Coc76CC/
X-Received: by 2002:a05:6000:2c0c:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-43fe3dc5b0bmr40547819f8f.5.1776938597764; 
 Thu, 23 Apr 2026 03:03:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/59] MAINTAINERS: Remove Mahmoud Mandour
Date: Thu, 23 Apr 2026 11:02:13 +0100
Message-ID: <20260423100229.2941820-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Mahmoud Mandour has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-13-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 11ae4829fd..206ff228d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4092,7 +4092,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
-R: Mahmoud Mandour <ma.mandourr@gmail.com>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


