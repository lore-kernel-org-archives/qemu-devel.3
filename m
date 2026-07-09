Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4B9C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtum-0007L0-VS; Thu, 09 Jul 2026 14:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whtud-0007Kg-QG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:55:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whtuZ-0002AD-JE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:55:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXK9E2518781
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 18:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h87IfPSJiaSlAnvIfXKTXiQ9roUcUITD0tjylikjOKs=; b=luedN2IZf8gF2Eha
 LRsdjtNLXw7snkSmRlg5n9a2jk5m0fqtdUhF5xbB4aKiECbug4Q5q9S8mwLV7geM
 rA8EF4ouSY8VFcD9HbJTymNxBxhtG+vjC6QLvlEZrpAI6EGajVbpvrn2oXBet542
 sHZBtP7RGRGI3X7t3OXE3dK/565JTNK4ofz05sL3+uux+xlI6IWU8DZPVlCdBcmr
 MS5DdkmWE77X70vvEjad9WodRp+pHoPTznTILqZBJFOhkyQWzMZY1qBkiTE4Dw8T
 ZMG1DjCzj/hJ32dSCae4RlBsYt9loMrDVgwYyHAtzS8BlBP3wgOET/BNv39li3w1
 5cDvsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faekn8yj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 18:55:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso1864691cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783623349; x=1784228149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h87IfPSJiaSlAnvIfXKTXiQ9roUcUITD0tjylikjOKs=;
 b=JFHWen8J/ywxZS7NvrqRcvkvxDo8CcWN4Kdl1Yz9qNmry2LecGilnnfLtsjnvnYjh1
 OCYzZt2O5Cy0uDRf01lOT627YA6dwoZn/WiU4b8+nubx2lH5S1JHL55N5F45/HmnyCyi
 4qoJo9sr44zBHhCpxRyXPRjxWaOMjBb4yq/vBmPbcfVriEEAT/DZnGgGx3rDFJ8aM6fd
 V0gNGhytT6DXrGn6gbmJihGx0l+94SMH7H/YIifRAWVBj0K81QpcXxIOu59GG7zrESem
 I3mxzDhr+lxJ47B0wNqNWkFA1u2XYJOhVHBgKM9A89YrBwPFbZFwXpVVVm4RJuhZaymf
 jRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623349; x=1784228149;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h87IfPSJiaSlAnvIfXKTXiQ9roUcUITD0tjylikjOKs=;
 b=PSR76xS60F8rKfFXUjbFWZkaDFdLDE1l0Oa95keNEnXtOxinmk/9MajDq0hMvYeO4l
 o/HTnDctq5QxpA+r0OKQpLRe9BnDcvX8cwxb/Qz1hEiY9icm2xv701vdTKPoGUW6KQaY
 oz/xnToloc61LXPcERl2QDJjt+uSQ9j4NAQrAzrv6jfwQFO5xVZkk8xNoQHmRvuzu1C0
 Ve8uEJ9UE65P/YMMgd87ProVJmux7fpdDCZGdO+Q8ZUcVrncCZ62mGjOGm5zaJMl8wq3
 9WxADKx8fbn1MfirP5J38njBcj2mDyHK8WrBFPPyILICTiMoQ12PqBbP2uiWZnJbvwMP
 15rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTW/YySr93RBVWzr6ycjtyz8dlC701QmyZCTVdI4QGoe/jZdHnesFLXcgOOxoq0vdDGG6scJ8ulZuX@nongnu.org
X-Gm-Message-State: AOJu0YyZlwinLOTseqM/UiN30e25py3nR0ybzz4+56hcX1mGVbi7QWCW
 1Sohk/kKvXrvmmCJB4YhVfMIFGfLaHwaN53JP/6jjPt8+M8HzfZISaITS6DIJ9SbMEwF8AJelaO
 6rSLtIc4wUm2D6QJ6hkvQwG9IZ6ZaQvxS45TFXqPV4KWKOuVxC0b4avnr+w==
X-Gm-Gg: AfdE7clKxZ+/eX5M51Vnk8lLOlAsU1GABVNKdtkNhHjKUsBxncpBid/o2Rxm58m6fwj
 F2Xz0rVCu2O6RnIIw9QDldSBMJdARcU2h3tYLv5g2Wz+lYZvB64SyzjSfk+EaPPp7BNfIzA1Fz3
 8DghPlgwbkO5+KXCpoKurtkU27j9uV86h0w/ud7cp5MW4SKneZTOhgNLepaR2QmMLLu8PChiJmI
 gc2JdvN1oHUHjQH0en//5BSxbXGerJ/wfofhIU+ecg7SkBy3F6MDmTx/FW1+0vDIlZg53Hb+IRS
 K0ptMlbA4r24xAWavkUzUWpwxBVthW9Ogh/X/YZuPT+GWN/BD4ArDM2znB/YOb3nTvS3IMR2MFq
 MRd0EpCfWbvHIcTnSvRWHngIYnZjKr1d8KzZWhVozrBN8m4kkAryUqlB2YCT8yg==
