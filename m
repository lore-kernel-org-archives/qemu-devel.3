Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D28CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 00:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKmMS-0001C1-Na; Wed, 06 May 2026 20:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wKmMS-0001Br-4U
 for qemu-devel@nongnu.org; Wed, 06 May 2026 20:13:04 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wKmMQ-0002TP-Fh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 20:13:03 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-130a4aae5ccso900778c88.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778112781; x=1778717581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=n1TbbqV5HyIfM3lS6Y3EjDs4IZ44pyzJ3iJw1DOe8WQ=;
 b=Mh2K52RXusxbI4a1f3KK5OLwK5OuaNxRuTPiwUpbSOsK9x0KxkGxm726ybkfb7aWdw
 IwBPS1kG/6ayfPkCFsVzSaGKl+r+BRqB7+nss3aF9eXEHxApc46SuNRvKiI2CyUFY8H3
 oiNv5/VGj1Tnp/F5skTkQMGjTXMscIXEsadDETOEwd/eLRhLFq6s8WxXVmA0nd5WBHUi
 5b22Eph4qqs4bF90Q1Dy2hi2ff9ilg6Poi57nKchyMSSvte3RXISGuCNRKIPE/V7G+Wn
 GWkZ6i5/tY62X0etSTf1OtDbXEtxITdTpR0JdmNuulxidZ+WkJ5RFy0cND0R9uP4k7Oc
 t+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112781; x=1778717581;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1TbbqV5HyIfM3lS6Y3EjDs4IZ44pyzJ3iJw1DOe8WQ=;
 b=SeD8S4X7jIyg77jwZQdHtkkLJGZ83WhKeCLl5+siC6txKqFO763Zftemo7iDOQI7BY
 DFcgoZCT23JnR6dg3a2DeeYyeEMIlDijUWGCOrH5zeHtK9w6CvIExdS9H1NC0ThtSCdE
 zzLbsbACKYwK8RpRJKx6Ciq3omjdTWUzXdRP84hr4VM+F8uf1IvpJwGCj0Ok+yyOOH+6
 /NwfziUGgkHa2T3yIyDOwPhaN5U5Idz/iHCQTy5tu4rmJWzsLqimfG8H13MpW16S8gg+
 i6qsNVJ1Ym39Oqb/PYN4Lc6vUnShxt/DQhE7MXlBM+WWMgVGss4nPeWJwa+mN/0NvAXc
 iSUQ==
X-Gm-Message-State: AOJu0Yzw+KptfS25jNFeW3+GanzF4xm+2bLWWGY0DMdNKgAi5AQ+i2Rd
 bMutOaVPouueNUkoVUXuAEK/odIewAKho8bqQl0AXo+1L6hlPV6JAaZ/
X-Gm-Gg: AeBDieu2BNAYYdXDW0O1jmVQIo/XAJwqJEp/3SzUGMtdyHoSJ2g0UdcZGG5FdPWKHBl
 bn8WKv2T3wIAoHxo407FHTPwdBd8ZB5stOZHWhDxAefMkbTerGbD75XmA1BLLYXjnc3+iDd7+Gm
 +koEp9ayfZloA7kMZT6lwTJZ79f/aBtqJLF8j/Aua9c9tnKKkLUD4Nzl+tfFuMdNDrs6hapJgce
 h3cvNC8CmeZxGCCDn6klyOu5sLK0hYJuVCggcjv20SPopbjrVLNjFOrwKvWngR4R/7okjW8Yj46
 wThwKZ7ovKEzuKOWyqQQoNuHalnrCepx+8s9Ilya9xFwFBST0IMqGNF38gSBaMHO89r0qDlajC1
 ilQWPIDZLxgx2W8XGtPVvwXPnWnHuG8MKwbVei4muKj+/lABQWBj4X1fjKTNVcWUuaqmYCcTkar
 rGzJXny4U3JcE0/pcCjv8/A+i2k130mSf2Vbd1VK7bo2UBYi5wHGPa0/J3pDTnHvEMsx+hqtjjF
 T6IBF/A7RHD0LiuBUVFCw==
X-Received: by 2002:a05:7022:6609:b0:12b:f881:d8fb with SMTP id
 a92af1059eb24-131853ec757mr3053345c88.3.1778112777412; 
 Wed, 06 May 2026 17:12:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202db27bfsm5580705c88.10.2026.05.06.17.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 17:12:56 -0700 (PDT)
Message-ID: <0a97d5ee-55ed-4a7a-9d71-e728dc661006@roeck-us.net>
Date: Wed, 6 May 2026 17:12:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: Alistair Francis <alistair23@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, integration@gluster.org,
 Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=groeck7@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/6/26 16:40, Alistair Francis wrote:
> On Wed, May 6, 2026 at 10:03 PM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I'm cc'ing reviewers and lists mentioned below, and frequent
>> contributors to MAINTAINERS.
>>
>> There are a number of MAINTAINERS entries with S: other than "Orphan"
>> without M:
>>
>>      $ awk '/^M: / { m++ } /^S: / { s=$2 } /^$/ && s { if (!m && s != "Orphan") print t; m=0; s=""; getline; t=FILENAME ":" FNR ": " $0; next }' MAINTAINERS
>>      MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
> 
> Conor, Sebastian and Guenter, are you still using the Microchip
> PolarFire SoC Icicle Kit? We currently don't have a maintainer for it.
> I'm tempted to deprecate it, as I thought it didn't really work
> anyway, but I wasn't sure.
> 
All I do is to run a couple of Linux kernel boot tests with it.
The idea is to test the Linux kernel, not the qemu emulation.
I neither have time to maintain this, nor the hardware to
cross-check it. It is ok with me to deprecate it, even more so
if it doesn't work well.

Oh, and I just noticed that I carry a downstream patch to make it
boot with Linux without backtraces. Ultimately that suggests that
no one but me is really using it. Another reason to deprecate it.

Thanks,
Guenter

> So is anyone using it and is anyone willing to maintain it?
> 
>>      MAINTAINERS:1792: SH4 Machines
>>      MAINTAINERS:2022: Machine core
>>      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>>      MAINTAINERS:2555: vhost-user-scmi
>>      MAINTAINERS:2862: XIVE
>>      MAINTAINERS:2872: Renesas peripherals
>>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>>      MAINTAINERS:3719: Checkpatch
>>      MAINTAINERS:3746: RDMA Migration
>>      MAINTAINERS:3894: Record/replay
>>      MAINTAINERS:4029: OpenSBI Firmware
> 
> I'll pickup this one
> 
> Alistair


