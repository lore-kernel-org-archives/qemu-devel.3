Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34781C19F53
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o67-00063l-57; Tue, 30 Apr 2024 10:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1o63-00063D-Ku
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:04:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1o61-0003PF-3m
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:04:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3499f1bed15so4043569f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714485875; x=1715090675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WF523ujNsXw/FcEr9sUzMrB3X35rwcy5DrlPYGIG5Nk=;
 b=lbW3xnBabXcecZnGWEXoE3RyMHRFDEEg4mLsIbO8wS0iuQVm2RcpnWdyMD0L8LNwDg
 +9gx31cAJGgFdHVRiAP13Qmu42VVLUQmsOfe+EzLxi2qY5b37OFzreGRgqTP42LalHh2
 jRmc3Wlw8mKNOwC76CEphgzTSyBZcxN6b1TZ68A9z0ZntfD0vSXZaPED0i5xROfXVGva
 dDyMh5IvFg72eKWOa1Wj7lzB5UnnkRCLNYlF3o8NZPPQnv/7WhB371xnmXLvXO6miXH9
 ylZXvUBym9OE/D9DZaT3bdvJMxICN/MTX5IM08I1D4/l8jmpkgg0oiWNEP8682WOGhY8
 IwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714485875; x=1715090675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WF523ujNsXw/FcEr9sUzMrB3X35rwcy5DrlPYGIG5Nk=;
 b=h6h6WJcyarJDPfLslvOLJJXg1VnihlLnDHacAGSq1Z1pmAozgo0x3PZzPZ1Gqw3VY2
 vT2wtsY0LPFmBZ3V1UR9HweFvx2aYPR85PZURo/k8IyEivsTLO5gMvJwSoaOVg+m7oXs
 ntq7WwCworLQfaNTj/FZIcDLEc5/iECKpa41etCdYSn1PH09QKwpbXEW757fI+HqD1Cy
 9oOqsXG+er9+zSremvZFVmoGaCUCjIVZagny2s8ePr2wKlAWl2y3F5xFSbiXHYUyDHUP
 pc5eitU6rbQLIJTdxzhM9nnkkjTFxrBUfK0ZGGnYghA4MKVtcUW3klofdcAa8gEh/36s
 D8/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFBo/mFPjHjQ5YXxSqB8Ezccgv5UQqqmr8IpoRUO/mYmKJ62KoWESZ4pV1PDpl8bGYOGjq/5s6ia/WrFVXB/xkhL0D7u4=
X-Gm-Message-State: AOJu0YzQRPnU9JCKXnYUwzOcJXg8R0y2Vc6BOmNro54oWKqw1j3985rU
 sDiRWqdkGwa+5ltGTQF71YjNTRUyFvl+xDZmicIgFn3v1uFBlv8L5JrK0rrJGC8=
X-Google-Smtp-Source: AGHT+IEim83wsUz+5m56KA+8Pgr0/1+utbw5/glKZhQSGOSmh+PiP0fcP2uXe0Qa+zoeDwW3rJoKaA==
X-Received: by 2002:a05:6000:1248:b0:34d:a0b4:d122 with SMTP id
 j8-20020a056000124800b0034da0b4d122mr1287673wrx.30.1714485875091; 
 Tue, 30 Apr 2024 07:04:35 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n2-20020adfe342000000b00343eac2acc4sm32165038wrj.111.2024.04.30.07.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 07:04:34 -0700 (PDT)
Message-ID: <b67cbe5e-2ea6-46bd-aa9f-9038d6a31c42@linaro.org>
Date: Tue, 30 Apr 2024 16:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc'ing few developers who touched the intel_iommu model ;)

On 22/4/24 17:52, CLEMENT MATHIEU--DRIF wrote:
> This series is the first of a list that add support for SVM in the Intel IOMMU.
> 
> Here, we implement support for first-stage translation in VT-d.
> The PASID-based IOTLB invalidation is also added in this series as it is a
> requirement of FLTS.
> 
> The last patch introduces the 'flts' option to enable the feature from
> the command line.
> Once enabled, several drivers of the Linux kernel use this feature.
> 
> This work is based on the VT-d specification version 4.1 (March 2023)
> 
> Here is a link to a GitHub repository where you can find the following elements :
>      - Qemu with all the patches for SVM
>          - ATS
>          - PRI
>          - PASID based IOTLB invalidation
>          - Device IOTLB invalidations
>          - First-stage translations
>          - Requests with already translated addresses
>      - A demo device
>      - A simple driver for the demo device
>      - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
> 
> Clément Mathieu--Drif (7):
>    intel_iommu: fix FRCD construction macro.
>    intel_iommu: rename slpte to pte before adding FLTS
>    intel_iommu: make types match
>    intel_iommu: add support for first-stage translation
>    intel_iommu: extract device IOTLB invalidation logic
>    intel_iommu: add PASID-based IOTLB invalidation
>    intel_iommu: add a CLI option to enable FLTS
> 
>   hw/i386/intel_iommu.c          | 655 ++++++++++++++++++++++++++-------
>   hw/i386/intel_iommu_internal.h | 114 ++++--
>   include/hw/i386/intel_iommu.h  |   3 +-
>   3 files changed, 609 insertions(+), 163 deletions(-)
> 


