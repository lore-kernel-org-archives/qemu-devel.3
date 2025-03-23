Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE52C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTzp-0005vZ-O1; Sun, 23 Mar 2025 18:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzn-0005uu-62
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzj-000684-JA
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3996af42857so3065883f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769637; x=1743374437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUzza3AvpEPfaWJWwigxhFBok8Yah8voXDxqR6U1fGw=;
 b=C1sQrKrEqS//U0PE5zh1pi5SLETrv4j5L4eRBi3L+KnnLQ5i4yw7keLZIQGZAOTsSU
 8XerG5c8OBut4OWXjE4CLa7cRODk08rrdF4a4fne9MTANukAXCASSZN4j3zgDIdfk5ZG
 LIhvXWkPwws9JhLvH+lGAHaLZcV93z1ot+tDCy+JmParNeSen00LblKk3v/Qc6xQjb6b
 YLOnRtCKci5vt1eGeXi3jRFZN/7unyAyyu2eBH6ZzfQsO1k0rxh8zrE0ui5JmuEA8gLZ
 /CT8UN2e75ZFJSWUoBpo4/oXPdfw58CqNqhaHnYROM/63IHquW03QYFTR7T1UxOMF8a7
 uvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769637; x=1743374437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUzza3AvpEPfaWJWwigxhFBok8Yah8voXDxqR6U1fGw=;
 b=b3cjchaPuJaL0Mh+hY3q3RTRDW2P0kgjAYSRJDnqO1z+0UdR1fZ9uYE2RElJSuNcVk
 t71U/quEVx1WntQnPu5VyqCxHpN5lkkHO+BNpZcjN8WGsx/1YtFjs8+ZUhGO9udW6WdI
 vqAm8lqkwvY8RbAbGjg+gyXZq304gsbM6IUFQ1eagjRzZ5BpuP5SfcNLXQcVg6WzfYjK
 uo0Y2ARt8YXjjy1Zzt6a/3AcRhSDHNK+AioTzK+H9vcLTcD7F8L5mb7oS+rlxcVw0ZFi
 aRbkKom4vDpVzysYQwmNIacsaH1FNGtIg8+mXgHLnXfHSUfQqESoFoafbbMePKdr7FI5
 KxXg==
X-Gm-Message-State: AOJu0YxETsu75fZ1zD2pCG3ENMg+P+kX5kmGh3UR8wEpTda8Ud5RBrOy
 mQvYKpcrBpw1R30NjS/v46XpKAGALAB/nEY1tMbTFKaBZn4yG4Rm0KkkktZaQtkXDMyK2oVIQJY
 X
X-Gm-Gg: ASbGnctbot5o6jE1FHtgxoxbDRH99Cu7uynY3rg4+2GQtpM0n1yL8GYfvYTU97Y1fVB
 ph28Qh+zuvDhcnhBz6tYV/KZc9QmOlP1zmbz2zlNjqWu19KZtxJe/6XNPlMv++7eu63wdrcKTOq
 CxAwOJd7bU8oD8r11TZyrw5a80t/yWkWLWoraLECoF/Mwf5a+DBvBwr1xTXW1OtorN/wXpMUYLs
 bzgwg5yG8GzVLsZvWnw8ChiJkRu4voYs1r4Q3efDbI8DjfG44oQRYjI4UD/i83GDx7js6ZCm+qk
 ypTb2J60LQ/h7JehgpN02hgw0F88pKwHpJKuAt30KuFf6/Ytx0VgMZdjwD1ZBIgjpkHqf1y/RE+
 /qS7hDgXmx4e93hRRmZ99/JET
X-Google-Smtp-Source: AGHT+IH1o7jidLPC7EmCNJERyEwibmyaN9bWu1oir6BayLoTzS06ftnPf9udLhhmkETV3oHQARkMCQ==
X-Received: by 2002:a05:6000:1565:b0:38d:b028:d906 with SMTP id
 ffacd0b85a97d-3997f933816mr9204362f8f.21.1742769637325; 
 Sun, 23 Mar 2025 15:40:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3a10sm8856262f8f.28.2025.03.23.15.40.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/6] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
Date: Sun, 23 Mar 2025 23:40:29 +0100
Message-ID: <20250323224035.34698-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

'cpu_list' might be defined per target, and force code to be
built per-target. We can avoid that by introducing a CPUClass
callback.

This series combined with another which converts CPU_RESOLVING_TYPE
to a runtime helper, allows to move most of cpu-target to common.

Philippe Mathieu-Daudé (6):
  cpus: Introduce CPUClass::list_cpus() callback
  target/i386: Register CPUClass:list_cpus
  target/ppc: Register CPUClass:list_cpus
  target/sparc: Register CPUClass:list_cpus
  target/sparc: Register CPUClass:list_cpus
  cpus: Remove #ifdef check on cpu_list definition

 include/hw/core/cpu.h |  2 ++
 target/i386/cpu.h     |  3 ---
 target/ppc/cpu.h      |  4 ----
 target/s390x/cpu.h    |  1 -
 target/sparc/cpu.h    |  3 ---
 cpu-target.c          | 25 ++++++++++++-------------
 target/i386/cpu.c     |  3 ++-
 target/ppc/cpu_init.c |  3 ++-
 target/s390x/cpu.c    |  1 +
 target/sparc/cpu.c    |  3 ++-
 10 files changed, 21 insertions(+), 27 deletions(-)

-- 
2.47.1


