Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD11C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd4t-00049L-Co; Tue, 01 Apr 2025 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzd4r-00045O-9U
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:58:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzd4p-0002GV-Ok
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:58:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so37631805e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519534; x=1744124334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=toT9Kq3dfWbeRgyKVjLXGdFzEnTEuvx6JtUR5SXoHr0=;
 b=lXgvqEAJkY5dWerOu2kbj3tllkkHUzcSQ20sYaDhMjWC57HsUi3zIeFN0R1peVYcrs
 khy02c3X1SpqRY3s4FHz+B0MrwC1qd5B2iYrWjzzCERiUUrA2x3cN5LoCAxKyx+DyqWZ
 sBEVAtuP0iGNcGAXueh0kZnbJPpPnAVqcS60KHrBBAaAJcPje4q0MSrPJ9WjTemQVV9W
 30eRG004+SouNCpW1z2wfpoJ51NwcYjO0+t38NWjIyrzksMVkpfuwEav9QCZuZN5HVQK
 3IYD6POajFkoYCb4/BM+6HICPySqo4qCva79BAZoSHQFFdLYyt/eBILB80fNwEQIoS3S
 zcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519534; x=1744124334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=toT9Kq3dfWbeRgyKVjLXGdFzEnTEuvx6JtUR5SXoHr0=;
 b=fDN0poeydrAMFLG1psBPFADrxj8qFWY+CNQ2KqhNe1TAtK7SIhUK448hzRhQI7L/dL
 mS2PpLPwXe+TC9yzApRPaH//loMB17qT233eTeI+0sKjbOrvMqEYIT1NIjw5BzXtcRYA
 OoddCk6Sq4H9g8v1x7MFYMz1jDFZunhaO0qylfqwgEVFMmmrGgUvD9Aee8omAdP5r2HP
 JPuAnXCzUSHqF38v8I/CsenQKdYkoUiEbjSRgKzcxTM6SiaCpIDCeS6Gbh9qxD+uvizf
 N0UKUjYjeM4Y/VceM3NdLdeP66arKuW3XxqFd1bzmfnu4HNWjvz56CN5A4t+ThHtrfG8
 DZUg==
X-Gm-Message-State: AOJu0YySaumAgxXikds9L+lDp63rmbOhv7ktmJIGNKja2RZYljdth9tw
 SdgPAyzJ3EP2rSkcrCd7+LJuHD+X4/VvV2Na/i4iLAWOJEnze2Ya4hPCiSQHL79YWa1zIH0YSbr
 X
X-Gm-Gg: ASbGncvaMhB11DZWPQSS7X1ZOji0o3KDoiVV2kNpwEOEO6hIZVNSo7WAvfh7sCmXJ76
 juEelGsEC8jBtB6h9hSr+lK7fqKij68ZNOj8ApKC0QtzqbYRU04QNSpo142ZmijsS4yR+ZN+iX/
 ZTocX2zGvcPzQMOSJHdyUxwpAXZink7dBTZeku/nq47z9dHiEXmm/voz4EJXX07gtemyavP49r7
 atimiUb1sUlbciGQbUZws9Bj5NUuzw4mNUONdMXqMfyE/hnjqD6VXR0u6/IZfV4gBfzmVowtc2i
 z33WbJh51QdXnVJskVeuuKiZ8RayYrBEZKBxzhndGHr2L8UYd0Y0VVeD3prYhdxhUwqAhu7T1p1
 2GOkfwhMjv23yH0CUW8cDsQU=
X-Google-Smtp-Source: AGHT+IEYeQ6dVuk3LE/OuKgmBliZY2rtbaCBvY/2WA1z325S682kYp0dO/tSUgX6qoggH5oMRnHzBw==
X-Received: by 2002:a05:600c:5486:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-43db6249aefmr113422725e9.17.1743519533528; 
 Tue, 01 Apr 2025 07:58:53 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f84sm158227405e9.25.2025.04.01.07.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:58:53 -0700 (PDT)
Message-ID: <ac856040-f400-4dfb-9322-02a2880b40f9@linaro.org>
Date: Tue, 1 Apr 2025 16:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ipmi: add fwinfo to pci ipmi devices
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org
References: <20250401140153.685523-1-npiggin@gmail.com>
 <20250401140153.685523-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401140153.685523-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 1/4/25 16:01, Nicholas Piggin wrote:
> This requires some adjustments to callers to avoid possible behaviour
> changes for PCI devices.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ipmi/ipmi.h     |  5 +++++
>   hw/acpi/ipmi.c             |  3 ++-
>   hw/ipmi/isa_ipmi_bt.c      |  1 +
>   hw/ipmi/isa_ipmi_kcs.c     |  1 +
>   hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>   hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>   hw/smbios/smbios_type_38.c |  7 ++++++-
>   7 files changed, 38 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


