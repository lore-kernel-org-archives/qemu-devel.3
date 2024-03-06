Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D77C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyBi-00070g-NW; Wed, 06 Mar 2024 15:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyBf-000700-KN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:48:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyBe-0007Ub-56
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:48:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41307c29eaaso1666425e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709758104; x=1710362904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=clW4tepOhz4bwtSCztep8nMjoY4jMCkBoy9loVNxKzI=;
 b=DGUR0KMpJihQ4DcbPnVmV6UmlAHpFHFfvpcMM0i3UybxM+ZZQZpg1fzx2Y984s88Yp
 Oy8d9jnutf3VpWaUm2mlSC5LqeNTDUkvw5SwIZ+2Uw3qykOTcuFiRpXoNhWyZgudo+Bb
 pJvPZz2s51NflQG2KWSHJKbH8OmLKtFWrW4nxX8IyMp/003cQsdXG6psWQ/S4PMdJHG/
 RbmXkRqyupLzLH7qaFU8Nn3mXwKEstfLffWQThqK1gBvq4zwpw6wojfMAzhU4cmCV0iF
 DGdy2lkPOBJDsxuZDrFrlE8Ecp+zQO1HFeeinCp5ODBIXqYsjdHF7Mc3om8lRmqQsi3b
 U41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709758104; x=1710362904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=clW4tepOhz4bwtSCztep8nMjoY4jMCkBoy9loVNxKzI=;
 b=K4CRFzciRZNKZKmwFukvAFB9CKJLxT0mGeXgDEOMRRsKEBvq2xTvQ5j77khygrQiOm
 uNBBew0JD/cDYuC8ZQK+S/oIXeD4fHA92QqUPd2O44NrJNKzASYe8H4ztJr6o1naxgYN
 QFWc+rDQJFd1wi4tgMt/uDk49Spn1Sx3H+Qy4vgPpiL4KiivSUkKhMCT0W1G2b+2Fg+/
 WqVwarukSqfK8NvcrLl3y31wT7gHtqhhejogeb+52Md8dfpWWODtPxgPX05RS7hW4YMX
 X/ToxfKPhLYhqL9ymtoEcb65pxU4hC32CLFUa0Sfve3WNu9l7OzcCIP+dI+MKnVF9QW/
 ey8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaUYizn1FlgRsmaK1r5gV/XtCa4r5H6O1wm3fpaRSB7Mfvu2Y6zz66v653JNJjZgti11eJv6BRnKiDSjbTJoUP1RTaB0k=
X-Gm-Message-State: AOJu0YypSfmhJpbFH8rwrnCd7IQRBtpDKqaUJAy2Hq0WChdj1LxT1u3a
 VG2QtgQYgWWtrbSY3F+/9qoq8l8euWVGPn2uJ7sxqyCMODzsJku6W4ExYJlgZC0=
X-Google-Smtp-Source: AGHT+IEFEsp6Rl9/OS07geuRNFLZ2Twmx04RYfW4YP574WKcumJd9jc1Acw2qmviDzQJWJyqzRVgFg==
X-Received: by 2002:a05:600c:46cf:b0:413:88b:c10e with SMTP id
 q15-20020a05600c46cf00b00413088bc10emr468516wmo.20.1709758104559; 
 Wed, 06 Mar 2024 12:48:24 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 n15-20020a5d484f000000b0033dec836ea6sm18505929wrs.99.2024.03.06.12.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:48:24 -0800 (PST)
Message-ID: <359b4559-0ba1-42b9-8292-c90d65043898@linaro.org>
Date: Wed, 6 Mar 2024 21:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] qemu-options.hx: Document the virtio-iommu-pci
 aw-bits option
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, imammedo@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-10-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306203348.65776-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/3/24 21:32, Eric Auger wrote:
> Document the new aw-bits option.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> ---
> 
> v4 -> v5
> - tweek the aw-bits option description according to Cédric's
>    suggestion
> ---
>   qemu-options.hx | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 757df3eac0..87959ede08 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1180,6 +1180,9 @@ SRST
>           This decides the default granule to be be exposed by the
>           virtio-iommu. If host, the granule matches the host page size.
>   
> +    ``aw-bits=val`` (val between 32 and 64, default depends on machine)
> +        This decides the address width of IOVA address space. It defaults

"It defaults"?

IMO this should be squashed in patch 6/9 "virtio-iommu: Add an option
to define the input range width".

>   ERST
>   
>   DEF("name", HAS_ARG, QEMU_OPTION_name,


