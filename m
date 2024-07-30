Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYrdP-0007dg-D3; Tue, 30 Jul 2024 14:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYrdN-0007cA-DY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:31:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYrdK-0001vz-TZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:31:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281c164408so23033615e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722364297; x=1722969097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yo27OhUoBxfOHgiiTJTXRNV6dD9ldbTD78KSPUR+b0o=;
 b=syPJLwo9aU0eWfE76RXehHl+BKv/6apnDRMtYGoqSOIcG2tbi0J+ADMTo14SR3OzdG
 FhfgqaVd6OxtUQGOtXs4y8v33dOenHsx1LioEv2K9ehW+Z+5iBXU3WieLjI/80lVMcoM
 K2qchCQJUQ9BiG0Pk5/u4yDFncDFcoa9uHpxZbXRQIPeKGX9rTYCuhlNEw42L505t26S
 aU3A+KkGeHwZi9Gqfeggze3mhBKMSt7rwpMKkzZGluj2dRTrdLhk8v8eXtxU1h165oWV
 ixnE/px453fXYeMCqAWRfkBJHC4ywFAkvhWlxHt4MX7MG8R6iuiC9hi5utZ2sFIHYPs5
 5m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722364297; x=1722969097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yo27OhUoBxfOHgiiTJTXRNV6dD9ldbTD78KSPUR+b0o=;
 b=VrludeeRKwDmhxju/KH7siyONHxO/MtxGZTUtaSfyRDpKJA3vXKCsIZymMytNhUQsH
 Mriw81LMKvFh9YZe+qpYMf/+BBZw9n+gFueKo07E1STqYufY2tExa5qaVHOH22/Bv2k6
 XpMOzv6yWyRJ9yBHd2E3Gr0ZY1u64JwHH4gLfL9sMNg7o1Q1QtcFtRZweRlImLNFEAcO
 GUTVeNm5VxXxLtkfvyKSwPZIxOKZDd74rMVeKZtbMMJvCbqTIcOcXjxZtsbUr0DI7lut
 yxMydT+KKD32NNL3j4sZzjYlvMBJV+SWO7m4WB8jBCmaz4IGIEvXEB3EdoHv1B7LlzF/
 cCcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVErE61Q75Kfd0YWOOvzdyJADzNHgjKcLaggutPoqQVyTpXf7YxSF3K3yA8FwOa2W83poPQKrW/GR+ct93JPO0d9NmI/r4=
X-Gm-Message-State: AOJu0Yzv5RHUU4wDa7l/kPr7QORsDV9tW/XNs0HggMsROh5nP4Tt4GMH
 Vh/Vf7d7wt28TR4A/8iQq2oyPLDaaC5lzswGQUH/LdeiOHg413/Ohvatv7oo5aA=
X-Google-Smtp-Source: AGHT+IFZfsME1gMW6UASnlX85pKIVE1qFcA5IEspAXrRn9bys4Foind2RJjZ2QG0dWEByp918pB7+g==
X-Received: by 2002:a05:600c:3109:b0:428:1663:2c2e with SMTP id
 5b1f17b1804b1-42816632d21mr71148655e9.17.1722364296768; 
 Tue, 30 Jul 2024 11:31:36 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281c3cc71fsm92878075e9.39.2024.07.30.11.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 11:31:36 -0700 (PDT)
Message-ID: <bd2b33a3-62a1-4ebd-85b6-645df2644d91@linaro.org>
Date: Tue, 30 Jul 2024 20:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] Docs / testing patches for 2024-07-29
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
 <Zqe2-4B8_qs3Oq0K@redhat.com>
 <d211f9c9-bef6-42b6-8bd8-8ef9cc7d6a29@linaro.org>
 <CAFEAcA90cJV4eUktKTC38kTqANHh6Y_g8qp=Dq7+go81yfqMnA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA90cJV4eUktKTC38kTqANHh6Y_g8qp=Dq7+go81yfqMnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/7/24 12:14, Peter Maydell wrote:
> On Tue, 30 Jul 2024 at 11:05, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 29/7/24 17:36, Daniel P. Berrangé wrote:
>>> On Mon, Jul 29, 2024 at 05:27:00PM +0200, Philippe Mathieu-Daudé wrote:
>>
>>>> Thomas Huth (9):
>>>>     python: Install pycotap in our venv if necessary
>>>>     tests/functional: Add base classes for the upcoming pytest-based tests
>>>>     tests/Makefile.include: Increase the level of indentation in the help
>>>>       text
>>>>     tests/functional: Prepare the meson build system for the functional
>>>>       tests
>>>>     tests/functional: Convert simple avocado tests into standalone python
>>>>       tests
>>>>     tests/functional: Convert avocado tests that just need a small
>>>>       adjustment
>>>>     tests/functional: Convert the x86_cpu_model_versions test
>>>>     tests/functional: Convert the riscv_opensbi avocado test into a
>>>>       standalone test
>>>>     gitlab-ci: Add "check-functional" to the build tests
>>>
>>> On the avocado review I mentioned that I didn't think we should
>>> be rebasing avocado during freeze. By the same token, I'm not
>>> convinced we should be introducing a new test framework during
>>> the freeze period.  This is alot simpler than avocado, but at
>>> the same time this small subset of Thomas' patches isn't really
>>> fixing any problem on its own, as avocado still exists in
>>> parallel.
>>
>> - As you noticed, Avocado isn't rebased here
>> - The python file added is almost a copy of the avocado base class,
>>     already well tested
>> - Test are moved from Avocado, so no waste of time running them
>>     twice
>> - macOS developers can run 178 functional tests. This is the big
>>     win and time saver for me.
>>
>> Do you really see merging these few patches now as being
>> counter productive for the community?
> 
> I do feel from the discussion in other threads that "what is
> the way forward for our currently-in-avocado test cases?" is
> currently still an open question,

Thomas demonstrated with few LoC we can leverage some Avocado
libraries (util, archive, ...) without having to use Avocado
framework as our entry point to run acceptance tests - which
is what gave us headaches the last 2 years -.

Richard only requirement is a "fetch assets" equivalent. We'll
look at.

I don't see anything else blocking this test conversion.

> so I tend to agree with Daniel
> that it would be better to resolve that question first,
> and we don't need to be in a hurry to change things in
> our test framework during the freeze period.

OK. I'll repost without these patches.

Regards,

Phil.


