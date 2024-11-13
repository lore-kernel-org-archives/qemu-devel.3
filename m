Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E948CD637C7
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 21:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKeV-0005RA-Pj; Wed, 13 Nov 2024 16:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKeN-0005Qm-IV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKeL-0003sY-Sn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 16:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731532300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/U0FdxpXEHFApXwX/Gv04MaLfWftqodoz0bSN3tz6ko=;
 b=XGjndcmI0kUXBOwi5LQQ7fuF94SJn+W/OLq6BTtBsRCcshYlIwL6esTSJzAud6DwKpEuaV
 KOtDXhMBQP1+xxDC4zAeq8vBuYeXxxMimtOxZ8dklEwAgkpAWE/lwSh1c1V1tZI3qvXeHU
 NZ+zaee5QwN4kz1evQTuhv5EDEFzegM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-MY2_tPl7OKSt5MaVfyqaKQ-1; Wed, 13 Nov 2024 16:11:38 -0500
X-MC-Unique: MY2_tPl7OKSt5MaVfyqaKQ-1
X-Mimecast-MFC-AGG-ID: MY2_tPl7OKSt5MaVfyqaKQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbe4fc0aa7so119072956d6.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 13:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731532298; x=1732137098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U0FdxpXEHFApXwX/Gv04MaLfWftqodoz0bSN3tz6ko=;
 b=DCDlTljMM5NC+Y0H57MzEoLM81faV2LT5gxVoYz5WdvWnfQsEDdV3KR9cEMJvjfWVv
 +QcJUSVkRinw6sBtvquyhGohe9uo6+TmH39Ylp4WwSkrH8KXlR113TCgkwl1Hd01Qy2G
 7G9+HgC777Z6NB7s8h902P86SNT431Em374PvcMHYYtXBj6gvXyO6IrbUyI3abC8bht1
 +IhUFVS4YSx9mcLOPxlc05Wm5AGwkma4jQtH1p+XiC+uolOwLIATkZ3sHI7oSHydgKZc
 KA/NUJgKP0R51kTvyqDuvBrJsUuKuxJQuOVNJ0RUCIRCEvJMQt43dAXp4k0TZJaboiD5
 +f7Q==
X-Gm-Message-State: AOJu0YwPScz7Z6Tsfu86HEA35gEGrKX/0T5Jl7Dsk6TxwCuRsf65cNyC
 kZg1vt4ZyQqbI2reFfJTzBPOyE/WGnfhYByV3FhYRfZSt8TwVRcjnJo2c/2pK9XeygdwV881qxQ
 BW6KgrWeIENN/TIrPytJrD0UKS7RhfL2dwGGOb6bIxoNgCpg+a6PB
X-Received: by 2002:a05:6214:3c8e:b0:6cb:cd05:cddd with SMTP id
 6a1803df08f44-6d39e12fd07mr326889316d6.26.1731532298095; 
 Wed, 13 Nov 2024 13:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAPD5FqFw6bwj/TQXbSARWDXSbrrwaiLEMlUIo2y2j+7SOGfsnrHIaCz0+kdUS2I+pLKkmJQ==
X-Received: by 2002:a05:6214:3c8e:b0:6cb:cd05:cddd with SMTP id
 6a1803df08f44-6d39e12fd07mr326889086d6.26.1731532297814; 
 Wed, 13 Nov 2024 13:11:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3983445f0sm87300976d6.83.2024.11.13.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:11:37 -0800 (PST)
Date: Wed, 13 Nov 2024 16:11:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 10/16] migration: split qmp_migrate
Message-ID: <ZzUWAnYARa_G2-J1@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-11-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-11-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Nov 01, 2024 at 06:47:49AM -0700, Steve Sistare wrote:
> Split qmp_migrate into start and finish functions.  Finish will be
> called asynchronously in a subsequent patch, but for now, call it
> immediately.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6dc7c09..86b3f39 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1521,6 +1521,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
>  static void migrate_fd_cancel(MigrationState *s)
>  {
>      int old_state ;
> +    bool setup = (s->state == MIGRATION_STATUS_SETUP);
>  
>      trace_migrate_fd_cancel();
>  
> @@ -1565,6 +1566,15 @@ static void migrate_fd_cancel(MigrationState *s)
>              s->block_inactive = false;
>          }
>      }
> +
> +    /*
> +     * If qmp_migrate_finish has not been called, then there is no path that
> +     * will complete the cancellation.  Do it now.
> +     */
> +    if (setup && !s->to_dst_file) {
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_CANCELLED);
> +        vm_resume(s->vm_old_state);
> +    }

Hmm.. this doesn't look like the right place to put this change.. as this
patch logically should bring no functional change if it's only about a new
helper split an existing function.

Meanwhile, this change also doesn't yet tell where does a vm_resume() came
from.. I'm really not sure whether this is correct at all, consider someone
does QMP "stop", migrate then quickly cancel it.  I suppose it may
accidentally resume the VM which it shouldn't.

Not to mention checking "setup" early, and unconditionally modify the state
here no matter what it is (can it be things like FAILED now, then
overwritten by a CANCELLED)?  But I'd confess that's not the problem of
this patch, but that migration state machine is currently still racy.. afaiu.

>  }
>  
>  void migration_add_notifier_mode(NotifierWithReturn *notify,
> @@ -2072,6 +2082,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>      return true;
>  }
>  
> +static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> +                               Error **errp);
> +
>  void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
> @@ -2118,6 +2131,20 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    qmp_migrate_finish(addr, resume_requested, errp);
> +
> +    if (local_err) {
> +        migrate_fd_error(s, local_err);
> +        error_propagate(errp, local_err);
> +    }

I don't see when local_err will be set at all until here.. maybe you meant
*errp, but then maybe we should drop local_err and use ERRP_GUARD().

> +}
> +
> +static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> +                               Error **errp)
> +{
> +    MigrationState *s = migrate_get_current();
> +    Error *local_err = NULL;
> +
>      if (!resume_requested) {
>          if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
>              return;
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


