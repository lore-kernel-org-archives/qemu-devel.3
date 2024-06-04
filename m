Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 20:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEb3R-0004SP-KB; Tue, 04 Jun 2024 16:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEb3Q-0004S9-Qy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEb3O-0000cw-Ic
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717534005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uShycdVSvLWIP7yFPm//D68AtsXMhXWkVuBQ9PWUCZY=;
 b=hLgOPHVJKeYDV5R5GnJVNhuqHTghrFcnMznt2sr+SPc65Ur6KNIcElmFNoFWk+BY5exESm
 wexKYil14gwlWTU5m17HEBqddxZlmIvi9gxR0nySpNgGPDexc+/aFhZdp/UB/ccL6fDGew
 w9dtLZfX0UB6QIVMn0r/1tCz2IKThWA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-5wz2pLeDMRWwTMN0Ggo8hw-1; Tue, 04 Jun 2024 16:46:42 -0400
X-MC-Unique: 5wz2pLeDMRWwTMN0Ggo8hw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ae3c7688f6so9471526d6.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 13:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717534002; x=1718138802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uShycdVSvLWIP7yFPm//D68AtsXMhXWkVuBQ9PWUCZY=;
 b=Dns5yldJMp0feouakV9q2wLuXbLSUq+PpPlk5gNRwpWVlnsaQnd8vG9TRRoU+xzX63
 /FCSaVanKSE5+4/l/BKuwWSamwD9lqoPB5YuXEeCRrjbHm8yn0LAi2l1y8AF54RVWIjM
 MwkpN/a8qECARUP3VgBkNrI+2skgnr/+zW3hK2mf8oa+qaFU2XariGYasizYOqZoGQbE
 1wr+K1VOyUq5TuVfWagHHvTJaVqdYSYw6thscEkBskdWku0p0BZfkYy2rzr5GTpWPwYW
 4TDUFMeeeOVDouH8hfDB8GQ6VDPo4IiT9FeLtsOP9dp0RgG8gYNVqj5GOVASYI66KWOC
 uwIA==
X-Gm-Message-State: AOJu0YxWbOO6LE/slvKx09xWjeko4KDHXRK+x5KJrLUzGNvtGNqZQv8S
 jwEygrQnXBIYiUx7jwcfrwu44QyI4fIKBhGALDyeH0hnITIuCn8rBXgXSmvJuSvkhipjdn/3dhV
 /4d2SfRcYbJQ9XeegnUVaDbc5ntd2myu2gj7dC5q6deWI4MBuqjBW
X-Received: by 2002:a05:620a:2584:b0:793:1840:b832 with SMTP id
 af79cd13be357-795240f3cf6mr43807885a.6.1717534001495; 
 Tue, 04 Jun 2024 13:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbXS99qnzBx4thhMvhZXnbKUZHjP1RN+ecerIyyyyb9TPu1QAFIWQja7kbfDLwTDXZj6Kh+g==
X-Received: by 2002:a05:620a:2584:b0:793:1840:b832 with SMTP id
 af79cd13be357-795240f3cf6mr43804585a.6.1717534000658; 
 Tue, 04 Jun 2024 13:46:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f2efc70asm392712785a.17.2024.06.04.13.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 13:46:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:46:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 14/18] migration: Add documentation for fdset with
 multifd + file
Message-ID: <Zl99JvararmD5bNW@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, May 23, 2024 at 04:05:44PM -0300, Fabiano Rosas wrote:
> With the last few changes to the fdset infrastructure, we now allow
> multifd to use an fdset when migrating to a file. This is useful for
> the scenario where the management layer wants to have control over the
> migration file.
> 
> By receiving the file descriptors directly, QEMU can delegate some
> high level operating system operations to the management layer (such
> as mandatory access control). The management layer might also want to
> add its own headers before the migration stream.
> 
> Document the "file:/dev/fdset/#" syntax for the multifd migration with
> mapped-ram. The requirements for the fdset mechanism are:
> 
> - the fdset must contain two fds that are not duplicates between
>   themselves;
> 
> - if direct-io is to be used, exactly one of the fds must have the
>   O_DIRECT flag set;
> 
> - the file must be opened with WRONLY on the migration source side;
> 
> - the file must be opened with RDONLY on the migration destination
>   side.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/devel/migration/main.rst       | 24 +++++++++++++++++++-----
>  docs/devel/migration/mapped-ram.rst |  6 +++++-
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 495cdcb112..784c899dca 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -47,11 +47,25 @@ over any transport.
>    QEMU interference. Note that QEMU does not flush cached file
>    data/metadata at the end of migration.
>  
> -In addition, support is included for migration using RDMA, which
> -transports the page data using ``RDMA``, where the hardware takes care of
> -transporting the pages, and the load on the CPU is much lower.  While the
> -internals of RDMA migration are a bit different, this isn't really visible
> -outside the RAM migration code.
> +  The file migration also supports using a file that has already been
> +  opened. A set of file descriptors is passed to QEMU via an "fdset"
> +  (see add-fd QMP command documentation). This method allows a
> +  management application to have control over the migration file
> +  opening operation. There are, however, strict requirements to this
> +  interface if the multifd capability is enabled:
> +
> +    - the fdset must contain two file descriptors that are not
> +      duplicates between themselves;
> +    - if the direct-io capability is to be used, exactly one of the
> +      file descriptors must have the O_DIRECT flag set;
> +    - the file must be opened with WRONLY on the migration source side
> +      and RDONLY on the migration destination side.
> +
> +- rdma migration: support is included for migration using RDMA, which
> +  transports the page data using ``RDMA``, where the hardware takes
> +  care of transporting the pages, and the load on the CPU is much
> +  lower.  While the internals of RDMA migration are a bit different,
> +  this isn't really visible outside the RAM migration code.
>  
>  All these migration protocols use the same infrastructure to
>  save/restore state devices.  This infrastructure is shared with the
> diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
> index fa4cefd9fc..e6505511f0 100644
> --- a/docs/devel/migration/mapped-ram.rst
> +++ b/docs/devel/migration/mapped-ram.rst
> @@ -16,7 +16,7 @@ location in the file, rather than constantly being added to a
>  sequential stream. Having the pages at fixed offsets also allows the
>  usage of O_DIRECT for save/restore of the migration stream as the
>  pages are ensured to be written respecting O_DIRECT alignment
> -restrictions (direct-io support not yet implemented).
> +restrictions.
>  
>  Usage
>  -----
> @@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
>  Mapped-ram migration is best done non-live, i.e. by stopping the VM on
>  the source side before migrating.
>  
> +For best performance enable the ``direct-io`` capability as well:

Parameter?

> +
> +    ``migrate_set_capability direct-io on``

migrate_set_parameters?

If with that fixed:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


