Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032EC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 06:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnCMQ-00057o-LQ; Thu, 21 Mar 2024 02:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnCMP-00057g-6q
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 02:57:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnCMN-00069k-Fk
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 02:57:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4146f2bf8ecso4263405e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711004225; x=1711609025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rrRYwR55NiY1Cvn85AP8/S7wGxZY+Y2NuNxJaJGUMXg=;
 b=f3oqM3M2TtTgUenJSHMsIMh5NDlhHAOdpdq4q2lxagJu2mOp+uaJPtj4p7K5RJBOHx
 Ofv/6pAoJ78XroNPXGxhd0jQQK2E4gdmDntU5KIiDO3F6FeCR/DVq1XYiCQrSt7CTnSU
 66ymYn1NaoxRnx3GwW7NbRRQ9v5etX6w2MsnsYot6ytHn0dDbPMC9YWmQxtFiIxfCIVb
 spKhrvoP1TKK8cuZnk5Pyt/33tk6b5dbmQUdbrtqAsc4g0838zMwp7e+413i0wpolJVQ
 FK31qncZuTgaVtCscmvywEA4Wq1E4MTe75uw9+lL37H0H6oL5w/kkJqhZPZrIxLhLHU6
 4PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711004225; x=1711609025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rrRYwR55NiY1Cvn85AP8/S7wGxZY+Y2NuNxJaJGUMXg=;
 b=u4e60EeMoeDPa83mIULVSfM12MDlwPTDdvU3Q88DIEx/qZnPMdHWRZjqfmUniOXQDW
 fhKHXi57NOZa8/baNOsKyfkE1V1t5yVtCcDf6PZqIg0mzg8Leze8VuzxK8gevW6H0gVg
 7cgGZvwnB+tg8x3qLYJOS8oAED9EFk8N3J5yg9k51P0qW3ZF3d+g+h2W+md5JSMurrQS
 hX6O3+UJSW0EgLbJwQqyyjHwnh3mUR+/qtqr1d7n1WVKgJAjntE47hh8XXZB2RCndWi0
 Ph3m6FarvH+lTdgfcGY4JH/FN5kshVOHvlYvPeq3qeV6R4pVhEARWP8erHlS0ECSETy4
 UIMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuA7MACjFaBJkPJ15z5ABUThNoNDroarFw+CxS1nmes+N4ltL5Pc8qG37ewiWrz2hUP6Ia1ULb10wSfq145mDrLOMRw58=
X-Gm-Message-State: AOJu0YyKDilJssXHgQLKrETbkwBuwP5r0siqF5c/kYfZ+auv5ft+pAda
 ZKzZ8PD8XeUZqPCe6qTpAaC170QVNFz+eG1yEqkr2/UvZanoX8d+UGAhs81pBpE=
X-Google-Smtp-Source: AGHT+IGosq1yAErrE/aGOgPGW0qDZBDNZPDpud/meEIBg9Zj++OrZ2dERc840NzkzdRTqea1lAoK6g==
X-Received: by 2002:a05:600c:524a:b0:414:f6b:f8fc with SMTP id
 fc10-20020a05600c524a00b004140f6bf8fcmr8927855wmb.2.1711004225192; 
 Wed, 20 Mar 2024 23:57:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 bu27-20020a056000079b00b0033ecbfc6941sm16233834wrb.110.2024.03.20.23.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 23:57:04 -0700 (PDT)
Message-ID: <9617e174-1aef-4caf-9f15-2ce3c455527c@linaro.org>
Date: Thu, 21 Mar 2024 07:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Content-Language: en-US
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320205018.3351984-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Dongwon,

On 20/3/24 21:50, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> QemuDmaBuf struct is defined and primarily used by ui/console/gl so it is
> better to handle its creation, initialization and access within ui/console
> rather than within hw modules such as hw/display/virtio-gpu and
> hw/vfio/display.
> 
> To achieve this, new methods for allocating, initializing the struct, and
> accessing certain fields necessary for hardware modules have been introduced
> in ui/console.c.
> (3rd patch)
> 
> Furthermore, modifications have been made to hw/display/virtio-gpu and
> hw/vfio/display to utilize these new methods instead of setting up the struct
> independently.
> (1st and 2nd patches)

Thanks for splitting, unfortunately the series isn't buildable /
bisectable since the methods use in patches 1&2 are only introduced
in patch 3 :/

> Dongwon Kim (3):
>    hw/virtio: intialize QemuDmaBuf using the function from ui/console
>    hw/vfio: intialize QemuDmaBuf using the function from ui/console
>    ui/console: add methods for allocating, intializing and accessing
>      QemuDmaBuf


