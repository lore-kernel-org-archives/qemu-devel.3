Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EADC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83R2-0005ji-Na; Thu, 24 Apr 2025 16:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83R0-0005jT-Qp
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:44:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83Qy-0007Iv-PR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:44:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so1045292f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745527474; x=1746132274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daebZoojvsEO1NrZuYzzqYzXPjn/N0cewXboicJ8mYM=;
 b=Vl1wv9GE55bfOtfpomCM1WH6ZY6GQXyw/nQFNgN1Rdc1ynmYeOZaN+SA0THRzBZzXK
 uI6KhGX3U2B1eTNxj1/etQBAl2LAOwHAg3ZDQV2Ij4otMac8WrgDj9S/iKeVoByPOKlZ
 Lozqq0ZqHuqGSe0chMPtWu6iSiQQ1esk+aVwENoWTK/zZGGle2ErJErXdKmYQP/8/pnI
 3IJizfWbThQDISsbCC7qfRojuygrOFdoxQbFi/Sye/WPeO+B6GhEllVAFJdJxk0nDksS
 G5DrkOHLUOLHtGHQ72ZR4zBB9yao0DxKu7Lnv4kqrLbf125JCa1kjQsjqXXsRwhuDWfA
 k9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745527474; x=1746132274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daebZoojvsEO1NrZuYzzqYzXPjn/N0cewXboicJ8mYM=;
 b=suPvWxyyCiYi4wMiLza1JKNRaHpC778EwpiDGo18q/bTFYBlpFdLpIFCWsAiKZsZW7
 xLt0TWUUHNqM2WcgwChap0TKehqbx1PJDs/7C8814DxvfxY+R4tYt9Ogmyg19eKuKbc1
 jxvs+fti0LAWv8Hy4/yr4p7wlasKXH1uyKxXQvgbEIuWJcTkrNv3kCOPPf1Q2zEZtENL
 VLvgEHkAlEh2BJcN0WZ4u3oMd/tnP54U6JZYNZWqFOvXH3bo6cRWpjxlp6io79+6YtSO
 ZX9x4TzADlN9lrQms0Isp4Z6Xj/qpFfex3cD99QNYLEQ8FnclE5H7tBKyq4L1bbY5dms
 KsrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdWc/8JDwNhwJ8bIOE3bj7e0T/LuSNNxqwyLq51t3bQAwML/Bs5nfmgw3FSYv0RQvQrGHazMDP2XNb@nongnu.org
X-Gm-Message-State: AOJu0YylEF3jJ5wB84mCijM04kHBuZRkphYM30enNpQ4LXYHNe//aQec
 OKRZSa4F0pm3R5VCL10jE9gWlxXD4fCg45jhGqd5xkjXBoAMVQb/KvP+ukYixYg=
X-Gm-Gg: ASbGncuDLKnJVZGO6J2AuxsoaY7pS0K8hIoyNXhv3a+sI1N4YeFOopDQoMBF5PyBUcZ
 IOFCNPwvbD7YMvHIkHnt2uXORgD28gteISrHazVtQp5HCNlmts7TLv0sGbC888SJgIGa7Ezvul/
 IRnqdZp47bPFKSskJ3175aM3TiEsMIWs+5KSXLq7AD/DxqsMffL2V9Mn9rvPyYp341Ufwhz/mr5
 +vQJyMs7SdrXU/n11o+RHUzrTYxS6CtuEg5FMRruk5FgzTlH16XYabezykSUTniHClf/NedW4Dl
 abPlzpW4ucdPIonSQu0BWb0gQhJ/yDiq8+bdQDcW41YxQk0SRRXLo8VLyS8pQCY4ujmXUalQT7x
 euL+Ulfmc
X-Google-Smtp-Source: AGHT+IFWqhYFHGluKAzPOwoWKoAKWzC1Fcd08ND6FYx4SYds3G+aooK/kRsHBigoV2Zn7KVrURYm1Q==
X-Received: by 2002:a05:6000:290d:b0:3a0:65bc:3543 with SMTP id
 ffacd0b85a97d-3a072afc393mr546319f8f.35.1745527473582; 
 Thu, 24 Apr 2025 13:44:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbede5sm324162f8f.49.2025.04.24.13.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:44:33 -0700 (PDT)
