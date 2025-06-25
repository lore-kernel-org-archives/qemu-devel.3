Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18457C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUO4q-0006y0-If; Wed, 25 Jun 2025 07:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uUO4o-0006xq-TD
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uUO4j-0004gn-TI
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750850035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UoDexJdJ84RSr0qybJ+g66Wmp4M6sI3qTppitE0fOnY=;
 b=F9vyP+wuPw10oXYnUkJy33FPrsFzxLf1JwjrYkij2dg01+83mQnuia0ur51JUjinAz4ygg
 M7cz+c4r5NwUUB5JV6I4XyGFiOiJ18INV+t3pL3CUPivIEV0A3Xu20VZ7wyoX8u8WHNgeF
 KT5xEEowbkRmfjGm8C3Uv7QkvHMlqzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-LSqjqRBoMmawny2YeOHU-Q-1; Wed, 25 Jun 2025 07:13:53 -0400
X-MC-Unique: LSqjqRBoMmawny2YeOHU-Q-1
X-Mimecast-MFC-AGG-ID: LSqjqRBoMmawny2YeOHU-Q_1750850033
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so3480333f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 04:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750850032; x=1751454832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoDexJdJ84RSr0qybJ+g66Wmp4M6sI3qTppitE0fOnY=;
 b=OxDHkTNzqglPykTWoGY6ng64X7S1q3H7HpJZ6U37AuMU05IRtWw9A4idVcs8jFse03
 dgpUG+s/X/g0x1g7fW4g8gsWd3kKbQCmrkPr8iLD0opAsgg82LccuX1xGC5t7vZiuAN8
 OGTvgKjY3eh1bPDnjM5EPAMHUIqEFdtgmWEXXnSZlrcM4FO7gOn6K+txAWmIVZJrRFn0
 qXsTBRSp8v5u0ZB1JQtuzqiikEnBtqUNQIk6A6FePtiUuBKJiKMentmc6FY26NQNMGN7
 BATnGs1i3ZxU67hZ4MIkTQ7p9nbEaF092vYlexxBsxpcFudt+D+0W0xSScM9AseOxkR4
 tXWQ==
X-Gm-Message-State: AOJu0YzwtP7fCUz7zLr8u4wxy/ltMzB2VF+HeWPx5r9WvfYzTgBh0OpU
 /OdRzoaLO0dFFOx1GXl5NjlgyM5YnzLNHCc3ESpUU7iYwLMjkZH5iOWpFtDsjViKNbfMOS5gk3O
 cPzbH00AxR+LT43LmwcrsT8yceqaHKl8c0FxioxwOA5qSRpgRtMHEBGwV
X-Gm-Gg: ASbGncupOSe6+szgSV/I7sAE2jGkogN14yxBCtlADrBJMo8l5ldejAEaTqgI2SLL4Kp
 lfrRlqjDtU/E9xcjqq/JfxE6G4tvw9fMVO1asqkUa3vsKFNU17IyFq060XMq5py0Tr+tSHQko5T
 FZTb9oege+puc1vpa/RdNlmakPyGn9BHOYvoDr5sjYiV+sQXUBpVccIOp/lYYhVUjcAav9M/tXx
 Pvkef6GZMgxgNnU0HMxYIwyeFj4vnGQghvz4cWSbEUkHtNh/077wL1xfxrFpi1Y39nIBcLBsW0B
 ULlX4G8or9in0e1HLucDsSGAYlvPQQNc5auZwA==
X-Received: by 2002:a5d:5f01:0:b0:3a5:1c3c:8d8d with SMTP id
 ffacd0b85a97d-3a6ed652db1mr1882239f8f.55.1750850032503; 
 Wed, 25 Jun 2025 04:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuA+tBNuFsStdF0KTa2We+nPhJVPxCBIUBlKouWepueAUY04vyEs0amwvTmQyVkaj7r4GOEQ==
X-Received: by 2002:a5d:5f01:0:b0:3a5:1c3c:8d8d with SMTP id
 ffacd0b85a97d-3a6ed652db1mr1882159f8f.55.1750850031125; 
 Wed, 25 Jun 2025 04:13:51 -0700 (PDT)
