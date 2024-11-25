Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB9BD58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcYu-0007Lk-NW; Mon, 25 Nov 2024 12:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcYs-0007Ia-Pz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFcYq-0001qQ-Ke
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732554462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AP8XbkEUuC8BeAqN8PL1cu9PSN7idF//Sd3vo+DF/4=;
 b=Do7nGmSnaEPS6sp36C1ABnESRomx75Z92pl/qTPGQuccQ6pCWU9Z3wdfOblgvLHNtolnhU
 NXBXIBN9dHKH2WXW4wa8oB/5H1CufVQx2czu3nkpaClDFwndvekdW6s8BhUh5I8Yd0+POr
 ubfpA3nYyIyM71FGcCeXT3tVdv/nDDM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-nF9rOVvINLCQpnz-SHP78A-1; Mon, 25 Nov 2024 12:07:41 -0500
X-MC-Unique: nF9rOVvINLCQpnz-SHP78A-1
X-Mimecast-MFC-AGG-ID: nF9rOVvINLCQpnz-SHP78A
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-841a3f2aebfso86152039f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554460; x=1733159260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AP8XbkEUuC8BeAqN8PL1cu9PSN7idF//Sd3vo+DF/4=;
 b=HrLS8OmfBpA1p3VDkRdiVJTO1DD+BIBoqIAmLXrGcrnAnLL7JXkP2xsdxw7YNeuRWQ
 iydGwrPh+vfCFKsVhcW4zQKL5gwhnI3flo6EgnEecvn8xnH4MpOvwiLELCP/CFR8NjCU
 jhO+XjzeYxQpiOHFhPE9nNZrUZVjUaZC3+W8lCMYIcC0KCJeyXohbIqTYQvS+mVK4mxn
 DdvFxyk/foTaYm00Ob57ZnAw/lsZPPOqMuO71bsa2uy2I3MHcRgaMC8jr4tO1nC4z6dY
 5MQj+KSvWJPRqfUyTnIo6HkAKM9bnGgmKgTLXX+wCfQpnqxn8PDBzF2GQkFjaa3zYTvv
 CJDA==
X-Gm-Message-State: AOJu0Yw46iGkpJKBbuC0Pj9Oi2ohs2eXosN7YpITxp4Qpc0MrxHB6aeh
 KXkYovnBtKe8xl4dt4336rvGdbc9o+4ZBV1FKrezT9wgf+qIVZQdbHifb95KTOP1oW1NJ1o/cVG
 Be6Tl2hOWnVzl9go9oX1QGtic+dSYLqZk4DJwJB5IRNZKnwlqwNpr
X-Gm-Gg: ASbGncs7r93ut8gGmCzIRky/IOw2iqGhhu0o/nPvVF3IcERq0jB++T/4Oker0rTw3qn
 QREEK2BxQu/a161fppRunkjsKTjW8oroN4QBmt6KzVMWt3zWCBCynAm+/iL/qOBqVHZQwIS4pnp
 BuY8rzbLxMWnL+eKZVaXipHV/al6b8TxgZRmqRPBAjC+od26HzJ1yeQONmjs+mtUYIikzwYQrVX
 xCvz1PE/1GzB+Vm2kJr6fea5Sh8arTZ0BetY94SJo9j5uL/vtFytpP7G/g+PkpPlao1rs3crZ96
 XAvT449EVGE=
X-Received: by 2002:a05:6e02:156f:b0:3a7:80ff:4a6e with SMTP id
 e9e14a558f8ab-3a79ae26a72mr113565335ab.11.1732554460189; 
 Mon, 25 Nov 2024 09:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWU3czKdOz4aiklPLAV9l1mhkYhci4xohBNS8R5uzzwaNtviqPFMEUUo7Ku6uv2YW6meA6dA==
X-Received: by 2002:a05:6e02:156f:b0:3a7:80ff:4a6e with SMTP id
 e9e14a558f8ab-3a79ae26a72mr113565095ab.11.1732554459746; 
 Mon, 25 Nov 2024 09:07:39 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2056df4aesm531958173.19.2024.11.25.09.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:07:39 -0800 (PST)
Date: Mon, 25 Nov 2024 12:07:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/5] migration: Activate block devices if VM is paused
 when migrating
Message-ID: <Z0Su2RINKfqRk969@x1n>
References: <20241125144612.16194-1-farosas@suse.de>
 <20241125144612.16194-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241125144612.16194-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Mon, Nov 25, 2024 at 11:46:11AM -0300, Fabiano Rosas wrote:
> Currently a VM that has been target of a migration using
> late-block-activate will crash at the end of a new migration (with it
> as source) when releasing ownership of the disks due to the VM having
> never taken ownership of the disks in the first place.
> 
> The issue is that late-block-activate expects a qmp_continue command
> to be issued at some point on the destination VM after the migration
> finishes. If the user decides to never continue the VM, but instead
> issue a new migration, then bdrv_activate_all() will never be called
> and the assert will be reached:
> 
> bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
> BDRV_O_INACTIVE)' failed.
> 
> Fix the issue by checking at the start of migration if the VM is
> paused and call bdrv_activate_all() before migrating. Even if the
> late-block-activate capability is not in play or if the VM has been
> paused manually, there is no harm calling that function again.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index aedf7f0751..26af30137b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2029,6 +2029,25 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          return false;
>      }
>  
> +    /*
> +     * The VM might have been target of a previous migration. If it
> +     * was in the paused state then nothing will have required the
> +     * block layer to be activated. Do it now to ensure this QEMU
> +     * instance owns the disk locks.
> +     */
> +    if (!resume && runstate_check(RUN_STATE_PAUSED)) {

I hope this will cover all the cases that QEMU could overlook.. or I'm not
sure whether we could invoke bdrv_activate_all() unconditionally, as it
looks like safe to be used if all disks are active already.

I wished we don't need to bother with disk activation status at all,
because IIUC migration could work all fine even if all disks are inactivate
when preparing migration.. hence such change always looks like a workaround
of a separate issue.

> +        Error *local_err = NULL;
> +
> +        g_assert(bql_locked());
> +
> +        bdrv_activate_all(&local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return false;
> +        }
> +        s->block_inactive = false;

This var so far was only used within one migration iteration, and the var
was only set in migration_completion_precopy() so far.  Now we're resetting
it upfront of a migration.  I'm not 100% sure if it's needed, or should be
put somewhere else.

In general, I saw the mention of other places that may also try to
invalidate disks that used to be invalidated.  If that's the case, I wish
we don't need to touch migration code at all, but instead if block layer
can cope with "invalidate on top of invalidated disks" it'll be perfect.

> +    }
> +
>      return true;
>  }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


