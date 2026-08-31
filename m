Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792A0C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11dN-0005Zl-SZ; Mon, 31 Aug 2026 09:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x11dM-0005Ys-12; Mon, 31 Aug 2026 09:01:08 -0400
Received: from smtpout5.mo539.mail-out.ovh.net ([51.210.91.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x11dI-0002BQ-7v; Mon, 31 Aug 2026 09:01:07 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hYTd43lXKz428X;
 Mon, 31 Aug 2026 13:00:56 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon, 31 Aug 2026 13:00:56 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.243])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYTd426F1z1xsy; Mon, 31 Aug 2026 13:00:56 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id ED2CB941BCC; 
 Mon, 31 Aug 2026 13:00:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008689ab45d-17b5-4124-a589-21b08d6e8a25,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a7c8c510-3391-4ab8-ab5a-c5432c9fb216@kaod.org>
Date: Mon, 31 Aug 2026 15:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: Alistair <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: Portia Stephens <stephensportia@gmail.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 qemu-ppc@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
 <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
 <CAFEAcA9zz60hTDMEMePnc1osis7dPjn5KmSksrWKATpSMc8SHw@mail.gmail.com>
 <3796c9917796a0fe26f2462645d95cc7039539af.camel@alistair23.me>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <3796c9917796a0fe26f2462645d95cc7039539af.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 8865335866800909394
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGS3r+lsiA/YlnvMvOS3yGpYL4IrjkxOWD4bDn9RWOXRs73D8wQ/JA/P8IdBsobKaM+9AKGsC3qMIyl4GKXmguDqj0gWUoAVYHHMokeg/RvDPUmLoPptNG0/HPIAodmSTQ/M4eg8R3z1hWUQTNz1Ng4C0mMxcV/3g44nt48KKFSwagGx1XxTuS+e/tg1dxMLf5hit0K5ad++BxUVNx4VLIW1H6FskOa1ySxk88tiOHvqB5/46rBdieqvY8+HgKawcuwwmZoa7/42iquBRkduvhSBvclaXu8X9MJUWQAJcOEiOiLeZWgYXuFB57IP1umRqR3txqtfvVZ2z7GOcoxdOPDqFT730UIOFbW/H47w1kkrsgDH/eFcw7rMV214wtvFXtVVhOam1PPdv4q0lIUJX3k2mtU797dLXqrvAZjuyjKpMXQsQRLyqJsdC5DCIKvvs1q55hftuNM23WbKmkK/tIRPxiNXa29ONCWPmUlaTIKpGBDGbw6MkOrDsrEmZ/QEtL7YLqakZW9hmkfzdMF3eVPmYBWxetkYPlSI2G17hz/LU5SDOMOY4agSdhhkSjIQ+WypLRry4eYGGiTiMzTT7CPDlf5FKisz8hER/WwGHj75+dRIbZa8WdPEWfx+MrK2oM3mSuB3gFnzHKKZaBvrMKhVlQcrgUcOVDP0ra36g3Esg
DKIM-Signature: a=rsa-sha256; bh=76mlXlI+68XKHVmuDCztsWSFKW2UJBoy8RhtgC9UAfg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788181259; v=1;
 b=ABBjKuCOanisMEbETgFe4EII2vgxg1d+cpY1MejMlXJhgKOlVot3cXCzBcfM/BzXvX6ZkRdO
 H2ZcJsKkMRWJv79oL+V11ZvI75wZk6N6XHJI88YVOO4Rpbk4yH36y5UlBgY8375nSolgOFP1Ekb
 JzYlW8d/rnYIhGEM9krxbswX5uyhZAOymjJsdI7shfNGdyzwVjsTbqtRWPBOrHWO9C2WHFqjHbt
 zfT4RJIOZC/3KXVrXaEBVFO1E7BaNVHjPe93WPeKW6dRWgFzOLRFVhQ9y1D6uDybzszWPHzRJyp
 6Q2rPqw8KelucW0FU66b+TRGNR/uEiW2XRDwaweFm5ovA==
Received-SPF: pass client-ip=51.210.91.44; envelope-from=clg@kaod.org;
 helo=smtpout5.mo539.mail-out.ovh.net
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

On 8/28/26 02:07, Alistair wrote:
> On Thu, 2026-08-27 at 12:17 +0100, Peter Maydell wrote:
>> On Thu, 27 Aug 2026 at 12:03, Alistair <alistair@alistair23.me>
>> wrote:
>>>
>>> On Thu, 2026-08-27 at 11:53 +0100, Peter Maydell wrote:
>>>> But isn't this just the way the SSI specification is? If we're
>>>> modelling a "you just have to get this right in software" bit
>>>> of hardware then we don't need to somehow try to add extra
>>>> checks in QEMU for whether the software hasn't actually done
>>>> things right.
>>>
>>>  From my reading of things this is a bug in QEMU, not a guest issue.
>>>
>>> The fact that aspeed_smc_flash_setup() for example iterates over a
>>> larger value to send a single byte at a time shows that currently
>>> everyone *thinks* think function should send a single byte.
>>
>> Doesn't that just show that the aspeed flash controller knows
>> it is always talking to an 8-bit SSI device ? It wouldn't
> 
> But I don't think that's guaranteed to be true.
> 
> On real hardware the software could know that it's only ever connected
> to an 8-bit SSI device, and set the driver accordingly. That seems
> entirely possible.
> 
> But the hardware seems to support larger sizes reading [1].
> 
> In this case the QEMU code is the hardware, and I don't see how we know
> we are only ever accessing an 8-bit device.
> 
> 1:
> https://patchew.org/linux/20220304083643.1079142-1-clg@kaod.org/20220304083643.1079142-5-clg@kaod.org/

On the Aspeed SoC, MMIO accesses (1, 2, 4 bytes) to the SPI controller
are converted by the hardware into SPI bus transfers. The exact
serialization is hardware-specific. QEMU's choice is to generate
byte-oriented SPI transfers.

In any case, SPI is generally byte-oriented, with bits shifted over
1/2/4/8 I/O lines. So byte transfer is sufficient.

C.

> 
>> surprise me if the SPI-NOR standard in particular insisted on
>> 8-bit transfers, though I can't find anything claiming to be
>> that standard.
>>
>>> So it does seem broken today. Making the current function clear
>>> seems
>>> like a good step. Supporting different or larger transfers in the
>>> future is then possible.
>>
>> I think the current interface already supports different or
>> larger transfers. We just happen to not be using that.
> 
> Kind of. It does support larger transfers, but there is no size
> argument. So how can the SSI device know how much was sent? Everything
> seems to just assume a single byte, but it has no way to actually know
> that.
> 
> Alistair
> 
>>
>> -- PMM


