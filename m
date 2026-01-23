Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B540ED778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjMwg-00030G-6T; Fri, 23 Jan 2026 14:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjMwb-0002ys-DQ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:35:45 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vjMwY-0007eZ-8j
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769196935; x=1769801735; i=deller@gmx.de;
 bh=fPPck/nuA/dTfrRCeOIMhOpcS1gmvq3sLHSzL5e9jvc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ktbj1wITasGmK2h/5t1scqBTGoxTE3aPETCt6ma+QQObdTL/gvB6T58t5M9orTiG
 lRuj3BhwQAMVhXxpozt1GLi50du+9k3ZbTh1mNB0MJ6aXLr5WqLdhLUn9GdTTSO0j
 A6cjiFcLC/nlRFvQOjeC9WaZ96oSFuMQqzxdoQKlQiJ5wFAXQFt+E9SARvyiehXH7
 iu8BxyNgRhi5ZGhDb7t67Jaj3oNw+eIM7pD5tN4nTiwdcPbXgzbAHUAsVITgMgesx
 9+n4DAu22++N6Rxvo4sQVVHw9Z8bjNBvrylbCO+Feyeq2jlYx51uyv4j4duOBDl/L
 pnipr+N/BHf9tkVmMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1wB1zw0wBP-00hzvL; Fri, 23
 Jan 2026 20:35:35 +0100
Message-ID: <1b4cf63c-2b1c-40e5-89a6-1bcf91bb6f8d@gmx.de>
Date: Fri, 23 Jan 2026 20:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user: val3 parameter of futex() syscall needs
 endianess swapping
To: Peter Maydell <peter.maydell@linaro.org>, deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20260123150921.17891-1-deller@kernel.org>
 <20260123150921.17891-3-deller@kernel.org>
 <CAFEAcA9cvvM8SAYQGNwah+7C3Uq_27LDXk6_X0rMPtmJVjy8_w@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA9cvvM8SAYQGNwah+7C3Uq_27LDXk6_X0rMPtmJVjy8_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HGOpo6q1+A3zyd+p0a9PjaOIU8ZPS5rdZ7wuH2d3xcW5qZGfNKw
 bRmVRsXu4KgK2F6Z1W0myHVfEP+ud23014ll3E8ZLSqxGC+fzKfxla2kNRFSZNl2jZfFlQE
 E0E/SuYYnTnOKerDnZ5+E9kz90HZMtaXKjFfCesAhN+5t1Ty8wd4DHmKrzHc9hhIguNlfw1
 2ZcoqIiTVAteQhLoqIV2g==
UI-OutboundReport: notjunk:1;M01:P0:KEQURp4wfT4=;HCnbNmsHnn8vA5GyBX/oMttWmsD
 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
 k+HbU1rryxmV0jQYMOnKDjCachEea
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/23/26 16:56, Peter Maydell wrote:
> On Fri, 23 Jan 2026 at 15:11, <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> The FUTEX_WAIT_BITSET and FUTEX_WAKE_BITSET operations use a val3
>> parameter for comparism. Even if this 32-bit parameter is in most cases
>> 0xffffffff, ensure that we do a required endianess swapping if host and
>> guest endianess differ.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   linux-user/syscall.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index c0a9a86529..7cb9de97e9 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -8106,7 +8106,10 @@ static int do_futex(CPUState *cpu, bool time64, =
target_ulong uaddr,
>>   #endif
>>       switch (base_op) {
>>       case FUTEX_WAIT:
>> +        val =3D tswap32(val);
>> +        break;
>>       case FUTEX_WAIT_BITSET:
>> +        val3 =3D tswap32(val3);
>>           val =3D tswap32(val);
>>           break;
>=20
> I see why we need to swap the "val" for these operations:
> it is the value that the host kernel will be comparing
> against the in-memory value. It's currently in host
> order but it will be in memory in guest order, so we
> must swap it.
>=20
> But why do we need to swap the bitmask in val3 ? That
> is in host order now and I would have thought the
> host kernel also wants it in host order.

Seems it was a brain-I/O error on my side.
I'll drop that patch.

Thanks!
Helge

