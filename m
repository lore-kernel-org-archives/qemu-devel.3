Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2CAC71131
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOybN-0001al-Aw; Tue, 10 Jun 2025 09:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYe-0007yH-U0
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYY-0002j4-Of
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so3144655f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560300; x=1750165100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1V3w/IS64oeqhhB6d9B4sJVJcOGGWYHRK87tYEg+og=;
 b=gAShiRFxDYHLbRgcO0vcBHyYb8XyHMjdoVZl6n0fuF+O4E7/CyM5hZyJ9JJeLYnXw2
 PDeeQoOsj9TO/9FndbRbdWrb5XiXvIimB66BX5RGmSTd3H/SQSs2bpH3VfJnNRzHy1po
 6dYhbx/DnhhQhC+WIbNVxOBhO2kSy5v1i3Hz+e4HceDROKsgAexFO9eUaeZv8RF3IS/U
 p6RZIuIEuLn7QmyOKfDrPjif6xeAsHEO7GjtGkpoHXks8XwNH5k715gzJH2udcHzZR0k
 FXKFylNJwzl2KrA0XoJF4aStNeP7Vm5S9Fz51Wp02ZJ9uXjkYx1QvvFbZx4RDB2tefkC
 n/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560300; x=1750165100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1V3w/IS64oeqhhB6d9B4sJVJcOGGWYHRK87tYEg+og=;
 b=wgZpl+Hw2cvba4kcbJbe5NSTslx0apdhjK8EMLt8L497DdMKGTvSBZiFwq+YNzGp7T
 qwC8zb6LuS4gxQUfb6PUzJSWadM+/6HkFZ+uij4yjEmKeo52taSql1/t7EtGnVyoQ42w
 eObZcdZqyiu4JH/MgC65WvcoAZEwt1LfikXUHpNB+PijMtVJMPNgofd7axbWbsDCQ37v
 tlJBby44ja9ArNIM1e742LjyzzKx/E4kvsLi1Kpq7FtZqreEwHLI7OuL1eszKorxMaD6
 /McwzXVUNT/hrML9ZSXak/WIxndS9jQU7GgfxgVi8NovcjV4pLksa/7fbBNtYnE38gXh
 5BoQ==
X-Gm-Message-State: AOJu0Ywpx5B1vaSifEwwXPfPg84MoY4yJoSe0AZ7Hh8puYGefBKviYWV
 WN4XMoagAU8M6yplIxHUvJkLHJFaalVR89eJvqaSU+evHrYgH3HT8+GiTz1bTgS5NL8esCVG1xR
 f8VUOCN0=
X-Gm-Gg: ASbGncv/Y4DT4QvOz7MEPb9ZXzckZWwJb34TrTbu5JZZ75c9g16lUMXFuz8t714w7GQ
 6OIyRDPP9kuhniTum1ZKJTvF/tNv9bgobQBc1wZtyAGFuQwvSVxnEh1Qu0R4qxPEoMZ/saFOeKk
 rIhFmHxsDW4GgVIxC+Om+p3/IUP2ZNFQhaTXuB1TBgu0C8+QHO3vMZt5j6aR9t114dwnT/ZiErk
 BVyL+3mijIiTLqI56RPenzOHJfM7sBGPkStpz/cRA9mj+buGXu9qtFtgBDRQFgmwMSy/6VHXnEM
 inmxCujyRF0cIyUZQYhPaXauwhmjLkGkx7yP+ZhqDZqwEAOFZRD8BRAeQMcvL2arcqIbJELH3Lo
 972Is0XaXsNIow3a01YDZGKOhpb7KSSutjhMHiKLZRQ==
X-Google-Smtp-Source: AGHT+IHLY2qOlpaD7ew7yDnmClP1Hpf5uajbMMKQr25oi/iLFkV82EWxorDwVrkAmQ7SxKtBsP8mVA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3a5319a6fa1mr14453238f8f.39.1749560300385; 
 Tue, 10 Jun 2025 05:58:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d9e9sm12425447f8f.13.2025.06.10.05.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/24] hw/net/i82596: Update datasheet URL
Date: Tue, 10 Jun 2025 14:56:32 +0200
Message-ID: <20250610125633.24411-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>

Change the asset link to one which is working from the PARISC website.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250607152711.108914-2-soumyajyotisarkar23@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/i82596.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 64ed3c83905..fc33a00d498 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -5,7 +5,7 @@
  * This work is licensed under the GNU GPL license version 2 or later.
  *
  * This software was written to be compatible with the specification:
- * https://www.intel.com/assets/pdf/general/82596ca.pdf
+ * https://parisc.docs.kernel.org/en/latest/_downloads/96672be0650d9fc046bbcea40b92482f/82596CA.pdf
  */
 
 #include "qemu/osdep.h"
-- 
2.49.0


