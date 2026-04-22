Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEBFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdoc-00014F-F5; Wed, 22 Apr 2026 16:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdnB-0008NL-I5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdnA-0003oM-0M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so4018292f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888202; x=1777493002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FK3XR1zSvbBfu0X4kGIkBvFvHlhDSuWw5xYaKTNfXJc=;
 b=THoeh2ps9AtUACO7R2tMgs9sZ3EzDhlBSxZhGY60aBoAxAMaVU+BLTUjmE3sVrQp4A
 UVzn+cJYEuKCxB/+dSzOOHQhF0OmEnSJ8mTjOji6TEST2B3jCNzP7L/7oSk+LlS6hA7k
 SJCes/WMcjaTzor7JbOfe/bwB/m28G8kzFahuzZw0Ci3gM8W345NTljr3EiHLIiJZ90Q
 gnaRJhpwVITHdCLhN3c92o+ElRRM6ucLWjK462lIk2GuGX9XOwhh98ab7nUmsMLk2AUe
 2rGOKyLo9ocTO0jBmN+b+ebn9Fsb6vKkV/eK2r0Z57WeBCcEjwp6LORq8vZ07hz1KqjF
 dBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888202; x=1777493002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FK3XR1zSvbBfu0X4kGIkBvFvHlhDSuWw5xYaKTNfXJc=;
 b=rk4k95pqueZY8vHcKl31sfZ1mUnSlcxYrZZOmFq+UiyC5cgLTgsJMHia9D1W8/6JEU
 j+OVlsNigpUV3PWfrCRue9nZybzRwzsMMfZkl1QIl6xgRhnoOEccXxVQpoWSLXytnnY1
 QsHd72xHhaTcRh0V9IRXRbbdahxA5xGnt1Pf8CnfdTt3eG7M6Ue9mmtyO1MGLbaVrckG
 2FSOsFZ78wFcnYeAFxI42zTRRBC61/00lPIHJ5VxL56pUJMURb0uGjpOpRpUGfUtTjqg
 qXMubrqlSkJ0WasVVWKlulC9HE/sk0Nrae7k13fhZRajTbdDzg9isISQ4aJlCqq/ZdVn
 GHLg==
X-Gm-Message-State: AOJu0YxjnHtTrhD6ymrD+TPnZm9IA9ZqTJsSa9cyRMV6fJZmMSV4vZAy
 2KO6G9k62K7kEAwY6NZFUPdZo9/4atbr0RtlJ9vkztM+TRT869A+iZVfD5V7bPOFWkXqvsvh1oz
 Wt1e2K1s=
X-Gm-Gg: AeBDietvmD6ts4bYK/NlucmAxeg9aOv4ja2jvkj0VhPyuI19VCgzrIvwTCQljFORU6B
 4/tOiDZqS6UXa6OWdP0QNaQhb/NXK+/1JKP8xWEfjzueTyiNZ1RV00HLVdi+R3Ja2+z7DPI4iTn
 xcMnlf3dyrfEAmR+CIRigO4WcmESAc1J5QgWmnEJQ9OQmlFVlqt4cy/KNr+XcT/Rt5IphIS5DAq
 3xzNryJW6oeThIPUy/WeyicLqSmlSqeFsntDahenU3jf/J5gLBuJQzEU2W7zznnjdQL79I1q4Uv
 JoCaMG22rt5xAOjpjovuIqppPRskPg5yAvmGhF2Zp3szlGNRrLvrNurVKCEtNvKhJFLNQELU9qC
 Cgk5eLH0oBXeKuWO4MG5Dji/g4sdKK2Sj6cg/hGpaixuEN7RT6enAiHai0Cn/1OHVlEArYHa+07
 azjRjS6LXHblw6dm8PiqmABr65Ijjx06/7Z1AdSlUja12OpyHR90kTvOgzGPiVNLreRxcD0CaR+
 38hnt7Xmqs=
X-Received: by 2002:a5d:5905:0:b0:43f:e429:c758 with SMTP id
 ffacd0b85a97d-43fe429c7aamr25337493f8f.1.1776888202036; 
 Wed, 22 Apr 2026 13:03:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm17971336f8f.1.2026.04.22.13.03.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:03:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/48] MAINTAINERS: Remove PhilMD from NVMe Block Driver
Date: Wed, 22 Apr 2026 21:57:45 +0200
Message-ID: <20260422195746.88865-48-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20260422080406.62638-8-philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed8aeab421b..05bcb5fc7fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4253,7 +4253,6 @@ F: block/null.c
 NVMe Block Driver
 M: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fam Zheng <fam@euphon.net>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
-- 
2.53.0


