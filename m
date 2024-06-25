Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B45C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0Dc-0008KN-7p; Tue, 25 Jun 2024 03:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sM0Da-0008K3-SN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sM0DZ-0006qG-Dt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719299032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prUB9TZ1uXehfDfJTeMYXbWjvebNH0RiEaVF6urJeH8=;
 b=bj7HclnTvSYH2NHNf7xo/aqWCkPSykzLKqzmLuGHYpqgqJYCYDpRB7/+p0pRnX+pZq6400
 iJo+JgKj+LYcnFVRzxVSudTp9yH9/DNLekPXC6dc1goy9lpBX+NRyW0e3lCUB4wnDy44Bb
 LcdLFSzxLPGEiPBuUp817VgSGM1/HDk=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-NZEKeJonPTSlc4rOkVfMsw-1; Tue, 25 Jun 2024 03:03:49 -0400
X-MC-Unique: NZEKeJonPTSlc4rOkVfMsw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4ef8e5bdbb0so228583e0c.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719299029; x=1719903829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prUB9TZ1uXehfDfJTeMYXbWjvebNH0RiEaVF6urJeH8=;
 b=QHFx4dbw6+tcJrdw7w67oxeDnPC+T7MQJ5SU+xIskKohsxps9sPVhaeJlnMerQr2Fk
 yd4t61BCWB7Y+TwA60EfiBgLVHXaFXZD+PeOkd/wkdzwGBQAAlXo0pXmFDFKIoGM3DXC
 vXca0/OebJmN77222a05ZaUa4z6oJKr0vl7xbHf6N86g+/CoddM6R+WBHjagAxTPYbF/
 Ec/LDQe5xPagOb8IeYlDgQjIo1G6irkodoUOwxD8ns6g/n/6EY1dD0MGMuCwhNd9RG92
 cyZTjgtyOr2XqUyNROBYmXwVI6K2NJRDozPvE6E2T/PHh0osMjIUWcHJE8FpRd0dU15S
 beZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLR5a/7KsHyuqTWfG4hT431tjj2/28qgMNzjzi4rywgKd6Aa+nzTBZ+0/JZhU7PNn84QnOEQ8OQEZR09+2iPF/47XAaGg=
X-Gm-Message-State: AOJu0Yy2BJttsw1fDohMeF/UHXBUk+RBterxgjoFt03Gw4+an/yRbGbK
 adS3C5N9RKV6I3BYYGV6+N5gQpfdY7WmqU3+gvjK3G9Xk3GPURqDGLwoEJ3ZsDkicZHAr2mj5v1
 Znk+0jg7X7RAA1kHjtH00q7CEATw7V+PoPC7kM3Kg+AZ+LO1CLoAL
X-Received: by 2002:a05:6122:2a52:b0:4e4:ee60:a60b with SMTP id
 71dfb90a1353d-4ef6d7d0a70mr4648124e0c.3.1719299029352; 
 Tue, 25 Jun 2024 00:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3vfWJxxKgb8XG/5/3X3wkUKDDw23Ff38rsXjSbzUE7LMfqcRr+uc1zwXV0MBJOPfGL7Iy9Q==
X-Received: by 2002:a05:6122:2a52:b0:4e4:ee60:a60b with SMTP id
 71dfb90a1353d-4ef6d7d0a70mr4648112e0c.3.1719299029019; 
 Tue, 25 Jun 2024 00:03:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ed7ed94sm41949326d6.73.2024.06.25.00.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 00:03:48 -0700 (PDT)
Message-ID: <b8c21f7e-632e-4480-a468-1d2153484c79@redhat.com>
Date: Tue, 25 Jun 2024 09:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] hw/sd/sdcard: Accumulation of cleanups and fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20240625055354.23273-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On 6/25/24 7:53 AM, Philippe Mathieu-Daudé wrote:
> Since v1:
> - various patches merged, few more added
> 
> Various SD card cleanups and fixes accumulated over
> the years. Various have been useful to help integrating
> eMMC support (which will come later).
> 
> Philippe Mathieu-Daudé (12):
>    tests/qtest: Disable npcm7xx_sdhci tests using hardcoded RCA
>    hw/sd/sdcard: Generate random RCA value
>    hw/sd/sdcard: Track last command used to help logging
>    hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
>    hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
>    hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
>    hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
>    hw/sd/sdcard: Use READY_FOR_DATA definition instead of magic value
>    hw/sd/sdcard: Assign SDCardStates enum values
>    hw/sd/sdcard: Simplify sd_inactive_state handling
>    hw/sd/sdcard: Restrict SWITCH_FUNCTION to sd_transfer_state (CMD6)
>    hw/sd/sdcard: Add direct reference to SDProto in SDState
> 
>   hw/sd/sd.c                       | 119 ++++++++++++++++---------------
>   tests/qtest/npcm7xx_sdhci-test.c |   7 ++
>   hw/sd/trace-events               |   4 +-
>   3 files changed, 70 insertions(+), 60 deletions(-)
> 
Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




