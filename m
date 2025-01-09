Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE3CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzf-0004lA-86; Thu, 09 Jan 2025 12:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzW-0004iV-1Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:42 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzU-00070J-Hs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:41 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso1910932a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442399; x=1737047199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=Q/rsOCOEeT23asef+rYJ21t/Vjufbdm6n40fdMz26p922+qioo4YGV60KCTRfeoM1P
 XqttUz7o8tR5ySntKzsjKwDYkLRoForh+KyZcPlt3hKxl8/ku6be0iKZsbRhLPEbK3+C
 ebZSadwlVZpY7YIuJVdoadtVXd1tmoLizyeSz+RN9DgcymzOMa+OUx14xG7reFHVGJqB
 Kj4XxmPIi05iV07GCK3/S+otvdMwOwXaAXhWN8xFQJurxBebf7AwapSIVAvWY/vPLYkZ
 DwjEfzmCcJ1QMdUF47VKRG81Kp5oo4vck4gE4nWtIuEdfscIazgObHJBS+/0gpViRwrk
 nevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442399; x=1737047199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=dFQFU+OyKy1DGCjCDPtQNh5iNU1S02vLNZTSlQj0AlzhlP3QYTBLSYaQYOPB93TPla
 dZzL/aFHpsYVIwjTBHspUgHZSDmiVtFYZPjWe2RgtaJGIQiUhJPbZlFclWP1jF0dGez5
 O0v3tBOhIXlo9TmPAy1rm3Apnw+GVk82kcT492pzq/g9SYENr69i3j0oPQyhyjrsWHzJ
 LVlX711hyMFgq9HK0rpwDmb4XidfomXo2DcB7gwS5o4B4NSdsgL88bXiQMppOWK03V84
 gbBj3iaT0dIZm/0CDwE/Hbj2D0+7Xgl8JeuQiRnYipH8j1x6AlMlSZwgsFWrup1QoXxa
 GFBw==
X-Gm-Message-State: AOJu0YwJ1Pu3ubWDIVje4oEJ9Zg8BZn252NMAyFMYgo0/vxCersqhEgh
 r690EdlVgg5t5tzorfTavksUlVvlJ3rWxFhSwo2zKwkNNkePb61hQLG42PXeFG0=
X-Gm-Gg: ASbGncsOxpUJNC966tmI675GDwjFf6fe/HzTQ3qiQafXXvjSGu7xVBqT/KErbbLi6vg
 K6fes6RY/5p9AAbzMcdLeRyjM57vKOLL18vtmHXJn+i7/oTQYrwOZ3/UUIr4eoauSpAesAbRqyp
 inzqVK+ov4cp8T4KdVZ781opZA+OwO7Ic6/dX2TarN6IWq97ov/sbibZcE0LRsJkO+UJVWnCuyk
 UF0Ou+xJoUuv2k/ZDWATGj79+Om6dqbN3tBw6UyIEo4JwbZQHnJlgc=
X-Google-Smtp-Source: AGHT+IHOvS/4wZXGOWU2EBLCpHrqsiBqzOJ6fEfFSbO4gKwqCMh/UVaWsVVbgU65/gb8L2TUkYE+bA==
X-Received: by 2002:a05:6402:2355:b0:5d9:a55:4307 with SMTP id
 4fb4d7f45d1cf-5d972e4eeabmr7141883a12.22.1736442398763; 
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c32a0sm805980a12.44.2025.01.09.09.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 190EF5F9CC;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 03/22] semihosting/syscalls: Include missing 'exec/cpu-defs.h'
 header
Date: Thu,  9 Jan 2025 17:06:00 +0000
Message-Id: <20250109170619.2271193-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target_ulong is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  include/semihosting/syscalls.h:26:24: error: unknown type name 'target_ulong'
     26 |                        target_ulong fname, target_ulong fname_len,
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index b5937c619a..6627c45fb2 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "exec/cpu-defs.h"
 #include "gdbstub/syscalls.h"
 
 /*
-- 
2.39.5


