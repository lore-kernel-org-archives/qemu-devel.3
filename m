Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA6CF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFIb7-0001O9-Ch; Tue, 21 Apr 2026 17:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFIb2-0001Ni-Me
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFIaw-0001yf-R9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776806721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TF7SmzuNr0uCh2qnzcJvYPOs35SdTe4cdaC5L6bTTU=;
 b=iMcJJ7aXXFCzGPYtS/MQSfozIMAwbQLEhUsgeyONmPKYmAmKRny2A2SOaPPbbU5xUruEgs
 YiBRdwVLtMn4BwranFQTQMZMnWx3MT1esJQ2EFzeQ9enm514DVLqPs3joHnF3tJWRy36j6
 bXRmc9l3N4mPkZn2etReNUx7uTKes4U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-MXuLj414OkSCScJ9AAFJDw-1; Tue, 21 Apr 2026 17:25:19 -0400
X-MC-Unique: MXuLj414OkSCScJ9AAFJDw-1
X-Mimecast-MFC-AGG-ID: MXuLj414OkSCScJ9AAFJDw_1776806719
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eabf08affaso777794985a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776806719; x=1777411519; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3TF7SmzuNr0uCh2qnzcJvYPOs35SdTe4cdaC5L6bTTU=;
 b=HVhxdpil9n62mA0Jv7FgPhUSCq47qkspqahdLFMqeHB/sbcLylfUEbCD7CZCYju4bB
 VMDR8j+j8TjFxAofr8xXZNlJLWr85WyGjgDN1NigrE4Cz91RoixMbvGoZV1SZvdATBfZ
 ssAqgiJMXOJzU1Dut3K5JwDmJtPkXUFe1Tu5qAxmFuXCKzhpccYVXyJVB/C2p7Ec3rYB
 3VhWy4coL+YR+/Soqremp5ahsj0FTkyhrkvWpXHnUsdxsZwvnHkmyJ9+NvU7CG4MUIqP
 Jj1q78xGv4UIK3DNpOrMmX9MIccH6mRcRZtKRfEpAyUbySP5CmnnkIth24lnxiTwbSvm
 7ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776806719; x=1777411519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TF7SmzuNr0uCh2qnzcJvYPOs35SdTe4cdaC5L6bTTU=;
 b=gzp2bmYIJ8i0zCclAIfMUTSsq+MsqszeQ6ofOWZTWGCqgeu7roAQLrA6ODmhOj9S0m
 5AClVuRleqP2pCnZAW2F9kZAvPUaQbXOWmDUa7gf3fxqzStKFMh0qDoGpcfaKkl9JAjL
 HW1At3VMJX2eWd9cdTMzsURok4w+xnO3RCoRgwHFEypGgCm7h7RUyrnkolPl2MkN9J0n
 lU8N4fLLIsKMghHKUp03Qxr581dRz5z92WnY7iTuA5ArCZc4V3KF1dtA5boAck3Z70dH
 M9xXhdNmudfY3+HU8Xvg/lefIZMW08Fy05KS17jlLjo2+FVGPKeBRSqiKRo+86ONUaP4
 ZqOw==
X-Gm-Message-State: AOJu0YyFt/tSvM6PbpW3CvlZkeDd7KGVQ6cPp7Za0VERdWOYGNVOT8ET
 EN/xs2KBwF1L8yqJFQl18Sb5L8IgD/3TS3U5Dpb3reMoM93OZu6ehSSKmWSCs/hE3AtlcJoS1Ou
 ol5nxzu0pXOqMq1RQvddQt1fXX8xJmraYgBV+tDeNFxZG7Wz/PaL3L39Y
X-Gm-Gg: AeBDietWapvjJfgCsC6KNYeMOdrAvUwdtI333zHVFsBHVsrgDQ3mwekP5m4T9dLSpbC
 8UAw2Bk3X1f16BcaWuYTNrEtVHtcdetV4JRq7rWAqVymC+LVh0+D7q0aRj3Igk4Yzyue7EJBTlV
 6VtnUPUC12j9SOoRotLiYyJ0+FCUGtybhsZiI8gSIqdeJ6CbFP6RVopsH0f4/qvm51AXw9MMVW3
 iHSl0wXC09tLVf+yRva00f653Eb4O7bEGSiR48q6kL+SJXH4lB6l/v9P/ocPdaQX6aALMgOQMQK
 GD8gSQhkgttcs7T9h2uLB5lsEpMV0Rei2qHcpYqlMXM2JUCRexqcLpAtdsHh+HqocDeNytCCent
 1BMtuWQpRhTr3zrPct8KYVWIaCn7XKdwEbfymMOeCxtCfflA8FSdM2/Vdig==
