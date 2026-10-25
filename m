Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB8606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=ljIsytIq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL5ga-0006p0-EF; Sun, 25 Oct 2026 17:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xL5gS-0006nU-P6; Sun, 25 Oct 2026 17:23:16 -0400
Received: from smtpout2.mo539.mail-out.ovh.net ([51.210.91.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xL5gP-0008HD-3g; Sun, 25 Oct 2026 17:23:15 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4jCV910Sg8z3wdV;
 Sun, 25 Oct 2026 21:23:00 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 25 Oct 2026 21:23:00 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.250])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jCV902Vzgz1xr0; Sun, 25 Oct 2026 21:23:00 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5902B1B431CC;
 Sun, 25 Oct 2026 21:22:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001ea9e6625-fc4b-4119-929a-c0830c916de9,
 4C76A92CB54B5F14DE055BB9F691F411DA7D2562) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <6e2a1a51-81bf-4f0a-bc71-9f14337a0dd1@kaod.org>
Date: Sun, 25 Oct 2026 22:22:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
To: Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
References: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
 <CAFEAcA_hYV_MzAD771i8MyX5NJozq=AuvT_v370udEqqa59O7A@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAFEAcA_hYV_MzAD771i8MyX5NJozq=AuvT_v370udEqqa59O7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8301260016180177980
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGOQPOKcd0pVXeQ4wRn8gcOm+gcDXpgTYtfmGwe3uyOOw6Q40MdgNI5Rd90MjrYeZX9nvtH0CHkQAaWJLDklLjhDDRAHNBe100l5LiR11w7V1dxVbcyrDPQhWN+6pF9SVOwo8fEOwYZBlSUXjNM/51TZSscqMj1ThhI1hLcrvGeiqhDcZdAtmfL+uGEHcn+vjLkSmcq6FMRD+DJ0rQ793gw/Sr3CQS6HLJcaCWRAtXNCjjJ+0AuNOtnUdSdf/qQLoK6wVgH56O+OtNee5mI2UHfS5BMSW1+c3AEyfyVysDuTy9K8uXx1AaJS9TM/S7W1YvY0hfx8isN7j0h/82XWGLAn2s2O7s7IeNO+g7QBRMhiF9XQTcaGv3aiIEJ81J/GYpu8ukTc6Q2ubWhUJzNKiVFNbKZ4hoB9BDDVMnfocOJrEqH5D4+LQFAGSWjDblfanxChj0gA6dkB6M8dsyImn8ESYHXAdc8IgYGYgqmWJS9UKPkP1mhbIPw1NATDvz6j29a3nxeT8RTUl1u8d5dZ9DgeK5ZW6gCOHv8y01WZvHfXSSmI4K7Z459ElOfMjCXyrvN/idKbSBUB0KGjVYuNpXmO+vhGshDA3tkauXJzLGxq07BoFHfZ+IyW7qB3QJNjG8VJnSflnp/940yeLy4AAcL4y2xAsLTI2jofiqvsVCHdg
DKIM-Signature: a=rsa-sha256; bh=JR5Hr72kLZBa9EAG6RzgNSqsmLdzW9TomBqKHMXdLgE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1792963381; v=1;
 b=ljIsytIqvTYjzFxyLJAyOQj4nkpnZf7h5tMSc2d8if8oENWPB2OrTsxRbQTObUUWPyt/KOKg
 1LBQp8aEsk7/2hPKGanFacUWFm00Rm3PQsEJNpZqdsqMBKf22atbTmaUZnDegRbWI0BEyRYS3Ag
 J4kzpXmyNmBaVVMT+76t3lIWMP7j6i6GSGTk+hfcqWHgrPpYGcZ1eh0yLM6KeNPM0ldeFYCq/fk
 Joj5ABUX4FlTPpGGFH550i2N4OV0lJ/rSj89vmI9S71D1+0oHtcmfXGYrWoGLjTzrfyacR4IHMg
 KoN/BJgz5r4GaY4IAI0dXEgPjw26puI5pJSpZmMqr7DJA==
Received-SPF: pass client-ip=51.210.91.41; envelope-from=clg@kaod.org;
 helo=smtpout2.mo539.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 12:12, Peter Maydell wrote:
> On Tue, 20 Oct 2026 at 04:38, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>>
>> The ASPEED PCIe class may be registered for machines that do not
>> instantiate a PCIe root complex. Updating the global msi_nonbroken
>> flag from class_init() therefore affects unrelated machines.
>>
>> Defer the update to the per-device realize handler, so the flag
>> changes only when an ASPEED PCIe root complex is actually
>> instantiated.
>>
>> Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
>> Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge")
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   hw/pci-host/aspeed_pcie.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> As reminder for whoever picks this patch up, they should add
> Cc: qemu-stable@nongnu.org
> 
> Cédric, I assume you'll be taking this as an aspeed patch.
Yep,

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


