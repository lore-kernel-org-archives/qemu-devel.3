Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73B0C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLYg-0004Wl-FS; Thu, 16 Jan 2025 03:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLYd-0004Mq-Ic
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:48:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLYb-0007fK-N3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:48:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so584322f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737017332; x=1737622132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mdLioY+9uv1wNXZ89MB5hjYXgSWhJls88d7Z7LIFuhE=;
 b=I9gs/Or5GphmIaHEwzUiGbNDV2RfBRQpp7JZDs37td2mLqhgl2tIyPe1elG6R6HfEl
 BME+rfxRwrxyOe68VnwSQoG46b6kA2MnVrLIp2KGZzjDuqH0Vog2Siriae0Ii6OYdR+J
 J/woEHuNuNHBSJ7jjrypT3KH22VTnMW/u2GQWY18NeLmSYIxEeCe1EhOcqi+EYpUjW/p
 KIjAKsrZCvlj8HSIyQwVv7VWDy2f03vHN1tg8/tjyW7ikiJuTWQ0BahW7Toj9Deq0cOy
 OEVnhdhpek3GTkjattG2mjPLMpKMstwM1kyqUzoDxWKkbeUkri4zPKu/ap5gFfWgnyL2
 aTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737017332; x=1737622132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mdLioY+9uv1wNXZ89MB5hjYXgSWhJls88d7Z7LIFuhE=;
 b=wE1huedWMXM9a814F83m7j3b/1WvrYiNQD7hFJSwzLzXNC5JCkkFxJdXwf27kKyG9T
 E7uoQgAdkU8LokYHoJv5JPPJXWpabnyDDArNLaJdBnXFfalHM0Nn2+0dmNikZiyCh9RO
 JuF6WqylOYc914CR8ZQFnrB0lmtiBJphTwwUFnGiaMSYuIUWL1jVdB8nHeUvGurRrz0I
 2u0EyqF47nBcx8W34noezUYBMUcFjFENn7sPdggvywkhJd42uZa67ho62W/Peynv2UCT
 Jlvo1rm/hEvP06BojQ2OuKcKmUa2GH5oNJPBC+NxU3kkgTu5lJLxcKSZa3FQW60rNmue
 0afA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3I9HKxaRfSXX4wIL3dTvAhi2xc75XQpAsgObeFG1EWN+X88No8Jwj8n/LK/nPZkL95+nk5K528DZK@nongnu.org
X-Gm-Message-State: AOJu0YwuJRIiZ3DQeMyAzD31NKpv3PgQmhrDcN1mF84SDIm3LFSeIzty
 TCWbVnFXOIaWalWfGOwombrhtfehROTikOOiYDiwGTsr4PoTDPbNwb0OUIVWbTtmnYal/ClKNMv
 Hxw8=
X-Gm-Gg: ASbGncuqW0RKzRg/piI6CWtOYKfrjpu9zxXaSbKgyLFDMElo+UhOmem5bhg731r31C7
 ZGHeL8BHrPzT4SaXJ4HeOA3EaRuVowGaif07CgqUnOeysximiFM0LGbknLwXejMDBwRt+C6F22+
 ThOUP9DH3gASL/CDg2C2O8UFbKuqlmpSTIeCYuPVWmcvY8dOBOfDJvjfyzEYpR61xfde5cOdyla
 DYWus4CkgXKGe1WvFBs4nltq7XuGpw4jTFDN255N8SwyDFMn3gR8dXFXM36NYjfFLJhawClbEWs
 NfVNIALSC7YOPhuDova7Xh7g
X-Google-Smtp-Source: AGHT+IFc0EGequubUfPj4rYEF3Cfvc2asamzIKmcVagKU7Nw6WMSqtPpF3Pz2I7W3PLpeLhcYSBx7g==
X-Received: by 2002:a05:6000:1542:b0:38a:a047:6c0b with SMTP id
 ffacd0b85a97d-38aa0476d5amr21977610f8f.35.1737017332025; 
 Thu, 16 Jan 2025 00:48:52 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38b15d3c7a5sm13512605f8f.32.2025.01.16.00.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 00:48:51 -0800 (PST)
Message-ID: <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
Date: Thu, 16 Jan 2025 09:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20250116064644.65670-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116064644.65670-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 16/1/25 07:46, Thomas Huth wrote:
> We now have a general note about versioned machine types getting
> deprecated and removed at the beginning of the deprecated.rst file,
> so we should also have a general note about this in removed-features.rst
> (which will also apply to versioned non-x86 machine types) instead of
> listing individual old machine types in the document.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst       |  7 -------
>   docs/about/removed-features.rst | 11 +++++------
>   2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962..7b42d6eecc 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> -``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -These old machine types are quite neglected nowadays and thus might have
> -various pitfalls with regards to live migration. Use a newer machine type
> -instead.
> -
>   PPC 405 ``ref405ep`` machine (since 9.1)
>   ''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index c6616ce05e..156c0c253c 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
>   System emulator machines
>   ------------------------
>   
> +Note: Versioned machine types that have been introduced in a QEMU version
> +that has initially been released more than 6 years before are considered
> +obsolete and will be removed without further notice in this document.
> +Please use newer machine types instead.

This is an improvement. I still wonder if we shouldn't list them removed
machines here, to help old users.

   Removed in 4.0:
     - pc-0.10
     - ...
   Removed in 9.0:
     - pc-i440fx-2.3
   Remove in 10.0:
     - pc-i440fx-2.4
     - pc-i440fx-2.5
     - pc-i440fx-2.6
     - pc-q35-2.4
     - pc-q35-2.5
     - pc-q35-2.6
     - ARM virt-2.6
     ...

?

> +
>   ``s390-virtio`` (removed in 2.6)
>   ''''''''''''''''''''''''''''''''
>   
> @@ -1006,12 +1011,6 @@ mips ``fulong2e`` machine alias (removed in 6.0)
>   
>   This machine has been renamed ``fuloong2e``.
>   
> -``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -These machine types were very old and likely could not be used for live
> -migration from old QEMU versions anymore. Use a newer machine type instead.
> -
>   Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
>   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   


