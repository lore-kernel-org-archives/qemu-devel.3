Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3ACC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3Wv-0000jE-DX; Tue, 07 Jul 2026 06:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh3Wt-0000iX-8y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:59:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh3Wr-00075i-9j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:59:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso36834535e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783421992; x=1784026792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ppw2tC4bwbMwGZqKVSQhlyH0n0RuWFwIRAnfv3sWAxo=;
 b=E+BT9GVA+QkDi+0xg826LEt40xMdUr4WW2ZAbuFP84MleXW6gAnXTX/yNc6xR4IY+m
 JNIQ3d3bCdJnMQpYuREP5pn2KgnWP8SU9fS+BUJ7K6tsBCp23CSC53QeZ6p91U/3OIa8
 ELBwTv0ZAyqpGWUnsbM/ehJ3phQjybXxomAHMEeDvkJS4d81iu/6QPdyD5LWZMKQTK30
 rf+hOI6e29CoQGx/aj3QC8WSKI4jqzsJZB/u1sQxx5eMaP1khoAwsU3maosYAPGErAli
 1m26gRorxbP7kqGnvnuXW06kq6L+0cNomJCAMDSFhLEQI5vH3hotx0sH5Xn+jWl818hm
 X/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783421992; x=1784026792;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ppw2tC4bwbMwGZqKVSQhlyH0n0RuWFwIRAnfv3sWAxo=;
 b=fWtk2gCnSqsvUgBMDVayXaoCW1uSvr4wymCksLgDPl0QyNOY4S1vgQwK9sjzJzxPxs
 nKeZccl6f+EV1sC6la7I4rPoagOx8zzAL9rJjTtwoZxrG1sFKVFSBHA5xcVN0jOJDNFX
 hAWf3xqIE/mW23b3dotiB3x3drBxkprGIa8RfEDENAIOwwJqd6QGYrrcjn312xx5VslZ
 mPaHT2MMvtmukhHyypVXv+zz4IL+XD1JuEOsQP0yi4yGA5bM1AHlY/lDXoalFcVmKl9Z
 AJVk4jKpICpw8zi8wD8NdYei2wWiKRI61FfJXeJdVerNlIyhF+S511Rgj7vLUcg5/FzI
 fGBA==
X-Gm-Message-State: AOJu0YzLCdmcZ/LvFLcAk9aJ4NknVpW9sSiCQyGMnLpdwV4mF0JrYqLS
 SzbU7ikkwLjooPe501/hC3Rgj11jGPi4+KC0+mOCxAovB/BLz2RHtXdC
X-Gm-Gg: AfdE7cnBidvJg40XrFp21+IndXX4t5doWvDo4qW6LcL4an12ldcrD1ntkP/DpDPOKEf
 f8tGpsBZNINtn5c9wUeo3V+Pq/hj6iZOOMFWxX/8B7sZkhX8yn55pHFDas5zVypHHn9gotqIFd2
 oc4VJtidfVFiGyzrRy7LIBh9ahxN2AX8KSpbxdzurNdReUPJM8asIIOYCWAnnxcKzh8IZwkk1t4
 gAF06g09V4lXDN7cJNnII3Eoo9EUHTt1aVzW1puSwbM0f+XFlChJpTMpD0EEWJgp9VlrP+gGquI
 Hr9Vnpg4kK/GI1FJW8VOu+6T/j58eZ4cLPd6AqxQzlbIMNMKJWAWIu6rgG6+tetBYpvreHcECWp
 /7U3KJvaH5GPw/XdWd2wDCtkx3MaNPwm6PeerV9Xt9FFBZd6YBhWkS+XEHjAl88z0R/n/jcUkht
 YzszUAQTwFKpYGjeiM2c0=
X-Received: by 2002:a05:600c:638e:b0:493:dfc8:77d6 with SMTP id
 5b1f17b1804b1-493e3adbb04mr9935855e9.12.1783421991595; 
 Tue, 07 Jul 2026 03:59:51 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm33754645f8f.13.2026.07.07.03.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 03:59:51 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:48:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
In-Reply-To: <202607061344.14505.pisa@fel.cvut.cz>
References: <20260702184038.178196-1-shentey@gmail.com>
 <202607061344.14505.pisa@fel.cvut.cz>
