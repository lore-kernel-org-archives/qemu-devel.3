Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE42FD2D76
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwnX-0005hD-4M; Tue, 10 Mar 2026 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwnV-0005gR-1S
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:06:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwnT-0006sn-3U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:06:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso17770615e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773148009; x=1773752809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLNOPGKOFzZfNCLQVbiRm7ZxcyMu7lA7ftQG/58+jic=;
 b=CCt18sfBhzqUYZkFF2+J8NEcU9jIK/LQRGwzDBG2hlZP0gy7/6lih3yM8YgTi1Yeqx
 3KmpXOV4oYsgKiHWPsROyRy4TXChHALoyAUR5WV5tRC/CDBC7h2cZ5b1R58nhqjByG7k
 8jybvMvltPmUUr3hFAr3I/XDo7R7iOxC6OOAF4GegieyXyArsFLSFjznSR+lCQicOeRC
 gjT4T7/r2Y7dp0o/vp92MhOCK9omE8RNs27o6hMTHyfPWn8WyraeKbACziG50azgkU7F
 2qW3GuU+Ev/edAPpUjow1TQhADutk78NkRee1fiNXwR2jaQNQz2YT39/6NU5ksVyk9Xm
 ZrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773148009; x=1773752809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLNOPGKOFzZfNCLQVbiRm7ZxcyMu7lA7ftQG/58+jic=;
 b=kHOmzcmde6iFXbYnIXeLDNhHfQtbdoLaUtfocHkehmyMFP3PaBESP/JdLvE0dyGAW3
 QmZyuUYrSLjcfjdQqz2u5e0M/9gKzWneNApB2YGoQt2B+OsLSk8gjDq7J7HyllO2byKs
 TbqkEPL6z47zl1IEkvwpfSXN9acTBlc+98CopoZnVmg78Eje8vvvhrbY184BNiP60WwR
 HIdOeYnidPEXgOmp+mAjWDt2YIffOt+3r2cxUKKG0zIyw4xrrk8QRMpbb8L9K9R+zQHu
 +ci9LDdKYTJH2OAzbN6MAtJZBlX/0df5sGMv4S9cxaJaMrBiMh3U4mE2+Y8qPdENLSHl
 hyGg==
X-Gm-Message-State: AOJu0YxFrcM6kL+HskaAC9BN6vXTN8mRYJsccU8p/0y+L3oMsjzxIUtw
 774JzbUMr3OSXdNcHAUoce8HtvVODFSlVdNs3BQzC0jQ+Fx6TXvaIgzZq0RQUEg2HnaeugzHJpc
 lTxoB+ic=
X-Gm-Gg: ATEYQzz0BqH42MrP3IAbym4ErTdF9REArLAkH2bRaFYnKsx176KGZh9aSts+hhl0LO/
 vmDnzqHNLFHgENa9Ah5kO8E7n5erXJKQZybOmTBPEUnprvaZ/Y3ngnbpMIGrH02JoiwaRVNgQBy
 ChZFk//5DrSRaYzrA/GswSCAOZ4ur4hTai03eeDDQzJeXm/V2oeP1ccLLOkKCahfpC0M88TS66H
 ABAWHe3aUEU2HXFgVATwgJpkStPSGpVtaFMAfxNDOhAUDmnNjBO6CkGHMd52B7R9TwCoG4CU4y+
 EWXnspeuud4FiZzLHAz+/RhPMPCNSKLMwF8hLbryiXud5P68uvBvPKupvxd64Yo4YpvR5KC0hKO
 SlMlMLzxKjA7n591TMNwl4sarFKkCmGfLMziQ9ILvDOCGeQvbhCJpt/MwNTrNQirIos3QisnUcm
 QE3B6tlr7qHdJyMsPIwqMmnspYgWwl/ZZivbVFRzHvVgLox2thlQ2IE0wcAJ1nZrQzgw==
X-Received: by 2002:a05:600c:8b5b:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48526927a4dmr254126055e9.15.1773148008977; 
 Tue, 10 Mar 2026 06:06:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm38390545f8f.25.2026.03.10.06.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 06:06:48 -0700 (PDT)
Message-ID: <7489d7bc-d2d4-4890-9fc9-0d105a272643@linaro.org>
Date: Tue, 10 Mar 2026 14:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Mads Ynddal <mads@ynddal.dk>,
 Joelle van Dyne <j@getutm.app>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
 <CAFEAcA9TSQEVEVeQc4rPtz4HEJJbZUs9LaeVbz-y3=tB9zv4EA@mail.gmail.com>
 <7C4D7803-46A3-430C-A66E-5C3B63E92E0D@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7C4D7803-46A3-430C-A66E-5C3B63E92E0D@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/3/26 14:32, Mohamed Mediouni wrote:
> 
> 
>> On 9. Mar 2026, at 14:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 7 Mar 2026 at 18:03, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>>
>>> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
>>> (tag for this submission: hvf-irqchip-and-nested-v19)
>>>
>>> This series adds support for nested virtualisation when using HVF on arm64 Macs.
>>>
>>> The first two patches are from the SME enablement series and are present for the
>>> series to be buildable on its own.
>>>
>>> It has two parts:
>>> - Apple vGICv3 support and necessary infrastructure changes for it
>>> - Nested virtualisation support. Note that the nested virtualisation implementation
>>> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).
>>>
>>> This series doesn't contain EL2 physical timer emulation, which is
>>> needed if not leveraging the Apple vGIC. As such, nested virt requires kernel-irqchip=on.
>>
>> Hi; I think at this point this series has unfortunately missed the
>> softfreeze deadline for 11.0, and we should be aiming to get it in
>> for early in the 11.1 cycle. I will keep it on my list to apply then.
>>
> Hello,
> 
> That’s quite unfortunate :/ Too close to the softfreeze tomorrow I guess?
> 
> Thank you though, think we got quite close to it with even an attempt of a pull before
> last-minute issues resulted in it not getting quite there. Hopefully future series will go more smoothly
> than my first ones :)

While we mentioned to our users that HVF/ARM is "supported" in our
documentation (commit 16595bcd0e2 "docs: Document that hvf on Arm
is supported"), it isn't "supported" by maintainers as in the
MAINTAINERS definitions:

            Supported:   Someone is actually paid to look after this.
            Maintained:  Someone actually looks after it.

It is marked as "maintained", thus developers caring are not paid to
do so (commit a1477da3dde "hvf: Add Apple Silicon support"). So it
is hard to follow / review / merge all the patches mailing list traffic.

If we want to consider it as first tier class accelerator, we should
at least improve our CI testing harness.

I started few series / patches around it, but quickly got overflowed:

- tests/qtest/migration: Update framework to allow using HVF accelerator
https://lore.kernel.org/qemu-devel/20250128135429.8500-1-philmd@linaro.org/

- split/arm: Run EL2 using TCG and EL1/EL0 in hardware with HVF
https://lore.kernel.org/qemu-devel/41c83d3f-e5dc-42c5-a743-1aafc4cce27a@linaro.org/

Some files already test nested guests and could be expanded:

$ git grep -li nested tests/functional/aarch64/
tests/functional/aarch64/test_device_passthrough.py
tests/functional/aarch64/test_kvm.py
tests/functional/aarch64/test_rme_sbsaref.py
tests/functional/aarch64/test_rme_virt.py

Regards,

Phil.

> 
> Thank you,
> -Mohamed
> 
>> thanks
>> -- PMM
> 


