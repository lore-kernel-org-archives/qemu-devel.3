Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5CC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmXa-0002Pq-1x; Thu, 27 Mar 2025 08:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmXU-0002PC-IU
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmXQ-00089r-Uj
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743079246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j6x6fmfYJedj7rFexmcTFyIux98BeOwXUCyFMaHJhug=;
 b=exq4I55SpBIznneOVUOC8xiMSl6G+qnTdPS9ZSe4rLKbmAP+sSZa/OrMBSe1OBWXaPfwTj
 Eo3Z/Yw9yIkZ/KTrELOdJ7WH/LCtzfJOD7UBEfbO2yC5Hjkcor1goAjh3IGaWczfCHPowT
 crFXHz4ul/+FsmhIHNXoRcbbUsBgTt8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-38FpsR0RN7SopCSCn14A_g-1; Thu, 27 Mar 2025 08:40:45 -0400
X-MC-Unique: 38FpsR0RN7SopCSCn14A_g-1
X-Mimecast-MFC-AGG-ID: 38FpsR0RN7SopCSCn14A_g_1743079245
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-72bd7984706so745911a34.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743079243; x=1743684043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6x6fmfYJedj7rFexmcTFyIux98BeOwXUCyFMaHJhug=;
 b=SrdXbMNPZv+Sujwlq8gqybrDSoEEAPY9bXTMIhwuP++JPSqLW8yJetWqNM+wl5esqN
 5VZG+yMGya+og+CnxM8EAoQY4KhQSWOHYOHmBP0xwoVZtOg3rwTapyVFaZkaVtBk78te
 W4HvYAMlqZRE/LTvBDne++2bmd7qSiDs26EdrZ/1sNgYpjLsRFhCZr46BAh6uJdNp5Ff
 cb4EQdOxyt4yxmdsTJ71G999q1fQcRGJVEnTrSxQ9cVFsQurBnmcEv/KkkjQTbqg2BP1
 XKHKUGX3l05tfjxWBRGJikXBpKYK5GzmmpLtss1CYzC6mluBF9Cgb503U4R1Nh+vVDx0
 a1wA==
X-Gm-Message-State: AOJu0YxmR/AxT1+r4/gcJJIx77rDd+HrZZhcLWmJjfzOxC5RauT0zdkL
 eMlZFsxK314kLJsQ1UvGGwgw6JHNte+lEunz8FckpxXT3hxxuVfC/a4QW4l+Iz4G0+Cn2axwuAb
 AlT1qSzBUhJINMKiVV//UyZrdlw7JgQi6ylOmsUf6whWqFtw7qOvK5qAppXBUaD7Bnq8xJqy2ut
 q71Md9KcKCJ2pAtwRAQejTBqnz7PxXnmvez3mwdQ==
X-Gm-Gg: ASbGnctXwwJs0/T49uUOd6H2uz+CS9Q2z3/EZ746eLN9915nSXJRYNuf6yGixPzmn4x
 gsrLOaR0gbFaItXxNn2+C/b5nTmZsfYapotlFgndN1M63hxkW+5BEhqhuWxK5a3SA4HvsId6BQ1
 o=
X-Received: by 2002:a05:6830:264f:b0:72a:f44b:13ed with SMTP id
 46e09a7af769-72c4c930df4mr2054886a34.2.1743079242746; 
 Thu, 27 Mar 2025 05:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB9yYVIXRaXiGpw6UDySZH2xstZzQTUpIyt5/Dloa/B/lK25qtLTpns2DtEjVw+7/+6mXGmvAywmHZ7Bqo9rY=
X-Received: by 2002:a05:6830:264f:b0:72a:f44b:13ed with SMTP id
 46e09a7af769-72c4c930df4mr2054869a34.2.1743079242350; Thu, 27 Mar 2025
 05:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <551d9eaf-dce0-4cf0-95b1-d2347bfaa1a6@gmail.com>
In-Reply-To: <551d9eaf-dce0-4cf0-95b1-d2347bfaa1a6@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 18:10:24 +0530
X-Gm-Features: AQ5f1JpDwkM1oEbtMiEJGwQOOT5A1a8BY6mstw43UHIwP7mUIF-AKzP0-dSfdPc
Message-ID: <CAE8KmOwQBxbjp4a_-kuv_m8SBbFPLsyzQbdqF2nEHs3nG+sQOg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/e1000: fix memory leak in timer_del()
To: Zheng Huang <hz1624917200@gmail.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On Thu, 27 Mar 2025 at 16:59, Zheng Huang <hz1624917200@gmail.com> wrote:
> This patch addresses a memory leak bug in the usages of `timer_del()`.
> The issue arisesfrom the incorrect use of the ambiguous timer API
> `timer_del()`, which does not free the timer object. The leak sanitizer
> report this issue during fuzzing. The correct API `timer_free()` freed
> the timer object instead.
>
> In addition, I'd like to ask for a way to fix all 100+ wrong usages. In my
> opinion, the best way to fix this is to hide to `timer_del()` API and
> eliminate all usages of it.
>
> @@ -379,9 +379,9 @@ static void e1000_reset_hold(Object *obj, ResetType type)
>      E1000BaseClass *edc = E1000_GET_CLASS(d);
>      uint8_t *macaddr = d->conf.macaddr.a;
>
> -    timer_del(d->autoneg_timer);
> -    timer_del(d->mit_timer);
> -    timer_del(d->flush_queue_timer);
> +    timer_free(d->autoneg_timer);
> +    timer_free(d->mit_timer);
> +    timer_free(d->flush_queue_timer);
>      d->mit_timer_on = 0;
>      d->mit_irq_level = 0;
>      d->mit_ide = 0;
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2413858790..61fdc8a3e9 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -127,7 +127,7 @@ static inline void
>  e1000e_intrmgr_stop_timer(E1000IntrDelayTimer *timer)
>  {
>      if (timer->running) {
> -        timer_del(timer->timer);
> +        timer_free(timer->timer);
>          timer->running = false;
>      }
>  }
> @@ -360,13 +360,13 @@ e1000e_intrmgr_fire_all_timers(E1000ECore *core)
>      int i;
>
>      if (core->itr.running) {
> -        timer_del(core->itr.timer);
> +        timer_free(core->itr.timer);
>          e1000e_intrmgr_on_throttling_timer(&core->itr);
>      }
>
>      for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
>          if (core->eitr[i].running) {
> -            timer_del(core->eitr[i].timer);
> +            timer_free(core->eitr[i].timer);
>              e1000e_intrmgr_on_msix_throttling_timer(&core->eitr[i]);
>          }
>      }
> @@ -3452,7 +3452,7 @@ static void e1000e_reset(E1000ECore *core, bool sw)
>  {
>      int i;
>
> -    timer_del(core->autoneg_timer);
> +    timer_free(core->autoneg_timer);
>
>      e1000e_intrmgr_reset(core);

* I doubt if this is correct; Because timer_del() API explicitly says
-> /* stop a timer, but do not dealloc it */

* Secondly: autoneg_timer/mit_timer/flush_queue_timer objects are
freed in 'pci_e1000_uninit()/e1000e_pci_uninit()' functions via
timer_free() calls. So the memory leak could be because the respective
*_pci__uninit() function is not called?

Thank you.
---
  - Prasad


