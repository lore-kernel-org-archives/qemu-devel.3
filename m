Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138CC55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 21:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqHQC-0002u8-G0; Sat, 01 Aug 2026 17:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wqHQ8-0002tn-Ms
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 17:39:04 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wqHQ6-00006I-MA
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 17:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785620338; x=1786225138; i=deller@gmx.de;
 bh=3lPcTbPyXYbo2ENaLq9qpJU9C8eWA36qwwfnrssFwZI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fGfIAqEGXRk00+NtDdv7fP1RIcMQdZuhrNnn/AmsKi19jwgC0S3d2bzgR+Q/yxk3
 fHF5l8Z1NR4+aUwbM1PfVS0roI9gfcpqHINn/sqkfQvVZXbr+NbgnJfRCGPv0ngQe
 C4iyMcHGHom2sF/JtB39EMnXs9/RCbXmhmKEQqed72tlnUTiNhgUIr60dDe/4qqz3
 TsI2fN3ZdfdHEm5Q/FJNBs63Uv+VyV0KrN7DF3nnNpO0Doq5SaUhvZfcjSJB1kTG+
 xHkyaS1dCmcsfsjwmY6kkVqWdxTzMQYhsD1gXspdOETdvFV8Y597sZoDy3QPTpe6u
 iL5Uexv5LadfCmDgkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1xHu3i0Z0m-00oCFK; Sat, 01
 Aug 2026 23:38:58 +0200
Message-ID: <89e75011-61fb-4cbc-9583-4117005e58dc@gmx.de>
Date: Sat, 1 Aug 2026 23:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
From: Helge Deller <deller@gmx.de>
To: Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+Tgw3VvLCbOkg8q4NyP9X8hlfMktC5OE83Q24G6NSTy5ztjnlO
 GWXx+I4sWZZQSg3JWGDpDGQRga6jofoNmQea7mGnD4a1y022oq5tjiNQbLKkm5iBSTWrFZ7
 TJjJRVYaCdeR6x2ARcTOd8yTHeUYCnFxGzAdQbyfAHikcVFC/KTWL6lttnhA2oKCFg8uYA8
 0l/IPe16i0905XTffcpfw==
UI-OutboundReport: notjunk:1;M01:P0:9+fXXqbz8/o=;d1mfUyeAK0/Bkb3zuGZfKca4bMf
 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
 xIBsJCL8va1PusRZs0eeCXNhH35E=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

(Adding Geert as kernel m68k maintainer)

