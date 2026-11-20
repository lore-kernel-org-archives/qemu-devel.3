Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA1606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wk9CA+Qn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSes-0006xG-Iu; Fri, 20 Nov 2026 12:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUSel-0006wv-IU
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xUSej-00012A-CR
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795196651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9CYbUus4iZNSgGEZyt2lbdoORckiIqqmcJjUOKExSwo=;
 b=Wk9CA+Qn9X077D3wrNtiFu7NBq018MM3LF7KlLVLxaEEDLSeU1otB7Z7cqQghk6BFVPFpy
 FEOD1odalDrbBQk6FzOwwieQ+eItGKRVpsdAt9Ebx5yYIgSCEO8oYRMsL010WQYar3oXc4
 GbyOph8Ioml1MDYRsOqhKzllpcgakL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-pamun9nsOJCMRwxbvNEWcg-1; Fri,
 20 Nov 2026 17:44:01 +0000
X-MC-Unique: pamun9nsOJCMRwxbvNEWcg-1
X-Mimecast-MFC-AGG-ID: pamun9nsOJCMRwxbvNEWcg_1795196640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437B619539BB; Fri, 20 Nov 2026 17:44:00 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 733541956053; Fri, 20 Nov 2026 17:43:57 +0000 (UTC)
Message-ID: <ae110444-bf92-483b-a7ac-72e983f03ae4@redhat.com>
Date: Fri, 20 Nov 2026 18:43:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/rtc/mc146818: Set PF independently of PIE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <xiaoguangrong@tencent.com>, Jason Thorpe <thorpej@me.com>
References: <20261119215956.30750-1-philmd@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261119215956.30750-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 22:59, Philippe Mathieu-Daudé wrote:
> The MC146818A datasheet says PF is latched independently of PIE; PIE
> only makes PF raise IRQF and the IRQ line. QEMU skipped the periodic
> timer when PIE was clear, so PF never latched.
> 
> Compute the period from register A regardless of PIE, and latch PF
> without raising an interrupt when PIE is clear. Stop the timer while
> PF is pending so idle guests are not woken every period, then re-arm
> it when register C is read. Preserve the PF cadence for a late read,
> and restrict SLEW coalescing to PIE=1 so it cannot inject interrupts
> while periodic interrupts are disabled.
> 
> The qtest covers PF latching and re-arming after a delayed register C
> read, and verifies that PIE still controls IRQF and the IRQ line.
> 
> AI-used-for: Regression tests

I have already written a qtest by hand, so I'll send a v4. :)

Paolo

