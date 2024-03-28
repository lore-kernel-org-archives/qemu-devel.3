Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A24BC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprIx-0004hF-6r; Thu, 28 Mar 2024 11:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rprIl-0004eB-0P
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rprIh-0000v7-2i
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkTxu8WLRukFBVnw6I9e9SS6TT60ybYmMFqebNomrVc=;
 b=UMin2+BHBgAHPjSUdlkLuCOmKrb6eSZ6iiOohOMU9Rz7hD9VAn6gxqA4IfgT7VB9O5mUwn
 df6ALbS2+CMtkymPLNHVz9K6vUFkz8w5v3Mgve9YAirnXMfvsZMA8Q3oifBfKHk48qKBhj
 d/adScceUmjE9qPGXG88Ap/bTgEmsPc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10--iN-ePktPKCoNTrWveu3hw-1; Thu, 28 Mar 2024 11:04:14 -0400
X-MC-Unique: -iN-ePktPKCoNTrWveu3hw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d48e62e525so8163651fa.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638251; x=1712243051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkTxu8WLRukFBVnw6I9e9SS6TT60ybYmMFqebNomrVc=;
 b=q7QIwufg1IXAkmiKZHvphS42F7LYJy9DNHnCfnm7cjgA/ULX01jp5F0uba0OhVpfCo
 p3d78er9SS5NfYTott1h06znLJAfRYfISeR3KxeD3hNiIxWboNfPDsaGzvFCZ1jft3GG
 0gRbp1RANuXKmZuKPbdR22Mf4jyjhluHqmgvlJJs1leN6K1yOdH1slTcDU4CCAi8WuFO
 hX2RKI9VOkrmNKx8+IL2h4F58MPql6Iu8lry72v0kBhAL+xujnfDnPOun7d2EKFCSUEG
 CbxQaEahXxhEO/jqFZv6xU4GijBUD/PW2zafH1B4Xjt58xTZ7d+ppAD271eCC4hLYGxM
 efAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRIBIQ+N86ytvLvmmGAgSJn/pJbvNtNWzSClSYOrmHhq8FIqsW9oCImA1IBCRIMcdaBSzoCCV0S9qtQ5hQJADC3VJ6HfI=
X-Gm-Message-State: AOJu0YyjbJrflATdfmmeIEPqCZRyxTSD6VQckMU30rXV6DExAYQPebhA
 0vS+uY6gO3UaUxP36BtHttz7r6I8HwCpRdMeYSCUIlcsDnboej/OWb9xxVH2SVcx4pcPIInqFQS
 +/F02mXgOB/wkD+mGnznN395OD1oo111quDT5UZsWex4nZR1uaAzhdo/GMLYd
X-Received: by 2002:a2e:7411:0:b0:2d6:af80:bc7c with SMTP id
 p17-20020a2e7411000000b002d6af80bc7cmr2179694ljc.7.1711638251157; 
 Thu, 28 Mar 2024 08:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE64eAiXEXuCdvu5krT2MU1J/Q6oIlPhurvqASsySEgIXTbBxoAuGQ8+dtmxrDhFQTBDiqcVw==
X-Received: by 2002:a2e:7411:0:b0:2d6:af80:bc7c with SMTP id
 p17-20020a2e7411000000b002d6af80bc7cmr2179665ljc.7.1711638250684; 
 Thu, 28 Mar 2024 08:04:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a05600c4e4a00b00414112a6159sm2566611wmq.44.2024.03.28.08.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 08:04:10 -0700 (PDT)
Message-ID: <88d0bdcb-6a98-4419-96f8-c8eb47949c2e@redhat.com>
Date: Thu, 28 Mar 2024 16:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 2/2] migration/postcopy: Ensure postcopy_start()
 sets errp if it fails
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-3-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240328140252.16756-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/28/24 15:02, Avihai Horon wrote:
> There are several places where postcopy_start() fails without setting
> errp. This can cause a null pointer de-reference, as in case of error,
> the caller of postcopy_start() copies/prints the error set in errp.
> 
> Fix it by setting errp in all of postcopy_start() error paths.
> 
> Fixes: 908927db28ea ("migration: Update error description whenever migration fails")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   migration/migration.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b73ae3a72c4..86bf76e9258 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2510,6 +2510,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>           migration_wait_main_channel(ms);
>           if (postcopy_preempt_establish_channel(ms)) {
>               migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +            error_setg(errp, "%s: Failed to establish preempt channel",
> +                       __func__);
>               return -1;
>           }
>       }
> @@ -2525,17 +2527,22 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>   
>       ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>       if (ret < 0) {
> +        error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
>           goto fail;
>       }
>   
>       ret = migration_maybe_pause(ms, &cur_state,
>                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
>       if (ret < 0) {
> +        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
> +                         __func__);
>           goto fail;
>       }
>   
>       ret = bdrv_inactivate_all();
>       if (ret < 0) {
> +        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
> +                         __func__);
>           goto fail;
>       }
>       restart_block = true;
> @@ -2612,6 +2619,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>   
>       /* Now send that blob */
>       if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
> +        error_setg(errp, "%s: Failed to send packaged data", __func__);
>           goto fail_closefb;
>       }
>       qemu_fclose(fb);


