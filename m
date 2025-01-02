Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE344E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPt1-0007wM-DD; Thu, 02 Jan 2025 13:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPsy-0007mV-Q1
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPsu-0007rQ-CW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so8864923f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735842323; x=1736447123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jK2yBpkIHnh1LAl5uT+d4QXAYiiQhFTrpHhJ+3UqzPQ=;
 b=DzZMP6q+v38cB5y9oCYjwIkZI4gwa6Fyhunhn1ANQO/zP0hi1KhGXoWz4a0wdIUI6i
 6xnNxpHYSUC2eG15AFAinjAihNz7cEH0/mxnKdeXEAR14dhF6DmhKVwNofO2Pgem5IRE
 Njc+yBeXwPmW0AZn49ChhkPedeBcoa3lDxm0IVqHoX0N3WP4/KNjf3Myq2e+sBCbZwKh
 XM4U9tTWYasnPIV6kBf9ZHSIl7KKoxybR7CU5ab9+n2iApVteUG9cktOmRo9yOFhzCQX
 1dnooOsBELi7Nphx+OaKr3HsR6SOi2MShUMsOOT8DF0Hw1A29MIxBs9K+RVD8WuaTEk4
 gteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735842323; x=1736447123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jK2yBpkIHnh1LAl5uT+d4QXAYiiQhFTrpHhJ+3UqzPQ=;
 b=azFlaYFczAapAUqZFfzSC2FQ3nU1KEWD2z4866/n1wAl4FjpX8Oer8z7TOo4v18bKU
 OV5KG6Lrvfd0aUbeSLp0MS60Eq0RA57gM8+iGiE2XzMcsdWrb+hUpkw/jkLTikFuaZ7x
 +4NcSUPc+unP15m4aQp3C9hQFPSdM3aqelsFIisf1CONj2d1KOrgiyVXGg93W35QfF3P
 RCAxpPUA8R0H2ZnxpsVayqtUuffT72NaA0apN0zpwMawxB29Tp3JPzFnprDV2eMSETiV
 v5A1EbMsc11Azp9sUmzgxlkXJoRFRHTO1Lcel1kDWTTdPKWMKzG/d/e/58iJQFrbZaWJ
 amPg==
X-Gm-Message-State: AOJu0YwCMLLKcxx/p2Y/nkUH+9hWAg5CwNUD3n71ykCWfzRS+JXSZN7G
 g6J09yxxFrupy+AaFhgMEFCoZO/i5ueAjJEynna5iOK8fIsDcM9BeNpJQFAlnU83eLZ+MhPxeT9
 oWI4EWg==
X-Gm-Gg: ASbGncti/JIXqC5SNY7wyoBNT+VkzzxmSII8vQuu9YlyI1q14z4MiINkt0GTJ7j91Ov
 O9+DoSpywuRotRCXqpG9Upqh/Eu5/uRbUHbeyn+YzhG6hhHLC2L1+C+wUUwsE/N0f7Cb7SUfIh1
 MEF1bIyEqTojpGDphs1q8nv5eX0Nccif8rwde0K8y+d+3vGepQV0wiqUBkNgiRE348VVA2H+rTp
 R4FLRw+xXttjrDST0dmOzH9wSAlszFEJAGXTrVkIposL2b2Wjuq5UCRkRJRMjPvQfBLHFAj2GF8
 C4+U8VA8WJ/r0Tzx/82rkGDmuKEniyg=
X-Google-Smtp-Source: AGHT+IFyA8zkiX7VC5zJdvgoXq837oN4eVeHzZOemNhRJ91sDVki+Wm2heUpuvo3pWH4Hdzt8ETgQg==
X-Received: by 2002:a05:6000:2c6:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-38a221e2d13mr38876114f8f.9.1735842323534; 
 Thu, 02 Jan 2025 10:25:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84ca21sm39011792f8f.63.2025.01.02.10.25.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 10:25:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] linux-user: Call tcg_flush_jmp_cache() before re-using
 threads
Date: Thu,  2 Jan 2025 19:25:18 +0100
Message-ID: <20250102182521.65428-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Fix a bug reported by Ilya in:
https://lore.kernel.org/qemu-devel/uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc/

Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold()
out") wanted to restrict tlb_flush() to system emulation,
but inadvertently also restricted tcg_flush_jmp_cache(),
which was before called on user emulation via:

  Realize -> Reset -> cpu_common_reset_hold()

Since threads (vCPUs) use a common CPUJumpCache, when many
threads are created / joined, they eventually end re-using
a CPUJumpCache entry, which was cleared when the first vCPU
was allocated (via Realize) but then stayed dirty.

Have cpu_exec_reset_hold() call the common tcg_exec_reset()
helper on user emulation, eventually calling tcg_flush_jmp_cache().

Philippe Mathieu-Daudé (3):
  linux-user: Only include 'exec/tb-flush.h' header when necessary
  accel/tcg: Factor out common tcg_exec_reset() helper
  accel/tcg: Implement cpu_exec_reset_hold() on user emulation

 accel/tcg/internal-common.h | 1 +
 linux-user/user-internals.h | 1 -
 accel/tcg/cpu-exec-common.c | 6 ++++++
 accel/tcg/tcg-accel-ops.c   | 4 ++--
 accel/tcg/user-exec-stub.c  | 4 ----
 accel/tcg/user-exec.c       | 5 +++++
 linux-user/mmap.c           | 1 +
 linux-user/syscall.c        | 1 +
 8 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.47.1