Message-ID: <341AB560-68B9-4965-917E-27E00E3A63DB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 6=2E Juli 2026 11:44:14 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2Ecz>:
>Dear Bernhard,
>
>On Thursday 02 of July 2026 20:40:33 Bernhard Beschow wrote:
>> Now that FlexCAN emulation has landed in master, let's add it to imx8mp=
-evk
>> as well=2E While the real i=2EMX8M Plus supports CAN FD which isn't emu=
lated
>> yet, the non-FD mode works well under Linux: It is possible to use `can=
gen`
>> and `candump` either way on the host and on the guest, as described in
>> docs/system/devices/can=2Erst=2E
>>
>> This series consists of five patches where the first four are preparati=
ons=2E
>> The last patch integrates FlexCAN into the i=2EMX8M Plus SoC and EVK bo=
ard=2E
>> The first preparation addresses the review comment from [1], and could =
be
>> applied independently=2E
>>
>> It would be nice if this series could make it into 11=2E1=2E
>>
>> Testing done:
>> * Start imx8mp-evk and run `cangen can0` there=2E Observe on the host t=
hat
>> `candump vcan0` prints the traffic=2E
>> * `make check`
>>
>> v2:
>> Thanks for the very helpful and super quick review, Phil! Here we go:
>> * Add patch "hw/net/can/flexcan: Wire clock control module via link
>> property" * Have separate MemoryRegionOps for 32 and 64 bit
>>
>> [1]
>> https://lore=2Ekernel=2Eorg/qemu-devel/77d5891c-de12-467e-8746-02fe4312=
1e3e@oss
>>=2Equalcomm=2Ecom/ ---
>> base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
>>
>> Bernhard Beschow (5):
>>   hw/net/can/flexcan: Wire clock control module via link property
>>   hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>>   hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>>   hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>>   hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk
>>
>>  docs/system/arm/imx8m=2Erst   |  1 +
>>  include/hw/arm/fsl-imx8mp=2Eh |  8 ++++
>>  include/hw/net/flexcan=2Eh    |  4 +-
>>  hw/arm/fsl-imx6=2Ec           |  5 ++-
>>  hw/arm/fsl-imx8mp=2Ec         | 38 ++++++++++++++++
>>  hw/arm/imx8mp-evk=2Ec         | 64 ++++++++++++++++++++++-----
>>  hw/misc/imx8mp_ccm=2Ec        |  3 ++
>>  hw/net/can/flexcan=2Ec        | 88 ++++++++++++++++++++++++++++++-----=
--
>>  hw/arm/Kconfig              |  1 +
>>  9 files changed, 182 insertions(+), 30 deletions(-)
>
>Thanks for the work=2E I have tested the series on the top
>of your imx8mp-flexcan branch, commit
>
>  3b7289419cac5b712faeadf6b4a6203579d08f76
>
>with our test setup for iMX6
>
>  qemu-system-arm -m 1G -M sabrelite -smp 4 =2E=2E=2E
>
>and it worked as intended=2E I have looked at all patches
>from your series and I do not see anything problematic=2E
>
>You can add my confirmation to the series and or individual
>patches
>
>Acked-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>
>Tested-by: Pavel Pisa <pisa@fel=2Ecvut=2Ecz>

Thanks!

>
>By the way, I have noticed your iMX53 branch=2E

I haven't decided yet whether to upstream it because I wonder if anyone wo=
uld be interested in this rather old but (IIUC) longterm SoC=2E For some re=
ason I get file system corruption there which should be resolved before ups=
treaming can be considered=2E

Best regards,
Bernhard

> We have some
>old kits for this because we used it for yet another generation
>of medical infusion system prototypes/instruments fully
>functional demonstrators but before final HW design with
>safety=2E
>
>The fully realized and produced systems with iMX1 there
>https://www=2Epikron=2Ecom/pages/devel/medinst=2Ehtml
>
>Functional demonstrators with iMX53 there
>https://onimed=2Ecz/wp-content/uploads/2021/02/medicina=2Epng
>
>Best wishes,
>
>                Pavel
>
>                Pavel Pisa
>    phone:      +420 603531357
>    e-mail:     pisa@cmp=2Efelk=2Ecvut=2Ecz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://control=2Efel=2Ecvut=2Ecz/
>    personal:   http://cmp=2Efelk=2Ecvut=2Ecz/~pisa
>    social:     https://social=2Ekernel=2Eorg/ppisa
>    projects:   https://www=2Eopenhub=2Enet/accounts/ppisa
>    CAN related:http://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>    RISC-V education: https://comparch=2Eedu=2Ecvut=2Ecz/
>    Open Technologies Research Education and Exchange Services
>    https://gitlab=2Efel=2Ecvut=2Ecz/otrees/org/-/wikis/home

