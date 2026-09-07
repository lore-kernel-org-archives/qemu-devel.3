Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D53C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WKp-0004zA-G6; Mon, 07 Sep 2026 06:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x3WKn-0004ye-AY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:12:17 -0400
Received: from va-2-36.ptr.blmpb.com ([209.127.231.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x3WKh-0000c5-Ft
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1788775913;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cX13N075+JOZRjEQY7TTYD2+uWHRYC6kdSkZtODJFyE=;
 b=PyDGH1yXsTOvuyOeJhUOr0peEBmNRyb9HYBGGgukCtjGvp8UDn4i5CysYYB0LNPmpvbZkY
 XW0xiiJ7fxQu1DD0/+DS/jhEFv3Klcz54gjwJgzRB8MI33jsvwK7+plHfJVOxJt+vanVXv
 bQ+7dZwExUi3iPUpkZnQM9gYJwuidGBvqtvAUBEjZGAn4U/NrIKAZ/P1zV+BLqPeHBpKk0
 zn+fcPfF79xR6IuOK/YmbtenvR8suNz0qFSRPw/rNodErwk+B+rV14l2ajUspznkjNS3/Q
 8y59XF9GtNLsMgMUkfwCdHK8a23G3iIogtRn1zIFKeUDnLRiDi42qqVUt7X7zQ==
Message-Id: <9d125a95-0fa1-4ea8-a8a6-4869afc629bc@lanxincomputing.com>
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Mime-Version: 1.0
In-Reply-To: <aprI8xQIDCRTJOV1@x1.local>
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
 <aoxiBB2Wn8NiL5s6@x1.local>
 <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
 <aprI8xQIDCRTJOV1@x1.local>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Mon, 07 Sep 2026 18:11:50 +0800
Cc: "Richard Henderson" <richard.henderson@linaro.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, <mst@redhat.com>, 
 <pbonzini@redhat.com>, <philmd@mailo.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Date: Mon, 7 Sep 2026 18:11:48 +0800
X-Lms-Return-Path: <lba+26a9e8de7+0a9d37+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: "Peter Xu" <peterx@redhat.com>
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
Received-SPF: pass client-ip=209.127.231.36;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-36.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/2026 9:34 PM, Peter Xu wrote:
> On Tue, Sep 01, 2026 at 10:44:13AM +0800, BillXiang wrote:
>> On 8/24/2026 11:23 PM, Peter Xu wrote:
>>> On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
>>>> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. Do
>>>> you think it would be better to make the load/store_atomic* public?
>>>
>>> They do not fit by default, as we need to still process unaligned cases=
?
>>
>> You mentioned the use of guest CPU context in [1]. However, what I meant
>> by load/store_atomic* is code like the following:
>>
>> static inline uint16_t load_atomic2(void *pv)
>> {
>>       uint16_t *p =3D __builtin_assume_aligned(pv, 2);
>>       return qatomic_read(p);
>> }
>>
>> static inline void store_atomic2(void *pv, uint16_t val)
>> {
>>       uint16_t *p =3D __builtin_assume_aligned(pv, 2);
>>       qatomic_set(p, val);
>> }
>>
>> I consider these to be generic atomic load/store primitives.
>=20
> __builtin_assume_aligned() tells the compiler the address is aligned.  Wh=
at
> if it is not?

When using __builtin_assume_aligned, the compiler will generate=20
unaligned load/store instructions if the data is not aligned, rather=20
than emitting byte=E2=80=91by=E2=80=91byte code, which may cause errors on =
processors=20
that do not support unaligned accesses. That's what I mean: callers must=20
ensure @addr is naturally aligned to the access size.

>=20
>>
>>>
>>> I wished we can use qemu_mem_move() directly that just got introduced..=
 but
>>> it does slightly more than wanted.  Maybe something like this?  Below d=
iff
>>> dropped ldsw_he_p() alone the way as it's never used.
>>>
>>> Thanks,
>>>
>>> =3D=3D=3D8<=3D=3D=3D
>>>
>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>> index 387d65c0b0..04a0f63612 100644
>>> --- a/include/qemu/bswap.h
>>> +++ b/include/qemu/bswap.h
>>> @@ -1,6 +1,7 @@
>>>    #ifndef BSWAP_H
>>>    #define BSWAP_H
>>>   =20
>>> +#include "qemu/atomic.h"
>>>    #include "qemu/target-info.h"
>>>    #include "exec/memop.h"
>>>   =20
>>> @@ -238,62 +239,52 @@ static inline void stb_p(void *ptr, uint8_t v)
>>>        *(uint8_t *)ptr =3D v;
>>>    }
>>>   =20
>>> -/*
>>> - * Any compiler worth its salt will turn these memcpy into native unal=
igned
>>> - * operations.  Thus we don't need to play games with packed attribute=
s, or
>>> - * inline byte-by-byte stores.
>>> - * Some compilation environments (eg some fortify-source implementatio=
ns)
>>> - * may intercept memcpy() in a way that defeats the compiler optimizat=
ion,
>>> - * though, so we use __builtin_memcpy() to give ourselves the best cha=
nce
>>> - * of good performance.
>>> - */
>>> -
>>> -static inline int lduw_he_p(const void *ptr)
>>> -{
>>> -    uint16_t r;
>>> -    __builtin_memcpy(&r, ptr, sizeof(r));
>>> -    return r;
>>> -}
>>> -
>>> -static inline int ldsw_he_p(const void *ptr)
>>> -{
>>> -    int16_t r;
>>> -    __builtin_memcpy(&r, ptr, sizeof(r));
>>> -    return r;
>>> -}
>>> +#define  LD_HE_P(type, size)                                \
>>> +    static inline type                                      \
>>> +    glue(glue(ld, size), _he_p)(const void *ptr)            \
>>> +    {                                                       \
>>> +        type v;                                             \
>>> +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
>>> +            __builtin_memcpy(&v, ptr, sizeof(v));           \
>>> +        } else {                                            \
>>> +            v =3D qatomic_read((type *)ptr);                  \
>>> +        }                                                   \
>>> +        return v;                                           \
>>> +    }
>>>   =20
>>> -static inline void stw_he_p(void *ptr, uint16_t v)
>>> -{
>>> -    __builtin_memcpy(ptr, &v, sizeof(v));
>>> -}
>>> +#define  ST_HE_P(type, size)                                \
>>> +    static inline void                                      \
>>> +    glue(glue(st, size), _he_p)(void *ptr, type v)          \
>>> +    {                                                       \
>>> +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
>>> +            __builtin_memcpy(ptr, &v, sizeof(v));           \
>>> +        } else {                                            \
>>> +            qatomic_set((type *)ptr, v);                    \
>>> +        }                                                   \
>>> +    }
>>>   =20
>>> -static inline void st24_he_p(void *ptr, uint32_t v)
>>> -{
>>> -    __builtin_memcpy(ptr, &v, 3);
>>> -}
>>> +LD_HE_P(uint16_t, 16)
>>> +LD_HE_P(uint32_t, 32)
>>> +LD_HE_P(uint64_t, 64)
>>> +ST_HE_P(uint16_t, 16)
>>> +ST_HE_P(uint32_t, 32)
>>> +ST_HE_P(uint64_t, 64)
>>>   =20
>>> -static inline int ldl_he_p(const void *ptr)
>>> -{
>>> -    int32_t r;
>>> -    __builtin_memcpy(&r, ptr, sizeof(r));
>>> -    return r;
>>> -}
>>> +#undef LD_HE_P
>>> +#undef ST_HE_P
>>> +#undef ADDR_ALIGNED
>>>   =20
>>> -static inline void stl_he_p(void *ptr, uint32_t v)
>>> -{
>>> -    __builtin_memcpy(ptr, &v, sizeof(v));
>>> -}
>>> +#define  lduw_he_p  ld16_he_p
>>> +#define  ldl_he_p  ld32_he_p
>>> +#define  ldq_he_p  ld64_he_p
>>>   =20
>>> -static inline uint64_t ldq_he_p(const void *ptr)
>>> -{
>>> -    uint64_t r;
>>> -    __builtin_memcpy(&r, ptr, sizeof(r));
>>> -    return r;
>>> -}
>>> +#define  stw_he_p  st16_he_p
>>> +#define  stl_he_p  st32_he_p
>>> +#define  stq_he_p  st64_he_p
>>>   =20
>>> -static inline void stq_he_p(void *ptr, uint64_t v)
>>> +static inline void st24_he_p(void *ptr, uint32_t v)
>>>    {
>>> -    __builtin_memcpy(ptr, &v, sizeof(v));
>>> +    __builtin_memcpy(ptr, &v, 3);
>>>    }
>>>   =20
>>>    static inline int lduw_le_p(const void *ptr)
>>
>> IMO, your change serves as a good optimization for the original
>> load/store by taking advantage of alignment. However, the real issue I'm
>> trying to address is the atomicity of these operations=E2=80=94for use c=
ases
>> like avail_idx in virtio, and this should not limited to virtio alone. I
>> still believe we should provide explicit atomic load/store interfaces
>> for callers, rather than relying solely on aligned load/store. And I
>> admit it was my mistake to use the aligned versions here in the first
>> place. I'll send another version later and look forward to more feedback=
.
>=20
> Explicit atomic load/store maybe still make sense somewhere as API, but I
> think Peter Maydell also raised that this exact failure may not be the on=
ly
> one.

I agree with that. Perhaps we should systematically find all relevant=20
places and switch to explicit atomic load/store in the future.

>=20
> IMHO we could directly switch to aligned access automatically when it can=
,
> the only concern is we add one more test instruction in this path, but I
> expect it always hit the aligned case.  Also I expect callers of these ho=
st
> endian APIs to not loop over a range of addr.  So irrelevant of whether
> above change would make sense, we want to study more on the impact of the
> extra if on the callers.  The hope is it is minimum impact and in case
> there're corner cases we can switch to other API even if existed.

I used your latest code [1] to test virtio=E2=80=91net with =E2=80=9Ciperf3=
 -u -l 64=E2=80=9D on=20
my RISC=E2=80=91V server, and found that the extra conditional check has=20
negligible impact.

>=20
> Thanks,
>=20
>>
>> Thanks,
>>
>> --
>> BillXiang
>>
>> [1] https://lore.kernel.org/qemu-devel/apW0SkNxWPCyvVV6@x1.local/
>>
>=20

Thanks,

--
BillXiang

[1] https://lore.kernel.org/qemu-devel/aoxiBB2Wn8NiL5s6@x1.local/

