Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B8DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChjb-0007mK-C5; Sat, 25 Oct 2025 13:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vChjZ-0007mC-8V
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:07:17 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vChjU-0001hO-Fz
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761412027; x=1762016827; i=deller@gmx.de;
 bh=A37RIWZihVFHaHWUgvV/a6KYbb+FgjJc03k/4C3Nc0I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GYBLTHoTr80Kvhz/eaLN0/4dZkYkM1bhR1Rsy8UVb8hrKwf9s5+kHeeRNwtKsRdP
 /vteos/hAAzPiUAOXcUOEhiV7cd65vjyvRsIqx459jeQCRMAeCQo8Q3U53NLoq7Xc
 QUwFqx4Hg2/9IrwayrOeR6quYiC0cmAqUz5FVqjKv2BsgsQrQCzvxB/Ysu39jOI/x
 szsGNzphMNugpMqoX1AoWymW8w8NqkvkgzFwaw2jNIJNeUHQnQP9TiQ04HUjbhw8P
 kHcMsyRXONJSBi2zlQhbL9OK36ZBpoCs+B3XnSpeGL5TbwI7fEp0FApgHzvTjW/F/
 ULY8PJZMc86Tb8o5tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.19]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1uj7eJ2NXY-00SuWm; Sat, 25
 Oct 2025 19:07:07 +0200
Message-ID: <176f6987-a576-466c-a302-b279abcb5c14@gmx.de>
Date: Sat, 25 Oct 2025 19:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] ncr710: Add driver for the NCR 53c710 SCSI chip
To: BALATON Zoltan <balaton@eik.bme.hu>, deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-4-deller@kernel.org>
 <20935a97-925f-3f58-998a-871dd0d04ca1@eik.bme.hu>
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
In-Reply-To: <20935a97-925f-3f58-998a-871dd0d04ca1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7A6NIfKpWVhdvsmCBIUF8oTTZLGIecfX2hvsFuDCARoIr+OQvs
 A3GsmtrJbWRhBtLmp6o9FzjJbB5OZUYXQXC6ajwNB1WW4s/0Ig0q4e5l1pPzWxGtTt5fiIR
 jpiBovTs6tu30rMQlz4v4cmc+YWLUIkWHoUtnD6YK8D59MldNBCcQwQ4SBiFMBoKxsQVl0W
 8R20ibN+7++T1QPs0JJ3Q==
UI-OutboundReport: notjunk:1;M01:P0:kARZwNINg+I=;Nzi5+XAYgzt1cOQYbyOCzycyI8+
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

On 10/25/25 18:59, BALATON Zoltan wrote:
> On Sat, 25 Oct 2025, deller@kernel.org wrote:
>> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
>>
>> Add an emulation for the NCR 53c710 SCSI chip.
>> This SCSI chip was used widely in historic machines, e.g. as SCSI core
>> in the LASI controller in HP PA-RISC machines.
>=20
> Shouldn't this patch come before the previous one as it defines
> functions that the LASI glue uses so I wonder if this compiles
> without this patch?
You catched me :-)
Basically you are right.
Logically it belongs before the next patch, but since it's not wired
up in the meson.build makefile yet, it will not be compiled yet.

I looked at switching both patches, but since it would not have had
any effect I just kept it as is.

Helge

