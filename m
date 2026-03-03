Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F226EEDEBE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUzm-0003w2-ME; Tue, 03 Mar 2026 14:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vxUzh-0003qO-8u
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:01:23 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vxUze-0003hq-8x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:01:20 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-660a7aa6e44so1357665a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:01:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564474; cv=none;
 d=google.com; s=arc-20240605;
 b=VqquwFG5cs6jYIl5Yb+xybqIDGF9o3KHFvLDlI8/W6lNo36hzUgPKGd1FHI0l/fBRD
 b8hGEn6zIOVGTNEImm01VpJvREnkG+r7kUrsXUGeA6E+kiVuOUU1+FV892U5A2VrjdHE
 w6LmrUoNFmDpFmzriaxiUcgN3QVTdeRIElHmTy+6lxoK2FwKRxRhNdMfSY+O17T7D9A+
 illLUoS254xir3p7dqM+qAn0Ux1sdgpxRyWsXnEr8boMkivQuW5vY5aSvU4kNkymfTiK
 gwLD+gB4eSAFi3GtipwbStmG/+E8+gqo63wrhnYTeAtIZNiIK2QBGObyhIrUPHKM6ojl
 OJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=FzmDDKHlwKvILesXo0IkUmDPoky6k8JaK9nozO+UEkQ=;
 fh=jSTqrr0MboOuNrzsNXwO/c3wDkgXeIFcUuyFKy8BmCQ=;
 b=dAlSMphrs+/b5EbjWdYavgcFbIYzYHjDMPsxpnpljnRjYgShCI6+qneJCOLJzT86kM
 kV6Ffu9F9Fm2jQe9TR20G6ppPbB5NzsQdRBbKyXtrFncmxZQH4paXfDc+2rgwSY057qP
 Et/QBFkp7V3UApEfFEMSMQ7TpWGhSFhmDdA0n61xrDqEaUBif19nUppftU1HvouEWVu0
 +iAnirrYY73ZWloXCgkHuMmQSCJxnxST52xhVmbKe9A1Gcp/xQf2PmPrr3OJKS7cgkw1
 YjF95/ozrIozVyGeqjXfoivHS75lA6ryFL/jqBKiOputa+9Rs3L0R5OCwaVL5PVCw+LY
 Erhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772564474; x=1773169274; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzmDDKHlwKvILesXo0IkUmDPoky6k8JaK9nozO+UEkQ=;
 b=Yb+yrxr62cc1elQ/2Ayuy+YEqRZX/kv+Jw7Lb8s7f8jcZS6dTweFFponxu471ZXfSy
 xSkuKBzpv74UvzVb0vgX5Cfy4ydMVjPHhbDz1Pq5umyu/R3geflkIdS2ydbgMo2kDDJx
 YgSr1fhCdcx5ls7sEYw/AMI5MgKbd2Rflb/stGkrc5c8DuNerRmdiUKiIjz6k60bc4or
 WUVm9NgzIDTUbB7xyfk8kbjBMGJUfntJMJnANoq+DCXW4//3ecTiRt0bxqqaQBoc2wp+
 iM7MF1YdIc1fHtp2exAZYXFY+Eju6fXJFj3QTBAc+TihG12KYPACc1j3cDOm07RNEu2y
 orbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564474; x=1773169274;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FzmDDKHlwKvILesXo0IkUmDPoky6k8JaK9nozO+UEkQ=;
 b=OzKT4wYZFLnmjOOWqwxVo+aGH9zWfCaA/Ii9y7mEf3vT1AQJeunra6XoLHCEs9I7rZ
 H3oOMyxpjkw+P/QAMlw0JxcZkC9QAFkpFJx/4cx9tJLb8+pD4g4B+w1b+Mei8p4AwhjV
 3A5JfzDpScw9K754Hn8nKoPQ9kDZkB0YpdWfIEZoqqokpadXOYFqNlB0y331s9ZXSMWB
 D6XAD7GL2jCcQ9j0cIvhOHUsJJPIZEpEEJEbF/L+ObSXjm+Z8dh7eQXMN82B3ZN5TPFS
 nS4rLP4CFWCoFDkKLPpX36tKYFlo5GbTZ0Gj4K1zaufWM8FPnKNwb90bqcu8wMlJvzS9
 Ev6Q==
