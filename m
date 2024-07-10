Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905A8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU99-0000JF-0A; Wed, 10 Jul 2024 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRU97-00006b-Ll
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRU95-0007ex-LA
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720605713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GRMAYPAsWEix64BJKJN4/MFcR2IxCQW8etUoqAMvKmM=;
 b=fL7BNC+HYW08bqQVZmSG4rCAE8MfWOPBsouCQz7NDXQyzG42YAnHu67ZORXkAHRTu9nVfx
 o0MCK1yGb/k7stLKzmXx4MB6axMcenb5qV4t69S4JOCq+3xAYjly3auXRJX9CBPh11FhiT
 cGBQNySkd62h2BB2RvjxK9ZgCgOtkSg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-clvTH8VDO8ODquEiVZ46yw-1; Wed, 10 Jul 2024 06:01:52 -0400
X-MC-Unique: clvTH8VDO8ODquEiVZ46yw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367a058fa21so356391f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 03:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720605710; x=1721210510;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRMAYPAsWEix64BJKJN4/MFcR2IxCQW8etUoqAMvKmM=;
 b=TP3Tiu5SJfxrPLoXyJZrb9BR7+GM//e0EHfwFq8igPSg90hxrweVRNeFXXMvQE3ITk
 dcJGigxkmdaaKfMwJsoe5TredusyW4a6NTlRkrtjClhTXVGkCLDkj/0IfC2rZwd8iGRW
 QweRnMqooO18ZS/Vt65sbJSJhhQmvh9z9reXPMVUX9o6du8quoNyFdZAEMCjCcNGhoao
 jpVyMo48Qud/toL8Jha407zKc0gP/+cGf5NVDPcR9+PZ7Y0cc3S42hp/80Pzq3jNZsLR
 RfmRT+hF475u0Y56+XhjPQK8HD34VtaHpVjWmzQolwRiO+T1CTRnPjz5V61dB+A4EbFf
 vjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/UNlQFFQ0vgIkQGPNCKLyUNjAgKOdIKy+q8FsEOxlpre/onrHB5bRcsm7BqHKujMEy+yjXNqRzdhan37gF20RO0/Oa9U=
X-Gm-Message-State: AOJu0Yxx7MKpACEjMPhJ2aMAJWbJe6ymwueMY9TJ/wDZ0V+O5PiLIefl
 V0rRVGXN4l6gwFwCYK8+L6NGeeTcpM5sTqnqm5Odrv+umIJRCXPemCO2eRIls9vnIAdFcSmLlA6
 mABXrNBuAbqp1z+cKZ71DepvN7iLphsgADaKURWq/HbMigAFLNgRdP5mr5MEd
X-Received: by 2002:a5d:6552:0:b0:366:e9fa:17b with SMTP id
 ffacd0b85a97d-367d29464b1mr4009061f8f.1.1720605709891; 
 Wed, 10 Jul 2024 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxBc1PDNxkBPsRYFYqyHFuiFgBcREF0Luf3rHsI2lLoJcgoqDFewxmwbQ7vf1TzmYWPKlE7A==
X-Received: by 2002:a5d:6552:0:b0:366:e9fa:17b with SMTP id
 ffacd0b85a97d-367d29464b1mr4009039f8f.1.1720605709411; 
 Wed, 10 Jul 2024 03:01:49 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-367cde891cesm4932946f8f.62.2024.07.10.03.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 03:01:48 -0700 (PDT)
Message-ID: <85f63a2b-00ed-40c0-b5b2-6544c67a3a28@redhat.com>
Date: Wed, 10 Jul 2024 12:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
To: TaiseiIto <taisei1212@outlook.jp>, qemu-devel@nongnu.org
Cc: mst@redhat.com
References: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hello!  Thanks for looking after the HPET, which is not a very well
maintained device.

I am not sure your patch needs to mask the comparator with

	timer->cmp &= 0xffffffffULL;

I think that's a bug in the "case HPET_TN_CMP + 4" part of
hpet_ram_write.  The logic was changed in "hpet: Fix emulation of
HPET_TN_SETVAL" but the commit forgot to apply it to the high bits of
the comparator.

The whole handling of writes to the comparator is very messy.  I can
see two more bugs:
* Idon't think it's correct that HPET_TN_CMP+4 does not clear
HPET_TN_SETVAL
* the clamping should take into account that new_val is shifted by 32

Can you check that this also fixes the problem:

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885db..11df272fe87 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  timer->period =
                      (timer->period & 0xffffffff00000000ULL) | new_val;
              }
+            /*
+             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the
+             * high bits part as well.
+             */
              timer->config &= ~HPET_TN_SETVAL;
              if (hpet_enabled(s)) {
                  hpet_set_timer(timer);
@@ -562,7 +566,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
              if (!timer_is_periodic(timer)
                  || (timer->config & HPET_TN_SETVAL)) {
                  timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                  /*
                   * FIXME: Clamp period to reasonable min value?
                   * Clamp period to reasonable max value
@@ -562,20 +566,21 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
              if (!timer_is_periodic(timer)
                  || (timer->config & HPET_TN_SETVAL)) {
                  timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                  /*
                   * FIXME: Clamp period to reasonable min value?
                   * Clamp period to reasonable max value
                   */
-                new_val &= (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1;
+                new_val = MIN(new_val, ~0u >> 1);
                  timer->period =
                      (timer->period & 0xffffffffULL) | new_val << 32;
-                }
-                timer->config &= ~HPET_TN_SETVAL;
-                if (hpet_enabled(s)) {
-                    hpet_set_timer(timer);
-                }
-                break;
+            }
+            timer->config &= ~HPET_TN_SETVAL;
+            if (hpet_enabled(s)) {
+                hpet_set_timer(timer);
+            }
+            break;
          case HPET_TN_ROUTE:
              timer->fsb = (timer->fsb & 0xffffffff00000000ULL) | new_val;
              break;
@@ -605,7 +605,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  s->hpet_offset =
                      ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
                  for (i = 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp != ~0ULL) {
+                    if (timer_enabled(timer)) {
                          hpet_set_timer(&s->timer[i]);
                      }
                  }

(the final part is taken from your patch)?

Thanks,

Paolo

On 6/18/24 15:10, TaiseiIto wrote:
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
> ---
>   hw/timer/hpet.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..2dcefa7049 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                   s->hpet_offset =
>                       ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>                   for (i = 0; i < s->num_timers; i++) {
> -                    if ((&s->timer[i])->cmp != ~0ULL) {
> -                        hpet_set_timer(&s->timer[i]);
> +                    HPETTimer *timer = &s->timer[i];
> +                    if (timer_enabled(timer)) {
> +                        if (timer_is_periodic(timer)) {
> +                            timer->cmp &= 0xffffffffULL;
> +                        }
> +                        hpet_set_timer(timer);
>                       }
>                   }
>               } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {


