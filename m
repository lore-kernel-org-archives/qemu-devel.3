Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45CECA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iJN-0004sg-DJ; Mon, 22 Sep 2025 11:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iJH-0004rE-HN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iJF-0007gL-B1
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758554311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lkBHMTqqYX/HIussTqxF2XAL1aifvNuoSuAdbLq2bH4=;
 b=A/nvA0VP9V4ctvib+KjGgdhVv0oGnxXpgvUDPSofCo8uf3IMpfKZ0jy8emfMWDVzrcwp70
 MVghaR0CrfqIrWX/pl1SB9FY5bdE9kn3iVinZWOAodzugSe8dQXLGjtlv5XmK42FFnbhku
 v105WfZBFqwNc8lWMx6X3t9VhOus59g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-hhBArT5jOliud5Zf25oAvw-1; Mon, 22 Sep 2025 11:18:30 -0400
X-MC-Unique: hhBArT5jOliud5Zf25oAvw-1
X-Mimecast-MFC-AGG-ID: hhBArT5jOliud5Zf25oAvw_1758554309
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so2176463f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554308; x=1759159108;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkBHMTqqYX/HIussTqxF2XAL1aifvNuoSuAdbLq2bH4=;
 b=h6V1An66SSdTB11FwxOvUzPkQ8X1QK1swdyDSMlnb0KNfdxDr27jGPDuUmlGWHk9OR
 Yiha4CTGmR1fXdNUWqp54hPgG/bwUof3aGKU/qtrEC3ibCOTdT6AFuRk3onFfHnbQc9E
 rIKhlZC+DD+LuGvfXxnErHhsfvVenO9oIJySSuZu+Rkw0Ng9CwLgYnEjEu0xBXGGHVWv
 8W6IQEerfGn5Bf69L3XmsDpBcLEXVQrvd+OugAs6cGZieMtgI1vULjgl4XmhMoskhIHF
 VfBMhhdhP/aKFMyQ5xD2cgeWqvlrzAdyvdbPwH1A6dSwXL6gSjU1irHDnXNfY4bYdgVJ
 NnNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzI7qa/b6wMNreS4FUZ0WSS5JyqBPV2hMu8inEZC1+AoZTpvoQVSB73/H5FEvqE3I6meY7Wb3y79OB@nongnu.org
X-Gm-Message-State: AOJu0YysTVDfBxBxBIMl2vNApnS2NfKk+vYyzCAq2HIGrY1goI4Ho6qh
 /RLOYQ21k3y6ebN5dr8d9Y3xh9+FCAunx58Ny/PVgASv8RjUC7hSRPw+86Iv75vM3V1GWxORSjO
 GXfMUaV+JK7n7my/e44VAXVW0omPLOpCwzNkepUO770oEJd6Np7q7VvnL
X-Gm-Gg: ASbGnctnTH4RFkPlwj8UxcNKwzPwMiuMu57rr/RTurfaZE+tAo6Y9VSAZFfwmh/2SKt
 zNpWe7Y+wlNnqhOulzso3NWEO3hearmgw0MVJYL9o0CfsFjI+eMTGXm/7jWSVJOnyheF5c0NgL4
 l0UFrF7RQHidN4sPIfcVTJLldS4C+IjlpVw3NyFlFrY1sf8jEdLZL6Fuq//ROmBUcO/CUNx/Rt4
 +xoc/Z4vSQ0nKpYyIteR8G3k+wAtNw/DFUGo9g+X0C7OHBvkrhVA+8KifE7fPx9pY1U2QGsIL96
 HN6HFCtteRv7jpytJ+LN8dZCxnuPhISFVgUXSZqxFVr4kxdegC5GPbT7o28xRudGFL0NkS/TnXN
 xhGc=
X-Received: by 2002:adf:9bc7:0:b0:3f6:9c5a:e202 with SMTP id
 ffacd0b85a97d-3f69c5ae5bemr4976297f8f.24.1758554308503; 
 Mon, 22 Sep 2025 08:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQuObb/VqD3yGXjNjsSt4QsTAx+NpHxZVUNzEU6m8rvHy5kFm79iDGcMBMMYx5uz5Oe0ZGuQ==
X-Received: by 2002:adf:9bc7:0:b0:3f6:9c5a:e202 with SMTP id
 ffacd0b85a97d-3f69c5ae5bemr4976262f8f.24.1758554307920; 
 Mon, 22 Sep 2025 08:18:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbf1d35sm21569808f8f.55.2025.09.22.08.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:18:27 -0700 (PDT)
