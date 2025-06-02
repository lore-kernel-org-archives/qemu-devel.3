Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56972C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7ti-0004Go-JQ; Mon, 02 Jun 2025 12:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uM7tg-0004Ga-Sp
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uM7tf-00083F-3D
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748881220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UND6LBgYzKh5UJoTdUouoreyW1Exj+atQyioQIzdY4E=;
 b=XvQRrZp8KRGAceVsnIFIDr02jDJue+L6Ly8lgJtktjoC5iwWGEA5uWQfXIMFYfF14Ib0Y3
 fzMd79pfvp3ivT/kl6p2M+NzicKWC6mEnWLNQeQoVJ2OkTkNTUJAp78GyTtRGi22eVUk6s
 irVmzg99D+FZwuTyLNntdjHZ99g29EA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--2Aa9LwFP6ewJrK51XFc7w-1; Mon, 02 Jun 2025 12:20:19 -0400
X-MC-Unique: -2Aa9LwFP6ewJrK51XFc7w-1
X-Mimecast-MFC-AGG-ID: -2Aa9LwFP6ewJrK51XFc7w_1748881218
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so1264062f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 09:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748881218; x=1749486018;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UND6LBgYzKh5UJoTdUouoreyW1Exj+atQyioQIzdY4E=;
 b=Kn2eVK4ZECPFkm/npn42BFs7QcxgcXFVhbS2Tx/WXBVapm01s0IedhSHn+56PWdH7x
 nc2VI5g/lfN5cn0u0w3S6rs8HX4Q1TxgHGsDKnCON8uJWpfIXoEWupi9gkc4RiOVCDHF
 0FTkMNAdafTPovool5syKGum6sWckEtgF3UwkTSq4GP9maQolYrfeJ+GuK730Kg/CZh2
 nbvMkjpe+0cDs6oIoZeP0R2qkRHlgrR0/2RZ2POXiUX1axvcKldHhqIzMEy5FXUGpmJI
 vDJcNTQp4Gorg9UkKMj0ijmSIqAvsNlD+q2LahFUesZQirKZ8xfASGLkkmJiPq3tGjd0
 HwJw==
X-Gm-Message-State: AOJu0Yyc0WaqD+6NPqwj6xcYdVfy3/uvpy8vZX/NFHtJvSzHN6sJ6Wu8
 hel2nIMUOBXo0uQyG+MgC3Bjhlhy2tlix8aPEvRvNEfbrrYl44L3y2Y9CPnBlTm+/NgXl1wugPM
 9LsigF2KL/5RhtzFld8auMASiOs/H40cPSjt2ssn4b+V3wY03Fblt9ajO
X-Gm-Gg: ASbGncsLoZiNu3rpDpkl8wzIYoP/KsBqdi5H8H4FfR+1qGrnIAsTV82fVvjYV7dPReK
 dCvfZtmbHKBYwMGVBbyHmqbF3TLm8UPDzV3WiNU121/eUSi1L8EzYhzbeCfG06nJQbk5B7Oqe/W
 47HVmgLfCpJGQLHto3ELTi7ha2IqZOOm5dedFOoe1AheWTllM1AzfWPfQ1qqFRUfm9f908k/gZ4
 sFe3xcgs3F7ghSxulEUZU2E9D8ZEAf+D0GYo094pALy/b76jsBagHxCtfCMxPJRySY58F2ARMZK
 7KSr+lo6yt/KIJIYjkobfGMKDEviLttFBisMAR84r0vJYoOLQE06
X-Received: by 2002:a05:6000:18a5:b0:3a4:f70d:dec3 with SMTP id
 ffacd0b85a97d-3a4f89bec05mr9189329f8f.16.1748881218097; 
 Mon, 02 Jun 2025 09:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESiDUL2+Vs7VE18oAK2IebVTWJNb220qZwPtf+CLouMGiM/sUVb1+RbvPc3MVVi0aOEJatLg==
X-Received: by 2002:a05:6000:18a5:b0:3a4:f70d:dec3 with SMTP id
 ffacd0b85a97d-3a4f89bec05mr9189300f8f.16.1748881217672; 
 Mon, 02 Jun 2025 09:20:17 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c525sm15331568f8f.23.2025.06.02.09.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 09:20:17 -0700 (PDT)
Message-ID: <1a5e1073-f624-4429-a7ca-6a5500fe036d@redhat.com>
Date: Mon, 2 Jun 2025 18:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is anybody still using the "highbank" or "midway" QEMU machines?
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
 <1301bf7e-0e52-43c0-9910-55ea34647a34@roeck-us.net>
 <CAFEAcA_0Hu8+G50sy0FJ2rX-=cNymLddDdrS2nN5ZY-doKiT8w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_0Hu8+G50sy0FJ2rX-=cNymLddDdrS2nN5ZY-doKiT8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/06/2025 17.31, Peter Maydell wrote:
> On Mon, 2 Jun 2025 at 15:24, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/30/25 07:23, Thomas Huth wrote:
>>> I was trying to create a functional test for the "highbank" and
>>> "midway" arm machines of QEMU, and only succeeded after lots of
>>> trial and error to boot something on the "highbank" machine.
>>> Peter mentioned on IRC that he also does not test these machines
>>> by default, so we started wondering whether anybody is still
>>> using these machines? If not, we should maybe start the
>>> deprecation process for those instead?
> 
>> I don't try to boot midway anymore. Commit log shows:
>>
>>       midway only works with an antique version of qemu. Stop testing it.
>>
>> That was back in 2021. The log shows that it needs qemu v3.0.
> 
> Might have been fixed by QEMU commit 61b82973e in 2022, which says
> # This change fixes in passing booting on the 'midway' board model,
> # which has been completely broken since we added support for Hyp
> # mode to the Cortex-A15 CPU

FWIW, I can now boot the midway machine at least to a shell prompt with the 
latest version of QEMU: Grab the "Trusty Midway" images that are linked from 
https://wiki.ubuntu.com/ARM/Server/Install/Calxeda ... unfortunately, there 
is no dtb available, but you can use dtc to compile 
arch/arm/boot/dts/calxeda/ecx-2000.dts from the Linux kernel sources into a 
dtb file that seems to work. Then run QEMU like this:

qemu-system-arm -M midway -nographic -kernel vmlinuz \
  -initrd initrd.gz -m 2047 -dtb ecx-2000.dtb \
  -append "console=ttyAMA0 init=/bin/sh"

>> I only test highbank manually (not in automated tests). I have this in my code:
>>
>>       # highbank boots with updated (local version of) qemu,
>>       # but generates warnings to the console due to ignored SMC calls.
>>
>> I have not run the manual test for ages, so I have no idea if it still works.
>> It also looks like I removed the local changes. Those were needed to enable basic
>> SMC support for highbank; maybe similar code is now upstream.
> 
>> Ok for me to remove both. Not worth the trouble.
> 
> Cool. I don't think these machine types provide anything to
> users that is particularly interesting (if you just want
> "boot an A15 or A9 Linux" then the virt board will do fine,
> and the original "test system software for this hardware"
> use case is long dead). So I'm in favour of deprecating
> these (and eventually dropping them).
> 
> There's not actually a lot of highbank/midway specific code
> here (no complex SoC modelling, lots of stock Arm peripheral
> devices, so just 400 lines in hw/arm/highbank.c, plus another
> 450 in hw/net/xgmac.c for the ethernet controller), but
> if nobody's using it then there's no point keeping it around.

I think I could also try to create a functional test with above images, but 
if nobody is really using these machines, deprecation likely makes more 
sense, indeed ... do you want me to create one of those two patches?

  Thomas


