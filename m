Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A43C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdA1c-0004ar-Qg; Thu, 22 Feb 2024 09:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdA1a-0004aN-RZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:26:10 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdA1Y-00066a-FG
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:26:09 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d23a22233fso52647891fa.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708611966; x=1709216766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fv52/qGNRrOaIQl7f40pXiqMeAxoYoLpka1HFphEA88=;
 b=r9lHxG9oV/2rN97ORlRdDKWA5JnN6DzzIr78J3J+A+2HK9WGGH1d3Q18rpBUUzo1S+
 R6+ccRP5KnYSKedxQmhDJHi5W5HAlQaYMrfywx6f3M9XXQCnRqZ6+Do/rpC4QqAmhWlQ
 bP2mD4BTYfPxhDzqpBj8IuBPDJ7J1y2bPqf6gbQjGPocXMwVymoX/+snHSUS6LSrSLbn
 axzZl0tIvIRHsca9s5jOgWVK7vww74T+L5PhRZPSDfJoduGd2UpHEBunTz2NbTqA/cdC
 ue/GPALjIzpMBGsKjfHyYYgNmAd1yH3F8J1c13Dj8bgsTJe/g4HCirXZsln01GqdeWYc
 fuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708611966; x=1709216766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fv52/qGNRrOaIQl7f40pXiqMeAxoYoLpka1HFphEA88=;
 b=uHegOpBo0KRkgjnmrngsKbMS/or6yG37qiM1WC1b2Zxw2iGCvEw1iGp8yczwdS7djD
 +4SEawtbnjdki2iBB1HWfC6x5ke50To/nt65piG1qf7fjBiP5n0Miu5/ZnWVm3gSPFWU
 LGpxCVUfvimakx687Ql5GtY+sRr8d2DM6XCgIFetni6pDLMKtodxT+6HnrXx+0Yhcnh7
 wbfUe8uaG5maOF+8mEzYGzOA9GJD9dZ0HceYOjGwIOKYhpzMV6Un2+dLubWen79r6sBd
 Z0FHlTAfrA+rHVSuKF2Tvob7PnQdxO5BHyS4S9BV6o+t+kptzktgHpcqN5DzL+h2JCbR
 UVLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhlChzo2NjL0t+8QFcxQunMdzIcefSEGJESoUBVS8ZSIvNub31ZKcnYbZFy3IkwMRdocnGGd4g53wk7o7/d99uKfswrJA=
X-Gm-Message-State: AOJu0YwVn+GLx9kwTwOe0VKeLGT1PLWfzGTWsPewGLW0zEqqhfOmw0Wv
 GGwi/+Ua1S2MuMmrt2y4WGWDoWvuypqAIk/WRxtgs2xf8HU+lfKLTtMTCcENFtg=
X-Google-Smtp-Source: AGHT+IFJnzsREIEGb/D2hmm/KwXp3hPq678bAHOIXkHuw7liIkXbXbxWqfAkq/MLi2+RTL4VnTeGSA==
X-Received: by 2002:a05:651c:1056:b0:2d2:39b5:6f6 with SMTP id
 x22-20020a05651c105600b002d239b506f6mr7626897ljm.28.1708611966001; 
 Thu, 22 Feb 2024 06:26:06 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 w16-20020a05600c475000b004128d4d0e05sm1181300wmo.0.2024.02.22.06.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 06:26:05 -0800 (PST)
Message-ID: <cbbdfce6-0ec0-4b06-bb89-49f49b2b0f87@linaro.org>
Date: Thu, 22 Feb 2024 15:26:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Simplify initialization of PC machines
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> The series aims to simplify the initialization process of all PC-based machines.
> 
> It consists of streamlining redundant code, as well as consolidating the setup
> of system flash and generation of smbios data which are currently fairly
> distributed.
> 
> These changes are expected to make the code easier to understand and maintain.
> 
> Best regards,
> Bernhard
> 
> Bernhard Beschow (9):
>    hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>    hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc
>      machines
>    hw/i386/x86: Turn apic_xrupt_override into class attribute
>    hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()
>    hw/i386/pc: Defer smbios_set_defaults() to machine_done
>    hw/i386/pc: Confine system flash handling to pc_sysfw
>    hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it
>    hw/i386/pc: Populate RTC attribute directly
>    hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables

Patches 2-7 queued so far.


