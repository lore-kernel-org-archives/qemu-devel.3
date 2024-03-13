Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A4C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMOd-0006Fj-D6; Wed, 13 Mar 2024 07:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMOO-00063N-LE
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:03:32 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMOD-00009a-B7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:03:28 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5131a9b3d5bso6381094e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327787; x=1710932587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8yikb7+gtK5o3QL027bQMj3zTGN+gPbsD7TqJVDhLJs=;
 b=Ixf6jYEV5vHKPBFIpidUsLibg6vbMtDVdzfHjjpFPQvm/icXsZVGSxj8ctT2XUvsvh
 HtGgBSuofvssHxOOVbwEYonB559aYTZwvKt+KZCVTirfqu2bOHut5FPMha6Li5Nd3Anl
 12n3mm9+jSfN6JdRI4kiyySZkT3KXxLFTK2BLjYcqfWREQy12HXXSbAyE0tkGXw1Qzk1
 rs6FQUwkrWfXVMAN00vo60JAtivx08crewF/IYC1Pe6mX5nsmmPWU4GS34iAFxiRXti6
 2R6aFhJHv7HxENbIHsLOHVwUf+bxz+8ME29/qxYY2jQ1ttrxq3k5f/mnxlRigejL9CM1
 fx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327787; x=1710932587;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8yikb7+gtK5o3QL027bQMj3zTGN+gPbsD7TqJVDhLJs=;
 b=XtZJccizKilT6i/uMK6oDTlpxdBlICnpDm63RtoTwIqBRisNh3qKiiOpCZWdw5CD2x
 9ca7YLsAZM8NmoX5L4k4WHNtMpVnm+mnMwsIxjlCOr3o9oZDHTcXv5oAdpOePepglcoF
 nS8bebtHh1ybjf0dd3JuGegEuUrtIcmL7jM5kso8XbRa4miY3yIwip/n9DjkAJn4qJBZ
 1teoiGmfIxnCe7GhRXeZiIs+YAtNglgb9PqV+JLCovOjFxEJyLHBljYBkgzaf7T0/tTS
 PUAt1F/jC9b/WIjoeMx1EHnfv1rifUBZyChkCvdb4QlotjZqSVGhEhAOi5acOyUdY+Us
 S6MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0hc6teeWLP9yRCBndz2rUSCGEJHcw/Mvb5l9QNDQE0TLlVeQgL8YfkIcmvf7Z+mBg6irARHcEP0YdFROD+2pTpZz+fLo=
X-Gm-Message-State: AOJu0YzZOyy2r+w1j4XmsWZMwh9T1Vj+920dPCbh4FRGx8J0dhddylzX
 DK7y8WsTWSM3U5wnHi+1i6WDZcPW3NPH3+HVOBUhuAJgFGT8f3HM0SRNwfrHwd8=
X-Google-Smtp-Source: AGHT+IEF0iCUN/isOfvW6QEUYShmjSjxDV3UHtb+wCimr8s6RkHP0CmO3Aju9tz448N+cvf/VTYlOQ==
X-Received: by 2002:a05:6512:28f:b0:512:d78e:90fa with SMTP id
 j15-20020a056512028f00b00512d78e90famr1819042lfp.15.1710327786945; 
 Wed, 13 Mar 2024 04:03:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fm26-20020a05600c0c1a00b00413ebdca679sm841873wmb.37.2024.03.13.04.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:03:06 -0700 (PDT)
Message-ID: <c0a5a1cc-a6bb-4856-a708-d19195aacb9f@linaro.org>
Date: Wed, 13 Mar 2024 12:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf()
 in do_command_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 13/3/24 09:57, Mark Cave-Ayland wrote:
> The aim is to restrict the esp_fifo_*() functions so that they only operate on
> the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
> underlying Fifo8 functions directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 590ff99744..f8230c74b3 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -265,7 +265,7 @@ static void esp_do_nodma(ESPState *s);
>   
>   static void do_command_phase(ESPState *s)
>   {
> -    uint32_t cmdlen;
> +    uint32_t cmdlen, n;
>       int32_t datalen;
>       SCSIDevice *current_lun;
>       uint8_t buf[ESP_CMDFIFO_SZ];
> @@ -275,7 +275,7 @@ static void do_command_phase(ESPState *s)
>       if (!cmdlen || !s->current_dev) {
>           return;
>       }
> -    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
> +    memcpy(buf, fifo8_pop_buf(&s->cmdfifo, cmdlen, &n), cmdlen);

'n' is unused, use NULL?

>   
>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
>       if (!current_lun) {


