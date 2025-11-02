Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A635CCFA00
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFgLS-0007uU-6Z; Sun, 02 Nov 2025 17:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFgLR-0007uM-0j
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:14:41 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFgLP-0003ub-23
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762121675; x=1762726475; i=deller@gmx.de;
 bh=uAOlC5anz/kDlFmWXlVCwRYTQmXOCqSZ3VRgVEIYb4Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YYtRo6PKjVuWTrXtFdimRkR48v6CnAcN0b5h7O9krP5m4GMmOlWQEwtRrmY8RZvE
 FH3skl6K5qzVbJxfTKuo2zIaF2o6oQynRFCn3CCSLLJkMlBFwDb105CMA9wLTx85N
 S/PN5YQVjAz3QNJ0We8BK+z1GstFqvvSdPXWkkBShjO4S9XOZVqhwu3hhkgkVjn8Z
 c1t6wy3/XBlyj7pq9F9NmT3U56BMv3nrg1LlMwJ4p0icSKw/jfo91DL7hguJwZ3Cc
 0UC6mNAgJdfD64gIjU1PmyHn9JTgt4spcfjTnJRiROPjzvcZCRsAq/mIzmUEKJRXC
 6FnbaooksOx1TueHMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.170]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1vXUJB49YF-00PmnQ; Sun, 02
 Nov 2025 23:14:35 +0100
Message-ID: <f1d54a7f-1cff-4684-8962-7efb872e2e98@gmx.de>
Date: Sun, 2 Nov 2025 23:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
To: Guenter Roeck <linux@roeck-us.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
 <ed6aaa98-af19-40ca-ad76-e4215579b74c@roeck-us.net>
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
In-Reply-To: <ed6aaa98-af19-40ca-ad76-e4215579b74c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdQWhMnKqs7ndge1j/NWLLcRhmQ86icMJO41C1FSZR/sYbclOVZ
 Lhb7+m3U3OGcwLNbc9DteWqVBtx3CNriRyrzn/wV+eazP9QI491SdmzBsS8n8bZJmkMTwKf
 yA+9A5EFlLB5veXN6jEb72aTgCMJJak4Hg4ZZa3I16xBxEnFBsn5WCTRXr809fWvZ4nvkZt
 RqASMRLC044YvOcGm7z3A==
UI-OutboundReport: notjunk:1;M01:P0:PST+0JqlGwQ=;m15VOpuILRj4iZ2PWJ/n68TnwYL
 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
 k7X6/f5j5bUV3NO0g=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

On 11/2/25 18:40, Guenter Roeck wrote:
> On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
>> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>>
>> Enable the i82596 network chip which is included in the LASI
>> multi I/O chip. Since LASI has different start addresses on
>> the various machines, always initialize the LASI components
>> by their offsets.
>>
>> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Changes since v1:
>> Added proper Qemu device initialization for LASI
>>
> ...
>> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
>> index d422af0429..a8a496c0e1 100644
>> --- a/hw/hppa/hppa_hardware.h
>> +++ b/hw/hppa/hppa_hardware.h
>> @@ -21,14 +21,6 @@
>>   #define DINO_SCSI_HPA   0xfff8c000
>>   #define LASI_HPA_715    0xf0100000
>>   #define LASI_HPA        0xffd00000
>> -#define LASI_UART_HPA   0xffd05000
>> -#define LASI_SCSI_HPA   0xffd06000
>> -#define LASI_LAN_HPA    0xffd07000
>> -#define LASI_RTC_HPA    0xffd09000
>> -#define LASI_LPT_HPA    0xffd02000
>> -#define LASI_AUDIO_HPA  0xffd04000
>> -#define LASI_PS2KBD_HPA 0xffd08000
>> -#define LASI_PS2MOU_HPA 0xffd08100
>>   #define LASI_GFX_HPA    0xf8000000
>>   #define ARTIST_FB_ADDR  0xf9000000
>>   #define CPU_HPA         0xfffb0000
>> @@ -44,6 +36,18 @@
>>  =20
>>   #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be=
 in f region */
>>  =20
>> +#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
>> +
>> +/* LASI offsets */
>> +#define LASI_LPT        0x02000
>> +#define LASI_AUDIO      0x04000
>> +#define LASI_UART       0x05000
>> +#define LASI_SCSI       0x06000
>> +#define LASI_LAN        0x07000
>> +#define LASI_PS2        0x08000
>> +#define LASI_RTC        0x09000
>> +#define LASI_FDC        0x0A000
>=20
> One thing I noticed: Those defines are now duplicated.
> Example:
>=20
> hw/hppa/hppa_hardware.h:#define LASI_LAN        0x07000
> include/hw/misc/lasi.h:#define LASI_LAN        0x07000

Yes. The file hppa_hardware is shared with SeaBIOS, that's why it's
currently duplicately defined. Will try to clean up with later patches,
but for now it's the best way.

Helge

