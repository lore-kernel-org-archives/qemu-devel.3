Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B1CC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoQ8-0006UQ-D1; Wed, 07 Feb 2024 15:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoQ7-0006UC-A2
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:21:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoQ5-0007lU-N1
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:21:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fe59b22dbso8634455e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337280; x=1707942080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJ5dgu4WrAaDtc47nTjMGY68SuWzyo4SfW/8fwQSQUA=;
 b=Kc2OoKH4+kYrCUyBag9QswSyQKxIskdfbg9frRlq2s5QZFYvONzzkvKEp6miJYB9QQ
 SVVaGlt0kwu3lkpYiF/M0Bmyz7hzscoSH0Yx0a+q0yJn0winTScDZxR32Y36xlX3LtfL
 Pa/btGfe4BUsMZSZlN5u4ITGJKWzAygF0L2Lxqk01NESP3Hfgkl6KI4Nx1xiPJA9EQX0
 QX+D2vt+vkGC59aml5zVG+y0o95BuGt5L+gfNiuIbayTNeDkjM7qM5EQUiEuuFJJGxWX
 fCDF0GIQ8W1m+hyNdGx9+0E9RfKzmZyghuGcaKv9+FtMP4bzYZJpe4XieAeZYXy04/0w
 OMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337280; x=1707942080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ5dgu4WrAaDtc47nTjMGY68SuWzyo4SfW/8fwQSQUA=;
 b=Pjr3YB85GixJjZAjSsqVf1kw8gx/FVwl2X1kU3uSIDjw6RPRov0FloO8qrvUM4Fpy4
 HphOULEXH2Ao174LXjmUNR/ze9qCkPuHARXWno3F2SXaVw03UKLHZkLUVKJTawKQFbBb
 10O3JLtBVoJO1Ley+8WqEH8JBh0fLCWyXj3QPlyeUNoyw8AATN+Nfdvo0BcZ0YNGQO6P
 C7pWifRsw+DNy10S62vUgoSpQeaMSSOvjetU4Jhw1xq+VLHB/u5QiS+vKahBdiIp9/ll
 9gWSWA4eJ/w3yb9JjHFa0QuFzaiJdUqn2oeN83vYLr8AUuGwLyMt5bq8tmUEkyk1oQh2
 E4Gw==
X-Gm-Message-State: AOJu0YygpN4mYx57AAokgmAmsMSKP8JuIlwvAaKgCUTXJUqrtTHNVfqM
 Cniwr+likgTxl2T4Rzw2G3T8IhiFQt7BM+DS7/hJtLj8/7dDW72a3VlELdd8b2A=
X-Google-Smtp-Source: AGHT+IFe5EC5SIgHZXEnFial3xcwCvbpJroSwytp7abMNLo/v633GzJrEfHsBLXzFmTtvLXcfiJhyA==
X-Received: by 2002:a5d:55c8:0:b0:33a:ff67:74b with SMTP id
 i8-20020a5d55c8000000b0033aff67074bmr4099847wrw.30.1707337275256; 
 Wed, 07 Feb 2024 12:21:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhdNnmcMZQ5sVmvXDLtUKUyVZWkqvnO2JnEX7KJK13IT3TEpXc7+y1Rpg55VTiUMx1H8juEN9KKAt1tALIKd+vHeEIbCZOz3vUoLS0Kr7MXf9WQgUy2AiwNrkZR6ZDlZE++UsIlaffoCP2/wHwZnJjAG5xsOtLrabyZPLxhcsousFirN6U
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c4f4400b0041007731a52sm3104298wmq.11.2024.02.07.12.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:21:14 -0800 (PST)
Message-ID: <56760355-3432-4fcd-a134-3f4467e35f6f@linaro.org>
Date: Wed, 7 Feb 2024 21:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: Use new Error** argument in vfio_save_setup()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-9-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
> Add an Error** argument to vfio_migration_set_state() and adjust
> callers, including vfio_save_setup(). The error will be propagated up
> to qemu_savevm_state_setup() where the save_setup() handler is
> executed.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration.c | 62 +++++++++++++++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 22 deletions(-)


> @@ -429,13 +431,18 @@ static void vfio_save_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> +    Error *local_err = NULL;
>   
>       /*
>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>        * after migration has completed, so it won't increase downtime.
>        */
>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
> +        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP,
> +                                          &local_err);
> +        if (local_err) {

Please check callee return value instead.

> +            error_report_err(local_err);
> +        }
>       }
>   
>       g_free(migration->data_buffer);
> @@ -541,11 +548,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       ssize_t data_size;
>       int ret;
> +    Error *local_err = NULL;
>   
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> -    if (ret) {
> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
> +    if (local_err) {

Ditto.

> +        error_report_err(local_err);
>           return ret;
>       }


> @@ -760,6 +773,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                               migration_state);
>       VFIODevice *vbasedev = migration->vbasedev;
> +    Error *local_err = NULL;
>   
>       trace_vfio_migration_state_notifier(vbasedev->name,
>                                           MigrationStatus_str(s->state));
> @@ -768,7 +782,11 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       case MIGRATION_STATUS_CANCELLING:
>       case MIGRATION_STATUS_CANCELLED:
>       case MIGRATION_STATUS_FAILED:
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING,
> +                                          &local_err);
> +        if (local_err) {

Ditto.

> +            error_report_err(local_err);
> +        }
>       }
>   }
>   


