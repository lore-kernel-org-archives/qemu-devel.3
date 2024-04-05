Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD9CC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj53-0004Uy-Nh; Fri, 05 Apr 2024 08:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj51-0004Q9-MC; Fri, 05 Apr 2024 08:54:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj4z-0000rw-Eb; Fri, 05 Apr 2024 08:54:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a2d0ca3c92so1323269a91.0; 
 Fri, 05 Apr 2024 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321632; x=1712926432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KW/JAdjkkx0AQWUZXkHf5lnnBtuRIMz2UCSnQC/OOKA=;
 b=ASkQoK4OA/tJlI3DkGsXMAum/DvT+aLei0rwu3YpMsMmI/Zv52zy30MTqqdkiRbr28
 uaBxBsYcgPb51Sqi8i8bCTOByu1BFTItLFh9P6J6lM38yGhCVB2o+iOaYmQo9x8vnQ5z
 z/8uPYDFYiey/ml5PgF7yAazuyeK/WJOhR3bOHUDKM76L0syIDMe1tGjimNvGdKHUqr7
 L1hJhG2pDzr7LC9Qkb0pcJnhNPLdQDamxKop6mF7as5H+uZM9gTD86icXsZRV+brYIfb
 UFBi/V8M8Aj2JXQZjPWox6yANW21Ci+zOSnbdDTICFMNigR4dcGypRkR41BmUwZdVK6S
 5g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321632; x=1712926432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KW/JAdjkkx0AQWUZXkHf5lnnBtuRIMz2UCSnQC/OOKA=;
 b=qWGvYOlaLlwxLp3Ay5ynf/anDLRRyBw/v+oaDhUYiavgiVR+DS4q2JNyNt0xmgFLa4
 M0m3jvuZibhoZOwOr7oq79BjXUt3h+V646JuQVXHnT+xCOCiIrnIGg+o34WC+w/V18Rk
 lA0wWA/eGkHw+Po75Wu+trM8EE3GA+t8c1giSilUzqphY00AnbTEg9oeTS+eEHDd7ZH6
 fLALx098wd5uiozYsNK6wkhTUbL7AgdPPKDTqL+14vyz4NVlOSBmKfdH/BsWl8wVtXZi
 ICD112oupFGalw7G8Szi03uXee8WR0hLtzb+aMVFbmyoVbBupqwdOhhJT4iB1gHY9hhH
 2+1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ofLuCRtOzYddaqpYl5fe67zpqguyVwLeOqH+jYdYS7uYXdAUDHMC1DyGh6eSMELXAaoi9Sq3ozpDIyqck31nSLFoxupf1JfEpD5oalcshVVx21+X5Sd+Wa+dqEdMSqrtu0D/GjUaeC8ZsAO7nuT2lzK0tCrgrvptuCJsE3WZrM3QQ2Y17VdK
X-Gm-Message-State: AOJu0Yxni+ukjsQmLF4/TAVKgKXffN/kwSEUlTZj67s5rA7Of1lOsuod
 +m/NxFMPgEfdmWVirywG4LWODZbQKHOjtzyHo9dSPJUSKYQRj6kP+xHSGTy8
X-Google-Smtp-Source: AGHT+IFFdgetPlOtv92JBgFBPLw8fZBrYIefywwFgfiOwmYhnRTUSJ539sd1E8L5KVxhh7vlkJo+Zw==
X-Received: by 2002:a17:90b:110f:b0:2a2:2cbf:2144 with SMTP id
 gi15-20020a17090b110f00b002a22cbf2144mr2255243pjb.19.1712321632507; 
 Fri, 05 Apr 2024 05:53:52 -0700 (PDT)
Received: from wheely.local0.net (124-169-104-130.tpgi.com.au.
 [124.169.104.130]) by smtp.gmail.com with ESMTPSA id
 t19-20020a17090ae51300b002a2d8d34009sm2984414pjy.27.2024.04.05.05.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 05:53:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH-for-9.1 v2 0/3] target/ppc: fix tlb flushing race (plus
Date: Fri,  5 Apr 2024 22:53:35 +1000
Message-ID: <20240405125340.380828-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ppc's broadcast tlb flushe must ensure all vCPUs have invalidated
their TLBs when the tlbie sequence completes. This is not true in
the current TCG implementation, due to async_run_on_cpu() returning
before the remote CPU runs the job.

Fixing ppc requires moving to async_safe_run_on_cpu(), however this
API does not guarantee that either, and actually changing to the
tlb_flush_*_all_cpus_synced() variants introduces another race
which is that the flush is not even guaraneed to complete on the
local CPU. To ensure that it is, the tlbie has to be made the last
instruction in the TB.

Fixing ppc removes the last caller of the non-synced TLB flush
variants, we can remove some dead code too.

For others - at least arm, riscv, and s390x all use the
tlb_flush_*_all_cpus_synced() calls AFAIKS without ending the TB. But
it's possible I've missed where they do, or they have other issues that
mean it's not required for the flush to take effect until some later
operation which does end the TB. Maybe there is no problem, but it might
be worth looking at.

To reproduce, I have a kvm-unit-tests case for ppc but should be quite
easy to port to other archs. You just need to be careful for the local
CPU test case that your tlbi instruction is in the same TB as the
subsequent load/store that is to incorrectly use a stale translation.

https://gitlab.com/npiggin/kvm-unit-tests/-/tree/powerpc

The test 'powerpc/mmu.elf tlbie:tlbi-other-cpu' breaks with upstream
QEMU. If we use tlb_flush_*_all_cpus_synced() like other arch, then
'powerpc/mmu.elf tlbie:tlbi-this-cpu' also breaks.

Since v1 I understood the full problem and fix, and fixed the fix.

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: Fix broadcast tlbie synchronisation
  tcg/cputlb: Remove non-synced variants of global TLB flushes
  tcg/cputlb: remove other-cpu capability from TLB flushing

 docs/devel/multi-thread-tcg.rst              |  13 +-
 include/exec/exec-all.h                      |  97 ++-----------
 accel/tcg/cputlb.c                           | 145 ++-----------------
 target/ppc/helper_regs.c                     |   2 +-
 target/ppc/mmu_helper.c                      |   2 +-
 target/ppc/translate.c                       |   7 +
 target/ppc/translate/storage-ctrl-impl.c.inc |   7 +
 7 files changed, 44 insertions(+), 229 deletions(-)

-- 
2.43.0


