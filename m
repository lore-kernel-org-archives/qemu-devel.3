Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05981C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 14:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7yV6-00084Q-AB; Fri, 17 May 2024 10:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7yV4-000843-TL
 for qemu-devel@nongnu.org; Fri, 17 May 2024 10:23:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7yV0-0005lY-80
 for qemu-devel@nongnu.org; Fri, 17 May 2024 10:23:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-572f6ee87c1so4619978a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715955831; x=1716560631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T3Jr+pPyO3WnQa3ZK1Qjhf63jHL8k886EREWBIH/NoY=;
 b=D9hTUDpA8KKTNz6nWJXJlw4JGAnpxFWiioyxYL5CU8XGpBcuI39BiEe1bklEXvmiYW
 pOJJc373y+n1ACKkmZGusecLB84xuJFj0n7wHn+m8ltKakzQqnWfWO2vGP579YFVmYYc
 hHx2g8lEjRjahflVj5EIhw7TxepGxz4vBx29s+qQeydQ/b8BLqOC5lV/osZXv1foz4sl
 3cwUbk5OhXzPsRQZj5b3MT5lwiyWyPSbTyE7fZf0Xp7cZz5RKxdlbrcD9aUB6BbZN7mx
 cCWgd2RUwUS+IW3xXI3BGHyJvyeOdFgEc/mIMnF4/RgkyKf5FU0UR24kT22syVHaA5KR
 wjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715955831; x=1716560631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3Jr+pPyO3WnQa3ZK1Qjhf63jHL8k886EREWBIH/NoY=;
 b=P67h4glLTSLmzoDsYiA6K/oxwWlSJtidbIOO5q4Bs+3oV3ldRRa4qPO+2i+boy2s6Q
 6WShuRtudYZTIOqhY1RoJ+E1V3tZK26HS1ucixQKXD21m+R/rL6Dnc3P8l2jowuVG4s2
 +qJf0TxdfPiaVV4Rh9ZEts6hBd9ZsYj53UNvWUxIAGptILGyL+TNhL1r57tMD6vK5JHv
 SYsZ6bV0fLqrlbjPPrwYfPwsrxNRg6StNjx19qH+VzKFjWL0lxQVG6BgOyOcmnOnCr0k
 sWI/ef2QHEYkufIgJFZrwlmbr/EiD3P9E1L6NPGMbZFgCpVZRhMZDvfTwTBaODfkBgDl
 rl/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIznPrzH6umk3XA7Eun+gociR81Zckf/VGfafhMZToMZgHx6vM7GbMCHrjHuY+VaERuGK9gB1zZmqdBSyXdi5qSTYEgII=
X-Gm-Message-State: AOJu0YyYbdvCK9hNlwQumSFCtB5D+BleT3zPvcHa8TPRs2gCOfUKNgsH
 ig4TPCpoQGxDfTLq28ORYHa3EsbOjjJkMy08bqSfDIBqghuCW5todF28YaPIj+k=
X-Google-Smtp-Source: AGHT+IFr81U2ed1yDiXUb5tz8aWX2q3yByaaX/gwR6W3TBFu9eFx/a65go5RlnnCT01v5YERHTL0ZA==
X-Received: by 2002:a50:ccdd:0:b0:574:eace:b7bd with SMTP id
 4fb4d7f45d1cf-574eacecf60mr7217292a12.11.1715955831574; 
 Fri, 17 May 2024 07:23:51 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5751cc0f954sm955607a12.74.2024.05.17.07.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 07:23:50 -0700 (PDT)
Message-ID: <3e9dba5c-638a-4b04-8e54-8dff87fe067f@linaro.org>
Date: Fri, 17 May 2024 16:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scsi-bus: Remove unused parameter state from
 scsi_dma_restart_cb
To: Ray Lee <hburaylee@gmail.com>, qemu-devel@nongnu.org
Cc: hbuxiaofei@gmail.com
References: <20240517071445.149364-1-hburaylee@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240517071445.149364-1-hburaylee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Hi Ray,

On 17/5/24 09:14, Ray Lee wrote:
> Signed-off-by: Ray Lee <hburaylee@gmail.com>
> ---
>   hw/scsi/scsi-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 9e40b0c920..7c3df9b31a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -255,7 +255,7 @@ static void scsi_dma_restart_req(SCSIRequest *req, void *opaque)
>       scsi_req_unref(req);
>   }
>   
> -static void scsi_dma_restart_cb(void *opaque, bool running, RunState state)
> +static void scsi_dma_restart_cb(void *opaque, bool running)
>   {
>       SCSIDevice *s = opaque;
>   

scsi_dma_restart_cb() is registered as callback:

  dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
                                                   scsi_dma_restart_cb,
                                                   dev);

The function prototype is (see include/sysemu/runstate.h):

   VMChangeStateEntry *
   qdev_add_vm_change_state_handler(DeviceState *dev,
                                    VMChangeStateHandler *cb,
                                    void *opaque);

and VMChangeStateHandler is defined as:

   typedef void VMChangeStateHandler(void *opaque,
                                     bool running,
                                     RunState state);

So even if the callback argument is not used, its prototype must
respect the VMChangeStateHandler definition. Thus your patch is
not correct. Indeed when building QEMU with your patch I get:

[152/339] Compiling C object libcommon.fa.p/hw_scsi_scsi-bus.c.o
../../hw/scsi/scsi-bus.c:359:13: error: incompatible function pointer 
types passing 'void (void *, bool)' to parameter of type 
'VMChangeStateHandler *' (aka 'void (*)(void *, bool, enum RunState)') 
[-Wincompatible-function-pointer-types]
             scsi_dma_restart_cb, dev);
             ^~~~~~~~~~~~~~~~~~~
include/sysemu/runstate.h:24:76: note: passing argument to parameter 
'cb' here
 
VMChangeStateHandler *cb,
 
    ^
1 error generated.

Please test your patch :)

Regards,

Phil.

