Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F42C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jbg-0005Kw-9J; Tue, 30 Apr 2024 05:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jbP-0005IM-Te
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:16:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jbD-0000as-3v
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:16:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a56d7d457a1so652449966b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714468588; x=1715073388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wFTewPJ37hrsDAQIHtI1vHhjGCq1FznsllVMtrQZAK8=;
 b=fPHRV8ga0gQ7DNdZ+lUq6Uk/NojNr7mXwbwVENemuTO6id7dn2R3gq/QPP43vMthJj
 CKJp+C4bAmRcibQ5DWKaCKZTkO9Gyu7Gb6HiATgPU684e0ERNmJEo6TRFXEflXCO6gJT
 a03J5dXlrKF5HudTHzOjNREkaW3wVXx3DyYzrWO9TNUW8jj44A6MH0l7SpbnX0xmJYly
 HIo/Lq6MO9RXWGZ+a8bnvUaRQZKbF83Q1P9znB22n5/CS92vQGbNAJc3+64n2ciunseb
 7o8NcPq1Z2CdzMHphDE/5SrqY6+760a3LA9cNFctEDn7iAtQxvCa4FIjPOje/r6Rbtw9
 Fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714468588; x=1715073388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFTewPJ37hrsDAQIHtI1vHhjGCq1FznsllVMtrQZAK8=;
 b=l/XLocRZewa5HljtXaTpXfZNR2LG6DJUy3nfnj/O/QHqLvnFWFJQpXxeB4qq+xPJt7
 qENBRYRZrwTFAMFz6C1oeb5WVTXWBg7g0oMAxiYQU7a4SltjZaCtXnRNVmCg883SzpBg
 dUpv+CRxIzBl7WLtOXsmJrAmacLPiFYq9j1DGZ7b5k/Sd7DCXTILbxek55SNxgMknAnH
 2IFVNjYywIN9JLANeyHFIA3WYIn9e0Bh9IOJ7DX2tpZlzvTt1aKRDakF7ryFcmqh3mig
 +mpUize4bOssI2bgvbnkchwTIWx5ST9lQmh4J5V+x8vortnbuRCAqgzNXOrvthd2HH/3
 M/6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfJT8kRbF++flMhGmNvYnyICf+ZgjOepf70hj+uguPolj4HsmiZa7RVBhxKPk/hJPXJM6gfC7tL6Pu1/54CZchgRBl8OY=
X-Gm-Message-State: AOJu0YzjE/INBarERYWH6dRe52sfL69DpblscQUHsX207RNueFP8lhfF
 QLeq5HjrnEZ4rpky7KiNS7ky3YvUrPeZFkvFexImxwcml9ewrV/Js8r2ccSMAcI=
X-Google-Smtp-Source: AGHT+IHQeFWuc+/p91bSptqrFkRxI8yYb9USiQdh9wDOVXpGFdYKWMt6yBick2dPF4toQX/7XGLnfA==
X-Received: by 2002:a17:906:3597:b0:a52:387b:8391 with SMTP id
 o23-20020a170906359700b00a52387b8391mr7386178ejb.34.1714468588295; 
 Tue, 30 Apr 2024 02:16:28 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 bt15-20020a170906b14f00b00a51eed4f0d7sm14903968ejb.130.2024.04.30.02.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:16:27 -0700 (PDT)
Message-ID: <e318d8dd-64de-4d22-a11f-76e8c2678c88@linaro.org>
Date: Tue, 30 Apr 2024 11:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] migration: process_incoming_migration_co(): rework
 error reporting
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com, farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
 <20240430085646.2359711-5-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430085646.2359711-5-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/4/24 10:56, Vladimir Sementsov-Ogievskiy wrote:
> Unify error reporting in the function. This simplifies the following
> commit, which will not-exit-on-error behavior variant to the function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   migration/migration.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b307a4bc59..a9599838e6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -735,14 +735,16 @@ static void process_incoming_migration_bh(void *opaque)
>   static void coroutine_fn
>   process_incoming_migration_co(void *opaque)
>   {
> +    MigrationState *s = migrate_get_current();

(see below)

>       MigrationIncomingState *mis = migration_incoming_get_current();
>       PostcopyState ps;
>       int ret;
> +    Error *local_err = NULL;
>   
>       assert(mis->from_src_file);
>   
>       if (compress_threads_load_setup(mis->from_src_file)) {
> -        error_report("Failed to setup decompress threads");
> +        error_setg(&local_err, "Failed to setup decompress threads");
>           goto fail;
>       }
>   
> @@ -779,19 +781,12 @@ process_incoming_migration_co(void *opaque)
>       }
>   
>       if (ret < 0) {
> -        MigrationState *s = migrate_get_current();
> -
> -        if (migrate_has_error(s)) {
> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -                error_report_err(s->error);
> -                s->error = NULL;
> -            }
> -        }
> -        error_report("load of migration failed: %s", strerror(-ret));
> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>           goto fail;
>       }
>   
>       if (colo_incoming_co() < 0) {
> +        error_setg(&local_err, "colo incoming failed");
>           goto fail;
>       }
>   
> @@ -800,8 +795,16 @@ process_incoming_migration_co(void *opaque)
>   fail:

Maybe just assign @s in error path here?

        s = migrate_get_current();

>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                         MIGRATION_STATUS_FAILED);
> +    migrate_set_error(s, local_err);
> +    error_free(local_err);
> +
>       migration_incoming_state_destroy();
>   
> +    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +        error_report_err(s->error);
> +        s->error = NULL;
> +    }
> +
>       exit(EXIT_FAILURE);
>   }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


