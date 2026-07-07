Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD22FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3Ew-0004TR-Ar; Tue, 07 Jul 2026 06:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh3Ev-0004T8-II
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:41:21 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh3Et-0003rM-SL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:41:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c029505b389so73215866b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783420878; x=1784025678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tvOJFMQbr0WF0C5g9i+mdq40kbvleSRKXRNdDEzP2U=;
 b=Qb7ETC6kLEy571Idlfg8mDBud+X7FErltgYBemWfWPk3itKU6PBK/ZVy2mcC8UmXfs
 uZBgos/GvdPUERlUh9Av97KG+L2FKTDIn9lQedjfjd4FsA0LYkoSO6uM74MmYPbgfSAM
 H4XA7G5DFW/c/VgzlpRYvNK83XuWGh927hPafMHWiaDFVbK2zRa35w4dchbivpaAf3M6
 uLwdUxf8DepyCNUo7Nei6VPS/uthgU5q7neI3d5tI1LBIGIDBNe9bD2pWQpnhAmn+drX
 AxF9Yx9OuXvZWfgL3OudAixQiFFaOrWMHRKkp7jMVhAL7d72D17Yc5yCmFLTgYUS/gRP
 mGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783420878; x=1784025678;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+tvOJFMQbr0WF0C5g9i+mdq40kbvleSRKXRNdDEzP2U=;
 b=BqTzq44LOTwFVTThJ5ZsxaHnL2qVhP31IKOaHRoURWjMIyDKaA68rcxTuTMZoZP5o6
 kFo5mR0T/UC35+1o17mflciX4Sjnvtt/8JmEvtKJ8J0rBjEd78p+FzJE2xRRTPS3uS2P
 92YnSJcUPWkoQquMcozArQjkZaHnuel5WaidEZvdVX19Xvg/EGzvr6LQhtbpZasrAmED
 IMv9arA+X9K5m4vpp6psVVOIMhM3sE483WdQX680gTUVQYhlzD8HQRpDiBLP3viJd9zP
 NKSux9YbvxAtXHP2L5Ev1MYWZWV5XpzC0M0rbSa2jhEP1EhLtEDe0wjzbIDiusYqSypL
 Pdmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RouXoUix88IS37Gg6KqbBI4EnkIU7/GjXNi7fapKrG8AAKmJVYxmRC/4BsqitDO0PVu+8P28uGsogjs@nongnu.org
X-Gm-Message-State: AOJu0YxRiOYySIwgh3B6dazGWrMX30aN947+0WZJLqbLsJeAgl6LhE7O
 T8lJCXj2Lkx08/W/MulUQSdp2T40lAYu54ByzMgMeOFE440u2BPmI8DN
X-Gm-Gg: AfdE7cn6xLksfvr1gUR/c2Rb3oq1q3y1YiHplx6ky0uTjAE1BSQRPZWLK/SuVRpA68r
 cjcbYPNrqzUhAlvAYPXc/GfKWZ8XlymIEAPRIfTONq5qEzvtb9sD5jQizUbf+3SWoebBtIvUPmM
 wg4BVVobEYvsNrVDEOiRuShSq5Oz4zQa2DstNAUAGwEvkC37BXK3/zAZSCixpZ1UXb+pfriQXj2
 +AI9lEuO7JbvuqOASA2XeQp8yZCc/DC6Et6vatU3CsnIOCR5U7WtwKU7kTrjoO4UjlVbr8l6iPT
 Zgc2Zg6WMBvtPf81ewRW3zcm6kVwmO5KRBHhLPxgbPZKluZYFHw9KzfRc3LRue8GIcDTFQgTQwF
 BHkUMP0r4sbM5K2fUjimPGjTm1MfGYhJDLQzGSSk5st8tUzFzGz5mcp2oz6GCoaVC2Hr0fvnf4D
 14yai/Y6x9iAIR16qtrw==
X-Received: by 2002:a17:906:fe02:b0:c12:5dca:864a with SMTP id
 a640c23a62f3a-c15ae988144mr137835966b.5.1783420877823; 
 Tue, 07 Jul 2026 03:41:17 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bca17sm106985066b.32.2026.07.07.03.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 03:41:17 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:41:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
In-Reply-To: <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
References: <20260702184038.178196-1-shentey@gmail.com>
 <519f6e43-5273-4426-b673-71cff44daffa@oss.qualcomm.com>
Message-ID: <CEDCEA0C-26CF-402D-925C-3718644F9171@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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



Am 6=2E Juli 2026 13:25:51 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@oss=2Equalcomm=2Ecom>:
>On 2/7/26 20:40, Bernhard Beschow wrote:
>> Now that FlexCAN emulation has landed in master, let's add it to imx8mp=
-evk as
>> well=2E While the real i=2EMX8M Plus supports CAN FD which isn't emulat=
ed yet, the
>> non-FD mode works well under Linux: It is possible to use `cangen` and =
`candump`
>> either way on the host and on the guest, as described in
>> docs/system/devices/can=2Erst=2E
>>=20
>> This series consists of five patches where the first four are preparati=
ons=2E
>> The last patch integrates FlexCAN into the i=2EMX8M Plus SoC and EVK bo=
ard=2E The
>> first preparation addresses the review comment from [1], and could be a=
pplied
>> independently=2E
>>=20
>> It would be nice if this series could make it into 11=2E1=2E
>>=20
>> Testing done:
>> * Start imx8mp-evk and run `cangen can0` there=2E Observe on the host t=
hat
>> `candump vcan0` prints the traffic=2E
>> * `make check`
>>=20
>> v2:
>> Thanks for the very helpful and super quick review, Phil! Here we go:
>> * Add patch "hw/net/can/flexcan: Wire clock control module via link pro=
perty"
>> * Have separate MemoryRegionOps for 32 and 64 bit
>>=20
>> [1] https://lore=2Ekernel=2Eorg/qemu-devel/77d5891c-de12-467e-8746-02fe=
43121e3e@oss=2Equalcomm=2Ecom/
>> ---
>> base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
>>=20
>> Bernhard Beschow (5):
>>    hw/net/can/flexcan: Wire clock control module via link property
>>    hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>>    hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>>    hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>>    hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk
>
>Peter, you just sent your (IIUC) last target-arm PR=2E I'm about
>to post my hw-misc one, do you mind if you take this series which
>is fully reviewed/tested?

Thanks a lot Phil for your R-b's!

Any chance we can still get this series mergend for the upcoming release?

Thanks,
Bernhard