On 8/1/26 22:58, Helge Deller wrote:
> On 8/1/26 14:11, Peter Maydell wrote:
>> On Fri, 31 Jul 2026 at 20:36, Helge Deller <deller@gmx.de> wrote:
>>>
>>> Hello Peter,
>>>
>>> On 7/31/26 20:05, Peter Maydell wrote:
>>>> On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
>>>>>
>>>>> From: Helge Deller <deller@gmx.de>
>>>>>
>>>>> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
>>>>> are defined as 64-bit time_t values, since the userspace may access
>>>>> the whole 64-bit value. By this change we fix the word ordering for
>>>>> 32-bit big endian architectures as well.
>>>>>
>>>>> This fixes the msgctl01 LTP testcase on hppa32.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>> ---
>>>>> =C2=A0=C2=A0 linux-user/syscall.c | 30 ++++++++++++-----------------=
-
>>>>> =C2=A0=C2=A0 1 file changed, 12 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>>> index 740142825d..c93b770ced 100644
>>>>> --- a/linux-user/syscall.c
>>>>> +++ b/linux-user/syscall.c
>>>>> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int sem=
id,
>>>>> =C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 #endif
>>>>
>>>> I see this has already gone into git, but some late review
>>>> comments. I suspect this is mostly me being confused rather
>>>> than actual problems.
>>>>
>>>>>
>>>>> +#define target_time64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 abi_ullong
>>>>> +#define target_swap_time64(x)=C2=A0=C2=A0 tswap64(x)
>>>>> +
>>>>> =C2=A0=C2=A0 struct target_msqid_ds
>>>>
>>>> Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, use=
d
>>>> only for backwards compatibility and libc5 compiles") or its msqid64_=
ds?
>>>
>>> Yes, it's msqid64_ds.
>>>
>>>> The layout matches msqid64_ds, which makes our struct a bit
>>>> confusingly named.
>>>
>>> True.
>>> In a follow-up patch this better should be renamed to target_msqid64_d=
s.
>>>
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct target_ipc_perm msg_perm=
;
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_stime;
>>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong __unused1;
>>>>> -#endif
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_rtime;
>>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong __unused2;
>>>>> -#endif
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_ctime;
>>>>> -#if TARGET_ABI_BITS =3D=3D 32
>>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong __unused3;
>>>>> -#endif
>>>>> +=C2=A0=C2=A0=C2=A0 target_time64_t msg_stime;
>>>>> +=C2=A0=C2=A0=C2=A0 target_time64_t msg_rtime;
>>>>> +=C2=A0=C2=A0=C2=A0 target_time64_t msg_ctime;
>>>>
>>>> Assuming msqid64_ds, the kernel version of this struct has a comment:
>>>> =C2=A0=C2=A0 * 64 bit architectures use a 64-bit long time field here=
, while
>>>> =C2=A0=C2=A0 * 32 bit architectures have a pair of unsigned long valu=
es.
>>>> =C2=A0=C2=A0 * On big-endian systems, the lower half is in the wrong =
place.
>>>
>>> Those comments are from the generic header:
>>> include/uapi/asm-generic/msgbuf.h
>>> and I think the last sentence about big-endian systems is wrong, as
>>> most platforms provide an own architecture-specific header file, e.g:
>>> arch/xtensa/include/uapi/asm/msgbuf.h
>>> and the big-endian platforms seem to have their high-word first.
>>
>> The comment is correct for any bigendian 32-bit system that
>> uses the kernel's asm-generic structure. Maybe there just aren't
>> any of those that we care about?
>=20
> m68k could be a problem.
> The other big-arches seem to be handled correctly by the kernel:
> arch/sparc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/parisc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/xtensa/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/x86/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/powerpc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
>=20
>>>> That would make tswap64() not the right swap for 32-bit big
>>>> endian guests.
>>>
>>> I did my testing on the 32-bit hppa/parisc platform, and with my patch
>>> the results in qemu were correct and were the same as on physical mach=
ines.
>>>
>>> I just tried in a 32-bit powerpc chroot and the msgctl01 now succeeds =
there as well.
>>> So, I think my patch is generally ok.
>>
>> Yeah, 32-bit powerpc also provides its own structure definition.
>>
>> I think it's worth having a comment about this, at least, because
>> otherwise the obvious assumption is that our struct which has
>> no target-specific ifdefs is supposed to match the kernel's
>> asm-generic struct.
>=20
> Yes, I will the testing on m68k, afterwards I can come up with a proposa=
l.
> Maybe it makes sense to modify the kernel comment too....


The msgctl01 testcase from LTP gives this preprocessed code on m68k:
...
# 27 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 3 4
struct msqid_ds
{

# 1 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid64_ds_helper.h" 1 =
3 4
# 20 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid64_ds_helper.h" 3=
 4
   struct ipc_perm msg_perm;
   __time64_t msg_stime;
   __time64_t msg_rtime;
   __time64_t msg_ctime;
   __syscall_ulong_t __msg_cbytes;
   msgqnum_t msg_qnum;
   msglen_t msg_qbytes;
   __pid_t msg_lspid;
   __pid_t msg_lrpid;
   unsigned long int __glibc_reserved4;
   unsigned long int __glibc_reserved5;
# 31 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 2 3 4
# 53 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 3 4
};

but the testcase fails with:
msgctl01.c:53: TFAIL: msg_ctime =3D 6a6e65d900000000, expected 6a6e65d9

So, for m68k either the glibc or the kernel is wrong.
At least they don't agree with each other.

I think it would be beneficial, if the m68k kernel would follow m68k's
glibc implementation of msqid64_ds.

Helge