Message-ID: <98f12f3b-10c2-453f-8887-c3132ec50343@linaro.org>
Date: Thu, 24 Apr 2025 22:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

+Marc-André, Daniel & Dave

On 24/4/25 20:33, Pierrick Bouvier wrote:
> Note: This RFC was posted to trigger a discussion around this topic, and it's
> not expected to merge it as it is.
> 
> Context
> =======
> 
> Linaro is working towards heterogeneous emulation, mixing several architectures
> in a single QEMU process. The first prerequisite is to be able to build such a
> binary, which we commonly name "single-binary" in our various series.
> An (incomplete) list of series is available here:
> https://patchew.org/search?q=project%3AQEMU+single-binary
> 
> We don't expect to change existing command line interface or any observable
> behaviour, it should be identical to existing binaries. If anyone notices a
> difference, it will be a bug.
> 
> The first objective we target is to combine qemu-system-arm and
> qemu-system-aarch64 in a single binary, showing that we can build and link such
> a thing. While being useless from a feature point of view, it allows us to make
> good progress towards the goal, and unify two "distinct" architectures, and gain
> experience on problems met.
> 
> Our current approach is to remove compilation units duplication to be able to
> link all object files together. One of the concerned subsystem is QAPI.
> 
> QAPI
> ====
> 
> QAPI generated files contain conditional clauses to define various structures,
> enums, and commands only for specific targets. This forces files to be
> compiled for every target. What we try to do here is to build them only once
> instead.
> 
> In the past, we identied that the best approach to solve this is to expose code
> for all targets (thus removing all #if clauses), and stub missing
> symbols for concerned targets.
> 
> This series build QAPI generated code once, by removing all TARGET_{arch} and
> CONFIG_KVM clauses. What it does *not* at the moment is:
> - prevent target specific commands to be visible for all targets
>    (see TODO comment on patch 2 explaining how to address this)
> - nothing was done to hide all this from generated documentation
> 
>  From what I understood, the only thing that matters is to limit qmp commands
> visible. Exposing enums, structure, or events is not a problem, since they
> won't be used/triggered for non concerned targets. Please correct me if this is
> wrong, and if there are unexpected consequences for libvirt or other consumers.
> 
> Impact on code size
> ===================
> 
> There is a strong focus on keeping QEMU fast and small. Concerning performance,
> there is no impact, as the only thing that would change is to conditionally
> check current target to register some commands.
> Concerning code size, you can find the impact on various qemu-system binaries
> with optimized and stripped build.
> 
> upstream:
> 12588   ./build/qemu-system-s390x
> 83992   ./build/qemu-system-x86_64
> 31884   ./build/qemu-system-aarch64
> upstream + this series:
> 12644   ./build/qemu-system-s390x (+56kB, +0.004%)
> 84076   ./build/qemu-system-x86_64 (+84kB, +0.001%)
> 31944   ./build/qemu-system-aarch64 (+60kB, +0.001%)
> 
> Feedback
> ========
> 
> The goal of this series is to be spark a conversation around following topics:
> 
> - Would you be open to such an approach? (expose all code, and restrict commands
>    registered at runtime only for specific targets)
> 
> - Are there unexpected consequences for libvirt or other consumers to expose
>    more definitions than what we have now?
> 
> - Would you recommend another approach instead? I experimented with having per
>    target generated files, but we still need to expose quite a lot in headers, so
>    my opinion is that it's much more complicated for zero benefit. As well, the
>    code size impact is more than negligible, so the simpler, the better.
> 
> Feel free to add anyone I could have missed in CC.
> 
> Regards,
> Pierrick
> 
> Pierrick Bouvier (3):
>    qapi: add weak stubs for target specific commands
>    qapi: always expose TARGET_* or CONFIG_KVM code
>    qapi: make all generated files common
> 
>   qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>   qapi/meson.build           |  5 ++++-
>   scripts/qapi/commands.py   |  4 ++++
>   scripts/qapi/common.py     |  4 +++-
>   4 files changed, 49 insertions(+), 2 deletions(-)
>   create mode 100644 qapi/commands-weak-stubs.c
> 


