Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E0C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoKy-0002lZ-Bc; Wed, 07 Feb 2024 15:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoKs-0002kg-1s
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:15:58 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoKo-0006Qe-LW
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:15:56 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so142675266b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336951; x=1707941751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSl+FKhZWTsWIuS2+/5PcEKJbx1dYx0K0dOrMl3WDyY=;
 b=DNkbrTKhXs5qsMz2LRo4cIPvtF+IXncpePtolh3+PJoUjfTiyHSVAOMbKiu/lGXUej
 8E3XeVjaL+spjxmgki9Fu4eWNr+K69nCvFMCKeuQIdj0svkA1uP9FaIs4/4xLOa5Lz9C
 YLaMy+x/Qoyw9KqWg5i//B1v8VGEJsGBTyXqxNX1hTNV6LB973VbZSSDsskEOKY9BSri
 2VKCjP9TMd4+4UORUY8xtYxTqmfGIqUlWVXlSd3tzTla9eNWunTe+n1i0NFHecItmzq2
 HApbXpEoGY/b9TovUxVSEMZK6JCiZqe/+x0a+6hz5fStVO1+gq9mV/MxZHr1UrGHTx9B
 0ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336951; x=1707941751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSl+FKhZWTsWIuS2+/5PcEKJbx1dYx0K0dOrMl3WDyY=;
 b=czOtIG0ZThjPGJkPWiNqiLR6kJnIgVLMWCyKOKTSmch2gG+XPibZIMqZPdGH/IrP+3
 lYwyhL88vR5rNDnY3OtxeCoJrFHjO5Dzce2AXK/Jmuh5I2F/jy0g7uil19JORfAFrJ94
 /WbQgZc5GC4cYyCLprsFQTGx1S0PqfiPfSHsYr/tAaNoFP0RL1Ljk1IsWd21YvVhehos
 iT5ExqMSfle5E0FHevT/1uzWS7KnmNkvpX+iak4QULr0WnzG3KnydU8tzrGHLdQI7JL9
 RcCvZL3i0skS8lFb/khBl3tSHUQAxJR3+J5DKhna6XtqNC+iDA3dNs8/PrgnblsTjIGM
 bgDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnT9lI/n75T8EBmDWepl8dwp58GIu3/AZlVXsehX1QP0BSsHAiFmdsMscGVh7oGigYD0L/MYGlt70JQs7M7Uc1ojPcnYM=
X-Gm-Message-State: AOJu0Yy+V2y/RiGX059g7RPDjquQ3gz/RqdPA8Q5hjjorqeRqAwa4fEm
 hTWENNZ4R6JmnA8AkI4u5krQiI05tMiODlvDSxbOKlQ5N6vXeAWdZR08CS2StKQ=
X-Google-Smtp-Source: AGHT+IH9q8CoEKPOL9Xcn9Y4Tu142I2r+xwLquQ6Is0N3mO7sleJqGp6yQQ8HMfKGaMgt7wS+V2+NA==
X-Received: by 2002:a17:906:32c2:b0:a38:4fb5:571d with SMTP id
 k2-20020a17090632c200b00a384fb5571dmr3424365ejk.1.1707336951533; 
 Wed, 07 Feb 2024 12:15:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSSrbnnRayu5UaVEvp3CetnWlkV4QKR5ze/7lixHscPhtNN8DP+j16WUqtJJTllmKe283u1AxVsPHgLWyOnZVkju4eHiSchsViZ0+kcapjvjFpDXlzUeIAGjiY95gr3qmy2zrNCriA2CO2jl0xYhGXmpI=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 hw16-20020a170907a0d000b00a36f28baa8dsm1108764ejc.111.2024.02.07.12.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:15:51 -0800 (PST)
Message-ID: <357afa82-3cfa-41a7-8b6f-de96d236ad5a@linaro.org>
Date: Wed, 7 Feb 2024 21:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration: Modify ram_init_bitmaps() to report
 dirty tracking errors
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-5-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> The .save_setup() handler has now an Error** argument that we can use
> to propagate errors reported by the .log_global_start() handler. Do
> that for the RAM. qemu_savevm_state_setup() will store the error under
> the migration stream for later detection in the migration sequence.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   migration/ram.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)


> -static void ram_init_bitmaps(RAMState *rs)
> +static void ram_init_bitmaps(RAMState *rs, Error **errp)

Please return a boolean.

>   {
> -    Error *local_err = NULL;
> -
>       qemu_mutex_lock_ramlist();
>   
>       WITH_RCU_READ_LOCK_GUARD() {
>           ram_list_init_bitmaps();
>           /* We don't use dirty log with background snapshots */
>           if (!migrate_background_snapshot()) {
> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
> -            if (local_err) {
> -                error_report_err(local_err);
> +            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
> +            if (*errp) {
> +                break;
>               }
>               migration_bitmap_sync_precopy(rs, false);
>           }
> @@ -2828,7 +2826,7 @@ static void ram_init_bitmaps(RAMState *rs)
>       migration_bitmap_clear_discarded_pages(rs);
>   }


