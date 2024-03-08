Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79636C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXnA-0002Ih-2u; Fri, 08 Mar 2024 05:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riXn8-0002IL-JU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:49:30 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riXn6-0004G7-LN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:49:30 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e64647af39so1839719b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709894967; x=1710499767;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2uCxD3DdxDsYZMD1GQV0Wv1IgoUr+dZxgojwO69mOmo=;
 b=jCIefJPwjNKR7Jln6PHK+zELPfxHlN75ImvhSjM2ApFbAW9qiIIhpMlBhI/yf0ltXx
 NOut9x+8bHwtxjhq4gnroHr3IFWTN0MPrpnSBTNyVtH4THdyVl1klcyKNIR+3iMNNMf7
 Pbp+XHBMEzsYHS+EDWhZC8/GF1HsgDVsNBt5V4NVWiWW+8MKKd1lSNcbs2dFQP8zc65m
 +Yz0bqVeytbUKs4yCXHpyBh7M6cEGgfyoe1SUNkj77iL9+6NQQokmpPuaZw9kt92rDGK
 OMsZv4NQAhUutUzBtPtIm5baecxE6aDuwc+Jb7VY7yLAW+JLPtloAVM4PMPFcnWwcopu
 7Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709894967; x=1710499767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uCxD3DdxDsYZMD1GQV0Wv1IgoUr+dZxgojwO69mOmo=;
 b=u7bV0zDd0mga5GaG7rb5C1ZBpIlDNijXfn2tZ8PlD88k/CS8ZivMYWCVJKQgTm4YyB
 D/biG7LYx2epqWkfbwIuHuYcFHyA6+rw6Rc3GNSnQDhvyPU5mWY1lARyv3bDjFAEiSh0
 cUii2uA9Dbe1HE7lPNuAxatAD+Qci/dADXdkLx14JIpD4pooUmB9dV7XXFRcX+apJs9i
 PMEaAzeIStcC1DUCWcA905Wbr4YsyBivFceDrvwDgUuYHVsh2kg8CsNdDMCvgQ1cWHml
 ZPMD6bW7rAioqECE4lUV2w5My7KCDpUmrTtkPDsbau8QP8gsW/xRvooD5J4G/LRYzYif
 pJ9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkXSQiQEXEw6XzIIqAGYdnnTax0qpZ54+zo0adkSKmoAQ5YJcUPUYrgdL1gnOTc1PfAiygOGwd12Y66NRZX2YK4oopFkY=
X-Gm-Message-State: AOJu0YxcO/qQezFyVmgkhagvvXgJvH4TZexdahP3VpHdvJRbYudRmAU9
 kIh6h96ojcOy4Vastrobq1jmhcSnCgUrpBWdPGzehrPusHK2Fd18mBQKdJi5j2g=
X-Google-Smtp-Source: AGHT+IHRpl8uIVeKUaOz1oETMTWNsjjRVmPSxi8i9hLaJQtlgRx1n6HLAMRj1dd2cQPP6W4MM4xiiQ==
X-Received: by 2002:a05:6a20:6704:b0:1a1:3cb:e1f0 with SMTP id
 q4-20020a056a20670400b001a103cbe1f0mr9710291pzh.52.1709894966600; 
 Fri, 08 Mar 2024 02:49:26 -0800 (PST)
Received: from [157.82.206.27] ([157.82.206.27])
 by smtp.gmail.com with ESMTPSA id
 p16-20020aa79e90000000b006e6672b7ba5sm1401366pfq.9.2024.03.08.02.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 02:49:26 -0800 (PST)
Message-ID: <957aa466-d3fe-442c-82f0-e85ed3cb9751@daynix.com>
Date: Fri, 8 Mar 2024 19:49:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] igb: fix link state on resume
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240308085643.1264964-1-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240308085643.1264964-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/03/08 17:56, Laurent Vivier wrote:
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
> +    igb_autoneg_resume(core);
> +

The comment present in the previous version is gone.

Regards,
Akihiko Odaki

