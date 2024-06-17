Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDDEC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDN9-0007xF-O7; Mon, 17 Jun 2024 10:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDN0-0007uu-LI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDMz-0004xi-3d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718634603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdEYXf6RvRLGMcErBLSteBtIO4W15UrPRKbsZ2WW5pE=;
 b=LgmgXUH+kXkxA2qOasT0xQHMkcENWFCq/5h/VmYIIacpgMvTcizXTHi/oN3dXhwdFITO5v
 qbGUdtwMrqZMuw84BpGqPsTeOJkoOUfX+H6WmmOC6DA8JgxYsRhhRSjLPl9ffqHWmx0pbh
 i9SosNhFWbHL+6ouGdxku9btAQ8yVgI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-6Nj9WbBWO4qwiJT4MNdA7Q-1; Mon, 17 Jun 2024 10:30:01 -0400
X-MC-Unique: 6Nj9WbBWO4qwiJT4MNdA7Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44051e6249aso55052271cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634601; x=1719239401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdEYXf6RvRLGMcErBLSteBtIO4W15UrPRKbsZ2WW5pE=;
 b=eLIWBwU0Ag8dV++hRc7Nol46/tBEIKnBXDVOu/dunAoSMcNK7Ag0wPWyeNUs1INH/h
 eyAloFlDHgeAourzcVcTrthvREOYwrXi/grtxpsAGm4yeBsLyjcH5nKnhNWcwahPgtNO
 h0RxR+6N2QUtd9My9SZ5nZCkEw9u7o/fgUuaQvnYuJglCPFEWkR591ngQbBjG8RoJnIq
 9CJOFiTn8eZ1idw/PoOiN4UAavWNIamiqHtaozReOMPxJiLIqSoJudJMbY/som8yQAIB
 XQRSVLYOGbX4LU7KEHUheL82HTCOPRDNcanyWAZ3d+NFDL9xyEQOgW3LmFGhBVx0nSLS
 2x3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKtofLlWXcGE5BnZJjjHkdzhDlQ9ByC1Be/J+0KUXkxyJTotu3s1e4ngnKZSQC3g8N9K+l6P5TYNgBY2O/85rqKyYkirE=
X-Gm-Message-State: AOJu0YxYSC+uL5FpZWxOAUv1UZcjbryHNdgn+zH/EXKkcxILrGvF5mg0
 NbRpgoYYMXkPaijBhez+wfPzbyFrqlbx6npQc8ybYEWuPmFonByTMK5NFT2cNWOumHstirUHvaq
 +DQulcyaYj620KoiQjdsCnzCzImrjrIxDrZxAP/2DCFWVsiVqEAgx
X-Received: by 2002:a05:6214:1bcc:b0:6b0:7327:c461 with SMTP id
 6a1803df08f44-6b2afc8efa1mr137969636d6.22.1718634600844; 
 Mon, 17 Jun 2024 07:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMLgQswyV/EvPnP7O1v2i//U1NBMfiJUw7MSA3HwPqJW/eHPxokfcyk+ugbXn542FwmyUd5g==
X-Received: by 2002:a05:6214:1bcc:b0:6b0:7327:c461 with SMTP id
 6a1803df08f44-6b2afc8efa1mr137969426d6.22.1718634600473; 
 Mon, 17 Jun 2024 07:30:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5f10490sm55487206d6.141.2024.06.17.07.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:29:59 -0700 (PDT)
Message-ID: <d47d15d1-d884-4dc3-b7ef-d7dfeddaabc8@redhat.com>
Date: Mon, 17 Jun 2024 16:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] vfio/container: Introduce vfio_create_container()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-10-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/17/24 08:34, Cédric Le Goater wrote:
> This routine allocates the QEMU struct type representing the VFIO
> container. It is minimal currently and future changes will do more
> initialization.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index bb6abe60ee29d5b69b494523c9002f53e1b2a3c8..a8691942791006f44f7a3c34b32c67ca51766182 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -430,6 +430,16 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>      return true;
>  }
>  
> +static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
> +                                            Error **errp)
> +{
> +    VFIOContainer *container;
> +
> +    container = g_malloc0(sizeof(*container));
> +    container->fd = fd;
> +    return container;
> +}
> +
>  static int vfio_get_iommu_info(VFIOContainer *container,
>                                 struct vfio_iommu_type1_info **info)
>  {
> @@ -604,13 +614,14 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>          goto close_fd_exit;
>      }
>  
> -    container = g_malloc0(sizeof(*container));
> -    container->fd = fd;
> -    bcontainer = &container->bcontainer;
> -
> +    container = vfio_create_container(fd, group, errp);
> +    if (!container) {
> +        goto close_fd_exit;
> +    }
>      if (!vfio_set_iommu(container, group->fd, errp)) {
>          goto free_container_exit;
>      }
> +    bcontainer = &container->bcontainer;
>  
>      if (!vfio_cpr_register_container(bcontainer, errp)) {
>          goto free_container_exit;


