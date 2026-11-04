Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9B606D801
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A7U7l6XE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZRs-0007ir-S0; Wed, 04 Nov 2026 06:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOZRq-0007iM-8Q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:46:34 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOZRn-00060U-W3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:46:34 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b30cbfa628so7540467b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793792790; cv=none;
 d=google.com; s=arc-20260327;
 b=PaaQmHIOMM7Dpi4q+t8pJLMCDsWPaMzr/R0usS1KO0WtQ9Z7RthA8r89cHwkyPo1UP
 QwtpYOwzddmc6rt+iTIiMe0jkyW8eHVHMIb5jKXNCJuiT4Jjt8Mjk2YoN3ZoKoeA8Yr0
 ezYW/3dcQJl7Adf7w+w69Io2R5yalleU2TGcnpSR8wPLDfOk3EyJko0Hc4w/VzDKp5en
 ccsDxPLZFitVMMEI8TANMqI4Y6QlFGUNbr060CaMR+hxO0GOUX96rBML0gC9YFpyPWWG
 MQmkar5jSI1vQJGuyi4ZdSNDA5moV4QWxjITfVD6RTuPykUzbCmSTkQR9U5vPQmNAwPp
 Pc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P4eIlVuBHovOSrLBo7rT9t0h4KV+Iz9yeUZVpQ1InEk=;
 fh=UGEyHwbgtx9wI7iyRsbmM29CIUHb5CctSz+Iw/tGsmk=;
 b=mVQ6h1+iYWZM0Tm/wb4S4cSMluT27fyrZsHIRYSJPb1/gvnYiKqUzL2ZOjFmDZLOf6
 WdbpGqr71AgKj6lVeIbuSpcXsvxi24j593RDRSBcXOKzwNlDgc/BCkmN9+awvWYGvdiq
 4kMj3groD3ngGRRhqCjqiBg6Lx40vYY6FGoZWUqQb8IAtuD9QsxHTIxs2x+zov+GdUz3
 dm88/+SqtbCT4sVYhu9pGpdQiHy4mp7L84RZvpOX/AJY4ItR+TgAtpkWbiXc6wFk6Q86
 g5xG4ybU09WgY97h6ajIEYxvhcwOmQR16+uxAY3uG4+QQnM9s9zOjrES6X/G6rCElSQy
 0s1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793792790; x=1794397590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P4eIlVuBHovOSrLBo7rT9t0h4KV+Iz9yeUZVpQ1InEk=;
 b=A7U7l6XEr/s5QBTs76XaVPpGjEkj5+KfGAwZ/2WvsVKMV/hP5sGSoC4Fchebm6kPps
 TiRpGk49o9xa+0OWkUYJWLJMPO1CzqM6YKSgxSYTnmnLVbfM4BIUDscdZTdmB0imlvYZ
 S3vMx6Jjx6JdHG+T1km1xnO9Lr5X9vQWHTKcFQEAeUdkz7h+hzPNVPXawiL0p+HaRkde
 rs4Df5Dw/rGqMwaLTUI7AExkR6Rtqu8yalIq0LQsOiVKzHnErsRe0TVMzevWS5h0x98W
 sCNS2TsVVmkmDoVapU00oPLCQrIATg+UEVc9Q2ZXtnh2kT9hsTjWF0MX0XnOKELWPOb1
 iBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793792790; x=1794397590;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P4eIlVuBHovOSrLBo7rT9t0h4KV+Iz9yeUZVpQ1InEk=;
 b=HuB4kYa6VN8WgZHaj3xa4avzj9VfZN6Tli2+Kp1I3euxQazdoMChjXTF5/HadFKbkp
 n0prvA5jt7xihd4/g2wTDExSHeNO8w+ZJTKhr37qEIlxzyVxMoT6i9sOVWM5YOmshZ8v
 WusOZCs8idQ9n6Pvca7oW9k2xselF+dMaPKsE2yWmbpkABK7KwLHWtt9Es8xT+39XhKF
 R/e44eAFbxOcuiRQu4ZHwWTy4ZRm5vq8aBuBmfOlDWtEYlxVfec0NY/sbB/K44LQaTD0
 ykDS+oJdvJ4Lbacx3gzhpqnNfX4UQs+W7jmjumaBvFTVbE7cAjvUjDn4zEzUxjj6sUKM
 4xag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwslGwWGYGvl1K69Ax23t2kjSzdScubxtvN5laeJSYxFSPmDh0DOQEvHDUgiMeSqN2V+KHp8eaDWsXO@nongnu.org
X-Gm-Message-State: APuU4Z+F32IZPqUDH2U0b8IV2zZ0NcbwA+dR3RZ0sUg4hpYX/cfEAROm
 3ddrp3qHBxhVfG0ezvanVGQR/8E+6VWzksUTiC2Y8dHVApYxPlzLPUBlx5L3FDxJogN6r7RG4vn
 HFqUFLxhD0CK3OrcWQnOp3E/jcTI5Vmx+5mT5IZwPpQ==
