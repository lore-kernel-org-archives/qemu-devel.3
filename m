Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49098C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMGg-0005Ao-TE; Wed, 13 Mar 2024 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGY-00058G-Ty
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:23 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGX-00078l-2C
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:22 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513af1a29b1so3056430e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327318; x=1710932118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aeLIdO/x6mKNNGtYvUzEtvZN9YuH6++NOLOCo22Tmu8=;
 b=hetS5v8iHVuclAy+B29FMxDLoIzDG6fsbVHGRZu5D+/BDDHE+VlwTTyx1cVXilEw9K
 8uIRRSM/vY0KJLUpqmcjiwGkWZrchhKpZCVoMBeDEQBcn/3delaPbWTf2OBOiNZ+38GA
 CIOydDKi/cCfsgI3lVGmBK1rr0iFafiSZCNgdtp7D/duvMTjRIrapfw7UFVBopVn9DLQ
 4rZyyJ3nx0JbqvZ68YdMJ4Y/laKZW40UxHD0OVuTptbkMtWAY6zajjxtU8YRuzSeWf6N
 GL4f00LbF8VHp5acp7rQXF8W5mLs8VT9NXNAiUfNXzWLTJ02DVvBN7+P4wq8n6vvEWFU
 JP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327318; x=1710932118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeLIdO/x6mKNNGtYvUzEtvZN9YuH6++NOLOCo22Tmu8=;
 b=efFhVfJgkmHGPld/9NGUciN+PfATADRPzAOzBdgpJiaeg35CIFSa+vucIbmiL06dCb
 s6cgRSbDn4+89KG3c9wtQpqAzIMu6hXR4ZbcXfcpte8/lFlvhROLsEHx3Rv2gkhXz5XV
 hCYBPPHJ+Gs18DSxq2EYNeI1aP9kpTBuaXJuS0FtSzZPuc6GJqr0V0be6NOOWwFhTi7S
 D+VxpV0W6zpCDxhz1Cb44A83D+gqcg4uLJ2IdS42MUC72NedUOqFiRkLf2Akc7oUywMa
 RtZ/fbpOxwczA7djVYbiq2vytRHuhLNcTe9K4aPNqxl8oNZRayHbZagQ4nRvs/7a0LXY
 LB1w==
X-Gm-Message-State: AOJu0YxkAELZZM5ZEiVlR7b2u+jJabM6BRPkyGZN94l/fKoic1YfV1Fq
 87cpDQvtMZxUmvON8XlNIit6mLTa2ffijnSbpahb+1qw/xttkPhb4VUy2g0ntkClCwmO+DVUUFv
 ZLBU=
X-Google-Smtp-Source: AGHT+IEmycWvGk3xVtP0QIC08rf2E70PHLK7H52e76eBbOy7eVe0zKYeER4CwP3lgF1FhYRs3IOFbg==
X-Received: by 2002:a05:6512:1052:b0:512:f317:f5c0 with SMTP id
 c18-20020a056512105200b00512f317f5c0mr10054000lfb.42.1710327317757; 
 Wed, 13 Mar 2024 03:55:17 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b0033e1be7f3d8sm11390338wro.70.2024.03.13.03.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:55:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 0/5] Implement icount=auto using TCG Plugins
Date: Wed, 13 Mar 2024 14:54:59 +0400
Message-Id: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12b.google.com
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

The goal here is to be able to scale temporally execution of qemu-user/system,
using a given number of instructions per second.

We define a virtual clock, that can be late or in advance compared to real time.
When we are in advance, we slow execution (by sleeping) until catching real
time.

Finally, we should be able to cleanup icount=auto mode completely, and keep
icount usage for determistic purposes only.

It is built upon new TCG Plugins inline ops (store + conditional callbacks):
20240312075428.244210-1-pierrick.bouvier@linaro.org

Example in user-mode:

- Retrieve number of instructions to execute /bin/true
$ ./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true
cpu 0 insns: 120546
total insns: 120546
- Slow execution to match 5 seconds
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips,ips=$((120546/5)) /bin/true
real    0m4.985s

Alex Bennée (4):
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API

Pierrick Bouvier (1):
  contrib/plugins: add ips plugin example for cost modelling

 include/qemu/qemu-plugin.h                    |  23 ++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   1 +
 accel/qtest/qtest.c                           |   1 +
 contrib/plugins/ips.c                         | 239 ++++++++++++++++++
 plugins/api.c                                 |  31 +++
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                 |  11 +
 system/qtest.c                                |  27 +-
 util/qemu-timer.c                             |  26 ++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 15 files changed, 379 insertions(+), 26 deletions(-)
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


