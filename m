Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBA1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkVW-0002bL-4m; Wed, 05 Mar 2025 03:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkVS-0002aj-91
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkVO-0004bN-Dt
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741164808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BSXUNQ3ly1xtn1Tpcx8uUoBshrEGB4/wQ2uID5/zArM=;
 b=fkDLt3wE2604bTJyHpk0GCMuuMqGEKs0qFwEY1cCDWpYDOHi3/51LrnFZs4uE9+MSRduF9
 1UV+Frs5MeVEevGCNMKz3bRZJIvvscIQoqVlxgqm4M+xuw33VOl6nQPGe8Iodjqw+P7z4u
 iWBI9Gh1bxbOTrx+yEeAPWfS/3vPRFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-uh7nKphwM-qv4sZidL0Xtw-1; Wed, 05 Mar 2025 03:53:15 -0500
X-MC-Unique: uh7nKphwM-qv4sZidL0Xtw-1
X-Mimecast-MFC-AGG-ID: uh7nKphwM-qv4sZidL0Xtw_1741164795
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so47731035e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741164794; x=1741769594;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSXUNQ3ly1xtn1Tpcx8uUoBshrEGB4/wQ2uID5/zArM=;
 b=MXXQuaAa9ir+TO+Kv4JEk89c2ZjLb9BwLIKNmtDCGFTZZFhFutsTrWyUkSjGuIjmYo
 Nq4URcOnWv9Z/wmXerNayqMIWDSSKFXMGC5G/XT56Pr2fwFaPmUSZbSU93rpLrY/0KLg
 8Zgy/iNYTf2GzMf31rA+UVF9SFlijxYnCmsTR8fznqK7LC/WZCeJ7dXpYBEKVoCvxn0F
 MQ+VmskR1cktgtKVlXh1VnKInvA3bwatMagUmJ7e25yGHFIgospRiTa6ztf5Z1M9MDPb
 lYyVrbQ4zL8OLY7eLkuceDaOVWPlZh7sm/f9PCv4njTn89q3FOYatN2UGKXQSFvNFa2F
 wFeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZGENyFADeAI20CagYpYE7hxEQh8lC8lDauHKm8idiXD349Mq+UBdputqGSI8qMFE+GZqi857/gQ20@nongnu.org
X-Gm-Message-State: AOJu0YxUNIyZOcAAIDO8Zi6YrPdT/bVolGv8nrZNUMLVEQtFOd3B8D3d
 8w6/601SufZSAitfQTKdbrR7dOtTwIr0aFM+eeV5aFVNY8JyyUNPwCfM4oDctQdeegq4euE2pHA
 V2mRk+gfSn703QxbylrgESaFh4BdwIHDWcmmbYduiZdW/v2n3yUz4
X-Gm-Gg: ASbGncuqfQwfzK72GkyGZ2pF3D8/nquBScMZZQ2KZ8/VeeDpW9LsMKLT3rSfXeBX9uW
 iX2OlpHqo5NmFlPlXizvwUyJXMpjlGf9Z+sr0LdEZJeIvosexV9WnvTDS4m7iBcuI5MYeiyKKnI
 Mu12yXpzATJ6XFuYlfDU5+ESPd70C4nkQSVygvWun/FGYWfV5Ak8Zn0ZqSSF+pW1epk0NnOKeY/
 PR03t+RsCxdC8iq2IxFQ+8jRVIgbf9j9n178WrKvVym8cflS1RVqx3tvU3wyUy1EFAZaQ1l2XMA
 IqOf6j4pwn8BmUbwpZzmAJUMVSx+jm7SR11X7NSXgyQvlEFZyPtyOg==
X-Received: by 2002:a05:600c:198f:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43bd29589c0mr13234035e9.9.1741164794573; 
 Wed, 05 Mar 2025 00:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO00Uc4rO6e0LmNe98/uEHJJDTyU51EQIJ+iBGgezrWncBR8fxrYJfXbayVQqORo50Nuofkw==
X-Received: by 2002:a05:600c:198f:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43bd29589c0mr13233885e9.9.1741164794154; 
 Wed, 05 Mar 2025 00:53:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd41c9282sm11495985e9.0.2025.03.05.00.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:53:13 -0800 (PST)
