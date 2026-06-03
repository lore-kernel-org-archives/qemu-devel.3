Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEA6CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsQO-0003vk-SO; Wed, 03 Jun 2026 16:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsQL-0003v3-W6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsQK-0001UB-DB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780519367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qiLXrv+EHVZiaiNusE/0qerEn7/xVuPpn64bFCYX+w=;
 b=fHA59PE8x+26kYaqCjmz87GgJL12zcOiYFbqnW+fAl1NTT065lL5A7yimDqqHHUjdKyxap
 0eUQiuMZDJVgw1/KW16uOVoDn42zYsowheigVuK0r8JdlvA8upreVjlSKrih4G2ICaPBSq
 mHp6uf/8bGTbTPLDCLxLA6x1ZYIT/v0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Z83yfcQAMWu74jcg6BQ0jg-1; Wed, 03 Jun 2026 16:42:46 -0400
X-MC-Unique: Z83yfcQAMWu74jcg6BQ0jg-1
X-Mimecast-MFC-AGG-ID: Z83yfcQAMWu74jcg6BQ0jg_1780519366
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so109764836d6.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780519366; x=1781124166; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/qiLXrv+EHVZiaiNusE/0qerEn7/xVuPpn64bFCYX+w=;
 b=DYDDUAjGuzW539BiooIT3ugf39EYFkH6wn4JA99rWRaXOzQiNoVTkJ6y1St/ZsKrpk
 ZhkS/REOUpJ3WZopLeOHt1qeAszojP4KJVTelGR9nWBurQcFoABj+JdLpFktG/fMyEi6
 P2uOYR4kj+YiXTqrroZpmjMzDJKUgbx5CnvTvpTOVTOIEMVFVw8AfQB9cwpS+Xwl4wut
 Q1CYLWCTRmIYDn3a3gHiAbz/C9CKVNtoPUH5SLBOF0nhdAE8goLMwAxHlti+GNGtjipj
 xS/n+9JQuptEMm/B8Grmx8dUs0S6cg21OLM+oUd7bA4UBCzQJrd4lTvVpPSGvo3xFSaa
 qpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519366; x=1781124166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qiLXrv+EHVZiaiNusE/0qerEn7/xVuPpn64bFCYX+w=;
 b=fLyJPAfH/PPDL5TkYXARw+AHd8iM9N1XBNJkhPklhjsOMC7sCD57aIyC0yn+w9eiIN
 yqcd/44l5WNkTwrnAH00qzriu0Sn4uIdT3PQ+OYEhNlOEqnFNuCzxgK9oHx2zC30qV7a
 O81rMC4wlak9AupG+uerRW+JQTrGlJgZA6BXUb16fRnrtllgJksxVRXNldHttQz9MvfS
 KRn3J3C9aBBw+DCN+M62hCUPgir/FO38mwqluUMbZpEqhwlW4pF+5JMHe5Ntj2PLIIez
 kXcSjZoAOtufjiYC4rrlwTGgQWn4mTynoxiBY8ZsQdM6GQQ1GbOGVawJ/ZmDLevTS8zj
 6sLA==
X-Gm-Message-State: AOJu0YwjSzzS2k6N3tS/4yAOxUvdMsqlx1eR62qvfA96OUKClBCuLj5z
 eqRD7Lr8dpxgaoVcmjNctQlw9/nHgzvfgtZu3lSkur+hMVNUxM1q3PH/KUnpB/0wRDyWUC03wB/
 WT8MpGAj1RX+X02e+D1Gm0GpDttA6HQYVhzq1PeEa/Vy3OFtiU+vmaDZD
X-Gm-Gg: Acq92OGbzIxQcHjKAhM5SVjSAh2SykeFzSoUxnHcY2mTlVMfCo58UMpOrFdgKEi5pzD
 Xv9taxQ/NXkReq1+nr3hgIB+ebpVoMtf6YOuEC52lM+tdMaLhFW5QAilK/wYCgG3YINQ7iJfLpB
 MmoPWqjCv7wCeIpUHfIh7qDDeSKyau245ZAe7tQ55PDu9TGGNrMD9+3wb1rklTu2aqi8Lyedqmm
 8clYA8NcwnfSbHuR5eMCyQtuarlO+2rTBnawn5FtKMMxxo5lOSdci/e/W0LgMnoZybmDaGZLG/p
 2mIZqRy7JL49+S2MiJnOieYGGl+jxwm2kdeURVFxSuPexCxqGMNu5Ip7J1doaU0NF5NDWm/6Fjf
 9Ia00B4y6z+FJRiAX6bEiQN5sfg==
X-Received: by 2002:a0c:fac2:0:b0:8cc:ebc0:6ec7 with SMTP id
 6a1803df08f44-8cece034148mr53913886d6.38.1780519365512; 
 Wed, 03 Jun 2026 13:42:45 -0700 (PDT)
X-Received: by 2002:a0c:fac2:0:b0:8cc:ebc0:6ec7 with SMTP id
 6a1803df08f44-8cece034148mr53913256d6.38.1780519364914; 
 Wed, 03 Jun 2026 13:42:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd26b3b9sm30982826d6.45.2026.06.03.13.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:42:44 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:42:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 07/13] migration: Fail migration if switchover-ack is
 requested after switchover decision
Message-ID: <aiCRwvoVl_Z7J3bL@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-8-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-8-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 02, 2026 at 12:26:15PM +0300, Avihai Horon wrote:
> Switchover ACK is checked only during precopy while the guest is still
> running. The last migration_can_switchover() decision and guest stop are
> not atomic, so a device may want to request another switchover ACK in
> the gap after switchover decision has been made but before the guest is
> stopped. Migration would then miss that request, which can increase
> downtime.
> 
> Cover this case by failing the migration if a switchover-ack was
> requested during that time.
> 
> Ideally, precopy iterations should be resumed in this case, however,
> VFIO doesn't support going back to precopy after being stopped, so
> implementing such logic would require non-trivial changes to the guest
> start/stop flow. Given the above and that this case should be rare,
> failing the migration seems reasonable.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nit:

> ---
>  migration/migration.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4bb649a467..6ee1c795ff 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2810,6 +2810,27 @@ static bool migration_switchover_prepare(MigrationState *s)
>      return s->state == MIGRATION_STATUS_DEVICE;
>  }
>  
> +static bool migration_switchover_check_switchover_ack_pending(MigrationState *s,

The name is slightly confusing.  It says "check if there is pending ack"
but then it returns true if there's no pending ACK..

Maybe migration_switchover_is_acknowledged()?

> +                                                              Error **errp)
> +{
> +    uint32_t pending_num;
> +
> +    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
> +        return true;
> +    }
> +
> +    pending_num = qatomic_read(&s->switchover_ack_pending_num);
> +    if (pending_num > 0) {
> +        error_setg(errp,
> +                   "Switchover ACK was requested by %" PRIu32
> +                   " devices during switchover",
> +                   pending_num);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static bool migration_switchover_start(MigrationState *s, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -2822,6 +2843,15 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>  
>      qemu_savevm_query_pending_final(s, &pending);
>  
> +    /*
> +     * Switchover-ack requests done after switchover decision, are not allowed.
> +     * Fail the migration in this case since we currently don't support going
> +     * back to precopy.
> +     */
> +    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
> +        return false;
> +    }
> +
>      /* Inactivate disks except in COLO */
>      if (!migrate_colo()) {
>          /*
> -- 
> 2.40.1
> 

-- 
Peter Xu


