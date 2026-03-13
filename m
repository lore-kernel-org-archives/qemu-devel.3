Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CA3106FD9D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xwm-0007Iu-DV; Fri, 13 Mar 2026 04:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0xwf-0007Gq-Mc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:32:33 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0xwd-0003vK-OM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:32:33 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-899fb030812so27180046d6.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773390750; x=1773995550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eh6IRUepxclXFelwPyRG7T0J4onKkZMI/jqyv3PlzJc=;
 b=fo4iRFZy/6TM/YzwwaOb74K1f8dds2sw7KCoK1ScBHNd7MxED//rmYliT56ewdg1Uk
 28sKrQGTK63miyy0yRYzSxCSBY8tmmr5YxjpGdwSb/u44lTOpi+VUBDFU1C0WhtVFBgX
 Bl35dSrEYlOSHBUUh3LLQqDpQCCRIUK40bMhATaBkIY4MjEe7rVIRMRDrA+sdHa9g+5v
 x0tpF8kk3Xac5mYJ211RQaOVnHXUnJISi89O6wErM85kGFy1GPihFu32Gierba9+8FGU
 SUNPbrAN2BVOfAb0ApSr7dLjuHbB0QflcADwzhndGqpsqokkQ03OnkNm96A3P3PJPSgw
 aC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773390750; x=1773995550;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eh6IRUepxclXFelwPyRG7T0J4onKkZMI/jqyv3PlzJc=;
 b=VLta1gDbvP50dFcwAMDepSneAUL9qSN7DPiBXJoLkU2UDoJ11sICC0zgfsK9clQvnb
 F0BLywDpl8ZQXbxV5qOjdqVCwQftfvTCl8kd2YaRt8asqvNp4tjh3mksUbaUz30wBQtM
 S47QMetSw6nxnSCP2lOgwxSelvPqGyYo9GIasuIa1K283Pdz7udySANWg2sPgMZIoH81
 Pmjql2Sv4tFeQFQibprtK2xcGCDiZscLsdPXcFRgKj5A4bxvBp2Kmsw4cYHfNXfHaFnJ
 K2HBtM0WgJ9uZAFuPx+LIAhQfsCWMfYRUHBLb/N0xTrascchXgz+MonT7T2spmCKwpob
 Woxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlRr0AKLvHBjN0v+sQM5iBNJZhmrT7ahfmFretX+jie28po7BgNBQeOXM0e8NxfnjY9FLpemAZvlUu@nongnu.org
X-Gm-Message-State: AOJu0YzHXN1xwdAfEMrD0cI6M7jzJETckFfUVrImoKUMjdzAF/n0VitS
 y9r49Xnc9HtrAjC2id0S+uVYKy7P4mT78VgQy1YEtXI57PhfwIAm5UJrIeXyypILh0Y=
X-Gm-Gg: ATEYQzwOdweTnKAftS/ukF2pkPl3bimWVtf9CJ3SAP/hwU46GceUbQbU/IyW2PR/WrD
 8Kq8Okwjid/siJfWQa2eiCaTujK15Puh6YeV+Q1SJEZ6CJ+J7EUTmNbJ8OLi/3826Yx1SHdYW+P
 xRbBAotMYjq5a316Ym8u/yS3nTIirKT+VA3VtU9lwdqxZKNla1StvK+hbj59B7RF2ni+tRVE4hq
 MIIYPhddTbrcokBtDXdCLGbU6Mo2cojBc3YcOR1W1WdY/lv27cQGbogsOnStnJitNbJQmiuXavs
 FSC21aERqdU6DZfHkqkKy3eCOKmgHGaIwzU0inmRsEibb9fmgHCEZ6EsnHlCKazqsoNTbRSuJiq
 aNJvsV+gPAmI+VA9ZyEwmPzuY2Oklus2qvdMcYdEiovqZ6cakzPkb8qcXE4w7lQTeDfLdRnfAIS
 2a9D88/VgspRRNF6n6VwViluGFoRavBEIvf7mt2ZS2E2zP6XrvUTYJEVQEQ37l2ipQ+Q8o