Message-ID: <d5731248-c3f8-413b-a2bd-3326df7e65f3@redhat.com>
Date: Mon, 22 Sep 2025 17:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/8] migration: multi-mode notifier
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-2-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1758548985-354793-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/22/25 15:49, Steve Sistare wrote:
> Allow a notifier to be added for multiple migration modes.
> To allow a notifier to appear on multiple per-node lists, use
> a generic list type.  We can no longer use NotifierWithReturnList,
> because it shoe horns the notifier onto a single list.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/migration/misc.h | 12 ++++++++++
>   migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index a261f99..592b930 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>                                    MigrationNotifyFunc func, MigMode mode);
>   
> +/*
> + * Same as migration_add_notifier, but applies to all @mode in the argument
> + * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
> + * the notifier is added for all modes.
> + */
> +void migration_add_notifier_modes(NotifierWithReturn *notify,
> +                                  MigrationNotifyFunc func, MigMode mode, ...);
> +
> +/*
> + * Remove a notifier from all modes.
> + */
>   void migration_remove_notifier(NotifierWithReturn *notify);
> +
>   void migration_file_set_error(int ret, Error *err);

I think the include/migration/misc.h file should be updated with
proper documentation, like found in include/migration/blocker.h.

>   
>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d..08a98f7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -74,11 +74,7 @@
>   
>   #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>   
> -static NotifierWithReturnList migration_state_notifiers[] = {
> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
> -    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
> -};
> +static GSList *migration_state_notifiers[MIG_MODE__MAX];
>   
>   /* Messages sent on the return path from destination to source */
>   enum mig_rp_message_type {
> @@ -1665,23 +1661,51 @@ void migration_cancel(void)
>       }
>   }
>   
> +static int get_modes(MigMode mode, va_list ap);
> +
> +static void add_notifiers(NotifierWithReturn *notify, int modes)
> +{
> +    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> +        if (modes & BIT(mode)) {
> +            migration_state_notifiers[mode] =
> +                g_slist_prepend(migration_state_notifiers[mode], notify);
> +        }
> +    }
> +}
> +
> +void migration_add_notifier_modes(NotifierWithReturn *notify,
> +                                  MigrationNotifyFunc func, MigMode mode, ...)
> +{
> +    int modes;
> +    va_list ap;
> +
> +    va_start(ap, mode);
> +    modes = get_modes(mode, ap);
> +    va_end(ap);

No sanity check needed ? Could we have conflicting modes ? Just asking.


Thanks,

C.



> +    notify->notify = (NotifierWithReturnFunc)func;
> +    add_notifiers(notify, modes);
> +}
> +
>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>                                    MigrationNotifyFunc func, MigMode mode)
>   {
> -    notify->notify = (NotifierWithReturnFunc)func;
> -    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
> +    migration_add_notifier_modes(notify, func, mode, -1);
>   }
>   
>   void migration_add_notifier(NotifierWithReturn *notify,
>                               MigrationNotifyFunc func)
>   {
> -    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
> +    migration_add_notifier_modes(notify, func, MIG_MODE_NORMAL, -1);
>   }
>   
>   void migration_remove_notifier(NotifierWithReturn *notify)
>   {
>       if (notify->notify) {
> -        notifier_with_return_remove(notify);
> +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> +            migration_blockers[mode] =
> +                g_slist_remove(migration_state_notifiers[mode], notify);
> +        }
>           notify->notify = NULL;
>       }
>   }
> @@ -1691,13 +1715,23 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>   {
>       MigMode mode = s->parameters.mode;
>       MigrationEvent e;
> +    NotifierWithReturn *notifier;
> +    GSList *elem, *next;
>       int ret;
>   
>       e.type = type;
> -    ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
> -                                           &e, errp);
> -    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
> -    return ret;
> +
> +    for (elem = migration_state_notifiers[mode]; elem; elem = next) {
> +        next = elem->next;
> +        notifier = (NotifierWithReturn *)elem->data;
> +        ret = notifier->notify(notifier, &e, errp);
> +        if (ret) {
> +            assert(type == MIG_EVENT_PRECOPY_SETUP);
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
>   }
>   
>   bool migration_has_failed(MigrationState *s)