X-Received: by 2002:a05:620a:2953:b0:8df:6628:3cd1 with SMTP id
 af79cd13be357-8e7913c28fdmr2626927085a.40.1776806718837; 
 Tue, 21 Apr 2026 14:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2953:b0:8df:6628:3cd1 with SMTP id
 af79cd13be357-8e7913c28fdmr2626920785a.40.1776806718158; 
 Tue, 21 Apr 2026 14:25:18 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8eb61bc0d3dsm582502185a.26.2026.04.21.14.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 14:25:17 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:25:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Pranav Tyagi <prtyagi@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
Message-ID: <aefrPBN7k94Jj2dh@x1.local>
References: <20260421052227.8278-1-prtyagi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421052227.8278-1-prtyagi@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 21, 2026 at 10:52:27AM +0530, Pranav Tyagi wrote:
> The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> arrive on the source from the destination in the return path thread. The
> migration thread would then be blocked waiting for package_loaded event
> indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
> source VM can safely resume as the destination has not yet started. The
> pong message can get lost in case of a network failure or destination
> crash before sending the pong.
> 
> This patch uses the error detected in case of network failure or
> destination crash to set the package_loaded event in the out path of the
> return path thread. This will kick the migration thread out from
> a condition of indefinitely waiting for the package_loaded event. The
> migration thread then fails early and breaks from the migration loop to
> resume the VM on the source side.
> 
> Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>

Ah I see.. thanks for figuring this out.

> ---
>  migration/migration.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..1656c1203c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2386,6 +2386,15 @@ out:
>      if (err) {
>          migrate_error_propagate(ms, err);
>          trace_source_return_path_thread_bad_end();
> +        if (ms->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
> +            /*
> +             * Kick the migration thread if it gets stuck in
> +             * POSTCOPY_DEVICE state waiting for
> +             * postcopy_package_loaded_event. The event will never be
> +             * set as MIG_RP_MSG_PONG from the destination is lost.
> +             */
> +            qemu_event_set(&ms->postcopy_package_loaded_event);
> +        }

This makes sense.  Said that, we have another similar case right below for
the postcopy recover path:

    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
        /*
         * this will be extremely unlikely: that we got yet another network
         * issue during recovering of the 1st network failure.. during this
         * period the main migration thread can be waiting on rp_sem for
         * this thread to sync with the other side.
         *
         * When this happens, explicitly kick the migration thread out of
         * RECOVER stage and back to PAUSED, so the admin can try
         * everything again.
         */
        migration_rp_kick(ms);
    }

It achieves some similar goal, where the migration thread is waiting for
some event from return path thread, and when the channel is broken we want
to kick it out.

I'm thinking if we can reuse that, instead of kicking multiple events.

Say, we can do migration_rp_kick() for both POSTCOPY_RECOVER and
POSTCOPY_DEVICE states in the rp thread.  Meanwhile at below..

>      }
>  
>      if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
> @@ -3232,6 +3241,17 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>               * package before actually completing.
>               */
>              qemu_event_wait(&s->postcopy_package_loaded_event);
> +            /*
> +             * Check for errors in case the migration thread was stuck in
> +             * POSTCOPY_DEVICE state waiting for the
> +             * postcopy_package_loaded_event which was never set.
> +             * If so, fail now and break out of the iteration.
> +             */
> +            if (migrate_has_error(s)) {
> +                migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                                  MIGRATION_STATUS_FAILING);
> +                return MIG_ITERATE_BREAK;
> +            }

... instead of waiting on postcopy_package_loaded_event, we can do:

    while (!s->postcopy_package_loaded) {
        if (migration_rp_wait(s)) {
            /* Error happened */
            migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                              MIGRATION_STATUS_FAILING);
            return MIG_ITERATE_BREAK;
        }
    }
    /* Acknowledgement received from dest */
    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                      MIGRATION_STATUS_POSTCOPY_ACTIVE);

PS: I think event also works in this case, so likely either one shared sem
or event should work; it's just that it was a sem before, and rp_sem has a
name that is generic enough to apply directly to the
postcopy_package_loaded_event use case.

Thanks,

>              migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
>                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
>          }
> -- 
> 2.53.0
> 

-- 
Peter Xu


