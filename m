Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66996C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 16:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCiN0-0004CI-IZ; Thu, 30 May 2024 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiMz-0004C0-4E
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiMu-0008Re-Md
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717085466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKTcnR1fDvdy3TfHFtSFnLfFliZBzFl3ZOVtMUHC8vQ=;
 b=g063E6PlvjizMu5aVVge8T3juYdV13T5hxNKfqLf5rWvm6o5eG+KsdKcc6X26HT0BCyrZm
 mD747awhT5SaDg/qrbu5oJ+V5zjzA+vuPIWrj2m+U3MuZ/14wFcKDgBWrzECduKIIKGmRm
 qvsKj8OpqQY5CwoayrtaibQjDrljOJw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-NKz6zk8HMwSoCYw3Ig3ttg-1; Thu, 30 May 2024 12:11:05 -0400
X-MC-Unique: NKz6zk8HMwSoCYw3Ig3ttg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ab8ca6df0bso3187706d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 09:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717085465; x=1717690265;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKTcnR1fDvdy3TfHFtSFnLfFliZBzFl3ZOVtMUHC8vQ=;
 b=f3ffjAlG/R0mvjhg5NQqO7x3XpEOopxvvY5UYjBXTnrohcbtXUzLIgKsGDPUOVe5oj
 99xGGnt41oYvzCOqMVT5CC2CkZVMjQkH8bjOphtM57d750h6fn4yrTm/Vacd3h2BvlEB
 l9bR8zG3ES3mloPV17ZbxhAzp7lqzBZta1IYQQVDXfYiQij2twtTWcABTz8wE439OX2G
 /0l4Rrz1OAKormkU9AGQ1YdEeJQR2Q4HzDXDFgVJwrrRXcqdNZQ/Bk50+oZsxbFtv4jq
 I92tZ1JsZbOkbEYpppbnnqCIGkREv6sUFgIKoDbZ1DgSKWMhE27HamTi1pBNiht1zJcq
 GGpw==
X-Gm-Message-State: AOJu0YzryvwVHEblrbUupYjsG3gOJKun9mN9Buv0eOeLeXB+XAy/NQst
 buz29sTBWfySXzGJTE+IfV5U8cU2C129zU7Xgyy4GjEGywoqlGbHU83hUkV6yGPasrgARd4ObOq
 6icdXJ2Kx/nILITVza1SAJa08SXn6aMUhw4CIU7mmgwIu6QxStMTc
X-Received: by 2002:a05:6214:238d:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6ae0c9a93damr29374576d6.0.1717085464496; 
 Thu, 30 May 2024 09:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPcjH4AjIk83H1XIsPXffzBZxiYOGvc/b4gtb64mMVLDjHiARd245YT0AypeEX/EfaRG6C+Q==
X-Received: by 2002:a05:6214:238d:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6ae0c9a93damr29374026d6.0.1717085463830; 
 Thu, 30 May 2024 09:11:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae2f182939sm2584356d6.2.2024.05.30.09.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 09:11:03 -0700 (PDT)
Date: Thu, 30 May 2024 12:11:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 01/18] migration: Fix file migration with fdset
Message-ID: <ZlilFQYVvHWRCABb@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523190548.23977-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 23, 2024 at 04:05:31PM -0300, Fabiano Rosas wrote:
> When the "file:" migration support was added we missed the special
> case in the qemu_open_old implementation that allows for a particular
> file name format to be used to refer to a set of file descriptors that
> have been previously provided to QEMU via the add-fd QMP command.
> 
> When using this fdset feature, we should not truncate the migration
> file because being given an fd means that the management layer is in
> control of the file and will likely already have some data written to
> it. This is further indicated by the presence of the 'offset'
> argument, which indicates the start of the region where QEMU is
> allowed to write.
> 
> Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
> call, which will take the offset into consideration.
> 
> Fixes: 385f510df5 ("migration: file URI offset")
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Right below the change, did we forget to free the ioc if
qio_channel_io_seek() failed?

> ---
>  migration/file.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index ab18ba505a..ba5b5c44ff 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -84,12 +84,19 @@ void file_start_outgoing_migration(MigrationState *s,
>  
>      trace_migration_file_outgoing(filename);
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY, 0600, errp);
>      if (!fioc) {
>          return;
>      }
>  
> +    if (ftruncate(fioc->fd, offset)) {
> +        error_setg_errno(errp, errno,
> +                         "failed to truncate migration file to offset %" PRIx64,
> +                         offset);
> +        object_unref(OBJECT(fioc));
> +        return;
> +    }
> +
>      outgoing_args.fname = g_strdup(filename);
>  
>      ioc = QIO_CHANNEL(fioc);
> -- 
> 2.35.3
> 

-- 
Peter Xu


