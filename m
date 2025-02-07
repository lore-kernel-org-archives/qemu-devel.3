Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1797C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQP8-0007sE-DC; Fri, 07 Feb 2025 10:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tgQMr-0002sL-CD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:34:09 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tgQMo-0004TQ-Pz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738942444; x=1739547244; i=deller@gmx.de;
 bh=swMt/q1ZhkbV/4dlXskwvN8unajecEUyMgTJKnT0D+o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=frO0gzYwews31QQxj9XA6CWS7SNt5f4WMP9W4uK3aTqUNnTsk2R2cOx76xkPk/6R
 g1dMDnXTK07qOAES1M97JEB/5UPhrZYu7ydqRapIqnire6RbwW2D9P24sjqQfHzs4
 /4LZqnWQo+SCD6mEeJG99VOyp5cREMnGeXWhcNsJXV2ZivCA4hxcMxYBs5VKTIzJU
 ty7HzIKY5l7oWyOmJ2HXJm3J73A+2FKfeEvIJaml5L9TlS5h7ikvui0G8Gf9zR1hs
 RgbyUjFiZ7DkPjsqVHKVaGjCBA5MDerSK+M6ppblzmRchJsVBFLsAHg5L0IRpW2nR
 6ZyNY5GqRqEbX0xi0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1thWpL3yTk-00Gfpr; Fri, 07
 Feb 2025 16:34:04 +0100
Message-ID: <a1bee9ff-f621-42c6-8ef8-c52432d735e7@gmx.de>
Date: Fri, 7 Feb 2025 16:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <74d703f3-b2c4-416a-805f-61859a5a4e70@gmx.de>
 <CAJSP0QWfaW0Nk2hdAWyT7kr9bOY6FNC3FXMqsjVfzONfU5cU0g@mail.gmail.com>
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
In-Reply-To: <CAJSP0QWfaW0Nk2hdAWyT7kr9bOY6FNC3FXMqsjVfzONfU5cU0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GWsKprxdY00U+0+iu1Z40CbNsfMDvqn0P2C0hjiJk1e+GSIjsQr
 47GhTPL8eTZaZth/p/relGTAlR3aOZYIy25PnsmbT+GF4r3wXVMuYYtHWAS9+H0RwmUNn1m
 M7HlGUKYFa4CQLFSmztb6y6V7UOycmlempysGmX8CUYpoGufv/tDtRqUzoHwtH7h7TCH1M9
 KQTgefcNNlXPPDAY+ND5Q==
