Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CFC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqV8-00061a-A0; Fri, 16 May 2025 04:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqV2-0005xM-MU
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqV0-0005bb-M6
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zLVsnLTeyjylfISYcDBbSFWfzrXvJK5ezm1ijVQRI8Y=;
 b=Y6xiN81t9LdMs5685NWsqh5mQh2dLfSimLJtBmuwUaieeYFrUgHn6PDEUTCCNyrD2JUpGB
 ckhCkDJn7XsBzufhnea879yWk7sSPcMP3vzTz20APNId1yXNTzhSzrgb/mZ5AIxMsherWp
 TBpVRMkDJbEq+7DcmxDUzlHnEyt8waA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-MPS4kRPuMvS_MXU7UfUaRg-1; Fri, 16 May 2025 04:32:55 -0400
X-MC-Unique: MPS4kRPuMvS_MXU7UfUaRg-1
X-Mimecast-MFC-AGG-ID: MPS4kRPuMvS_MXU7UfUaRg_1747384374
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a363beb5ebso21090f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384374; x=1747989174;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLVsnLTeyjylfISYcDBbSFWfzrXvJK5ezm1ijVQRI8Y=;
 b=ToIh7YffQlcSeluW/uynUOiEyKlJoaJ5+5pxbByaOTWyu4WYkA0FY/sEzu7mkieXjI
 o1rl677d3bbnnM35iX2++3wO+WDVYIwNewIJC0pOjWffXctpTnxJMUplkeIJcLfZdWNJ
 3hzF9iYEDgbqo49GPhjD9bBhdYrv1bJ2F5x9bQ6uKCW6MfxPfzacjIa5MXomcwtlSika
 GjaeNezEwNYfSwFBJy1yaTX6RjSdabcBBLo5A8oABl4L6fOoejBEFVFNE+uwSy47D4Xc
 wV3Fj7H/ZggxfekUTOB8OYbrR1HUWd4734/Tj7JKMQ+uWrjYc7qZDBtfbcW4cm0VmLKh
 139A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnJb0/jFx7GEFr0MOAtyEFG4i/kVocB2dgrvQ/8ctPv/QlzHcBA/8HrWoyG+tadIf0hVHi7MFhzmXw@nongnu.org
X-Gm-Message-State: AOJu0Yw7givoMzN9kG4CSzmfYAIBeE/9k93IIOHvYU/tE5THtjO36cfQ
 RjGUgTeNANJR6VJPAJS/at5YIhZO6BJfgD/iNOK/SWD9rdSNk5Y52onXc6RbWmP/+mI7afJOpFj
 2sDVlViR++22elK9JkuCLWck5wTbOOs4gd9dmwY/a4j3z8jAkwlczqaPd
X-Gm-Gg: ASbGncsYrpyTi6x1+u8ymmUfGwzPWQqW/QN66JUSw/z4DzpeKFNKuBGPvAWGXhrVehT
 7rNKxFZZi3Akho60Vc2K4aEz6ukygtrh8EAzCHLcqqwW6ndvs7BTUXlrrhB1FwR9StzmzVpchBw
 l9TtU8qlOGkmiiftuHLUJ8rISy2JMltbSav3lXpHXIhheguS7x2hOx/cIT98p98XorYGvM6mg/9
 9JcvsEw3wGxPbP7acOM/iUaKtFxcFR9LcVGJFE7S9vABdvLHPJradQXYCapm0fyWawiMiuR8j1L
 WoJvDkQGb36gz1NoZxiVWeXG0siX8p5b3L+FoivSVIC0bpW4/g==
X-Received: by 2002:a05:6000:2011:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-3a35fe96165mr1313144f8f.32.1747384374385; 
 Fri, 16 May 2025 01:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZiMlJMwdiTyuwt9w294LgjAxhDUx0+b53mUZidTGy2pD8g7f7eCYwvcWzKB/coyELuHkqtw==
X-Received: by 2002:a05:6000:2011:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-3a35fe96165mr1313119f8f.32.1747384373940; 
 Fri, 16 May 2025 01:32:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd4fdbfcsm25069735e9.3.2025.05.16.01.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:32:53 -0700 (PDT)
Message-ID: <acac8632-6c9e-4635-add3-d029b70c74f2@redhat.com>
Date: Fri, 16 May 2025 10:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 16/42] vfio/pci: vfio_vector_init
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-17-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-17-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 5/12/25 17:32, Steve Sistare wrote:
> Extract a subroutine vfio_vector_init.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4aa83b1..b46c42e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -511,6 +511,22 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> +static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vector->vdev = vdev;
> +    vector->virq = -1;
> +    if (event_notifier_init(&vector->interrupt, 0)) {
> +        error_report("vfio: Error: event_notifier_init failed");
> +    }
> +    vector->use = true;
> +    if (vdev->interrupt == VFIO_INT_MSIX) {

You seem to have plans to use vfio_vector_init elsewhere (patch 22).

Looks ok for now.

Thanks,

C.

  


> +        msix_vector_use(pdev, nr);
> +    }
> +}
> +
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> @@ -524,13 +540,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       vector = &vdev->msi_vectors[nr];
>   
>       if (!vector->use) {
> -        vector->vdev = vdev;
> -        vector->virq = -1;
> -        if (event_notifier_init(&vector->interrupt, 0)) {
> -            error_report("vfio: Error: event_notifier_init failed");
> -        }
> -        vector->use = true;
> -        msix_vector_use(pdev, nr);
> +        vfio_vector_init(vdev, nr);
>       }
>   
>       qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),


