Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D40CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVRS-0003C8-D9; Tue, 02 Sep 2025 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utVRN-000361-5a
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:09:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utVRL-0005Zb-6r
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:09:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ce47d1f1f8so3805857f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756836544; x=1757441344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BqXHVrMYsu40em3jPwo0FH0WNRZiKK6ehvIv2eqeJQ=;
 b=Ox2zy0FmVr0gj7Sq/N1BPyWPUta4UzsRUrG3kfXIwMZve9yOCWjhGmshqF0qUenLlE
 vmidTHmJcPiC8CUJ16oecyN+i7kPFsxxlhJgA1zIgADFUxfvDb3FTxKe7GSBJHHKcMp2
 CjUFBTGKNNDKSZd76h3sgLDUY7Pdit8HlcbjIigSI0InCuXXLAlmblEAFFPvwqVZG2pn
 CTQ5VJojEJhvHbnExxXLqmHnHqJtsSTkcp404Ac7lHJnREUK1tPQoY5wlPYwnwTYB0Wr
 SkNjFgA0c/Has8Kiiw2wl93q2A2613mUYFCMSdNqUatwQllUeHq1hia+br9d6o+0eMLE
 d7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756836544; x=1757441344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BqXHVrMYsu40em3jPwo0FH0WNRZiKK6ehvIv2eqeJQ=;
 b=gedRIbXYARBfokS+7re89uihPjonNU4GRzIO8NyGEkYHavblcnV5QaAnKmD00EcRry
 J1LTXX1L1YHKMZk9FFE1bwXvJE8hnDMX/HrkBLwQ0Bj8vTJNhg9tIXk7irpdg3zk0lk1
 0NGF0x92KxbDjSZowxQQb1EwzZwnU1dP4RhyZR/I3LQIHyBGsCmLncvpdUyeeqxhHZRG
 uvnx9vPV0c4arnTwtEfMA2MvCXkmvhrp23TRSgl2G/FKiMONfObdS2NxBwvqeD5ZkUCK
 n+WdND+4hor0hZ8zUC9TizWyxVu6ucmjgkXGwcOipCJMgJNftc8wOd1Zl3n0zqcllH/N
 /q+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQr23HYr/rSyD1gqVRi2PMAT9iM+QoINcHRsh2quKW443JrrmuCA3PuDz07WPwafKCIcGa04cylfdH@nongnu.org
X-Gm-Message-State: AOJu0Yy5MBDXRdXrY8q6Tm6ONAY8/JSo/EALgc2SE14LfZgkMGgxLpr4
 19pIeEB6lhOFe7GEvv31YwiKV2doMSzK7Gcdd873HBHA+ZsrcF5WWQHfX5x7M3vY/rw=
X-Gm-Gg: ASbGncsrSmbP6Tk0k8Kn7TR7JQOX/zsrsd3IzkGamCiHYtl2VKQ+sRD9D1jErdOEIM1
 TxUK/Hj0QdyyI/n5Ym3ikZdf6pAs+wcbHZQW7SRMO8i+tpbJTwkXizNHOw94dSXbs0fJyBDTTME
 yYMfRT5oy3h5OaMhuoN5fgIlJoHfkKseNIaFS7iuNO60YhkthaBzwHwm4oc5wt9DnWDHy0qUFJr
 8ZuxDfQxqgB5J4G+JltvGZ3AV0ys+17Ih04EyAA+9kMP0G1qoDmOWk7EOQisrYyIIzlXiSSSWAb
 bJvcB/lflJmv/29ek5rEamYAnbZb1lMIFFaDLfmzVzMm2kVCnx2CczjCvkakcF0qAlunNThRQC/
 8bbpJwJOReQ3FCcB6diA5s3G/g5JWXjjL7YFPkzy0x6QO99jHE0XlsuWtyDsGnfZyuZR6wAyaFU
 eMPbew32zCpKY=
X-Google-Smtp-Source: AGHT+IES/SlQgOzI3NRsrt1bRYwnDsQi/YFSysS6reUQ1bhtVjaQR3GqAQ1XT9dTTOvacmw0gr80vg==
X-Received: by 2002:a05:6000:26c4:b0:3ca:4e3:6ea6 with SMTP id
 ffacd0b85a97d-3d1dee6d7e9mr10886328f8f.46.1756836543524; 
 Tue, 02 Sep 2025 11:09:03 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d48760d1c9sm13087384f8f.17.2025.09.02.11.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 11:09:03 -0700 (PDT)
Message-ID: <b672f2c8-8298-45ba-8989-fc830914e61b@linaro.org>
Date: Tue, 2 Sep 2025 20:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Fix size check for backing block image,
 part II
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
References: <9f7fc688-7676-49ff-8f86-fac347f70f05@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9f7fc688-7676-49ff-8f86-fac347f70f05@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Jan,

