Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12C3C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEzY-0005N1-PZ; Thu, 20 Jun 2024 06:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEzX-0005Mj-QU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:26:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKEzQ-0003Ci-R0
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:26:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6fc30e3237so54500166b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718879154; x=1719483954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1+GD1AiosH4ZlfQqVjaaQ/UFCGFvFSvfRT6gOEDeZeA=;
 b=qkB7oDz3AUQuBeHQUTJFcwYt5du4SoOvhkiAPbmDnsyKujiBCltMut+HJUQQpeohhN
 9vkoLx3q5aksw+d/7VILYtPxaxDjZfROw4s8tnHEOBcRf1HkT4PpMewHgidpl29oS1xo
 5cnR/dIqfrT4A2qnLzI+jenNKffivM2YMh0X+oOQItrMVf3g/AZUQ7gpTKIlerNZ24lq
 AZmqsCvvxYdk/b1S/D6WNDwmMonie/QqAalv4n4lySemn0tu9WWxNQl0Gr+YDbQzKOOr
 RQrw0SJcjT0LMPyd4fwZxQDk/K0LpU1yzX3EGAq0f4b9BB9g1PKuBDLIkV6iJmx3vj8J
 2maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718879154; x=1719483954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1+GD1AiosH4ZlfQqVjaaQ/UFCGFvFSvfRT6gOEDeZeA=;
 b=DnCoS2jfc6bV44MA013Ejjys0vt9xJS65IZmykuCcQ7fG1rJs9sxKie/VdPCvL3cj7
 LAY/U8qpkbnra3L6RK0uYcANeNpo87ccauBWbSUmtlDNeP9V5vgzKevpPsKmd7yPCX5+
 ZMWrO1/+fIO4/aXRy6YvJEXborQNsEcj087q+HalqBxojazCofSsSWtvXQkN8YeBEGuM
 lbtdFN6kzBAUqa6SRLZOXqOR2rLmeVsda/h2iTnkHm/iKk/ICC/fFxJKt7be2432Soa6
 5smTCl5yPWKvZAMiR2wHgZEAXuCjrO1iTtDmOR9jZUDUWMZlVVz77stFAUO4r34HggC7
 MXAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzXBnBSvW3HEyFjuagbUC66B5KmKnc5PZ94tVcDxx5ZKH8yii3GAr+nXeVQ1h0X2BTNCheOy3LWxa8YODT9YaYBI+IoQ=
X-Gm-Message-State: AOJu0Yx/oOZCmOLL18yPmqmITVTKmVXk0smxAbDvq+qUQKwziekmU8zO
 q2eirrYQXYvo+CaslaS7pAydidAYh75XhkuBMkq27StO/JPg2hXmfvHh1v/kx8eJjAhsrdJ31JL
 L
X-Google-Smtp-Source: AGHT+IFlSvIhhw1C8otISEgxYhiyQIqtGJhvd35qmAPP9TLvAJ+hDq+4/SA+7wSb5gWfqRoiiiRtsA==
X-Received: by 2002:a17:907:15c2:b0:a6f:64d7:a81f with SMTP id
 a640c23a62f3a-a6fab778d3amr245397066b.59.1718879154254; 
 Thu, 20 Jun 2024 03:25:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da40f6sm748936266b.43.2024.06.20.03.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 03:25:53 -0700 (PDT)
Message-ID: <12471213-83da-4226-ba2a-2b8b6452d46b@linaro.org>
Date: Thu, 20 Jun 2024 12:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20240618144009.3137806-1-zheyuma97@gmail.com>
 <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
 <CAFEAcA82T-hS0Armp6PVBkrywfqv+-u+L4z8rtrjBpnwvE8Hxg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA82T-hS0Armp6PVBkrywfqv+-u+L4z8rtrjBpnwvE8Hxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 20/6/24 12:10, Peter Maydell wrote:
> On Tue, 18 Jun 2024 at 15:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 18/6/24 16:40, Zheyu Ma wrote:
>>> This commit updates the a9_gtimer_get_current_cpu() function to handle
>>> cases where QTest is enabled. When QTest is used, it returns 0 instead
>>> of dereferencing the current_cpu, which can be NULL. This prevents the
>>> program from crashing during QTest runs.
>>>
>>> Reproducer:
>>> cat << EOF | qemu-system-aarch64 -display \
>>> none -machine accel=qtest, -m 512M -machine npcm750-evb -qtest stdio
>>> writel 0xf03fe20c 0x26d7468c
>>> EOF
>>>
>>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>>> ---
>>>    hw/timer/a9gtimer.c | 5 +++++
>>>    1 file changed, 5 insertions(+)


>>>        if (current_cpu->cpu_index >= s->num_cpu) {
>>
>> That said, such accesses of @current_cpu from hw/ are dubious.
> 
> True, but I'm not sure we ever settled on the right way to avoid
> them, did we?

No we didn't, it is still in my TODO list; we might discuss it
when I post my RFC.

Regards,

Phil.

