Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763A7CFA460
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3gzg-0004oI-1l; Wed, 23 Oct 2024 15:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3gzd-0004nY-RP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3gzb-0007q9-7L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729711561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnabi7S/+grDkXYXLiGY87Dq8lZtHPjRx+mpEZqnyMo=;
 b=PSeoqobdxszzqAmJAqSdSgeii6z65hoo7Wm2x2kqTzpMxu9rUAGPGNNqYpHomVBgj9NB5M
 Kufh8WqXuGlRdLawH/wd1eWThOKnYyAjjMUdKYlnYD1bXZ4xDEPLmvtfSH4cm4D+Uzsaoa
 IAwkoIK7HT/zRO9zLjTX9pjK+EaXllg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-CtnxRH7WN-Sd2Gxz4_tJHA-1; Wed, 23 Oct 2024 15:25:59 -0400
X-MC-Unique: CtnxRH7WN-Sd2Gxz4_tJHA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71803f0a377so230992a34.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729711558; x=1730316358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnabi7S/+grDkXYXLiGY87Dq8lZtHPjRx+mpEZqnyMo=;
 b=i7zLaW4sDxpQbmvnk8H004kgRN2h27fOuVDNGFqRe29QAiKWmN1GNgVjvVrjoWd/sS
 vWl3xBQnNVhIkxhI8BRid/qDTNZRNZXnR8moGFWNb8xZRkOdMNQ2jM63WMqFxhpBhc6z
 w7wmhvAcOrF745asMsQrlcs0u7P0MPGTufVAEpbXSb2XgM3GSD37sEw5motpNXqXMMv7
 1HHkcqY+Q1yZJpFnorx8JDI5TIveQRFvBM3MIlQJncknJM5FvaXIIrlq3EI7Tl/wQCSh
 7l7VUKhmgMRf6H2bZNdBJNmqmeXxdzhYJuH6XmE4qgVxqeyHGALZl/zHXZq/Xfd+R69q
 U/EQ==
X-Gm-Message-State: AOJu0YxQQraESPOoOQ7uqZ5L2y6VQq6GlaSIHIadm6/pCT6J/ezXMMh2
 DIK1xBMR1YVPmHMQ6pyQafyH/uKS6SelIvosBb9zXNo9hML2kRu3taSHrOOtD6AItugDgh2ReIx
 AHLJZrwivG/RSU4gQ7LcmykcpA+hQ6tIjOzcATehdYmf8o41TmLHuytaGgcWge0IGoCSmY27e4G
 RN/wKkL84QOGNK3SecPA0F0NlahCHbPhcqBQ==
X-Received: by 2002:a05:6830:620f:b0:718:1090:3d10 with SMTP id
 46e09a7af769-7184b33d935mr4030431a34.26.1729711557734; 
 Wed, 23 Oct 2024 12:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFORw7N9ckqpLDd0xs6lgqYaentHjfigOwElPT019GDa4RiFy9Ygdd9nWJ062y2c64nOeGPvA==
X-Received: by 2002:a05:6830:620f:b0:718:1090:3d10 with SMTP id
 46e09a7af769-7184b33d935mr4030404a34.26.1729711557317; 
 Wed, 23 Oct 2024 12:25:57 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008acc74sm42270426d6.21.2024.10.23.12.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 12:25:56 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:25:54 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] Migration: Make misc.h helpers available for
 whole VM lifecycle
Message-ID: <ZxlNwoyaJ6mya8_H@x1n>
References: <20241023180216.1072575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Wed, Oct 23, 2024 at 02:02:12PM -0400, Peter Xu wrote:
> This is a follow up of below patch from Avihai as a replacement:
> 
> https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/
> 
> This is v2 of the series, and it became a more generic rework on how we do
> migration object refcounts, so I skipped a changelog because most of this
> is new things.
> 
> To put it simple, now I introduced another pointer to migration object, and
> here's a simple explanation for both after all change applied (copy-paste
> from one of the patch):
> 
> /*
>  * We have two pointers for the global migration objects.  Both of them are
>  * initialized early during QEMU starts, but they have different lifecycles.
>  *
>  * - current_migration
>  *
>  *   This variable reflects the whole lifecycle of the migration object
>  *   (which each QEMU can only have one).  It is valid until the migration
>  *   object is destroyed.
>  *
>  *   This is the object that internal migration so far use.  For example,
>  *   internal helper migrate_get_current() references it.
>  *
>  *   When all migration code can always pass over a MigrationState* around,
>  *   this variable can logically be dropped.  But we're not yet there.
>  *
>  * - global_migration
>  *
>  *   This is valid only until the migration object is still valid to the
>  *   outside-migration world (until migration_shutdown()).
>  *
>  *   This should normally be always set, cleared or accessed by the main
>  *   thread only, rather than the migration thread.
>  *
>  *   All the exported functions (in include/migration) should reference the
>  *   exported migration object only to avoid race conditions, as
>  *   current_migration can be freed concurrently by migration thread when
>  *   the migration thread holds the last refcount.
>  */
> 
> It allows all misc.h exported helpers to be used for the whole VM
> lifecycle, so as to never crash QEMU with freed migration objects.
> 
> Thanks,
> 
> Peter Xu (4):
>   migration: Unexport dirty_bitmap_mig_init() in misc.h
>   migration: Reset current_migration properly
>   migration: Add global_migration
>   migration: Make all helpers in misc.h safe to use without migration
> 
>  include/migration/misc.h | 29 ++++++++----
>  migration/migration.h    |  4 ++
>  migration/migration.c    | 99 +++++++++++++++++++++++++++++++++++-----
>  3 files changed, 113 insertions(+), 19 deletions(-)

Sent too soon. This breaks device-introspect-test.. Sorry.  I'll look at
that and repost.

Meanwhile please still comment on the idea, especially when one disagrees.

-- 
Peter Xu


