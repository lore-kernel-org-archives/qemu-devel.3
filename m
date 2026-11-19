Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991C606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHd5bnQX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUABq-0005xG-Op; Thu, 19 Nov 2026 17:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUABS-0005gk-BQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:00:50 -0500
Received: from mail-qv2-x04.google.com ([2607:f8b0:4864:33::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUABQ-00014h-MV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:00:46 -0500
Received: by mail-qv2-x04.google.com with SMTP id
 6a1803df08f44-9211c92e822so2039256d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795125642; cv=none;
 d=google.com; s=arc-20260327;
 b=a6tHopUvWs0o6mf4dNyWgkLUi2157rtjAwlOVs9cxTM4ZbF0tyKR8J0XhMdQj/Kjp2
 LvrMNtlvcQ9d2Mo2kw2LD16tcIoyIsbiECYNz7Epz5O8HkgjGn/Agh9Y1cmUcHFoHCqN
 enX92FTb/rYzh8zZGPy6ByrlgDCKXqLNa9tI4yOIm3cMF3Sk122A5aHENqHSD9Yt2NSp
 8rgNhX+n/eCeVtSbv3K3WHhNLmRh2Wjp2BXscieIcLLvAX6XOkqX/JMQOuJHCi7ebLyb
 us5DvRoSDdDPcxb8HIKFIs8gARZkqfOuyxe5JdZsI6jCIvLuAP01ToIdcWfgvn7H3IJ6
 oADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZwKiCro9TkGp13P67Cwz/4I9tTK9CxH1Xodthy/jFZA=;
 fh=03AmPWFaHef3r0pr6lywoT+NsG/gfH+n4yTbB9xciVM=;
 b=kaRIphhWZcYGq2qOTHhmPD5l8ZI14LUP8vj4leMmOZArecVMCqC9ihenBk8cpjH7gi
 BFp5fENLwgVhgpnZWn/bU8IhXDzMTwk+eB6LEChUziJZWri4Rd7zxWHq4Jsb7g3bZWwC
 9XlXjDnG2jw4sp7OqUJnKQzfBm9y2AD+vb311dBkNhZTWEI//7jTGI2CNX3Fanx/y+vW
 tLs0b7rcqlkt24l34tXJMfN0AqZhQy9VPPqQDD8AeVmOnMCPsMey4feSlILCoTEzCNk+
 dg9livRvnIVR7lknVgTZ3+8sSPnsKEHGWwXCj/FISsgAr2Mv/fbh4eD/esjufTZAWdXs
 1Spg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795125642; x=1795730442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZwKiCro9TkGp13P67Cwz/4I9tTK9CxH1Xodthy/jFZA=;
 b=lHd5bnQXWYmiOCunf8f7bLCVlLg9S6rfVFnlhfPNY5r+8rdfBN30LWhrqo9Qhs1TlA
 dvudlg9URHuEy4ryE9lJ30hgQe2H35XwRIolXzckQNFiLT9IOfnfdepawk2/ZF47pmu4
 3Cr8CdjyA1ytB1Io/KL3j2T4ZZn18+yh3llpwtKqfV57R79KCZA96D65zk4BhCEjMO4t
 Gk3/VxB5Od4TBQoBQ4GBpdCoh0sazXd0UkznkIZQL82qw3E2WfCJkwYe4Wmxw0ThHb5B
 YgXkBD9oQ6QM+WtWZ+/dRDbtp5M/4dBdCyC9TXfI81wa9gdXY+ep+JpERUGO17WlcMVR
 FCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125642; x=1795730442;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZwKiCro9TkGp13P67Cwz/4I9tTK9CxH1Xodthy/jFZA=;
 b=LKbUW5Nr8DwE9vZ3aeBg5ZTrI5NQwA/c+V8SVEfk9PTiwkbR2u0bGnU/MyFXipGf9Q
 YznwCflnY1MA6oClSV4BrS3hX505DVT+TGeB5yfwOCsP93HsLSp6tuNa5LvDF5di0Ds4
 Z1/4EGish4KxaBc3vI3fyoYTibLsRRHg/MPhrZH+y1xjAdMWcoHGYo9eYAS02mTt/aen
 UuFzf4khzPvMh6z1joCawBfBlbmQc9FBMRaKalKygq3Aj8OD3FqvsJ7iSEwm5SCOsHeg
 5HUUBvILVRlKCO6W1x10TcCuuKXyt8pfgjwk/oEVo24+4ZTh4rv8r6IXelS8SAvU3mvv
 nyow==
X-Gm-Message-State: APuU4Z81C1vYI6fgizWEk3G9ZBViZsuscxbyFEUbzLtxMJpxOUHTn59M
 rKKS0QORL/r0C2IoRrS0YXBVk8SaAVTF5kVwwy73doE33IHEjrs3da2o4uqoCmkJPDWcoILBBZv
 joMVnUTF48NDeVEwKiMR4mtpI5n5zzkc=
X-Gm-Gg: AZFdTZfqg4hdV3mNL+0zdD/cGJtnDhAH1gCIyBj6VvzCRo5XLGelg95b4czh395ebIo
 lgGf4iJAp+K8ZSsEt1/PTUIcHXF6BWID50b3xZPmpi8h1UDcZYW/ze6wl/aYwY7WFSzo90Siss9
 /hA0B2Peh163tH/r1TWTOjelPPBI1p6eAO3WP++y0BDiv51Z1jUTVh35ZRifl9e4lIV/kxQIMgQ
 GkQs95UVqITomL5Gn+vSgLa3ASJEn7jmAygchbEufCqmLTIRdLXHDe76fkcm4XQc4w4HFI4ZtXd
 GtaAtghY2Zk25p2uTXsnHXoB/sBrqW3IF8akEhqf+c85c5EM2A6xJZUhqkXwUQeisnoMs0aDWZm
 mWiYxrZRTlZBu41LRzLpPUUBkljEQZ06aAdCO6W59RPcX67axAMF8lcB8g7CTeqpQcH3fBP7ESo
 ffzPjyFQsV5H/mzw==
X-Received: by 2002:a05:6214:d8a:b0:917:a253:4f8f with SMTP id
 6a1803df08f44-92134a960c2mr17740996d6.40.1795125642220; Thu, 19 Nov 2026
 14:00:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110130108.706228-1-mdspan.github@gmail.com>
 <20261110130108.706228-4-mdspan.github@gmail.com>
 <4a2dd42c-fe8e-46ad-a74c-bae94d088be8@linaro.org>
In-Reply-To: <4a2dd42c-fe8e-46ad-a74c-bae94d088be8@linaro.org>
From: mdspan <mdspan.github@gmail.com>
Date: Thu, 19 Nov 2026 16:00:29 -0600
X-Gm-Features: Aa3M54rw4R3uzxMlVvqhGHdj-T7A5nHkmWnpYWD4Y3SzLL9GHwBOt8wLTmDQHbs
Message-ID: <CALU8FV9cTiAwrF0QGzLMS+1aTGB+1=FemHf93wOZK_O-DGNOkw@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/i386: emulate LAM in TCG
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:33::4;
 envelope-from=mdspan.github@gmail.com; helo=mail-qv2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, I'll do that in v2. Separate fetch indexes, returned by
x86_cpu_mmu_index() when ifetch is true, so that fetch and data
entries for a tagged page aren't sharing a TLB.

Tim

On Fri, Nov 13, 2026 at 12:12=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/10/26 06:01, Tim wrote:
> > @@ -581,15 +581,35 @@ static bool get_physical_address(CPUX86State *env=
, vaddr addr,
> >           }
> >
> >           if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
> > +            int lam_prot_mask =3D 0;
> > +
> >               in.cr3 =3D env->cr[3];
> >               in.mmu_idx =3D mmu_idx;
> >               in.ptw_idx =3D use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX=
;
> >               in.pg_mode =3D get_pg_mode(env);
> >
> >               if (in.pg_mode & PG_MODE_LMA) {
> > -                /* test virtual address sign extension */
> > +                vaddr masked =3D x86_lam_mask_addr(env, addr);
> >                   int shift =3D in.pg_mode & PG_MODE_LA57 ? 56 : 47;
> > -                int64_t sext =3D (int64_t)addr >> shift;
> > +                int64_t sext;
> > +
> > +                /*
> > +                 * LAM masks data addresses but not fetches.  Both ins=
tall
> > +                 * the entry under the unmasked address, so if masking
> > +                 * changes it, keep only the permissions of this acces=
s.
> > +                 */
> > +                if (masked !=3D addr) {
> > +                    if (access_type =3D=3D MMU_INST_FETCH) {
> > +                        lam_prot_mask =3D PAGE_READ | PAGE_WRITE;
> > +                    } else {
> > +                        lam_prot_mask =3D PAGE_EXEC;
> > +                        addr =3D masked;
> > +                        in.addr =3D addr;
> > +                    }
> > +                }
> > +
> > +                /* test virtual address sign extension */
> > +                sext =3D (int64_t)addr >> shift;
> >                   if (sext !=3D 0 && sext !=3D -1) {
> >                       *err =3D (TranslateFault){
> >                           .exception_index =3D EXCP0D_GPF,
> > @@ -599,7 +619,11 @@ static bool get_physical_address(CPUX86State *env,=
 vaddr addr,
> >                       return false;
> >                   }
> >               }
> > -            return mmu_translate(env, &in, out, err, ra);
> > +            if (!mmu_translate(env, &in, out, err, ra)) {
> > +                return false;
> > +            }
> > +            out->prot &=3D ~lam_prot_mask;
> > +            return true;
> >           }
>
> Swapping translations between read and execute isn't fantastic.  You may
> get away with it for the most part because rip-relative data is not
> generally stored on the same page as code.
>
> Better would be to split the mmu_index in two: one for execute, one for
> read/write.
>
>
> r~

