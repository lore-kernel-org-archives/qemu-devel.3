Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC5C0219D
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thEfR-00007s-Vg; Sun, 09 Feb 2025 16:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1thEfQ-00007R-5t
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:16:40 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1thEfO-0003om-HO
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:16:39 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5343010a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739135795; x=1739740595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlqlZjOCom3Z8oR3xK7otCpSgVgm+sM9Zn5Lx9ifaqc=;
 b=KS2g6gLINYtdqZJ9w6U9BqQGo2BaTu7BnNY0qL/tzKoudPPdmIQgB3JRHw5hG/AEg7
 ZPoFORxp/u6vEUEflJK+4ows3TXZ3dbIehdYQgOLQKPUXzKcPwJGESm1EBH36IarlwpO
 acDs+/L4b5/rft26ax1uqvxdAS9w6TQGkc2+YNenJz8FwXIKgJtaHTDG2BrK/NFI9VQ6
 a8a3VvnismgX7iQ02rBEdedg7enpuPfKio6bixwRq8QKpNKzImFwtVdNN6OVD7PIsway
 MWhAfPmfytD7XGwFLD2aJr47U5ikFk8ca45/vazB41FyhWy/lSFu/ZYzGlJWYeag/MeY
 rwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135795; x=1739740595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlqlZjOCom3Z8oR3xK7otCpSgVgm+sM9Zn5Lx9ifaqc=;
 b=ZWG8e6Uzw8FkVP2QE0XnvaRQCxpdxhbsL0+Xs11pcpOupZh6CYKdYuShd8VaJZfjV4
 sXczIQkRZRvmnZ9NXl55UtIKFn5Wo6eyLYSHfj0b6OGlalaZgknFIlV8r4B8fU6KRu2p
 TInqJGIRP/MZaZ8LnZt2hMmJpKxx06lWujeLU+a8t6X9YcBvnsrXF5MwFsXeodMW2wea
 uJkA3gcPVB7Fl1uMBrhtM/AI7mU8KVyXGqzBj7O5VhnWalHTq+LTTfmxfT7THDWcyCtm
 I+FpuEpErjkg1vcIUIeRehIx9rPoGAjo5jH8udXPGw/MgWpId+9cruB4CJcxoVFbTDrU
 M1fw==
X-Gm-Message-State: AOJu0YxyB35fmVUXMzhxe78z4D3pAzuVHVIjjKX74CC83H21VC7tMrgm
 Axy79nOHYTLO8rTBDXEXWvc6VHc1DnGCIlI/0+aEbyqL5Zlzjje7o3NORb1w+OEKXmV85yrV8un
 gCrMPpola6ZOB7eDKgzawNFHPrAg=
X-Gm-Gg: ASbGncuGyNGc6vLkBtGCbpWZKE86I56FCdYBYBsWAA9KR68SUw3YflpLg/xxcgx9YzO
 sU038fkyMd0rndymd5wta/1vRKmEaRZCJf2CiZWb5DrYgS0Y1cFha58XoowVfuPLkTdUHpqtf
X-Google-Smtp-Source: AGHT+IEjBR3spxH9gojPKibSsoqwAs/thJmdDCVYPWLnWcSq7KLRj+xDRHhgsCi4nufTdpOFPhwEnY5aFA4lM4rvHyM=
X-Received: by 2002:a17:90b:2ec5:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-2fa24274b6cmr18692962a91.15.1739135795354; Sun, 09 Feb 2025
 13:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20250131214528.117846-1-atar4qemu@gmail.com>
 <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
In-Reply-To: <99ea71e8-b978-41c6-8ba5-f056935ea39e@linaro.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 9 Feb 2025 22:16:23 +0100
X-Gm-Features: AWEUYZl3sA2LLAnwcGXyr0qXMTE06sV4um7DMcP0N1kOHDXcyye8O1_khdj24bo
Message-ID: <CAAM0arMwOeZ_d0dmGqoTFcf-ezb3_j3HTd71qo6k35ftPRRzdw@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: fake UltraSPARC T1 PCR and PIC registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=a.tarasenko@gmail.com; helo=mail-pj1-x1035.google.com
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

On Sun, Feb 2, 2025 at 10:47=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/31/25 13:44, Artyom Tarasenko wrote:
> > fake access to
> > PCR Performance Control Register
> > and
> > PIC Performance Instrumentation Counter.
> >
> > Ignore writes in privileged mode, and return 0 on reads.
> >
> > This allows booting Tribblix, MilaX and v9os under Niagara target.
> >
> > Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > ---
> >   target/sparc/insns.decode |  7 ++++++-
> >   target/sparc/translate.c  | 20 ++++++++++++++++++++
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> > index 989c20b44a..504147563c 100644
> > --- a/target/sparc/insns.decode
> > +++ b/target/sparc/insns.decode
> > @@ -96,7 +96,10 @@ CALL    01 i:s30
> >       RDTICK          10 rd:5  101000 00100 0 0000000000000
> >       RDPC            10 rd:5  101000 00101 0 0000000000000
> >       RDFPRS          10 rd:5  101000 00110 0 0000000000000
> > -    RDASR17         10 rd:5  101000 10001 0 0000000000000
> > +    {
> > +      RDASR17       10 rd:5  101000 10001 0 0000000000000
> > +      RDPIC         10 rd:5  101000 10001 0 0000000000000
> > +    }
> >       RDGSR           10 rd:5  101000 10011 0 0000000000000
> >       RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
> >       RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
> > @@ -114,6 +117,8 @@ CALL    01 i:s30
> >       WRCCR           10 00010 110000 ..... . .............  @n_r_ri
> >       WRASI           10 00011 110000 ..... . .............  @n_r_ri
> >       WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
> > +    WRPCR           10 10000 110000 01000 0 0000000000000
> > +    WRPIC           10 10001 110000 01000 0 0000000000000
> >       {
> >         WRGSR         10 10011 110000 ..... . .............  @n_r_ri
> >         WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
> > diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> > index 7e5c7351cb..285c9b0a59 100644
> > --- a/target/sparc/translate.c
> > +++ b/target/sparc/translate.c
> > @@ -2882,6 +2882,15 @@ static TCGv do_rd_leon3_config(DisasContext *dc,=
 TCGv dst)
> >
> >   TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
> >
> > +static TCGv do_rdpic(DisasContext *dc, TCGv dst)
> > +{
> > +    tcg_gen_movi_tl(dst, 0UL);
> > +    return dst;
> > +}
>
> return tcg_constant_tl(0);
>
> > +
> > +TRANS(RDPIC, HYPV, do_rd_special, true, a->rd, do_rdpic)
>
> Surely reads are not allowed in user mode.

Thanks Richard, addressed it in v2.

