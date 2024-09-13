Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6697FFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6Uy-0005a6-QH; Fri, 13 Sep 2024 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=56UY=QL=kaod.org=clg@ozlabs.org>)
 id 1sp6Ux-0005Yg-7s; Fri, 13 Sep 2024 09:38:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=56UY=QL=kaod.org=clg@ozlabs.org>)
 id 1sp6Uu-0005SH-M6; Fri, 13 Sep 2024 09:38:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X4wNl1zMFz4xQN;
 Fri, 13 Sep 2024 23:37:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4wNg5bhxz4wcL;
 Fri, 13 Sep 2024 23:37:55 +1000 (AEST)
Message-ID: <2f888d59-b2ee-4fe8-9193-728f322fa132@kaod.org>
Date: Fri, 13 Sep 2024 15:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: Chalapathi V <chalapathi.v@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20240807202804.56038-1-philmd@linaro.org>
 <d30b16a2-a45a-4596-bef8-2eac898a00e9@kaod.org>
 <d93476aa-d777-419b-90a2-b50bb2d861ff@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d93476aa-d777-419b-90a2-b50bb2d861ff@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=56UY=QL=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 9/13/24 15:24, Chalapathi V wrote:
> 
> On 12-09-2024 22:25, Cédric Le Goater wrote:
>> Chalapthi,
>>
>> On 8/7/24 22:28, Philippe Mathieu-Daudé wrote:
>>> v2:
>>> - Cover PowerNV SSI in MAINTAINERS
>>> - Use GLib API in pnv_spi_xfer_buffer_free()
>>> - Simplify returning early
>>>
>>> Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
>>
>> I was wondering where we were on this series. I see there were comments
>> on the initial one that would need some response at least. Do you have
>> plans for a respin ?
>>
>> Thanks,
>>
>> C.
>>
> Hello Cedric,
> 
> Thank You so much for reminding me. I apologize for not getting back on this sooner. 

That's fine. We have some spare time before the QEMU 9.2 cycle
closes. I'd say ~2 months. Still, it would be good to address
these issues before adding more models (Dan's TPM device model)
relying on it.

> I am working on the review comments from initial v1 patchset and send the v2 patchset ASAP.

That would be a v3 ? Since Philippe sent a v2.

Thanks,

C.


