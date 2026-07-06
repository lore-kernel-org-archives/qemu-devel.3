Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09704C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgete-0002i7-JG; Mon, 06 Jul 2026 04:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wgesg-0002YK-VN
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:40:49 -0400
Received: from smtpout3.mo540.mail-out.ovh.net ([51.210.91.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wgesc-00039p-Gm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:40:45 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gtyVV1dscz4Q97;
 Mon,  6 Jul 2026 08:40:34 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  6 Jul 2026 08:40:34 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.125])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gtyVV01Njz7tLP; Mon,  6 Jul 2026 08:40:34 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 2867A941946; 
 Mon,  6 Jul 2026 08:40:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0079792e7d7-ffdf-442d-90a1-08781c22f518,
 85E5B3372E37D114A8148E0C2423338A4BE4238A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0830c96b-9fde-4b0c-89ff-f6c0bed60725@kaod.org>
Date: Mon, 6 Jul 2026 10:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte
 handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <bb4b7240-ea2c-4738-80e1-83e259f3ef4b@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <bb4b7240-ea2c-4738-80e1-83e259f3ef4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7638667919626972299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEQ+dPGPgId7szL2nG2ZqlIFkC95XUFd7limahSTuvhhpQrrYgzCJ3cDNjdNQBriXn4OoMzVl5i2Z0pk42xbW8z+0k04N9ro2QWJZAlDBmJHtzX1n1HiIOPcdfNXBtUz6FoDKMM80ZsF4IdR7MyE3GUPp0b+7e4/KF0dYee2mfTLV8m085AM42pgwC2mZfSBTBlO7RFGfoQtsLGRw4y6VlzwnnfT6zLfs009fZOZpdf7FgTsfm1MfYS3oKmLTXOMtL8+Qv5dUcTinrRdUMLauLfTio71miKuAtI9vkpW3ZTO7baPUyYunmgbxscNc2NSlG1K6uVnSE6uhwySJpRAFGhfNhl7zMHxwC291Bl2TH5puzChksC+JLQ83d+Ru1gpySEsMiZVqYGNWrckx6hIuPx3/l/J4CG2qAbLPZ3noh596gsQTOt3/anaMSMt1ocnpBjfG3SoHLGRxfi40MykpT2lCyOQkfhbYW16JvNuV4qeqEzuwYgZk9LcnxMeaGZwLNDzlK4M2PnMSFK67DrH2hGkhmZNpihJfKfJ/6PHaJN+DB5fQzlZDXIxwc5YM2whyui3beEUJ+CjKLQnUBoLTIgtJ64VhOGQc50GNrYmw39bG7/9vZQxRgELcyjJzlRJXFdVGOYZzOY2ejEZWFOoYl0+PljdLLo56PGW4jTCTB48A
DKIM-Signature: a=rsa-sha256; bh=yp44Cy9h+Uno55W9GEpHgQYtMoGxLts1ydMSZPodMew=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783327237; v=1;
 b=fHqKuDkpr3gG0I5f5QAzv2C8OxRACN8KtQ1QemlLJFcXbMcRYWGti06Xnw+o1N/l01VPyfdw
 kHNfCPwKBNPGlb58DYDJLWO8adpZEQrkaDye8PjeiA34SstJGnC2yO77rKRtLCmIK3zc/RhnR3I
 HCPTQkk73DZtRV2C1Bv29hlSRMmnBDuDwejoKZDkS1sQGOvfHTv/iVtnpeyYMrP+MWjL6gPhkAa
 IJMzQG21ntHf1+32fc8GXgS0X4ShvIOK8r1sMgikNrXk9H0LF3NeFdxpXa6TF1vmD3PmlwMch+C
 cuobfqjYTIv9WwLGsHuF1tkpIHYVDTkcYvQyA+87T2t4A==
Received-SPF: pass client-ip=51.210.91.52; envelope-from=clg@kaod.org;
 helo=smtpout3.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/6/26 10:19, Philippe Mathieu-Daudé wrote:
> Hi Bin,
> 
> On 30/6/26 15:57, Bin Meng wrote:
>>
>> This series fixes dummy-cycle accounting for SPI NOR fast-read
>> operations across the m25p80 flash model and several SSI controller
>> models.
>>
>> The root problem is that the affected code paths mixed two different
>> units. Flash datasheets and controller registers often describe
>> fast-read dummy phases in clock cycles, while the SSI bus interface used
>> by these models transfers byte-sized words to the flash. As a result,
>> some paths treated cycle counts as byte counts directly, and other paths
>> compensated in controller-specific ways that duplicated flash command
>> semantics.
> 
> 
>> The final patch documents the intended ownership boundary: flash models
>> own command semantics and dummy-byte consumption, while controller
>> models own hardware-generated dummy phases and cycle-to-byte conversion.
> 
> I'd blame the API. I'd feel safer having the block/ layer use bit
> cycles, and a core layer converting bits to bytes when calling the
> SSI layer. Maybe too late to improve. The documentation you added
> is helpful, but I'm pretty sure we'll introduce more regressions.
> Anyway, thanks for your work :)
> 
>> Some background:
>>
>> While recently working on some device modeling, I hit this issue
>> again. I then realized that I had sent a fix series for it more than
>> five years ago, but it never made it upstream.
>>
>> This series picks up that old work, refreshes it against the current
>> tree, and fixes several issues in the SPI controller models. The original
>> series is available at [1]. I have tried to verify all the SPI controller
>> changes by booting real-world guest software to ensure the change does
>> not break anything.
>>
>> [1] https://lore.kernel.org/qemu-devel/20210114150902.11515-1-bmeng.cn@gmail.com/
> 
> (Could we add this as a functional test?)

Nearly all aspeed machines will test these changes when booting.

Thanks,

C.