UI-OutboundReport: notjunk:1;M01:P0:Zskj8j08Lco=;kgZsuDkijTYfnfN8ZG/rmYDalTQ
 VPy0pMb7tucVTcJ9mDMx+B9nBCuOLzo3hZ0wzCCoiCULNq9D3inQGCKFSZpmGzwaDzC8EEN0K
 yktfxCpcNpVCb0Dt+5P7BR7Wgvk4DtvoluVkreKBfvDvXyqUAMZwx4Av/mYISZhpjyZEl2B+J
 ZKG7rLfHRRuaoM35v+ukMuzkxAf8RXB03Cq8U9UyFV2udU9f6ue+WMkUuEqRqK79zSkDrEwwR
 2UgibqVXqKcyimy4YAyHu36mV4HiyF21CJ13ZpJxFzkUyn2rca16tdPfQVLW3OgDpiMsMK66h
 9+C/abd57ybZbEYhRc9zmmfdg/odP5WC+gnrATVSgNbxXiRkchbTY40wupTcX1grUUEEdB4+f
 DS5Da1XcdJO3zkOZXtE3I2H+gHGM4WOOgysW9g6NLwywjAmCNGC9XteywuZ8qSZ5D1A/LBUUi
 UDxxPaVnmEUjHJhLiEtieE/LRb7AiFOvsj2/+0bG938gMsf/viOfCLbttAdJRNgjI+3XwJCT+
 qPXMt7aqrHrRA9fbf0PNxJt0JMKTAh/ORZIPGzoeUZM6kli+FyJqcfALWkrbjgeh4MchgJZzY
 lCuShy2vWP5mOCJ1Q8VYQCRt667tMX4ST60kkKrLsz6X2EbJaogfy7S/EYzW9nuH2Ldsl4sUl
 7EYdrYhvbVqxlxZos7qSf1r+C2sr+RKF2WsMnk9voAHpL2uDuePB+PADTHKsE7FlmjzL4fJ14
 eoF7MvtQkNmim4FAMsitbq1c8OP0QKR73zh7/UzUpAAqSucsCpOojF3eEQWMzOkBlxQbAa4zX
 nC/Mf6tle5dGZxTKfemmi59ASjmQCqTpV77XHQ7JhYN90rLJqBqM4jA8wujpiJkx1oJj9Qyl7
 uK30w33UMULLO8XcKSGfhE2x19iX1WTwLWxn0Gns3VlrUp2n5WYp5jrOZrQzbCHCQVfTqcBfs
 yDy4oAvVYJumkKzj0GgDxIA0wmXCabMw1+nXecMicsE9PLHSg7q8z7sTXEcLpjW0rzvD1PbXB
 z4v5NLPsFDtqqUpevvNAAuIjpUZi7NyjL22dFxJt8/2Swjt1lOtG98SeQoVE1WSaPLyzlFAWQ
 FGpYHh7utu5rhEwpzIo6tXgWCy48H7EBeSkBfrFSpTQvZKwXWVDw4vi0PdcHOLOgYSLNjC/cp
 xR4fG4KYhu9UYAsxsCbS2Zv07mGZ27VSpPQpDyQgMecv+ccLDDL9PZloauH/8bG3Yux1BG3mI
 eHMXrbZVhBKOgSmZyBaYopRyFRCbDHOR3lulX5cJm2AAxhddwjlgkwbVQ+lju2Wq/+ZQzR/3K
 CkiJK9fQDC5nt6TiyhcGGrtuayyR24C43O8dEEMKVf83WAe3/IhrPmpYj3ij1Sn+NSDqNcBKz
 sMIRHlmwQwK5Me/Wrl2O9lUSfbeQDAXl46zeN/FqoMPfpAhN59hqnxxqDwDpXemfu+o7KHrdv
 rVzL8aDZOzCS5tf42RsqaovRqGWOapLP+8qBFfGoeGwn9fyy4
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/7/25 15:47, Stefan Hajnoczi wrote:
> On Fri, Feb 7, 2025 at 9:39=E2=80=AFAM Helge Deller <deller@gmx.de> wrot=
e:
>>
>> Hi Stefan,
>>
>> On 1/28/25 17:16, Stefan Hajnoczi wrote:
>>> How to propose your idea
>>> ------------------------------
>>> Reply to this email with the following project idea template filled in=
:
>>
>> Would something like this be acceptable?
>
> Yes, it would be great to have an emulation project idea like this!
>
> Please choose exactly which device you'd like them to implement.
> Interns may not be knowledgeable in the field yet and you actually
> help by setting limitations.
>
> Link to the specific device's datasheet, existing open source driver
> example, internal QEMU APIs needed to implement this type of device,
> etc so that it's easy for an applicant to investigate the idea and
> decide whether or not to apply.

Ok, here is an updated text:

=3D=3D=3D Develop a driver to emulate an existing network-, scsi- or graph=
ic-card in software =3D=3D=3D

'''Summary:''' Develop a driver for Qemu to emulate an old network-, SCSI-=
 or graphic card in software

Qemu allows to emulate a lot of physical machines. Beside widely used
x86 machines as used with KVM, this includes historic machines
based on PowerPC, Alpha or HP PA-RISC CPUs too.
To allow to emulate additional specific historic machine models,
drivers to emulate specific hardware like network-, SCSI- or graphic
cards need to be developed.
This project is about to develop such a driver for the historic
HP PA-RISC architecture. Based on the knowledge and interest of the
applicant, here are two non-exclusive options:
a) driver for the "LASI" network card. This is basically an Intel 82596
network chip, which was integrated into another ASIC in the HP 700 series.
That chip was used in SUN machines as well, and the full Linux driver
for the various machines can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/ethernet/i825xx
A driver for Qemu exists, but it's not fully functional yet:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/lasi_i82596.c
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/i82596.c
Datasheets for this chip exists too.
This project is about debugging and analyzing existing code, including
development of missing code.

b) a driver to emulate a "classic" first-generation NCR 710 SCSI controlle=
r.
Really old machines used a NCR 710 SCSI controller, for which currently
no qemu driver exists.
Qemu has a LSI53C895A driver, which partly even allows to
emulate a LSI53C810 too, but those chips are "too new" and as such
are not accepted and supported on old operating systems (e.g. HP-UX9).
The WinUAE project seem to have modified the existing qemu driver
to emulate a NCR710 to support the Amiga:
https://github.com/tonioni/WinUAE/blob/master/qemuvga/lsi53c710.cpp
The goal of this project should be to develop a nice & clean NCR710
driver which is acceptable to include in qemu source code repository.

'''Links:'''
* https://parisc.docs.kernel.org/en/latest/technical_documentation.html
* existing Linux kernel drivers

'''Details:'''
* Skill level: advanced
* Language: C

