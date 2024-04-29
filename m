Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A5DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WkO-00051W-Sq; Mon, 29 Apr 2024 15:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WkK-000518-Lg
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WkI-0000BF-UA
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714419180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4ZJuQ2alEohZD5iVWYA9V4FItqLlLyqqgXKA9cMfpY=;
 b=CStMYN6i6qv8PZcKBnLkrshsroUdZ4cU85Uxayt8MDtsV+pTV6DNzilCIlbTQ/HqtBjJVp
 APk0rJNGJdUxt/2gwGAJBdejZnI8sqv3WP/LDb1Yr9rvw6pAcyLDQYvrEzYuraoj9fhG0C
 OW6NyCx9rNSXoEdFaGX85bVzW0GSoNo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-wiRemPwpNGe9F6xrH7gLuA-1; Mon, 29 Apr 2024 15:32:57 -0400
X-MC-Unique: wiRemPwpNGe9F6xrH7gLuA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1e8674afee9so775115ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714419177; x=1715023977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4ZJuQ2alEohZD5iVWYA9V4FItqLlLyqqgXKA9cMfpY=;
 b=wYkP3LrXb3dZhqpbyEF5Kl2iVr04S0f1cQ81wf4oDbmkx+/Avyz3iU4oQfoBNa6tP8
 IG8UaX1X7dVMfl5Wt3fBGFDMXhy2Kt0OIOTsxMwrBPuVh2aYIQsAMrHqgAWxC8bIBydD
 HpD84LcHtncWH9Glf6urx7AKwHR6BxiHWljiQfLDDrPJ7ccqS7as6CsxzHcX0SXONSbv
 oUcmUAtJRGwOmrz35oOQNBlufQVM/Q1TVzHcVQNKGw9cMAQEeIZez2Gqg+IGMJVSBG7G
 LDJ0fTglxVgcxBH9Vwn7kV84ArXgCc5D+huUqgugwBpZHTbipkfR0gMlZaO+2uUIhRv3
 JwnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJV1Yhc+YQIkRhmPygjXKoTD5toHYnt+MgXyEh64WjdfWtUARYg6Q/OpFcAiI/wA1dmxCr1Jxo4itOpfC5bh0FUElPAfA=
X-Gm-Message-State: AOJu0Yzcsx5e8SJRFV1KP9j0p5jBxdKW/H1B5GuNzgs8bpdXVZF1tp0k
 bdhPz9Nv54pUtP09Da10E8cTM+FrgEz4kas8UFbagRW9M5qRadAJytc09ihS2eArS4i6kXk27sL
 n9P5YIk51dt3j2upb3jJEBrWK1DLoiZQNVctiKzWSb5xqzq/MxC2M
X-Received: by 2002:a17:903:22cb:b0:1e6:626c:f373 with SMTP id
 y11-20020a17090322cb00b001e6626cf373mr14213636plg.0.1714419176581; 
 Mon, 29 Apr 2024 12:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpm/5x7DQecsnL42iBZVgAR8o29O4xwsR4LEa/9r67ShfGhYQG53PPmEoDdnc3AeM3SZPwPQ==
X-Received: by 2002:a17:903:22cb:b0:1e6:626c:f373 with SMTP id
 y11-20020a17090322cb00b001e6626cf373mr14213601plg.0.1714419175985; 
 Mon, 29 Apr 2024 12:32:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 a8-20020a170902ecc800b001e944fc9248sm16509454plh.194.2024.04.29.12.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:32:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:32:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 3/5] migration: process_incoming_migration_co(): fix
 reporting s->error
Message-ID: <Zi_15NLonFVFjQQP@x1n>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429191426.2327225-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 10:14:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> It's bad idea to leave critical section with error object freed, but
> s->error still set, this theoretically may lead to use-after-free
> crash. Let's avoid it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/migration.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0d26db47f7..58fd5819bc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -732,9 +732,19 @@ static void process_incoming_migration_bh(void *opaque)
>      migration_incoming_state_destroy();
>  }
>  
> +static void migrate_error_free(MigrationState *s)
> +{
> +    QEMU_LOCK_GUARD(&s->error_mutex);
> +    if (s->error) {
> +        error_free(s->error);
> +        s->error = NULL;
> +    }
> +}
> +
>  static void coroutine_fn
>  process_incoming_migration_co(void *opaque)
>  {
> +    MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> @@ -779,11 +789,9 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        MigrationState *s = migrate_get_current();
> -
>          if (migrate_has_error(s)) {
>              WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -                error_report_err(s->error);
> +                error_report_err(error_copy(s->error));

This looks like a bugfix, agreed.

>              }
>          }
>          error_report("load of migration failed: %s", strerror(-ret));
> @@ -801,6 +809,7 @@ fail:
>                        MIGRATION_STATUS_FAILED);
>      migration_incoming_state_destroy();
>  
> +    migrate_error_free(s);

Would migration_incoming_state_destroy() be a better place?

One thing weird is we actually reuses MigrationState*'s error for incoming
too, but so far it looks ok as long as QEMU can't be both src & dst.  Then
calling migrate_error_free even in incoming_state_destroy() looks ok.

This patch still looks like containing two changes.  Better split them (or
just fix the bug only)?

Thanks,

>      exit(EXIT_FAILURE);
>  }
>  
> @@ -1433,15 +1442,6 @@ bool migrate_has_error(MigrationState *s)
>      return qatomic_read(&s->error);
>  }
>  
> -static void migrate_error_free(MigrationState *s)
> -{
> -    QEMU_LOCK_GUARD(&s->error_mutex);
> -    if (s->error) {
> -        error_free(s->error);
> -        s->error = NULL;
> -    }
> -}
> -
>  static void migrate_fd_error(MigrationState *s, const Error *error)
>  {
>      assert(s->to_dst_file == NULL);
> -- 
> 2.34.1
> 

-- 
Peter Xu