X-Gm-Message-State: AOJu0YwEsWB5lNBRjl1i7O5bHbwARPJGj12ErATVFYMCqp6hMEdxny08
 ooks0SFBnxZGjkDS6MAkXLY1KFGAyOKAugJr1DH634uCMDv2fUEW12At2nd61a7iYMnnLEGEVo4
 K6InkZDx8dnQeetWTMbGqtnBB26YcwXGkvb+a
X-Gm-Gg: ATEYQzyF3V2ZOzoyvhW8HkS2A+MYqcdU/vS1STxdkn+FNDreBNdjh4kX8IUFdqSAoo2
 z2UdSqWvk5PXhBz9pvGZlm2UuOqXRmuQogMbr9uYzOkUFWPQTftqMONNYw/e1sMZuZV86hOa3iO
 j4m32x/Ta8qr1h0CJUvBzjCwBnPNUu3IzMCrsiSPkBpjZVgNQHYZWXdEcuMK/pyv8jvipyiMMhG
 nWzs7KoQkCS6zMxPwYXXS/PBBYCsSmau54Z7Hly2MVu3853CldRfl9de1ixaDg+q3MXPKP+okp3
 YIxPBK8SNwfU7Jl/DwvNl7hEbc83VcNehLXyHzGu0O3/zgEHpVM=
X-Received: by 2002:a05:6402:354d:b0:65f:76c9:a78c with SMTP id
 4fb4d7f45d1cf-65fde4c4649mr9230348a12.26.1772564473642; Tue, 03 Mar 2026
 11:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
In-Reply-To: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
From: razvan ghiorghe <razvanghiorghe16@gmail.com>
Date: Tue, 3 Mar 2026 21:01:07 +0200
X-Gm-Features: AaiRm50q0vhb0veVZ1iUE26QIfx4qFfG6wYmmSAXBJQ3WLZpkOtVAglSGH1BCtc
Message-ID: <CAK=UehLPXz9AB2tEqdYEwKH+rUrmxbPeV2W0gDo2rUuwv-X3OA@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Fix mremap() with old_size == 0
To: qemu-devel@nongnu.org, laurent@vivier.eu, razvanghiorghe16@gmail.com
Content-Type: multipart/alternative; boundary="000000000000cb0224064c23533e"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000cb0224064c23533e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I'd like to kindly ping this patch. It has been a few weeks since
submission and I haven't received any feedback yet.
I'm working on getting familiar with the contribution flux. Any review,
even brief comments on the approach would be very helpful!
Thanks in advance,
Razvan

=C3=8En dum., 1 feb. 2026 la 03:08, Razvan Ghiorghe <razvanghiorghe16@gmail=
.com>
a scris:

