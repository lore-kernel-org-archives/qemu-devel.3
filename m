Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F8FCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1K9-0000MK-JE; Wed, 29 Oct 2025 04:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1K0-0000H4-Vw
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:14:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Jt-0004zd-Q6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:14:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47114a40161so77875525e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725650; x=1762330450; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=utZpS5XcNdUXDjEy2icG4A48+qvfCU4a3CJWGYsuPLk=;
 b=GKlC53jJ/meVo3+inmopC+maKqcKO6kkOBxiWFsAoVrdayKuuIgxiF5v8/t8joYV7H
 f3+gnK6hRBsomO2ECeXWsc50PLTTj3zHy5Ir8P6wXmGC4k0qSXRIA0u6g5Oud7zgX8Zq
 WaUw3m9Poj1TVNXso/yji+BJInSbTXmcn5fH0ue90hXIj+ycgrySUIyjRsUWvq33AfUg
 LOkHpvLz8QshR+hTGJD4nXEYQAFctLU3DONLMc3T4KIkQXbGWy+ccvU+yYU5soU+FbhM
 R5GCtVSLKSLhArwaGCojz50PBM8T1tl5nzaLaGhJtILB4N/7tKC182AjDNxJecvl9eQ3
 4f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725650; x=1762330450;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utZpS5XcNdUXDjEy2icG4A48+qvfCU4a3CJWGYsuPLk=;
 b=KFBwsU6eEcJlIlPBK7Zj1i3tLMb2ud7TFGdV1wsxFaveV7jexSro57hFbihBJhDNnY
 6kfXpHJ4SYx8KnrnRSPT/M1RYluYhiywV58BqE5TgiD3GDETBEqRvBmR3l93GLqlJI7J
 ezc4duqpMjjOgQGwpXDzgu/GKVR/XrCaQdX9AX74Jk/+oB43CN0bdy/xmBqdyW7ALFAi
 MakNh3QbMacrJquWB0KGfCigBowCzixVBlDn37O4BKKthkDE4Sg5s5Iv8TntY6ZyLIUS
 ppv5GWYpMigGG9KtxEPQDuaUrf6viZjCSUSQLsBUeGHnl7hNZYtUQMDo4a1lDAu68PWZ
 b9Og==
X-Gm-Message-State: AOJu0YxqzLWHBYzrsKUNKbEZiK6AJvJz3jG7FvopXxKlhRoAN2d9rFEh
 oXh8Le5ph2uB0+ha8cFR5W8JMa7rzzaI4M66KXb4gsR17R961A6G4qUZAExcGSIiqqjkK/FKlGH
 nzxUB
X-Gm-Gg: ASbGncsNv/E8x9rDdkzVSGOLKfoZOsUu+tgyN/maSbM84OQT1e/i4Ph4iBrAd6L72fs
 jpwCofCfyqrnxGGz50j98+GUOT6yQCSdoHXfRoAT/sooFysussVNmc1l3G0/mgSVI79YiOYFT7/
 JP17pbeQPN+/txIrD5e5dwKY5fDUs4Uwb4+cl66Pwhuz1t84It92xTQyH+LZTyiLuL85PApJ56J
 zVmSH7201QytlGv4qymQw6hPTw8oTO7nDhG1HP7DiABd6YYJs+cKwX0pkCZUNVX9Rm70W/qqVWJ
 Wf3sSilAd4RE4VVAx9TTn5iBD/8CqFXrWmZoZsRdmFjaEOsTJFPAtt3UUt79LRVAkhQ/udoDQwf
 VnV86QMaZ8r6BInitJE1AAZSzhVFqsK9zWtQSmchYvo4UNPFmz3zuEwwBDYznboduzaEqWHdfsk
 y8UkH2uATSJMBaz/5EWgY+0Id5gqjRxxsNNPOBzJzILiVVmaX8
X-Google-Smtp-Source: AGHT+IGe0QAwil3HRHsL1f+brsYo1R2IDj27kRaROm84jCx7ds86A2azE4hTCXen23RNyZx98a95jA==
X-Received: by 2002:a05:600c:3506:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-4771e3b849fmr17106615e9.30.1761725650574; 
 Wed, 29 Oct 2025 01:14:10 -0700 (PDT)
Received: from meli-email.org (athedsl-4440624.home.otenet.gr. [79.129.178.32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771bc597c7sm29848275e9.1.2025.10.29.01.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 01:14:10 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:13:42 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 02/35] scripts/ci/setup: regenerate yaml
User-Agent: meli/0.8.12
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-3-alex.bennee@linaro.org>
In-Reply-To: <20251027110344.2289945-3-alex.bennee@linaro.org>
Message-ID: <t4vw7k.qshbmizu7wto@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.737,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 27 Oct 2025 13:03, Alex Bennée <alex.bennee@linaro.org> wrote:
>We inadvertently updated the base libvirt-ci project which has
>resulted in changes. Make sure the output matches what we generate.
>
>Fixes: 0d4fb8f746d (configure: set the bindgen cross target)
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml | 4 ++--
> scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
>index ce632d97108..70063db198e 100644
>--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
>+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
>@@ -26,7 +26,7 @@ packages:
>   - git
>   - hostname
>   - libaio-dev
>-  - libasan6
>+  - libasan8
>   - libasound2-dev
>   - libattr1-dev
>   - libbpf-dev
>@@ -37,7 +37,7 @@ packages:
>   - libcap-ng-dev
>   - libcapstone-dev
>   - libcbor-dev
>-  - libclang-dev
>+  - libclang-rt-dev
>   - libcmocka-dev
>   - libcurl4-gnutls-dev
>   - libdaxctl-dev
>diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
>index f45f75c9602..4f1a49be34a 100644
>--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
>+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
>@@ -26,7 +26,7 @@ packages:
>   - git
>   - hostname
>   - libaio-dev
>-  - libasan6
>+  - libasan8
>   - libasound2-dev
>   - libattr1-dev
>   - libbpf-dev
>@@ -37,7 +37,7 @@ packages:
>   - libcap-ng-dev
>   - libcapstone-dev
>   - libcbor-dev
>-  - libclang-dev
>+  - libclang-rt-dev
>   - libcmocka-dev
>   - libcurl4-gnutls-dev
>   - libdaxctl-dev
>-- 
>2.47.3
>
>

