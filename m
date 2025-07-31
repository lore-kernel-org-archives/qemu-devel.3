Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A499AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb0i-0003BN-8Y; Thu, 31 Jul 2025 17:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhaoU-0007mp-Fp
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:27:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhaoS-0007n3-Kt
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:27:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso1426895e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997263; x=1754602063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HW7hdyrAaYmDo+KOG80ORADvlFCxHaqB499J0C9HP10=;
 b=mOBvH4QLdO40ilA8mkDHUR7LsnGFz6iCqqLixQsK9HktLqhShChJVBRIgP7lUfTV3f
 N6gaCil05Yru3Q4iA4cpKTK7zRDigNcWvmxQCthL2aPJHRVPe/GDsYN6Y1ZY/4O1mDVf
 1XPoNACMzUiwOYLPuUiM7Vbuqgxp7T+AIDL1B+biEvxkPzJ5BBAi8MdTGUSVKUMbeY7m
 JJIaV1v1Z+GHsQG2pdf6BFT6zCO1RpqyTL4suYs6qJgh2RpiHIho1sKpwzcyo7/ZlqzJ
 LixQvcXzuYDAaDFZT5kf1T1AKXS8PSaLTJfbElM7fRuDeF79PxUcsSC5iavH0LBu20m/
 IdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997263; x=1754602063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HW7hdyrAaYmDo+KOG80ORADvlFCxHaqB499J0C9HP10=;
 b=aEv+FbwBJyqUU/DSe8L857Sh5ZJQan0GooUpJeStoc17efDSkzPT4l4AhYOvw2jPsF
 Ze36oXuvfJ436lM6KcXU5P79OjKdSBmynq14K8Te6ADIZF0fXC1zjP8UbVGcvxVlehE0
 ts6fvhZDHV9Ij/AEIl05H0ybieBjjE/EKN+5vbMohh+OrW+hQb937zVblSlo4opHYjH8
 tL9RSVyNVzHMJ/5S1FokgDaFbME8dVkQhgbgnmYk+eHhCzuch2mGnVFEyEZk3o60VtkL
 WFzKDQwWDY4WZtgvC4RjV9JXoX/XQYdvdsyI5n6zk0GK5ND3QtR3viYvwKIKjIcINzQo
 Crhg==
X-Gm-Message-State: AOJu0YwpB016vca9CgRVLmXLda1bKBbHm7OBNYweMRXWv3nMvQT7U3Z+
 5IZasfsGTP6TNiq/6bysItLdJkeQusHD0Pd86lfx89Oyll+k9BGf3oYpYT8dhJgZ1jQ=
X-Gm-Gg: ASbGnct1Hn+W08P3nnd8y9fzVoGLFsOYr3ooeN7XioNQvabQuGaqBU5shhrf/ujKje8
 7W6VbLMepAeT1mdR6gf8AUVCAciY0jRRMykHGjlHLO06UXep8xlObEtCBgxR6rBSQBJ3zeGbD/O
 a6bNZR2R2+ptHbBZdcJlhMA965xXLdbZJv1V/xUieLPnn4nJXISvBm1V4h07RtFviAxfU54kjKA
 WueEhhC0F4B9GuF0C8/oVpEfgWgOdPRNC04cpE75S96Ve8+Eun1zsU6jYFW+A9XpyofH9b0ltbI
 lzDY3NBrsPyTIqmtN1Yj+Vftm06oTdLiTG1wN0l0EvgdPJaBF+hrlwV1EJOANyjKICndACxjHSF
 VljWaRUgzgIF2igB5FJkkWLKhdr9VTCoe8FHcTVlbUnpiUYBL0DJC6s7TKiDWqrlQdA==
X-Google-Smtp-Source: AGHT+IEDJJq3Z24n+bY+AGZeIZx3hoFMbwGVdJKil3rl2bL2T675rEKb8t0oxBMYCN/Ts8CtyRlUBA==
X-Received: by 2002:a05:600c:4448:b0:456:1e5a:885e with SMTP id
 5b1f17b1804b1-45892b95341mr100549505e9.3.1753997262748; 
 Thu, 31 Jul 2025 14:27:42 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530b3sm3769913f8f.34.2025.07.31.14.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:27:42 -0700 (PDT)
Message-ID: <7cc71966-5165-430d-80ec-6de6d5e6dc1b@linaro.org>
Date: Thu, 31 Jul 2025 23:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/7/25 20:30, Pierrick Bouvier wrote:
> On 7/31/25 9:23 AM, Peter Maydell wrote:
>> On Mon, 28 Jul 2025 at 20:34, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>> This old commit (7702e47c2) was the origin of having interrupt related
>>> code in a generic folder, but I don't really understand the rationale
>>> behind it to be honest. It seems to be an exception regarding all the
>>> rest of the codebase, thus the idea to bring back things where they 
>>> belong.
>>
>> Most devices are both (a) architecture specific and (b) a particular
>> kind of device (UART, ethernet controller, interrupt controller, etc).
>> The nature of a filesystem hierarchy is that we can't file them
>> in both ways at once. We picked "sort them by kind", which is why
>> all the interrupt controllers live in hw/intc, all the UARTS in
>> hw/char, ethernet controllers in hw/net, and so on. In this
>> breakdown of the world, hw/$ARCH is supposed to be for board models
>> and SoC models only.
>>
>> The GICv3 and the NVIC are odd, because they are very closely
>> coupled to the CPU. (A few other interrupt controllers are also
>> like this, but many are not: for instance the GICv2 is a distinct
>> bit of hardware that communicates with the CPU over the IRQ and
>> FIQ lines only.)
>>
>> One of my post-implementation regrets about GICv3 is that we
>> didn't really get the split between the GICv3 proper and its
>> CPU interface right. In hardware the GICv3 is an external device
>> and the CPU interface is part of the CPU, with a defined
>> protocol for talking between them. In QEMU we put all the
>> implementation of this in hw/intc/, and the code in arm_gicv3_cpuif.c
>> does some ad-hoc installing of hooks into the CPU.
>>
>> For the GICv5 I'm trying to structure this in a cleaner way that
>> is closer to the hardware structure, so the CPU interface
>> will be code in target/arm/, with a clearly defined set of
>> functions that it calls to talk to the rest of the GIC that
>> lives in hw/intc/. (This would be too much upheaval to
>> retrofit to GICv3 though, I think.)
>>
>> In a green-field design of M-profile we might have made
>> the NVIC be code in target/arm, and instead of a separate
>> device have the CPU object itself do this code. But at the
>> time it was written we didn't have the same QOM device
>> class setup we did at the time, and IIRC CPU objects
>> weren't a subclass of device.


> Coming back to our issue, I can see two ways to solve it in a short term:
> - On build system: define target hw before generic ones, so we can reuse 
> all the source sets defined there. This has the advantage to be usable 
> by all others architectures.

That seems the cheaper / quicker way, isn't it?

> - Move gic related fields to a substructure in arm cpu, and provide a 
> simple accessor to it, like "cpu_gicv3(cpu)", breaking the dependency to 
> cpu.h. Concerned fields would be: gic_num_lrs, gic_vpribits, 
> gic_vprebits, gic_pribits.

FYI a previous attempt to disentangle GIC vs CPU with QOM:
https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/


