Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3B6C54ED1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 00:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIzCS-000676-Ks; Sat, 24 May 2025 20:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uIzCQ-00066x-WD
 for qemu-devel@nongnu.org; Sat, 24 May 2025 20:26:47 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uIzCP-0000jl-3V
 for qemu-devel@nongnu.org; Sat, 24 May 2025 20:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748132797; x=1748737597; i=deller@gmx.de;
 bh=MzECX3+osFQOMWmlY544ElyKp+j3HwnWBUwZpc5wkfs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aX1OJjNdMmyY499B37XlvCRnAKQvnT3staZSaOLF4PAB4qNLIQDtzDcxylF5UUJl
 NXeSt5atoXXfJc1jZ1F+1x2sN/2F5rxfGsCJSmzd7XeUivFUm8rGBt3Oe5j2jvhgu
 iaYH2dMTvIR4zQunDDz+EdN6FpYvHeEmGIOxt2vRvebk5iBRjiVwS9u+YYRXClKI7
 NAayYSLFVgeILhMexYdGXyPgXtn6IfzC1Tx5WIjk/kFTzeoNxvvfVAX69mWsrG9g4
 w+XHZhg1AqkyRtnRxss+h1wj8gl24o8i3h4Y7lYzQ3RO1y9ozsh3Ashb6TQegmYah
 UbCczcGJTVC5erhH5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.249]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1uqhNa3p7u-00oAnA; Sun, 25
 May 2025 02:26:37 +0200
Message-ID: <9cdae9a0-c82f-4238-9eef-792e51eaa535@gmx.de>
Date: Sun, 25 May 2025 02:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] roms: re-remove execute bit from hppa-firmware*
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org
References: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
 <aCs183hjzXVafV6B@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aCs183hjzXVafV6B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mg3FD4EFlr15YIX8WwsbPygciJ03IB4ye/I4zoEoqemBrhB44BQ
 OVzdLc9sR13BOakmFGYEu1GfFtKioNyUzKnWARN5TilDblv8/wbGMzO9K6TW9nte9ML+7n5
 Iozi0CGLhmDZIecpniW/ldu6t/Q5fQmajru6vg+MMJOWCR9Bp9d9tMUn7jG4ax+xXtdKfR4
 6tS0JzGGnOEnSqBJXH+mA==
UI-OutboundReport: notjunk:1;M01:P0:/w1raECprMY=;oktIdUdQ2uamLgE7u8xmreywvmZ
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 5/19/25 15:45, Daniel P. Berrang=C3=A9 wrote:
> On Sun, May 18, 2025 at 01:54:20PM -0400, Cole Robinson wrote:
>> This was fixed in c9d77526bddba0803a1fa982fb59ec98057150f9 for
>> 9.2.0 but regressed in db34be329162cf6b06192703065e6c1010dbe3c5 in
>> 10.0.0
>>
>> When the bit is present, rpmbuild complains about missing ELF build-id
>>
>> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>> ---
>>   pc-bios/hppa-firmware.img   | Bin
>>   pc-bios/hppa-firmware64.img | Bin
>>   2 files changed, 0 insertions(+), 0 deletions(-)
>>   mode change 100755 =3D> 100644 pc-bios/hppa-firmware.img
>>   mode change 100755 =3D> 100644 pc-bios/hppa-firmware64.img
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Acked-by: Helge Deller <deller@gmx.de>


> Though given the back & forth, I wonder if we wouldn't be better off
> changing meson.build rules instead to mode 0644 for all blobs ?
>=20
>    install_data(blobs,
>                 install_dir: qemu_datadir,
> 	       install_mode: 0644)
>=20
> ...assuming none actually need execute bits set.

yes, please.

Helge

