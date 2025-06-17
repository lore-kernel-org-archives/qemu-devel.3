Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13384C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSiq-0006AX-HF; Tue, 17 Jun 2025 05:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSip-00069T-41
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSii-00081A-Mr
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750152907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IxRAZDdRGkQQHubgoZbvwTEto/wqcug0Mn7VTI75TQ=;
 b=BOAwPTvC1apwn9HL4BrD55j1lFnAMHrK6dJNVurnjOsqcF7PnEY4q9Q+apUQoZC5jk8f4C
 SmRyzwk+aVE8lnADquDOLuHPzxCPWgzbeJtmxEKs+sdNHEXfcw+jCfYmxktTmMiJ4Vod1w
 OR68KHEDWQKNfHt1XTKwxoEoLt0GxKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-phR6JLv4P0e-N0onSIstvA-1; Tue, 17 Jun 2025 05:35:05 -0400
X-MC-Unique: phR6JLv4P0e-N0onSIstvA-1
X-Mimecast-MFC-AGG-ID: phR6JLv4P0e-N0onSIstvA_1750152904
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4530c186394so23866225e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750152904; x=1750757704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4IxRAZDdRGkQQHubgoZbvwTEto/wqcug0Mn7VTI75TQ=;
 b=baqUeHWLE0/jTeHPSoKo7ZXwgYhQN4eJnOOW41ryjsUYCxws3HQfUXlNahEluc2k/U
 t3vfXjl8uZhgMd+l05MSu+Hp4I0Af9OmQnmwLCc3VqSYnQ99en4XMXUtAbJrS/bpCUwr
 gpUxOwQnlbvg+U3AY4rc4K4yuRYhD7URSDDVCJXA5DQ9SFnQ9WdBVSGoArhLn+/9jqr2
 NOpyUTtwcSDwdaOBoUWEYV/4gzM0ZxGxx3Fg4vhCQeCoIB3bngeTky085r3TgepYKVpv
 0p0GdawFqKzpuRzbl+pkoVGGt90L8uHOW7dDZCDcMw6EKKuVfiEPbkBPfjcb5Wy8yfae
 CNWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrfpS5PZ57TXqZltZXoibRWAz6nCBdOEiy7X8/+YpP2l9VI15f3Jngbw2XKNqOcE/46LCcsiEonruy@nongnu.org
X-Gm-Message-State: AOJu0YzDoe/9yzye1HwbQo53wJIjJe3JOAgr9wx4fMfP34onSh8rCAkZ
 wwRXNR09Lm3H20zKbgQtpRS/dhJozf3JDgJQHon3ndZTZj3aLq0XqQLxFKlcGlJihq9T2CMc4E8
 AqC4ZUZTF/x5JOjYLT/sp1If/uujfACKUhxbZyap03nSzAOa96Kbzy1H8
X-Gm-Gg: ASbGncsKkCaH6ehRPGcNMguJWhHr+S/WN68f7TUUCGiSFLobc2/SpPS59xVYA4HJRYN
 BgoLkcKF96FVpLfcIh4Boc/rbIdgxiCZ1wWcIRScLUdX++/LcZuqltTd0/EjtzTVOUaZWD6EZSX
 U7NNgbqgmi8iq+NcBCHNSoahn5oFCC5oRZnQVyeUTz1KYtTWMAqV3LQsfsLqEPx7F3y4VeOpoqs
 zoHL5+NQXSYHoKTo9kGEZ3cqwhKz8t0Ac5MBG1CJHwdWS5u7GNWbG4VW0yWRWSOcudqdTZaFGi4
 LbpDv0/YZvuMCT5mD9kVpgZzmuMDeWvvffkjE67amg9mwY1cGTtZtMYRPMGv9fTfoVPJVg==
X-Received: by 2002:a05:600c:4e09:b0:453:6f1:bdba with SMTP id
 5b1f17b1804b1-4533cb3bb4bmr101297755e9.20.1750152903974; 
 Tue, 17 Jun 2025 02:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeNRmGLbdBsxDpbmRGNNlYaih/7/XV82wwUqCPMwc3cSbIiCSnfyTp1Qw527wqAwMeSXEyfQ==
X-Received: by 2002:a05:600c:4e09:b0:453:6f1:bdba with SMTP id
 5b1f17b1804b1-4533cb3bb4bmr101297365e9.20.1750152903583; 
 Tue, 17 Jun 2025 02:35:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4531febf905sm197876505e9.0.2025.06.17.02.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 02:35:02 -0700 (PDT)
Message-ID: <5b0f2250-e521-4172-870c-0384c5ef2382@redhat.com>
Date: Tue, 17 Jun 2025 11:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 0/8] hw/arm: GIC 'its=off' ACPI table fixes
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/16/25 3:18 PM, Gustavo Romero wrote:
> Since v2:
> - Fixed no_tcg_its inverted logic (rth)
>
> Since v3:
> - Fixed remappings in the IORT table when ITS is no present
> - Rebased on master and resoled conflics, like no more "no_its"
>   flag in VirtMachineClass
> - Dropped patch 1/9 because we actually want the instance flags,
>   not only the class flags, and the instance flags are the ones
>   to be used often when deciding about the presence/absence of a
>   machine feature, instead of the negated class flags ("no_*")
> - Adapted the other patches that depended on 1/9
> - Dropped patch 4/9 in favor of using the instance flag for
>   checking if ITS is on or off
> - Simplified VM options for the new "its=off" test
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
>
> Fix ACPI tables for '-M its=off' CLI option and resolve the issue:
>
> https://gitlab.com/qemu-project/qemu/-/issues/2886

One first comment is that this series will collide with Shameer's SMMU
multi instance series which has been lunder review for quite some time
(adding him in TO):

I think it may be more future proof if you could rebase on it - I know
it is a pain ;-( -. Or if sbdy objects for Shameer's series please raise
your voice now.

[PATCH v4 0/7] hw/arm/virt: Add support for user creatable SMMUv3 device <https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/#r>

https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/

Also I understood Shameer intended to write some new bios-tables-test.

Thanks

Eric

>
> Cheers,
> Gustavo
>
> Gustavo Romero (7):
>   hw/intc/gicv3_its: Do not check its_class_name()
>   hw/arm/virt: Simplify logic for setting instance's 'tcg_its' variable
>   hw/arm/virt: Simplify create_its()
>   hw/arm/virt-acpi-build: Fix comment in build_iort
>   qtest/bios-tables-test: Add blobs for its=off test on aarch64
>   hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off
>   qtest/bios-tables-test: Update blobs for its=off test on aarch64
>
> Philippe Mathieu-Daudé (1):
>   qtest/bios-tables-test: Add test for when ITS is off on aarch64
>
>  hw/arm/virt-acpi-build.c                  | 134 +++++++++++++---------
>  hw/arm/virt.c                             |  25 ++--
>  include/hw/intc/arm_gicv3_its_common.h    |   2 +-
>  tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 172 bytes
>  tests/qtest/bios-tables-test.c            |  21 ++++
>  6 files changed, 113 insertions(+), 69 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>


