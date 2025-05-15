Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D2EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFffp-0005M3-Ea; Thu, 15 May 2025 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFffn-0005Lp-Rk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFffm-0008Hn-6c
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747342760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ptKn1OBLdx6WI0wPlKtqIwZnc5jfSZtxXEXK6AMwr1g=;
 b=K4f9m829WYzCcFZCKPOy+HEImYSxOFaY6+RGEGadT5m92t8f7rNrEenMTnt9gVEEsEcZVo
 nlq+guRY0gQIR6GSeCRsbwEe10ao78Ls2SsrgERHu5QRa1kKeF9uCeuxMIshALTcggm1WH
 yq12swmXuQRVrEKTYgcIeNsSgwiKUXs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-48PHfjGOPX-mjX7qAjx-eA-1; Thu, 15 May 2025 16:59:18 -0400
X-MC-Unique: 48PHfjGOPX-mjX7qAjx-eA-1
X-Mimecast-MFC-AGG-ID: 48PHfjGOPX-mjX7qAjx-eA_1747342758
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5d608e6f5so346508985a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747342758; x=1747947558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptKn1OBLdx6WI0wPlKtqIwZnc5jfSZtxXEXK6AMwr1g=;
 b=Lq+8+LaUbJ+pWVBKUSixNx1kd3Xz2gWIhsl4gNY1CR6ZS49zdHU+LVZ+xJBW73JltL
 IjotO7Laz+brOqV7BFwDR7hW0cGG7okns8rzAdHBipqYagkZw8V9fY8cRrwxar4Nw525
 z1k46PZQZK6R/6UM18BrUKzSC6SqQzcdMCUWkN6bMuXA6IlSYFpITtRbHeQLmazymKcB
 mHpMEmwcymhdza+in3ObH52tGZwAsX8oN9eFqoo5LdaJYYA8akgJ1gY++1ZlDQIJ2YOl
 DP2ZBOYgsDku12Ch+x2hPfum7zz3/fBML0uiX0qyrujRhDWLKJh7Z6XcTgCCIQSpUlOE
 AEIg==
X-Gm-Message-State: AOJu0YxeuCG6FQlybgR1ixAvw5eJj6gCZUe8aGV1CG4zlUQwvybZWg5H
 yohPh5q4CkV7sEHI7G8u3bzK8Ut3zNLe/DbFGz+O2cJ+J6AbM0+u+yHklio5mjH6vtKPzCgLORy
 /V6ySOEczpGfQWIfwbBfL0JvnombqMWLaHCS+KCqqtBonHRo4wmivQlin
X-Gm-Gg: ASbGncvhtwzEiCwW8waSLqcbJAG35QLxtUJXNlcRmAkarilD9I/0p/fCvxyUY0svm7C
 Ad21+N2pQ/Jz3AH+yojyGlapcpvetUQ0WPf/vzeK1ynq5LWXZQslK/rn+0Yy3X6vcJBDoAHGope
 gDxGyxylvRcBnIK+o+EYPZyGByUBDK68Y12KdcLL3/3RqJ5EuZP6Vfr+SvTxmT4Z2FAVExaYPjK
 rkLRq03lhx/KErzfPvO/PVFP2crzKFYcoqB/5QbOE8rjkVC/BGpfz5qtoISXiJJTrVaI90E76g2
 AeE=
X-Received: by 2002:a05:620a:4306:b0:7c5:cdb4:6230 with SMTP id
 af79cd13be357-7cd47f12e4amr30680485a.17.1747342758169; 
 Thu, 15 May 2025 13:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEG5IpAfL8uemhQAJODlphLCYEChxnAgBz7iPhXQcUaRb+an7XFWoMxnBpYsMQFIit8Xm4A==
X-Received: by 2002:a05:620a:4306:b0:7c5:cdb4:6230 with SMTP id
 af79cd13be357-7cd47f12e4amr30678785a.17.1747342757740; 
 Thu, 15 May 2025 13:59:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468d220bsm29386485a.108.2025.05.15.13.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:59:17 -0700 (PDT)
Date: Thu, 15 May 2025 16:59:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 04/13] migration: Fix parameter validation
Message-ID: <aCZVolkNMBZb5KvC@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411191443.22565-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 11, 2025 at 04:14:34PM -0300, Fabiano Rosas wrote:
> The migration parameters validation involves producing a temporary
> structure which merges the current parameter values with the new
> parameters set by the user.
> 
> The has_ boolean fields of MigrateSetParameter are taken into
> consideration when writing the temporary structure, however the copy
> of the current parameters also copies all the has_ fields of
> s->parameters and those are (almost) all true due to being initialized
> by migrate_params_init().
> 
> Since the temporary structure copy does not carry over the has_ fields
> from MigrateSetParameters, only the values which were initialized in
> migrate_params_init() will end up being validated. This causes
> (almost) all of the migration parameters to be validated again every
> time a parameter is set, which could be considered a bug. But it also
> skips validation of those values which are not set in
> migrate_params_init(), which is a worse issue.

IMHO it's ok to double check all parameters in slow path.  Definitely not
ok to skip them.. So now the question is, if migrate_params_test_apply() so
far should check all params anyway...

Shall we drop the checking for all has_ there, then IIUC we also don't need
any initializations for has_* in migrate_params_init() here?

So, admittedly s->parameters.has_* is still ugly to be present.. we declare
all of them not used and ignore them always at least in s->parameters.

> 
> Fix by initializing the missing values in migrate_params_init().
> Currently 'avail_switchover_bandwidth' and 'block_bitmap_mapping' are
> affected.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/options.c b/migration/options.c
> index cac28540dd..625d597a85 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -987,6 +987,8 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_mode = true;
>      params->has_zero_page_detection = true;
>      params->has_direct_io = true;
> +    params->has_avail_switchover_bandwidth = true;
> +    params->has_block_bitmap_mapping = true;
>  }
>  
>  /*
> -- 
> 2.35.3
> 

-- 
Peter Xu


