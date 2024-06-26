Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C199C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMP1O-0000lv-MI; Wed, 26 Jun 2024 05:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMP1N-0000lO-Dl; Wed, 26 Jun 2024 05:32:57 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMP1L-0001rv-F4; Wed, 26 Jun 2024 05:32:57 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4ef53497bc2so1521208e0c.3; 
 Wed, 26 Jun 2024 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719394374; x=1719999174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIiuY/kI6aSlkBrD69CvVJ9pgMHGtoi+ydqeDFnbaBQ=;
 b=RiJ+yZZMaWdeH6Kg7q1P01XT5qooutPcmyKMXvQ2WTxOIMn2Z/h2gXd7ncCzmJunHb
 Pq3dhZggNX3va3/ykEJGONss2XsMng5IRV8VnKL/Pk2oEVVtTFDa4HskwucvJvQNPuw8
 fa3oT7ujj/R18kJyeaSJh/uJCGGJpabV/rkkByO5Xn61eJpM8YRViYa0nPFn+1WQ86EV
 A6Vu8IMd7+StVp2InvbhgxiA+r9n1kva9OtHX11IRRctuPoteM5LRrXji1n4TakYPJi5
 SEJMJZxjrSftu68xLlIMAjS9hi1j76V72m/LrQwVFHglThiB6cRS9rcuNCWYm+zjMTa4
 uW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719394374; x=1719999174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIiuY/kI6aSlkBrD69CvVJ9pgMHGtoi+ydqeDFnbaBQ=;
 b=cwKuyLRE2ZiWD3nFVFjv2slZbb3ZLkqZBDivp26cDMH79bn34T4njVd/6iyqDY4b98
 KvJLSD4tQAK08dinM184sdMKbDv8M5FetXTV6ImNoy+9VMelLXO1wMPi/Ne1S/Jpf16z
 qcaNmI39WaZ9MWMDtl9TLQRewxN0S0Ei7q6CjpU1Hh6WR56amsnLWsHs/L1i2XXmYjSS
 AjY+Pgf+/f6u9D6iPgGOF1UXCEv2+hm7RYp6urr9lCWXRLCfMzBEo1tf4VLhCw1TokzC
 p6S8xC+4GOvIQOEV9U28h8XRJZQ6EUSJ/QRDWQFhQyz7ozuUl+aF4df7jsPHCuNO62DL
 x5EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxrrTGIIyJVdHC3itDuzxv1suQJKjD81G1qYdZEn8XMBmodKpVeCq54QCGus5M+Nd2XNvYqBMpFKxCrjG0u9k6BiMacPw=
X-Gm-Message-State: AOJu0YxuOmwzIIyZGUAJ781yn7w9NjRV3ZoYs1SGaZgktOyqENvC+GaB
 VgSnop6ZSG6lCDeOTXwBAaaashShlY9IKwWURLy9RnQQ/Ywun1MIq6zhUT2p3eRkop5kPCnni71
 ahXaYIdfnUBY9dxHM4cDey8lu6MI=
X-Google-Smtp-Source: AGHT+IFq++rc87ClmNOqGQHwREaN7AFX9yp0gGaawytRiTrIQqj4oFuvoMlrLJmB6D10eAFCBF5Gp30/hP5Ul6XZJJs=
X-Received: by 2002:a05:6122:4f97:b0:4ef:58d4:7106 with SMTP id
 71dfb90a1353d-4ef6635fea5mr9325504e0c.5.1719394373917; Wed, 26 Jun 2024
 02:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240604041445.244768-1-alvinga@andestech.com>
 <20240604041445.244768-2-alvinga@andestech.com>
 <CAKmqyKOngPTAyno29HNBhFZ-GdU+0Jw2ymSadmTc3oR7r5P+MQ@mail.gmail.com>
 <SEYPR03MB67005F5CD419B6D6D76DE64CA8D62@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB67005F5CD419B6D6D76DE64CA8D62@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 19:32:27 +1000
