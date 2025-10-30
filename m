Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7324CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEbSs-00068F-FA; Thu, 30 Oct 2025 18:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbSl-00065z-UY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbSa-0001gk-Hu
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761864572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAHpiBmNSpNUM8AHfYZXQm3evjakxYKoMc5L6NWo88M=;
 b=HLjj1/ucwesN+83ABqY5CoV/pC3MSM2R31DStV4Hv0NZ2XcmCxDT67BSBLlDyiXsCkz28c
 3PeQJOOt2MUWPL5hrlfJLnnIWcfS3Da9P53JxOrUfFxTAwtUSjJFzoIkEDY/iBKEzJ3nIj
 +06b1VlxmCRg9O9t3wCuK24gk9xQyuw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-v57iI9TnMCmnFewzLTNHdQ-1; Thu, 30 Oct 2025 18:49:30 -0400
X-MC-Unique: v57iI9TnMCmnFewzLTNHdQ-1
X-Mimecast-MFC-AGG-ID: v57iI9TnMCmnFewzLTNHdQ_1761864570
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e88a5e70a7so49601761cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761864570; x=1762469370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAHpiBmNSpNUM8AHfYZXQm3evjakxYKoMc5L6NWo88M=;
 b=jxOFoNE6ZCztcMIvQCYJ18xc7pqc0oW800Q8P40Bp2bSgJde4LAu50BZ4wtGQTgsa5
 ktpMCyqE0AHuE0aN8h3Qlc5GrohsxMtSam2wPYX0vZ3HZ9jsyiuT5dxOPd3MxrLbQeA/
 G5/sn4Rf2lX60XkYcb4GQRa+UqerNYPc9lffp4k5Hdb7hTHeEHoXHnl278RMQvxd6cuu
 TbGLkYbJMgzcneYPhWT7whTrsLHW+J6/jOCDarb+ftRw2MaijbUKhr+b9dLOuzKdnL6w
 cbT09mxaxM1kJHKQYP0aYtHUN5AowWQ2pV/O2uJw2vq8JmL6e/3NH5ORIqM2hA67bpVP
 4Lrg==
X-Gm-Message-State: AOJu0YxkwLIvuhF4IyT3+vxxc6VT9jBMqnJElPX6BdBEpB2LoSR0ecnJ
 /in4EfeilydMzHI8osyUFCNGAwG4H2VfxIZ+cipPjIcqp6B/9R47rhaJVsEEBcofpDck1nAJipS
 rTi7F9zOU8yMusvN3CyVyJzCU+Jug1lEjG+aLVuqBrzQXyLr5yMa5gtBB
X-Gm-Gg: ASbGncvE3MFOAE6YULQcSKMUHNbNGuUAwXcqvzvzcxRk4rN8w/Llc6LVZhD2qpxojuB
 a1jKDlqGRs5KBjxsh6CoOGNjRwJdXy0Xtnr53LI4/SZopICNRT0Nxsp5gg6N+IDMvnKZDu+2qS8
 v4/6rr4W0NXO1C3UO1FtAklFLU4MvneFBSHlz3qE87Dxy5nkwyo90b0LaspAvFX/KVQ5huxOQoy
 LKObttw8Z1oiYP33IQ7JJO04eLmeF+7bMaXqlAMt0SEcLafV5qRRlrxFYPkiZrPQoW4I9GdQ/tb
 CKPTbdPYb7EKcOJbJX43IyLpo5/smRIgsEb4v2j2WAXFpR86xz37oui81zIZ/ahbUH0=
X-Received: by 2002:ac8:7f51:0:b0:4ec:8914:c373 with SMTP id
 d75a77b69052e-4ed218b27d3mr57836971cf.20.1761864569757; 
 Thu, 30 Oct 2025 15:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9lR/7OkiQMd7Rt4MBq+VCLQsC+j0KX3hbA6/TJckw45mmm7fPaWJ59179rLTsoVUEpqWWsg==
X-Received: by 2002:ac8:7f51:0:b0:4ec:8914:c373 with SMTP id
 d75a77b69052e-4ed218b27d3mr57836831cf.20.1761864569318; 
 Thu, 30 Oct 2025 15:49:29 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880362d276esm240736d6.28.2025.10.30.15.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 15:49:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:49:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 5/7] migration: Respect exit-on-error when migration
 fails before resuming
Message-ID: <aQPrd0giJxS6qz2i@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-6-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030214915.1411860-6-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:49:09PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> When exit-on-error was added to migration, it wasn't added to postcopy.
> Even though postcopy migration will usually pause and not fail, in cases
> it does unrecoverably fail before destination side has been started,
> exit-on-error will allow management to query the error.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/postcopy-ram.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 48cbb46c27..91431f02a4 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2080,11 +2080,16 @@ bool postcopy_is_paused(MigrationStatus status)
>  
>  static void postcopy_listen_thread_bh(void *opaque)
>  {
> +    MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      migration_incoming_state_destroy();
>  
> -    if (mis->state == MIGRATION_STATUS_FAILED) {
> +    if (mis->state == MIGRATION_STATUS_FAILED && mis->exit_on_error) {
> +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +            error_report_err(s->error);
> +            s->error = NULL;
> +        }
>          /*
>           * If something went wrong then we have a bad state so exit;
>           * we only could have gotten here if something failed before
> -- 
> 2.51.0
> 

-- 
Peter Xu


