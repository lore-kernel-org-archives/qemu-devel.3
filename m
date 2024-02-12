Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B39C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZfzL-0002Iu-QQ; Mon, 12 Feb 2024 18:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rZfzL-0002Il-31
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:45:27 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rZfzI-000884-Km
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707781518; x=1708386318; i=deller@gmx.de;
 bh=Tq3aROdEvhNz2/bjPK7dj2lndzVury1v9tABDfMkRYM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YbNgmJu59Zvg9gmwAxnYLd3QsAQcgssSdInVBiYEv+/bP1hAj4nct6tZVjst00NY
 6onX8Z8yW0Bsk7+y2gwZDsSHqedcqSMS6cm1K+ZmNsZDVc7spIYFaln/qK/D9+QeQ
 CmMicL5MYYc+AMfabnAosiCoS/UuLwt6XJIZ9fh0GVH5YVuO6NbW4+E89yPF1fksJ
 2bO/l1yLUiappAjVJsKj4/ZEQdrgeTKEN1n/xZ17Gbfv+kxFX+/DJnsiHl26SRR05
 CUqNGzCyxoSrqL39XOTR/p0JV/YFZQT1JqLjEvwvFAmiag//2VDOGyfEx1V+DV1aF
 iaZ98sbQyi50GMQcew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.146.12]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1rDWSk3Fpo-00ma9M; Tue, 13
 Feb 2024 00:45:18 +0100
Message-ID: <3af05e52-c386-4bda-916d-3dd3b397c160@gmx.de>
Date: Tue, 13 Feb 2024 00:45:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/12] target/hppa: Update SeaBIOS-hppa to version 16
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>
References: <20240211122909.5807-1-deller@kernel.org>
 <20240211122909.5807-12-deller@kernel.org>
 <a9813b14-1e62-4e4c-8f95-46fa36edc62f@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <a9813b14-1e62-4e4c-8f95-46fa36edc62f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KVUsREKOhrfXmqzfJI6L6OkLo9EA/ykJyF+pJxwbJwafd4QWSdW
 +COVIWi3XAZrtw8/tg60cvfsFFt2ZlYSXFfJFWFQ0UkaDRvg+z7YbJG2tWqeKoceUgmZ1J2
 mzwzAHE58EmfFr9UtOTziGj4+aiq0Hg/ZCYgd+ldcF77DL2pXUZAEb1H1jEBGIV46IVUMCq
 a9FF5BfGSsJss9IF+iMeA==
UI-OutboundReport: notjunk:1;M01:P0:557fcfPbsAQ=;5vD1OQdb1DZXqzbXmo2nZOBGaRl
 tBLAGeGsSg6vGxh72NWKihvfrBZ5NGYPV6OXZ05z5I6g3zmaJPB1COIcYTQSScSEN25p9me6g
 zHDKVfuGzkaTSrpGW8ZCZvn4H9nG4ElDTXYN/29Uw6kS3m0wJLnUNh3HW4ovJmzhbdmFpjp7F
 JUIz531T8CYa50dq0wJw3WRiVTuDeSBArW2eRPLhOfSceDXxqdK/OeuJqAd3b6zIJkhNJ9ch8
 zHB8nTXH976qMB+qp4voMkwTygF+3zkGanvP83YupfBSTRs1sxaifwPBWL5RfeANGPiH3coY9
 AbZYtRqsICspqlgxwtSTXwk7u/RKWRM3UVtSxJ5E1IKiL0BNW8ggZjXlmc/k6+ZLFWo2Cg8XX
 JrckRZsU9MSEEZVjxpvJ2RFU3jQ6E9Ql3AcLVEHjI5xoJFEiWHX3gDASm5fZnBFpmsiWqjIUs
 Qh2JEhalGLbLP2Gy7Gm0lDBt6rzkAOYpVIiN+XX0mwO4mj28VEP0LbfZs5yTKCeSm11Dkpqz3
 Hnce6cJAjsU3+PdINd0Rc7v63MiVAowzdHVLGx9pLJHp456cAKqDjQ/tqeQrtlbKAb3yfpG2v
 fQCJJLkjr+Up+f+h/PxOSlORBNZSgCdUfuSXUuCQd66zbz+hzPk6JD5SZoXgyxxdF8OfIKL65
 TTM0oEk8B40z1cl3mHhcajKeytCZffMmt6FjDtbV5MVgYhexkoJXGZjzihukzhuw1M8vuY6lU
 7ACnqLhhMXXacviruNwy/AGmnMBFy7I72JGGtcwmjTf5nIm3L/hMjbLMTLibw16154GMBoahV
 zpPhqz6hxgepfWhThbtnZp3Xikhq2r3ksxdi0QWTK0lZg=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

On 2/11/24 19:49, Michael Tokarev wrote:
> 11.02.2024 15:29, deller@kernel.org
>> From: Helge Deller <deller@gmx.de>
>>
>> SeaBIOS-hppa version 16 news & enhancements:
>
>> =C2=A0 pc-bios/hppa-firmware.img=C2=A0=C2=A0 | Bin 163324 -> 167820 byt=
es
>> =C2=A0 pc-bios/hppa-firmware64.img | Bin 0 -> 206024 bytes
>> =C2=A0 roms/seabios-hppa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 3 files changed, 1 insertion(+), 1 deletion(-)
>> =C2=A0 mode change 100644 =3D> 100755 pc-bios/hppa-firmware.img
>> =C2=A0 create mode 100755 pc-bios/hppa-firmware64.img
>
> Can we have build instructions for these files in roms/Makefile please?

Sure, I'll add then in the next round when I send a v17 firmware.

Helge


