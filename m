Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CA0C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfmV-0003W1-Vp; Tue, 16 Jul 2024 06:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTfmV-0003VX-9E
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTfmE-0004CT-VJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721127079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n6BYVNNZVP39nT/WG3Zy/ktffzjBk2lR8pGdDxK77d0=;
 b=NdYzJKBYQsQOqr/LvZCckBo+QOigM2TQNXN7rXTtWUAo1adWVgPq9uxkeHmlPNc5f3tTGR
 ZY2JZC7VFmxETw6phqbQ/xJFoWHNomJNVZbUESaVaPpeRC+Ktjep4xB1sx7IAj8tCJ3CEJ
 PfE/t6FrhZaGpj8qfRkoRses/WLXmNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-AWHTaIMqMSWyzy3kH0ey7A-1; Tue, 16 Jul 2024 06:51:18 -0400
X-MC-Unique: AWHTaIMqMSWyzy3kH0ey7A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367987cff30so3522424f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721127076; x=1721731876;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6BYVNNZVP39nT/WG3Zy/ktffzjBk2lR8pGdDxK77d0=;
 b=fQfqQp2dyATg2MFxZTjUaqqqF6oQZqaT8Q+R6mnoZySLH5Zdjap4wjXp1Ret2odv9i
 ngp+qscAA1b7dRjm22wvbSckaghiJNPyPjsE97iUvRIFuKq5t1WrOcyVxP60c9l8g3Uv
 TbV6Kox4ByeDTY8VCp+G+1d9LxiMzT544CEXIE7koDePHZ8Q9n3jBgCSMNHQvNFVtqKk
 I+aoa73vRvn37AErEZfC39m7pF3pu32+NooAD9k+cH44fDPMlNXlxNwcQa41VBZ08sGF
 VkXhiNeIoRWxS0rSnNknuNAQu5swtCKFpNqtcl1wi1z0VL2J5+DgHh6fXzkS950ZdSS5
 UOOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWLWOuI19h8/F2V5808YRYZdA5+bJrTz+/9oKeRksqDUp8HS/6fGpJ+nBaAkKGLgHueAOcpUL/vNLQfoITZ8DOV+Gd2Jc=
X-Gm-Message-State: AOJu0YwlupcN8zRKBIb74nrfumtNsH912Dq174FAI5y4hMQoZ6U/O5Wt
 cmHezoriw8JQuz7smBwwn6HWZtPTVdteZ7RnwJ14jGV9SBR6oQUpJ5p6wT7kgvLWcwff05vNNA7
 v/++iJNfJadcWMH1eJj9sGkVDRWkWkW1k80fBabGjL1TSAeM+onKJQ4WEYXoM
X-Received: by 2002:a5d:47c4:0:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-36826313455mr1333657f8f.50.1721127076200; 
 Tue, 16 Jul 2024 03:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVac2SQ8vzfvBQRbOfLdiA7aboEtfcVWnVpUF5TMNH4dMG5kGTcTMCwMRqbasyOlROIrj18A==
X-Received: by 2002:a5d:47c4:0:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-36826313455mr1333643f8f.50.1721127075688; 
 Tue, 16 Jul 2024 03:51:15 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3680db047c4sm8715236f8f.108.2024.07.16.03.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 03:51:14 -0700 (PDT)
Message-ID: <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
Date: Tue, 16 Jul 2024 12:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
To: TaiseiIto <taisei1212@outlook.jp>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com
References: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/13/24 13:54, TaiseiIto wrote:
> Before this commit, there are 3 problems about HPET timer interrupts. First,
> HPET periodic timers cause a too early interrupt before HPET main counter
> value reaches a value written its comparator value register. Second,
> disabled HPET timers whose comparator value register is not
> 0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers whose
> comparator value register is 0xffffffffffffffff don't cause any interrupts.
> About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa
> to an HPET periodic timer comparator value register. As a result, the
> register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits of
> the register doesn't affect itself in periodic mode. (see
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
> which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the
> HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
> comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
> time. The period (0xaaaaaaaa) is added to the comparator value register at
> "hpet_timer" function because "hpet_time_after64" function returns true when
> the main counter is small. So, the first interrupt is planned when the main
> counter is 0x0000000055555554, but the first interrupt should occur when the
> main counter is 0x00000000aaaaaaaa. To solve this problem, I fix
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function to ensure that writings
> to higher 32 bits of a comparator value register reflect itself even if in
> periodic mode. About the other two problems, it was decided by comparator
> value whether each timer is enabled, but it should be decided by
> "timer_enabled" function which confirm "HPET_TN_ENABLE" flag. To solve these
> problems, I fix the code to decide correctly whether each timer is enabled.
> After this commit, the 3 problems are solved. First, HPET periodic timers
> cause the first interrupt when the main counter value reaches a value
> written its comparator value register. Second, disabled HPET timers never
> cause any interrupt. Third, enabled HPET timers cause interrupts correctly
> even if an HPET driver writes 0xffffffffffffffff to its comparator value
> register.
> 
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
> 
> Changes in v2:
> - Reflect writings to higher 32 bits of a comparator value register rather
>    than clearing these bits.
> - Fix wrong indents.
> - Link to v1: https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/
> 
>   hw/timer/hpet.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..4b6352e257 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                   timer->period =
>                       (timer->period & 0xffffffff00000000ULL) | new_val;
>               }
> +            /*
> +             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the
> +             * high bits part as well.
> +             */
>               timer->config &= ~HPET_TN_SETVAL;
>               if (hpet_enabled(s)) {
>                   hpet_set_timer(timer);
> @@ -562,20 +566,22 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>               if (!timer_is_periodic(timer)
>                   || (timer->config & HPET_TN_SETVAL)) {
>                   timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
> -            } else {
> +            }
> +            if (timer_is_periodic(timer)) {
>                   /*
>                    * FIXME: Clamp period to reasonable min value?
>                    * Clamp period to reasonable max value
>                    */
> -                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
> +                new_val = MIN(new_val, ~0u >> 1);
> +                timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;

This seems wrong to me.  The comparator must be reset using 
HPET_TN_SETVAL, otherwise it just keeps running.  From the specification:

"If software wants to change the periodic rate, it should write a new 
value to the comparator value register.  At the point when the timer’s 
comparator indicates a match, this new value will be added to derive the 
next matching point. So as to avoid race conditions where the new value 
is written just as a match occurs, either the main counter should be 
halted or the comparator disabled when the new periodic rate is written".

The sentence "at the point when the timer’s comparator indicates a 
match" indicates that the comparator register is not written.

I suspect you're hitting the other issue, and HPET_TN_SETVAL is cleared 
incorrectly by a 64-bit write.  I'll try sending out a patch to fix that.

> -                    if ((&s->timer[i])->cmp != ~0ULL) {
> +                    if (hpet_enabled(s)) {
>                           hpet_set_timer(&s->timer[i]);
>                       }
>                   }

This is incorrect too.  "hpet_enabled(s)" is always true here; I think 
the bug is that timer_enabled() should only affect generation of 
interrupts.  Are you perhaps using level-triggered interrupts?  If so, 
it makes sense that you want the timer to be running - and then when 
setting HPET_TN_ENABLE the interrupt will fire.

However, we're making progress; you're just finding more bugs.

I have some ideas on what needs to be fixed next, and I placed them at a 
branch "hpet" of https://gitlab.com/bonzini/qemu.git.  Unfortunately, I 
don't have a way to test them (writing testcases is on my list but I 
don't have time right now) and as the branch proceeds things get more 
experimental; but let me know if it helps or if you can make small 
changes to the patches that fix your testcase.

Paolo


