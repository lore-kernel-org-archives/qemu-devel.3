Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iTe-00005T-TH; Mon, 22 Sep 2025 11:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iTQ-0008Tu-MR
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iTO-0000vC-8G
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758554938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XDaIhdrrKpPqF3KQ6PX1IerLCXNXHqcxP3iNl9Rn+bg=;
 b=GUwOEjFOeTByz9YvCCqXPFfKgRvEVp2ne8AGuDUUVOVry118xjUwh2NiNPmDrjq3v9H1Pj
 AGlY2Vgky2flZzC2X/mAVx0NG4+YGuIOgOSGPk3l1OdbSD3uFdjtPjMLWF7H2+rxUnN6/0
 dHXEDt13elLyuUJmrtDgi3WyxsKE9qE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-BohC1YFMNFuWM-XaBJXlQw-1; Mon, 22 Sep 2025 11:28:56 -0400
X-MC-Unique: BohC1YFMNFuWM-XaBJXlQw-1
X-Mimecast-MFC-AGG-ID: BohC1YFMNFuWM-XaBJXlQw_1758554936
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso14995425e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554935; x=1759159735;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDaIhdrrKpPqF3KQ6PX1IerLCXNXHqcxP3iNl9Rn+bg=;
 b=IWTWKdQN+KvvhKPD4yY41jaKf0rGlKwO4uad7d2BU2tDPStG2G1FvVrb47Th8yM8Ml
 MSm0VK9ev0bIkMeTbZTLPX4BQmO0c1vFYJYGQXlM+j0zRTLPtSQD3UdxmTToktE919q3
 KfRer+1jDY/V8oyDpqSRVCk1mwfR7/GulawxoB77MxhZb6EcXmey40lsyBYSCTuvgVdX
 AC/nLB+inNoC/pQ+xsowyHPkOiNeR5swsAKPMQIqoduJsivtyKfGR/xmlr/7OaZOo9p2
 v6BRZZ3eKzWOA1lSBKHa+LD0JG7jRrTh9OosGu+IKqpgtcrbshXHFg2MrETJIVSA3a9K
 8vjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqzCgcG/2SvZrDDqrgPAkapPDjcwRVUkOQ4BJXr06kf2noTM/4OGb1alafpQYHSTQAiMIVkROCuM2N@nongnu.org
X-Gm-Message-State: AOJu0Yx5jZkrCATfkJwe4qxt8TpDwhOwrk8rHZhfcuFIdRoA7aQRAMx+
 Yp3jskr6+SGuFNZpCDR7XbPe/y0XEkwPL6ZO+BbEYnxcJoRHp2zcKIpCJNF3YMHOzf65vX1g4dt
 pine1E3YkY07klau2dFVHvaHBCLSV5kakS7rX++h3kc/Krsc44lmFOB0k
X-Gm-Gg: ASbGncsnEeq5qh22FchJQEqUjJv6DW5j/bBX4IlvtVVZK/rCnZUmrKj3pM+u85sI3DU
 b9Oy/7q6Ihq0uqd0+c0L5ZOlsBNaOwkm54sbT4OLtF5EL9hWqQmncagkm75Xf3XuFFnuIH9eIgH
 jDnN4vLuj5E5NzFtu0xPMVMLRvwmULnSNUl543uBoDa+cFeAkRHOeLyzvcgzIo0kK+KMMzczVfJ
 /zdzbzfnPgiZa4p8z4ByR+th4S+gjiReLVidjTQmQisLo40sEsnrLO2H/X1IunZsk1XLyQ4DnAF
 OzoV7gDqAS2A+/t9zYLxoBjylAmtL3gdpw2JqFH4eb7nXiTEARbcHMfyKy3uYNaR1G5xKzSeQEm
 pF8E=
X-Received: by 2002:a05:600c:c494:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-4684c13ec5bmr120708835e9.6.1758554935533; 
 Mon, 22 Sep 2025 08:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRVG6GdMBoHXNmZb7bq0umGtYF+J51Ey5mLduNfGD1pkdWHkjBadF2s26mzhQwLGBsSwx1Og==
X-Received: by 2002:a05:600c:c494:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-4684c13ec5bmr120708515e9.6.1758554935023; 
 Mon, 22 Sep 2025 08:28:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f4f3csm19589650f8f.2.2025.09.22.08.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:28:54 -0700 (PDT)
Message-ID: <96adf42a-7e81-40bc-9dae-7cbcc95f0df5@redhat.com>
Date: Mon, 22 Sep 2025 17:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/8] vfio: cpr-exec mode
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-9-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1758548985-354793-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c   |  3 ++-
>   hw/vfio/cpr-iommufd.c |  3 ++-
>   hw/vfio/cpr-legacy.c  |  9 +++++----
>   hw/vfio/cpr.c         | 13 +++++++------
>   4 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 030c6d3..935f14d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -988,7 +988,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           error_setg(&vbasedev->cpr.mdev_blocker,
>                      "CPR does not support vfio mdev %s", vbasedev->name);
>           if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
> -                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
> +                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
> +                                      -1) < 0) {
>               goto hiod_unref_exit;
>           }
>       }
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index 148a06d..e1f1854 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>   
>       if (!vfio_cpr_supported(be, cpr_blocker)) {
>           return migrate_add_blocker_modes(cpr_blocker, errp,
> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +                                         MIG_MODE_CPR_TRANSFER,
> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>       }
>   
>       vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 8f43719..eebb3bf 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -176,16 +176,17 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       if (!vfio_cpr_supported(container, cpr_blocker)) {
>           return migrate_add_blocker_modes(cpr_blocker, errp,
> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +                                         MIG_MODE_CPR_TRANSFER,
> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>       }
>   
>       vfio_cpr_add_kvm_notifier();
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> -    migration_add_notifier_mode(&container->cpr.transfer_notifier,
> -                                vfio_cpr_fail_notifier,
> -                                MIG_MODE_CPR_TRANSFER);
> +    migration_add_notifier_modes(&container->cpr.transfer_notifier,
> +                                 vfio_cpr_fail_notifier,
> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>       return true;
>   }
>   
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 2c71fc1..db462aa 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
>   void vfio_cpr_add_kvm_notifier(void)
>   {
>       if (!kvm_close_notifier.notify) {
> -        migration_add_notifier_mode(&kvm_close_notifier,
> -                                    vfio_cpr_kvm_close_notifier,
> -                                    MIG_MODE_CPR_TRANSFER);
> +        migration_add_notifier_modes(&kvm_close_notifier,
> +                                     vfio_cpr_kvm_close_notifier,
> +                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
> +                                     -1);
>       }
>   }
>   
> @@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>   
>   void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>   {
> -    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
> -                                vfio_cpr_pci_notifier,
> -                                MIG_MODE_CPR_TRANSFER);
> +    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
> +                                 vfio_cpr_pci_notifier,
> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>   }
>   
>   void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)


