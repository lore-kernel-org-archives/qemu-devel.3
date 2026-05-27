Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8670CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFco-0002iH-9R; Wed, 27 May 2026 10:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSFcm-0002hg-Fu
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:52:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSFck-0006PK-RZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:52:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so55484805e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779893565; x=1780498365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPsT6DGijS+Rp3D+8TDa65rw1lWb4mazFnj6j1d1TBE=;
 b=K0Jqw6pxV2+2fckSLbTGj0+GqqfvtGaeUZ3SkY89LJ7R3pnw8xUADWSVI6I8pTD/pi
 BNSKJm1z+7t/uOTPMx36+lJ4LtOKX0Sc6Q93eARzONIUi+CKnLLB/G1rsmS03F64TYi5
 SGL+zcHpU3L7Rr3CXvy5Hs1LxLsREfhNZkW0lcfIC4qmpXS4P44wisoHOEQrcf8Lwr+P
 aoPiFZ1he9APJwNq51X+isqa3Q5YqsOQz2VGeaJTpnEabnHb8KYCc6vIbNr7+Jn/JlRn
 C82UbO9vCP3BjrOzSPVjzbGP8W31UelqQXACFlpULwaOscHqh+RM+QSGJm1yl9wuqzCb
 OOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893565; x=1780498365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPsT6DGijS+Rp3D+8TDa65rw1lWb4mazFnj6j1d1TBE=;
 b=ZiuPCoJLesubAUVaS3OpU3MIxR4U6J0GkSSv+SWwa9l8M3yjGCNoR/K391T4kxMOdJ
 fHQGDjaJ5SEmYAqEHeCY92/SiZSx8pQ309cMZwX9mmkY3aSSyKkbBb3yPyU88ryKyIi4
 5/KP1oZioc1eu6SUe9UCsKx6JP9idYOMhfTa08L6y6APwMagKcPeuGCp0/Xfc+Pcxt7o
 qWuii48wLXq8Exen9PpnW5pIpXvu7k8tCgC2v4TP31RYJLFf2lBzRB5tz7B1jNFOkRwt
 /csAxxRfWqxE0V4x1d5KFWuHyeweKkOUOm3km0NdifmdoOENyzPG4e7Cwgq93oi8lp5t
 SEsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99in4zpJt1Gob2lIUSrDx7WSeO/wQnxPUamO2CyrWT3ptNhnjIRfBia9RQC2MXMw6qeMjbR0mKLHVt@nongnu.org
X-Gm-Message-State: AOJu0YyxSzuCu7K4y27n63dvDy3S1VNt0cVFuYU5MjXPQ8Zx8yr8N10+
 kzA4d4n7a0+ZmucoCit/lFhbJZHFjyYwNMUpxQs3wYtWD+uqJJ5/yN4bRzAGUV4f0WWeHWTnDIn
 PzxfSm3CYYg==
X-Gm-Gg: Acq92OFgtantS6oPjHGy4HWpeRStqhKvqcARZMz0CJHsM0NNgKUUDEys6uUEVFQ74mT
 UUXaHHtv175eLCPUizaW28zepVgwNlL4f+M9+/EGRshYwIMgBp0M30nDBXEhJ8lH5nLE50NfZEw
 DmA7XQqVrIu4md1oos18E/p5EylOeqEDTOcVekVne5BYeahunDOVaL7JPbhVbW6XGJKABmYb1ky
 tNuaaJnhz8yvtqevOk0To+NZOQ421QW+qSlMsrJtnVTkCvqCeMh1GmeIDcHXGzbIYe9mMFzbKN1
 o2Ae2diQgom18pw+IqaDZndNJM2WdG7ncFaSvQul/FotTVmPc1xcVWFJoK9P6SesfX66CeYxcd4
 ogwjZyQiUNztkHU7QUBlhfhHHM4pRF6z108zAJ14SvtNBwepJUfVbdwZ8bClyhwZTWrc8Qv0q5z
 zmBB7WvLA2jGVSn9ctI7LH6ZHvhU8/hcmeN7m7lX9YBO4JQluBHV0ioAgkWSmvGJZLS8xma8efu
 Sp3
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id
 5b1f17b1804b1-49050ff7b15mr326612845e9.5.1779893565167; 
 Wed, 27 May 2026 07:52:45 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526ca50sm371723665e9.2.2026.05.27.07.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 07:52:44 -0700 (PDT)
Message-ID: <538ebc46-4030-4433-aa84-55d5fa962eba@linaro.org>
Date: Wed, 27 May 2026 16:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: fix close_range detection on older glibc
Content-Language: en-US
To: Quan.Sun@windriver.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260522201850.1342167-1-Quan.Sun@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260522201850.1342167-1-Quan.Sun@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/5/26 22:18, Quan.Sun@windriver.com wrote:
> From: Quan Sun <Quan.Sun@windriver.com>
> 
> The has_function('close_range') check succeeds at link time on hosts
> with kernel >= 5.9 even when glibc does not declare the function
> (glibc < 2.34, e.g. AlmaLinux 8 / CentOS 8 with glibc 2.28). This
> causes CONFIG_CLOSE_RANGE to be set, but compilation then fails with:
> 
>    error: implicit declaration of function 'close_range'
> 
> Fix by adding a prefix that includes <unistd.h>, so the meson check
> only succeeds when the C library actually declares close_range() in
> its headers.
> 
> Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index eb07491819..e396394f4c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2596,7 +2596,7 @@ if host_os == 'windows'
>   endif
>   
>   # has_function
> -config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range'))
> +config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range', prefix: '#include <unistd.h>'))
>   config_host_data.set('CONFIG_ACCEPT4', cc.has_function('accept4'))
>   config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
>   config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


