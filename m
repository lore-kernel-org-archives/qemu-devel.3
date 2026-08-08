Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52731C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsdFw-00016k-Ff; Sat, 08 Aug 2026 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wsdFu-000163-Bx; Sat, 08 Aug 2026 05:22:14 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wsdFp-0007Sj-Jz; Sat, 08 Aug 2026 05:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786180927; x=1786785727; i=deller@gmx.de;
 bh=LPtqI9FBwXbYJUaDk01c1WtOP605RbV6GigVao3ur8c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mVJjDCuWzKFWp5wHdql80tir5DvYj3LfLHLQ43lzB/t2pvWGhuMb/4WNMRZHtZL8
 3Vy/a5DGZYRL1HUQBsbwIkD1fDrZioFpabgPo6JrHTPwWiKndPNvsQ0+hBhiqJG4H
 qOs/HRxUQmSM1M1lxlCJeT/mWQrunoQ2xBtk8YG/rvSUDKLJAgG7F0zbPU/oQOip5
 xJgvidDQToyf77a/y4Y1dvoGJIw5g9/Ui6IMmaqb2E4GQWUs255PLiAGIxxPcdfQ4
 8+RD3uWCfG9drJC06aqdcf/YHRN3axZAiYTNPL1a1eThMxKn85fp2kwjI5vlnAHx4
 p9srnpKNZuy3gdLY5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1wRrBs2dil-00PyqK; Sat, 08
 Aug 2026 11:22:07 +0200
Message-ID: <3141d1ed-f7b6-4666-bb0f-9c52eb02d74e@gmx.de>
Date: Sat, 8 Aug 2026 11:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/syscall: fix target_msqid_ds time fields
 order
To: Michael Tokarev <mjt@tls.msk.ru>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240329223653.155786-1-jcmvbkbc@gmail.com>
 <c2c16a13-96d8-47b4-afec-81c812d473fe@tls.msk.ru>
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
In-Reply-To: <c2c16a13-96d8-47b4-afec-81c812d473fe@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tt0pyCWEF7Ebw6a5tye0zWoL+sQQp7mDNY1CReIuxwuueNViAnH
 2Zw7RkXkV5Y5N4DiMNtv1cn1l9yM/mltWWbzSTJevHD6vkf+DNjf+HeOChapi68RGItNhtr
 QJ+459er7JT9Fz/HqoqeyLTf19rTiJ6vRMhtP+/xE1e2qJcOrP/YEN4InhnPkl5lLeD8f0L
 nXsYqVDqqyiDoa5Krutqw==
UI-OutboundReport: notjunk:1;M01:P0:HMRtngWyjEA=;yVh7i1gFwtzhhztIzPr/j0zEdRg
 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
 gfb56BWnTb5vdS5qM2w=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/8/26 10:50, Michael Tokarev wrote:
> On 3/30/24 01:36, Max Filippov wrote:
>> target_msqid_ds::msg_*time field pairs are reversed on 32-bit TARGET_PP=
C
>> and TARGET_SPARC and on big-endian TARGET_MIPS and TARGET_XTENSA.
>> Fix the order to match the kernel definitions.
>> The issue is spotted by the libc-test http://nsz.repo.hu/git/?p=3Dlibc-=
test
>> on big-endian xtensa core.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>=20
> Just come across this old patch, is it not needed anymore or has it been=
 lost?

Yes, seems to have been lost.

> (I realize the current code uses target_time64_t instead of abi_ulong, s=
o probably
> not needed now)

Right. Unless we have an alignment problem with target_time64_t on 32-bit =
(which seems ok).

Helge

>> Changes v1->v2:
>> - split into a separate patch
>> - add PPC, SPARC and big-endian MIPS
>>
>> =C2=A0 linux-user/syscall.c | 20 +++++++++++++++-----
>> =C2=A0 1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d9bfd31c1cad..781ed14bc613 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4113,17 +4113,27 @@ static inline abi_long do_semtimedop(int semid,
>> =C2=A0 struct target_msqid_ds
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct target_ipc_perm msg_perm;
>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_stime;
>> =C2=A0 #if TARGET_ABI_BITS =3D=3D 32
>> +#if defined(TARGET_PPC) || defined(TARGET_SPARC) || \
>> +=C2=A0=C2=A0=C2=A0 (TARGET_BIG_ENDIAN && (defined(TARGET_MIPS) || defi=
ned(TARGET_XTENSA)))
>> +=C2=A0=C2=A0=C2=A0 abi_ulong __unused1;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_stime;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong __unused2;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_rtime;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong __unused3;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_ctime;
>> +#else
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_stime;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __unused1;
>> -#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_rtime;
>> -#if TARGET_ABI_BITS =3D=3D 32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __unused2;
>> -#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_ctime;
>> -#if TARGET_ABI_BITS =3D=3D 32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __unused3;
>> +#endif
>> +#else
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_stime;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_rtime;
>> +=C2=A0=C2=A0=C2=A0 abi_ulong msg_ctime;
>> =C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __msg_cbytes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_qnum;
>=20
>=20


