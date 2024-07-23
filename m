Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHDM-0007oz-0B; Tue, 23 Jul 2024 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWHDI-0007lA-3S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWHDF-0001kb-1e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721747638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1Hf9HZiStN9wf6zFMcCkdptIqgYTUZuiXVyaTP5do0=;
 b=LcyklUoq5udeF1pLkdvKMcD0bjLOClg1lJFYCkF45mNcldZJuyMPNxyquuuAhUdRCnyUVP
 k5TEklLi26LIkjtJYQx/2w+DyFpJbWfr6exMoHTTwMJyGOrAZ4DXW7/alrS1OM1SZvNbxI
 qb35ddCezsludGjFHdInLqH8IMWmZug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-pNMKf92lOJ6AaeDiTdMhrg-1; Tue, 23 Jul 2024 11:13:56 -0400
X-MC-Unique: pNMKf92lOJ6AaeDiTdMhrg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265d3bf59dso40276185e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747635; x=1722352435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R1Hf9HZiStN9wf6zFMcCkdptIqgYTUZuiXVyaTP5do0=;
 b=Wx6b51q00O+Hy4GjN5hF7MCiRA/o4dUZdSI7J6VK4p78i0nXXsp70J5rF5aeYCiYO5
 x2LBvgJTQijNBGr6rEVXoLMTObmQ60IEyofxi8sOPemGJN/is8DCDBRSNA7APxS1Qtgz
 jcbTpmrsUwS3JbNiFPrDCRtfWglme1/L4UaZkRoqQwAqxpwnK1kMfGiQd8p8kGaRUhb6
 JRu6DXbDUp97Uv5VEeScIibN8SS9Veof9tRKDExmErjBSFxu+xx2kwr+HK72kQVII5I7
 7P4lt5/35A10UTyUheKwpO1RvbemYMnu/GyYDb5gTh6P0BV75e8JbYPdXfhkqEa+TwK8
 Pl0g==
X-Gm-Message-State: AOJu0Yz0CdxOl6XL/xfhWRxwlYrimb8oa7uiV8RjkVaibtjYKkPfevCi
 lh1GFYvj34FiuhEhfKhlXCCqY8/0RwcXXW5+auOfZvS6wKsnfhNefjPGix2SPzTJfQRc4c/klAc
 ysCBjPGOt/uNTzbJAV614oj1r4LaYBnK5nNf8FXUVu1nvsed7QaNnUew0AWbiKG77vQ9VcuhP3p
 i885VlYGF+8wiOD5V78IfRZuRg0iwyLA==
X-Received: by 2002:a05:600c:500f:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-427df7a7828mr68323295e9.29.1721747635405; 
 Tue, 23 Jul 2024 08:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGJ/RXS3vSQYk5CM0XmsP4A9mvBUZpCwVkjrf5QENsxK+2irhx+b0SS+HJSf5wpxF79PSO5A==
X-Received: by 2002:a05:600c:500f:b0:426:6326:4cec with SMTP id
 5b1f17b1804b1-427df7a7828mr68323085e9.29.1721747634977; 
 Tue, 23 Jul 2024 08:13:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebd50sm11748420f8f.93.2024.07.23.08.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:13:54 -0700 (PDT)
Message-ID: <aba2bede-c727-4def-8cad-cb0daedd708d@redhat.com>
Date: Tue, 23 Jul 2024 17:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] vfio queue
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/23/24 16:00, Cédric Le Goater wrote:
> The following changes since commit 6af69d02706c821797802cfd56acdac13a7c9422:
> 
>    Merge tag 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu into staging (2024-07-23 13:55:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20240723
> 
> for you to fetch changes up to 6ac9efe6805af60de14481fdde7d340080d38324:
> 
>    vfio/common: Allow disabling device dirty page tracking (2024-07-23 11:10:10 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * IOMMUFD Dirty Tracking support
> * Fix for a possible SEGV in IOMMU type1 container
> * Dropped initialization of host IOMMU device with mdev devices

There is a problem with an email address in patch 13 :

    Reviewed-by: Cédric Le Goater <clg@redhat.co>

I will repush an resend.


Thanks,

C.



