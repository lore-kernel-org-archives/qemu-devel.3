Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E6BCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUrYe-0002gJ-If; Wed, 03 Jun 2026 15:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrYb-0002fc-49
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrYW-00085T-6y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780516029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8trTXXgB97EY4CXfA74sUVI3qFg76/J/Z4vUaouXpI=;
 b=Um6UAuFgoPz8HDTnCTl6uYJ7nZWTsi0UmNyUvZigLP0BohZQoLHsyC5PvXMuQpvJmD7u7K
 lkdgeCjsEVAF29gDD5qgTcsU/Oqp1aXArkr9MDanj5bzcHohp7hR67QBuId7j4KfKDvqxf
 PFygjQ9ZBl3GcKaSZrkwlu79+2X621A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-4mMPJXwlMne2rjahVBEf6A-1; Wed, 03 Jun 2026 15:47:08 -0400
X-MC-Unique: 4mMPJXwlMne2rjahVBEf6A-1
X-Mimecast-MFC-AGG-ID: 4mMPJXwlMne2rjahVBEf6A_1780516028
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso15274026d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780516028; x=1781120828; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F8trTXXgB97EY4CXfA74sUVI3qFg76/J/Z4vUaouXpI=;
 b=rTzFUqd59tGxLoQ7xmFNnGKZPVDqkJxF2ZS7RmaOPQxdio0JrnVxdFxBTZwVTWCMbl
 wzTiIB7pbku26A3Kd2uZLhAnyQyWvoMBR0i4BHmaKsxgjtE5zFQWXWkrQrqsms/tJx/P
 3g8cGcZP9k3EgE4Xn73u4+JsW+qMdOh802iEbkefHgu1nJcbPKJBOCWI16w4C+UiHdMc
 tvhe9zK+Rs5/2LW/Sxhidv18lridurZ3U65v50jMS/RjgZPd0vXhcegAMCg4YC3LG7iz
 5lJkI+UnyNzxo9o0wRH1TkuLd4Kzlnm9738sl9658pFY6c0n9JBiPmNp5pru/gNNH5JZ
 gbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780516028; x=1781120828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8trTXXgB97EY4CXfA74sUVI3qFg76/J/Z4vUaouXpI=;
 b=kwnLsLyXXiIYOPuabqqJDOyKLt4536Ms8x9p5LE0uj+8G04IFsFlzusxm2zxIOrnfq
 KcwH5jLwUkH4Vu14wTOvBVBmoIyWTyXVrkZJfmHUyNJqk/D0zHZuMNz5xo6j+1sXHjzw
 /OWLgeBCCi6tBpK4+uwOgOkIZD6SOycrrr3k++lL10/ut12+RcrdvA89mE2XjPR0jEtx
 eLnMu4/XDKpoVDUm5l18SHyrqorA8GFkNKdmFgG4+OgB+OJga8VRQPw2O5/z91DsAPJr
 OyFJOe0rOHT+yQQUgUVjqrPKWLq1vZ8k2kwhIUfVq2cbpN9GI2Gdef06wllMW35Mk47t
 tjmg==
X-Gm-Message-State: AOJu0YxasiF9mMpYOJOreK4+o4E2qkXYA/KigYsbmNRLIYt7Pftwzk/Z
 72n4QzC4NDHeG7hxnQwCeSgR9KZcd0s0pseGV04LREOi2CfAkJSUtYlj8si52e9fseGA92FZqem
 AwJw86n/GsyPD3S8KbiwtlM/y7PQxXwjhS4gQePkLs50GwofDoAbMIWHW
X-Gm-Gg: Acq92OGYSy5pO6En+LGmgkG0gNdUtyTRgHt+4R8lZzTlu1HBzjSEz+6rS4e70Z4edDh
 3ShFiiZi3S5mdPLWA42uAsrjSS0SsW5IjcF4CUho8fa8AddVMfqZ9sfSPdu3H1yb9WPf35eDV8c
 sEdOleUF2yVMVpR3wEzPMIvQ2Un22peiOWiHAsWPnebn8KLcAD5+AkWOGXvqxCjR78rvmeGJ/Wd
 ufZ5P3oQ9r6XUwwUZtHckXLBuWmpbrwpdinjO1JGaTPJdSTV0R73ynW/0MDal2Oqo1ffRMlc34r
 gEJ96RqCiIbLMZuVTnY9eB2gmzea1iDHnsQrWS1jR3Xm+jcX1Lsoy6ruWiApVgxLh9Lv3UYet/C
 v46zXi4Uf8pZwTRMZka0t5BRbzQ==
X-Received: by 2002:a05:6214:1bcc:b0:8cc:dddb:eeaf with SMTP id
 6a1803df08f44-8cece16b555mr74744616d6.40.1780516027874; 
 Wed, 03 Jun 2026 12:47:07 -0700 (PDT)
X-Received: by 2002:a05:6214:1bcc:b0:8cc:dddb:eeaf with SMTP id
 6a1803df08f44-8cece16b555mr74743906d6.40.1780516027245; 
 Wed, 03 Jun 2026 12:47:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm29308636d6.25.2026.06.03.12.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 12:47:06 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:47:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 01/13] migration: Propagate errors in
 migration_completion_precopy()
Message-ID: <aiCEuAmX3qpWDS5n@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-2-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-2-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 02, 2026 at 12:26:09PM +0300, Avihai Horon wrote:
> migration_completion_precopy() doesn't propagate errors to migration
> core which leads to error information loss. Fix that.
> 
> This prepares for a follow-up where migration_switchover_start() can
> fail on switchover-ack and still report a useful error. Errors from
> qemu_savevm_state_complete_precopy() are not propagated yet as it
> requires more plumbing.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  migration/migration.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..7488a94206 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>      return true;
>  }
>  
> -static int migration_completion_precopy(MigrationState *s)
> +static int migration_completion_precopy(MigrationState *s, Error **errp)
>  {
>      int ret;
>  
> @@ -2823,11 +2823,12 @@ static int migration_completion_precopy(MigrationState *s)
>      if (!migrate_mode_is_cpr()) {
>          ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>          if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to stop the VM");
>              goto out_unlock;
>          }
>      }
>  
> -    if (!migration_switchover_start(s, NULL)) {
> +    if (!migration_switchover_start(s, errp)) {
>          ret = -EFAULT;
>          goto out_unlock;
>      }

IIUC this patch overlooked the follow up call:

    ret = qemu_savevm_state_complete_precopy(s);

We should make sure ret!=0 will always set Error*.  Better pass Error**
into qemu_savevm_state_complete_precopy() too.

Thanks,

> @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
>      Error *local_err = NULL;
>  
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
> -        ret = migration_completion_precopy(s);
> +        ret = migration_completion_precopy(s, &local_err);
>      } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>          migration_completion_postcopy(s);
>      } else {
> @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
>      return;
>  
>  fail:
> -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> +    if (local_err) {
> +        migrate_error_propagate(s, local_err);
> +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>          migrate_error_propagate(s, local_err);
>      } else if (ret) {
>          error_setg_errno(&local_err, -ret, "Error in migration completion");
> -- 
> 2.40.1
> 

-- 
Peter Xu