On 2/9/25 19:47, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There was another mistake in the size check which 8c81d38ea5ae now
> revealed: alignment rules depend on the size of the image. Up to and
> include 2GB, the power-of-2 rule applies. For larger images, multiples
> of 512 sectors must be used. Fix the check accordingly.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Not fully tested yet, but as staging is broken right now, I wanted to
> provide this already for early feedback.
> 
>   hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 2d34781fe4..0f33784bd0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,6 +2759,26 @@ static void sd_instance_finalize(Object *obj)
>       timer_free(sd->ocr_power_timer);
>   }
>   
> +static void blk_size_error(int64_t blk_size, int64_t blk_size_aligned,
> +                           const char *rule, Error **errp)
> +{
> +    char *blk_size_str;
> +
> +    blk_size_str = size_to_str(blk_size);
> +    error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> +    g_free(blk_size_str);
> +
> +    blk_size_str = size_to_str(blk_size_aligned);
> +    error_append_hint(errp,
> +                      "SD card size has to be %s, e.g. %s.\n"
> +                      "You can resize disk images with"
> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
> +                      "(note that this will lose data if you make the"
> +                      " image smaller than it currently is).\n",
> +                      rule, blk_size_str);
> +    g_free(blk_size_str);
> +}
> +
>   static void sd_realize(DeviceState *dev, Error **errp)
>   {
>       SDState *sd = SDMMC_COMMON(dev);
> @@ -2782,24 +2802,16 @@ static void sd_realize(DeviceState *dev, Error **errp)
>           }
>   
>           blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> -            int64_t blk_size_aligned = pow2ceil(blk_size);
> -            char *blk_size_str;
> -
> -            blk_size_str = size_to_str(blk_size);
> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> -            g_free(blk_size_str);
> -
> -            blk_size_str = size_to_str(blk_size_aligned);
> -            error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g. %s.\n"
> -                              "You can resize disk images with"
> -                              " 'qemu-img resize <imagefile> <new-size>'\n"
> -                              "(note that this will lose data if you make the"
> -                              " image smaller than it currently is).\n",
> -                              blk_size_str);

First, no rush, your previous patch didn't make it to master
(CI failing) ;)

Again, this painful restriction is due to CVE-2020-13253. Per
merge commit 3a9163af4e3:

     Fix CVE-2020-13253

     By using invalidated address, guest can do out-of-bounds accesses.
     These patches fix the issue by only allowing SD card image sizes
     power of 2, and not switching to SEND_DATA state when the address
     is invalid (out of range).

     This issue was found using QEMU fuzzing mode (using
     --enable-fuzzing, see docs/devel/fuzzing.txt) and reported by
     Alexander Bulekov.

     Reproducer:
       https://bugs.launchpad.net/qemu/+bug/1880822/comments/1


Reproducer being:

---
#!/bin/sh

cat << EOF > inp
outl 0xcf8 0x80001810
outl 0xcfc 0xe1068000
outl 0xcf8 0x80001814
outl 0xcf8 0x80001804
outw 0xcfc 0x7
outl 0xcf8 0x8000fa20
write 0xe106802c 0x1 0x6d
write 0xe106800f 0x1 0xf7
write 0xe106800a 0x6 0x9b4b9b5a9b69
write 0xe1068028 0x3 0x6d6d6d
write 0xe106800f 0x1 0x02
write 0xe1068005 0xb 0x055cfbffffff000000ff03
write 0xe106800c 0x1d 
0x050bc6c6c6c6c6c6c6c6762e4c5e0bc603040000000000e10200110000
write 0xe1068003 0xd 0x2b6de02c3a6de02c496de02c58
EOF

../bin/qemu-system-x86_64 -qtest stdio -enable-kvm -monitor none \
      -serial none -M pc-q35-5.0 -device sdhci-pci,sd-spec-version=3 \
      -device sd-card,drive=mydrive -nographic \
      -drive if=sd,index=0,file=null-co://,format=raw,id=mydrive < inp
---

I guess remembering we fixed this one then another path was fuzzed,
so we audited and realized restricting to ^2 was the safest option.

I'm not against unrestricting the model, but I don't want we raise new
CVEs. Users adapted truncating their images to pow2 and accepted the
downside.

I'll run some tests, but it might take some time.

Thanks for working on this fix so quickly,

Phil.

> -            g_free(blk_size_str);
> -
> +        if (blk_size > 0 && blk_size <= SDSC_MAX_CAPACITY &&
> +            !is_power_of_2(blk_size)) {
> +            blk_size_error(blk_size, pow2ceil(blk_size), "a power of 2", errp);
> +            return;
> +        } else if (blk_size > SDSC_MAX_CAPACITY &&
> +            blk_size % (1 << HWBLOCK_SHIFT) != 0) {
> +            int64_t blk_size_aligned =
> +                ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +            blk_size_error(blk_size, blk_size_aligned, "multiples of 512",
> +                           errp);
>               return;
>           }
>   

