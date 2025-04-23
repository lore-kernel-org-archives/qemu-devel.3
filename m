Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E0DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y8r-0008Mh-2U; Wed, 23 Apr 2025 07:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y8n-0008HC-Ud
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:19:46 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y8j-00025Z-B7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:19:45 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so162430066b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407178; x=1746011978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NvxQB+bQzj8Mx5HM6pMKDFDV8zvY34xjyx3a3bpAANc=;
 b=QEC+0pJFfA2+Qjtj+qJd3accyYEg1pObMZWSdmAMzz2O2/vzzboqEq/F0lRzm+j2sX
 INzuxCjdwuWsVXhvxFY9AHgbKNEQ35jR1IUei2OEgn02QsSX+NIZrp1cVzepsL3H6jnb
 v/Zkem53Sdi4F+SQVbs/NXwPrypzt2KLuDzI8ts2o8yYtDXE8StVrsia+qY0vZV3rD5x
 cHEo63ATfeuqW16V2770KhpPGMm2D7vQDbtu0EUNr2pF+hjcvscKYIOLErrMhiaSqg8+
 UCs6tJgudPPVPxN0xBvv8bZ5ZlnBuWj8cwquIAGByXsLHd9Ji805j3yWeWr3tHB9+11t
 hmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407178; x=1746011978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NvxQB+bQzj8Mx5HM6pMKDFDV8zvY34xjyx3a3bpAANc=;
 b=EKVHHNf5aHnHe6eN4CvvZI5ajl0bp2HNcokX2Zlm2ERl2ki7zcEQvJZhPudQqqsz/Z
 GUfEco1qVCNw+mTdvp8+Qqae/10jiUJUnItm4UvLPLv/DnZkanmfuzbGU0VREnHO7nTa
 jYmO9wocLwUxltKg1/Yd6TWiwmRoPjsnmdlRGoZtHEmAjmf1g3FVp3uTUsItkw75TB+H
 0kqTz3HUGj6QMK/IsDRbWgWs6+hQYweBX1yzGTxIMitYjFrnM6OHzvWYeDmLBOUEyC6p
 kgOKLKQEGuYH1WJZpM4ZvE5UZxmVjtVy6rWzv/ZSOTOcWW8IP+c6Ebu30fnrv0B4IsH7
 4A/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvH+hgEd6aU7BcEbsumXS8STZ+0UnrKAQGD2XHh3lUmSAx2gbIqX4Jlp+Ujdw/DrgRt9/3Csfuxa9x@nongnu.org
X-Gm-Message-State: AOJu0YydGMBJI/GAFsgXKsZilyF3qcofraAqpQKZ5adngQNoJncqhVTX
 Q5gejyjtq7nnT3eD7tMOjI6Y6PcOo67mjwLrJa73TBYZZBDhCcSzPilAtOk9jb8=
X-Gm-Gg: ASbGnct9tfJtZMUsx9H7yndF454LSH2AUZ5jB3IZOQeoXGg3+SwFSJMHCQsArl50Xlg
 DCZZOgHB9or+jhgmifqjDaO03zIRKXRvAmEl9Kacuamdn34POFT6xhYJhfRxkDLHqISTH504fE8
 JAqM3tOMgPSESnewSInYVFqdieuuwmLegxbLhi5RJdsD7UE4AYEqfHnG3sr7fbwTQ7KQNFcWRc5
 YxkbD5Wqp5Yh+f//g/hRQJ2hG1rLxAOrOF3+hMB68xZO+2g6clk0SQy0AwEduyqQI1uYUF0UZVO
 zWbJls/thTnmMh5M5JKwwyEiU8yPFmKpwxoJxMOja61uYov1AdupU4oQKYTHzjSJ8U1hRydkCWv
 96XpYiB27
X-Google-Smtp-Source: AGHT+IGli2bBU26BvyH0AxS9pMQWZUCRqG5FRPFGua0puqq9daSOhNsGZmRQqWXEiMeMyuF8SNHrWQ==
X-Received: by 2002:a17:907:d17:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-ace3f5581b4mr163004166b.24.1745407177992; 
 Wed, 23 Apr 2025 04:19:37 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefcf0asm799868466b.103.2025.04.23.04.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:19:37 -0700 (PDT)
Message-ID: <7a855f49-cf46-4a4c-ab5e-91d79a11e235@linaro.org>
Date: Wed, 23 Apr 2025 13:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pc-bios: Move device tree files in their own subdir
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 23/4/25 12:02, BALATON Zoltan wrote:
> We have several device tree files already and may have more in the
> future so add a new dtb subdirectory and move device tree files there
> so they are not mixed with ROM binaries.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   MAINTAINERS                                |   2 +-
>   pc-bios/{ => dtb}/bamboo.dtb               | Bin
>   pc-bios/{ => dtb}/bamboo.dts               |   0
>   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>   pc-bios/{ => dtb}/canyonlands.dts          |   0
>   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>   pc-bios/meson.build                        |  23 +--------------------
>   qemu.nsi                                   |   2 +-
>   system/datadir.c                           |   4 +++-
>   13 files changed, 29 insertions(+), 25 deletions(-)
>   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>   rename pc-bios/{ => dtb}/bamboo.dts (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>   create mode 100644 pc-bios/dtb/meson.build
>   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


