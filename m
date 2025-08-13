Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E31AC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 20:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umIQg-00020k-6K; Wed, 13 Aug 2025 16:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIQd-00020R-L2
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umIQY-0007Eg-2t
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755118225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/JxizR82w/DoICaY4CyUsLkuuMXxRpNQH3evcKuSyM=;
 b=eJB8AzTK9DdjvGqD8PJ6DBHNlv3Csqf3eKjX2yp0Mxe6TuQP9sgJx1K5BZ2Kvl5N0BYyzS
 D0pMPXLhCLs93W12PiZQvXdDc/fzaH4rOZPKVIR4JYR8M+1l1lBwZmEJ3bDF1I8g5mL/aW
 hOqLvqWJhpUoHTl32gR4Vqdtii5JEBM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-MNmRISGRPreKDsJ7p5Beww-1; Wed, 13 Aug 2025 16:50:24 -0400
X-MC-Unique: MNmRISGRPreKDsJ7p5Beww-1
X-Mimecast-MFC-AGG-ID: MNmRISGRPreKDsJ7p5Beww_1755118224
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71d605e421dso4317777b3.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 13:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118224; x=1755723024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/JxizR82w/DoICaY4CyUsLkuuMXxRpNQH3evcKuSyM=;
 b=Uin/jB2LzQKaN3BPcOUyVv8bhPGUXwJwLsAsg8zx2e9RROThqTsmIaYqmcGN7ECk/E
 DXuhln/d74FD//RcSP5R2K7LVKcWz6S9hCqQVlEkGPi9U4M3KjPt8B4epVUpSnQGVx5V
 /AXsSD62JNfknYMre23ywevbK6JDdRJhnsjPhYxZ+6icn36oJFg0JAfLyYPzlXcOnL7r
 rYy9q56HkTYPjc+BeitjYPBQElK113RVDTmtXLptTPObE+mGxiUBrCIVqHm5ArqN13tB
 mS1yK3rH2fPyunynXwFXaANHgKATHsesZqF9HKHERpt8D5Ldg8Oorniu81SCckUI//U+
 Rvhg==
X-Gm-Message-State: AOJu0YyNJ4gU668MawE1vH4w5wrN6RaOm61/L14xeO9xSu8wE5OoVfL3
 Z3OqMhBQiE1al49MDcgmfd3L3uzNjrrqDQdgDQisJ4q4j6zcofTl8//2HHorri3E5SUHlbfXTSw
 IjB7exUTqNddMSJP59F2QV99UkNjBoN513pKzoKXVLPsKKFlAi7+ei8rw
X-Gm-Gg: ASbGncuuRH+vsUfvW18ZPX/pesRSg9pdz5oilA2PY2foHdykMRc4/EedXAbDqjpIdlq
 MnKbVnvJzPTaqiyHVqAteNyy7QSoOxsrRNdt2pybiEyVxCr9pjRv8L7yns/KTtJxAnsZgLhvBQI
 cswwqpmqe7O31rLeoiuLjlfjBD6k2wIaU5P+yrlO1H1/vSRRUg6lIq5HT8kJZdTI559ZioIhUUU
 kadJrKh2eYcBYKz+vH6ml7Zw/0sjl+jcFWG+ZIQUwJ9bIRS91ufA1wC6DNSyk58qkwvXZJKfudy
 OQ9uQMTbUWdPaqhibav0NzfdreILk3rwQyMikmnloA1SA2RgieorLD/O6j3ZYwDRiQRuw0U0qtE
 1x2/iJOiTULyJwhJACQw7tg==
X-Received: by 2002:a05:690c:6483:b0:71c:7eb:3556 with SMTP id
 00721157ae682-71d634347a8mr4332617b3.15.1755118223796; 
 Wed, 13 Aug 2025 13:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV8q20At0nmjYToCWATHBENvTbp9Su+jk5ChRP9w3KXr3gjN77H6g6AJbOzmS6tfD/63HO4w==
X-Received: by 2002:a05:690c:6483:b0:71c:7eb:3556 with SMTP id
 00721157ae682-71d634347a8mr4332447b3.15.1755118223487; 
 Wed, 13 Aug 2025 13:50:23 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d60d8d670sm1589917b3.28.2025.08.13.13.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:50:22 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:50:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 devel@lists.libvirt.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 18/24] qapi/migration: Deprecate capabilities commands
Message-ID: <aJz6jF-CR-qqmDBJ@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 30, 2025 at 04:59:07PM -0300, Fabiano Rosas wrote:
> The concept of capabilities is being merged into the concept of
> parameters. From now on, the commands that handle capabilities are
> deprecated in favor of the commands that handle parameters.
> 
> Affected commands:
> 
> - migrate-set-capabilities
> - query-migrate-capabilities
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst      | 12 ++++++++++++
>  migration/migration-hmp-cmds.c |  6 ++++++
>  qapi/migration.json            | 16 ++++++++++++++--
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 42037131de..15474833ea 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -605,3 +605,15 @@ command documentation for details on the ``fdset`` usage.
>  
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +``migrate-set-capabilities`` command (since 10.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +This command was deprecated. Use ``migrate-set-parameters`` instead
> +which now supports setting capabilities.
> +
> +``query-migrate-capabilities`` command (since 10.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''

Don't forget to update the versions.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


