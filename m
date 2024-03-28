Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF0CC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprZ4-0004KW-M4; Thu, 28 Mar 2024 11:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rprZ3-0004KK-Ae
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rprZ1-0004Dj-EK
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711639268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tU5gcPPjOOQYbjJnEXHPzzXPEWkVTbxIf52ciggj4Qc=;
 b=UEkY2KBRsccnGk/GvVBz0bUVeRNlVrsTaSrsDBkBEXptQBhOBGlpm28MOZyR2iL6PcNKug
 qd8p5YM2ic9/Tmzyi3mFcY6Ep1pKEZoUumTyDj0YhrZF/dhN2K6xyyoZgxnzTf9qiz4Y1o
 CsmTSWUk2ogV1l6AaTVVikh+1y7ADgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-HfNhY6YbO5i_n4FLBALmrQ-1; Thu, 28 Mar 2024 11:21:07 -0400
X-MC-Unique: HfNhY6YbO5i_n4FLBALmrQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4148b739698so6369645e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711639266; x=1712244066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tU5gcPPjOOQYbjJnEXHPzzXPEWkVTbxIf52ciggj4Qc=;
 b=Q+PsMjfvwclwdGhQyv+XRLFuElENWyEjH4LK9VqTf1Ip/7KDAiIrQvOlXNWh19LPt+
 arw3qb5udzIaLyrwuO+OVh6YdpH4FmD9/FFruhfrcIwKNU2uxoyZgIpVX+qKLhMR92q6
 +zwD79SfHSjHqXq0y9UwwRB7C49/EKarkM57b8ZA4Ptv9OvMgKPtkjwbNfXbwlrZ6B5s
 bMwC4RBZD9xQrR58KGIpMVz91uDHetkbPsWbq+XBASkrm1WoNWW3q6lx60AGvo/PBfqj
 yJ7g9xnnjzAFEVOPeyw/ixDSVPK8NnLdlEvi+nj/Bs+WPW7Vym7PfffSx5A71eJV4aB2
 3r+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVORXyN+FRmRHYskKoY1q0UOA1lCMPCD+wSDZJj0O6rq4MDoLxXqPIiNyLnrmqMgiP3lg4a8yM7sAUgcDIxdKubGhssOqo=
X-Gm-Message-State: AOJu0YxqUgeXopSpDdv2Ghdu82ZM/Ws0CllBS3Dfbc2+l+wJ37/wqFls
 27ArnAnzfaojE3w2iSaZxNlSk+QGhXJdlNwewY2cCchSWSEUQEbZ14vX97oLr0xYscdKtxdS7nC
 Lutwh9E3aOewNlfm8YycptsnbBFC281OWcly0Z3nF7rAkXjW63LEv
X-Received: by 2002:a05:600c:5249:b0:414:6172:8366 with SMTP id
 fc9-20020a05600c524900b0041461728366mr2877277wmb.15.1711639265974; 
 Thu, 28 Mar 2024 08:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw5R+IdFvTYwg+oRH4g5EMERdLlctNou2BKjcEhBHy5fkmOaoWevwL+wl0BQfJYU1JdYFBHA==
X-Received: by 2002:a05:600c:5249:b0:414:6172:8366 with SMTP id
 fc9-20020a05600c524900b0041461728366mr2877267wmb.15.1711639265613; 
 Thu, 28 Mar 2024 08:21:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fb7-20020a05600c520700b00414969894a1sm4469202wmb.13.2024.03.28.08.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 08:21:05 -0700 (PDT)
Message-ID: <9aea916e-ea64-424b-bb48-4d1ad75e85ac@redhat.com>
Date: Thu, 28 Mar 2024 16:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-2-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240328140252.16756-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Hello Avihai,

On 3/28/24 15:02, Avihai Horon wrote:
> After commit 9425ef3f990a ("migration: Use migrate_has_error() in
> close_return_path_on_source()"), close_return_path_on_source() assumes
> that migration error is set if an error occurs during migration.
> 
> This may not be true if migration errors in migration_completion(). For
> example, if qemu_savevm_state_complete_precopy() errors, migration error
> will not be set

Out of curiosity, could you describe a bit more the context ? Did
vfio_save_complete_precopy() fail ? why ?

We should propagate errors of .save_live_complete_precopy() handlers as
it was done .save_setup handlers(). For 9.1.

> This in turn, will cause a migration hang bug, similar to the bug that
> was fixed by commit 22b04245f0d5 ("migration: Join the return path
> thread before releasing to_dst_file"), as shutdown() will not be issued
> for the return-path channel.

yes, but this test :

     if (ret < 0) {
         goto fail;
     }

will skip the close_return_path_on_source() call. Won't it ? So I don't
understand how it can be an issue. Am I missing something ?

> Fix it by ensuring migration error is set in case of error in
> migration_completion().

Why didn't you add a reference to commit 9425ef3f990a ?


> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/migration.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9fe8fd2afd7..b73ae3a72c4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
>   {
>       int ret = 0;
>       int current_active_state = s->state;
> +    Error *local_err = NULL;
>   
>       if (s->state == MIGRATION_STATUS_ACTIVE) {
>           ret = migration_completion_precopy(s, &current_active_state);
> @@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
>       return;
>   
>   fail:
> +    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +    } else if (ret) {
> +        error_setg_errno(&local_err, -ret, "Error in migration completion");

The 'ret = -1' case could be improved with error_setg(). As a followup.

Thanks,

C.




> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +    }
> +
>       migration_completion_failed(s, current_active_state);
>   }
>   


