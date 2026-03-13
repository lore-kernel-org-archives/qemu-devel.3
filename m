Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D7106FD6B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0t4y-0004bd-Mr; Thu, 12 Mar 2026 23:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t4x-0004bK-JU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:20:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t4w-0003XZ-0s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:20:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so1185527f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372044; x=1773976844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=okhD1q11AgmnUQ1ll05otEdOHkzs6qpqtA4IfS7Xk2Q=;
 b=qsNyxOAE1xuMXHP1oZwVvcd8REixZ0XT/kwJE+2Gsu6S9dCUmAq2AmRuOzRPuvB6F0
 fKtps8xNya06/C5ti1vujOYAd1+DhAxhiwxRVvGG/x7tAsg71WdWTVmXN13NGTX9IBtf
 1kcenXNC4RrwmxTCyitfXvqzrQ4SfxeHRUI3r4Kpben8M7qpKwSL1I3nkpNr1o9httTG
 wdVzJbcpM6aezvrK7uHW9f5RqGFUPmLkMX1nkvx42WRtdoaLSUyCDLfEQJKTggIkPK+X
 fpJmH24mz7+PX2G1LItjo05nl3o8Q+EAmRe1Uvkj18rq4WrCkYA6w5xKIv6ZQJ1gVjoh
 d18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372044; x=1773976844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okhD1q11AgmnUQ1ll05otEdOHkzs6qpqtA4IfS7Xk2Q=;
 b=se2noa+na7fb4sZiX9Ad9uMZHDYx6mGYWmUaGyvc9EVwT58bRGUdANxSiSGhf+ClH9
 1cGZgjwcjIPseaoDT0RUMD62kIsVGobNi8YPlIaaVoScK62sAsbmTI8yc01F/SRd0NNS
 85/dUYcetR53rWUCii5CIAaHOGgC7dnKf0lw5hiMAFcS09ZCes8wjT+KIYKOr9vRhsb5
 MpXVlMcSlAIZ5YuyyImTqjO30NdeZAKmdwTi6+OqbqC79H4Y+f9PnXARaxi3PLlmOgZ7
 x2TXzaLgo7MZkX8TH3r+VcYLk/GP4mF85nddz7v9+er7HD9xF5ch4YwlUqxmQqcdlvQr
 eY6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe1LWHV+/QVifkolsFQ+kuFOQUaVPPGBSfaLGeYVhqgFuNkSIGYMIXrZWCjysiwOs2Ib6Ia1qcmfPi@nongnu.org
X-Gm-Message-State: AOJu0Yy/lGYeu33trRAT1XC7nN90J9bcQxjQsd4EIK2MYC0YjPl2kw10
 6AEik1cpKt4Qupxhq3Gn1sldN5nTS0pC3uY5QBn545UBFjIleMZ6sBi1eNbd/eHt6YddbYY06xT
 x5s5g2vk=
X-Gm-Gg: ATEYQzzKneD4mOcsDGvhDYUetlHfDI/qiJM1I7o5bHKiDxXBCQtl0Z/iBxY2gyie6kU
 4XdCaxUyDv+PiXkXOSQ3F/K8bPrzNOzCj3RT9ui9iHpcon30memFNfJRR6Ldifw8PNYuN1TFWa9
 i4q49W7k35KBvU6EgbHSsi5CL0ME+kBN87AsuN/01aL9ybC+SkzTgnY+egEWoAavccoP6a1NCay
 mI6nc/qdquwV4C/vG8f+Xob2YHwFoXI5mPag45phfN/rdRH8WvdcKquH+MJ/QkOduYSIH0ILKqy
 BkSsQDTv8bt3aVrdKA5iiU3zKmIlDoOfvIVYa7OXxociRRts820NieLji6qEdCqYuwc+nTQbFkk
 aLsFFL3GMQiWqfCvT521+m3wrlSEwV6j/Jp3wPVvXCVhdHNWecC4jmtllM2vhqEVtSx2K1IQEXQ
 R0DqnztcLzPmKjG6I4/GzD+b4lYBMDfllMcnszSU69ile5WLtG4bvkBDgSym5PdnFtMg==
X-Received: by 2002:a05:6000:4312:b0:439:d74d:a66d with SMTP id
 ffacd0b85a97d-43a04dba87cmr3395795f8f.21.1773372044061; 
 Thu, 12 Mar 2026 20:20:44 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ac34sm14392056f8f.3.2026.03.12.20.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:20:43 -0700 (PDT)
Message-ID: <6492850c-12b6-4687-a07a-99530e2553ae@linaro.org>
Date: Fri, 13 Mar 2026 04:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Add stubs for needed functions.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>   hw/vfio/pci-quirks.c |  5 -----
>   hw/vfio/meson.build  |  3 ++-
>   3 files changed, 22 insertions(+), 6 deletions(-)
>   create mode 100644 hw/vfio/igd-stubs.c


> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index f32d8573600..562ba79d1c0 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -16,7 +16,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>   ))
>   vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
> -vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
> +                                     if_false: files('igd-stubs.c'))

Directly add to global stubs source set, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