Message-ID: <98091353-f8c2-41a2-87c7-430c1013a3ab@redhat.com>
Date: Wed, 5 Mar 2025 09:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 36/36] vfio/migration: Update VFIO migration
 documentation
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <6bbaaab45a9b8a2707c63570635255183eb1e997.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6bbaaab45a9b8a2707c63570635255183eb1e997.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/4/25 23:04, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Update the VFIO documentation at docs/devel/migration describing the
> changes brought by the multifd device state transfer.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   docs/devel/migration/vfio.rst | 79 +++++++++++++++++++++++++++++++----
>   1 file changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index c49482eab66d..fb76a38c333f 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -67,14 +67,39 @@ VFIO implements the device hooks for the iterative approach as follows:
>   * A ``switchover_ack_needed`` function that checks if the VFIO device uses
>     "switchover-ack" migration capability when this capability is enabled.
>   
> -* A ``save_state`` function to save the device config space if it is present.
> +* A ``switchover_start`` function that in the multifd mode starts a thread that
> +  reassembles the multifd received data and loads it in-order into the device.
> +  In the non-multifd mode this function is a NOP.
>   
> -* A ``save_live_complete_precopy`` function that sets the VFIO device in
> -  _STOP_COPY state and iteratively copies the data for the VFIO device until
> -  the vendor driver indicates that no data remains.
> +* A ``save_state`` function to save the device config space if it is present
> +  in the non-multifd mode.
> +  In the multifd mode it just emits either a dummy EOS marker or
> +  "all iterables were loaded" flag for configurations that need to defer
> +  loading device config space after them.
>   
> -* A ``load_state`` function that loads the config section and the data
> -  sections that are generated by the save functions above.
> +* A ``save_live_complete_precopy`` function that in the non-multifd mode sets
> +  the VFIO device in _STOP_COPY state and iteratively copies the data for the
> +  VFIO device until the vendor driver indicates that no data remains.
> +  In the multifd mode it just emits a dummy EOS marker.
> +
> +* A ``save_live_complete_precopy_thread`` function that in the multifd mode
> +  provides thread handler performing multifd device state transfer.
> +  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
> +  from the VFIO device and queues it for multifd transmission until the vendor
> +  driver indicates that no data remains.
> +  After that, it saves the device config space and queues it for multifd
> +  transfer too.
> +  In the non-multifd mode this thread is a NOP.
> +
> +* A ``load_state`` function that loads the data sections that are generated
> +  by the main migration channel save functions above.
> +  In the non-multifd mode it also loads the config section, while in the
> +  multifd mode it handles the optional "all iterables were loaded" flag if
> +  it is in use.
> +
> +* A ``load_state_buffer`` function that loads the device state and the device
> +  config that arrived via multifd channels.
> +  It's used only in the multifd mode.

I would have preferred that the documentation updates belong to the
patches implementing the handlers. I will change that when applying.

>   
>   * ``cleanup`` functions for both save and load that perform any migration
>     related cleanup.
> @@ -176,8 +201,11 @@ Live migration save path
>                   Then the VFIO device is put in _STOP_COPY state
>                        (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
>            .save_live_complete_precopy() is called for each active device
> -      For the VFIO device, iterate in .save_live_complete_precopy() until
> +              For the VFIO device: in the non-multifd mode iterate in
> +                        .save_live_complete_precopy() until
>                                  pending data is 0
> +	          In the multifd mode this iteration is done in
> +	          .save_live_complete_precopy_thread() instead.
>                                         |
>                        (POSTMIGRATE, _COMPLETED, _STOP_COPY)
>               Migraton thread schedules cleanup bottom half and exits
> @@ -194,6 +222,9 @@ Live migration resume path
>                             (RESTORE_VM, _ACTIVE, _STOP)
>                                         |
>        For each device, .load_state() is called for that device section data
> +                 transmitted via the main migration channel.
> +     For data transmitted via multifd channels .load_state_buffer() is called
> +                                   instead.
>                           (RESTORE_VM, _ACTIVE, _RESUMING)
>                                         |
>     At the end, .load_cleanup() is called for each device and vCPUs are started
> @@ -206,3 +237,37 @@ Postcopy
>   ========
>   
>   Postcopy migration is currently not supported for VFIO devices.


This should be in patch 31 :

> +
> +Multifd
> +=======
> +
> +Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
> +_STOP_COPY state via multifd channels. This helps reduce downtime - especially
> +with multiple VFIO devices or with devices having a large migration state.
> +As an additional benefit, setting the VFIO device to _STOP_COPY state and
> +saving its config space is also parallelized (run in a separate thread) in
> +such migration mode.
> +
> +The multifd VFIO device state transfer is controlled by
> +"x-migration-multifd-transfer" VFIO device property. This property defaults to
> +AUTO, which means that VFIO device state transfer via multifd channels is
> +attempted in configurations that otherwise support it.


This should be in patch 34 :

> +Since the target QEMU needs to load device state buffers in-order it needs to
> +queue incoming buffers until they can be loaded into the device.
> +This means that a malicious QEMU source could theoretically cause the target
> +QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
> +> +The "x-migration-max-queued-buffers" property allows capping the maximum count
> +of these VFIO device state buffers queued at the destination.
> +
> +Because a malicious QEMU source causing OOM on the target is not expected to be
> +a realistic threat in most of VFIO live migration use cases and the right value
> +depends on the particular setup by default this queued buffers limit is
> +disabled by setting it to UINT64_MAX.
> +

This should be in patch 35 :

> +Some host platforms (like ARM64) require that VFIO device config is loaded only
> +after all iterables were loaded.
> +Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
> +device property, which in its default setting (AUTO) does so only on platforms
> +that actually require it.
> 

I will handle it.


Thanks,

C.