X-Received: by 2002:a05:6214:411e:b0:899:f9f5:979b with SMTP id
 6a1803df08f44-89a81dc6e4emr37016756d6.22.1773390750232; 
 Fri, 13 Mar 2026 01:32:30 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65ce34a0sm51625366d6.32.2026.03.13.01.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:32:29 -0700 (PDT)
Message-ID: <901ee0a3-a70f-4fb3-8102-554fdd550941@linaro.org>
Date: Fri, 13 Mar 2026 01:32:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/vfio: single-binary
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <61656692-dc0f-4e34-8b81-c2422928d017@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <61656692-dc0f-4e34-8b81-c2422928d017@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf29.google.com
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

On 3/13/26 12:50 AM, Cédric Le Goater wrote:
> On 3/12/26 23:44, Pierrick Bouvier wrote:
>> This series makes changes to hw/vfio to compile files only once.
>> Changes are pretty straightforward and are mostly extraction of kvm/other config
>> specific functions to proper files.
>> This is the last hw/* subsystem that needs to be changed for single-binary.
>>
>> Pierrick Bouvier (8):
>>     hw/vfio/listener.c: remove CONFIG_KVM
>>     hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>>     hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>>     hw/vfio: eradicate CONFIG_IOMMU from sources
>>     hw/vfio/pci.c: eradicate CONFIG_KVM
>>     hw/vfio/ap.c: use full path for target specific header
>>     hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>>       hw/vfio/kvm-spapr.c
>>     hw/vfio: all vfio files can now be common files
>>
>>    hw/vfio/kvm-spapr.h          |  12 +++
>>    target/s390x/kvm/kvm_s390x.h |   2 +-
>>    hw/vfio/ap.c                 |  11 +-
>>    hw/vfio/ccw.c                |   9 --
>>    hw/vfio/helpers.c            | 172 -------------------------------
>>    hw/vfio/igd-stubs.c          |  20 ++++
>>    hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
>>    hw/vfio/kvm-spapr.c          |  47 +++++++++
>>    hw/vfio/kvm-stubs.c          |  35 +++++++
>>    hw/vfio/listener.c           |   4 -
>>    hw/vfio/pci-quirks.c         |   5 -
>>    hw/vfio/pci.c                |  37 +++----
>>    hw/vfio/spapr.c              |  30 +-----
>>    hw/vfio/meson.build          |   8 +-
>>    14 files changed, 331 insertions(+), 253 deletions(-)
>>    create mode 100644 hw/vfio/kvm-spapr.h
>>    create mode 100644 hw/vfio/igd-stubs.c
>>    create mode 100644 hw/vfio/kvm-helpers.c
>>    create mode 100644 hw/vfio/kvm-spapr.c
>>    create mode 100644 hw/vfio/kvm-stubs.c
>>
> 
> I am glad we are getting rid of #ifdef CONFIG in the code. I wonder
> why we stopped using stubs in the past.
>

Probably for convenience. An ifdef is quicker to add, can be more 
readable, and the only downside is that it breaks all possibilities to 
mix several targets in the same binary, which is a new and recent goal.

> Anyhow, as said, what bothers me with this change (which I like OTOH)
> is that it is exposing IOMMUFD support at the UAPI level. But,
> 
> 1. only i386, s390x and arm have IOMMUFD support. Not PPC for instance.
> 2. downstream can compile support off
> 
> That said, support should reach all platforms one day. So we could
> say that relying on a runtime check is preparing the future. I am
> not against the change but it needs more thinking on the consequences.
> IOW, a bit late for 11.0.
>

Sure, I'm posting it now but don't expect to get this merged for this 
release.

The IOMMUFD part is indeed the one debatable in the series. My rationale 
was that, even if it exposes iommufd properties, they won't have any 
effect as long as kernel doesn't have support.
Having played with it in the past, and having discovered that arm64 
kernel defconfig does not enable CONFIG_IOMMUFD, error message is quite 
clear.

If you prefer, we could definitely try to build properties at runtime. 
However, be aware that it's usually less readable (need to build a 
dynamic array) and more clunky than the static const array, since it 
requires a set_X callback instead of setting properties as a field. It's 
usually our last solution resort if exposing things is not possible.

Let me know what you would prefer for it.

> The idea is great. Let's try for 11.1
> 
> Thanks,
> 
> C.
> 
> 

Thanks,
Pierrick

