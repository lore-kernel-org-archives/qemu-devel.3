Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D122FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 23:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXrau-00021W-Ud; Wed, 07 Feb 2024 18:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXras-00021J-T5
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 18:44:42 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXraq-0001za-1t
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 18:44:42 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so15461261fa.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 15:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707349470; x=1707954270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqy/Pj+yNPAIT9HHF0OvBTnLDNzISGkZDC8cmirvaCo=;
 b=dDFokno3X3zp5pOEtFhwquHU3OJ/4FZrzz2NCGluK320EtnrKiSki77I31mUe+o9zH
 RYnLF9k7NKQ+T8nks7ILdLIEutmHeE0QuppLWZyRgHP1XqonMKIaelZW5gpCp3StyDrT
 1Xe42qLDQIG4FhllRWeGdQm8k+NseSkZOuQJdBVtjYCwDRxSFjSfadA+sQiGq2+bp4af
 vxSA2+cIQQrXVUonC0ZRcOub7Jzvkpru6bGVDRNK/KtE3eg5P5Y17mTdK6IULjaTm0oJ
 KCYIOo7/egL99qYa4bq8ur8woraUL5DHcT3KNjeHpc1snh/4aRE1qbjMfRsXNK274TR/
 eFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707349470; x=1707954270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqy/Pj+yNPAIT9HHF0OvBTnLDNzISGkZDC8cmirvaCo=;
 b=wFWAhkP3tijTE/7KeVtfeXqqj7mQU9nH1Ep+/q8Nuduuik6MHmiGcHZegHHQzL4LeF
 u1dx9kw24BY4AfikVqgfk2Sa/5XnOAzKn64UMuFjHY1dc8Wju/einJFu0wVujDTISZnW
 WATopmvht36oNe8Rfj4MPY/MVq3eqiRXiz6EM6e8PKrOgPigakdRYxsHY1yFq/7P8tI3
 PD+KCxe24ztJkLT7qw9hXOr3Fj+aWJtulvT8jDYlgKjjthknrjKp3e7LpI4CK/O4ufCD
 7IRjj6iu7bRvPcDc5J1SGlTwcTy85/MLj3OJ61+wzHiM8fhZaXfuSd8kkCT1YBCVvRk9
 RI5Q==
X-Gm-Message-State: AOJu0YwTo/pGBinmSLqdbrgH4dz2Nqt7bsn+X2Tc4p99bvxoYwKlPkEK
 v99KaQDp1sFvQDd5KKqCKNtVrzj8LMaAL0w0fZ+ejd40qXhFBTab8i6K1ChAcQhBuwShWMxs8eo
 WcIejxgYNxjFi5PgvIMNixCTu4PzJDZPb7ZKVkw==
X-Google-Smtp-Source: AGHT+IFgleB65lJhSD4+wKpwSrKfcLgmeaqJcO6JD90NM3N6bZq3mVotjuSZY/i2dQnT40HDMrcl/48uT36hgNtO7O8=
X-Received: by 2002:a2e:9f41:0:b0:2d0:c77c:b1ca with SMTP id
 v1-20020a2e9f41000000b002d0c77cb1camr2549128ljk.49.1707349470217; Wed, 07 Feb
 2024 15:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-3-hao.xiang@bytedance.com> <ZcMDVpLilA-PZ3he@x1n>
 <ZcMI-wPq94x6cO2Z@x1n>
 <qhvli57ctzn3cyt2fwppmcauhmlrqoz7ubljxswx7ghroshop2@kmiaukhnvfko>
In-Reply-To: <qhvli57ctzn3cyt2fwppmcauhmlrqoz7ubljxswx7ghroshop2@kmiaukhnvfko>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 7 Feb 2024 15:44:18 -0800
Message-ID: <CAAYibXi3BUxjg+b1ZXiT_AnnV5LkAN11G-UZc6bZQr4sFz5uzw@mail.gmail.com>
Subject: Re: [External] Re: Re: [PATCH 2/6] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
To: Jiri Denemark <jdenemar@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lj1-x232.google.com
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

On Wed, Feb 7, 2024 at 12:41=E2=80=AFAM Jiri Denemark <jdenemar@redhat.com>=
 wrote:
>
> On Wed, Feb 07, 2024 at 12:37:15 +0800, Peter Xu wrote:
> > On Wed, Feb 07, 2024 at 12:13:10PM +0800, Peter Xu wrote:
> > > On Tue, Feb 06, 2024 at 11:19:04PM +0000, Hao Xiang wrote:
> > > > This change extends the MigrationStatus interface to track zero pag=
es
> > > > and zero bytes counter.
> > > >
> > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > >
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > I'll need to scratch this, sorry..
> >
> > The issue is I forgot we have "duplicate" which is exactly "zero
> > page"s.. See:
> >
> >     info->ram->duplicate =3D stat64_get(&mig_stats.zero_pages);
> >
> > If you think the name too confusing and want a replacement, maybe it's =
fine
> > and maybe we can do that.  Then we can keep this zero page counter
> > introduced, reporting the same value as duplicates, then with a follow =
up
> > patch to deprecate "duplicate" parameter.  See an exmaple on how to
> > deprecate in 7b24d326348e1672.
> >
> > One thing I'm not sure is whether Libvirt will be fine on losing
> > "duplicates" after 2+ QEMU major releases.  Copy Jiri for this.  My
> > understanding is that Libvirt should be keeping an eye on deprecation l=
ist
> > and react, but I'd like to double check..
>
> This should not be a big deal as we can internally map either one
> (depending on what QEMU supports) to the same libvirt's field. AFAIK
> there is a consensus on Cc-ing libvirt-devel on patches that deprecate
> QEMU interfaces so that we can update our code in time before the
> deprecated interface is dropped.
>
> BTW, libvirt maps "duplicate" to:
>
> /**
>  * VIR_DOMAIN_JOB_MEMORY_CONSTANT:
>  *
>  * virDomainGetJobStats field: number of pages filled with a constant
>  * byte (all bytes in a single page are identical) transferred since the
>  * beginning of the migration job, as VIR_TYPED_PARAM_ULLONG.
>  *
>  * The most common example of such pages are zero pages, i.e., pages fill=
ed
>  * with zero bytes.
>  *
>  * Since: 1.0.3
>  */
> # define VIR_DOMAIN_JOB_MEMORY_CONSTANT          "memory_constant"
>
> Jirka
>

Interesting. I didn't notice the existence of "duplicate" for zero
pages. I do think the name is quite confusing. I will create the
"zero/zero_bytes" counter and a separate commit to deprecate
"duplicate". Will add libvirt devs per instruction above.