X-Gm-Gg: AYBFou1lEvfJExdGz1krkmUWip+FyFaK4LNcH6ZNnCSWoiHhMqXvNTvoYaHt45zfzsY
 Cl3JgEjLWTXoBX562ZgXnmrV/ngAxvj3hwBOfryh5q4uMZxmXp+8nPUvkidN1EO0ZvZ/td+2FcJ
 OtEp56qMxVMueTEAfWP69owuqVosffdgKREMoygG4wjmIcmnD53M+QHzHYd981GPSgDJ1EyT28O
 CLDjm9plgMnzuXVO5vBVCGqJomTcLGFq0jU06ahAAxIvVu0Ro6IiEFmDnoKCKJaP4/L9x7/q/qB
 HlLkKLImRFzRB7DmduPVYq9FP9uPbkHjbiI9NWr8lLbvProo7RVA3Isac2wepQsHjb3l22+M3M9
 2P8BJWGd3lgH+yws3WaNmwHAjYdRdgW0O6pzhZ8jPDYrBLPFp8fSD94jCMIK2Cjij58Hcu8HI5c
 0gLhXdxNc/B4NO9yTYOMCt
X-Received: by 2002:a05:690c:c504:b0:8b3:416:b198 with SMTP id
 00721157ae682-8b30416bbd2mr23959677b3.21.1793792790310; Wed, 04 Nov 2026
 03:46:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-5-peter.maydell@linaro.org>
 <CAFEAcA8X1ARhpncsz=kE2JxFjALGej4ycw3hus=m5kfcVSJXYw@mail.gmail.com>
 <50dcaa06-1f02-4662-8c4f-9ce2ab5e923a@oss.qualcomm.com>
In-Reply-To: <50dcaa06-1f02-4662-8c4f-9ce2ab5e923a@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2026 11:46:18 +0000
X-Gm-Features: AclHuK8qJ9UJJ0mrVCsU77qe1QRotl2CAl-ovmdTmEhHs0EbTGEYZUBgem4bwEs
Message-ID: <CAFEAcA823iF+bJGd64VJ8oJYsWf1tTthrifWea3ECRS4tx9cGg@mail.gmail.com>
Subject: Re: [PATCH for-11.2 4/4] hw/intc/arm_gicv5: Use correct type for
 value in lpi_cache_get_hppi()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 11:24, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/11/26 18:49, Peter Maydell wrote:
> > On Tue, 3 Nov 2026 at 17:26, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >>
> >> lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
> >> to iterate over the LPI cache hashtable.  This hash table has keys
> >> which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
> >> value, allocated as "hashvalue =3D g_new(uint32_t, 1)".
> >>
> >> The function is passed the key and value as type 'gpointer' and has
> >> to cast them to the real types itself, but it incorrectly casts the
> >> value pointer to a uint64_t*.  This works on little-endian hosts
> >> (since we only read specific fields of the L2 ISTE using bitmasking),
> >> but won't work on big-endian, and trips the clang sanitizer.
> >>
> >> Fix the pointer type.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >>   hw/intc/arm_gicv5.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> >> index fd6456cd8aa..a362349e5ed 100644
> >> --- a/hw/intc/arm_gicv5.c
> >> +++ b/hw/intc/arm_gicv5.c
> >> @@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
> >>   static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointe=
r user_data)
> >>   {
> >>       uint64_t id =3D GPOINTER_TO_INT(key);
> >> -    uint64_t l2_iste =3D *(uint64_t *)value;
> >> +    uint64_t l2_iste =3D *(uint32_t *)value;
> >>       uint32_t prio, iaffid;
> >>       GetHPPIUserData *ud =3D user_data;
> >
> > Looking at this again we could also make the local variable
> > be uint32_t; but getting the type wrong on that doesn't matter.
>
> Should we use GUINT_TO_POINTER() when inserting in put_l2_iste()
> and recover here with GPOINTER_TO_UINT()?

You mean change the type of the hashtable value from "it's a pointer
to a uint32_t that was allocated" to "it's actually the value" ?
We could do that; we'd need to update L2_ISTE_Handle to always have
the actual l2_iste word and not the "maybe we have a pointer to it",
and put_l2_iste() would need to update the hashtable entry always
rather than only when the pending bit changes and we add/remove
an entry. But it would save us that allocate and free of a uint32_t.

The potential downside is that if we ever decided we wanted to use
the architectural IMPDEF option to put implementation-specific
metadata into the L2 ISTE we'd have to reverse that. (See spec
section 4.7.4 -- the ISTE is 4 bytes with no impdef metadata, but
if we wanted metadata then it would get bigger and no longer fit
as a GUINT_TO_POINTER().) But I don't really think it likely we'll
want to go down that route -- in the virtualization parts of the
spec there's scope and intention that the implementation puts metadata
into various in-guest-memory data structures, but for QEMU it's much
easier to put those in host memory instead,  and that's what I did.

I have a feeling that when I wrote this code I was partly under the
incorrect impression that L2_ISTE words were 64 bits (e.g. there's a
comment in get_l2_iste that mentions "the uint64_t pointed to"), and
while I fixed most of that confusion before eventually posting the
original GICv5 patchset, I left the "we have to allocate memory for
the value" part in, not noticing it wasn't really necessary any more.

For 11.2 I think we should stick with the simple fixup of the
type mixup here, though.

thanks
-- PMM

