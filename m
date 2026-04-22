Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7249F94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSa1-0005Rp-JC; Wed, 22 Apr 2026 04:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSa0-0005RU-5X
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZy-0001HO-Jj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so21377725e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845101; x=1777449901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyKGdw2zspavug7DDv7we9RbVYA/l2a6yq0Q0ZNP7lo=;
 b=nsU8bsA3SD13om9uWcjrVN1bPdHpauB1sRSz45+9z4LBfOa13JyJkusl9XbtXL7Xt6
 8ZUu/ad4J4LuhuhEkuQ9VqwvD5kLhgM5OJ7gwyGfSKL/fCaN5mNLy3EdbdIlzx8rFzla
 W/Gf+ta4e0jLKicy3GiluzyMsbJdznkAeV84VjXLNYPt0KspWEKVI6YmH9u1KasAWOO8
 4pr3DH3H4bGcgXmT0a28LwScbZTM6o6HqJFtARc+NFnok2hHZzPYVjMzMAZWNB/ksbR5
 ESi3FyTLa/qbvOnNzOrMDAoYrJG7a4MqbdDAjSChoJYnryQqnsB0all6BeQNJG/Rklao
 ujRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845101; x=1777449901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyKGdw2zspavug7DDv7we9RbVYA/l2a6yq0Q0ZNP7lo=;
 b=lV/hInWE293jeqb9Z03vPQccuPWhSqE8MsBk8w8Z5go6dLiVcNMKTJDyV9ch62SNGW
 i4EiqEWeIwMFDgYd6dIMB3aMJPmUvm5HhU+p4Jy/UvyB+TX1KdT7tiQHiSI6et31lrN/
 j4aYOlJssvnWwsH0tywLaH+vLtejFy3wz1Q/UIERyg7lfScjgkWxz/HhsnHYSTM/pHAN
 /c3jLp8fn+7MZpmcW+Zkwo4ygOO8P64VTGoZM0hiLA0EibEMrcHiaH8Gi0ZvKrocLCP+
 xZIs1TRIfZXjL9gtWMErYvOT98MMCB4ICi5IEieKZHjXa5/lbmC3LSCu+5Wqr6V3hULL
 CuXw==
X-Gm-Message-State: AOJu0YwXcHIu/wUnjWLfsqnwsvXI8VkXDGBn9RZaVuKELzcw+0FtHWeO
 olH1yFjfFHtzPelkvZhMluUoEdZ1hBdbRZRHhN+3Q+TFtS23VJbN9h7BgErCwihCdS0p8/ioAdR
 ojBP23ps=
X-Gm-Gg: AeBDievdagk6QiG3ZeODWYuWESrpefqjNk1PPeimzw4fwwuZy//KkNi2M4pGlfhX6UH
 QEDbvovmfGR6YRFyoIc5kXz16ye6IRmi/KTZfFBe+BvVXtioPw2rw4T0xd/sUcOYVeQtEBzDEIG
 2XgZaJWoMSR/4I96kOZx2V01U6lL4i9xACOptRW/WQJPKzyDfFTiYMAz6oSQxLqtGxZMD4FK9Ch
 aEhxX6hMay5Sqs309PnQ3S1UG6tcdQHTL/FcxmzKHdVl9RCF7tdWCqVAOxAT6oHQPJuwy+Dou0y
 yGKzExvAb6gcVsFsnnUEitiOE6XBcQwYIux1bsSkYdjFW6D+YwRkbnxa15poxsSRnlN22/kMDWr
 mLAiPv3ORRR6elUigvsDCylessqiIUWAjVODVUa6eNTtJ9xDbvTFkNe6IarLxPu8IB/m/tVW0w4
 SdULRJk7BKJW3zDLjccRur3xg7GVdXgcDxJ2Twm8khZrv6Yu1faiRaXR84OewK5fVr+APAqYIzD
 rsSbex6Xuw=
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488fb8b91a7mr275215525e9.12.1776845100449; 
 Wed, 22 Apr 2026 01:05:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm189411765e9.7.2026.04.22.01.04.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 07/10] MAINTAINERS: Remove PhilMD from NVMe Block Driver
Date: Wed, 22 Apr 2026 10:04:02 +0200
Message-ID: <20260422080406.62638-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

I'm not following this code anymore, no need
to be listed as reviewer.

My gratitude to Stefan for everything he taught me while
supervising this topic. I truly appreciate the time he spent
helping me in many occasions. Thank you very much Stefan!

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e3bf662561..e651d18879a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4234,7 +4234,6 @@ F: block/null.c
 NVMe Block Driver
 M: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fam Zheng <fam@euphon.net>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
-- 
2.53.0


