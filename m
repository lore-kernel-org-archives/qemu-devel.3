Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E5D149EA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4P48-0001Oo-6T; Fri, 25 Oct 2024 14:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t4P46-0001OO-Ml
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:29:38 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t4P43-00069U-3H
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729880971; x=1730485771; i=deller@gmx.de;
 bh=nFNxkvcPt0hriKpnHMcY3BLH0MoGeYnKZhhWRqIy/mY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RnjKlxEN1AGEfg9fhM3OVVPOYuwGwLC4YPNV8ki3pldl+OK8/uOvm8QY1x+qHR8N
 SkTWz5Jg4x+AcWClocv9L9A0lMBUNHJ2LsoUdpISMCbi+wvr5bYmN/X0KMmvr2uYw
 lZuiVnCtZY2r/A5du11eHIJCAubhacfYNVtJhWxrEZGgKTGQtM/ns3m+B9lkmaYcE
 /ae1nFSn2KX0qxs5lPZsr45MAID79+WuVldOgHs9FUJU0YtEpxCYE9sCOZL4Nxs0Y
 EDklXm7yN81REBhpHebW3ZqNPjrLTdCEOJgxyu9c5nH5ImhNDjWwRWAfjcsTHOrCJ
 JCV7u3af83DM4jJ80w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1tbp8X33RG-00qj80; Fri, 25
 Oct 2024 20:29:31 +0200
Message-ID: <af3a5e4b-a9ae-4a1d-868e-43d6e06a6008@gmx.de>
Date: Fri, 25 Oct 2024 20:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] softfloat: Set 2-NaN propagation rule in
 float_status, not at compile time
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <e5e9e5e8-febd-43bf-bfad-8932b29fdd0b@gmx.de>
 <CAFEAcA-UZbFxXRt5pzQP9Fa40DJAvuYz0_a=AEsVjUb8A3Z4nQ@mail.gmail.com>
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
In-Reply-To: <CAFEAcA-UZbFxXRt5pzQP9Fa40DJAvuYz0_a=AEsVjUb8A3Z4nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b1eUfodZZnZRHHxQdiCtloXnqAYawVwGx6Ie46KYekw5XoiZtQ2
 VaprHvH/GTXkR1mcq8iqL8N0E4tNPqVjOAKofxUxkEl7TRFrbZVoxofAhAbcWt12wlDSQ6A
 lg55oa9a1gbd80wuZDfcywSHvnFER4IhjxhebLF8xC+5141pCbMwLNen4ZojWqjLpAp8mVr
 ms2vsBbsaCL1JnSUaoVIA==
UI-OutboundReport: notjunk:1;M01:P0:8SmXNGpkxeY=;UFI7F8J/CizJIwhxjaHVxHbc8N3
 VNlELymTsPuTUrIbMVQ+HjSbo0+BFaIZe55oM7U27aVPH3dEC4dqsP+9sEh9F1zGarv7Qo5tN
 3lfOigV/kPFUldqlNvNIecrS3giOS6Xx/tgPv0YhilOR2efQnhBYnMX+rlaLzttAoclcsR3dh
 3AbWr0jO27qQrxqUQwSh2DouDFQFzvuWE62l5MX5faEx6Xo3tbbHNY18ssYKh4y8/VDtWt6ME
 bcLrzEhS2aFJUzAfQNZmtijao244m0B0M0t3nMAts0yeUr84ujH2vtUI93mYB3HAQwazCo5oR
 Y0C27lBHNdP/0oRKtkBMwd2X5UWBNeEsMoFKizy82BEsaQKTgSCTnnn7OGe5dF3zid5zudUiG
 z72qym1mMsxYZW3sBT0MQ9tGP513roro4M8AOvj5973yOnmseuluUj9VnwFeLgW7m6j+d1wbJ
 LUoOzcoQrk+petkemz/CM0ZOnqVQW4HA2fXZ503oqMGciND20zHlW3NaoBSe3Q0Vap8KmeYE0
 0DL33vCCGddLKzlEix5VYQ4/BMUtT2QTYqpnCbSeWHyKjOJ2XSXoYx4t8M69FaI9HBjSRXhAB
 CPtYKQ/MGkpWkMxw9CWywKq3Tu5iHGteM4MK4jTwvGstTKFWFwN7SeVE8ZITAgare8F7OILPn
 1qianMrr59Gtvl2RzYyu9A42SL3G6/UbOycAecFNbtcF1Jg7CEHQgn7YSbLOQZMmo5JplLTB0
 0enlFOFKivKi1yN6idewEQ9LPtCQ0erhJIgcvuPcyYQLJZCy4SpV6WqrWqOWpq4GoTm5Ktp7e
 XgjDoZf9IYIMh2ZxlVm0ErJg==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/25/24 16:59, Peter Maydell wrote:
> On Fri, 25 Oct 2024 at 15:49, Helge Deller <deller@gmx.de> wrote:
>>
>>
>> On 10/25/24 16:12, Peter Maydell wrote:
>>> A summary of those TODOs and other oddities I have noticed but not
>>> tried to tackle is:>
>>>    * hppa really ought to implement a CPU reset method
>>>    * alpha also doesn't implement CPU reset
>>
>> I used the alpha code as template to implement the hppa machine.
>> That's probably why the CPU reset method is missing for both :-)
>>
>> The TODO about implementing: ?
>>          resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_ho=
ld, NULL,...)...
>
> Yes, basically. The reset method should restore all the
> state of the CPU to what it was when QEMU started.
> Typically you put an end_reset_fields marker in the
> CPU state struct so you can memset() everything up to
> that point to zero, and then manually reset anything
> else that needs special handling.

Thanks for the explanation!

I've just sent a patch to the mailing list:
[PATCH] target/hppa: Add CPU reset method

I tested it and it does work for me.
If OK for you, I'd happy if you could include it in your patch
series and adjust as needed to fix the FP initialization.

Helge