Received: from fedora (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45380705351sm23534125e9.0.2025.06.25.04.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 04:13:50 -0700 (PDT)
Date: Wed, 25 Jun 2025 13:13:48 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Message-ID: <5wyhdft4ucul4wehkq76im56jkixfmyxrfrhezzjnf7qnkmu7i@e73pvqathnom>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-7-peterx@redhat.com>
 <oo4t2s5rz4uaivfm3vejlum5c7efsjiysbavtt24rinoefs2tk@ihtornpsiz5q>
 <aFrHF4hKTdAgRpfs@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFrHF4hKTdAgRpfs@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-06-24 11:41, Peter Xu wrote:
> On Tue, Jun 24, 2025 at 04:36:39PM +0200, Juraj Marcin wrote:
> 
> [...]
> 
> > There are still mentions of 'save_live_complete_precopy' in:
> > 
> >     include/migration/register.h:100
> >         * parallel with @save_live_complete_precopy handlers.
> >     docs/devel/migration/vfio.rst:78
> >         * A ``save_live_complete_precopy`` function that sets the VFIO device in
> >     docs/devel/migration/vfio.rst:198
> >         .save_live_complete_precopy() is called for each active device
> >     docs/devel/migration/vfio.rst:200
> >         .save_live_complete_precopy() until
> >     docs/devel/migration/main.rst:511
> >         - A ``save_live_complete_precopy`` function that must transmit the
> 
> Good catch.  If I prepare this fixup to be squashed, can I get your R-b?

Yes, with the fixup it looks good.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

> 
> From 58147b11276fa193c25f35e63f41a8e34d444dd9 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 24 Jun 2025 11:38:17 -0400
> Subject: [PATCH] fixup! migration: Rename save_live_complete_precopy to
>  save_complete
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/main.rst |  4 ++--
>  docs/devel/migration/vfio.rst | 12 ++++++------
>  include/migration/register.h  |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index cdd4f4a6d7..6493c1d2bc 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -508,8 +508,8 @@ An iterative device must provide:
>      the point that stream bandwidth limits tell it to stop.  Each call
>      generates one section.
>  
> -  - A ``save_live_complete_precopy`` function that must transmit the
> -    last section for the device containing any remaining data.
> +  - A ``save_complete`` function that must transmit the last section for
> +    the device containing any remaining data.
>  
>    - A ``load_state`` function used to load sections generated by
>      any of the save functions that generate sections.
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 673e354754..8ff5ab0c74 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -75,10 +75,10 @@ VFIO implements the device hooks for the iterative approach as follows:
>    in the non-multifd mode.
>    In the multifd mode it just emits either a dummy EOS marker.
>  
> -* A ``save_live_complete_precopy`` function that sets the VFIO device in
> -  _STOP_COPY state and iteratively copies the data for the VFIO device until
> -  the vendor driver indicates that no data remains.
> -  In the multifd mode it just emits a dummy EOS marker.
> +* A ``save_complete`` function that sets the VFIO device in _STOP_COPY
> +  state and iteratively copies the data for the VFIO device until the
> +  vendor driver indicates that no data remains.  In the multifd mode it
> +  just emits a dummy EOS marker.
>  
>  * A ``save_live_complete_precopy_thread`` function that in the multifd mode
>    provides thread handler performing multifd device state transfer.
> @@ -195,9 +195,9 @@ Live migration save path
>                                        |
>                  Then the VFIO device is put in _STOP_COPY state
>                       (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
> -         .save_live_complete_precopy() is called for each active device
> +               .save_complete() is called for each active device
>                For the VFIO device: in the non-multifd mode iterate in
> -                        .save_live_complete_precopy() until
> +                             .save_complete() until
>                                 pending data is 0
>  	          In the multifd mode this iteration is done in
>  	          .save_live_complete_precopy_thread() instead.
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 0510534515..2a26e76a68 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -103,7 +103,7 @@ typedef struct SaveVMHandlers {
>       * Called at the end of a precopy phase from a separate worker thread
>       * in configurations where multifd device state transfer is supported
>       * in order to perform asynchronous transmission of the remaining data in
> -     * parallel with @save_live_complete_precopy handlers.
> +     * parallel with @save_complete handlers.
>       * When postcopy is enabled, devices that support postcopy will skip this
>       * step.
>       *
> -- 
> 2.49.0
> 
> 
> > 
> > Also, should we also drop "live" from
> > 'save_live_complete_precopy_thread' as well? IIUC they are called
> > together with (now) 'save_complete()' during precopy.
> 
> Agreed, though it's better done in a separate one.
> 
> If so, wanna send a patch? :)

Sure, I will send it today.

> 
> PS: would be nice if on top of this series, then I can collect them together.
> 
> Thanks!
> 
> -- 
> Peter Xu
> 


