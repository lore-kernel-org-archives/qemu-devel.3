Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9126E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQak-0003tL-FK; Wed, 24 Dec 2025 10:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZx-0002em-9K
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZu-0003HA-EA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so54534505e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589304; x=1767194104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29OVqUMLaQsKzXt2ITIZ8V00Bi0PBc0R85gFJ4t8yz0=;
 b=n/K2oqf781GnI9En1ybZA0nJrnXX5j7xVHgZNEgPcNdUhdoubkJr0XN4NMyT5Wmech
 dFLkKl6bNt8eNhYrvBf2cVx8qHRLZDPCEAX8pphjQtTx9ot/oZtMELmqVEKGxaBDnSgC
 V0kFAlNyQ2SPxybflodA63Np1GN4uEqP/jpj5iilq+cJ4L/8VdxFyG+mHdwP6biQl7qh
 kr+JQg8kSZuFuacbdUo//NOSPMpnR5UEKARBxS0rLuKqUChwEeTYyhgHC2zTK1ZhDk6F
 TwbzHUO9SJFsPPwoZCuqQhVC3D8nqqZY37pf8YbS7/4SEj59KRK1qf3Ts5+lRHmi64lB
 Zz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589304; x=1767194104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29OVqUMLaQsKzXt2ITIZ8V00Bi0PBc0R85gFJ4t8yz0=;
 b=Nz9qBsry5CMMGyoiQ4jLNbqbSFuctI4j8s+M2FhpOXHRk/tf50kIWLcbeHoo6ZUqYf
 7DBNFMb0JUbaFu7JEaxbjJe86CVZyA5RYFd7acV1r+vguo0uvybQ4GjKMzNo2CxA3jnC
 ObI0l6RH6vnuzbxOB15Gaywqi4XVifokgdYOVPZLHmxIlEb0K1X7S7Y6uOYhvYg8025U
 JCv+Mf1NhdKmtuIdR6Qbv07kg92//IS138bvgKBBvZjit90474xb84Rm2cKUMsZVAucl
 QBHKkzl+HmO8ZjRG3UbArRcQPpMw56+vU56SzDeuii8qKeyOD9v4V5673ju5tS8wIWIz
 bhvw==
X-Gm-Message-State: AOJu0YxXp4JXpnJxm8DCfwbwejVKsb/ENZpXkz3uIHcrlYVYqs75qgag
 /dVbG7l/r4QkrlG13B5EVqAf4rS1UHT2k7A1bMl/aJwTpPMJrNtprNSVubTxWaWHnaUn/EdfzR5
 ih5fFlYI=
X-Gm-Gg: AY/fxX5cj51VITQD5UqRK8gaXdL3T0WXMF39VD6m3s8vsJ3ycbnGS2Or3DEPJs6nlpm
 07gD51XhP0ZIU180C8v8QGgZ0V9aWhfTjsAEpTkA+Debb36kI5rHlN7UnjVerDZ/E7momb3UmDl
 J5aDon4v+tCsc+psJKfODSmGhmbVWuUZwf71OipiW7Qnytj4x/hR/oFjdv3GmQrT6/ykkIutTpG
 Kqc4572GVadCaW7IZFFZcUt8KiO3IqeJdZrV9X9qXlvi7XvsY9DjN6PZ03ITn//0O4rXGow8Bwx
 9cAAOzPrEMjwDxdStNVIAiksjRz1qEUW9lCdffCyI5r/KcC/F7b5H2IwFRqFGChgC8aHakvuhd0
 eAQha7GlAG0ukmfjG0XecuRCR8dF2+r+gfe8HMs0eX+NyeyBcKzQw3vu8JXptJXgkwZORPGENeZ
 hJV4lK+QUxbPTy7h9bntSVSHT8WTCzpJ9zTcUUJFpfmO2tV4qBWYkWd8k=
X-Google-Smtp-Source: AGHT+IE6dxLRujWp4AZgsTWnQKJqg9gYGPiqWzsT4Gjmdxf55S4jKIE38CsLQMbJdU+x/ILiNgp65w==
X-Received: by 2002:a05:600d:115:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-47d1997e733mr124968935e9.30.1766589304458; 
 Wed, 24 Dec 2025 07:15:04 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm361184265e9.7.2025.12.24.07.15.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:15:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] configs/targets: Mark targets not using legacy
 ldst_phys() API
Date: Wed, 24 Dec 2025 16:13:47 +0100
Message-ID: <20251224151351.86733-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Luckily these targets don't use the legacy ldst_phys() API at
all. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the API to them, avoiding further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/avr-softmmu.mak          | 1 +
 configs/targets/microblaze-softmmu.mak   | 1 +
 configs/targets/microblazeel-softmmu.mak | 1 +
 configs/targets/rx-softmmu.mak           | 1 +
 configs/targets/tricore-softmmu.mak      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index b6157fc465d..baf20fb7f2f 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index bab7b498c24..cf635798c90 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 8aee7ebc5cf..52feb957b48 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_ARCH=microblaze
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 1c250a6450d..3a90f1b9977 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= gdb-xml/rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 781ce49a62f..5e018d81068 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=tricore
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.52.0


