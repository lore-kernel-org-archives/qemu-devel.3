Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63368D0D15D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdY90-0006Dr-So; Wed, 07 Jan 2026 13:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY8x-0006DP-9D
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY8u-0005hu-1b
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso14899435e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767810021; x=1768414821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0G8ePG/xwYeYm53w8/0ob6ClKk4HM+nSjzkRTPCGon4=;
 b=qm4uBqAQ5OhhAFaOTJ66lGX6A1KOOIcI5/TX44KQY3l+MaW+TtSv0NW3+k5z1/8hZz
 d2RBZiW/5LOTe8tqrtFQ8Por4rVcoCrgZVMVbDByvTMjYSXcp4Vq1HBawJZSmvkxDLTQ
 9U3Z4y9v71t3r/iEMjRdOwA5SKYKKvG3mUNZKF1P0OJGZTtw+3Ut+6FcDz3e5kj8LCoq
 YjvLE0ayW8aEjZRlh+zhoQENg5oVL8B5L8+PK7VBMteQPtTWJx3fRKZmjFIiVHmBu/Kd
 39ggQOIdj8yR8urOQw4opGq/9/mucJlA0LAQ7LoR2nhFj7TsvjuosuNvS2+INT+6OH8c
 bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767810021; x=1768414821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0G8ePG/xwYeYm53w8/0ob6ClKk4HM+nSjzkRTPCGon4=;
 b=UAsz1obWcxll2tC467JPpI+YXms5mXrp9IBcHZOSXMkNPz2XdByu8+puJfUr2bnPKF
 0jqUffm5PgTQuS0Is/148CcsLzLcp18v8UDDuore7NuffUjiAU+mrEUlx21HeAyIWDvC
 j0ZPwsEnJfxPi2PHU3kt+R5zVxw5SjgOn4ocu/DW4Gghfewf9vZHnLJ4tA4nUmTMkYWW
 8Z6g9TVhE2fWzkVVFRQygCPNinVLEbe3UEAXdGN2ItURh3YFKQ7Ffn3Q4Kk2NZUkFZNP
 dy1vVtjNKU/cMUc3Vb43ZDWWE7TWWGhIvDCjJXGzjJRIvksvFf11zlVIWBLkkf2XaRpD
 vAFw==
X-Gm-Message-State: AOJu0YxUX7u5klEMynlJACvNH0oCW+6ee47waAiJ7S3AntaGyB2h8XzD
 Gx8Ir0aeJZAmk7UNba7rCkv9e85XstZmRzmU8FWZpkM7niPi4J/SWxa3jIK3wUHl4/Gn7gWLQY8
 GRRWAtgw=
X-Gm-Gg: AY/fxX5KVrZ0Ms+ELXuNCxEaqZg9GKhQ6qi3r6jC2mVFfM5HeFjdlTCLljFQ4u197KW
 Hnqi4F3m1/jHDMHJ5ijPPhoGpvT5+hvpOdOIjABvZqy01YGo2kDXP3bCi+AvuJmiwVgB8Jsn0Hb
 CygH5loEap/6M+0v9agTZfQQ0orYEXLlJkvWO0Qc/jGjXTxceshQn3n74IYe0pAXP5Kp5gCSsAK
 DCzWskme4OgdGDIMM4X/bWiQCGc/Rg1UtkhIERown/dOniqHj4omvL+jQYE2YGYM5yiuu2L6NsX
 HvnqFpJa1JdlLUJTGMYU70sGW2CqG9K04FtwRN/u+crLBnhjREXov1EdS9MLXDX6wiQlvM3kIwn
 Zko77uhzG+rzo6NRVaAEvtINgSr+VsT7sccNxVminYj9qYby6ebs5xOvEJolJ6qB4VX9j9JE/2w
 TqVpMza5bLuVOqpJ5lGR1rlbexibhM+/ar8tCIn6ffxcQUNCweITzHxYwhUCkx
X-Google-Smtp-Source: AGHT+IHZddU/+QYJbjNbz15Pb3DeYc9JOZhDRMU1bkJlileLWYwTVGdaoDyg2bwa0BBFaQ/mFA7F9Q==
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d84b3b719mr48554465e9.31.1767810021486; 
 Wed, 07 Jan 2026 10:20:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm111603055e9.0.2026.01.07.10.20.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] monitor/hmp: Reduce target-specific definitions
Date: Wed,  7 Jan 2026 19:20:17 +0100
Message-ID: <20260107182019.51769-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move most of target-agnostic definitions from
"monitor/hmp-target.h" to "monitor/hmp.h" to
reduce files target-poisoning.

Philippe Mathieu-Daudé (2):
  target/i386: Include missing 'svm.h' header in 'sev.h'
  monitor/hmp: Reduce target-specific definitions

 include/monitor/hmp-target.h  | 28 +++++-----------------------
 include/monitor/hmp.h         | 23 +++++++++++++++++++++++
 target/i386/sev.h             |  2 ++
 hw/i386/sgx-stub.c            |  2 +-
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  2 +-
 target/i386/sev-system-stub.c |  2 +-
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  1 +
 target/riscv/monitor.c        |  1 +
 target/sh4/monitor.c          |  1 -
 target/xtensa/monitor.c       |  1 -
 14 files changed, 36 insertions(+), 32 deletions(-)

-- 
2.52.0


