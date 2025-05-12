Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F7CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOay-0004NR-Ta; Mon, 12 May 2025 04:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOax-0004N0-5m
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:33:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOat-0000tu-W0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:33:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so207005e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747038781; x=1747643581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FE7JusQVun7wGBVxA/AMMKpV9a0KnFMu6frd8TsJeB4=;
 b=Mtk0Bdu4NrYcbbNcDLjCr5lu/nhhz5QD91RsqwTRTIH+TWFmZzM9OcwTSPh0xKetRw
 kr8rehCotp1h4Orjad93qs8X9fMq5TVPE3DZvJbRWz5rN2m+2iTVzsGrMzIAB2Ggdooz
 4Kij1I4Qb25DfiHkVNCMo96OBvUxv0m1teCPYDOSUUbO8TEWTLVnDSvAEXKv32nLC/jj
 Pqs61BYlNFbpLbwsLjkb2k8XLry2Gum0bxeq4l1bW7F7EMLC0jPZ5QMMCAsG9VGtXXZu
 JImiVBGjgDdu6+xU0PPWGukfIKqNjB2WGMSjM8HOH7iOGjS5Er7DuchMslB+ltODOalw
 Gw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747038781; x=1747643581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FE7JusQVun7wGBVxA/AMMKpV9a0KnFMu6frd8TsJeB4=;
 b=GimW2ejsf77Hum/3ee9b1wS/GJHrDPVKWKSMyraUPYctdYyJD8J51ekFqTIoJ6i9OU
 YAWuzAXSa0A+n29+ZT5+1wTWJ+wh8zUYjw+nXGDPiRqCnvzmPHvY3n42FSrRte2SY2Xw
 sFyVYXw9TBbY4Y6IofX3lnfmZGKiYOCuAts4WJy/hCz+MhInIQumVcb14DdZaQux2KrU
 4NwSx7pH+RoMURp9qbETAXRwmMld/LOXXBCPuv+PKOz6HdHc6X8dHEsJE9UhNfIfRTmg
 vjHw3cZUhDUK59rCYIFhzT/dw/dzHSHol37dEB29D2aWgJMAbsda6LWJmUNa43NRg4ys
 cpng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGN5kOaahgh0vk6LqTOGQfj5ndR5/VaPZGZi3tce/wFbk7xsF8jx1kEVu/AFJCDUbAA5zo1Yj/H/X@nongnu.org
X-Gm-Message-State: AOJu0YybhrZap+yklBTMwPtWdv8QpjF+gVdvXKye+XQNVko7w8abkR26
 t/bPxDwF4qUzOS9DbRT8R6caayhOm1oTkkudz1BcneuncN3U1IbD0sobEI9+RRI=
X-Gm-Gg: ASbGncv6I3ds74ZMbuYSiUQngIaUzuzaKhmI+V8tb7RENgHqQy9u2IbasrSFuQsqfpU
 nafiOcL7GquffSVYz6lXp5Hca2bd7ptEG7Ox+Cp0Wlpdr9tHusJWNyFM30M0Dlg8+jvG+YsLPou
 URJxdJNwsdJOPAgTvtMIyZLB4mIH41w7KkmyIs9qesQvscJUrz+L6xN2hws6B04kpNTOde9qSn0
 pt4YVwEcQhwyxbr0QKa5kFM0BYFMOuOvSUnYrDOTNBg1sxy8SHFeBuj+Hg7oNbzkb0NPZAG8AwF
 N6fPx0FQC88gw6mdkfKnfd5wLlPPQKp6mwLV7/aE/Ev28LIwbftV+8IgWHYv3LpO5HsuHiqe7SZ
 ShH4IovIW2PYvgGbp
X-Google-Smtp-Source: AGHT+IH3Ndj75+dAN1pgtxJmd7HIHD/mBO2a/vfpCAl/3XTpXIRZ2Aih7bhroeC+aC7txmEkpTHHbQ==
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-442d6d44aa7mr127543975e9.10.1747038781501; 
 Mon, 12 May 2025 01:33:01 -0700 (PDT)
Received: from [172.19.170.213] (129.163.185.81.rev.sfr.net. [81.185.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67e2db2sm117486055e9.16.2025.05.12.01.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:33:01 -0700 (PDT)
Message-ID: <6597f440-2c26-4051-a6bf-73f46c6a8020@linaro.org>
Date: Mon, 12 May 2025 10:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250506143905.4961-1-philmd@linaro.org>
 <4d3d7964-2ff0-4e62-9949-bc3df4018e31@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d3d7964-2ff0-4e62-9949-bc3df4018e31@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/5/25 15:30, Thomas Huth wrote:
> On 06/05/2025 16.38, Philippe Mathieu-Daudé wrote:
>> (series reviewed)
>>
>> Since v2:
>> - Removed qtest in test-x86-cpuid-compat.c
>>
>> Since v1:
>> - Fixed issues noticed by Thomas
>>
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series only includes the 2.4 and 2.5 machines removal,
>> as it is a big enough number of LoC removed. Rest will
>> follow. Highlight is the legacy fw_cfg API removal :)
> 
>   Hi Philippe,
> 
> I just gave this series a try, but it fails in at least two spots.
> 
> First, you missed this:
> 
> diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
> --- a/hw/block/fdc-isa.c
> +++ b/hw/block/fdc-isa.c
> @@ -112,7 +112,6 @@ static void isabus_fdc_realize(DeviceState *dev, 
> Error **errp)
>       }
> 
>       qdev_set_legacy_instance_id(dev, isa->iobase, 2);
> -    qdev_prop_set_enum(dev, "fallback", FLOPPY_DRIVE_TYPE_288);

This should be:

  +      fdctrl->fallback = FLOPPY_DRIVE_TYPE_288;

> 
>       fdctrl_realize_common(dev, fdctrl, &err);
>       if (err != NULL) {
> 
> Second, bios-tables-test now complains about a mismatch in the ACPI 
> tables somewhere...

I can not reproduce that (tested on macOS and Linux).

> 
> Could you please fix that up and check in the gitlab CI whether the 
> problems are gone? Thanks!
> 
>   Thomas
> 


