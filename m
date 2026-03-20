Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCAF1088E6E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3W8I-0005ny-Bh; Fri, 20 Mar 2026 05:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w3W8F-0005ni-Sq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:27:04 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w3W8D-0006Yg-QA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773998814; x=1774603614; i=deller@gmx.de;
 bh=6+zElKr6n8TXa4Loc4Nkik/ePuCzuzeMN4rB6DlijSQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oafY3ah8lppG7y/RipsQGOUyWksDzVY5VzJaAeKGiWoBTF3MmfdILQdjLfONioYA
 4DbJE+factShuf6s/jnTC78YWBT0Lfjyynu51BAyRsbvkmzkUMTVsjlAW9FgX4qZr
 m1wN071VRnpXBQa5EwWtqkxYgd0GiEbHcTsQvZfG9zfwWRXE6VccsVBCu5tOlpkD+
 zk6n+b+8dFRCw9K2V2yBAjesiVCgYfd4wV5x5+3eUpGHHvmA7rcJ7lQ9KYVEpM5lL
 ubwg1uJs78d5XnB3q3eYeQeVEl2eSKoI8iHY6D2G23jTSNhHknSZVHwYWecwgk6Zw
 lo5lRKOG/pPM7vfiBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1w80EA2Isa-00MFwl; Fri, 20
 Mar 2026 10:26:54 +0100
Message-ID: <d91038f5-1345-4851-a39c-358ecca02d13@gmx.de>
Date: Fri, 20 Mar 2026 10:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU requires a 64-bit CPU host architecture?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
 <ab0LPpXlojZHtMZQ@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <ab0LPpXlojZHtMZQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u8bykroOBXGqIyv5w5yEt6XUsC0dXCaJfZaPDvMa2f42oR0M14T
 xoPy4wla/ugzoKyeZc6pCI6odCpF4EoVu6bOGiDcijnJEBX6OrqWVDz5c8Pw+CJikc2dJv2
 +GyrMHJC0ODkkjJaBdZVvZ9zI1YNqBIHteRPn465BXSw9uxFe5mfrEavj9+371JG4Uy+L3B
 +ES79CM7n4UxvId4/R+DQ==
UI-OutboundReport: notjunk:1;M01:P0:gIXHDM5IRrs=;7wBzqQLSJKLpD306gUt4ZwgIRTM
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/20/26 09:54, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 20, 2026 at 09:45:20AM +0300, Michael Tokarev wrote:
>> Is it intentional that qemu does not build utilities on 32bit hosts
>> anymore?
>=20
> Yes, per this note:
>=20
>    https://www.qemu.org/docs/master/about/removed-features.html#bit-host=
-operating-systems-removed-in-11-0

This states:
"Keeping 32-bit *host support* alive was a substantial burden for the QEMU=
 project. Thus QEMU dropped all support for all 32-bit host systems."

The parts of qemu which deal with running as emulator I agree with this (e=
.g. removal of atomic requirements and such as you stated below).

But Michael is referring to the *tools*, like qemu-img and such.
There is no need to limit those to 64-bit hosts.
Those tools are necessary on a lot of platforms and architectures,
not just those which are officially supported by qemu.
On Debian there are quite some hard dependencies of some debian packages
on the qemu tools to build other things.
I once had a debian bug report about this (which I would need to look up a=
gain).

That said, I strongly agree with Michael that we should not
pro-active prevent building the tools on 32-bit platforms (or
other architectures) and restore the ability to build (the tools only)
on 32-bit hosts again (even without official support).

Helge

>> I understand system/user emulation on a 32bit host, where there are
>> quite some real difficulties with address space sizes.
>>
>> But what's wrong with building qemu-img et al on a 32bit host?  It
>> doesn't require 64bit address space..
>=20
> While the acclerator burden was one big factor, there were other
> code removals enabled by dropping 32-bit hosts, such as removal
> of 64-bit atomics emulation, and removal of some back compat
> definitions for 32-bit kernels, and simplifying assumptions about
> CPU features in other code, all of which leak out into common
> code used by qemu-img & similar tools.
>=20
> Keeping an arbitrary, and continually changing, subset of QEMU
> supporting 32-bit while most code dropped 64-bit would not be
> fun situation for maintainers, even with CI to try to detect
> problems.
>=20
> With regards,
> Daniel


