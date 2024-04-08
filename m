Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4057CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 11:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmjH-0005Y1-TS; Mon, 08 Apr 2024 06:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmjG-0005Xr-5m
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:59:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmjA-0000dh-75
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:59:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso560281766b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712573984; x=1713178784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eYetE4dGHCVsqV8x/WENRuYU4fuza/J1/4l0nUH+OqI=;
 b=UEbkId6nOfOEIKw0ZIbsV3praYpBoqsGjwV5QX5WEWkOzCifW7gplKkpSGuHTG9Qys
 Tcwlu1W8eH62l52o5lKOH5MVqBDKykVy+A0DiMqhS0l8H2T0LwwzpTEiucVNNSt7iFmN
 D40Oz6w9FOcZ1M6vlyD/1z3aVkEccF4JQ9b7E2QetE/od8sn10W3+jlPeX14hvbzYpWi
 TIRexDFDBFrVTSV2SfhvI/F/lA7Al7XIVRVkAVS9V9AHBG3jXL7XNnJCNaMmS4iksssP
 kOx6lx2c2cD6MbmArF8uJl6yWuQZb/ef+ovOx3f1za/w8tzQ7u2YWFncDNWVtQpYUEFe
 AhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712573984; x=1713178784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYetE4dGHCVsqV8x/WENRuYU4fuza/J1/4l0nUH+OqI=;
 b=Rf1Q4GFTperYsy+QIiTHNuwIkoHG6dCWIA8GDj0KtGNcFEfOLalVwWJQPu/fk5+g6A
 eCZCpIP1VL2XtqAVVsPY1SBg60lkzsw40cOpKcQPiivQmTrPvdAzua6m5tiCMhVEyPCu
 x8Gl24EZMfWNaS3KlDoEEy1wTu8WAp9LpWn62SWhHPIKvuNIkvrCkrnkHumaIdOiebuX
 jEIqeAFG4kbrf20eWaKq029wncJRSyI9vOPBvQ65W6QJWK1yEA1PsUXQGOkg9xgNPZeC
 uTSYhptxLg85OXH3evPPRvMVSD8SbdtUQ1nlQ6OVecBEEwG0mkIqIjZGEYlwOQfLYBsS
 Mvuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaQXYP7m4ZZ+Bv9UqkxuDTA6jAxGW0jxJ/+01XMhKtBDTlIC3NMCHvpPMihMjwXZs3JxscNNii5XP+Z8QqBA1Q4uHwRSo=
X-Gm-Message-State: AOJu0YyfmPpM2vI9VylTqfZ7r5Xp9h9CYUUb1ZpXj/8aGzYQUCGS4d75
 cZTdLEp+GYtUHYC2CqwdRf8M3n73MEv61SVIFXoF6Ap4yoCtZPr/QUWtkPKoUok=
X-Google-Smtp-Source: AGHT+IENXS8kacStS/rsMli+4q4c3LF9Zx17Ma3Z5V+XjW4D5YEhC8ul+bwc9uNFG8XdAQHR6Ter4w==
X-Received: by 2002:a17:907:94c7:b0:a51:d54b:378f with SMTP id
 dn7-20020a17090794c700b00a51d54b378fmr1649686ejc.33.1712573984160; 
 Mon, 08 Apr 2024 03:59:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 qt28-20020a170906ecfc00b00a4e8991cfbfsm4256417ejb.127.2024.04.08.03.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 03:59:43 -0700 (PDT)
Message-ID: <521b4a1c-2762-4dc7-b9fa-ffa6a8250a13@linaro.org>
Date: Mon, 8 Apr 2024 12:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 3/7] monitor: Rework stubs to simplify user
 emulation linking
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-4-philmd@linaro.org>
 <CABgObfb=Yfd55YiYgrN0YBN+bpZxJs4XHpac4t=kupHKm6oS0w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfb=Yfd55YiYgrN0YBN+bpZxJs4XHpac4t=kupHKm6oS0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/4/24 11:50, Paolo Bonzini wrote:
> On Thu, Apr 4, 2024 at 9:48 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Currently monitor stubs are scattered in 3 files.
>>
>> Merge these stubs in 2 files, a generic one (monitor-core)
>> included in all builds (in particular user emulation), and
>> a less generic one to be included by tools and system emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   stubs/fdset.c        | 17 -----------------
> 
> Oops, merging fdset.c breaks storage-daemon linking.

Odd. My 'tools_only' build directory is configured with:

'--enable-tools' '--disable-docs' '--disable-system' '--disable-user'

I was building qemu-img & co. I just checked it isn't anymore,
the directory only contains libqemuutil.a, libqom.fa,
libevent-loop-base.fa and tests/unit (I'm on macOS host).

This explained why I missed the link failure. I'll dig to
see when these tools disappeared on macOS.

Regards,

Phil.

