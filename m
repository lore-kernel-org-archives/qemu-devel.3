Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDCAC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhcG-0007dC-GE; Wed, 06 Aug 2025 13:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgXY-0004Wh-Vz
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujgXX-0004Kk-Fn
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754495933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qJq2dOVpjV6Q4xw1PCcxlPJITPprLtM6M/MMmK9Y3c=;
 b=YzpkBbOZS5fg3Rnl6ZHp9tJZfeWHYLxARbRhp1jwArTEtK326Yhn+McYKVO4ajHWdgUxJZ
 hs2ISGrZxESelx6myXKVijHgRGJG0Olx/qylBW3CFPL7qANm9BbkZxJbW101RvomNF/5qY
 +0YaHSgt08dem0oZxYSJGY1WHydlfxk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ggZMcTHPMou8nUi-vvfy8A-1; Wed, 06 Aug 2025 11:58:52 -0400
X-MC-Unique: ggZMcTHPMou8nUi-vvfy8A-1
X-Mimecast-MFC-AGG-ID: ggZMcTHPMou8nUi-vvfy8A_1754495932
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7073f820d42so2044756d6.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495932; x=1755100732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qJq2dOVpjV6Q4xw1PCcxlPJITPprLtM6M/MMmK9Y3c=;
 b=s+vdV3od+1PvNBAJiD5c4UsIbG6qY9Nn3l0MvdO5oj3epckpTFXp8Ia/uXBZi85zNE
 orX3Y6aMcJOuhwUasnr4bhY4R7BCNsyIJxjkFKktJHPAxvQTl0VN4BGlu46LeWPVzPYB
 hHaRim5ilrQ4B/d7xeiYdzkyxhZDpmwsHZVKIM7BoY1/WH+3aMONbDalP3MwwgO8Z0af
 Ni+QSU9K//G91zUY3ekay3Pf3hbAD2DrwOpx97wUF0Pr8Et1IPXKDnaraGk+YR0AeOTI
 94SkqiF2PeXDDT0sU8b7WT/6IIjrw3H+iD8mxrCa8G+nQtTegiZCLUtoxIDWF6h5adig
 1kgw==
X-Gm-Message-State: AOJu0Yx4a0oOVw2q5ACkhPqesejDgsHEFWnYOqW5pzaYT9oX22YleE9f
 55fdHBxJuLenkjOGOSN2C0XvNF17C7RnWCxh+Eh0ozLkYO4HLUQT2FHDBlTM1bn0KE4HaWrD9ud
 yokPlNVJ6IE4IUCJTMH9hKdseQ1gsiaACe7I8bAQNyebIARqjUvJxUo3a
X-Gm-Gg: ASbGncsmwytbeavYkvOK57QYkwFfaMThLqcB4OSFsgaqyQsnc2UsRKyimhP8Jl3LYbw
 u2L7O3kZ8vs2pXKXOF1XmepaKfuqXPD2yL/BHiJsS+P/0loOwR63R1xunvtBeb65vHM48lazbml
 oBAowkhoqSaH6StJ3oDi0u81SKpSKfWumRcB6LexT7UNON4iUKHGma5i0iUhBgYZRsY1XFu5un9
 chHkcYw/4ZXfpBnkU4sumKKWG0vYfszzgS5hbTJmhzUqjjew201GN5SaOygQDEUIphaX19YfcOn
 z0e2ggmeRDQVo5v7Nj9SXXcphFzDw3hmE+o2iBes9yK2wKixW1nxiTlBpucRu5KL+hFUmn1FW5F
 r0oMqq0niGy+hkqSjSA1FVA==
X-Received: by 2002:ad4:5c62:0:b0:706:6967:71da with SMTP id
 6a1803df08f44-7097961d97amr55586796d6.38.1754495931757; 
 Wed, 06 Aug 2025 08:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfQOKKlQ+17ReBw+QAHFASfripwDaYM7b6335lEJWMVHgGC5V/snbtYsBVaIXv+CFey/Gn0Q==
X-Received: by 2002:ad4:5c62:0:b0:706:6967:71da with SMTP id
 6a1803df08f44-7097961d97amr55586456d6.38.1754495931340; 
 Wed, 06 Aug 2025 08:58:51 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca3621asm87155956d6.33.2025.08.06.08.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:58:50 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:58:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
Message-ID: <aJN7uOWSt10U7DMi@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722124127.2497406-2-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 22, 2025 at 12:41:22PM +0000, Jonah Palmer wrote:
> Adds a new migration capability 'virtio-iterative' that will allow
> virtio devices, where supported, to iteratively migrate configuration
> changes that occur during the migration process.
> 
> This capability is added to the validated capabilities list to ensure
> both the source and destination support it before enabling.
> 
> The capability defaults to off to maintain backward compatibility.
> 
> To enable the capability via HMP:
> (qemu) migrate_set_capability virtio-iterative on
> 
> To enable the capability via QMP:
> {"execute": "migrate-set-capabilities", "arguments": {
>      "capabilities": [
>         { "capability": "virtio-iterative", "state": true }
>      ]
>   }
> }
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  migration/savevm.c  | 1 +
>  qapi/migration.json | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bb04a4520d..40a2189866 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>      switch (capability) {
>      case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>      case MIGRATION_CAPABILITY_MAPPED_RAM:
> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>          return true;
>      default:
>          return false;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6ca12..8f042c3ba5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -479,6 +479,11 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @virtio-iterative: Enable iterative migration for virtio devices, if
> +#     the device supports it. When enabled, and where supported, virtio
> +#     devices will track and migrate configuration changes that may
> +#     occur during the migration process. (Since 10.1)
> +#

Having a migration capability to enable iterative support for a specific
type of device sounds wrong.

If virtio will be able to support iterative saves, it could provide the
save_live_iterate() function.  Any explanation why it needs to be a
migration capability?

>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -498,7 +503,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram', 'virtio-iterative'] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.47.1
> 

-- 
Peter Xu


