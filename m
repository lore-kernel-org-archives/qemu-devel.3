Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4ACC3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGoRa-0004K6-PW; Sun, 18 May 2025 20:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoRX-0004JW-AD; Sun, 18 May 2025 20:33:23 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoRV-0001Vn-PZ; Sun, 18 May 2025 20:33:23 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4e14b17c181so1301685137.0; 
 Sun, 18 May 2025 17:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747614800; x=1748219600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvcYTPRSmDPFyWjKYDuSmeoWclyZCkd6OqvsK/rGyJQ=;
 b=cZ4NqLKEB4RxqbIyK6dhcIhZ+hFFAmWl0mbYAbo10jtuTxs+3JjrWZdoXR50YV2/J1
 aXkXaIkIjPMXCOepwccJHxQ/9sSG2NGgezfsJtGLLXH6FJpdzsulRGdhzgurMoSi/1cX
 9nJhEnoIFTwLcHNAJnax0DunBl6pVGTzfVf4QCIIAkKWC4mlpIXvz7YACHiq0zSVva71
 krHEzR7AA9Mvbx7YEzgCKGawK8QJj3PnOhwzpe5XgkBiC75JvOyRrqMYcpTZMV1LwpCL
 02bcolQCjrn+xKi/nswC9KcPHHcn3Pz1xVMpQMBQ36Im4SmtLw6borW/dux1dPnuWegy
 RImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747614800; x=1748219600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvcYTPRSmDPFyWjKYDuSmeoWclyZCkd6OqvsK/rGyJQ=;
 b=Ad1Bd0AX7RB6Vsw0pDkslE74+KbAESlOOpLHGBRk77cdR73WYqfspUTfiJ5zzLs3Qn
 XsFS3uBAZhbqXNPddT2NwAC4qz7ydOchhUef7LassMT0YZ1yx5KM6gWh4draEVYVFDBo
 DCPkENCYLGfXVTR1PsqchChDrLbDrJVYuch4r7D4Sa21tjN5zH+gSEzOFa2AhUZYHyBb
 VYxzH7++5akgpVzrMVgftjmijEMZp6yyuVfUJmIoBQw6HGDw8G2/EBfjBmZDdq0L6Zku
 T5sL8BIK1ccSG/z+XnmB4OfZkOrd4V6DIqJPYBbw+Ign45wOilnbOZ2t5vqH70w+3icV
 Jl0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMIk5NXn0WFwA/VbSgzX9ThJNt8Uzz5lZc3SdTd29OBEwa3US35q9nsnvtkqLHflYq125LYaocRFR6@nongnu.org,
 AJvYcCWuNL2QI3ET2bK59w6G3kar15BT3MLauCeIUTsYsFj9v5sU878SxBxoITz6C2jd4JR//EPSpmM8Y6gS+Q==@nongnu.org
X-Gm-Message-State: AOJu0Yy3DIbBA2VvsdxP/1Wj4eLR1XjHU/9mVVvRnRVrdI5vJqTTI+Qz
 OkSdE+c472bVnQ+wMCHqu2kObO7aFmUgplL48em5vDhltKGzej4eTjofOGHOJUIcXdwLNuUsh4H
 +2b0EENfFL72FuuoQaldkXLBAd9vVv0g=
X-Gm-Gg: ASbGncsnr6wJl6cySQxYIugLZu/CszDORLE6fZBy6mJWL9cpzMwwX6GJa9pKytejSVs
 YWoAp2KwsXl9j8Ye2pieEnuvG9QyC9aLhLw/RYViOVKiROQj2CxOQyyn1NnAmqP/kLXo1eJ56Uu
 iD5kTXgX5uUhG9LpVAKjd2Rmmg7pQ/mTnC77XmzF0LmHcSsu23EmOaG7tHvvTMVg4=
X-Google-Smtp-Source: AGHT+IH2sWPDudNZUefYUiNLrcH9DRXeSSO0LYlDL7Rof52tKkevNMIe7oKhhIuILTAz3aJZ4F3Yj/zQRTIPUOEGuRU=
X-Received: by 2002:a05:6102:1508:b0:4c3:346:29ef with SMTP id
 ada2fe7eead31-4dfc30f4313mr11136634137.11.1747614800216; Sun, 18 May 2025
 17:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <202505122007170451_WeaVnOMOCnJghLHZ5zH@zte.com.cn>
In-Reply-To: <202505122007170451_WeaVnOMOCnJghLHZ5zH@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:32:54 +1000
X-Gm-Features: AX0GCFtBrcs6_Pi5sgcNBsJY6GTb6TygnWQsDs9l6Vzc8lMXHjmrnD8luERehWA
Message-ID: <CAKmqyKNX1bnO9ptoj5AHY+XwWcrwAD+nwV5pJPArBURf1PCmSA@mail.gmail.com>
Subject: Re: [PATCH v2] migration: Fix migration failure when aia is
 configured as 'aplic-imsic'
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 farosas@suse.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 13, 2025 at 2:33=E2=80=AFAM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Address an error in migration when aia is configured as 'aplic-imsic' in
> riscv kvm vm by adding riscv_aplic_state_needed() and
> riscv_imsic_state_needed() to determine whether the corresponding sates a=
re
> needed.
>
> Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' ca=
n
> only be initialized under certain special conditions in commit 95a97b3fd2=
.
> However, the corresponding ses of these vmsds are inserted into the
> savevm_state.handlers unconditionally. This led to migration failure
> characterized by uninitialized fields when save vm state:
> qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
> Assertion 'first_elem || !n_elems || !size' failed.
>
> Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM A=
IA")
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>
>  Changes in v2:
>
>  - Dropped the modifications in vmstate_register_with_alias_id()
>  - Added riscv_aplic_state_needed() and riscv_imsic_state_needed()
>
>  hw/intc/riscv_aplic.c | 8 ++++++++
>  hw/intc/riscv_imsic.c | 6 ++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8bcd9f4697..c9abef2e0f 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -962,10 +962,18 @@ static const Property riscv_aplic_properties[] =3D =
{
>      DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>  };
>
> +static bool riscv_aplic_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    return riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
>  static const VMStateDescription vmstate_riscv_aplic =3D {
>      .name =3D "riscv_aplic",
>      .version_id =3D 2,
>      .minimum_version_id =3D 2,

I think these should also be incremented

Alistair

> +    .needed =3D riscv_aplic_state_needed,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_UINT32(domaincfg, RISCVAPLICState),
>              VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 2169988167..92a7254076 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -398,10 +398,16 @@ static const Property riscv_imsic_properties[] =3D =
{
>      DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
>  };
>
> +static bool riscv_imsic_state_needed(void *opaque)
> +{
> +    return !kvm_irqchip_in_kernel();
> +}
> +
>  static const VMStateDescription vmstate_riscv_imsic =3D {
>      .name =3D "riscv_imsic",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .needed =3D riscv_imsic_state_needed,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
>                                    num_pages, 0,
> --
> 2.27.0
>

