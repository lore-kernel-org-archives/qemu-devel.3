Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D16C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhDm-00011X-De; Thu, 29 Feb 2024 09:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfhDk-00011C-Ak
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:17:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfhDh-0002kq-VS
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:17:12 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 445B841012
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709216226;
 bh=3ktERJNdKhBJ1YQ27KnTJIGcParFel8BoUgWki4tdfg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kk6S/u01IoZX6H9gJ2MwJYH2QtOSY6mEyO2qDJq1rDghQfM1d7t1SCGD67LevYizc
 h7dGxvVGpS2VwYQSncKXb9pd29KECUVuQW5ggSL7VVo+6rIUT7wtzVcCWORLGgj4q2
 RRfFqQj9P2Z/XpvqemVlO/LUHUczM3qio2IBs8Q6DcXdeDG2dfVUYTuKHjAEY3krua
 ZOYdcvrbwTlN4NGRvc4AsIdA3a000ef5UqeUmrSw35ovKSFtcmunjdxRudCYBU3/Bi
 uYUjKX6IXPsTvfYuMOpsAc79IqH52M7QzcVfUjvB2SlyjcTieWPOY1fkalw5G0QNoR
 saC15fb41pp6g==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3e6f366aceso71060666b.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709216224; x=1709821024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ktERJNdKhBJ1YQ27KnTJIGcParFel8BoUgWki4tdfg=;
 b=L8qmeIMEvIUhaYO1QFPIxRvfYGY/AF0NFXRijHh8HXPEwj+0M/4WAIqxWZaz9qmhOr
 y+IsMRhkQplmdeDAGZ8PWYGJd2Vk3vYbIcJz4vqd4TzWjkEchc99hGwNB9kV/b5f/5ID
 3fDG625DGlGKobhCxEEkyhTOf6laN4h4rybSDcG5EJATzgo+B+bU3K/iUmInTSKvJKsY
 r2swDCsxjo5VDlNAVQ+EUDb/xhzVRx3T8F2DtV9psNuI+gulu73hveHGT8JIO3qImNQI
 MT9Yg/azqCq6TjESY/9v3Oc73VPeeD0DzbWKkhtH2SRaBu62dJCkm5VqslBqZuL5AC9v
 i64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiO3cTzeB/4vtzdGfdI2sQyTXdvKp6CCrIQ5X+R3S1flCwunJ1mpLFlIOK7HjIbPuGuNFb9P6I8zRuPb3Ga0WG2fjwjtY=
X-Gm-Message-State: AOJu0YzGTPyEwiy8TJA70iEEWHzmHUJCqsAkzYOeI4/9EJITqVU6lBO6
 BnqM3oJBnIRofC18QJGzf/XVDWY7VBriY2ahXv/D6TH8SxoJNGz2r6oWPIOxcpEOKISsg4xhst3
 1hrOi5y4sZlcazkHKw37XDY11H/COI9GRXlzhsHrC2eIjb5X4CP1WTBpOdXKtNnZO3J22
X-Received: by 2002:a17:906:40d1:b0:a3e:73c8:cd27 with SMTP id
 a17-20020a17090640d100b00a3e73c8cd27mr1696355ejk.73.1709216224062; 
 Thu, 29 Feb 2024 06:17:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFiQFxARKpzmqmTmmE6+nnR4aVwmR7XKA2ok2ZWHW5+V46Yv+wVE9SECqW3dhcLiDRjn6jGQ==
X-Received: by 2002:a17:906:40d1:b0:a3e:73c8:cd27 with SMTP id
 a17-20020a17090640d100b00a3e73c8cd27mr1696342ejk.73.1709216223736; 
 Thu, 29 Feb 2024 06:17:03 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:3e7:44e3:487b:13d?
 ([2a00:20:10:8f6:3e7:44e3:487b:13d])
 by smtp.gmail.com with ESMTPSA id
 vx11-20020a170907a78b00b00a3f8cd4db25sm720135ejc.196.2024.02.29.06.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 06:17:03 -0800 (PST)
Message-ID: <4797d9ef-65f4-483e-9bb7-f79bbfa5172d@canonical.com>
Date: Thu, 29 Feb 2024 15:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mattias Nissler
 <mnissler@rivosinc.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
 <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
 <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.02.24 13:34, Peter Maydell wrote:
> On Thu, 29 Feb 2024 at 11:17, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>> But yes, I'm not surprised that CXL runs into this. Heinrich,
>>> are you doing CXL testing, or is this some other workload?
>>
>> I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:
>>
>> qemu-system-riscv64 \
>>         -M virt,acpi=off -accel tcg -m 4096 \
>>         -serial mon:stdio \
>>         -device virtio-gpu-pci \
>>         -device qemu-xhci \
>>         -device usb-kbd \
>>         -drive
>> if=pflash,format=raw,unit=0,file=RISCV_VIRT_CODE.fd,readonly=on \
>>         -drive if=pflash,format=raw,unit=1,file=RISCV_VIRT_VARS.fd \
>>         -drive file=sct.img,format=raw,if=virtio \
>>         -device virtio-net-device,netdev=net0 \
>>         -netdev user,id=net0
>>
>> This does not invoke any CXL related stuff.
> 
> Hmm, that doesn't seem like it ought to be running into this.
> What underlying memory region is the guest trying to do
> the virtio queue access to?
> 
> -- PMM

The error occurs while the SCT is executing function 
BBTestReadBlocksConformanceAutoTest 
(https://github.com/tianocore/edk2-test/blob/cabb98d44be94e7547605435a0be7c4946d10f8b/uefi-sct/SctPkg/TestCase/UEFI/EFI/Protocol/BlockIo/BlackBoxTest/BlockIoBBTestConformance.c#L45)

This code is accessing the drive defined as
-drive file=sct.img,format=raw,if=virtio .

In the conformance test correct error handling for invalid parameters of 
the UEFI block IO protocol is tested. This includes calling the UEFI API to

* read with incorrectly aligned buffers
* read with invalid LBA parameter
* read with buffer size not being a multiple of the sector size

In all these cases the UEFI API implemented by EDK II is expected to 
return an error.

Best regards

Heinrich

