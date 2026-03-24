Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AAEE9A769
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zRO-0000Qv-6g; Tue, 24 Mar 2026 06:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w4zQu-0000Nw-IQ; Tue, 24 Mar 2026 06:56:24 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w4zQs-0001JE-KU; Tue, 24 Mar 2026 06:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774349779; x=1774954579; i=deller@gmx.de;
 bh=7KQnjGT4k5XM94bn/l0CbxeEbLXOfpjGWJwF0l4F6Rw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VOIDawF4uGuVWwuR/iEKapyXIMCyJtyZVwBxeShOKm4MDUhuehnFmTnopeTIquXZ
 Nt5FLzwTGQOVGGMwbFPWA/MatfeCyJ3nNyckanI/DefH38yside9GDbDwekKHTV+N
 UuB0buHqe1k6wPXnSzU7fA8W/CcWF1RjFLNQCCbrwZoBQbMCs8Ny5vHftYdkK4yHL
 TVdWGUy/iYVZfFuyPHnyu5RyTonusW/aypGy1HIw0ptydNgWrmjQUFKJh55ErNmpI
 urg/4KXdTIf0HD0MQWJCPPEGPUpWrxyNu4toAXgjHAWB9rdLpZCoimiFTfy2EMBwP
 +lBvU4r59gPKoAYo4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1w8YCk0pcD-00CW3D; Tue, 24
 Mar 2026 11:56:19 +0100
Message-ID: <57aa74f6-f28c-450a-a19d-15dc8403ef83@gmx.de>
Date: Tue, 24 Mar 2026 11:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user for v11 patches
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260313183009.34221-1-deller@kernel.org>
 <66022765-b7b8-4f46-a90a-43dc473a16fd@tls.msk.ru>
 <0864102b-f32d-41a1-b19a-7eb9b237b368@gmx.de>
 <389cce41-5aad-4703-82bc-dfb9a8f7e774@tls.msk.ru>
 <b20eb2a7-1386-477e-b3f7-e5ddffdd62ca@linaro.org>
 <ff2edb88-fab7-43e9-b3f5-5cfcddb09cc0@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <ff2edb88-fab7-43e9-b3f5-5cfcddb09cc0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jeNlSWdd/Sz/goG6AAY0wU/9Yrrjih55Wr0PVRYJICkS6YWzArY
 Az/XrE711RYD4brI4BysNMPn/3HlmrIuKFp2o8eZs1HMGIdpTBjG10RXZmiP+PqldD+3CB/
 mcWgafh7+3QrYxEWtAU4RwrwP/Po8RG+wWIbKDxZo+8guRvG8nNjJhKeiyIWLwwPOCSBidj
 vkXGlSUjHD4gGF06LaDfg==
UI-OutboundReport: notjunk:1;M01:P0:2q8rWTsgBrU=;gFmHZfYeP8wV6M0NnDBI0gWy4HD
 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
 gVou8YwdjFe
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Am 24.03.26 um 07:19 schrieb Michael Tokarev:
> On 24.03.2026 01:53, Richard Henderson wrote:
>> On 3/23/26 17:52, Michael Tokarev wrote:
>>> On 16.03.2026 20:00, Helge Deller wrote:
>>>> On 3/16/26 14:43, Michael Tokarev wrote:
>>>>> On 13.03.2026 21:30, Helge Deller wrote:
>>>>>
>>>>>> Razvan Ghiorghe (2):
>>>>>> =C2=A0=C2=A0 linux-user: Fix zero_bss for RX PT_LOAD segments
>>>>>> =C2=A0=C2=A0 linux-user: fix mremap with old_size=3D0 for shared ma=
ppings
>>>>>
>>>>> This looks like qemu-stable material, is it not?
>>>>
>>>> Yes.
>>>
>>> ..with one caveat: mremap with old_size=3D0 fix doesn't apply to 10.0,
>>> the current LTS stable series, because 10.0.x doesn't have f55fc1c092
>>> "accel/tcg: Add clear_flags argument to page_set_flags", because of=20
>>> this:
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_set_flags(new_addr, n=
ew_addr + new_size - 1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prot | PAG=
E_VALID, PAGE_VALID);
>>>
>>> What would be the correct construct for this for 10.0.x?
>>> (Adding rth to Cc list).
>>
>> Probably
>>
>> =C2=A0=C2=A0 page_set_flags(new_addr, new_addr + new_size - 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prot | PAGE_VALID | PAGE_RESET);
>>
>
> Well, at least the testcase works with this version.=C2=A0 Thank you!
>
> BTW, do we have another testcase for this scenario somewhere,
> like in LTP or something?=C2=A0 Looking at linux test project I don't
> see this case covered.

At least there is a reproducer here:

https://gitlab.com/qemu-project/qemu/-/work_items/3105

Helge


