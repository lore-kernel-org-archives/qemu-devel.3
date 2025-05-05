Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034A2C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2op-0000td-GU; Mon, 05 May 2025 16:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uC2on-0000t7-FC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uC2ok-0002oA-BK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746478416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzWwBkC8LuDtWy8I+tsKsAszZ1hufFjrZ1ChN//4vmg=;
 b=A2RPZKz2difFvz3ilXq/S+sIenZ8gsqGhuqyQGcHgi71y8WOQI2e7aLeXiSEcqIdlRxlDB
 liWzYYYPzPBLgv5qYbVYAWhJthfW7kwP3t/6qrQgOgNfDs8rD9FwHanWMDUnq4OOzDgZFX
 RyIL/FB90+UVe++m+sDwTfx3Z15EZgw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-0gkFVSLsPBSdVdNPFqLo5A-1; Mon, 05 May 2025 16:53:35 -0400
X-MC-Unique: 0gkFVSLsPBSdVdNPFqLo5A-1
X-Mimecast-MFC-AGG-ID: 0gkFVSLsPBSdVdNPFqLo5A_1746478414
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476c2d1c582so93391001cf.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746478414; x=1747083214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzWwBkC8LuDtWy8I+tsKsAszZ1hufFjrZ1ChN//4vmg=;
 b=X54LrU/fR4ac0yYGTehETv7cxoHEswgSQ/BXxCoAV+GPiq2VUGCC93SRCpdxr2n8yg
 4rAIQgT+WeXcYgZZ6aYUeuOFtuRcFoaQyJoj1suBFkjk3kM2nvPIaFNGkL2cfEgC44Dm
 S0RJGOk8P67W/EYjikGzU9Vr8DeVumjE9Oj0gGlB1X3Osfiq1Y4lJmXXLPBinD+uIlde
 5LCENCgdAfPMl9VoJaeSuQc6foDuXfzW6rxtKnW3sBXXNQesBPFgZwakg/qX6y/IdvmP
 FfPqYgPNOe2061HHiEWlgPdzv2iGSFOVRdTiDGfmYY5FwdjSVI7a2g5gbks4ki6bTGVt
 Z6ig==
X-Gm-Message-State: AOJu0YwAoOHqcJeVenDtPyEwu1bF3gM8JQ3L/U7v0Y6VaODXDMtbB9vs
 LuJFstvnLJ5qVIkZ6ATvJQzAJwPDDS2HuXcNekzzNJ5JbWKJdYHeqrCne2Vdy4Bku02Mx7xwmXu
 /WKS/mknpMk4iX+v1AwNrj2cW01Mw7LjHZ18S7yuJT5LD3TIFCQmk
X-Gm-Gg: ASbGncstuoh64VOXojFYrsVPFNugbWP8K195r+qcW9t2bze95B7NYu2N7B1hlHgVLWO
 sLFedzoczQuVzq2xvrG+u7a7kx0W6OFuSCNDvCt+5AjFDgQqfZANTsOhpTXvPkaTFlB3M6eRIDV
 lbfOoAUztpwKARkK0Xl6m/q5vg1ShrrLLvwCe0RzGFO9uTV0iltoRsCopWsYFdwArSkh2UkYxHK
 Rhzp0YsHagJXA7hHTywvjbu1Ik8PzLcvhURJw1iIjxG0I3qFLEdSAWO8eLzzPvFlPt2jkOHYLZ3
 TUA=
X-Received: by 2002:a05:622a:1302:b0:47a:fb28:8ee4 with SMTP id
 d75a77b69052e-490e2e737aamr13596851cf.22.1746478414633; 
 Mon, 05 May 2025 13:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRPIrciH7hotDsGWrjNO/OFBAoaozJE0v0enYxphcNKb1U4d7sK+4D7vCapirXit4jRzrxKA==
X-Received: by 2002:a05:622a:1302:b0:47a:fb28:8ee4 with SMTP id
 d75a77b69052e-490e2e737aamr13596691cf.22.1746478414346; 
 Mon, 05 May 2025 13:53:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b966c7fcfsm63071911cf.20.2025.05.05.13.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:53:33 -0700 (PDT)
Date: Mon, 5 May 2025 16:53:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] migration: Trivial cleanups for postcopy
Message-ID: <aBklSyqZ39QSPXmf@x1.local>
References: <20250416134356.29879-1-farosas@suse.de>
 <20250416134356.29879-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416134356.29879-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Wed, Apr 16, 2025 at 10:43:56AM -0300, Fabiano Rosas wrote:
> Some general cleanups of silly things that were left behind when
> refactoring code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d46e776e24..89b1de0ab5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2732,19 +2732,15 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      }
>  
>      /*
> -     * in Finish migrate and with the io-lock held everything should
> +     * in FINISH_MIGRATE and with the BQL held everything should
>       * be quiet, but we've potentially still got dirty pages and we
>       * need to tell the destination to throw any pages it's already received
>       * that are dirty
>       */
> -    if (migrate_postcopy_ram()) {
> -        ram_postcopy_send_discard_bitmap(ms);
> -    }
> +    ram_postcopy_send_discard_bitmap(ms);

IIUC it was from:

commit 58110f0acb1a33e2bc60a2f1b26d2690a92e8a14
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Mon Jul 10 19:30:16 2017 +0300

    migration: split common postcopy out of ram postcopy

I need to confess I know nothing about migrate_dirty_bitmaps().. and I
still think the name is not well chosen - migration definitely has its own
dirty bitmap, and it has nothing to do with block layer..

Obviously, it was for postcopy support of block layer stuff, but I don't
know who is using it, how, and when..

Is people using this feature?  Maybe we should have an unit test, and a
doc?  Copying Vladimir.

>  
> -    if (migrate_postcopy_ram()) {
> -        /* Ping just for debugging, helps line traces up */
> -        qemu_savevm_send_ping(ms->to_dst_file, 2);
> -    }
> +    /* Ping just for debugging, helps line traces up */
> +    qemu_savevm_send_ping(ms->to_dst_file, 2);
>  
>      /*
>       * While loading the device state we may trigger page transfer
> @@ -2774,9 +2770,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          goto fail_closefb;
>      }
>  
> -    if (migrate_postcopy_ram()) {
> -        qemu_savevm_send_ping(fb, 3);
> -    }
> +    qemu_savevm_send_ping(fb, 3);
>  
>      qemu_savevm_send_postcopy_run(fb);
>  
> @@ -2807,13 +2801,11 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  
>      migration_downtime_end(ms);
>  
> -    if (migrate_postcopy_ram()) {
> -        /*
> -         * Although this ping is just for debug, it could potentially be
> -         * used for getting a better measurement of downtime at the source.
> -         */
> -        qemu_savevm_send_ping(ms->to_dst_file, 4);
> -    }
> +    /*
> +     * Although this ping is just for debug, it could potentially be
> +     * used for getting a better measurement of downtime at the source.
> +     */
> +    qemu_savevm_send_ping(ms->to_dst_file, 4);
>  
>      if (migrate_release_ram()) {
>          ram_postcopy_migrated_memory_release(ms);
> -- 
> 2.35.3
> 

-- 
Peter Xu


