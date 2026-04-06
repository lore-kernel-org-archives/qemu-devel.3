Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F291EF4EC2
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9hj4-0001eR-SB; Mon, 06 Apr 2026 07:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1w9hj2-0001dq-BM
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:02:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1w9hj0-0002xV-2r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:02:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82cf96ca071so1605552b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775473350; x=1776078150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDFBY45wz9aNsN4wYuF4xOUE4+j3yCaPyyua9ld7Thc=;
 b=ZjwAiuqMAsu10MfcS7wMAHlAwKI736Qayd4Tds8qcbZZIs/4/JZtoIFVhDWNaaHAVn
 1o4kGITzqZRPMsPGDI/LFQErOmZAVmgLEhUdFRfKH4m7VYKN8FuBrDY9M4/i+M1Kwy7v
 JFfHz81LZOPpF7CjOkqQahzp4tztNHF+53hnXpIGUTUfn8IIhEf6cAqUyLmATE4vnD2Q
 uDYcoDxyd6t8LSA3r3bo7YQh5MT2UOhO+eRrHwXht16IuItnBblluiK+KoSwkclkJYF4
 tKGnWjEM//N/dG5rAIH4s9M+OiiZ0NrBBPsXycNolj7jlfptck1KGNOaMGqZcj+Pots8
 D/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775473350; x=1776078150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDFBY45wz9aNsN4wYuF4xOUE4+j3yCaPyyua9ld7Thc=;
 b=JVgIaTHs2qS5FebJI3VM0x31TFIn0z9m+DFyUjwYR/i9PqiSEbDGK/OPEUxGbmkJwP
 qyQagjPL4CkmSwzZPvrIHvPR3m3kPIbIP5d1otD9VkCgLP5lbVITADtknmNTjSE6lKG9
 mZL7Wi9ynSDtxujm2GlF7kYVRZ6aXDfMtRL9lojovJNI/BrCyRN/c7R++D/NdPXSE6Jc
 aKIqCzU+vJETayh9iML92NWogSfuD3XfU6MggR3NjW0zcfs7Hwfu2LntYaorW9d4GeWJ
 6cVxN8qMEl5IqCIHr5zmWNYIzZdwR1B/GrYTGKucpEaPUMSjqwdnxqcAuY/jsSzcf45x
 UPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqUlIe78lWv31lP8sZqkglGEicrlws4PTZJm8zyLLTt0XAX77drBDi4OPZ3xoVXvdRbpEh/QB7A9OX@nongnu.org
X-Gm-Message-State: AOJu0YyGiPrGYyHpcZCe9UNX5ErhCyKxFDuWwXLAAXPDpZyGbl8gK85W
 61dWUx5aA9UADDi90HHd4BieB0tfaqprWUO0EFjWs9AnRjM5GYG1RSnX
X-Gm-Gg: AeBDieudzRvhSAnxpFzIBrEnK6HgYbv49R3p2JR9yoDvlS6dooD39Rw1dnEU74z5M8l
 57v95NgsYjElD8EU99cTJxnyTL5jkTzxizRJJqs5RqZ6oBS02FTkjtv5h8DwJacpP2b2WlNl5FQ
 gHzBeeytK4rjrkzApZJ/CRUU8Ve8gUP3kj8cRy4lx30vdSOXrhtpaxoU26g1LgtsQZMmmrsf245
 FqIJmxbb5sw8ya/YtKRI1L6giU8aA/iRs6LzGB8eVWSywOqxahEcBP1rffx60J94J8wV/izphZb
 WtBLxNIU1sZuwg5TYBpgcqTgFCCQUereDoe9G5AcKkDd3fqNOLqq1DjykWP5p+hs8adqQQaXn3y
 Dfwfe0zIehBvC1gqLKAGn30NDKz69yHr6hVNolTpAIrHnKYjz4YjSO4onAyp/fZb770VOVjZM/h
 k1TPNhrxD5O1zWwy/iq+uAD4/1OlOPKvJ9bFpmwEiGhm5JC9PUhz3X
X-Received: by 2002:a05:6a00:13a3:b0:82c:d9d0:f482 with SMTP id
 d2e1a72fcca58-82d0dbb6b25mr11481076b3a.46.1775473350256; 
 Mon, 06 Apr 2026 04:02:30 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c6b80dsm16735634b3a.42.2026.04.06.04.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 04:02:28 -0700 (PDT)
