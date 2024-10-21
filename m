Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B97CD15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2u5J-0007Ak-0a; Mon, 21 Oct 2024 11:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2u5G-00079N-CC; Mon, 21 Oct 2024 11:12:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2u5D-0004Ck-PM; Mon, 21 Oct 2024 11:12:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c805a0753so39170665ad.0; 
 Mon, 21 Oct 2024 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729523554; x=1730128354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=UlUy+bMqSoiVA/UUXFzURM6D6xtz113AOJBt1Jkj7Hc=;
 b=HVqJ5NcZrilHxM3EOYCby0RUfZ5Wp7rD8L/LY9F8S1ouOzIZLLdqDlSU8m6F8K5JwV
 rs0N28am09B8Xr1J7ObibejOJEkjoJa7wSIjoy+E+2o+iJHpTwQKmKtZTTvcJ1cB3pNv
 Pt4HM5r/JDFJklgcEqlI8UVMFvXort583vC8s9xzftdTKfSJMx7xHs+YUZdTiTwwMZxU
 VsrdRPLCUCu7xpfQFjKTnSQrtbkpaggNxqfKhI6Oodok1vooCPCW+vD7bOhnqtbDEKKs
 Ud5OkXSYlyEgqC4gyRkPek0MHd2//tBfhiT40gz0irDxwOhRxQkEamRxClFmQn9snGPZ
 noWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523554; x=1730128354;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlUy+bMqSoiVA/UUXFzURM6D6xtz113AOJBt1Jkj7Hc=;
 b=EZKPxD8gmGWEa7sO5FmfOy6zektOmREx3eoA6kSrmE/Wgp0xR5gWbO/oSJNiYxON67
 2gqI4VGmyE8Gfx84/gvls/9Z5PRpHfy+2IQRE28bXyBekxzS8iCbypk3nPWYB1R9jD3/
 1UZg+xjrI06IdCDl1MP9O+y+lZbpVFM1IaI3OIvFoct651LgZDlD/gb7ubndQmjgtDFx
 VMiysI98CmI2s7Ojr+BBjhtYUxQHU/8KOAX4nIIsemg/XcuYejBnhT/bAq3O/BaNLaBX
 OwmrAzJ49srFHof52Vw/WkD4RHleoXGtKK1ajDC7/KieJ9e20HSUtyz0nZvkj2t3Idqo
 uPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDCbllmRYhmSUN3uSaG4/hm/IxZz7Cg4afmskx4ghG4I8TgzbfVsnll4Ui2IXNNi3lmJeUyKN3X9Ko@nongnu.org,
 AJvYcCUepj/PWQ6ocUqlK4Z1I1wmTMwgA2YswK77AAeOU/oycIkosDyLRa9/jNOJPaxuuRs5wlNbw1kyAjw=@nongnu.org
X-Gm-Message-State: AOJu0YxTDNc7zP5+t595oEer/yIxa1DI57lEgSAPLdxv+tGD7EiApOHu
 TYxZ801vVAaCUjHUi5xrOQwITXpVSXbEzM2t7GxNG+W+n41NqBbEEvq3rA==
X-Google-Smtp-Source: AGHT+IG/4htqMozC/daMRKDol99QvdVdEHISCe9CeeC2+x41vBT0828fi/WChZP0a3iLBl/w+AzCyw==
X-Received: by 2002:a17:902:d50d:b0:20d:345a:9641 with SMTP id
 d9443c01a7336-20e5a798dfemr145110575ad.27.1729523553715; 
 Mon, 21 Oct 2024 08:12:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0c156csm27262455ad.161.2024.10.21.08.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:12:32 -0700 (PDT)
Message-ID: <fe8602bf-2633-43c0-a5c7-d054cef2b8cb@roeck-us.net>
Date: Mon, 21 Oct 2024 08:12:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/ppc: Split out helper_dbczl for 970 (fwd)
From: Guenter Roeck <linux@roeck-us.net>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <416c2534-d975-6123-00dc-060ec00c1e24@eik.bme.hu>
 <fb61dd4a-91c8-4ee4-9d30-722e9a6c57eb@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fb61dd4a-91c8-4ee4-9d30-722e9a6c57eb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/21/24 07:36, Guenter Roeck wrote:
> On 10/21/24 03:43, BALATON Zoltan wrote:
>> (Resend with fixed ppc list address.)
>>
>> On Sun, 20 Oct 2024, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Fri, Jul 19, 2024 at 11:07:01AM +1000, Richard Henderson wrote:
>>>> We can determine at translation time whether the insn is or
>>>> is not dbczl.  We must retain a runtime check against the
>>>> HID5 register, but we can move that to a separate function
>>>> that never affects other ppc models.
>>>>
>>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> I see an odd failure when trying to boot ppc64 images in qemu v9.1.0 and
>>> v9.1.1.
>>>
>>> Starting network: udhcpc: started, v1.36.1
>>> malloc(): corrupted top size
>>> Aborted
>>
>> Do you have more info on what reproduces this? What is the QEMU command and what guest code is running? This looks like something may be using dcbzl on something else than a 970 or if this is emulating a 970 then I don't see why this stopped working. Looking at the reproducer may help.
>>
> 
> It affects all CPUs I am using for the various 64-bit powerpc tests. Those are
> ppc64, POWER8, POWER9, e5500, and power10. I don't see the problem with 32-bit
> emulations.
> 
> A sample command line is
> 
> qemu-system-ppc64 -M mac99 -cpu ppc64 \
>     -m 1G -kernel vmlinux \
>     -initrd rootfs.cpio \
>     -device ne2k_pci,netdev=net0 -netdev user,id=net0 \
>     -nographic -vga none -monitor null -no-reboot \
>     --append "rdinit=/sbin/init console=tty console=ttyS0"
> 
> with the root file system from
> https://github.com/groeck/linux-build-test/blob/master/rootfs/ppc64/rootfs.cpio.gz
> 
> Other than that, I'll be happy to set up a complete reproducer with images etc,
> but that will take a while. Turns out that qemu v9.1 has a number of problems,
> and it will take me some time to dig through all of them.
> 

Never mind, it turned out to be straightforward.
Try https://github.com/groeck/linux-test-downloads/tree/main/ppc64

Thanks,
Guenter


