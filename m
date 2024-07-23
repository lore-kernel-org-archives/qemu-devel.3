Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F8EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAms-00059e-QK; Tue, 23 Jul 2024 04:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAmr-00054I-I4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAmp-0000Z1-Ic
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721722938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2MQpVYr27hGcWtOmev0wH5MyAf1RKidQgDpnmrpIyg=;
 b=gMUD5zgnT1FheyZv6W/ulZLXnAEYhKUxf9tnPsv2MKs5gkKa4OhvmhDZ4p9/5eLF5WgkgY
 ZQPNJW+LMumzoiRnQ6WmfVIhtsPFrkc27TlJpAckVLgpRFio+qKGXQkF7zHf90H/4qK158
 Qjq02azYWIhtt3E7Bo77AFsDutNq0qU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-WwJyQvUlPpCCsbtyDz35qg-1; Tue, 23 Jul 2024 04:22:17 -0400
X-MC-Unique: WwJyQvUlPpCCsbtyDz35qg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b79d1eb896so99559206d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721722937; x=1722327737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2MQpVYr27hGcWtOmev0wH5MyAf1RKidQgDpnmrpIyg=;
 b=M1KQkqv3iwqgEfrKBxNU0Yka1vuvxTNxx47aGAGBXk0ZXK8iM3msfL8GI3qhFU1NjE
 vcO4lmGewLeBU1OFPL5qPteZqahENOQvFco9Z9eGhMhQ78Hj5vQz4j7iGCATDNRqR/Ll
 0JyDEkES6rK0KdiEEbdwqhY/Rim2yI8EpLcXrqdT5zZzfo+ZGq00KhrjvP90T4c8mtYQ
 oYwqd3KM6ZfiuA66CkTJDSFlzpuaNKQFrK4i4W1r7VsCUh5Arm24xBohIOMW9OCFcleO
 3qJ9AtFhNMiOfo/QFUQ8L038g1P3446CWBZfsHOoTRO5ZMlNjCE1YZj5MX2Vi0tqnJIc
 QYBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVevR8URC01oNyhndziSxzeDf0psJD68bwqbYWgoauoqqJOyIcQ8xJwZkYqN/XjaiaJQsJMXGLjKolWTZgSK4gO9vBNyCA=
X-Gm-Message-State: AOJu0YwHacq2r6SkOL3uhlQy9b3Bo7HZoYT2AOSvqQmrh704OSG15+v9
 w1YC/kLl1IHbSSU9CnLaOfzheuB1MW99cHIV7OEh9s42ZzA6TzZ0rUJzYkB87BRiL+YrtghowO5
 oIi3BTd30ekmqY7TMqhj5jtz9QRZ0wg3wrUSTaQYczrKFpdTON3ZC
X-Received: by 2002:ad4:5bc9:0:b0:6b5:116:eb54 with SMTP id
 6a1803df08f44-6b9610eaab3mr135124556d6.47.1721722936705; 
 Tue, 23 Jul 2024 01:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExjmt9ytboCk2e5Syb5KG/Eexuai8qKsecHEvJZh7M723UIjlcUtjNBex2cFwTTRb3Wn9tvA==
X-Received: by 2002:ad4:5bc9:0:b0:6b5:116:eb54 with SMTP id
 6a1803df08f44-6b9610eaab3mr135124366d6.47.1721722936357; 
 Tue, 23 Jul 2024 01:22:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b896a2e4f5sm39094636d6.21.2024.07.23.01.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:22:15 -0700 (PDT)
Message-ID: <945609b9-4832-4ebf-8aa4-e00ded0ebd0c@redhat.com>
Date: Tue, 23 Jul 2024 10:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-9-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-9-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/24 23:13, Joao Martins wrote:
> By default VFIO migration is set to auto, which will support live
> migration if the migration capability is set *and* also dirty page
> tracking is supported.
>
> For testing purposes one can force enable without dirty page tracking
> via enable-migration=on, but that option is generally left for testing
> purposes.
>
> So starting with IOMMU dirty tracking it can use to accomodate the lack of
> VF dirty page tracking allowing us to minimize the VF requirements for
> migration and thus enabling migration by default for those too.
>
> While at it change the error messages to mention IOMMU dirty tracking as
> well.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  hw/vfio/migration.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 34d4be2ce1b1..cbfaef7afffe 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1036,16 +1036,16 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          return !vfio_block_migration(vbasedev, err, errp);
>      }
>  
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported && !vbasedev->iommu_dirty_tracking) {
>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>              error_setg(&err,
> -                       "%s: VFIO device doesn't support device dirty tracking",
> -                       vbasedev->name);
nit: does support neither/nor writing may be better here and below but I
am not a native english speaker

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> +                       "%s: VFIO device doesn't support device and "
> +                       "IOMMU dirty tracking", vbasedev->name);
>              goto add_blocker;
>          }
>  
> -        warn_report("%s: VFIO device doesn't support device dirty tracking",
> -                    vbasedev->name);
> +        warn_report("%s: VFIO device doesn't support device and "
> +                    "IOMMU dirty tracking", vbasedev->name);
>      }
>  
>      ret = vfio_block_multiple_devices_migration(vbasedev, errp);