X-Received: by 2002:a05:622a:17ce:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-51c8b2e4204mr82285041cf.34.1783623348842; 
 Thu, 09 Jul 2026 11:55:48 -0700 (PDT)
X-Received: by 2002:a05:622a:17ce:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-51c8b2e4204mr82284761cf.34.1783623348294; 
 Thu, 09 Jul 2026 11:55:48 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm53690539f8f.27.2026.07.09.11.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 11:55:47 -0700 (PDT)
Message-ID: <b87db62f-6c9c-4da5-8382-500adc29b828@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 20:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
 <20260610115850.2410566-2-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610115850.2410566-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NyBTYWx0ZWRfX3up7Uq8oreev
 NuM5rKZAXIbXraK7ZdLmXxv9IYUNU3N9oo3ZkOhLmcG1Km7xn8qTm9ErVGciSy0AABuKXJLhwLM
 B+1x/R9dnM5A8qyPEYOoNznLDI2v6Rk=
X-Authority-Analysis: v=2.4 cv=SNlykuvH c=1 sm=1 tr=0 ts=6a4feeb5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=xM0yZBth02H7qQ3JzjEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-GUID: 0mO8h8s0HZ3w59rUDLUYzSPhzb2DiTLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NyBTYWx0ZWRfX4fEs0Z9JcHrc
 JfHYWWi/+UoTPRpN6Suxw3E+iuE9TlPfCP1XwRud0ooET8id35PeEoBFpnOwVoYOqRb4/v9zRvs
 GFmyxt0DN6sb0BEb0N00XzqkYQ4vBNuQ4S+g7b/ZnRxbh9MMrl1nVNi7NJjJ68xDXC10SCXP7I2
 KhoRDfhpouLT2tQPASKi1FVKokaXpGRxLXnsmgQG+siPrqcBpYslD1jnuAvyzZwl7XRRQpPLVCf
 +ni2d5qO4mnaSirscZQ8BtebC7bR4b7EpzpVajeQiHQRr9yrdzy9aRe2jugRPaMqmWzU+2eFP2/
 Yj0LHaVceAQPrpRjRWVJdE3LAn576m3K7+aCeqyIuSdBm5H0vPnr+vyUtZwkkkf/g7+caV8n6Q5
 A6qCyGrON8ANR9xBbMZ5FqDo3rje5K2V96fZhZLSF/1JEyDro8Nc4WsdkkASerY5WtrqufchL0J
 y1TgarEvdvD3I5eseMQ==
X-Proofpoint-ORIG-GUID: 0mO8h8s0HZ3w59rUDLUYzSPhzb2DiTLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090187
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Denis,

I tried to review, but not my area and way out of my confort zone...
Cc'ing Akihiko & Peter who might have more familiarity :)

