Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F24CAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcYM-000194-CG; Fri, 19 Sep 2025 10:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzcYK-00018J-8m
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzcYB-0008S5-MK
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758293842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQhBPBj2xyCF1Txti8vjAK57g/dVTUncPpxYQSDtzRM=;
 b=hxiq28m8rE6e2BcU5QxhISiDK27/L905ezxnpGJfzRDsAxkeZjqitdyBccj1UMJ3CHy1zn
 aa83zDLfhXwHrjLVddJvq369GtOhzKZ7xS/sjSH7QCxfEISeFPW4pQy3n0RVH+iNPYEYTx
 BFTRMXJMcGAO4zsZ94HDz/ZgA2fqa9M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-BEDiiCn3M3KALgIyVWBZdg-1; Fri, 19 Sep 2025 10:57:15 -0400
X-MC-Unique: BEDiiCn3M3KALgIyVWBZdg-1
X-Mimecast-MFC-AGG-ID: BEDiiCn3M3KALgIyVWBZdg_1758293835
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b5fbf0388eso28006561cf.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758293835; x=1758898635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQhBPBj2xyCF1Txti8vjAK57g/dVTUncPpxYQSDtzRM=;
 b=MWv6D7e6PGuJL/ZiBqmAwKMS2DUdHA5XlyVtF5bRn8rP6yvpl1Q6xo9JWSEXeGxRai
 PTDVvSBhuL5QNNyPCaHIaT5V+11R11tXhGJMADcD7OnX/TPLWK6Mg4ws21yK2B0mT6zp
 oHXU5H69L7mUvGzrxcpFAo/ZDyX5gcPuUbe77r9ktD2LZiTZvKLpgTPUqWlypSc74OJO
 ReYgKbocvg0/A7cU9Hg82XQ8cWzynWihhpsfWEEzlVCM12CAnC9l8EDO4kEOQGAtMJuF
 r4wMUyEOr/oglId+ngXZy+CKbatuQJ3zEr/91FnyzvNpw6JysRKd8FsZ6DX/g2sDkWSI
 +h8A==
X-Gm-Message-State: AOJu0YyAmsB0Kd2GR9RfGhkXXTtR+x6a3RknnkZNzKdDOH6G01O7z5nW
 nBeQfeV5oW22tiWhBpYkGIjxvREh8PZjG5zoyc4wBe+xoyTe4heHojQj79SKL5rerA02VuhDTAR
 AJxQoKbAu+PzhxKBtO+j0CyUc1i4nx1y10SrCuras5PEkCp7vmtvpLtBn
X-Gm-Gg: ASbGnctDGca8TL+srfF44XywFoy+CTjDR/0xm+NxScT2DKVn9ApAtaSeoKeWIY0zGkx
 p5bGlVZnWZWWW9H4fR9p0ZaEI/y5F7DiZ84LU3w1YL4TtI4nJlFxE+bqE7bI2g9xYFyaSTDakck
 dGJadlpbkWMSq+5CkYEf8pikL3ECA3KTSmnfvX/jUTGIcwddMttrpRKlK+OqKoqpoyxE0xo9Q70
 MFYZY5QGTUAMWc6XO1UALj/9kb3yhfcZVILHqxs+mgsaiuM+xEFcntFFXGp2tNnGNPGCrSud5rv
 Gkv4ywm7AuFupRRG2uJ/PDO2efSSZ1tp
X-Received: by 2002:a05:622a:14f:b0:4b5:dc7c:a6ea with SMTP id
 d75a77b69052e-4c073106ac8mr36489581cf.49.1758293835060; 
 Fri, 19 Sep 2025 07:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQr+rP0w07AGf416rcvXKfyzrjL8kYTZbEvztQNcbM0UGxBXbgbm5VZJOf3OgdN2dgMcVT2A==
X-Received: by 2002:a05:622a:14f:b0:4b5:dc7c:a6ea with SMTP id
 d75a77b69052e-4c073106ac8mr36488991cf.49.1758293834534; 
 Fri, 19 Sep 2025 07:57:14 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda140ccadsm30625081cf.4.2025.09.19.07.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 07:57:14 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:57:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] migration: Accept MigrationStatus in
 migration_has_failed()
Message-ID: <aM1vSZcXY08tfMpM@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-3-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915115918.3520735-3-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 01:59:13PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> This allows to reuse the helper also with MigrationIncomingState.

I get the point, but just to mention that this helper doesn't really change
much on incoming side on simplifying the code or function-wise, because we
don't have CANCELLING/CANCELLED state on deste QEMU.. which is definitely
not obvious.. :(

So:

  migration_has_failed(incoming->state)

Is exactly the same as:

  incoming->state == MIGRATION_STATUS_FAILED

Except it will make src start to pass in s->state.. which is slightly more
awkward.

Maybe we keep the MIGRATION_STATUS_FAILED check in your next patch, and
drop this one for now until it grows more than FAILED on dest?

> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 8 ++++----
>  migration/migration.h | 2 +-
>  migration/multifd.c   | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 54dac3db88..2c0b3a7229 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1542,7 +1542,7 @@ static void migration_cleanup(MigrationState *s)
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> +    type = migration_has_failed(s->state) ? MIG_EVENT_PRECOPY_FAILED :
>                                       MIG_EVENT_PRECOPY_DONE;
>      migration_call_notifiers(s, type, NULL);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -1700,10 +1700,10 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>      return ret;
>  }
>  
> -bool migration_has_failed(MigrationState *s)
> +bool migration_has_failed(MigrationStatus state)
>  {
> -    return (s->state == MIGRATION_STATUS_CANCELLED ||
> -            s->state == MIGRATION_STATUS_FAILED);
> +    return (state == MIGRATION_STATUS_CANCELLED ||
> +            state == MIGRATION_STATUS_FAILED);
>  }
>  
>  bool migration_in_postcopy(void)
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..2c2331f40d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -535,7 +535,7 @@ bool migration_is_blocked(Error **errp);
>  bool migration_in_postcopy(void);
>  bool migration_postcopy_is_alive(MigrationStatus state);
>  MigrationState *migrate_get_current(void);
> -bool migration_has_failed(MigrationState *);
> +bool migration_has_failed(MigrationStatus state);
>  bool migrate_mode_is_cpr(MigrationState *);
>  
>  uint64_t ram_get_total_transferred_pages(void);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..c569f91f2c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -568,7 +568,7 @@ void multifd_send_shutdown(void)
>               * already failed. If the migration succeeded, errors are
>               * not expected but there's no need to kill the source.
>               */
> -            if (local_err && !migration_has_failed(migrate_get_current())) {
> +            if (local_err && !migration_has_failed(migrate_get_current()->state)) {
>                  warn_report(
>                      "multifd_send_%d: Failed to terminate TLS connection: %s",
>                      p->id, error_get_pretty(local_err));
> -- 
> 2.51.0
> 

-- 
Peter Xu


