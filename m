Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDD606A32D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYKGDzUH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOAcZ-0003v2-Dc; Tue, 03 Nov 2026 04:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOAcV-0003uB-TK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 04:15:57 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOAcT-0000EX-QI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 04:15:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so5919782a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 01:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793697351; cv=none;
 d=google.com; s=arc-20260327;
 b=TSOSFxzqIultoA0IMWk9afnck7iQVZ/8yxbEBI5P0zAR+6EKUJhkbdRdqYKuCkv4Jb
 YHZxbSTqLZDLqnQ8mteBPvPSZA/TOKE7N4nvxb2qxbEP4iHIOe3G5r6UJZymmjCTyI3U
 RQ6fIXIUeTF9ZOKb4bICGBR5C39dKZIW79zO/WS9K28S+SnE3fDWTmlrymFYO0eVZheN
 C7axUYmC/c2BgVQAG5qjlEyUcWk+Hvo/RmvbKxw/sAwySSzkBSEAeyL0aOhSObPQjOui
 ps4F/j8Ge6+Enxx6r5R0urh5U+ttPo9w689MzoLeQvmOJcNRaaHvY0jxb1zX66xUNQWu
 7C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6HpPn4PoYBNIQe4jwAq6RYNc4y0GSA5S0U2wFZLAcN4=;
 fh=Si5sPdu6QaN1MRftWzrU7i8xDSspAZLN+kbMOisCt8o=;
 b=Ve+ASNh3wMsXQVpg6FH3il3m8ADUyJYe+kmO92MOeajcbcF9GBnYH6x8gbu3bfSxBi
 D0BezSpiuFFBBECBIHWMnEM3fAsV7ke6sh6j+vgNi9hoVaUny5rqFO6DQks8nqnHDOYi
 7RToGqT/7OYSjFPr3J1e5pXMRXKvOMtOCCI78sPQRDWdKPIcrAZSK5+d2sxExw+FyoS7
 BJAveXTNz22U8T3JnY21MMJcc8scVxjqKOsAOJSFo72RTDUtS7azN9NDSfhTMjfPZbbi
 zXwnbbEVw14ID+G/ijZBBB2OQ859FCJVajikJJ2MPI+ydYAv0L8QUnwOX+siQYs9NsZM
 uIYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793697351; x=1794302151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6HpPn4PoYBNIQe4jwAq6RYNc4y0GSA5S0U2wFZLAcN4=;
 b=uYKGDzUHc8CKPW5yTYQeEHzxj0Qhu4KcFYnSD4BGQ+TQ+1G3EmsHGB8Y/ScS+fdsey
 WlM6+Sw+Y494nZWZ2BkjJhHL8t5g5tMpBQ0lL1FtTNDCOCyQVT4C8KYcyQ1Y4aJKweez
 veu1c8BshwSkoH57a71iM0H5MuLTEfBChyowTrE0j1NtyEEMeXTzG5/+2T+28l1pfCpg
 kErc5u3BRJ/3cV6b8TEWZ/fZx5o5XfQvOVZp3oD9kMIHEqKb852/ujEGFqntPzPHp/TI
 BNW2ljLzXZV3fH3YlpQH/DYZPNoKDfJqhRpa8QzjD4AwiLMXrDgVmTSYhZHlMoPjtilu
 gYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793697351; x=1794302151;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6HpPn4PoYBNIQe4jwAq6RYNc4y0GSA5S0U2wFZLAcN4=;
 b=a/J7tVgvUfNaX6EV7X+5gwI9s3FsQ3UtP1e4C5akhHwsweXNNKfsIeIiXMP5hFPW4a
 aBlENmLs1f8nhdRGNd91ewmM+Jbds3T8Zjfa+xmDOJoUtXCzCX1Ic2tJE8tS9RNmNhOS
 Ix+53p1LU06eb5qyw0Ev7VqzJcEygsKnjPHdHQkJ98VmoEfuzYfze/vH25rleb2YQfbr
 bgLlHBf6UB6PrlW9IoeRMMSRwrxRlzaVW0Wlj0I0O9xo6El7QKw60K9PhMh4rUlW2qw7
 qoH1xgglaK3dbdzsy3HyyF3Fhkf3s0nGdKhtfGJP9MQcgpT/JBfBc5Y9jVvU14VmNK1m
 HW5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcsAGxQUJ2CWxvukU+FY0IXsYRTCjzfgnMvYnEFaZgO29WCGwcdfWjcpoZ2AWqowPptrLJ6kDmWd+B@nongnu.org