> Fixes: 369b41359af ("mc146818rtc: precisely count the clock for periodic timer")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2021-06/msg05307.html
> 
> Cc: Tai Yunfang <yunfangtai@tencent.com>
> Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
> Cc: Jason Thorpe <thorpej@me.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/rtc/mc146818rtc.c   | 35 ++++++++++++++++++++++++-----
>   tests/qtest/rtc-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 887a8b075825..a6d760fecd00 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -134,10 +134,6 @@ static uint32_t rtc_periodic_clock_ticks(MC146818RtcState *s)
>   {
>       int period_code;
>   
> -    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
> -        return 0;
> -     }
> -
>       period_code = s->cmos_data[RTC_REG_A] & 0x0f;
>   
>       return periodic_period_to_clock(period_code);
> @@ -162,6 +158,18 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
>           return;
>       }
>   
> +    /*
> +     * When the periodic interrupt is disabled the periodic timer only
> +     * serves to set the PF flag in register C. Once it has been set
> +     * there is nothing to do until the flag is cleared by reading
> +     * register C, so keep the timer stopped to avoid useless wakeups.
> +     */
> +    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
> +        (s->cmos_data[RTC_REG_C] & REG_C_PF)) {
> +        timer_del(s->periodic_timer);
> +        return;
> +    }
> +
>       /* compute 32 khz clock */
>       cur_clock =
>           muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> @@ -194,7 +202,8 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
>        *    to a shorter period, scale up the missing ticks since the
>        *    OS handler will treat past delayed ticks as shorter.
>        */
> -    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
> +    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
> +        (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
>           uint32_t old_irq_coalesced = s->irq_coalesced;
>   
>           lost_clock += old_irq_coalesced * old_period;
> @@ -241,6 +250,13 @@ static void rtc_periodic_timer(void *opaque)
>               }
>           } else
>               qemu_irq_raise(s->irq);
> +    } else {
> +        /*
> +         * Only the PF flag is affected when the periodic interrupt is
> +         * disabled. Stop the timer until PF is cleared by a read of
> +         * register C, so that an idle guest is not woken up every period.
> +         */
> +        timer_del(s->periodic_timer);
>       }
>   }
>   
> @@ -702,6 +718,15 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
>               if (ret & (REG_C_UF | REG_C_AF)) {
>                   check_update_timer(s);
>               }
> +            /*
> +             * Clearing PF re-arms the periodic timer: it may have been
> +             * stopped while PF was pending with the periodic interrupt
> +             * disabled.
> +             */
> +            if ((ret & REG_C_PF) && !(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
> +                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
> +                                      s->period, true);
> +            }
>   
>               if(s->irq_coalesced &&
>                       (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
> diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
> index 02ed4e123859..5eca6f65ea95 100644
> --- a/tests/qtest/rtc-test.c
> +++ b/tests/qtest/rtc-test.c
> @@ -540,6 +540,56 @@ static void am_pm_alarm(void)
>       g_assert((cmos_read(RTC_REG_C) & REG_C_AF) == 0);
>   }
>   
> +/*
> + * The manual says the selected periodic tap sets PF in Register C whether
> + * or not PIE is set (PIE only additionally gates IRQF). With PIE clear
> + * the tap must still latch PF, without raising the IRQ line, and reading
> + * Register C must clear PF and let the next period latch it again.
> + */
> +static void pf_without_pie(void)
> +{
> +    uint64_t first, second, period;
> +    uint8_t c;
> +
> +    cmos_write(RTC_REG_B, REG_B_24H);
> +    cmos_write(RTC_REG_A, 15);          /* RS 1111: 2 Hz */
> +    (void)cmos_read(RTC_REG_C);
> +    g_assert(!get_irq(RTC_ISA_IRQ));
> +    period = periodic_clock_to_ns(periodic_period_to_clock(15));
> +
> +    /* PIE is clear: PF latches but no IRQF and no IRQ line.  */
> +    do {
> +        first = clock_step_next();
> +        c = cmos_read(RTC_REG_C);
> +    } while (!(c & REG_C_PF));
> +    g_assert_cmpint(c & REG_C_IRQF, ==, 0);
> +    g_assert(!get_irq(RTC_ISA_IRQ));
> +
> +    /* Reading Register C late must not delay the next PF edge.  */
> +    clock_step(period / 4);
> +    g_assert_cmpint(cmos_read(RTC_REG_C) & REG_C_PF, ==, 0);
> +
> +    /* ...and the next period latches it again.  */
> +    do {
> +        second = clock_step_next();
> +        c = cmos_read(RTC_REG_C);
> +    } while (!(c & REG_C_PF));
> +    g_assert_cmpint(c & REG_C_IRQF, ==, 0);
> +    g_assert(!get_irq(RTC_ISA_IRQ));
> +    g_assert_cmpint(ABS((int64_t)(second - first - period)), <=,
> +                    period / 4);
> +
> +    /* enabling PIE makes the next period raise IRQF and the IRQ line.  */
> +    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
> +    while (!get_irq(RTC_ISA_IRQ)) {
> +        clock_step_next();
> +    }
> +    g_assert_cmpint(cmos_read(RTC_REG_C) & (REG_C_PF | REG_C_IRQF), ==,
> +                    REG_C_PF | REG_C_IRQF);
> +
> +    (void)cmos_read(RTC_REG_C);
> +    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) & ~REG_B_PIE);
> +}
>   /* success if no crash or abort */
>   static void fuzz_registers(void)
>   {
> @@ -709,6 +759,7 @@ int main(int argc, char **argv)
>       qtest_add_func("/rtc/update/uip-stuck", uip_stuck);
>       qtest_add_func("/rtc/misc/fuzz-registers", fuzz_registers);
>       qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
> +    qtest_add_func("/rtc/registers/pf-without-pie", pf_without_pie);
>   
>       ret = g_test_run();
>   


