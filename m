Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D30C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bGF-0007To-MR; Tue, 15 Apr 2025 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4bG7-0007OI-Ud; Tue, 15 Apr 2025 04:03:08 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4bG6-0000ac-6k; Tue, 15 Apr 2025 04:03:07 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so5142203a91.3; 
 Tue, 15 Apr 2025 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744704184; x=1745308984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CuKJQuncCKUufm1Xqj/P0HNSYyB5UU+r6o8o5jNXXb0=;
 b=eH/7dIZn4pg969unwM92OUQP0+mTpOiHmoIn1BKCNSTLu3JdkW4MEoxk80OwxPdwEC
 03ZcXUJ7Ei8BYT13Fw4H3hxydqVF/BBYNtjTQ8jLwwwAjwZiVOP6xTbyYkwMFLc2p98q
 Pez/jWsC/76HsU9J+4ykAL6/Pevo9yCNMJd35DYsaiuT7cxQWQIHMuDLOT8ur6ZiJ7l/
 uFKBJE8jXiKUaIVnq/WAcDczf3yJ5ktuW0j0SqyfodycxbXONPq21ZoKgKfu8gPORrOw
 sKe/MX8+8AfHiCLhWqhBzVYvIPh8hcSXwqZ6S4NXc2buHTia1r4irLzbjxwZmL8I4/iN
 5mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704184; x=1745308984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CuKJQuncCKUufm1Xqj/P0HNSYyB5UU+r6o8o5jNXXb0=;
 b=c7/BVvsJ5rFYPJ0KNZuEi0Mp+r7szi9foRQz5nLnSE3l+4bjCacSlxOD03HszahfWD
 FftOHWwx6rpr9lrRXoea7CgITz33dTkmsuCFA2UMT09sLHCO9cGub8szIon59QbFWWDz
 Kxb9f3+Vuetg/XMCcj3w3+gi5YQ5iqvYUBqx/CDvliIhlXFu6g8yqsAq57VQW77Vdw2F
 ypA34uo3/vcpsAyNN5YpXIXU4GaP03RBUhsK+calVsqwNGDGZ6soz49k7mP7ZhATKqWB
 jTKy3mJhCmD8tLShYXwYg7X2Z3lTodEQF+ibOmj2C66mNK93Ld0gc58LY9IKdsQPqz4K
 Pntw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcvJsgr9knKEYqF2xjTj7b/xfo13tMn1X2PD1L0RhRz9zp49/gL/ENn5BfsRPFzoraVnNAIhv4NJjlIuE=@nongnu.org
X-Gm-Message-State: AOJu0YygfZ0HqHh/ryK9S3bB7ug2m7ynRTcEtYE8YXI11wzdvK1SsQuL
 w/9sI4YwAwbmUXl3U1P3+3ADSa0delFNVKJuOB97HPUTA/hfBT6T8EFgaPNm
X-Gm-Gg: ASbGncv0bakhD+knFC5oiLTAHr13sTkbc5zMpeg7xP6kBVKsWhh2Boa0/AT8DOWuDNz
 kri5qh3KgMTC7B+44tzgr0pV06pbLMVkRCzRargRZBktKAESiEa80ifRtkHCQ4l6nWreFLjljwm
 k+fIVC5yWlfG+gmy4EIcExTrNzeT/OAR63ZF0OVY12BuHJqeZBUKCgNflPeVcQ+xGyjCogfsXnv
 QnPPDZyHt6cY6SEHsUJ6HaUqi2/en5CtzbLEud3g7OZlOAPFJEHqmIk2Aj9Xaguh4skwAi8bWXR
 OFoQM1V4A+S4lFxxesjM5F0j/hyXGe8fMQHRU5ky
X-Google-Smtp-Source: AGHT+IFvLygAFWDMg5A9qPDUuqfGnLz7UMN9ZO6QujQT6A8DrALcyagX34a2lQLfp2KRtpmUCQJccg==
X-Received: by 2002:a17:90b:5188:b0:305:2d68:8d55 with SMTP id
 98e67ed59e1d1-30823633602mr22582540a91.8.1744704184099; 
 Tue, 15 Apr 2025 01:03:04 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd12b5c5sm12640745a91.24.2025.04.15.01.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:03:03 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, philmd@linaro.org, pbonzini@redhat.com
Subject: [PATCH v3 0/1] Fix endless translation loop of riscv
Date: Tue, 15 Apr 2025 16:02:53 +0800
Message-Id: <20250415080254.3667878-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pj1-x1029.google.com
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

This version fixes the return value `old_pte` not correctly handled in
my previous patch.

This patch refers to common usages of qatomic_cmpxchg like those in
target/i386/tcg/system/excp_helper.c and target/arm/ptw.c. I also add
a brief explanation of the correctness in the commit message.

Thanks Philippe Mathieu-Daudé for offering previous review for my
previous patch! 

Ziqiao Kong (1):
  target/riscv: fix endless translation loop on big endian systems

 target/riscv/cpu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1


