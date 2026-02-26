Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD71FFC592F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZSS-00083H-Pn; Thu, 26 Feb 2026 06:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vvZSO-00081C-7j
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:23:01 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vvZSM-0006cY-JO
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:22:59 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-896f632d206so22914666d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1772104977; x=1772709777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3mkj4jiSLwb7XGqZ14vdwtI7821lsnp9gwQEvNFdx/Q=;
 b=olFGLiWmyrff8TMrVahPHQbHlt6TjosNBAQtRDt7C/ZIZaVmG/KkYRKKWKPOvJ5UHh
 cEYER1587wLMDHWX3Y0ZD47HcMorqIwzTrAVN1AYEDFJlN4iW3rZt3v+E1g2R2ELSUiz
 +Zi4CmIAbG2ZWNtXXa1hUXg3rxR/PneyWTo7eRKRU1/HA0nAfjkshw4CRYgA7fWpLgc5
 RF3dptv+j7ihEsCZpS1EetaQxnNvbVragSBdYgyW6SzVPH5lNe979mrCf78jrBQ3qjF2
 ZgPiV4VgRZG1bXkS8oApt0ZGaRoSzBXyuWjwjSHVkgTTbZGZvXCNZmFQfI0Tj9OtEHMb
 O2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772104977; x=1772709777;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mkj4jiSLwb7XGqZ14vdwtI7821lsnp9gwQEvNFdx/Q=;
 b=CCbQQ0oCrmgL0GVU6CHQsgnbRQPFU9Bccjc+289xvIvVBvFWiKuqke3oW9Zkn98ICT
 erW6oZPlibcAhxvh+KHaOU5UeDqR1+4uQhVR7k7Mwt5VeiTyRk3hKt4bZ2Ra6ktd1LAs
 yiiv8aBXEhyeGGG/p0F1fmP844mdjbzfIjvfzTivhctB3XlcodV6UHyyKrL/9U8bwrvV
 IumBsS7eJ5ssnd5e0nAoC8FylHSQbKq0stfwt0JL6ac7SZNMzMDJcMCyFHCBHfZ/ZP9p
 ZRWOE4xZ7XVTWq/wz4FHUKGoG6Umb3UZqPCFx6BNR7zDLke5QYl+ZxhX3Iu12DflYgrw
 fsgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9S99+STv1f6yDAnZP5Ohbim3H5YTCWGUDuYo1R9Cyvo91Q1Dtx5Io1BgvDzJRcKSPpcLc5MHooFGb@nongnu.org
X-Gm-Message-State: AOJu0YzXqwLe9W2agHxDJVIlnaPvSpcojnX2Lj5Zpmq87sM9Qr5jWDKT
 uJcFu+LNP8zh+cOPpqfPG8uDLb3GTKvhaCkcKZZAusEn3Msaq425GIcaxCZxS98X2rI=
X-Gm-Gg: ATEYQzzzXodFfTzO5Q0ZreVVuuTywnJwH896NUrWXngmx8538V5gz3ajX1c4k0g8QOG
 WHE7HR8gyoED6RAzyHelKZXNGiqLbcpBlaUP+MdYa7X/JMwdiLxCc+EIgMWjkvXXJsZowHX5CIq
 7cOJbWftYPh6UJg/KSvl4rhPW5upQzR0sUI8bOHKV8dIxsMxyXVz7WxCcwr67L8rv3n5OZr/K+t
 mHH1DyqoQoxoKsXPgBmwXtuI4g/2eiT12w4EeZ7WDBPZMEWKZg6XgMMM04Ubp/mIxChLpYIZBad
 clcXrxpQAwX/DVFMxBXfArZhytGnVsQ41cpC9UXweFR+CY8MsIkFuY0yw5vygiHohPaZIVJmSrq
 sWidAeWPrXau51uiUHWzgwG2Wcd2kIBhzSstwsSq/R0dRhU4PDtytVyX8w7MDNzLqIouwPjRxzz
 wKNZEpG2a2PdUsffn1COOSQZs/XZ94jiCwIS04NeHPZg9Ecl6LXA==
X-Received: by 2002:a05:6214:1d2a:b0:894:70f3:5ece with SMTP id
 6a1803df08f44-899c67948demr30760386d6.8.1772104977083; 
 Thu, 26 Feb 2026 03:22:57 -0800 (PST)
Received: from [192.168.15.9] ([179.110.114.143])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf71ae8esm175008785a.41.2026.02.26.03.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 03:22:56 -0800 (PST)
Message-ID: <a0e12772-d3e9-44e8-a997-136f5c4eb7b0@ventanamicro.com>
Date: Thu, 26 Feb 2026 08:22:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs
To: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 2/26/2026 7:20 AM, Chao Liu wrote:
> Add myself as a reviewer for RISC-V TCG CPU related code to better
> participate in patch review.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71..4923715c9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -333,6 +333,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
>   R: Weiwei Li <liwei1518@gmail.com>
>   R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>   R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> +R: Chao Liu <chao.liu.zevorn@gmail.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: configs/targets/riscv*


