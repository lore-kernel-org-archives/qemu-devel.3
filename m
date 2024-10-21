Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A48D15DBC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vSx-0007PZ-13; Mon, 21 Oct 2024 12:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2vSu-0007P8-D5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2vSs-0006nE-QI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TiU0FA2gLFX4iI6xTTdE52rIaVuCOUFmJMHqThLlZA=;
 b=AP1POtu3tVVzBuuZFkswnGiN/bln9B+g0uTL5gnBKkcqHxcLhG7558uE4mFEN+EP961o1t
 JoAyUI06pI5iIef0dJR2rTEa0RggKZpy6L90umITBhU2rRRIVtKbwwdAPjovZcBG7SR93e
 mZVXhfrwTGtPMTVec41klEBEvamj53c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-dEMF-RgYPeehckWohSLzWQ-1; Mon, 21 Oct 2024 12:41:04 -0400
X-MC-Unique: dEMF-RgYPeehckWohSLzWQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-460a9b67fadso65560571cf.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528864; x=1730133664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TiU0FA2gLFX4iI6xTTdE52rIaVuCOUFmJMHqThLlZA=;
 b=H5rYTwk4EqXKOgn9DLPKSm6wvcLC22ppNl1G6FqlguG+ssXMHVPSWN2VUcNwkn8/cJ
 KPL9xA0NyyUD8dWKWcfDuZJ3fOLdQ6X5q5XYPHJ/H6rf879ojY4TmA6OUkCo0CQ189bu
 G0g+KC75ZTtFniLYRxTo4k2wjHd0v86XtLQ+thF+qgt/HhSokRjXbr05147HGie8A2NN
 MX34ADvIKXmA4u/ZmzddiwQFaZRb9mihqD+UyokEMa4rmMpr1hTKfeqBr5bDXObcEZ5q
 gDUlUcPcfbRPerVJpSloksyoMO9kXaLTWNhr0SYIvSSyRg0GJzUbDzzQjjNpyoLn+R6b
 BZQA==
X-Gm-Message-State: AOJu0YxjnWCQuP/2Y/E7x0gufVz/j723RJ8OshZKwxHfF3kh8vTpXyMX
 xWa27PeNRDAPSGzyHbWkDtcVLXYejqkATOqVDdHiul8JIgwi+4yUVg6I3qijG4LQpxWPHaVUwL0
 O/b2xRJYmf62dVtbxsL8D0AJoMpz4lrc5Cma19/OOJOtE3ED47GSS
X-Received: by 2002:a05:622a:4e95:b0:460:8fea:ecad with SMTP id
 d75a77b69052e-460aece7fd6mr156578011cf.12.1729528864420; 
 Mon, 21 Oct 2024 09:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdHRillgkQBV7i1KoznREy4FRvvCmbecUVqeMN+NAAZapYNhe0eSwVaQ3bMZ9MtCn44qyzog==
X-Received: by 2002:a05:622a:4e95:b0:460:8fea:ecad with SMTP id
 d75a77b69052e-460aece7fd6mr156577591cf.12.1729528863886; 
 Mon, 21 Oct 2024 09:41:03 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3d6936asm19564371cf.69.2024.10.21.09.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:41:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:41:00 -0400
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
Subject: Re: [RFC V1 05/14] migration: init and listen during precreate
Message-ID: <ZxaEHLa7LP5DCkYf@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 17, 2024 at 08:14:06AM -0700, Steve Sistare wrote:
> Initialize the migration object as early as possible so that migration
> configuration commands may be sent during the precreate phase.  Also,
> start listening for the incoming migration connection during precreate,
> so that the listen port number is assigned (if dynamic), and the user
> can discover it during precreate via query-migrate.  The precreate phase
> will be delineated in a subsequent patch.
> 
> The code previously called migration_object_init after memory backends
> were created so that a subsequent migrate-set-capabilities call to set
> MIGRATION_CAPABILITY_POSTCOPY_RAM would verify all backends support
> postcopy.  See migrate_caps_check and postcopy_ram_supported_by_host.
> The new code calls migration_object_init before backends are created.
> However, migrate-set-capabilities will only be received during the
> precreate phase for CPR, and CPR does not support postcopy.  If the
> precreate phase is generalized in the future, then the ram compatibility
> check must be deferred to the start of migration.

This makes sense to me on its own, so maybe we can have a seperate patch.

We should probably always do the check at start of migration, to avoid
postcopy-ram cap set followed by an memory plug which doesn't support
postcopy.

> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/vl.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index bca2292..d32203c 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2753,17 +2753,7 @@ void qmp_x_exit_preconfig(Error **errp)
>          replay_vmstate_init();
>      }
>  
> -    if (incoming) {
> -        Error *local_err = NULL;
> -        if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
> -                                 &local_err);
> -            if (local_err) {
> -                error_reportf_err(local_err, "-incoming %s: ", incoming);
> -                exit(1);
> -            }
> -        }
> -    } else if (autostart) {
> +    if (!incoming && autostart) {
>          qmp_cont(NULL);
>      }
>  }
> @@ -3751,6 +3741,18 @@ void qemu_init(int argc, char **argv)
>       * called from do_configure_accelerator().
>       */
>  
> +    /* Creates a QOM object */

Shall we still keep the ordering notes for global/compat properties to be
set before this one?  "create QOM object" on its own isn't much of help as
a comment if the function has a proper name..

> +    migration_object_init();
> +
> +    if (incoming && !g_str_equal(incoming, "defer")) {
> +        Error *local_err = NULL;
> +        qmp_migrate_incoming(incoming, false, NULL, true, true, &local_err);
> +        if (local_err) {
> +            error_reportf_err(local_err, "-incoming %s: ", incoming);
> +            exit(1);
> +        }
> +    }
> +
>      suspend_mux_open();
>  
>      qemu_disable_default_devices();
> @@ -3773,20 +3775,9 @@ void qemu_init(int argc, char **argv)
>                       machine_class->name, machine_class->deprecation_reason);
>      }
>  
> -    /*
> -     * Create backends before creating migration objects, so that it can
> -     * check against compatibilities on the backend memories (e.g. postcopy
> -     * over memory-backend-file objects).
> -     */

(so if there'll be a separate patch to delay postcopy ram check on src,
 this removal can be part of it)

>      qemu_create_late_backends();
>      phase_advance(PHASE_LATE_BACKENDS_CREATED);
>  
> -    /*
> -     * Note: creates a QOM object, must run only after global and
> -     * compat properties have been set up.
> -     */
> -    migration_object_init();
> -
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type = machine_class_default_cpu_type(machine_class);
>      if (cpu_option) {
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