Message-ID: <CAKmqyKNz43hmuehKqsBUyBEZws2-jGubwG4dfFpa4Mw6Vu+Cqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] target/riscv: Add functions for common matching
 conditions of trigger
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 26, 2024 at 5:27=E2=80=AFPM Alvin Che-Chia Chang(=E5=BC=B5=E5=
=93=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hi Alistair,
>
> > -----Original Message-----
> > From: Alistair Francis <alistair23@gmail.com>
> > Sent: Wednesday, June 26, 2024 2:20 PM
> > To: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andestec=
h.com>
> > Cc: qemu-riscv@nongnu.org; qemu-devel@nongnu.org;
> > alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com;
> > dbarboza@ventanamicro.com; zhiwei_liu@linux.alibaba.com
> > Subject: Re: [PATCH v5 1/4] target/riscv: Add functions for common matc=
hing
> > conditions of trigger
> >
> > [EXTERNAL MAIL]
> >
> > On Tue, Jun 4, 2024 at 2:42=E2=80=AFPM Alvin Chang via <qemu-devel@nong=
nu.org>
> > wrote:
> >
> > The `From` address is mangled here. It shows it was sent from the list =
instead
> > of your actual email address.
> >
> > Do you mind looking into your email setup and see if you can fix it?
>
> I did not add "--from" when I sent the patch files.
> And I've just added my name and email address by "git config sendemail.fr=
om ......".

Thanks! Let's see if that works.

This patch fails to compile though, I see this error

../target/riscv/debug.c:308:13: error: =E2=80=98trigger_common_match=E2=80=
=99 defined
but not used [-Werror=3Dunused-function]
 308 | static bool trigger_common_match(CPURISCVState *env, trigger_type_t =
type,

I'm going to drop this series from my tree. Do you mind resending a
new version with the build failures fixed

Alistair

> Hope it will work next time I send the patch.
> Thanks.
>
> Alvin Chang
>
> >
> > Alistair
> >
> > >
> > > According to RISC-V Debug specification version 0.13 [1] (also applie=
d
> > > to version 1.0 [2] but it has not been ratified yet), there are
> > > several common matching conditions before firing a trigger, including
> > > the enabled privilege levels of the trigger.
> > >
> > > This commit adds trigger_common_match() to prepare the common
> > matching
> > > conditions for the type 2/3/6 triggers. For now, we just implement
> > > trigger_priv_match() to check if the enabled privilege levels of the
> > > trigger match CPU's current privilege level.
> > >
> > > [1]:
> > > https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vot=
e
> > > [2]:
> > > https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asci=
i
> > > doc
> > >
> > > Signed-off-by: Alvin Chang <alvinga@andestech.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  target/riscv/debug.c | 70
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >
> > > diff --git a/target/riscv/debug.c b/target/riscv/debug.c index
> > > b110370ea6..05e001d041 100644
> > > --- a/target/riscv/debug.c
> > > +++ b/target/riscv/debug.c
> > > @@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env=
,
> > target_ulong trigger_index)
> > >      }
> > >  }
> > >
> > > +/*
> > > + * Check the privilege level of specific trigger matches CPU's
> > > +current privilege
> > > + * level.
> > > + */
> > > +static bool trigger_priv_match(CPURISCVState *env, trigger_type_t ty=
pe,
> > > +                               int trigger_index) {
> > > +    target_ulong ctrl =3D env->tdata1[trigger_index];
> > > +
> > > +    switch (type) {
> > > +    case TRIGGER_TYPE_AD_MATCH:
> > > +        /* type 2 trigger cannot be fired in VU/VS mode */
> > > +        if (env->virt_enabled) {
> > > +            return false;
> > > +        }
> > > +        /* check U/S/M bit against current privilege level */
> > > +        if ((ctrl >> 3) & BIT(env->priv)) {
> > > +            return true;
> > > +        }
> > > +        break;
> > > +    case TRIGGER_TYPE_AD_MATCH6:
> > > +        if (env->virt_enabled) {
> > > +            /* check VU/VS bit against current privilege level */
> > > +            if ((ctrl >> 23) & BIT(env->priv)) {
> > > +                return true;
> > > +            }
> > > +        } else {
> > > +            /* check U/S/M bit against current privilege level */
> > > +            if ((ctrl >> 3) & BIT(env->priv)) {
> > > +                return true;
> > > +            }
> > > +        }
> > > +        break;
> > > +    case TRIGGER_TYPE_INST_CNT:
> > > +        if (env->virt_enabled) {
> > > +            /* check VU/VS bit against current privilege level */
> > > +            if ((ctrl >> 25) & BIT(env->priv)) {
> > > +                return true;
> > > +            }
> > > +        } else {
> > > +            /* check U/S/M bit against current privilege level */
> > > +            if ((ctrl >> 6) & BIT(env->priv)) {
> > > +                return true;
> > > +            }
> > > +        }
> > > +        break;
> > > +    case TRIGGER_TYPE_INT:
> > > +    case TRIGGER_TYPE_EXCP:
> > > +    case TRIGGER_TYPE_EXT_SRC:
> > > +        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not
> > supported\n", type);
> > > +        break;
> > > +    case TRIGGER_TYPE_NO_EXIST:
> > > +    case TRIGGER_TYPE_UNAVAIL:
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not
> > exist\n",
> > > +                      type);
> > > +        break;
> > > +    default:
> > > +        g_assert_not_reached();
> > > +    }
> > > +
> > > +    return false;
> > > +}
> > > +
> > > +/* Common matching conditions for all types of the triggers. */
> > > +static bool trigger_common_match(CPURISCVState *env, trigger_type_t
> > type,
> > > +                                 int trigger_index) {
> > > +    return trigger_priv_match(env, type, trigger_index); }
> > > +
> > >  /* type 2 trigger */
> > >
> > >  static uint32_t type2_breakpoint_size(CPURISCVState *env,
> > > target_ulong ctrl)
> > > --
> > > 2.34.1
> > >
> > >
> CONFIDENTIALITY NOTICE:
>
> This e-mail (and its attachments) may contain confidential and legally pr=
ivileged information or information protected from disclosure. If you are n=
ot the intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution, or use of the information contained herein is strictly =
prohibited. In this case, please immediately notify the sender by return e-=
mail, delete the message (and any accompanying documents) and destroy all p=
rinted hard copies. Thank you for your cooperation.
>
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

