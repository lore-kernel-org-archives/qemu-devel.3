Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27378C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSOY-0001J7-QQ; Fri, 23 Feb 2024 05:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSOX-0001In-HK
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:03:05 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSOU-0005UY-Hy
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:03:05 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512bc0e8ce1so141796e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708682580; x=1709287380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u/ZEHHQQJ7TneXWz9Z91knv44YPnLKbvGbn+UTLm+fA=;
 b=my+aI2r8rBzenQVEXWIaQ7lc7qRkG2KSC9HA03hpV2KOxmbUtFRMLDodlmuWvOx5Oc
 8cRcE0vUb3f2MzqS1C7PQU4wASR8uzwNQm80wdOF6qeC4hh383iDyRyKSMJ+Ldm3ERrQ
 lU2lexZSb1bHrPJPltJtEEgIvTHn19JyFHdRJmmO+PlD7ByD0n+GaP+/w0i1UNN0fT/U
 xDX2Db+rzzE4espD5ukd8KVplBIIxqwJ2/qf7dkh0wbuYgj8iiSkuEoj1PAHmO0u28BY
 bt5+Ew5FuLN1i2D9v+PZnds/mLYv5YMRkmTUUy89XENJLhIv20Y/Wx6eIlGo/1ZhXEZD
 eyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708682580; x=1709287380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/ZEHHQQJ7TneXWz9Z91knv44YPnLKbvGbn+UTLm+fA=;
 b=ohTVL9iNEyHLRLWvohMW//NDvZd4wA/i2sDLMQYDph9aaPY9KCEFpc7cudZFKe8MbG
 Icsafr352owLmut0yFj/ahr/dGvYlGvX8TRTtE15F4oh86WayDIEobrRKHWi+7xW7jWq
 ptmiZAm/v0RALni5V/jbbdsnVqSQ12KroeCbe9aO1gGgMRM6KD5zkU1Oe0bvLPBma2nq
 P78tbgVKgv5MonvwEo387SzBBDM9F3PAUen9/bglYpXXIpoy5AO/8lKaJaTqGmScHihN
 ka5ELoUPitXylDbLEp4dzydUWgDmyCEFMqDYPURglDwHuEi4rzuJBL6VLJ52AixMze+/
 qUpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ251fQunmvTCn5+DN9jIrTIcCd+/ut14PMiLIFzhxNGF7udNTnf0fZ6l7yZtyGQJPSEBuwK3ulyxf2D0I4XF8vlz5L2Q=
X-Gm-Message-State: AOJu0YziQXZQFlJ9/SoaHktb/Ku7j5Y8E3QYArV2nIGPvR4zp/AXnwjb
 nvpv2vHin26aEx17vgqAtF7SW3nWNxlpGkFF2f6Cc1cWVMVctnd0cTeQlPRxluDqgYTvpoO7msL
 nFR1p+md8GTLsh/c6xANczR2TqQJQq9oOogHVkA==
X-Google-Smtp-Source: AGHT+IGpTQcrZ/TLTvw8DWN+u0imyHimS8sPPc+GEzTF9iID+v37fJu9yS18AJbResR+Z92UzHJomAiBb8KAqgJbf/E=
X-Received: by 2002:ac2:5b0c:0:b0:512:cbae:4e05 with SMTP id
 v12-20020ac25b0c000000b00512cbae4e05mr1087260lfn.60.1708682579822; Fri, 23
 Feb 2024 02:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
 <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
In-Reply-To: <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 10:02:48 +0000
Message-ID: <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 22 Feb 2024 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/19/24 06:12, Jonathan Cameron wrote:
> > I'm far from confident this handling here is correct. Hence
> > RFC.  In particular not sure on what locks I should hold for this
> > to be even moderately safe.
> >
> > The function already appears to be inconsistent in what it returns
> > as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> > value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> > the previous value.

I think this is a bug in the TCG_OVERSIZED_GUEST handling,
which we've never noticed because you only see that case
on a 32-bit host.

> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2: Thanks Peter for reviewing.
> >   - Handle the address space as in arm_ldq_ptw() - I should have looked
> >     at the code immediately above :(
> >     The result ends up a little more convoluted than I'd like. Could factor
> >     this block of code out perhaps. I'm also not sure on the fault type
> >     that is appropriate here.
> >   - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
> >     likely() doesn't seem appropriate here though.
> >
> > target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 5eb3577bcd..ba1a27ca2b 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
> >       void *host = ptw->out_host;
> >
> >       if (unlikely(!host)) {
> > -        fi->type = ARMFault_UnsuppAtomicUpdate;
> > -        return 0;
> > +        /* Page table in MMIO Memory Region */
> > +        CPUState *cs = env_cpu(env);
> > +        MemTxAttrs attrs = {
> > +            .space = ptw->out_space,
> > +            .secure = arm_space_is_secure(ptw->out_space),
> > +        };
> > +        AddressSpace *as = arm_addressspace(cs, attrs);
> > +        MemTxResult result = MEMTX_OK;
> > +        bool need_lock = !bql_locked();
> > +
> > +        if (need_lock) {
> > +            bql_lock();
> > +        }
> > +        if (ptw->out_be) {
> > +            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
> > +            if (unlikely(result != MEMTX_OK)) {
> > +                fi->type = ARMFault_SyncExternalOnWalk;
> > +                fi->ea = arm_extabort_type(result);
> > +                if (need_lock) {
> > +                    bql_unlock();
> > +                }
> > +                return old_val;
> > +            }
>
> Use BQL_LOCK_GUARD() and avoid all of the repeated unlocks at each return point.

Is the BQL definitely sufficient to ensure atomicity here?
I guess that given that we know it's not backed by host
memory, any other vCPU trying to access the MMIO region
at the same time will have to take the BQL first, so it
seems like it ought to be good enough.

-- PMM

