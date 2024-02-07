Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B784C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoUE-0000Xe-Fh; Wed, 07 Feb 2024 15:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoUD-0000XV-9o
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:25:37 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoUB-0000Dq-BZ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:25:37 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d5c7443956so466199241.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337533; x=1707942333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vMTcL3JdRtRqDxjld2E54YKw2crKsOHAvTb1xGnDD4=;
 b=mKgqT1H6yiZpvapnyi+88UnOTT9FS3hLtpqd0Hxr/griZjIC4vPuHMeAN33i5y29XF
 mnG/GR3WC2EbuSHySdJUvNIJ4wzYbRKuAu+Aj9IOAPijs3BPK/8//xT5jPlt4KBiGQlx
 pAb5d6gKTAQYC5x1taBm9PJx0Sq7LiHz5BbqEXYkpDf7lnnfOhyKja0JSpdMhohHbDCO
 pz6Cj+sdr7A6raq76aY6ypInWuMvB0a1AXwOGISTNn2rPPN2LfNYbBx5p73vdrs8Ui0m
 1H6nzSCo6mdDYK1k9k1ZWLTcVUe4FYhW0vsbR9/5g3RhfIKbbPhG6xdq641zIRQibEii
 iOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337533; x=1707942333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vMTcL3JdRtRqDxjld2E54YKw2crKsOHAvTb1xGnDD4=;
 b=GvP4kt0xq+0bMwSGI9WhJ5+6PVt4/4Y3hwVSTtAVUDfam9f3PIn0PjWaYWXolYOFDh
 1of5IZOP3n/Z11eEu2Po55jHzr9iM2TAWICgJxPVm5tq9R54SvnRiHvKDSbXAG557uEY
 gBfa3GOzxJdTBL96dnbho3DtkzKSQX2HCOJENi7si1bRP7Uvs3Glmu9AuU38yc1260ZZ
 KfnLlySTqtiRv5F0O8DFqPnK7HvxhLi5ByMY1QdIxlxDeEUKOyQTe4Phut7KWnrLR0Xg
 jPE+IkyB04jUtddNKITHCJKsmpMNQSl2dRLV6qD4x3Q0NnIHbMrQQ4gp41BK9E+4Uo5U
 PaJA==
X-Gm-Message-State: AOJu0YyEzo+npL3KDkeAMMWGlyQPfT3HkEB44SNRFF2PPljrcnWZZK7d
 +3kiwQ8SzT+edLoj9D+6g283tLD1qdwUN9ppOAe4GjQCZrvcKowkAdW5gRBYMcU=
X-Google-Smtp-Source: AGHT+IEyVmuTZMHaAGDC6KUW1FiJvT0UgmV1ZuOTPwJYr7XHLl05VNPtkYb2pHeYgl9m90wCc2Gblw==
X-Received: by 2002:a05:6122:201d:b0:4c0:3d4e:774b with SMTP id
 l29-20020a056122201d00b004c03d4e774bmr4690903vkd.9.1707337533073; 
 Wed, 07 Feb 2024 12:25:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXMEdBza7Vq8GA+7ReMcFTcInTVLi2q1+lBeHzxVTDNXvIFahWXrlaMt1d9+oundI4t0qG/28wlT3+L/TzGLXvX63uUpCtYbO/xZQq1AgJxpsiM8XHF9X4LmwtIzvV6MT5LMDAiEcegVRVPcHtTJZ/Vjpk=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 kr4-20020a0562142b8400b0068cc67a4070sm80801qvb.94.2024.02.07.12.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:25:32 -0800 (PST)
Message-ID: <f124f1ae-fe06-461d-b8a2-acd5aa7e7447@linaro.org>
Date: Wed, 7 Feb 2024 21:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: Extend vfio_set_migration_error() with Error*
 argument
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-12-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-12-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=philmd@linaro.org; helo=mail-ua1-x929.google.com
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
> vfio_set_migration_error() sets the 'return' error on the migration
> stream if a migration is in progress. To improve error reporting, add
> a new Error* argument to also set the Error object on the migration
> stream.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 50 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 30 insertions(+), 20 deletions(-)


> -static void vfio_set_migration_error(int err)
> +static void vfio_set_migration_error(int ret, Error *err)

Maybe rename vfio_report_migration_error() for clarity?

>   {
>       MigrationState *ms = migrate_get_current();
>   
>       if (migration_is_setup_or_active(ms->state)) {
>           WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>               if (ms->to_dst_file) {
> -                qemu_file_set_error(ms->to_dst_file, err);
> +                qemu_file_set_error_obj(ms->to_dst_file, ret, err);
>               }
>           }
> +    } else {
> +        error_report_err(err);
>       }
>   }