On 10/6/26 13:58, Denis V. Lunev via qemu development wrote:
> cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
> by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
> to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
> fire-and-forget: it reads w->to_wake and silently returns when it is
> NULL. A sleeper that is between two iterations -- has just released
> s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
> the wake:
> 
>    iothread0 timer coroutine           main thread (qcow2 close)
>    -------------------------           -------------------------
>    while-body (holding s->lock):
>      read interval = 600
>      wait_ns = 600 * NS
>      release s->lock
>                                        take s->lock
>                                        interval = 0
>                                        qemu_co_sleep_wake(w):
>                                          w->to_wake == NULL -> skip
>                                          return
>                                        qemu_co_queue_wait(exit, s->lock):
>                                          release s->lock
>                                          yield
>    qemu_co_sleep_ns_wakeable:
>      aio_timer_init(+600 s)
>      qemu_co_sleep:
>        cas scheduled NULL -> "qsns"
>        w->to_wake = co
>        yield  [sleeps 600 s]
> 
> cache_clean_timer_del_and_wait() then blocks on cache_clean_timer_exit
> until the original 600 s expiry fires, and qcow2_close() holds BQL the
> whole time so the VM stalls behind it.
> 
> block_copy_kick() has the same shape. Fix the primitive once instead
> of working around it in each caller.
> 
> Use a tri-state for QemuCoSleep::to_wake:
> 
>    NULL     - idle
>    co       - sleeper parked
>    PENDING  - wake delivered, no sleeper yet (sticky)
> 
> qemu_co_sleep_wake() xchgs PENDING into to_wake: a real sleeper is
> woken, NULL/PENDING is left untouched so the wake stays sticky.
> qemu_co_sleep() cmpxchg-publishes itself as the sleeper; if a wake
> was delivered before it got there or races the publish, the cmpxchg
> observes PENDING and returns without yielding. On normal resume
> qemu_co_sleep() clears the PENDING the waker left behind so the next
> sleep starts clean.
> 
> A double-fire (real wake plus timer callback) is harmless: the first
> xchg returns the coroutine and wakes it; the second returns PENDING
> and is a no-op. Cancellation latency through qemu_co_sleep_wake() is
> now bounded by aio_co_wake() rather than by the sleep duration.
> 
> Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qemu/coroutine.h    | 17 +++++++++---
>   tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
>   util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
>   3 files changed, 104 insertions(+), 19 deletions(-)
> 
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index e545bbf620..1c31de60f9 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -260,10 +260,19 @@ int coroutine_fn qemu_co_timeout(CoroutineEntry *entry, void *opaque,
>                                    uint64_t timeout_ns, CleanupFunc clean);
>   
>   /**
> - * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
> - * deleted. @sleep_state must be the variable whose address was given to
> - * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
> - * qemu_co_sleep_wake().
> + * Wake a coroutine sleeping in qemu_co_sleep() or qemu_co_sleep_ns_wakeable().
> + * The timer set up by the latter is deleted on wakeup.
> + *
> + * The wake is sticky: if no sleeper is parked on @w at the time of the call,
> + * the wake is recorded on @w and consumed by the next qemu_co_sleep() on the
> + * same @w, which then returns without yielding. This closes the lost-wakeup
> + * window between two sleeps and is the documented behavior callers should
> + * rely on -- e.g. a cancellation signal raised between iterations of a
> + * sleep/work loop will shorten the next sleep instead of being dropped.
> + *
> + * The state persists until consumed: if no further qemu_co_sleep() is ever
> + * called on @w, the pending wake is harmlessly discarded when @w goes away.
> + * Multiple wakes coalesce -- the next sleep consumes at most one.
>    */
>   void qemu_co_sleep_wake(QemuCoSleep *w);
>   
> diff --git a/tests/unit/test-coroutine.c b/tests/unit/test-coroutine.c
> index 49d4d9b251..aa1f719b08 100644
> --- a/tests/unit/test-coroutine.c
> +++ b/tests/unit/test-coroutine.c
> @@ -421,6 +421,57 @@ static void test_co_rwlock_downgrade(void)
>       g_assert(c1_done);
>   }
>   
> +/*
> + * Check that a wake delivered before the sleeper parks is not lost.
> + *
> + * qemu_co_sleep_wake() is fire-and-forget: a caller cancelling a
> + * sleep/work loop may call it in the window after the sleeper has
> + * decided to sleep but before it has published itself inside
> + * qemu_co_sleep(). The wake must be sticky and shorten the next sleep
> + * rather than being dropped (which would block until the full sleep
> + * duration expired).
> + *
> + * No threads, timers or AioContext are needed: coroutines are
> + * cooperative, so ordering the wake before the sleep deterministically
> + * reproduces the state the racing waker would otherwise produce.
> + */
> +
> +typedef struct {
> +    QemuCoSleep w;
> +    bool completed;
> +} CoSleepWakeData;
> +
> +static void coroutine_fn co_sleep_wake_entry(void *opaque)
> +{
> +    CoSleepWakeData *d = opaque;
> +
> +    /*
> +     * The wake was already delivered before we got here. qemu_co_sleep()
> +     * must consume it and return without yielding.
> +     */
> +    qemu_co_sleep(&d->w);
> +    d->completed = true;
> +}
> +
> +static void test_co_sleep_wake_before_sleep(void)
> +{
> +    CoSleepWakeData d = { .w = { 0 }, .completed = false };
> +    Coroutine *co = qemu_coroutine_create(co_sleep_wake_entry, &d);
> +
> +    /* Waker runs first, while no sleeper is parked on w. */
> +    qemu_co_sleep_wake(&d.w);
> +
> +    /*
> +     * Entering runs qemu_co_sleep(), which consumes the pending wake and
> +     * returns without yielding, so the coroutine runs straight to
> +     * completion in this single enter. With the pre-fix primitive the wake
> +     * is dropped, qemu_co_sleep() parks, and completed stays false.
> +     */
> +    qemu_coroutine_enter(co);
> +
> +    g_assert(d.completed);
> +}
> +
>   /*
>    * Check that creation, enter, and return work
>    */
> @@ -660,6 +711,8 @@ int main(int argc, char **argv)
>       g_test_add_func("/locking/co-mutex/lockable", test_co_mutex_lockable);
>       g_test_add_func("/locking/co-rwlock/upgrade", test_co_rwlock_upgrade);
>       g_test_add_func("/locking/co-rwlock/downgrade", test_co_rwlock_downgrade);
> +    g_test_add_func("/locking/co-sleep/wake-before-sleep",
> +                    test_co_sleep_wake_before_sleep);
>       if (g_test_perf()) {
>           g_test_add_func("/perf/lifecycle", perf_lifecycle);
>           g_test_add_func("/perf/nesting", perf_nesting);
> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
> index edef117284..19ded0b6fd 100644
> --- a/util/qemu-coroutine-sleep.c
> +++ b/util/qemu-coroutine-sleep.c
> @@ -18,20 +18,29 @@
>   
>   static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
>   
> +/*
> + * Sentinel stored in QemuCoSleep::to_wake by qemu_co_sleep_wake() when no
> + * sleeper has parked yet. The next qemu_co_sleep() consumes it and returns
> + * without yielding, so a wake that races the arming of a sleep is never
> + * lost.
> + */
> +#define QEMU_CO_SLEEP_PENDING ((Coroutine *)(uintptr_t)1)
> +
>   void qemu_co_sleep_wake(QemuCoSleep *w)
>   {
>       Coroutine *co;
>   
> -    co = w->to_wake;
> -    w->to_wake = NULL;
> -    if (co) {
> -        /* Write of schedule protected by barrier write in aio_co_schedule */
> -        const char *scheduled = qatomic_cmpxchg(&co->scheduled,
> -                                                qemu_co_sleep_ns__scheduled, NULL);
> -
> -        assert(scheduled == qemu_co_sleep_ns__scheduled);
> -        aio_co_wake(co);
> +    co = qatomic_xchg(&w->to_wake, QEMU_CO_SLEEP_PENDING);
> +    if (co == NULL || co == QEMU_CO_SLEEP_PENDING) {
> +        /* No sleeper, or a wake is already pending. */
> +        return;
>       }
> +
> +    /* Write of scheduled protected by barrier write in aio_co_schedule */
> +    const char *scheduled = qatomic_cmpxchg(&co->scheduled,
> +                                            qemu_co_sleep_ns__scheduled, NULL);
> +    assert(scheduled == qemu_co_sleep_ns__scheduled);
> +    aio_co_wake(co);
>   }
>   
>   static void co_sleep_cb(void *opaque)
> @@ -43,6 +52,7 @@ static void co_sleep_cb(void *opaque)
>   void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>   {
>       Coroutine *co = qemu_coroutine_self();
> +    Coroutine *prev;
>   
>       const char *scheduled = qatomic_cmpxchg(&co->scheduled, NULL,
>                                               qemu_co_sleep_ns__scheduled);
> @@ -53,11 +63,23 @@ void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>           abort();
>       }
>   
> -    w->to_wake = co;
> +    /*
> +     * Publish ourselves as the sleeper. A wake delivered before we got here,
> +     * or one racing this publish, leaves QEMU_CO_SLEEP_PENDING in to_wake;
> +     * the cmpxchg then fails and we consume the wake without yielding.
> +     */
> +    prev = qatomic_cmpxchg(&w->to_wake, NULL, co);
> +    if (prev == QEMU_CO_SLEEP_PENDING) {
> +        qatomic_set(&w->to_wake, NULL);
> +        qatomic_set(&co->scheduled, NULL);
> +        return;
> +    }
> +    assert(prev == NULL);
> +
>       qemu_coroutine_yield();
>   
> -    /* w->to_wake is cleared before resuming this coroutine.  */
> -    assert(w->to_wake == NULL);
> +    /* The waker left QEMU_CO_SLEEP_PENDING; clear it for the next sleep. */
> +    qatomic_set(&w->to_wake, NULL);
>   }
>   
>   void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
> @@ -70,9 +92,10 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
>       timer_mod(&ts, qemu_clock_get_ns(type) + ns);
>   
>       /*
> -     * The timer will fire in the current AiOContext, so the callback
> -     * must happen after qemu_co_sleep yields and there is no race
> -     * between timer_mod and qemu_co_sleep.
> +     * A wake racing with the arming of the sleep -- including the timer
> +     * we just armed firing in another AioContext before qemu_co_sleep()
> +     * publishes itself -- is captured by the sticky PENDING state in
> +     * qemu_co_sleep_wake() and consumed here without yielding.
>        */
>       qemu_co_sleep(w);
>       timer_del(&ts);


