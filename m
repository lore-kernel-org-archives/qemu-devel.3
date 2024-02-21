Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D5CC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaI-0007HW-2I; Wed, 21 Feb 2024 10:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoPH-0005EJ-S9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:21:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoPD-0004Ic-25
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:21:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4127a0d8ae1so1160815e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708528864; x=1709133664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N7rGT8yZCvAdoVTuAMhRwm2ubb3JgqYFNPXxnz7r5cI=;
 b=nB6Xr7lnYNBGoBEU3w1VflH1R1ReinON5oE2J/f2IseDjk/bbgiJ/ETU1c1QHxdM3v
 +cD+NRVOQf+Bnp6RyyKFnyQneMnnAPJZvBVpev+bhrd1QU6TOCgtCMSqhKeH+d9io5d4
 az2KqLGvpka/fdpGB+XEno6X+nxynrvinEZYaUxto5db8gDINepWaihxjJzkXgFomUx6
 MfVi32znXQn29dvGrIofFVkihlcrOnjG06zHbWKP7VC3zx8vi2vF/l9tfzMHfB7u2Cy6
 Pqfa1VzRQDoos7afQ5qUGPIZwjh1LL9SNc5WGNX7pqYPwM5ZgBLbzewuhfCvFc4E313O
 COhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708528864; x=1709133664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7rGT8yZCvAdoVTuAMhRwm2ubb3JgqYFNPXxnz7r5cI=;
 b=pN0JVRBl6nJ4B3YOjGe8EqsmSPUG0CDfXpBqf8ILgwZ9AKEHALlYObMEQV8kTVus+Y
 Y+tyLrwLobu2IEPFSY1lMM3c1B9ksHvx6SeFKpmjD0uWLC4ErO/fubBDxzh0mRe0HsHI
 hXnmsAZ47eTXlwLY2YpThgAR1xTCMpvIT2E1tjUjEr7IMaRXnMRjxR2CReFxbbN569Ds
 5iBe1Vzjxjy9KEA5Yv1pbrE/Eh9fHqeat1Qyt6CdGLqowz4RIF/1AZomLTRCX6g2IaZ5
 kU6EgDuzJmKLLbMZqQVcVm0oYOzAQyhFh+Q2Z9wAiPwrZ1WsCRutZ6BpT4iJwiLoegcZ
 M6xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU00XapxoF6AhNBXIbp3ahGrNxXaaiTQRVG6dSDR7PYvT1byT51Cjc2XsT7DbqNIkA3L1jdZUzlnwl2LcSYlhbCNdxy8V8=
X-Gm-Message-State: AOJu0YykCHsth/3hLugT5kWyXcbqcrEnD+uFhKpv0iIgUZPnv+KuqLws
 VT1nL4/ZgvBGtpNgmtmAtSWROOd+2xSeM/uYP7zO0uW+VjZina8ZmXNFhi7igFM=
X-Google-Smtp-Source: AGHT+IGJm+aHfTqk17QohLqvqvgJ1905KXyxZup2B2MbulSNHTddU548WfYPTXE841pUYNVS4/Oj7w==
X-Received: by 2002:a05:600c:2184:b0:411:c9c0:eddf with SMTP id
 e4-20020a05600c218400b00411c9c0eddfmr13923149wme.36.1708528864617; 
 Wed, 21 Feb 2024 07:21:04 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0041279707ffbsm793673wmo.15.2024.02.21.07.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:21:04 -0800 (PST)
Message-ID: <a5bd04e4-6f41-4e2b-a99f-d5150682e53a@linaro.org>
Date: Wed, 21 Feb 2024 16:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
 pc_machine_done()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220160622.114437-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/2/24 17:06, Peter Maydell wrote:
> In the i386 PC machine, we want to run the pc_cmos_init_late()
> function only once the IDE and floppy drive devices have been set up.
> We currently do this using qemu_register_reset(), and then have the
> function call qemu_unregister_reset() on itself, so it runs exactly
> once.
> 
> This was an expedient way to do it back in 2010 when we first added
> this (in commit c0897e0cb94e8), but now we have a more obvious point
> to do "machine initialization that has to happen after generic device
> init": the machine-init-done hook.
> 
> Do the pc_cmos_init_late() work from our existing PC machine init
> done hook function, so we can drop the use of qemu_register_reset()
> and qemu_unregister_reset().
> 
> Because the pointers to the devices we need (the IDE buses and the
> RTC) are now all in the machine state, we don't need the
> pc_cmos_init_late_arg struct and can just pass the PCMachineState
> pointer.

Even if we remove the IDEBus/RTC pointers from PCMachineState,
we can still QOM-resolve them from it in pc_cmos_init_late().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/pc.c | 39 ++++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 23 deletions(-)


