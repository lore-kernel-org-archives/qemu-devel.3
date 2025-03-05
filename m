Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C9C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdRO-0006av-TU; Tue, 04 Mar 2025 20:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdRM-0006a1-CV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:20:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdRJ-0005k6-9N
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:20:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390f69e71c8so215535f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137647; x=1741742447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tk/h5aC9157IndKi5d93agJzQQcdRdCNAHnwM8zwr7s=;
 b=Xw+ScyPTqa/E4fQ2DYfccOmiUMkQnKRjLi3UFWu3I3vtdwMCgxEzt4T9S25RxvtOQJ
 dBCoJXnrEudswLFDtRm73HYwCTN38/Uqz/Vg4xaghSG+IUgTCdBuD5mdjA2vdU8eJPc9
 T+eAEYRQ5W/uxxAXyU+zbfCF6Ootc2eF+i4+lKzfigl658yG3ip0sTGg2LyPpT5SnhEt
 ix02JUT7em6riz650r8yuzsUOBjeKsvlnlAh5OFGk+7hT3zpIUOnjOUgCgT1EQop4B52
 YJLAXSggR0UjrqHUcsLHkwfHOpxULm2jdDpGjuu8OyV2SviMvw6WTsyEfD7b3ngJrdWw
 FTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137647; x=1741742447;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tk/h5aC9157IndKi5d93agJzQQcdRdCNAHnwM8zwr7s=;
 b=iarBABQTNucKlWe1FsKgjVMqlGetGhx/TYsChpPgNrvlq9sna7kTbw0LS41dZ4KU9O
 DSWtc2pcJcWPuS+FFqCneR8++T1srKGuwDVwR4vcFylnpYu5N7bylPIdp2qNHws39SrD
 q5aRs9VPay/8j51INsZzA8qZQIUIkJdOCpzQ6mtfj2MH1PjdBPlE/klPUEd7x4viazAW
 Ga3a/913rBUuKOdapAGR9RKEXWCUCYpNFe79TjRyXKJR/4xd3zK3IRVaX1hj4s/nW/HC
 BnxWhCg1c6hRx0qH6VjvgmqICRqYpArl/Mn9Zx9KuGWaorjdkhAVMPpWInekgZ94lCsh
 oCzA==
X-Gm-Message-State: AOJu0YygKYDK3lXBzCTOBo9h2KcccAhayehaI8bRIF278Tn5sHQBKRCw
 C9vclQ1N0AHAVdWLnbswJC7hR30LnDjg+jotHz6QvKiIj8+holJD4g75ZbVHB80=
X-Gm-Gg: ASbGncvoMNQt9gTL0Groi1xqEKPsRUHMSVhtkBPH/MpG15rOn45EnHY89s3XYzRVcuk
 T9LaGqYmFs1MzfKVQlu9Z8KJE3KBNOrB/M6EYlG+Ib8vpVN4xi4uCPajb21trn9VtaefZvQ1Yp6
 eDVy3aKbHGyRb4Hg14LW7RHphFX3YOM7/nq2KpX00fPpK8bPAdxCUZ33+1743M9a+tNPx+zNoXL
 0Sg/uDnOjleNIJwExY6Id5Gy3YGL+7BRXf6pz/48WJ8DOecybFDUReeZAzwk/FHAE2eXwQuxR6a
 9YoXIi5nLUeAt5Idv3A6v+gmPn2fxem234i66wrclbClBMBev5b++rldw7gFu5RYl3OI4PKU+51
 QB79m/LD8eRgN
X-Google-Smtp-Source: AGHT+IEUM1iwwu8LPCt3wShcauBD88FFdJciFH6VNKztu3VtAO0/r2xK/eKIdMbodubiw3iBG6BsHQ==
X-Received: by 2002:a05:6000:4009:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3911e9df21fmr958328f8f.8.1741137647606; 
 Tue, 04 Mar 2025 17:20:47 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d1asm18998820f8f.4.2025.03.04.17.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:20:46 -0800 (PST)
Message-ID: <b6d6b2bc-bd5a-4917-9486-9a23ba4afbf4@linaro.org>
Date: Wed, 5 Mar 2025 02:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/11] hw/vmapple/vmapple: Add vmapple machine type
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Phil Dennis-Jordan <phil@philjordan.eu>, peter.maydell@linaro.org,
 berrange@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, mst@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Alexander Graf
 <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-12-phil@philjordan.eu>
 <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
 <CAAibmn0tV_YLwJwcgfy5sZiPyeaBWE_FPOPEEE_0aZ7mMANFig@mail.gmail.com>
 <81390b0b-bae7-43bc-84d4-7447805a1a83@linaro.org>
Content-Language: en-US
In-Reply-To: <81390b0b-bae7-43bc-84d4-7447805a1a83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/3/25 23:11, Philippe Mathieu-Daudé wrote:
> On 3/3/25 21:36, Phil Dennis-Jordan wrote:
>>
>>
>> On Mon, 3 Mar 2025 at 19:20, Philippe Mathieu-Daudé <philmd@linaro.org 
>> <mailto:philmd@linaro.org>> wrote:
>>
>>     On 12/1/25 22:00, Phil Dennis-Jordan wrote:
>>      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>


>>      >   MAINTAINERS                 |   1 +
>>      >   contrib/vmapple/uuid.sh     |   9 +
>>      >   docs/system/arm/vmapple.rst |  63 ++++
>>      >   docs/system/target-arm.rst  |   1 +
>>      >   hw/vmapple/Kconfig          |  20 ++
>>      >   hw/vmapple/meson.build      |   1 +
>>      >   hw/vmapple/vmapple.c        | 618 +++++++++++++++++++++++++++++
>>     +++++++
>>      >   7 files changed, 713 insertions(+)


>>     Alex, Phil, we now mandate a SPDX tag. Due to the license used in
>>     vmapple.c in this patch, are you OK with me squashing here:
>>
>>
>> Sorry about that, I forgot all about the SPDX tags in scripts and docs 
>> - yes, please add that SPDX on uuid.sh. The vmapple.rst is Alex's 
>> creation (I think I tweaked a few lines max) - but if that's the usual 
>> license we use for documentation as well then it seems a reasonable 
>> assumption to use GPL2+ there too if we don't hear from him.
> 
> TBH IDK and IANAL :) "GPL-2.0-or-later" is about *program*, is it
> relevant for documentation? This is the single license used with SPDX
> in docs/:
> 
> $ git grep SPDX docs
> docs/system/devices/igb.rst:1:.. SPDX-License-Identifier: GPL-2.0-or-later
> docs/system/devices/virtio-gpu.rst:2:   SPDX-License-Identifier: 
> GPL-2.0-or-later
> 
> Note we also use the FreeBSD-DOC in bitmaps.rst (not as SPDX tag):
> 
> docs/interop/bitmaps.rst:5:   This file is licensed via The FreeBSD 
> Documentation License, the full
> 
> Per commit 2b96c1a4931 ("scripts: validate SPDX license choices"):
> 
> +    my $prefer = "GPL-2.0-or-later";
> +    my @valid = qw(
> +       GPL-2.0-only
> +       LGPL-2.1-only
> +       LGPL-2.1-or-later
> +       BSD-2-Clause
> +       BSD-3-Clause
> +       MIT
> +       );
> 
> GPL: "program"
> LGPL: "library"
> BSD/MIT: "software"
> 
> In doubt I'll stick with $prefer except if someone has a better clue /
> suggestion.

FTR I'm going to send a PR including this series with the previously
$prefer = "GPL-2.0-or-later" snippets squashed.

Regards,

Phil.

