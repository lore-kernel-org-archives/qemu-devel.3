Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FFBC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzMr-0003b6-EV; Mon, 19 Feb 2024 03:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbzMn-0003an-48
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:51:13 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbzMl-0006EU-Cm
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:51:12 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56439b7c7a9so1494649a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708332669; x=1708937469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmZqW8EI/CtrrThbpB+ZE1itJYLfl2+JjStxpohzQPQ=;
 b=DVo4LqDYnikyMvv8cMJcZG0ZMjy/36OKN2LFc3fnyi0hyH/A4Aa/h0cJUsBPo3JbNN
 WKGBLcnsoB9Z6/RWRp6QsOTPIJ/0fit1CMaTetxH7H08olgvp7M9kxEIW5sdY2QeR5no
 142JPUhR2zJnqFAFdU43iqe4FYwB0qECUMUgi1KBfJMCWx0FE/cJ2Mpf97kgi3FnhErW
 26gAWWWIhKen7U9JDIY5bGtEdVvnMstYIQ+jgxzICeY5nxkAEjUjixrkUNsMpfFVyTbR
 h044jwpB2dpqYTbLiMoyAmBGabE4umLCD0EdaHPQnquw2q/ZAovhMNsQFM3zgWspr+6t
 q6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708332669; x=1708937469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmZqW8EI/CtrrThbpB+ZE1itJYLfl2+JjStxpohzQPQ=;
 b=QsxVUXG6NkcUeMZzCX3OgLNwbW9lX6/JOKOs7ubHi97u72IpjRIM/rMnQbvdnbMDvQ
 KyrKO7l2pC9Rxj3EcEkkxrVowHrno86Wc51LGeKc4FEv1pZYPX4KdngmEH3ciVMt3jfU
 s1ooxryJVifawhYOW+tFI1EDSphXBsCmYujnKbBBKe77t4Ylus98N7ThUGtiuSm1d6n4
 o0vf8O3WfYi4HCoZUpN2ZLzCTQQTvKXny0KmLizZmI5gv3maSBev0v08LRDM7qA4IDeJ
 Tnx0wgZK9eM2TNzWp7jLpvy0SbxaOTEio5gqVTrPtaXLyid/HaQUAi7+b+zCZxgJnbDc
 Bc+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnJc18EFPs9X1aAWaL7LqPYsGqfdNNJAll2Jwv3UqDC91mwoyeWQdlDKnrX/4Xijvt/vovNgKI0enoy76VAiDG8zqdmU4=
X-Gm-Message-State: AOJu0YxMdKI+wgxUQOs64/lrnDRpl0YcYfTEw6NXXJCSR7ZyjPV+LwSn
 cx/Xj5iPcBSG2viPK+6xc1jiOuQ9YBhmf84QjChFtM/t+TMhLDOFLjkVKfP1N5A=
X-Google-Smtp-Source: AGHT+IF7UUwXmHbxEs55PxjUA7WGd5OwwI/VTbp5akPA9EmhbAjyW8wcaoNyxrGCmHnxOG2raJIyIA==
X-Received: by 2002:a17:906:4e8a:b0:a3e:977a:708f with SMTP id
 v10-20020a1709064e8a00b00a3e977a708fmr1609580eju.70.1708332669393; 
 Mon, 19 Feb 2024 00:51:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 ha1-20020a170906a88100b00a381ca0e589sm2707754ejb.22.2024.02.19.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 00:51:08 -0800 (PST)
Message-ID: <cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org>
Date: Mon, 19 Feb 2024 09:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_q35: Populate interrupt handlers before
 realizing LPC PCI function
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240217104644.19755-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240217104644.19755-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 17/2/24 11:46, Bernhard Beschow wrote:
> The interrupt handlers need to be populated before the device is realized since
> internal devices such as the RTC are wired during realize(). If the interrupt
> handlers aren't populated, devices such as the RTC will be wired with a NULL
> interrupt handler, i.e. MC146818RtcState::irq is NULL.
> 
> Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before accessing it"

I think this commit is correct, but exposes a pre-existing bug.

I noticed it for the PC equivalent, so didn't posted the
pci_realize_and_unref() change there, but missed the Q35 is
similarly affected.

IMO the problem is how the GSI lines are allocated. The ISA
ones are allocated twice!

Before this patch, the 1st alloc is just overwritten and
ignored, ISA RTC IRQ is assigned to the 2nd alloc.

After this patch, ISA RTC IRQ is assigned to the 1st alloc,
then the 2nd alloc wipe it, and an empty IRQ is eventually
wired later.

The proper fix is to alloc ISA IRQs just once. Either filling
GSI with them, or having GSI take care of that.

Since GSI is not a piece of HW but a concept to simplify
developers writing x86 HW drivers, I currently think we shouldn't
model it as a QOM container.

> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_q35.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..43675bf597 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -240,10 +240,10 @@ static void pc_q35_init(MachineState *machine)
>       lpc_dev = DEVICE(lpc);
>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>                         x86_machine_is_smm_enabled(x86ms));
> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>       for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>           qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
>       }
> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>   
>       rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>   


