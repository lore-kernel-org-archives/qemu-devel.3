Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D82C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVSK-0008Lo-Tc; Tue, 20 Feb 2024 14:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVSI-0008IS-FQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:07:02 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVSF-0002mD-Nu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:07:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso2925424f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708456017; x=1709060817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=biUbDf1nUaz9JvarQjOtcLfzwcwLgPZ/henEN5dcJlo=;
 b=vYN0TGREABSYsnhZSMmYRVps6asi4e3PMq9qsGEQn3zDVUjYCVYAani3qpcxK795GF
 1/AO0RRFievfrm1Y7eo4vxzom/68KnkXHZBrJV4xQ34sG9PPgKUkldXsEEEo3goXx0lW
 ZhmFIVFZwAqa0vhjIsBo4invbzd7TY8LzhjOpRgzrQYpmoAoDE1EvYsqeQv52Rguttpx
 2eI9S2a7Me1kNM8QBtoQpyIixN9DbhD2lWeIr5DfuTrIvXsQlz5H0R7ivhazujsBtzzo
 fwnWXcqmj11ypWcXXnuad3IVNHb6OxopzTXUxvFJmxxNjhE5IuSDKHM5yKXpb+AM3MOS
 tzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456017; x=1709060817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=biUbDf1nUaz9JvarQjOtcLfzwcwLgPZ/henEN5dcJlo=;
 b=clVoVbEtXIL1k9jfW5T0QNKkOzEqkhKicSgQA/nP8KyXb7QEwWV64CsfvIoggZLLCI
 U+veVZFijCrzGxiNaSOnpufUOpEjlC/eFjTNJ+Q/kqTEc0Wj7bsLDT5Hyu24yFe9R5Ei
 O7Oz7vZGigdhPi8XQm8Ta2pVyAfTwPawTZK2LLUi1OXIRtB7iWfGqqB93KHWFl76//Qi
 90n6fGACQF4DMGObwSO3kbeOJIgUNz2PXBzMPR2urzzu4XzJnYavNPSSqlifc2Nc8ZPx
 6Nj77JSD1shGPu4fqKe/paavHnhqliu94sL8QzkheNn+ZUlQhBTpz36Wo8QnUxZsb8p2
 9GYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvm0OWEKz+ht2y1fqd8tGPEp5lIQPgo1fVKH4yAKdOhy1j8Hb0cLiUqtxn5nLi40gGQ58jrqZfRNRTN2yGD99N2AvhA80=
X-Gm-Message-State: AOJu0Yw+v6X1o3urYb6Bf+SRXL8tejUNUhmzlD+WyfYaH0l82kgrycbU
 VpV8OAf9W/JzUFlfTHLTcIeJnIcmsXtVSdCin1CwCapjbj4EkBp1O4khTLnrgtg=
X-Google-Smtp-Source: AGHT+IEgNbDyrXIx4i4kXQA/xn32Tf6YwhqvuV1+hDd43pC01yKngmEzn3gRnxCo/oRU884bEwEewA==
X-Received: by 2002:a5d:67c8:0:b0:33d:5250:71b3 with SMTP id
 n8-20020a5d67c8000000b0033d525071b3mr4469220wrw.57.1708456017608; 
 Tue, 20 Feb 2024 11:06:57 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 co18-20020a0560000a1200b0033d4c3b0beesm8499364wrb.19.2024.02.20.11.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:06:56 -0800 (PST)
Message-ID: <18996dba-a47c-4e68-b9cf-5e0ae5e9cd43@linaro.org>
Date: Tue, 20 Feb 2024 20:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220160622.114437-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
> Move the reset of the sysbus (and thus all devices and buses anywhere
> on the qbus tree) from qemu_register_reset() to qemu_register_resettable().
> 
> This is a behaviour change: because qemu_register_resettable() is
> aware of three-phase reset, this now means that:
>   * 'enter' phase reset methods of devices and buses are called
>     before any legacy reset callbacks registered with qemu_register_reset()
>   * 'exit' phase reset methods of devices and buses are called
>     after any legacy qemu_register_reset() callbacks
> 
> Put another way, a qemu_register_reset() callback is now correctly
> ordered in the 'hold' phase along with any other 'hold' phase methods.
> 
> The motivation for doing this is that we will now be able to resolve
> some reset-ordering issues using the three-phase mechanism, because
> the 'exit' phase is always after the 'hold' phase, even when the
> 'hold' phase function was registered with qemu_register_reset().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I believe that given we don't make much use of enter/exit phases
> currently that this is unlikely to cause unexpected regressions due
> to an accidental reset-order dependency that is no longer satisfied,
> but it's always possible...
> ---
>   hw/core/machine.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4c..9ac5d5389a6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1577,14 +1577,13 @@ void qdev_machine_creation_done(void)
>       /* TODO: once all bus devices are qdevified, this should be done
>        * when bus is created by qdev.c */
>       /*
> -     * TODO: If we had a main 'reset container' that the whole system
> -     * lived in, we could reset that using the multi-phase reset
> -     * APIs. For the moment, we just reset the sysbus, which will cause
> +     * This is where we arrange for the sysbus to be reset when the
> +     * whole simulation is reset. In turn, resetting the sysbus will cause
>        * all devices hanging off it (and all their child buses, recursively)
>        * to be reset. Note that this will *not* reset any Device objects
>        * which are not attached to some part of the qbus tree!
>        */
> -    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());

Interestingly after this patch TYPE_S390_IPL is the last device
using resettable_cold_reset_fn(). Per commit cd45c506c8e:

     /*
      * Because this Device is not on any bus in the qbus tree (it is
      * not a sysbus device and it's not on some other bus like a PCI
      * bus) it will not be automatically reset by the 'reset the
      * sysbus' hook registered by vl.c like most devices. So we must
      * manually register a reset hook for it.
      * TODO: there should be a better way to do this.
      */

> +    qemu_register_resettable(OBJECT(sysbus_get_default()));
>   
>       notifier_list_notify(&machine_init_done_notifiers, NULL);
>   


