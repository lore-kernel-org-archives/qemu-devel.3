Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D8C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWPk-0008PN-Ey; Thu, 01 Feb 2024 07:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWPi-0008P7-3X
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWPe-0004xN-Lv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706791405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hh2SkeDXVJXiKy06zMjEfgwb4cF/vdZEmtW8Zn/iSB8=;
 b=VmM9UEYqhR+cAaYzLgBglYvgaAAtQ43E56uiUAYu+hXyZ8HnF3Ytqqldby+UDc/h9WCUzy
 3LCM6D6M0uz79kgIknHJvhbTgc91oU46HXzirgP9n2Vv+9Cu4gv5vBH0/Z4OkG9fOKHvc0
 niSxe0Pd4zCj7I7TB/KAiSoWs3X0M3s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-od1O9XKkMc-JmWRGw1b4Fw-1; Thu, 01 Feb 2024 07:43:23 -0500
X-MC-Unique: od1O9XKkMc-JmWRGw1b4Fw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50ec9529001so814853e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706791402; x=1707396202;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hh2SkeDXVJXiKy06zMjEfgwb4cF/vdZEmtW8Zn/iSB8=;
 b=BIsqNL4RVjoz6m1eWwk9srVnNc2YXaGa5G0lEeThjK6fBHOpSh/jjS/mu9GyctkWNA
 iacP98bKS6Pwm2SihqjRaHhmNCweJcpHyfx4DAd1zbUplvUZgapxivmxzSa2T+8gdq32
 a/T/o8UA2Rpgu6LNsg/2fCIYNP7vwSRgiSCzZljqXeSoXAB7/R2BWl8SXM7WGioSvbHa
 ShbNa5VzKZSaTCB73PQ8z0Mp/OFK9Bn44o+C+o0PDvS8QCSmhXBS4ZZ7NcuvwXzJk5F0
 nd/k1hxTKZ3A1mihOw2ftwmgE2VlavjmiSDwXcmVz7Ji9IxFJOnl9Uu768LwP7kI2am8
 13ag==
X-Gm-Message-State: AOJu0Yz1rDFY6NFZEgdwXnUuXsBUBPIfNJideIuWsnGY6XBvq/IsTD4e
 KQYkySvuHVwuL4pyYPmwxpK5JVsv/X0QdKf9qNjSl6uLb4DwPEH1UUcrBEHLNRSSdhxE+J53ezs
 dDmjdBCK2DKdlE6BA3+n0lLxKdk2Uxy0V62GfdluMZYdVxf/ofTGm
X-Received: by 2002:ac2:4463:0:b0:50e:7c08:1a55 with SMTP id
 y3-20020ac24463000000b0050e7c081a55mr1663157lfl.18.1706791402429; 
 Thu, 01 Feb 2024 04:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHsS7/cRa22XcevGCJp5Gb7lsv9V0DMbPrsSBHjPFWMba5T/z9Bl0Dv63M2vDasbvw26hAkQ==
X-Received: by 2002:ac2:4463:0:b0:50e:7c08:1a55 with SMTP id
 y3-20020ac24463000000b0050e7c081a55mr1663148lfl.18.1706791402076; 
 Thu, 01 Feb 2024 04:43:22 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV53XcgGn8djGFerIf5nmRh9+vNwmHGpf8cHYSS7ZZtnF+FQ8m+JTuqUvO0FGfyerRP5+r1x7ZtTOeifhGu7aOYvbkQ64ecoal4nPY1W4GVMV9PUjA+1Mb8+IGh9ph+NwodKM91qsgS9KN3EspcedEjmNYpQhuK5KyoHhBZDHX/jK5DPBphSjuPOZ3588cQinQzTrQpu326vJx2B4MXX+RK24EQ5imgIH9LeNtGYddMyKN6zsgn/njk0PXc3cmgy+FfBUOnLXwONBk0x+X9EV0nYFom2t4XthB3wFPhdBaLsW/TlRYy9gjOXeme5nWa/S7wv5LUF7WPhaBgP3RmnDdj7O1efVGikqsmkq+II1Sg17RiUtEnMSw4Lul+4aaajjLxO6IAKMKjvCK/WAZyVDejK3Ygtw1vxa5u2LSZELOJ2uQ0BYv8X+tvUkeiJyKuaOfeU10wAH2bBqH2Udho+hYaMI4ixAKgY+vI8ITEvzABeuyDs/b7RacxNPTJkYjo4KCB2C2qkaM41+eseGQF8hi1jBf8iot2fLUstFBqYr75VuqMJB+mdPycBmWqsI5yaphWje6kPyZowE9/gRK7DbxCWWQGD7uWljoretjGqTgmbUyaDg==
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b0040ec66021a7sm4414186wmo.1.2024.02.01.04.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 04:43:21 -0800 (PST)
Message-ID: <25209797-86d3-4665-9cd8-a9ec2b236086@redhat.com>
Date: Thu, 1 Feb 2024 13:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] kconfig: use "select" to enable semihosting
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
 <20240201122835.1712347-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240201122835.1712347-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 13.28, Alex Bennée wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Just like all other dependencies, these can be expressed in Kconfig
> files rather than in the default configurations.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20240129115809.1039924-1-pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configs/devices/m68k-softmmu/default.mak    | 2 --
>   configs/devices/mips-softmmu/common.mak     | 3 ---
>   configs/devices/nios2-softmmu/default.mak   | 2 --
>   configs/devices/riscv32-softmmu/default.mak | 2 --
>   configs/devices/riscv64-softmmu/default.mak | 2 --
>   configs/devices/xtensa-softmmu/default.mak  | 2 --
>   target/m68k/Kconfig                         | 1 +
>   target/mips/Kconfig                         | 1 +
>   target/nios2/Kconfig                        | 1 +
>   target/riscv/Kconfig                        | 2 ++
>   target/xtensa/Kconfig                       | 1 +
>   11 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>




