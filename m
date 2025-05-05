Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65490C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxVd-0002fQ-6B; Mon, 05 May 2025 11:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBxVb-0002fB-Pf
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:13:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBxVY-0007hQ-Ig
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:13:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso4509366b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746458007; x=1747062807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/Jl3l3DVv9rtRLFtxgCV5rbTAOjyYdjBbiLzHNjVpJc=;
 b=A7cDtsZ1/82kBlSueKKwKUq9dct0d43QqVnlJhgge8UaMvrxmqw67ToFy0x3EQkxgj
 HioXWHZt0x6FeWym4RNGzcKlkR4/N3dZmd12eaNxi+lhoxp0ePYfGNyg41h6CavSY6Sx
 5HaHvjB9uRf5rB7FVi7BkMDPRP7b1htbBr9xCJFBEm4WLra/Tj60GFZQ3tUoEyLt7icl
 9l5VFQvv2N0+Su4qZ8tlObVR9nElPzWZ+XZXO/cIkywnkL10tpD89VUUjBpgBJnDu1H+
 MbbQ+hByCOMWGGgJbikqArkEb0roGSNic1T5W+HBHDJxTu7FsnwioBG6RI0qe+5WP0Ud
 OWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746458007; x=1747062807;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Jl3l3DVv9rtRLFtxgCV5rbTAOjyYdjBbiLzHNjVpJc=;
 b=K+9JocQSooQC5SreQZ6uPWLmHonpBYGsNJfQoKs05ejLLgsoUNeh2MYhkoN+JOHV5W
 PtiRT/ipNl7RHh8JIbsPTM7+xptz0vxBpE/+SKda56dfEEEpyhlZehpfvUhyphvIEU3d
 xjEGDkLc2bZCdh4L+AnK5ZF890fWE3xcKCTL2ps3V3rmMa5TZSC+kUAV7DZ5Hb4AomCY
 66mgU/6L0MQYzMbdD3ojtFmEHG6KvjcHgMPAPwerXZ9rD2Gy1nE4igCTuu+/spq5HEy6
 I7Z0SqZD0nRZrMmHUIejTUDOsvUCorX+tNLyEWOp2itBmqr9AivlBGkLF2p4phO+7jXD
 xT1g==
X-Gm-Message-State: AOJu0Yw3/OiH0mrIQXBx+svoT7/eAijyA+FWwWq8dusyWF2jqcygUC7T
 dFIZKx6Q6Sq5s2WT63YAvSKmfDNW/6HP3Do5J25WSge/VxsIGgI=
X-Gm-Gg: ASbGncv0Iy+rx1SeGX60AlcVE5hxuMnE4VTjaAgYTeMmgHHOO81xB45Nc3Dho+hza3u
 EdzYf8pL2ejXT95OU8ug7WNbp1iK01BqyEYPo7348lPliqFl4elIPv1boyu87/eIKFDTlGdybxO
 7ClbuKDy7LMIiGIo2niiTOjF49z1B3dljQn+ZCsjb8sEUAE3eNXgzk1hCbwPN20qqTX6+zWaFKj
 BUOspPmHKpVOav8EHXmeIE1epuTJXjGfCQwVvCozRoOhbkfAzgzmnXz7YQ8cHRu7llNOdOWs/iR
 Q9AY/3gP3/da8yL0KPd03+RUntxDs/nzY73jrgZfNz0PH14=
X-Google-Smtp-Source: AGHT+IF/266p+ZvmG+Cka72IktpaYistjUunQL766BtVCBhOXJFyBI2644hLXK0RXXzXHHFsMOHFsA==
X-Received: by 2002:a05:6a00:2a08:b0:736:ff65:3fcc with SMTP id
 d2e1a72fcca58-7406f176b76mr11217190b3a.16.1746458006843; 
 Mon, 05 May 2025 08:13:26 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a50fbsm7145608b3a.177.2025.05.05.08.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 08:13:26 -0700 (PDT)
Message-ID: <0e254df5-25db-435a-839e-28ff2e34e261@gmail.com>
Date: Mon, 5 May 2025 23:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/igd: Restrict legacy mode to Gen6-9 devices
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
 <20250428161004.35613-2-tomitamoeko@gmail.com>
 <4781421b63032965326824850f34b90ad4b313ea.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <4781421b63032965326824850f34b90ad4b313ea.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 5/5/25 16:42, Corvin Köhne wrote:
> On Tue, 2025-04-29 at 00:09 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
>> CSM support on later devices. Additionally, Seabios can only handle
>> 32-bit BDSM register used until Gen9. Since legacy mode requires VGA
>> capability, restrict it to Gen6 through Gen9 devices.
>>
>> Link:
>> https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAADAsHNi0zEFiakAAACORk589NFmMEL0IRdt7DRVpnoi_6WKuXqQANgyXom23JAMNMr3UlEVSZvZdOtespZyqyGqsgLV2z0x8MkoDwNY9VFWuoC1hAOa_kpJihDYFTkqJw9sxp1uw6X9Oml3OGmOnrY8bVlHo2n7h5uiu73mh7RdgB0cFnBy59ExBLmCowsh6nXK5LA_Udnf-WbH0pzMWtCwjhPF453hx1Rm93_KYzUhuyswu_sg0
>>  
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  docs/igd-assign.txt | 1 +
>>  hw/vfio/igd.c       | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
>> index 3aed7956d5..95beb76812 100644
>> --- a/docs/igd-assign.txt
>> +++ b/docs/igd-assign.txt
>> @@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI
>> Option ROM, see
>>  
>>  QEMU also provides a "Legacy" mode that implicitly enables full functionality
>>  on IGD, it is automatically enabled when
>> +* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
>>  * Machine type is i440fx
>>  * IGD is assigned to guest BDF 00:02.0
>>  * ROM BAR or romfile is present
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 6678e0e5cd..cecc3245b7 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -516,11 +516,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
>> *vdev, Error **errp)
>>  
>>      /*
>>       * For backward compatibility, enable legacy mode when
>> +     * - Device geneation is 6 to 9 (including both)
>>       * - Machine type is i440fx (pc_piix)
>>       * - IGD device is at guest BDF 00:02.0
>>       * - Not manually disabled by x-igd-legacy-mode=off
>>       */
>>      if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
>> +        (gen >= 6 && gen <= 9) &&
>>          !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
>>          (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
>>          0, PCI_DEVFN(0x2, 0)))) {
>> @@ -565,7 +567,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev,
>> Error **errp)
>>          vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
>>      } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
>>          error_setg(&err,
>> -                   "Machine is not i440fx or assigned BDF is not 00:02.0");
>> +                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
>> +                   "or device %04x (gen %d) doesn't support legacy mode",
>> +                   vdev->device_id, gen);
>>          goto error;
>>      }
>>  
> 
> Afaik, at least the LPC quirk is required for Gen 10 and above for the GOP to
> work properly. On the other hand, Intel hasn't published any GOP yet, so it
> might be unlikely that user use it. So, not sure if this is a breaking change or
> not.
> 
> Besides that:
> 
> Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
> 

A previous change has added a new experimental option x-igd-lpc to allow
users manually enable the LPC bridge quirk, the documentation was also
updated with "GOP driver depends on LPC bridge present". In non-legacy
mode, user can manually enable lpc quirk with x-igd-lpc=on option.

Thanks,
Moeko