X-Gm-Message-State: APuU4Z+Lou75U3skDl5UhjLH4bE9Fkxa5QH4QQpNuSNpIyMuX6MBvbew
 /gTj2Ql0XIrOVKYBgoi3ts+3GOlwC2GN5tf/mwgoqRVNEJO1mPkGaZx3+esEixmcBqE3ymAqI1z
 fUu24fXvSW+0exZh+7w8IFuyOY3Bo/4I=
X-Gm-Gg: AYBFou3ySSSPm4Bd/Kr2ZOWF3Pw5fcI586Q77/1nT5jIG7xIyXUqKoYFePGdXWfZ6wb
 mh0Z6m1+mRrHwXmhXEknylKZq+Ca4F1PxN/DxHz4+a/FmCZGbYOgZF4mpb1yDnBn1Qfd/U2ZgM3
 gZFlRLAMO44neZgRgKZ7eSs2uji7SvgxWrEIt4m2kqGh+5xfReDVgl0avBciGijlJvJKPHe0twa
 lCdvMDO/xL57pv4IuoxDEdCJRg+pMNUvqj9I4ARGXfX0TdG3wp5U55v/8CY952b1h2TzVDd5hu5
 GGtbgrjfXPrcddQnLlY1aZxKgkF7Z3Ujc+Y2xdVzpJ2uupMCVRYnRjvItE+GNhxPpLlYUqZA832
 Hs1JpHrPZRIg3Clo3qkuYFSjO88jtTNq0SemY
X-Received: by 2002:a05:6402:2355:b0:6b4:20bc:fa3 with SMTP id
 4fb4d7f45d1cf-6b4d467bb11mr9345520a12.22.1793697351217; Tue, 03 Nov 2026
 01:15:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <aumYOBw-nKQAWdYK@redhat.com>
In-Reply-To: <aumYOBw-nKQAWdYK@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 3 Nov 2026 17:15:38 +0800
X-Gm-Features: AclHuK9NUtlMJehxCaFT4QHnxh-0yBZ0hPP8kK9uDqXwDHrUyauf19YUe8SC3VE
Message-ID: <CAE2XoE8Xwevk523OfB+GgwbRu0iVnyD4VNOx81rj7J7F5aq=OA@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Felipe Balbi <balbi@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, 
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 4:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Oct 30, 2026 at 05:51:44PM -0800, Pierrick Bouvier wrote:
> > On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> > > On Fri, 30 Oct 2026, Yonggang Luo wrote:
> > >> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the
> > >> type_init
> > >> function that calls type_register_static(). A later change needs to
> > >> pass a
> > >
> > > That's the point of the macro to hide the boiler plate code.
> > >
> > >> target mask into that registration, and the macros have no parameter
> > >> for it.
> > >
> > > Couldn't you just change the macros to take that parameter instead of
> > > expanding it everywhere?
> > >
> >
> > Problem of macros is that they don't have default parameters, so you
> > need variants for everything:
> >
> > DEFINE_MACHINE
> > DEFINE_MACHINE_EXTENDED
> > DEFINE_MACHINE_WITH_INTERFACES
> > DEFINE_MACHINE_WITH_INTERFACE_ARRAY
> > and now would need a new variant, with variant for other existing ones.
> >
> > In the end, it's just simpler to remove this and add the boilerplate.
> > It's written once and never modified, so using a macro just save typing
> > those lines once.
>
> For each machine, it is only written once, but we add machines
> over time, and every time a new machine is added the code style
> is slightly different. We introduced all the variuos DEFINE_*
> macros for QOM to better ensure consistent style and usage as
> new code is added over time.

I understand that the DEFINE_* macros are bloating because of this.
Indeed currently the only two macros used are "DEFINE_MACHINE" and
"DEFINE_MACHINE_EXTENDED"
; each time people want to add a new attribute, the macros is twiced.
And the usage of DEFINE_MACHINE_EXTENDED is rare and can be replaced
with DEFINE_TYPES or TypeInfo
and be more explicit. When we used as macro parameter, we need think
what's that parameter means, and for
TypeInfo, we can directly know what that member is about(because we
are assigned with the member name).
That's why I suggest keeping a single DEFINE_MACHINE, just like
DEFINE_TYPES; as they are the most
used macros(and simple enough), and won't suffer from changes much.

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

