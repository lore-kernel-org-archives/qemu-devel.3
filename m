Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B402AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEITz-0000Qr-IT; Mon, 03 Jun 2024 20:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEITx-0000QO-PK; Mon, 03 Jun 2024 20:56:57 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEITv-0005Th-1B; Mon, 03 Jun 2024 20:56:57 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4eb076bec24so197993e0c.1; 
 Mon, 03 Jun 2024 17:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717462612; x=1718067412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs/jKuLhldhRhNermI5Eis9VnXKK/yGuBC9o02rNLqY=;
 b=UHeaCZshrlB8W2/7xM7P/xmVVHi/lBNhmOJlmFY5VIzeqD0S5QsGks4zU5TBg0j28f
 SljQRR7E6AhEbLcvSXngKg7nR6uxmPMH9gGj18e+42EKbtkjAtNfG2JqY0y9P4atcEbX
 mfTGWwyY4XrZz7b5dxY0C2+caSkimpGuc2OLUlMjSMYxe9A+X6zDopEBR6Z65WOXEI9a
 AE3bW0PJy8Cht2CZqBRGw+0IciePUZFOUt8IN0rmnlmtvdVCnPUttjz2Y2t6JyBFbwMZ
 CAhgEL2Vb4NaqBWSbvHvDbdMPl8JJ9QNb8FXQl55WXzREwCtzJRMO8NBpzcfXDiwBUE+
 jDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717462612; x=1718067412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs/jKuLhldhRhNermI5Eis9VnXKK/yGuBC9o02rNLqY=;
 b=jwgmgbtv8lkJI2pdiLNWNytpAjP79RKwO3AeoEA9vjsgR02ITMKcpMa5n4p0dILbP6
 XAW+ZcaMe6uH22NL35yEAwK7hN1nY7z57OiIXVn/J69kpnzFk0PNVpTFBbfZX/Ym96KD
 NK6sZ+7fIqk6RppLsMNO/gUNQaAIup8hzxTXR5PbN7E4DtV636wuAygimv/MD5hWWz5C
 Jzt4/LYobV47HV3ARL3i5K6hDBJshgt/fGMoVe+PlXH4slZoFsJTPCN14q2jlFazkw9J
 G2PUaqFKn6iu/+SjHs/KlMSL95qRkIMFQyq0q5RvWw3PM8/cOj4ktt+DU8vJOTr3p1kP
 N13w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3xI4WOr+GkcFFjuUAnAHZZd7hFL6IuHsJnJUAs8JxDEZ01+Y746ODgv4yerjzNf/4pbBpc9V6csjds2lwvf8Gv65pvNA=
X-Gm-Message-State: AOJu0Yz+oysCTwu70cHkRaNybESbICCquSLccdv9vyUzMdcyTz/H2tnb
 25JlLt9p1NwG/wWuIIMkqJLP8Fc8aGZVUfepgf5MyHwynBfuPpBhRnEMN77KkZzbcqAYr29pIPw
 Aje3N9YqvnDwP3aJjOeOQvGyhuck=
X-Google-Smtp-Source: AGHT+IF7UnWdoQFGJmfNKLkRVv7kD5vylb2GG1CBpRr+ZvaN1qnbWvKD6pGHndencnEjWqMPbSF8WColmkJFMhr3FXY=
X-Received: by 2002:a1f:7288:0:b0:4d8:797b:94df with SMTP id
 71dfb90a1353d-4eb02e09638mr9261229e0c.2.1717462612397; Mon, 03 Jun 2024
 17:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-3-fea.wang@sifive.com>
 <CAKmqyKMPy40UQxvVAyuJ+tvC3-58nMvYB1UqMDcoDOT5_A8u1A@mail.gmail.com>
In-Reply-To: <CAKmqyKMPy40UQxvVAyuJ+tvC3-58nMvYB1UqMDcoDOT5_A8u1A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:56:26 +1000
Message-ID: <CAKmqyKP4pDZdq7mdouTOSznATuGg7jX4QurVvyVEFFRXF3ab4Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/5] target/riscv: Support the version for ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 4, 2024 at 10:46=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Wed, May 15, 2024 at 6:02=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wr=
ote:
> >
> > Add RISC-V privilege 1.13 support.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Whoops, ignore this.

>
> Alistair
>
> > ---
> >  target/riscv/cpu.c         | 6 +++++-
> >  target/riscv/cpu.h         | 4 +++-
> >  target/riscv/cpu_cfg.h     | 1 +
> >  target/riscv/tcg/tcg-cpu.c | 4 ++++
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 6dd3d7f4a3..ee2ec4c4e5 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_sp=
ec_str)
> >  {
> >      int priv_version =3D -1;
> >
> > -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> > +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> > +        priv_version =3D PRIV_VERSION_1_13_0;
> > +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {

This patch should be split in half. We only want to expose this to
user after it has been implemented.

Alistair

> >          priv_version =3D PRIV_VERSION_1_12_0;
> >      } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
> >          priv_version =3D PRIV_VERSION_1_11_0;
> > @@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
> >          return PRIV_VER_1_11_0_STR;
> >      case PRIV_VERSION_1_12_0:
> >          return PRIV_VER_1_12_0_STR;
> > +    case PRIV_VERSION_1_13_0:
> > +        return PRIV_VER_1_13_0_STR;
> >      default:
> >          return NULL;
> >      }
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 140eb43fcb..f691c7d828 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
> >  #define PRIV_VER_1_10_0_STR "v1.10.0"
> >  #define PRIV_VER_1_11_0_STR "v1.11.0"
> >  #define PRIV_VER_1_12_0_STR "v1.12.0"
> > +#define PRIV_VER_1_13_0_STR "v1.13.0"
> >  enum {
> >      PRIV_VERSION_1_10_0 =3D 0,
> >      PRIV_VERSION_1_11_0,
> >      PRIV_VERSION_1_12_0,
> > +    PRIV_VERSION_1_13_0,
> >
> > -    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_12_0,
> > +    PRIV_VERSION_LATEST =3D PRIV_VERSION_1_13_0,
> >  };
> >
> >  #define VEXT_VERSION_1_00_0 0x00010000
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index e1e4f32698..fb7eebde52 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
> >       * TCG always implement/can't be user disabled,
> >       * based on spec version.
> >       */
> > +    bool has_priv_1_13;
> >      bool has_priv_1_12;
> >      bool has_priv_1_11;
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index fa186093fb..f53422d605 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVC=
PU *cpu)
> >          cpu->cfg.has_priv_1_12 =3D true;
> >      }
> >
> > +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> > +        cpu->cfg.has_priv_1_13 =3D true;
> > +    }
> > +
> >      /* zic64b is 1.12 or later */
> >      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
> >                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> > --
> > 2.34.1
> >
> >