Message-ID: <262bd67a-194b-407e-8727-ddb491b4996f@gmail.com>
Date: Mon, 6 Apr 2026 20:02:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/ufs: Add idle operation
Content-Language: ko
To: Jaemyung Lee <ldc.jml@gmail.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jaemyung Lee <jaemyung.lee@samsung.com>
References: <20260402-write_booster-v1-0-e4fed1df6c7e@samsung.com>
 <20260402-write_booster-v1-3-e4fed1df6c7e@samsung.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260402-write_booster-v1-3-e4fed1df6c7e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/2/2026 6:43 PM, Jaemyung Lee wrote:
> When no I/O occurs, the UFS Device performs various internal operations.
> To emulate this, adds a timer that periodically checks the current I/O
> status of the device and call the ufs_process_idle() function when idle.
>
> Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
> ---
>   hw/ufs/ufs.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   hw/ufs/ufs.h |  2 ++
>   2 files changed, 49 insertions(+)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 69f82ab462d135fe6cda479891f9d8f26d19be9a..111ce3c3a0b03a1ead722f48b799e3ed0c403cce 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1801,6 +1801,47 @@ static void ufs_sendback_req(void *opaque)
>       ufs_irq_check(u);
>   }
>   
> +static void ufs_process_idle(UfsHc *u)
> +{
> +    /* Currently do nothing */
> +    return;
> +}
> +
> +static inline bool ufs_check_idle(UfsHc *u)
> +{
> +    return !u->reg.utrldbr;
> +}
> +
> +static inline bool ufs_mcq_check_idle(UfsHc *u)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
> +        if (!ufs_mcq_sq_empty(u, i)) {
> +            return false;
> +        }
> +    }
> +
> +    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
> +        if (!ufs_mcq_cq_empty(u, i)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}

I think the idle check needs to consider the internal MCQ request state 
as well, not just the guest-visible SQ/CQ state.

In MCQ, a request goes through
SQ free list -> RUNNING -> COMPLETE -> CQ pending list -> guest CQ 
write-back -> free list again.

So a request can already be dequeued from SQ and still be 
UFS_REQUEST_RUNNING, or it can already be completed and still be pending 
CQ write-back.

The idle check should also cover active internal requests and pending CQ 
completions, not just SQ/CQ head/tail visibility.



> +
> +#define UFS_IDLE_TIMER_TICK 100 /* 0.1s */
> +static void ufs_idle_timer_cb(void *opaque)
> +{
> +    UfsHc *u = opaque;
> +    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
> +
> +    if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
> +        ufs_process_idle(u);
> +    }
> +
> +    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
> +}
> +
>   static bool ufs_check_constraints(UfsHc *u, Error **errp)
>   {
>       if (u->params.nutrs > UFS_MAX_NUTRS) {
> @@ -1863,6 +1904,7 @@ static void ufs_init_hc(UfsHc *u)
>       uint32_t cap = 0;
>       uint32_t mcqconfig = 0;
>       uint32_t mcqcap = 0;
> +    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
>   
>       u->reg_size = pow2ceil(ufs_reg_size(u));
>   
> @@ -1959,6 +2001,9 @@ static void ufs_init_hc(UfsHc *u)
>        * dynamically
>        */
>       u->temperature = UFS_TEMPERATURE;
> +
> +    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
> +    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
>   }
>   
>   static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1986,6 +2031,8 @@ static void ufs_exit(PCIDevice *pci_dev)
>   {
>       UfsHc *u = UFS(pci_dev);
>   
> +    timer_del(&u->idle_timer);
> +
>       qemu_free_irq(u->irq);
>   
>       qemu_bh_delete(u->doorbell_bh);
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index 13d964c5ae5ec430a98b2ef71987cb9279e9a317..b5f040302129f4d02732ddd20ef82eb33c41922a 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -148,6 +148,8 @@ typedef struct UfsHc {
>       UfsCq *cq[UFS_MAX_MCQ_QNUM];
>   
>       uint8_t temperature;
> +
> +    QEMUTimer idle_timer;
>   } UfsHc;
>   
>   static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
>

