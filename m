Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B855C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvi6-0004dZ-1S; Thu, 25 Jul 2024 06:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvi3-0004Xm-88
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:28:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvi1-0002f2-9I
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:28:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so810071a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721903307; x=1722508107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=39BdGgQvW1nrJkp9JpXA3vNxh75VvIwLEnEQZbhSUkg=;
 b=FXrw7zl6BJitVth1HlhqOyJ6RlwKFE7tFhcLKL3tyW95fzkvAnDC9/S3jsQ4jpN4tV
 Kk2QDeCBh+xvS3b7WGWom7AxxuBYXgtAuff1HfFLqlvmPu69cjGxenrCK3J9Z3RvYq/5
 yaTRKMPWsi60NizGFIgohF5bZQWOuVdM3b/UTzCCACMWYLX7l7t5kOIm9Ebio+DpCsTu
 mi6YrRK9thcPL8dcXhrV9CLwi51zbOQu+RLvDawNvjkOkRyM+KHtVzbSkMqtUZa8e6f1
 Hnlg7aH6dWD44TRfunbKH+G33SzFqXWJs1mYGT/rJGpB3zQNOfkXj5texnyYfnaiCrpd
 y/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721903307; x=1722508107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39BdGgQvW1nrJkp9JpXA3vNxh75VvIwLEnEQZbhSUkg=;
 b=lzu+66P/eiFXR4IbyVJ11TqP8xTnX/qwqV+TvBeG36oGjLmmhebhXApgD6p/AoweuY
 sND91vZbQ2h+EtPyq04xqXuW/jG8gcLi8iAnafUtLYXpU+3LZahK5idalDWjIRPqyTIN
 soTRjMShiMUQMMHzB0THD/5LvaloSk2Ea271aASpL5HmDsxBv0cBAv2Tb5qgyHxO9CWV
 K2OhRKAPLvuDfCIrP0hoI68s+hCbJpznqCLnftgtkHkS9W+MRmMlWEicvmQpazwSZQ71
 QM8Fw4D1W6ZSq1sSBkBJKwG0nlXXl/ikkICzBeiU6JUWyihUk3QFVT04KYdPl1tFA3Gg
 4zBQ==
X-Gm-Message-State: AOJu0YymIMj+aQ3diq4jl7Aiocyh73+GpYZbJ18jVisEbQkMhWFMCugC
 KJEZ5bS+W2tCdPW8td9KlYD7p3X66E46bKzEqSIHXXpj4O1s0CKrrAG0FKobNdEkiBkGW6yILhP
 Dh/yNJ3rs8pru4wo/WAmrxq0rw9iN7kdAesINtw==
X-Google-Smtp-Source: AGHT+IHmSYjavNliss0dOU+rpbNvg3Mygu5anbwo5vHgADGeL0GgExVJuJ8soqGJ/V6Z2NxQR/c9amMJQ6XFuyGKYXk=
X-Received: by 2002:a05:6402:40cf:b0:5a0:e4a6:b3c9 with SMTP id
 4fb4d7f45d1cf-5ac631af1admr1271337a12.7.1721903307468; Thu, 25 Jul 2024
 03:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-4-pbonzini@redhat.com>
In-Reply-To: <20240723141529.551737-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 11:28:16 +0100
Message-ID: <CAFEAcA-+BmDLzsjwBdJLHpRobxwUEZhW2M90qYReFkKQdu32Bw@mail.gmail.com>
Subject: Re: [PULL 03/11] tools: build qemu-vmsr-helper
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony Harivel <aharivel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 23 Jul 2024 at 15:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Anthony Harivel <aharivel@redhat.com>
>
> Introduce a privileged helper to access RAPL MSR.

Hi; Coverity points out an issue with this commit
(CID 1558555):


> +static void coroutine_fn vh_co_entry(void *opaque)
> +{
> +    VMSRHelperClient *client = opaque;
> +    Error *local_err = NULL;
> +    unsigned int peer_pid;
> +    uint32_t request[3];
> +    uint64_t vmsr;
> +    int r;
> +
> +    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
> +                             false, NULL);
> +
> +    qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
> +
> +    /*
> +     * Check peer credentials
> +     */
> +    r = qio_channel_get_peerpid(QIO_CHANNEL(client->ioc),
> +                                &peer_pid,
> +                                &local_err);
> +    if (r < 0) {
> +        error_report_err(local_err);
> +        goto out;

Here we have a check for r < 0 that forces an early exit...

> +    }
> +
> +    while (r < 0) {

...but then immediately we do a while (r < 0). r cannot be < 0
here because we just checked that, so this while loop will
never execute and the whole loop body is dead code.

What was the intention here ?


> +        /*
> +         * Read the requested MSR
> +         * Only RAPL MSR in rapl-msr-index.h is allowed
> +         */
> +        r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
> +                                (char *) &request, sizeof(request), &local_err);
> +        if (r < 0) {
> +            error_report_err(local_err);
> +            break;
> +        }
> +
> +        if (!is_msr_allowed(request[0])) {
> +            error_report("Requested unallowed msr: %d", request[0]);
> +            break;
> +        }
> +
> +        vmsr = vmsr_read_msr(request[0], request[1]);
> +
> +        if (!is_tid_present(peer_pid, request[2])) {
> +            error_report("Requested TID not in peer PID: %d %d",
> +                peer_pid, request[2]);
> +            vmsr = 0;
> +        }
> +
> +        r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
> +                                  (char *) &vmsr,
> +                                  sizeof(vmsr),
> +                                  &local_err);
> +        if (r < 0) {
> +            error_report_err(local_err);
> +            break;
> +        }
> +    }
> +out:
> +    object_unref(OBJECT(client->ioc));
> +    g_free(client);
> +}

thanks
-- PMM

