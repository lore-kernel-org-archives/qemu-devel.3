Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685FCC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WSk-0007EI-Px; Mon, 13 May 2024 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WSg-0007BT-KA
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WSe-00082L-4T
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715609726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CA3KJvC+9raWEm5iCsMQxMRscl7E+EFVpiYgjeQqgTU=;
 b=RmhI6q5/fbciDuzRcNixQim48Nf0d77ohKVa0SVX5gcdBDirpIz/vOmhOZ0EC4TRedkCgF
 hKaHSZeXmfV49DBbbaMejuWV6mN73j5m9qdBJqLbsYViS1HOHZBs6QDlSpjVF4KLjVro07
 2J082DSTa0ooOBWLYu+bUB56LMpK1o0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-mBlmXD9YNVSZVNzCTFFPQQ-1; Mon, 13 May 2024 10:15:24 -0400
X-MC-Unique: mBlmXD9YNVSZVNzCTFFPQQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5aa350b43ecso6599891eaf.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715609724; x=1716214524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CA3KJvC+9raWEm5iCsMQxMRscl7E+EFVpiYgjeQqgTU=;
 b=eZyGypBrBAlzHw5THhmo8YFGHR3i4ji/QsbDeWU4+lC3zVuCvKmnEWm6F+BVPNehTx
 0n2pawaqVMubwpNMthTFnRnwTgNbi/vt8qxNDpi/kMpqB1xMqtzkU5cqlbO7KCZhDpeX
 ZLE6ZSrx7s5Sf1NR25+UYaUCv5LUoTSS8skU5ml0dJCwplzpazynPGmm1iYkbG3M4q4q
 7J7UjF1gemT34YvV6rPhOmzh1Zw+akVkn5KINv8Z61VwCDacFA5R1AqGXUyF1NPEOzTq
 IoGPPF/3rcNYQ2CLv73J3IEDUB1GcNYuUMp1hCaHbRaM5Gkx/66SgBUiqyGj2j3j9T7x
 RH6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfUaEDCCxkZ/DKE8f2lyN08TRZOxnoVroYVmwBjSsLNjCIzasUct+wDROlfQqOeZ6U1fuheAHmWyqO3fRJD0SJAyn10c=
X-Gm-Message-State: AOJu0Yw9boeslwA8mb2tLzOZ9yBMAxxaZLtV1uEoSa2l00xqX+YZ2heW
 JupznhdvMSSmnPbLWSy4Jk7RmG5lMCqkUTgtyAhXvAYH1nmpSr+pcZeKqjRVpvOJX0R0/vtku9D
 ma7LqUlGRuaRVB7w3Fs5KAr1ErqeklxlwoWM1c0njqmAdDSZclyHa
X-Received: by 2002:a05:6358:339f:b0:192:c556:5552 with SMTP id
 e5c5f4694b2df-193bb3fc5fcmr957897755d.6.1715609724043; 
 Mon, 13 May 2024 07:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbr5PPxeSqsVvPQ9awj9ZHMSW/gv0PW1AU7NhaYsrixtMYDsecAFb6zHjclGIjos1G4gGm4A==
X-Received: by 2002:a05:6358:339f:b0:192:c556:5552 with SMTP id
 e5c5f4694b2df-193bb3fc5fcmr957894355d.6.1715609723675; 
 Mon, 13 May 2024 07:15:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e24483cbasm1388621cf.60.2024.05.13.07.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:15:23 -0700 (PDT)
Message-ID: <e34a7c4f-2c6c-404a-a721-4838fe0edeb2@redhat.com>
Date: Mon, 13 May 2024 16:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qapi/vfio: Add VFIO migration QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-2-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240509090954.16447-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/9/24 11:09, Avihai Horon wrote:
> Add a new QAPI event for VFIO migration. This event will be emitted when
> a VFIO device changes its migration state, for example, during migration
> or when stopping/starting the guest.
> 
> This event can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
> 
> Note that this new event is introduced since VFIO devices have a unique
> set of migration states which cannot be described as accurately by other
> existing events such as run state or migration status.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

LGTM,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS           |  1 +
>   qapi/qapi-schema.json |  1 +
>   qapi/vfio.json        | 67 +++++++++++++++++++++++++++++++++++++++++++
>   qapi/meson.build      |  1 +
>   4 files changed, 70 insertions(+)
>   create mode 100644 qapi/vfio.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84391777db..b5f1de459e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2160,6 +2160,7 @@ F: hw/vfio/*
>   F: include/hw/vfio/
>   F: docs/igd-assign.txt
>   F: docs/devel/migration/vfio.rst
> +F: qapi/vfio.json
>   
>   vfio-ccw
>   M: Eric Farman <farman@linux.ibm.com>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 5e33da7228..b1581988e4 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -78,5 +78,6 @@
>   { 'include': 'pci.json' }
>   { 'include': 'stats.json' }
>   { 'include': 'virtio.json' }
> +{ 'include': 'vfio.json' }
>   { 'include': 'cryptodev.json' }
>   { 'include': 'cxl.json' }
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> new file mode 100644
> index 0000000000..a0e5013188
> --- /dev/null
> +++ b/qapi/vfio.json
> @@ -0,0 +1,67 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +
> +##
> +# = VFIO devices
> +##
> +
> +##
> +# @VfioMigrationState:
> +#
> +# An enumeration of the VFIO device migration states.
> +#
> +# @stop: The device is stopped.
> +#
> +# @running: The device is running.
> +#
> +# @stop-copy: The device is stopped and its internal state is available
> +#     for reading.
> +#
> +# @resuming: The device is stopped and its internal state is available
> +#     for writing.
> +#
> +# @running-p2p: The device is running in the P2P quiescent state.
> +#
> +# @pre-copy: The device is running, tracking its internal state and its
> +#     internal state is available for reading.
> +#
> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
> +#     tracking its internal state and its internal state is available
> +#     for reading.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'VfioMigrationState',
> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> +            'pre-copy', 'pre-copy-p2p' ],
> +  'prefix': 'QAPI_VFIO_MIGRATION_STATE' }
> +
> +##
> +# @VFIO_MIGRATION:
> +#
> +# This event is emitted when a VFIO device migration state is changed.
> +#
> +# @device-id: The device's id, if it has one.
> +#
> +# @qom-path: The device's QOM path.
> +#
> +# @device-state: The new changed device migration state.
> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
> +#          "event": "VFIO_MIGRATION",
> +#          "data": {
> +#              "device-id": "vfio_dev1",
> +#              "qom-path": "/machine/peripheral/vfio_dev1",
> +#              "device-state": "stop" } }
> +##
> +{ 'event': 'VFIO_MIGRATION',
> +  'data': {
> +      'device-id': 'str',
> +      'qom-path': 'str',
> +      'device-state': 'VfioMigrationState'
> +  } }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index c92af6e063..e7bc54e5d0 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -52,6 +52,7 @@ qapi_all_modules = [
>     'stats',
>     'trace',
>     'transaction',
> +  'vfio',
>     'virtio',
>     'yank',
>   ]


