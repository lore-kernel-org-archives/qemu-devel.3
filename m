Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E350CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3a9e-0006pn-SH; Tue, 30 Sep 2025 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3a9b-0006oK-Cd
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3a9M-000324-De
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759237925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mj5qZ2al5wBPPveFMnFThYt5sgQalEc39XFAuYbrY4I=;
 b=bgEMPfOXzlRQqqI5KeN3qjpqNdeO1Jik0bfdRGfu9lCNIv+793WXJOjrzeRXkDixGFAJQz
 si6ZUJ8efbR41IsfUzV029FD8Iefv5eBTTaM+ZHLWdGUHb1myFqdGLT6HiYEfBjsA3bVIA
 5AD6QzGZp7J3z3As2p138AxG1Makt0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-CtZ9aR6QOuyucK4mlD9JwQ-1; Tue, 30 Sep 2025 09:12:04 -0400
X-MC-Unique: CtZ9aR6QOuyucK4mlD9JwQ-1
X-Mimecast-MFC-AGG-ID: CtZ9aR6QOuyucK4mlD9JwQ_1759237923
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ef9218daf5so5572081f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759237923; x=1759842723;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mj5qZ2al5wBPPveFMnFThYt5sgQalEc39XFAuYbrY4I=;
 b=wiHND68xnplCGRheIL+srComD08Fvtuv71hfMcxzNNAPuWSSwivR3eMKGVnXBgDoSo
 9ZsMcBt9CjGLWM8i9Aa8Dl644K007c570TKYCFEKvFI4JnBz5ybDTludwS3wpzrThh1A
 i6ltNtIR6A7k9/XwDaMveq26hQXiOIUPTADWyPh+QFAyvvWKJTbz6mkbD0DLd/qvpkRU
 ZIEIN/lfvQ2OiALeKwnOr70VG/ADwuzoEI2WSUvvALDMZMy9k+gcLQSv+zWSMKnFNA4v
 HuluoBOPCp7paTvxxnV0qbqximDTAPQ2Cepjr3lfqSMdQ9RU48lWQsZtr8bSdMotR2Au
 nCmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZC8Rn0Rmc8zF/YHMwIK8YacyPftN5XL9eOYOKJNHtwvY+tLf1nwP0GdgoMoiQCNkG8shokkt0FPau@nongnu.org
X-Gm-Message-State: AOJu0YxV0karWlcw+3l+mgk3A4h//omcDiW5aU6hM+0EmzoJsYF0jfwL
 7lOyzFyL+MtWGwD69yyo45mSUq1asBSqbb3RNB7mZDTqDOvZ6xBo/atnTqpL+tejzcL/7sDLdyb
 OydsjxBKuqwK7FYRCJNyBPFmR+IpYozNK3m4iwygvkIOBPi6sj83zY8bt
X-Gm-Gg: ASbGncva+2uarUUbeYBYPhNLz1dKqcmU3mwbBSx8AIozV9ZbFT1uSzkwyxzPhKwxwdy
 GSv77GMm084jXZ0Irf9wD1KdgDOXffXqLtLWNAIWYL+Dg0lcuaskDqdNbojSRyQ/qBm9JkL130V
 RLbEQDignakOzSHRVbpU+CN+6Sb+/s6y26EMoZ71QH11IuTjENTREpiQ37z59kKxa/qyK6l0Kxm
 Bb1/mJwQZaFTx8SzKx7LL0Hf30KpFvDSvQL4THc9r2359SMk4LNhkAPH4ChIzDC07rks/c79UYv
 VBxszYUVjmsFD1zn4wi1jbrtZq78ev86tIWRiyr1hlEAikIEuAkGbARmG+NCnrHuXjdwbQdGydN
 mL9EaFDdY
X-Received: by 2002:a05:6000:2486:b0:3ed:e1d8:bd73 with SMTP id
 ffacd0b85a97d-40e4d9c9330mr18887446f8f.57.1759237922963; 
 Tue, 30 Sep 2025 06:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLl6HB4oxpSeUavM1XeyQ4hGBSU9fIaPcw0Raykjsi4IkTCnu41DgueNpyPbfXoC+iLdQqhQ==
X-Received: by 2002:a05:6000:2486:b0:3ed:e1d8:bd73 with SMTP id
 ffacd0b85a97d-40e4d9c9330mr18887424f8f.57.1759237922530; 
 Tue, 30 Sep 2025 06:12:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f534e3sm65088915e9.6.2025.09.30.06.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:12:01 -0700 (PDT)
Message-ID: <b499b956-7357-4e1b-aa63-74d4b52880b4@redhat.com>
Date: Tue, 30 Sep 2025 15:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/vfio: Remove invalid uses of ram_addr_t type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>
References: <20250930123528.42878-1-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250930123528.42878-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 14:35, Philippe Mathieu-Daudé wrote:
> Replace ram_addr_t by either hwaddr or uint64_t types.
> 
> Since v2:
> - Rename variables as 'translated_addr' (Cédric)
> 
> Philippe Mathieu-Daudé (4):
>    system/iommufd: Use uint64_t type for IOVA mapping size
>    hw/vfio: Reorder vfio_container_query_dirty_bitmap() trace format
>    hw/vfio: Avoid ram_addr_t in vfio_container_query_dirty_bitmap()
>    hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map
> 
>   include/hw/vfio/vfio-container.h | 13 +++++++------
>   include/hw/vfio/vfio-cpr.h       |  2 +-
>   include/system/iommufd.h         |  6 +++---
>   backends/iommufd.c               |  6 +++---
>   hw/vfio-user/container.c         |  4 ++--
>   hw/vfio/container-legacy.c       |  8 ++++----
>   hw/vfio/container.c              | 15 ++++++++-------
>   hw/vfio/cpr-legacy.c             |  2 +-
>   hw/vfio/iommufd.c                |  6 +++---
>   hw/vfio/listener.c               | 18 +++++++++---------
>   hw/vfio/trace-events             |  6 +++---
>   11 files changed, 44 insertions(+), 42 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



