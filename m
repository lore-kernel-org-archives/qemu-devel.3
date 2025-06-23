Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0C5C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTWko-00033N-2m; Sun, 22 Jun 2025 22:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uTWkm-00032m-1v
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uTWki-00088a-Pv
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750645061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVQNsnzkR4fy/0MFAc0InlJSrCjdz2VdJOThIkc6lIE=;
 b=YBTO/4WVH0+l/M1D2d4BATQOVFYXrfaJry9FR+RGFZ5uWeqCyAMVVnXPe5tt9BVUNhG2Gw
 gJkuHddOrKB1Xl6HLwHE4caTNOZ8K5t4/HOa0QDcLxyWcakcAp4viqrPO4P9SDeCUdBGjG
 8ZoIqCB4yP/2iz57HyhC/mZX3ltN9RU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-GKD4MM1mMQqP9vScvQbN7A-1; Sun, 22 Jun 2025 22:17:40 -0400
X-MC-Unique: GKD4MM1mMQqP9vScvQbN7A-1
X-Mimecast-MFC-AGG-ID: GKD4MM1mMQqP9vScvQbN7A_1750645059
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2356ce55d33so53862125ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 19:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750645059; x=1751249859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVQNsnzkR4fy/0MFAc0InlJSrCjdz2VdJOThIkc6lIE=;
 b=SxAGjeup62FSUcif5J+hmIOuN+NJsZxyR21eRxcqc0IwxOyul/vEljF/7O9ozqMkGD
 WcegzEYDKeQhs6oUMoFgQqc+wQvD1cBmy92njzVkSbijJ7s6gqrM1Bvmg4FlV85j7fQE
 oBEIljKHquFBq68IAsnVAwFSAa7EBWBnPoBe1xNNh6xI04drObNMEegR0U6DACbD2Xyo
 lzk1H10F35UPPeyaKpEhbuqs5DOiuGOM+kilhOsdy4HjTq7Y+seWipwYFkFs1uf7sNEm
 6ZLWE1mmCtaelL77ChITuH7vcMSmw8ZAiRy6uEhA/3cvjlDfZQ5KABd+i1tW9Na3k4V0
 7wzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+8B90piSAE4esA2j8aQyI91BPO2M5dzb+8614zSXEAJTZ5I/Q9W3IOmNFnO/P6YuKwig7qWOwLEDm@nongnu.org
X-Gm-Message-State: AOJu0Yw2/LBnIKTcHX7IMwgdsgLJkc0uz0AP26Eru/myDtSwuYTOtTxO
 j/lc+oQ+4sgcAtGs4xeDpbqdyrn3DHOvUw9jrzaTJlloA8RGmto2pqsSnvb8dtxx+gH3HqzngI5
 St9J20wY8uO6ESUzLEZV9s27Y+lUut6IBhJ0pswc6Y/EG008uqtNTuGsw
X-Gm-Gg: ASbGncsOfepjhoNw3kd4h3RRUDQl+Td/rY5xjkjxh7VJoBczO9QOrvs4kTIgDktJTRl
 iSmS48Ntmr4qIGAU2Bh2LNCz//rFkXn526AFXq7zx6p8NFuctoqaGmxwybmyKPzKz6w9M2Z9NRm
 OYOMeuW9Mq8gBw7/UMp152+FtiMHS+MMP8lFzhNRLsPjdcKPdjvPRDbiBf/tX+6HX2hUIRbgq1x
 iXmq4hwxe1vmeB5iaq8buRBrncVpXERWvq54eStPMi5MYfxSP94DhA2GkHzROIUoVzOxj76Aupr
 Htr7t8lzTzcf1tVitZkdm4nkR14=
X-Received: by 2002:a17:902:d542:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-237d997a5aemr207642285ad.44.1750645059298; 
 Sun, 22 Jun 2025 19:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyMeb44jMY0db4e4nYjzaR8owVVFon/Hp2X0ZqUUGOIDy9jj7EU+X5AKaNyfcEffHIvKCzRQ==
X-Received: by 2002:a17:902:d542:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-237d997a5aemr207641875ad.44.1750645058878; 
 Sun, 22 Jun 2025 19:17:38 -0700 (PDT)
Received: from [10.72.116.103] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8695440sm70830085ad.185.2025.06.22.19.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 19:17:38 -0700 (PDT)
Message-ID: <61187896-f836-46c2-9f4a-4957b85f33b2@redhat.com>
Date: Mon, 23 Jun 2025 10:17:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] ramfb: Add property to control if load the romfile
To: qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Auger <eauger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20250617030521.2109305-1-shahuang@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250617030521.2109305-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi guys,

Kindly ping for this series.

Thanks,
Shaoqin

On 6/17/25 11:05 AM, Shaoqin Huang wrote:
> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> for ramfb, so they don't need to load the romfile.
> 
> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
> device, because the vfio display also use the ramfb_setup() to load
> the vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Then I set the use_legacy_x86_rom property to false by default, and only set it
> to true on x86 since only x86 will need it.
> 
> Changelog:
> ---------
> v3 -> v4:
>    - Set the new property to false by default, only set it to true on x86.
> v2 -> v3:
>    - Fix the underscore error.
>    - Add a new patch to set the property in arm compatibility.
> v1 -> v2:
>    - Change the property name.
> 
> v3: https://lore.kernel.org/all/20250609073408.2083831-1-shahuang@redhat.com/
> v2: https://lore.kernel.org/all/20250606070234.2063451-1-shahuang@redhat.com/
> v1: https://lore.kernel.org/all/20250605030351.2056571-1-shahuang@redhat.com/
> 
> Shaoqin Huang (2):
>    ramfb: Add property to control if load the romfile
>    hw/i386: Add the ramfb romfile compatatibility
> 
>   hw/display/ramfb-standalone.c | 4 +++-
>   hw/display/ramfb-stubs.c      | 2 +-
>   hw/display/ramfb.c            | 6 ++++--
>   hw/i386/pc_q35.c              | 3 +++
>   hw/vfio/display.c             | 4 ++--
>   hw/vfio/pci.c                 | 1 +
>   hw/vfio/pci.h                 | 1 +
>   include/hw/display/ramfb.h    | 2 +-
>   8 files changed, 16 insertions(+), 7 deletions(-)
> 

-- 
Shaoqin


