Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41167C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNmM-00069F-66; Thu, 04 Jul 2024 10:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPNmK-00068s-Hs
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPNmI-0003fB-Tn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720104580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dLJQEcAty7+LwAOC7ei/wZUkJQhI4/p1Vwyee5EATXE=;
 b=CnQgK3Mlyrby2tW+cKR+vji4D9ZESrf+eXnwzrkeOmZYDcBJabHv2Xi6+ZqalokMxoTa66
 t2rlbX6J27bLFUC34WpHpR/f2bPXZf+ytuM9gZ62Tf+RQ5vTPtAVvccSu/RQ3eofwLA+RY
 SRXcT4AUVvypMOMYtwKPTkfDeHxa2Ms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-4LuAF7FXPB-9OzptlUk8SQ-1; Thu, 04 Jul 2024 10:49:38 -0400
X-MC-Unique: 4LuAF7FXPB-9OzptlUk8SQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42648daf064so4469425e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 07:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720104577; x=1720709377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLJQEcAty7+LwAOC7ei/wZUkJQhI4/p1Vwyee5EATXE=;
 b=b1tEXPdo7WUhwrrEZ5DW+ZWN2gai+WuQueOHYd2pZ5U787tNQzyQaywkOPbhfADcTC
 F7MWAcK17SyUsdDeiLRC7MbhhH2DeleJ9jkj2SkAXdiJEY/Vr7qryVWCxESb3J3LimmE
 sSbX91mFqlULDoCEqYfbTSMtgqJ1sgBcK6b1HI8yhVqLlwHZCH82woveeLXfIv6aecY9
 y/cibdbgsWDTUSkMjIrbj2D1eE5HDiNqW5KzG+yGC7Afu3tYrURrB+NJD8qNmJeJfEVD
 GMTcV6RblSziygCI2ORIDAszwldnzWxmAI502Q/X9IrDGNqwJR6CsDSVAuuMtxkN68v/
 5WjA==
X-Gm-Message-State: AOJu0YyKB9kWubF05E2NyuWn/F06xz21C2U0salf6al3meH+HOPs0VzM
 BhPUQTXk6ZFyluT9TMOjoKZLF7FFJzF91/D8sOUMdMJF/nLNvg4sNn+Lq8Yb5EXvbfnpIUxWOfF
 GgmClv8h8eas/2wVzNmPJCP+IuSsLlRqhX8XH3+BC7MtXys/AepDn
X-Received: by 2002:a05:600c:4d96:b0:424:7425:f8a0 with SMTP id
 5b1f17b1804b1-4264b1619afmr17703325e9.15.1720104577047; 
 Thu, 04 Jul 2024 07:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyLJGuefgLarHTSdSxcdTH9Ccw9fruO3M23ogNhrZW7g5gbITlGY/C0WzFMSa1V6jKDBkIzw==
X-Received: by 2002:a05:600c:4d96:b0:424:7425:f8a0 with SMTP id
 5b1f17b1804b1-4264b1619afmr17702925e9.15.1720104576450; 
 Thu, 04 Jul 2024 07:49:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1dd902sm28071535e9.12.2024.07.04.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 07:49:35 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:49:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: TaiseiIto <taisei1212@outlook.jp>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Message-ID: <20240704104833-mutt-send-email-mst@kernel.org>
References: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 18, 2024 at 01:10:44PM +0000, TaiseiIto wrote:
> Before this commit, there are 3 problems about HPET timer interrupts. First,
> HPET periodic timers cause a too early interrupt before HPET main counter
> value reaches a value written its comparator value register. Second,
> disabled HPET timers whose comparator value register is not
> 0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers whose
> comparator value register is 0xffffffffffffffff don't cause any interrupts.
> About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa
> to an HPET periodic timer comparator value register. As a result, the
> register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits
> of the register doesn't affect itself in periodic mode. (see
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
> which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the
> HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
> comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
> time. The period (0xaaaaaaaa) is added to the comparator value register at
> "hpet_timer" function because "hpet_time_after64" function returns true when
> the main counter is small. So, the first interrupt is planned when the main
> counter is 0x0000000055555554, but the first interrupt should occur when the
> main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code to
> clear the higher 32 bits of comparator value registers of periodic mode
> timers when HPET starts the main counter. About the other two problems, it
> was decided by comparator value whether each timer is enabled, but it should
> be decided by "timer_enabled" function which confirm "HPET_TN_ENABLE" flag.
> To solve these problems, I fix the code to decide correctly whether each
> timer is enabled. After this commit, the 3 problems are solved. First, HPET
> periodic timers cause the first interrupt when the main counter value
> reaches a value written its comparator value register. Second, disabled HPET
> timers never cause any interrupt. Third, enabled HPET timers cause
> interrupts correctly even if an HPET driver writes 0xffffffff to its
> comparator value register.
> 
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>

I didn't get this patch previously. Donnu why.
Tagged now.

> ---
>  hw/timer/hpet.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..2dcefa7049 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                  s->hpet_offset =
>                      ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>                  for (i = 0; i < s->num_timers; i++) {
> -                    if ((&s->timer[i])->cmp != ~0ULL) {
> -                        hpet_set_timer(&s->timer[i]);
> +                    HPETTimer *timer = &s->timer[i];
> +                    if (timer_enabled(timer)) {
> +                        if (timer_is_periodic(timer)) {
> +                            timer->cmp &= 0xffffffffULL;
> +                        }
> +                        hpet_set_timer(timer);
>                      }
>                  }
>              } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
> -- 
> 2.34.1
> 
> 


