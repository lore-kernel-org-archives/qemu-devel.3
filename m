Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2B8C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSU2J-0005LX-3I; Tue, 23 Jan 2024 22:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSU2H-0005Js-7T
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:34:45 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSU2F-0005Fy-3f
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:34:44 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so3423054b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706067282; x=1706672082;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XvVMIQZ2rBWxzYDmBj6h0uRoCxx704eggyzxCN2WUV8=;
 b=MrkPhoWlxWc2Q2UczWLqMmy9JNwybiZokANe+F/t8fBFldIIyNETzL37Q/E7iOoh5t
 SImtEoyHmHeGI9qFc8DV4zQZkJe9fdP6OmE99ifMow/0yDuC5IsKKXmWh3FSIx/DyQcS
 s6T5p7jx4QhnScZOxq5AWsB3hB2J1wfm4H9SpitVXF/6Pr5kI3t/HH77+jHy3TsQjJWA
 2/Eap3aK6ShUi+AspQvQa48Apm+SZnBGOSS2Aa5T40in5/j0bgDyqL5bbzMz0ErLjxM0
 I1hpJ1G5lgMSBVzwU517xEY2Ks338/j/1HGyUR6z8LUM0OwBjihKMZhIeVkzUrHv9sVI
 pGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706067282; x=1706672082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XvVMIQZ2rBWxzYDmBj6h0uRoCxx704eggyzxCN2WUV8=;
 b=VMs8ffMb2n+GaallfA6XOH1FY4IrHPjqCuZaGK2r3PqAXvIZ9wtfBaG2GIJdIaMdfT
 xCrIctwIE5ThiiC9F3iAYA53RtS1yt4w9vXK4tT0ocibbda5/EhYFoGdIG+R3pKq15iu
 gMSid/LXLyG7NZ2LCoA4V7K1viUTDVQjcXWzcFFSQUik+6g8egDAvzLfcGeeRgaO1DBC
 el+jfEpdyt2XxHq2sv6ee9xyC19UUKCL0DYID1YkVTm4IJSeG1zr1CLpbSZGhNvvzthw
 4Vb3nWC7gVFItXkoE4EcjBPjlxHEXdiAo1zJtqoL2P/AMAHBTH2F2r/2cxQ/xxuIrLIe
 9SNQ==
X-Gm-Message-State: AOJu0YxVYqLC/lcK6VhRli/PleX+KO6J0Zc/Cr2oU0y2vpuIFy0np0u1
 Gmbwj79kXrjpVdNeg6F8t+T5jD9asjZoZR3MAjYNheZKY2PhVsOeDWedjRyGKao=
X-Google-Smtp-Source: AGHT+IHy0DkEs0/uUNbk1MT2NFd1fxTBsM6vP7rIgKxfwoym/BoMuhfyV9PMQhGUmDXb7txpifzx6g==
X-Received: by 2002:a05:6808:6407:b0:3bd:a9d9:5724 with SMTP id
 fg7-20020a056808640700b003bda9d95724mr1091747oib.12.1706067281801; 
 Tue, 23 Jan 2024 19:34:41 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a056a00140a00b006d9b2694b0csm12368361pfu.200.2024.01.23.19.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:34:41 -0800 (PST)
Message-ID: <325c852a-0450-4ac4-9119-7fa4f4c73c30@daynix.com>
Date: Wed, 24 Jan 2024 12:34:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] igb: fix link state on resume
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240123112501.305681-1-lvivier@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240123112501.305681-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/23 20:25, Laurent Vivier wrote:
> On resume igb_vm_state_change() always calls igb_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
> 
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
> 
> Reproducer:
> 
>     # qemu-system-x86_64 ... -device igb,netdev=netdev0,id=net0 -S
> 
>     {"execute": "qmp_capabilities" }
>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>     {"execute": "cont" }
> 
> To fix the problem, merge the content of igb_vm_state_change()
> into igb_core_post_load() as e1000 does.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-21867

Please also add Fixes: tag as described in: 
docs/devel/submitting-a-patch.rst

> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/igb_core.c | 47 +++--------------------------------------------
>   hw/net/igb_core.h |  2 --
>   2 files changed, 3 insertions(+), 46 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 2a7a11aa9ed5..31ab959ab8ff 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -160,14 +160,6 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>       }
>   }
>   
> -static void
> -igb_intmgr_timer_pause(IGBIntrDelayTimer *timer)
> -{
> -    if (timer->running) {
> -        timer_del(timer->timer);
> -    }
> -}
> -
>   static void
>   igb_intrmgr_on_msix_throttling_timer(void *opaque)
>   {
> @@ -212,16 +204,6 @@ igb_intrmgr_resume(IGBCore *core)
>       }
>   }
>   
> -static void
> -igb_intrmgr_pause(IGBCore *core)
> -{
> -    int i;
> -
> -    for (i = 0; i < IGB_INTR_NUM; i++) {
> -        igb_intmgr_timer_pause(&core->eitr[i]);
> -    }
> -}
> -
>   static void
>   igb_intrmgr_reset(IGBCore *core)
>   {
> @@ -4290,12 +4272,6 @@ igb_core_read(IGBCore *core, hwaddr addr, unsigned size)
>       return 0;
>   }
>   
> -static inline void
> -igb_autoneg_pause(IGBCore *core)
> -{
> -    timer_del(core->autoneg_timer);
> -}
> -
>   static void
>   igb_autoneg_resume(IGBCore *core)
>   {
> @@ -4307,22 +4283,6 @@ igb_autoneg_resume(IGBCore *core)
>       }
>   }
>   
> -static void
> -igb_vm_state_change(void *opaque, bool running, RunState state)
> -{
> -    IGBCore *core = opaque;
> -
> -    if (running) {
> -        trace_e1000e_vm_state_running();
> -        igb_intrmgr_resume(core);
> -        igb_autoneg_resume(core);
> -    } else {
> -        trace_e1000e_vm_state_stopped();
> -        igb_autoneg_pause(core);
> -        igb_intrmgr_pause(core);
> -    }
> -}
> -
>   void
>   igb_core_pci_realize(IGBCore        *core,
>                        const uint16_t *eeprom_templ,
> @@ -4335,8 +4295,6 @@ igb_core_pci_realize(IGBCore        *core,
>                                          igb_autoneg_timer, core);
>       igb_intrmgr_pci_realize(core);
>   
> -    core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
> -
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
>       }
> @@ -4360,8 +4318,6 @@ igb_core_pci_uninit(IGBCore *core)
>   
>       igb_intrmgr_pci_unint(core);
>   
> -    qemu_del_vm_change_state_handler(core->vmstate);
> -
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
>       }
> @@ -4586,5 +4542,8 @@ igb_core_post_load(IGBCore *core)
>        */
>       nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
>   
> +    igb_intrmgr_resume(core);

Please add a comment to note that an old version of QEMU pauses the 
intrmgr timers. Otherwise this looks unnecessary.

Regards,
Akihiko Odaki

