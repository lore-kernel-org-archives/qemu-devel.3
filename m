Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BBCE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mg-0007IT-8S; Thu, 19 Feb 2026 05:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MU-00075p-DM
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MO-00063a-M9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:19 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so13207995e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497254; x=1772102054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OQfEbThu7oMSWLhYHhXd3iUGX21b3ELkTS9VtOATfc8=;
 b=XQNwpja6+XjH6Oz2fqeR4ftkIp1TuEQD02bS5G6O9F6F/KR3iFsO0VR4/jGUAyDOm8
 CHhGLQWkqy1cFU6IXoRILwFvj7010yYjVSqNTI0UZbZZv10oFwKNWVBw8z1RVrJmrUlt
 tOaJEbVVc8NiHtBA97Kpvh6UZZ+GeBAZRFNWnbFX0VYnIwmSaa6OZ0l2Guo2vCp09J6Z
 l317XIqKyAWVyPSI/i1kXfN5/QVPpvVvB6pjpMfVZ876lG/yBZuSo8kEvgw3J1wKUgqx
 AlmBKUxYi1jofTRSLee65dNX62vCEGui5emZcH5Z9COxepDgeeZCUjt/fbMo6zn3iNyZ
 2rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497254; x=1772102054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OQfEbThu7oMSWLhYHhXd3iUGX21b3ELkTS9VtOATfc8=;
 b=vrrFCkLLRDhnkTgFUY5qGH0H9PFiyfo9/aMLe2t2H+8okMIZ8ambN7EWURbffuDmm+
 nRMK/P2qzvyvMWUyOfXgKF2dWewj1nQjFd1ngJZYqjqsD15qS2jkTiwTl5i8M0JEj4Ei
 phXiHwEHQFOf0nXoJWxCnab4Ovw0V2I03LIDE7bF0RG8oJjApaF9TiMGQB6cdN7BM/nZ
 NbUbro0emxrNrHFQxYlxR/9FJxNArdCOZc4fDTV4YIqjAtiIRDgvSfujvet1P5m9GDQF
 AjAuMkS6YIUxitdBIJMaj8SsqlJEV4NVWclBxSZktPMwbfgGo9t0Y9Q0O4CmJy709/M2
 hKhg==
X-Gm-Message-State: AOJu0YyUKzvLZCW9b5HO3/jWRFMm7Sc58PilUYcEoVhIybeKq5P0qLi1
 rCIhyjbESZrpBE5O2Z9YE5OwKZAC5a9iR6TcH7Agko8ctSXmX+atllfrfV6ZTcnVoHuxtMt1wCY
 HijUU
X-Gm-Gg: AZuq6aLkX5dms66ShSTy8XLwW5O5czNA3SvlV9sZg8YlW4BtT1gqKo74551SWkAEpXn
 ZMk3zD2LY0A70BIKG18ye1HW3T9kajlHGvAEwCa7DEuBOMG68ez+KfLtQerRc8R/poIYvtNqALU
 amBkL+/n6SmxsnpABpAu1N65jIeY6kANiNrywIs1edHGAlg+DLaJKCDmydrOgYiNdiqZBpmWWDd
 mq030c1HHoS8gEL6Eiqnq/pUedkDu8DvxIYv/l9dci23R4GHzz6X7CyMnUAZhUZ6pb1JoFDPJiy
 ZTcC1l76vrB/0BzwRcjt8h2RhEQrBlageDCFIn9oOvyjHjGbvrY+YzCXdgrbWmXVZSsvpWJKWX5
 MKBrmOUpbT5BzNoZlHtECq4h8W6BLoCD3HnFI+JiO6Hpm0I6y8wfZgVAalz+0xWflpwHBJc/voW
 /l48ZNLtMJ3IEwU84Ku1fp5E2VA6NMnCqKkJ6rN3vu1Tz8v/7RD9VbBzqemNWFpXrgXxJ6T6ls5
 ax9ZrLhQpKUQ5/mkhAyGlOC/DJR9c4=
X-Received: by 2002:a05:600c:4616:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-483a00a51b6mr12544465e9.11.1771497253932; 
 Thu, 19 Feb 2026 02:34:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] target/arm: Handle SME-without-SVE on change of EL
Date: Thu, 19 Feb 2026 10:33:40 +0000
Message-ID: <20260219103405.3793357-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

aarch64_sve_change_el() currently assumes that SME implies
SVE, and will return without doing anything if SVE is not
implemented, skipping a possible requirement to change
the vector register state because the SME vector length
has changed. Update it to handle SME also.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260202133353.2231685-8-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ebf185000b..e12b2455d3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10139,8 +10139,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     int old_len, new_len;
     bool old_a64, new_a64, sm;
 
-    /* Nothing to do if no SVE.  */
-    if (!cpu_isar_feature(aa64_sve, cpu)) {
+    /* Nothing to do if no SVE or SME.  */
+    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
         return;
     }
 
-- 
2.43.0


