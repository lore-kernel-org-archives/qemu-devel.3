Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624ACD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprNy-0006pC-Eq; Thu, 28 Mar 2024 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprNv-0006ow-W8
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rprNu-00022i-H0
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pEQW1F32Ci2aXv4UWMumzqzAZZGZqXoK3fPaDDAvKXM=;
 b=H/cnJIsQeB6QqZdwN7hXE9n1JwfWOi9+/lIGIu5O8COFgcm7K5zM2+7uOStTh/DuQZ2hEi
 bxec9JIPdeEUu/W0HfCHvmdxWx+kq6x9S3LDj+jS7Tu9NtBTERwlGbv0uFdhac8Xk8lYHQ
 oFeW51frD9Pgl1YgjpNhvTmAQd6uFYo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Keaz2WtlPjKlT9lFSB1f8Q-1; Thu, 28 Mar 2024 11:09:40 -0400
X-MC-Unique: Keaz2WtlPjKlT9lFSB1f8Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830635331bso25530285a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638580; x=1712243380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEQW1F32Ci2aXv4UWMumzqzAZZGZqXoK3fPaDDAvKXM=;
 b=ar4Gomq7J1cnxg/oCGzjRbEEkLGVyQksEtwxfIvpD63RYMnJDZiU+XGqVYtaWhxAqv
 30lDUzBqTu1AbpqtMWjQM9Bf3U4EsiIMPX/nJqqPJZFRrcZKScpsocXUFK809U9bUUdO
 c/xMRBajSPKOO963aXIrutAMT3MT4Ewt0/vL8ja/cV9gPj/NkwiC/kvO77bi2jYQU77d
 sKMTid0KgL4yInUJKrODrNOIAytKHRpjCaI7GxKtyGMxJjdIANlpMPO49EisnQU2Buet
 Ero/mu+Y4tCiyCsFJdsvBhPyjF++fdVR6RvQsxgL967hLGr+twaTJQtONr0QGAnEJ+E5
 NQOQ==
X-Gm-Message-State: AOJu0YzGRfwjUWK84QnvPrgrmvIhbMwciw42sV8w1V+6xeDi9XYDPrTh
 4Y9E8Ai3SqTCGU8j/oi+uypFWbpndg4Nr4M1Y1xktvTiHpHOfHWAllKD/FZDinlDdDQ4pMyRnD7
 nJk2oVaNsUAmDnM3G580C+F68m0TCoaWTNNlFy7ZBjxlOWxsKIbWa
X-Received: by 2002:a05:620a:4103:b0:78b:babc:9dbd with SMTP id
 j3-20020a05620a410300b0078bbabc9dbdmr2764288qko.7.1711638579485; 
 Thu, 28 Mar 2024 08:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5YTFs36Xc26w4Yc317di5aB8xnL7B1O6KCUSnMF7yrD8IoPNVOEviPL1vZVoTe19ID+RAhg==
X-Received: by 2002:a05:620a:4103:b0:78b:babc:9dbd with SMTP id
 j3-20020a05620a410300b0078bbabc9dbdmr2764240qko.7.1711638578918; 
 Thu, 28 Mar 2024 08:09:38 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05620a120600b00789e8860ef7sm584477qkj.121.2024.03.28.08.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
Message-ID: <ZgWIMDjzXG1Efwgv@x1n>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-2-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328140252.16756-2-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Mar 28, 2024 at 04:02:51PM +0200, Avihai Horon wrote:
> After commit 9425ef3f990a ("migration: Use migrate_has_error() in
> close_return_path_on_source()"), close_return_path_on_source() assumes
> that migration error is set if an error occurs during migration.
> 
> This may not be true if migration errors in migration_completion(). For
> example, if qemu_savevm_state_complete_precopy() errors, migration error
> will not be set.
> 
> This in turn, will cause a migration hang bug, similar to the bug that
> was fixed by commit 22b04245f0d5 ("migration: Join the return path
> thread before releasing to_dst_file"), as shutdown() will not be issued
> for the return-path channel.
> 
> Fix it by ensuring migration error is set in case of error in
> migration_completion().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I'll attach this if it looks all right to you:

Fixes: 9425ef3f990a ("migration: Use migrate_has_error() in close_return_path_on_source()")

Thanks,

> ---
>  migration/migration.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9fe8fd2afd7..b73ae3a72c4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
>  {
>      int ret = 0;
>      int current_active_state = s->state;
> +    Error *local_err = NULL;
>  
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>          ret = migration_completion_precopy(s, &current_active_state);
> @@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
>      return;
>  
>  fail:
> +    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +    } else if (ret) {
> +        error_setg_errno(&local_err, -ret, "Error in migration completion");
> +        migrate_set_error(s, local_err);
> +        error_free(local_err);
> +    }
> +
>      migration_completion_failed(s, current_active_state);
>  }
>  
> -- 
> 2.26.3
> 
> 

-- 
Peter Xu


