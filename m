Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E74C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpt2H-0002rI-Ux; Fri, 31 Jul 2026 15:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wpt2G-0002pW-56
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:36:48 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wpt2E-0007II-9a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785526598; x=1786131398; i=deller@gmx.de;
 bh=jl2scJfjn5P+FmNmpyO13Qk9+xcQQOLivZZSY2mKe44=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nOWD3s8nlbRXhzZlAUhgK0SOmgSMRw0I2nniuK97DZ/Cb5PyALGJhiE4BdfYeOnX
 O3XbeWn35OZksUT2PjwD3wqHG7OD/bZdqjYEDMy+kuwpgBeykmYhLy/k/ReYabkDu
 qW27ujyzr6ZuKPXGk1K91YYyVOnz5MxLvy0oUTanD+pyrLWfE5CeryXaGCJbrKKDw
 jgLHWYVflIfD9h2ovf1XI+92NiAagWNH2QzwaiXkH4aI3O81w28+n5CJydQywUqJa
 NavC9AUNtVkAcXrzhJ3SY+qcICfK8o2gKYO8azIub5Oz3tRoUtPz6zmNxKgVAbnVb
 nm+CRWNxGSGAoDsx0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1xEBAt1jnV-00ZZiD; Fri, 31
 Jul 2026 21:36:38 +0200
Message-ID: <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
Date: Fri, 31 Jul 2026 21:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:khHClGqzXndj0UAOtBYPw8vAhabg1bgaaxMD+cpkRPsaS8P+b9D
 6SsTn5mTde5tWhID6CbexSjo/MUp9kkv1uT8S6babkfT/hTX5odBh2Rmm3TiJfI2SoF36Vn
 9tAdICRPBrvQWQnZkRFN2M0lWTpe7V3lxESV/3j1oUznW2lBOu62ENflqo6/uap2TE1UzNJ
 GGIz07Mfn4llIOzHIqqeA==
UI-OutboundReport: notjunk:1;M01:P0:uPqGAEYC0eA=;43ky6p3qGCgRt6VJeLsVfGkKPHn
 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
 0gHdUKHus9vF7T8JDxVZWzy2LfNw=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

Hello Peter,

On 7/31/26 20:05, Peter Maydell wrote:
> On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
>> are defined as 64-bit time_t values, since the userspace may access
>> the whole 64-bit value. By this change we fix the word ordering for
>> 32-bit big endian architectures as well.
>>
>> This fixes the msgctl01 LTP testcase on hppa32.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>   linux-user/syscall.c | 30 ++++++++++++------------------
>>   1 file changed, 12 insertions(+), 18 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 740142825d..c93b770ced 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semid,
>>   }
>>   #endif
>=20
> I see this has already gone into git, but some late review
> comments. I suspect this is mostly me being confused rather
> than actual problems.
>=20
>>
>> +#define target_time64_t         abi_ullong
>> +#define target_swap_time64(x)   tswap64(x)
>> +
>>   struct target_msqid_ds
>=20
> Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, used
> only for backwards compatibility and libc5 compiles") or its msqid64_ds?

Yes, it's msqid64_ds.

> The layout matches msqid64_ds, which makes our struct a bit
> confusingly named.

True.
In a follow-up patch this better should be renamed to target_msqid64_ds.

>>   {
>>       struct target_ipc_perm msg_perm;
>> -    abi_ulong msg_stime;
>> -#if TARGET_ABI_BITS =3D=3D 32
>> -    abi_ulong __unused1;
>> -#endif
>> -    abi_ulong msg_rtime;
>> -#if TARGET_ABI_BITS =3D=3D 32
>> -    abi_ulong __unused2;
>> -#endif
>> -    abi_ulong msg_ctime;
>> -#if TARGET_ABI_BITS =3D=3D 32
>> -    abi_ulong __unused3;
>> -#endif
>> +    target_time64_t msg_stime;
>> +    target_time64_t msg_rtime;
>> +    target_time64_t msg_ctime;
>=20
> Assuming msqid64_ds, the kernel version of this struct has a comment:
>   * 64 bit architectures use a 64-bit long time field here, while
>   * 32 bit architectures have a pair of unsigned long values.
>   * On big-endian systems, the lower half is in the wrong place.

Those comments are from the generic header:
include/uapi/asm-generic/msgbuf.h
and I think the last sentence about big-endian systems is wrong, as
most platforms provide an own architecture-specific header file, e.g:
arch/xtensa/include/uapi/asm/msgbuf.h
and the big-endian platforms seem to have their high-word first.

> That would make tswap64() not the right swap for 32-bit big
> endian guests.
 =20
I did my testing on the 32-bit hppa/parisc platform, and with my patch
the results in qemu were correct and were the same as on physical machines=
.

I just tried in a 32-bit powerpc chroot and the msgctl01 now succeeds ther=
e as well.
So, I think my patch is generally ok.

Helge

