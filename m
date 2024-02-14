Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DEEC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raGie-0007ZN-2X; Wed, 14 Feb 2024 09:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1raGic-0007Ys-AC; Wed, 14 Feb 2024 09:58:38 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1raGia-0004GT-FH; Wed, 14 Feb 2024 09:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707922707; x=1708527507; i=deller@gmx.de;
 bh=eSczcXDzi2DaiObRf+OR5MUQEih8uG5m6wgqZB/xnLw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=qLW0Mbr0bCz6N7r1JlT2hPr+b7SdAYiefRc5DKEP6ffx8ZowdOxn8ZBnha1AQBU9
 WJrv6fFFrqGbj/Mhgqg4ZIaX0jQITqSLVB6HzEX011nj3qSSij0ZylfaqnSwZJLRM
 7d2quhrAbefagpt2OQ7xr4Q79Eqm1VRVdr0W0nQEKiYH3Ry4lPNgHJCcCNFBDRRC+
 JFnQ0+ok+rbKspn0gHOlbZ1ygB1PdqH+72MyBAVwsYsOz2ZbBYNEImk6EBS2MzxLr
 1VleygZg8H1RuZ6E2O+7djuBNTcMNmGNIsHrwL6Qa8QLG7+PTbakTp2e6KXNAL7lZ
 Z7lakU6FWhVAroapVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.158.68]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1reNBF3xkV-006Rn5; Wed, 14
 Feb 2024 15:58:27 +0100
Message-ID: <8a73da2a-9485-4f91-8c67-79a644fb1d07@gmx.de>
Date: Wed, 14 Feb 2024 15:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Hppa64 patches
To: Michael Tokarev <mjt@tls.msk.ru>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240212234723.222847-1-deller@kernel.org>
 <675576ad-ef02-4791-8ad5-08d8ab2b710a@tls.msk.ru>
 <b3be66b3-d032-4dec-ac47-0c2b41bd95cf@gmx.de>
 <ae1da63a-2bad-427a-84c5-ee1f37155ec5@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ae1da63a-2bad-427a-84c5-ee1f37155ec5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGIV5uMcrderfmxaC9KDlLw3uYLZKNpmB6jenJ8ifi+kQPRxU2I
 UvUjc6Zuwxu1NvOkvsId6DxV2GjLTGIMPwSZ1XvnfJjx5R3wnXLGuJGPv9V3IqMFUQOYV5C
 fuphVDZK1cF7G6GrDIWt/X8TjAuRrk2zeJ8aUPbki38nAGLotJ+KomMQlEusKckVt1meQYu
 TLVMvZUPU9RuDwWOlcjgQ==
UI-OutboundReport: notjunk:1;M01:P0:UCKc63i3Vnw=;b66PlcbMp5MRHAG1S/oU/wo+QPU
 ThMrAxrVh1il2pr761rWuH7VWJH5i9LzzdJwjMiDSS2UDcudiTcoDLeMYPHgmdUH+dxHiiKAp
 lBIpR6gLSbmMs9XzeYicxlTP//6vIOBizDBzMaFyoQwqt/zYbzM1GylwQQ6dmANE+0ojY4/PU
 8kDot0DcoOJa/iz0g5Y1g0c3khIJHhhmBq79lKQ0y429YJgbZL0fpjZqaiwigUPjugmvhOMCj
 3Haex1anmxkjBXg3HFih8EqsAbeYB1HFddcRs1ic4dWne/Vja8Q9WSEhEz3f7nS70b+r4xmRf
 AzwcRGkKC6MHjP51DOs4ExWNLfdvBfaMiwTbf/fY1jTD6KZeeGOYSx8NpgtditjhEfXITHhrf
 q2sItBp68MunFAOMn02r/rYVOGtFFL3uG/Vxp49c6Yo8Q7WkvbafEPyQiwRX4yL8R3w75WY5q
 /skPGbRzkyBXSrQca7LU7r9VDAllRCMSCa1tJnsyVK2/8evOyRUlY+UNmwiyLmFeUu/LAdhAr
 ESVN7bFIj/pfXZSICZijgmwSHoYq9aMxH7ipbgSUb2ppvG4+raG1QQfTEExiFQCxb/ayRVah+
 /SiDqk78v5tt74GAuB/0nmk37NddADLsIeDB0nH/DmICDyerUhHpYu+G+2iB9o2unh1yZ+qx1
 6abrWl/eXmWBMQdSZ81UNVkjKwzreLhLnnn0pITCkoVEVU0NzYkF25L7zBFFNqmWSii3AjgA3
 /yeW1mcBbmStr3je6xym0cY49XPW2LbnhpfZrVuKvghG5ZR8Vr0XAZ24AF3nljPavbGRfLmer
 H6oUDdHzAS+Nt7FgxLfdMDKNXch3iqKqO6Et26//vGghE=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/14/24 10:07, Michael Tokarev wrote:
> 13.02.2024 22:16, Helge Deller:
>> On 2/13/24 19:09, Michael Tokarev wrote:
>>> 13.02.2024 02:47, deller@kernel.org:
>
>>>> Helge Deller (11):
>>>> =C2=A0=C2=A0 disas/hppa: Add disassembly for qemu specific instructio=
ns
>>>> =C2=A0=C2=A0 target/hppa: Add "diag 0x101" for console output support
>>>> =C2=A0=C2=A0 hw/pci-host/astro: Avoid aborting on access failure
>>>> =C2=A0=C2=A0 hw/pci-host/astro: Implement Hard Fail and Soft Fail mod=
e
>>>> =C2=A0=C2=A0 lasi: allow access to LAN MAC address registers
>>>> =C2=A0=C2=A0 target/hppa: Implement do_transaction_failed handler for=
 I/O errors
>>>> =C2=A0=C2=A0 lasi: Add reset I/O ports for LASI audio and FDC
>>>> =C2=A0=C2=A0 target/hppa: Allow read-access to PSW with rsm 0,reg ins=
truction
>>>> =C2=A0=C2=A0 target/hppa: PDC_BTLB_INFO uses 32-bit ints
>>>> =C2=A0=C2=A0 target/hppa: Update SeaBIOS-hppa to version 16
>>>> =C2=A0=C2=A0 hw/hppa/machine: Load 64-bit firmware on 64-bit machines
>>>>
>>>> Sven Schnelle (1):
>>>> =C2=A0=C2=A0 hw/net/tulip: add chip status register values
>>>
>>> Is there anything in there which is relevant for -stable?
>>
>> Ideally all patches.
>> At minimum the tulip patch.
>
> Heh.
>
> Ideally there's no bugs and everyone knows everything ;)
> In reality though, you know this area *much* better than
> me, and I rely on your judgement here.
>
> Still the whole lot seems a bit too much here, while some fixes
> in seabios-hppa (so whole new release of it, maybe without the
> separate 64bit firmware variant) looks worth to have.
>
> It's a mix of features and bugfixes, and some features (like
> this tulip thing for example) actually *are* bugfixes :)

I suggest to just downport the tulip patch.
32-bit currently works in stable series as-is.

Most current fixes in SeaBIOS and hppa code are to fix & enable the 64-bit
Linux kernel & HP-UX. I don't think we want to completely back port those,
as they aren't yet fully functional either. So, this 64-bit is stuff which
should be limited to upcoming versions.

In case we want the newer SeaBIOS in stable, I suggest to additionally dow=
nport:
- target/hppa: Add "diag 0x101" for console output support
- target/hppa: Update SeaBIOS-hppa to version 16 (minus the 64-bit binary)

Helge

