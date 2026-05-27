Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3AACD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDqT-0004Dx-BB; Wed, 27 May 2026 08:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSDqP-0004BF-Cm
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:58:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSDqN-00081p-K5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:58:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so77591325e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779886721; x=1780491521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmkaGBmXz63OfwFXK5yL3ohL7iGoSyYRoYxjunfShhM=;
 b=uTDMcena0qBWHJs4xFJFtNpQJ7FGUuBXfmqz3MhXpA76h0KeUzkCRWp53ri326WKPz
 wthFdfgSPVHnASFQ6GoAbE6MzPpJW8HM6d+Mmbya5K+79gB97vPZLiAXesHbeRNtWrMB
 +8mtOXYNJiVJGwy98Ov1932OIfBj3jTzJiC0XVCUDmx0hL/2fkoEs5KGRWOEra7TSSxN
 XjpPSS2Ah3YExAiG7GVfx9HVciDcK8EZK/b/uJt6zejkWNfAkASRSAXqZEGeNsT71quv
 bL0BqiYtMW655PbZv7qCNpcCszeWM2cwciLMv9rRN+R0KHhRVhxSLI0KIv73MkP2eaTD
 qBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886721; x=1780491521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmkaGBmXz63OfwFXK5yL3ohL7iGoSyYRoYxjunfShhM=;
 b=UKtyZdjLiwodM37FOWYkfhebuGaxTbuSN5oxQ9ESGPJx2qAnjnQVHoVn4NxqYqgwyd
 13WNuJKm0bU2gbxJMVlJ+kW1f8e7keQakd2BCyNkE+vRUI00V9a9SOhUnuSG0jv5gB08
 INPRaKPp1xgQ4YPzVFQmqZviPcJ6of8DVfKMZ0/CWpMMyZDdnGXxTYqjIuvB119aHSgM
 fYujRky6ps+MWGTaVvtQs9M3HFcQeVTJaJKFoY0cOyMJPgTUEWdr1N8oPZsHIgG5QoaK
 vYxNe7QFhYHlECq5FnsqI6TbYHQPhwA7A4cQEP/8Wzd2JoIilwRIVB2pY8oogk8dBb77
 tYAA==
X-Gm-Message-State: AOJu0Yy3y7OUbC1qvLXJhBeSVWCpK466jkRcovokeM2QvAp7ULe0kZvu
 OOmWn8CRKU1KiAreo2MB4M3k4k9sdR3+ucOtZusWviAt+wR2ua4IYoRvEDjNt7wUe3I=
X-Gm-Gg: Acq92OGuj8er8MmZRp5T473EgCYN4KIz0Dems83gA6klcjFjByxaFzjfDO4PfB/78rP
 wRcqFxyzzQy7Hov/nk/A0s5mv7wEABhGiGvG1diJ2UArzjFC3vXyryLGsrnQQMd3GlxlwL7luLh
 CZV4d4afTKjjZ6x64/HD/A5aywF1re6K566Xd0udbIp1mS5l3F1hrkEthbkgqeIGiU0993LKIe3
 dTZ15SHxWZBDR93IeeAJdb9qGbqFYj0WstsUzRGMOwHAfQ7YxfZifVa9wy1Nx7LXsKXDFLBZDZ3
 3u8MI4srHbuykpK+I/TL7X8kko7Sii+SkusmPg4LEkvnFkfUSU/2NiTSFBPtUbCsuWmr5xNBER2
 jDXE+oGSF3Ix3788t/quOKXm9A7MCAKdZDosQszRz60pL6hZYWKkdm3qR4TfnI22932kDiinLce
 Za+WNL5wTMBY01Pjfa+mc5VKU=
X-Received: by 2002:a05:600c:3e12:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-49042481066mr337575375e9.9.1779886721202; 
 Wed, 27 May 2026 05:58:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac676sm429859485e9.13.2026.05.27.05.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:58:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93D9E5F7F0;
 Wed, 27 May 2026 13:58:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Torbjorn SVENSSON <torbjorn.svensson@foss.st.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-arm@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PING] [PATCH 0/3] target/arm: add support for Cortex-M pointer
 authentication code
In-Reply-To: <b50cb0e2-5198-460c-abee-ba86c7002a96@foss.st.com> (Torbjorn
 SVENSSON's message of "Wed, 27 May 2026 09:36:03 +0200")
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <b50cb0e2-5198-460c-abee-ba86c7002a96@foss.st.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 13:58:39 +0100
Message-ID: <87mrxlxb40.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Torbjorn SVENSSON <torbjorn.svensson@foss.st.com> writes:

> Gentle ping! :)
>
> There is apparently also a ticket for this work (that I did not see befor=
e I sent the patches): https://linaro.atlassian.net/browse/QEMU-444
>

The Linaro tickets are public (because we work directly upstream)
although the existence of a ticket should not imply that we plan to work
on it. We create tickets for most of the Arm CPU features so we can
track dependencies, what is left to do and when others have patches that
need review.

Our actual planned roadmap can be seen here: https://linaro.atlassian.net/w=
iki/spaces/QEMU/overview

>
> On 2026-05-18 18:13, Torbj=C3=B6rn SVENSSON wrote:
>> Testing an arm-none-eabi GCC toolchain using QEMU gives unpredictable
>> test results for some test cases. In the GCC testsuite function
>> check_effective_target_arm_pacbti_hw, the testsuite tries to identify
>> if the target supports PACBTI instructions. The test consists of:
>>          __attribute__ ((naked)) int
>>          main (void)
>>          {
>>            asm ("pac r12, lr, sp");
>>            asm ("mov r0, #0");
>>            asm ("autg r12, lr, sp");
>>            asm ("bx lr");
>>          }
>> Running the above code in QEMU will cause LR to get corrupted.
>> The reson for the corruption is that AUTG overlaps with the SMMLA
>> instruction, and SMMLA will write the result to Rn, that for
>> `AUTG R12, LR, SP` happens to match `LR`.
>
> The above statement is not entirely true.
> SMMLA is writing the result to Rd and that happens to match PC, not Rn an=
d LR.
> Sorry for the confusion this might have caused.
>
> Kind regards,
> Torbj=C3=B6rn
>
>> The solution to the above problem is to define the following new
>> Cortex-M instructions in QEMU:
>> * AUT
>> * AUTG
>> * BXAUT
>> * PAC
>> * PACBTI
>> * PACG
>> This patch series only implements the pointer authentication code
>> part
>> of PACBTI. The branch target identification part is not implemented.
>> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>
>> ---
>> Torbj=C3=B6rn SVENSSON (3):
>>        target/arm/tcg: define cortex-m85 cpu
>>        target/arm/tcg: add PAC related instructions
>>        target/arm: implement v8.1-m PAC support
>>   target/arm/cpu-features.h  |   6 ++
>>   target/arm/internals.h     |   2 +
>>   target/arm/tcg/cpu-v7m.c   |  40 +++++++++++++
>>   target/arm/tcg/m_helper.c  |  17 ++++++
>>   target/arm/tcg/t32.decode  |  21 ++++++-
>>   target/arm/tcg/translate.c | 138 +++++++++++++++++++++++++++++++++++++=
++++++++
>>   6 files changed, 221 insertions(+), 3 deletions(-)
>> ---
>> base-commit: ac6721b88df944ade0048822b2b74210f543d656
>> change-id: 20260518-pr-pacbti-366d7acbe1be
>> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

