Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C48C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6o6-0002oz-QB; Thu, 08 Feb 2024 10:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY6o5-0002or-CJ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:59:21 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY6o3-0007hl-Oy
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:59:21 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5101cd91017so2324616e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707407958; x=1708012758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/M75lOqiJ9a3YyUMUldO2QWmCKnALPKdli8qHpTA1A=;
 b=E+Pob1gAPNRJObO/NBNwft859+qJvQ1Tuv5mGuEWrPro9xu1cXPlm0XpChf0YlXRUk
 n8iHSZ8I0klneELSR9OD5yFtTPkbI1kdZVsdVZ41yZgqNNZWw7zY6DMXXbIvwdWDysvM
 1egFM8UPKTddQysuOu9etQaV+j2k1k22TdBffMczOxJ3VFO8NYLA3ZG8HvxULHsN2GLX
 Zw6c6bt1pPyXTLc/qp0c4Ozqwj8gnJ7g0Jv9dpelePnqD8PExDzsDDMF/qVXwqsBx0LX
 VOoYLXqkWdaGZjZgKVflR2bnyxcXmNnnzzWK/yaiwJDhljhM5/64L6rlVWPXHIvlDsXR
 qZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707407958; x=1708012758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/M75lOqiJ9a3YyUMUldO2QWmCKnALPKdli8qHpTA1A=;
 b=ttK3PrzCv+FxDbNFXwZt47eebI7UtsAwrCz5icDfbbYGZUMK+KM5EsQdkNe5cQMlD5
 iF7STQSLLalBkNaz8ujGKAQd1IaNt5gO+7fi72pYJQhIrq0K86iW+hAM8BwmO8EmGIdd
 5SpnPOVLDO9n65E2YrZoB7xkX1ymHylNxyW8OybPeRL/V3gu+vhPIR3jZyJP2EdHdBt4
 74Sx4Wkm1Qm8/aUFUz2UHlV0XarJyLuXpOl3dJUDz/bR/1YIupx/0RvcOiNezTNjycW0
 GM7eUE513v4GKB4EfTSxshTssM+Khku/PjEj++pZb2ne1sjcR6ByESqWFxZCRWXcE4uh
 od1Q==
X-Gm-Message-State: AOJu0YwFoo5rXL6NPnB6FKFW9Cq1/7x8+wRm/jMcAoSxB938slTijJvS
 F9drRgC/Jz1qlAru0n86234z4lmVOoX0ypoWh4i47iOFnVLbZuZvz9W5yPEc6lU=
X-Google-Smtp-Source: AGHT+IE7XzAUrDAQozuNfx8Pb4ng94jB85YEN1K3ieJWKISS28R8KzSQfGMNYhfLIMFVmwgh7ApxSw==
X-Received: by 2002:a05:6512:33cc:b0:511:5724:dcd1 with SMTP id
 d12-20020a05651233cc00b005115724dcd1mr8187405lfg.11.1707407957853; 
 Thu, 08 Feb 2024 07:59:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXT/pVryqLplcJolOvNCsESFuACOhQGMMCsPHaW6jnfeXTRvNSpcxFcNhY4AkQt8bDbRwtYws3u+sp5PiecFj/VbAXw+0YUTT4vExY4Y0pvyiLaa849O7l+OVxGp+Op3TYaG66hgUnFpxBtqqpJYreJkXBrTmV2WqwKduyrMQ7jTytjygLQ/ELWHjsm1ntMRaqTPwyDQG6oFRcqALEYhWKON4LuXKymZl13yMj9yZ3uPX3pujCR86LrFxZYEalfiRv/k4zU94im46oZyz6teHT/95J3ZqsteK4ycN3kZeUKyj7lZcU9mkz8Rn/ZmDTEFbfsxJC3EguoYnmjuMkL
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 bw11-20020a0560001f8b00b0033b541e987csm2139736wrb.33.2024.02.08.07.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 07:59:17 -0800 (PST)
Message-ID: <776de49d-1885-4d23-89b5-99e701d42417@linaro.org>
Date: Thu, 8 Feb 2024 16:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] memory: Add Error** argument to .log_global*()
 handlers
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-4-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 7/2/24 14:33, Cédric Le Goater wrote:
> Modify memory_global_dirty_log_start() and memory_global_dirty_log_stop()
> to also take an Error** parameter and report the error in the callers.
> Aside from error reporting, there should be no functional changes.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/exec/memory.h | 12 ++++++++----
>   hw/i386/xen/xen-hvm.c |  8 ++++----
>   hw/vfio/common.c      |  6 ++++--
>   hw/virtio/vhost.c     |  4 ++--
>   migration/dirtyrate.c | 24 ++++++++++++++++++++----
>   migration/ram.c       | 27 +++++++++++++++++++++++----
>   system/memory.c       | 37 +++++++++++++++++++++++++------------
>   7 files changed, 86 insertions(+), 32 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 177be23db709d8bab9cebfe6acbae57611073327..b348070dc8f17b3505196d3a92d8cfb2171b640f 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -998,8 +998,9 @@ struct MemoryListener {
>        * active at that time.
>        *
>        * @listener: The #MemoryListener.
> +     * @errp: pointer to Error*, to store an error if it happens.
>        */
> -    void (*log_global_start)(MemoryListener *listener);
> +    void (*log_global_start)(MemoryListener *listener, Error **errp);

As documented in error.h, functions taking an Error** handle
as last argument should return a boolean indicating failure...

(multiple occurrences)

> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d2e85746fb7b10eb7f149976970f9a92125af8a..443acab7a7efbd6e9c94883363e1a827a3538292 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -90,13 +90,19 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
>   
>   void global_dirty_log_change(unsigned int flag, bool start)
>   {
> +    Error *local_err = NULL;
> +
>       bql_lock();
>       if (start) {
> -        memory_global_dirty_log_start(flag);
> +        memory_global_dirty_log_start(flag, &local_err);
>       } else {
> -        memory_global_dirty_log_stop(flag);
> +        memory_global_dirty_log_stop(flag, &local_err);
>       }
>       bql_unlock();
> +
> +    if (local_err) {

... that way we don't have to check the pointer.

> +        error_report_err(local_err);
> +    }
>   }

