Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13124C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVQI-0008OR-UR; Mon, 26 Feb 2024 02:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1reVQG-0008OA-La
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:29:12 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1reVQE-0002Y2-Cs
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:29:12 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a43488745bcso86603466b.3
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1708932547; x=1709537347;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBZDSQ1BO3HUUo2QQg7SKTxZLC25UHMFYLwsY/UVCpM=;
 b=SpiyyN9SWiwkFpK420l7aClC1VhuwGR9x8pC7PD4OEEvVCyNlMDNDejV3pTcQKh9cA
 Fxr8uDFmJ5JI8/LNG06UHtBerTJSaYJIeTxOYdrPGgxZYoBlv/5WaH6us2zkyKxkemVD
 H45nO9veKgboqQX6ydkAbPovRQ1iTbqSJsIujNaw8Y9EQ+6ZIbMgbGAbU5VnfycytHUF
 mKiSV+03fn6lJrRYzK7N9ZQEEgsF66cd9nMaah9X3cFNicVd3CJnID8J/OoB1i/NoDsV
 2WfcSL1MQuu4bAhA35e3ZoOZu77Wbz9pn+mEdNfUGgO8wJdT2bKVm22vEHyr2GR6sW3g
 0Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708932547; x=1709537347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBZDSQ1BO3HUUo2QQg7SKTxZLC25UHMFYLwsY/UVCpM=;
 b=A4/GwCfcsLVjJMUkeQqA3ixqKcNdiVTOOeP4rai+vyflr05ZWoVRIokm1IEiHhEpbt
 RGV9Bs4RLUygjxa4f4XoncCPm/zGA98GMTPkpDe0VdmG+MfWVopBmkjzIcaKlWV4quFn
 q3+klVThY9owKtULIdxP1z0sZnPBXdSyI7Mi6i9p5Mh2I+V7TnyEASEeZGzybUTZ2f4e
 a0EaSsw9IXUZeNsXgB8YwjWv7faT0BKm1J9BMU4OIqVutTyECgjvdE3XYc3tn8EGAvKZ
 4cd2UXGrHQycl4lirSAIXC4tA5z7GkbXEW0RQOSJGG8MCgl4eMJO+6MxSXQ/LoANdg5+
 ezYQ==
X-Gm-Message-State: AOJu0YytmZ83NIU2kebezPMEuPVmmfO0sn2puxgj+u7/Pp6O/kKb4+TT
 /OUK3h4+LjyxI9SDANaY9mrWZrmhYKVWHcsgMpdqodt2bBmeOjH15z7iqL4YnFoOKEBdNRGcnn1
 p+dDe1NR4prVZce2pFTF/BQYVGS8ua5YE5AHhZB310sWMPkDD
X-Google-Smtp-Source: AGHT+IEDnGCkFfqRdg3bdtfJZ6mgHLzXy+941kJXKHE5r3P0gf0YlmK0+Cv1yFTVydjWfAktY2FJVRFqiHrgG1FOYDU=
X-Received: by 2002:a17:906:454e:b0:a42:fb21:5066 with SMTP id
 s14-20020a170906454e00b00a42fb215066mr2600376ejq.31.1708932546893; Sun, 25
 Feb 2024 23:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Mon, 26 Feb 2024 16:28:50 +0900
Message-ID: <CAFS=Ecm+aY=pswdL4supc8v0NOGbdW7Mz80j1agLAqc3SQWJ4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,
I would be happy if you could give me some comments.

ping.

On Thu, Feb 1, 2024 at 5:14=E2=80=AFPM Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> The previous code ignored 'impl.unaligned' and handled unaligned accesses
> as is. But this implementation cannot emulate specific registers of some
> devices that allow unaligned access such as xHCI Host Controller Capabili=
ty
> Registers.
> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> unaligned access with multiple aligned access.
>
> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
> ---
>  system/memory.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index a229a79988..a7ca0c9f54 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -535,10 +535,17 @@ static MemTxResult access_with_adjusted_size(hwaddr=
 addr,
>                                        MemTxAttrs attrs)
>  {
>      uint64_t access_mask;
> +    unsigned access_mask_shift;
> +    unsigned access_mask_start_offset;
> +    unsigned access_mask_end_offset;
>      unsigned access_size;
> -    unsigned i;
>      MemTxResult r =3D MEMTX_OK;
>      bool reentrancy_guard_applied =3D false;
> +    bool is_big_endian =3D memory_region_big_endian(mr);
> +    signed start_diff;
> +    signed current_offset;
> +    signed access_shift;
> +    hwaddr current_addr;
>
>      if (!access_size_min) {
>          access_size_min =3D 1;
> @@ -560,19 +567,24 @@ static MemTxResult access_with_adjusted_size(hwaddr=
 addr,
>          reentrancy_guard_applied =3D true;
>      }
>
> -    /* FIXME: support unaligned access? */
>      access_size =3D MAX(MIN(size, access_size_max), access_size_min);
> -    access_mask =3D MAKE_64BIT_MASK(0, access_size * 8);
> -    if (memory_region_big_endian(mr)) {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> -            r |=3D access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs=
);
> -        }
> -    } else {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> -            r |=3D access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> -        }
> +    start_diff =3D mr->ops->impl.unaligned ? 0 : addr & (access_size - 1=
);
> +    current_addr =3D addr - start_diff;
> +    for (current_offset =3D -start_diff; current_offset < (signed)size;
> +         current_offset +=3D access_size, current_addr +=3D access_size)=
 {
> +        access_shift =3D is_big_endian
> +                          ? (signed)size - (signed)access_size - current=
_offset
> +                          : current_offset;
> +        access_mask_shift =3D current_offset > 0 ? 0 : -current_offset;
> +        access_mask_start_offset =3D current_offset > 0 ? current_offset=
 : 0;
> +        access_mask_end_offset =3D current_offset + access_size > size
> +                                     ? size
> +                                     : current_offset + access_size;
> +        access_mask =3D MAKE_64BIT_MASK(access_mask_shift * 8,
> +            (access_mask_end_offset - access_mask_start_offset) * 8);
> +
> +        r |=3D access_fn(mr, current_addr, value, access_size, access_sh=
ift * 8,
> +                       access_mask, attrs);
>      }
>      if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io =3D false;
> --
> 2.39.2
>