> When old_size is zero and old_address refers to a shareable mapping,
> mremap() should create a new mapping of the same pages according to the
> mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this cas=
e.
> Previously, QEMU's target_mremap() rejected this valid case with EFAULT
> during
> the initial validation, before checking for the special old_size =3D=3D 0
> behaviour.
>
> This patch adds proper handling for old_size =3D=3D 0:
> - Validates that MREMAP_MAYMOVE flag is set (required by man spec)
> - Passes the call through to the host mremap()
> - Creates a new mapping without invalidating the original, with both
> beeing valid and sharing the same physical memory frames.
>
> Tested with the reproducer from the issue on qemu-riscv64.
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
> Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
> ---
>  linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 4bcfaf7894..b1a84eb60a 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr,
> abi_ulong old_size,
>          errno =3D EINVAL;
>          return -1;
>      }
> +
> +    if (!old_size) {
> +        if (!(flags & MREMAP_MAYMOVE)) {
> +            errno =3D EINVAL;
> +            return -1;
> +        }
> +        mmap_lock();
> +        if (flags & MREMAP_FIXED) {
> +            host_addr =3D mremap(g2h_untagged(old_addr), old_size, new_s=
ize,
> +                             flags, g2h_untagged(new_addr));
> +        } else {
> +            host_addr =3D mremap(g2h_untagged(old_addr), old_size, new_s=
ize,
> +                             flags);
> +        }
> +
> +        if (host_addr =3D=3D MAP_FAILED) {
> +            mmap_unlock();
> +            return -1;
> +        }
> +        new_addr =3D h2g(host_addr);
> +        prot =3D page_get_flags(old_addr);
> +        /*
> +         * For old_size zero, there is nothing to clear at old_addr.
> +         * Only set the flags for the new mapping. They both are valid.
> +         */
> +        page_set_flags(new_addr, new_addr + new_size - 1,
> +                       prot | PAGE_VALID, PAGE_VALID);
> +        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
> +        mmap_unlock();
> +        return new_addr;
> +    }
> +
>      if (!guest_range_valid_untagged(old_addr, old_size)) {
>          errno =3D EFAULT;
>          return -1;
> --
> 2.43.0
>
>

--000000000000cb0224064c23533e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>I&#39;d like to kindly ping this patch. It has been=
 a few weeks since submission and I haven&#39;t received any feedback yet.<=
div>I&#39;m working on getting familiar with the contribution flux. Any rev=
iew, even brief comments on the approach would be very helpful!<br><div>Tha=
nks in advance,=C2=A0</div><div>Razvan</div></div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=C3=
=8En dum., 1 feb. 2026 la 03:08, Razvan Ghiorghe &lt;<a href=3D"mailto:razv=
anghiorghe16@gmail.com">razvanghiorghe16@gmail.com</a>&gt; a scris:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">When old_size is zero a=
nd old_address refers to a shareable mapping,<br>
mremap() should create a new mapping of the same pages according to the<br>
mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this case.=
<br>
Previously, QEMU&#39;s target_mremap() rejected this valid case with EFAULT=
 during<br>
the initial validation, before checking for the special old_size =3D=3D 0 b=
ehaviour.<br>
<br>
This patch adds proper handling for old_size =3D=3D 0:<br>
- Validates that MREMAP_MAYMOVE flag is set (required by man spec)<br>
- Passes the call through to the host mremap()<br>
- Creates a new mapping without invalidating the original, with both<br>
beeing valid and sharing the same physical memory frames.<br>
<br>
Tested with the reproducer from the issue on qemu-riscv64.<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3105" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/3105</a><br>
Signed-off-by: Razvan Ghiorghe &lt;<a href=3D"mailto:razvanghiorghe16@gmail=
.com" target=3D"_blank">razvanghiorghe16@gmail.com</a>&gt;<br>
---<br>
=C2=A0linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 32 insertions(+)<br>
<br>
diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
index 4bcfaf7894..b1a84eb60a 100644<br>
--- a/linux-user/mmap.c<br>
+++ b/linux-user/mmap.c<br>
@@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong=
 old_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (!old_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(flags &amp; MREMAP_MAYMOVE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_lock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; MREMAP_FIXED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_addr =3D mremap(g2h_untagge=
d(old_addr), old_size, new_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags, g2h_untagged(new_addr));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_addr =3D mremap(g2h_untagge=
d(old_addr), old_size, new_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_addr =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_addr =3D h2g(host_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot =3D page_get_flags(old_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For old_size zero, there is nothing to=
 clear at old_addr.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only set the flags for the new mapping=
. They both are valid.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 page_set_flags(new_addr, new_addr + new_size -=
 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0prot | PAGE_VALID, PAGE_VALID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shm_region_rm_complete(new_addr, new_addr + ne=
w_size - 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return new_addr;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!guest_range_valid_untagged(old_addr, old_size)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000cb0224064c23533e--

