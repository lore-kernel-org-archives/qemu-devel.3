Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECF8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYSN6-00072A-Uk; Fri, 09 Feb 2024 10:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSN1-00071P-Ek
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:00:51 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSMz-0000Qe-V5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:00:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4105f6fbdd9so7654635e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707490843; x=1708095643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jR1Xb2v8k/8ZZSdjWOz5eRsjS9ULRCmvbK4cgzEA0yE=;
 b=bIvvJpm/AvO81pUi8HW+NMb7AXrUji8IpJQ/5xPKH4GUsCu0am/Oi9iF4ZiKIhG8j7
 lv0DE9r3eOYGrsR2kkmDliidbARI0BiayGJ087elm52QoMkrXm1/tTJlTz9Zd9ay29ir
 3H/GaZH58/blH/olDxy7yKPQ/lcLeNigpbiyesMAmi/5xMFhsnXLllwoRJGySoa8j5wd
 8dJ1sx8cBGmBuP5Dsb9J+kGtHKmTDS53zsHaaDLb+o5+W2Gj72FgSIvrH7XP9wnguIVp
 bPNaBPy5Pnvl4t9tRGmFoSBzya0EkXKlAIENJiQuyHwwEbYt15tUqF4i5psYUHkV+xg7
 tMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707490843; x=1708095643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jR1Xb2v8k/8ZZSdjWOz5eRsjS9ULRCmvbK4cgzEA0yE=;
 b=j9xAZfgSgD9jdGHIMALBNNiUVVga3NM0yu8w/KzezrbicApYB6FiSIDmPc74lewGIq
 Vgs/3qHAJuqqmeuKmmuW87NKRyagO8c0ZMCLpkFOmhvEPOYDdW2fIohqjPszRHkKtJPg
 lGyDdOZ0c2Y2c9fkFXMLZsj4cMWKdyFn/0KP1bopVJB0IU4jk+zy515RJzvjXRusn9w8
 fy0NAE7h68CbvChazRNzowLZwmQDzQ1g3whngEwAtYKN+PJwcPDONVU7n2aA4CuU8EE8
 TBZaBpgzifISIAzH9vqE38/AMUcDCZlAiI1n6gu1Sw0Xp+ixbKmt/XTRsicjPE3Dv8e/
 Zh8w==
X-Gm-Message-State: AOJu0YwjRtq4dPUfBvGjzb/ON7YKjgojjl567J+lrNCu3oKNW6i63t74
 /5B1CVuI+Chx6Hn4yrqLzEZwn7lDigfg9/aBoUXpfPZbVMnlFK6mI126LX9RuNCQVBSypOuW91J
 p
X-Google-Smtp-Source: AGHT+IFr8tqt0PvUirWWa9r0FVucaZjWYCAGc5hFrPUoLcAczMtZRy0eeVHUpWrC3sx0SNSuT6i0vw==
X-Received: by 2002:a05:6000:1183:b0:33b:1c33:2b3b with SMTP id
 g3-20020a056000118300b0033b1c332b3bmr1394869wrx.2.1707490843431; 
 Fri, 09 Feb 2024 07:00:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXsCVYKktD6KbWGfXstpNQihAEDcwzJ/Q1jtZdEitGAB6S3zLmAVlUO+a2ukDuFHf/cb0o9ZDvL4O4wFiTMDTYP6pWcSxQYaYjab1egR0H654eGCVGG4tYQv0HAmZn6ZV4WQCMfaP3cQlJ7zp0LX3i+Xs2KddyFeGzNnogCbdX47cAdfSjYO7LRA4zbcCjqqqNUHwTLbGAvpQmsbSt+td65kX0RsbxuGxwZZdEjTk+lRWMl2bevPT0D+9ScH99nV9rpQmRF0TIk+rJi75Fw1ycLn1cQuPqo8g==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a05600c348f00b0041083b718e8sm219747wmq.43.2024.02.09.07.00.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 07:00:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/3] system/memory: Trivial fixes
Date: Fri,  9 Feb 2024 16:00:36 +0100
Message-ID: <20240209150039.22211-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

- Include missing "exec/memory.h"
- Set machine as parent of io/mem regions

Philippe Mathieu-Daudé (3):
  cpu-target: Include missing 'exec/memory.h' header
  monitor/target: Include missing 'exec/memory.h' header
  system/physmem: Assign global system I/O Memory to machine

 cpu-target.c              | 1 +
 monitor/hmp-cmds-target.c | 1 +
 system/physmem.c          | 7 ++++---
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.41.0


