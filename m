Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F22C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 20:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWMmW-00023X-HI; Sat, 03 Feb 2024 15:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu-devel@gudrian.org>)
 id 1rWMmS-00022q-L9
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:38:28 -0500
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu-devel@gudrian.org>)
 id 1rWMmK-0007gt-Vy
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 15:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gudrian.org;
 s=s1-ionos; t=1706992698; x=1707597498; i=qemu-devel@gudrian.org;
 bh=8LSXYvnqySj4jmZlLLG0R9Nqpz+3Wtc3ZnMRakM9pSM=;
 h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
 b=ScPAqL/NG67mFUm0zAVodhMG1G9s52mpDdeYZ7cc13iprGC9Xt3Kslt9g8uoLI3H
 eRUIijiPjGf4Ao/E5myAullukgBVqm1e+RAQdE12kQUsHsBOhfxK1ScBpDQm5kBlf
 Sd+01x0Gqa5kQ6JuXu4cqUIoAescEc5rbL3ij/qbFrL1bTsqaj6+cNGi2Zch2zF8+
 3QpJvP2GliaWXK2qaQLnBgikapsP3shA9H9Vok+uWtEZg9ooBwu9gyU2LmDZQXAgq
 4T25RYmpPFXawS0Bj5uB3fS8c7Mxi0BW8lxiPZwun3UOb/OA3v4Jy191UoJPSRVmM
 z6lWNrkBKX8fGy+hsA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.208] ([92.200.167.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5G1T-1r52Nz0sOz-0119Ud for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024
 21:38:18 +0100
Message-ID: <9021fa4c-1663-eae4-73b2-9e1c95522d2d@gudrian.org>
Date: Sat, 3 Feb 2024 21:38:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Christian Gudrian <qemu-devel@gudrian.org>
Subject: Re: ehci: more than 16 ITDs
To: qemu-devel@nongnu.org
References: <441d024e-9d3f-b410-2e3c-3323af841b8e@gudrian.org>
 <2cc91c6e-7c1a-f7cd-2b7d-69136c98d832@eik.bme.hu>
In-Reply-To: <2cc91c6e-7c1a-f7cd-2b7d-69136c98d832@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chnzYk3XaK7z8pVSEqQL+CuZZGulhlv5Ul5nMjhy0HnoPqJUQUU
 SNzU02MYTrPGfltG8NxI993jPiBAPD6/7QXhZE9Gnx1vD6FUNjzFgrdZXy7PBFyG58HkOvK
 GaVuK7LP6lnToxCsfItjOX4WcHURXTtkTCsyFwzykNjao0Cr2QE4hZNb6BOBk0DuazyFSbV
 xpWwPfet6Fx+zZK0J7q0w==
UI-OutboundReport: notjunk:1;M01:P0:nC2IAMRmODw=;KFbooTggbAiTVNlyik8fYRUp+/b
 6IXSRdODiBt6sy1zc1IbQKVuZ+6heyY7VuaWwfiom+2tGQWNqyYfwUfsGoJ+ErP3r9jmdU03W
 pGrtLVjrwiVk55zob/9u+CZGqH2f46eu/feF+Rcqw1lXdnMwaxhy4NqI36vqAfDQK2iXzo+2/
 o3DPRwKZquzVnUleHhl3sJ8W5WygsKKVUA6wg0xE48o57eMSxCrraSqeQW0n4UIZVYFaUu+NJ
 aY76kBdpfA1IlkykL+PUqn0k0agd0sYDoHN7bDMIP2GX6NR35UyQ0j7UJ0u6Oc1cS4/kNFDNJ
 qQTE+HSNgu7YyQchbUvLv0G2eiuUv8yCY0AAyUn4IpiqZc60srv9r7fjh4t0J9Qs+6IBYzlBw
 Vz+SgqAugfS/PC8y9DXVQrF4UCUrK6QGk+SMUP0G0rYqe6jit7grPSCoU9Ls+CRUb9vwrNCrO
 Dh3H6B75Ew/DXIzLuVRe1RjStLjMJH2JodDn420DdrLs59M+KS+cifZq9SWlfnXs/Gm+D1AMv
 ZLFF81GmCf+Qjip3J1EcP7Avw3Sx3Ho8Cw3CM4DX8JzOVYHps3vnjBkyQHoOSEj0TNEPyhZCf
 1LqEzamV8vrt4nW9e6/leOMXIktgH2/gofQuHdt2lv23TM/37/VcmzEMn4kjzVcIxaOJu2TSz
 qkLmH+1+lca9fWvWoxBRI7YPf7fqIzMgmNUrAk7EOZfBqQ2DMUF1+xbfcD8ctlGNNdegCpQZ2
 Jlw8/lrkwedcpGhpeV9m64lObf9FEymQUv+/A0FBEHBX+qUjVXJuhc=
Received-SPF: pass client-ip=212.227.17.24;
 envelope-from=qemu-devel@gudrian.org; helo=mout.kundenserver.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.509,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 03.02.2024 21:06, BALATON Zoltan wrote:

> It's hard to tell, I don't know EHCI but there's a TODO comment near
> that error so maybe there's some EHCI feature not emulated that you
> may need to implement in QEMU there. I guess you'd need to check the
> EHCI specification or the docs of the actual chip that is emulated
> for info on how this should work.

I'll have a look at it. Meanwhile I've added dedicated debug output and
found out, that the 17th ITD only occurs occasionally. Could it be the
16 ITD limit has been arbitrarily chosen? The host machine is not
particularly powerful so that buffers might fill up to a higher level
than usually expected.

> Also to get more debugging info to see what's happening you can add
> --trace enable=3D"usb*" (or see qemu/hw/usb/trace-events for the list
> of trace points available that could be enabled individually) in case
> you were not aware of that.

Thanks for the hint. I indeed didn't know that. The audio hardware,
however, is particularly time sensitive during initialization and
requires a power cycle if anything appears strange to it. But I'll have
a try!

The refcount warning is triggered by inconsistent data structures in the
EHCI driver of the Linux kernel: while the 'periodic' array encodes a
structure type of 'ehci_qh' the pointer in the 'pshadow' array actually
points to a structure of type 'ehci_itd'. My hunch is I'm running into a
kernel race condition due to massively skewed timing conditions compared
with the original bare metal hardware (where the kernel runs just fine).

Christian

