Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED85E9DE60
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkpP-0003Za-7o; Thu, 09 Apr 2026 04:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAkpI-0003UV-3S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 04:33:25 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAkpF-0007Kn-7N
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 04:33:22 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so532230a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775723599; x=1776328399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hb0hyvG4NVMGqig9mXj4GVha4CGNBj8WZM/iYnW7vAE=;
 b=K02rSbuqhv7y4tlUKw5CbJ9gqPl9xrtB96O4un0YoPDMd5/gVeEwKfNvLyfP9ZTChZ
 BhkhAy3hY6ikNxV1gv5rF2jEZpYdBTtR0fu8pzjKywGi/lciJDi01Uz1TVfu8yE/3B6d
 sS2Dl31V5bFarL1mAZi6Ldv2CalsvPg8AsNIo7M0dK/tjYRWtF76fdoyxH/VnPa3G8FE
 qMaVPHvS/0r6osA2t3wZJmMuUK9Mo63Nae8jaaiGrK3za561WDCKGPraScJnP4yE14o5
 GVMlpevC5iDA9rRt0qKxo7UBOuzbEL9r1ZUVEoky9x7Sh1JzIcnmWA9PXoSFrxi4XqRg
 VQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775723599; x=1776328399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hb0hyvG4NVMGqig9mXj4GVha4CGNBj8WZM/iYnW7vAE=;
 b=O0a2QY6FvokMGz5t9+7OUMh/E6H0C6i7HoGgstZ3BUNu6wYQArBGXkp7Z1iWTw/7xn
 ZFrXBBKXF0TqlEipMyhqczwupvmQIY33hXaMKz1o4cOLmmJHRY0j58CCxGNTN/5Bm1Jq
 a+UkINJoO92bavHQLkxLU79rTrJxJo51EXFLrkqqqIYSEeh9Ik86pFSxK8YgnY0ZDUG+
 iaHPTYRN8S9A2zwj1CN9nueZO7r62DOEKcczNDpc7fUFCRU0UxVcgK+bTM5lIWsfi7Wt
 X5rGCR2A5fw34rBjYyrY1i3jspfQOoPKTZVnQFIzQFXr2WmFI8YK3OrMPKmNkern9qLI
 T6Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXumzqYSbBqk/8gqGe6/Rtrkq25Usy2aHAi5pSiXyst4ThzDR7c3xh0Itp9t3G4zm54FjnNywLbfnor@nongnu.org
X-Gm-Message-State: AOJu0Yw8GR4lAgKrJ3yAZZ152GjlqWFYdGwQ7K8kI70gbcYnrFe3iJpn
 YVcWHGYmNL0//cCQZi3cm0DaVDjeVZvaci900WYcwr63QaOC22erlGKt
X-Gm-Gg: AeBDieugXVhN/3hP8UfPqfCpbWpPLQ66YPjfSI9kBKogm1yjb1FHiViXgY9TqLKqdSf
 k4i7TVag+VlckpK8sw7O+3kYC1zpksLiKvvq717LPxeaSD6Ldkjw+6q5nG2JEAGOWITf8pba/j3
 inoxtAPZAX9U/gs+voxxoOWePHpfD1SSlEzj7p1E2Y/Sym8ACGE5eqs8+f8FunnIR5xNfGlDJYT
 apP1TWElUC9n2RPHWSl0HBRIjmCVmld6PTL487urkNwSvuD7ZW0LXlnnDeM5XWG/Gf37XSK8MNt
 Y0jGLnDbRx/DH45hnbBKc+cj5lZEQdl6Yoo7/PwoJGn5gJaYrUP8pZiuNCkGnMr/YulzBBZGQ7j
 KpuARQpyNzw+UfNO/Az0QeztIG+N53jAjPJt01qJ/8H/BDqsQGa7l/OGD0G+axerzqYN9YM6Vsn
 xZ+oRVKwZ4hD6gRh4hIXl2WsowOd9NRuL1U2YJfCLJKQ==
X-Received: by 2002:a17:90b:3fce:b0:359:8eaa:7f42 with SMTP id
 98e67ed59e1d1-35e35969d15mr2645072a91.18.1775723599088; 
 Thu, 09 Apr 2026 01:33:19 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e34fa9ecdsm2313212a91.4.2026.04.09.01.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 01:33:18 -0700 (PDT)
Message-ID: <b2b0c46e-d100-4aad-8611-01e82613541e@gmail.com>
Date: Thu, 9 Apr 2026 17:33:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/ufs: Add idle operation
Content-Language: ko
To: Jaemyung Lee <ldc.jml@gmail.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jaemyung Lee <jaemyung.lee@samsung.com>
References: <20260409-write_booster-v3-0-dd2f1c0119c8@samsung.com>
 <20260409-write_booster-v3-3-dd2f1c0119c8@samsung.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260409-write_booster-v3-3-dd2f1c0119c8@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 4/9/2026 2:37 PM, Jaemyung Lee wrote:
> When no I/O occurs, the UFS Device performs various internal operations.
> To emulate this, adds a timer that periodically checks the current I/O
> status of the device and call the ufs_process_idle() function when idle.
>
> Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
> ---
>   hw/ufs/ufs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/ufs/ufs.h |  2 ++
>   2 files changed, 65 insertions(+)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 69f82ab462d135fe6cda479891f9d8f26d19be9a..33887ac12a4bae647acb94b292f1d680bff9a007 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1801,6 +1801,63 @@ static void ufs_sendback_req(void *opaque)
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
> +    if (!u->params.mcq) {
> +        return true;
> +    }
> +
> +    for (int qid = 0; qid < ARRAY_SIZE(u->sq); qid++) {
> +        if (!ufs_mcq_sq_empty(u, qid) || !u->sq[qid]) {

This is still not correct.

Only actually created MCQ queues are non-NULL, so NULL entries must be 
skipped, not treated as non-idle.

Please change it like this:
if (!u->sq[qid]) {
     continue;
}
if (!ufs_mcq_sq_empty(u, qid)) {
     return false;
}


and:
if (!u->cq[qid]) {
     continue;
}
if (!ufs_mcq_cq_empty(u, qid)) {
     return false;
}
if (!QTAILQ_EMPTY(&u->cq[qid]->req_list)) {
     return false;
}


> +            return false;
> +        }
> +
> +        /* internal ongoing MCQ request check */
> +        UfsSq *sq = u->sq[qid];
> +        for (int i = 0; i < sq->size; i++) {
> +            if (sq->req[i].state != UFS_REQUEST_IDLE) {
> +                return false;
> +            }
> +        }
> +    }
> +
> +    for (int qid = 0; qid < ARRAY_SIZE(u->cq); qid++) {
> +        if (!ufs_mcq_cq_empty(u, qid) || !u->cq[qid]) {
> +            return false;
> +        }
> +
> +        if (!QTAILQ_EMPTY(&u->cq[qid]->req_list)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
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
> @@ -1863,6 +1920,7 @@ static void ufs_init_hc(UfsHc *u)
>       uint32_t cap = 0;
>       uint32_t mcqconfig = 0;
>       uint32_t mcqcap = 0;
> +    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
>   
>       u->reg_size = pow2ceil(ufs_reg_size(u));
>   
> @@ -1959,6 +2017,9 @@ static void ufs_init_hc(UfsHc *u)
>        * dynamically
>        */
>       u->temperature = UFS_TEMPERATURE;
> +
> +    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
> +    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
>   }
>   
>   static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1986,6 +2047,8 @@ static void ufs_exit(PCIDevice *pci_dev)
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

