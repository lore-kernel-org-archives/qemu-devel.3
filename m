Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6607EEC1428
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNMF-0004tS-88; Tue, 03 Mar 2026 05:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vxNM6-0004nb-FZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vxNM4-0005AX-Jh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772535113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeqp3qR1dyEMnSwd0jNInzAnfFep6sz/aLNKIQhH/iE=;
 b=JY7Q+k01ZnlEUr7TCjDPkK5apRebrU7QzEKC1WP9EJ1ePwtmKrky9KZvjQxHQ/Dv0G6hMW
 4UdvpQ12Md+5igosp++6AHTDWEF0TOlZGel7SUEB2+6tHxh39gkTQYTNskIkaBUKMnTfIJ
 D/IV/alur4znoiEPrY0hut5x1snQ8g8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-yxwNsJq4OIimFx0lat8dXw-1; Tue, 03 Mar 2026 05:51:52 -0500
X-MC-Unique: yxwNsJq4OIimFx0lat8dXw-1
X-Mimecast-MFC-AGG-ID: yxwNsJq4OIimFx0lat8dXw_1772535111
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-503342386c7so57923861cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535111; cv=none;
 d=google.com; s=arc-20240605;
 b=STc3mNaGsNeq+jWTTY9M8XvNm7Ni5BSp7xCvlINGbU/FJ0fxfmgp6eJ+KVcdEymXeE
 b0tSIcwycR3Nsv3jUondsMhA6oW1qj/Ci2ZETqAtaJm9mInvwNeloFradtreIW8xSpwy
 LxKS0M9FR2LVO5LP8WztJMQYNXk/8dum0SSE7UPLnsRBn7f/VVjvJgcLBKnh86nhX8pm
 98bm2RjAhhbSzAUBgQXEPIa+LrHsvxPoRH51YuGetU7Ti4XRao66jhaKcJEpnrkYISwE
 2fwYgTwK2oj8eAwbaFLRx/EdpyV3cef19cpdn5l5xBiiTkaXqEGC5W+pNdVVf0O3EdEc
 jGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qeqp3qR1dyEMnSwd0jNInzAnfFep6sz/aLNKIQhH/iE=;
 fh=xOMUjlFLKQjD/n/eR0dhTuHN3+73GLok2fPxfadBzsk=;
 b=JqVXx+4Doh9xOt3YnFnvQJegf/xJ2mL4Z/r3CMOeE1m2go+8XPDkPU5++uPobIZBxI
 aKIN+1Be2g0LgflVE20CLNziI8QsEV3z0/nnr2PWmTsW9VJkb6bfReLwsTR2UEQVAzYK
 XO70eUZ8CJhaEhi9CUQ17rECG0MkbXzsmEgydbClNnrWL618EnC+trzsQKNGdX0Umuaw
 Dzr4ng8F4XWXzf4TuRrA/+YhmZ9iomN1CsAvezz/t0xBCaI4i0JfWoTrX4dyGOcEqiPB
 HrKLXn3ljebeqcn5nFbJ/rTqs++pYkGFkGl04JLsvNQnJWJ4A9ZQ8jy8iUWY1buYg5kX
 NYRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772535111; x=1773139911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qeqp3qR1dyEMnSwd0jNInzAnfFep6sz/aLNKIQhH/iE=;
 b=RYu6B+Mz/K3CIfxDqSUtYeuumKzsbfbvkITvu9WdZj2eOefjaXvcTCIEHZheIeGo5s
 Hif2tUjBVA2c3IBAiqOOCbUVxpe9D+2pD/d+chhVDaODtYoAoFBrXf5c70rI/CXWg5Dw
 ou2w8JBFdCRm4PzVNAFvpmuvuv7OziTlzej22CLR1dM0mm/AT3G/wK340uJl8uyXdPwY
 RDT72GubjxoJLjdy2eDDNzn9TAe9S5EHYcxbxCXhOAyNBTciUhM9AXXZTPFoXlZ1UjNE
 ILoXLtKjnWxRgQgJ3GEm2TgQW3qAA1eobz0wPXZ61gKVQ8ePt+VmwxrGMRN5f/3amjuN
 gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535111; x=1773139911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qeqp3qR1dyEMnSwd0jNInzAnfFep6sz/aLNKIQhH/iE=;
 b=pbFrKAnOVxOE9LaPd81XjESHMcywCoBMT85HfkG9Q64VNXOYLIZsBeU6cz76olGErP
 UZg4awurFbAft+fmg07faSHM8CSmvyAd7dMCOkUQDtOivKXMUNaBRMH8y8ggZATJFDQz
 p0MWjL5gKJYVk1G5cYlmPSvF5gYNcuxN13z1HCh24mrndw7RGfV0G9LUtRClxbT1chxH
 CYAJRSi03f7y89d42i/aMnVKVF8mM2w3Zbka7yVndyIpY3zVRJBpU5aWKPRWNZd8e1at
 3AFZpjfHJ1pQEvBW1AFlIiIf/kdtNUNBVQV0+A2aw9TFvh1Tlp05BW4PSMKlJxc+MAvu
 HlCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe8Ju1JZzfoi5KaKFfr/++O4nUQlfB6VMh0tcZAZF6AFM6YchrECQb/89BZGnemiXpznHn6eNbOl3A@nongnu.org
X-Gm-Message-State: AOJu0YzP0+FTAWFxrQ2HEEIHVk7W3rPB6CM4mCqv/a1WQhGDR4HV5odm
 HbpS7UD4/GJE14riWINjwjhnOrNGwSVS6xSCYreZ8cVBkhMhTkLET0+h4E5PMKrfmZ3VddKFmlw
 f1v2+UBOMpTGSvavUyHS20ms8LhdlWMLRU5wmksxSVNpgZkwAF0MgUa4hvHFCEGtxW/OSVmFLWO
 6dzm4AntDtHqRQ3YCNOKgK+IcsAPDA1gI=
X-Gm-Gg: ATEYQzxVJbIHpVaWVTrqE4JUKz4BRHWuUPtAxxTrs9EFSxwSe05v/Gqc4P9+0Hl5K2I
 lI/buQ9Z04lE6dD9mx8RWLjCyBSHExfkY5th/OwPLCYQsXUptaoXt1mvNG4wC3h6aZV1km5luqv
 u1FCdX2O6dv3dwEAM7kxrJb+AdG3z09GgmJDTEyNBohLXPbzEwGNgwBktMOj8TgpEbqtg38YoIo
 wYlBZXzpK4hTpW7ihny6cbEeOf4nNCttddu4yk=
X-Received: by 2002:a05:622a:51:b0:4ed:b06b:d67d with SMTP id
 d75a77b69052e-507527cd3e3mr184411951cf.45.1772535111463; 
 Tue, 03 Mar 2026 02:51:51 -0800 (PST)
X-Received: by 2002:a05:622a:51:b0:4ed:b06b:d67d with SMTP id
 d75a77b69052e-507527cd3e3mr184411821cf.45.1772535111075; Tue, 03 Mar 2026
 02:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <aZ8xlrL2xQtoN9MI@x1.local> <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
 <aaBFxY6PUsNrAYft@x1.local> <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
 <CAE8KmOzmk195FKCK-J6qVnj=wcDp5HC6+xhbNhturYo-Ls0egw@mail.gmail.com>
 <aaXsj5osdbUNbttY@x1.local>
In-Reply-To: <aaXsj5osdbUNbttY@x1.local>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 3 Mar 2026 05:51:40 -0500
X-Gm-Features: AaiRm50bkI_oVEtgctGqRmzJJJlZmGPKYd2ouhT__UIgu2zguWW65j82xZLChOU
Message-ID: <CAK3XEhNoo-e6xriy_viiyzac0MLTMbC9zcREHVZoYgfsKxAd4Q@mail.gmail.com>
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, 
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 2, 2026 at 3:01=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 02, 2026 at 04:58:50PM +0530, Prasad Pandit wrote:
> > Hello all,
> >
> > On Thu, 26 Feb 2026 at 21:46, Ani Sinha <anisinha@redhat.com> wrote:
> > > >>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
> > > >>>> Currently the code that adds a migration blocker does not check =
if the same
> > > >>>> blocker already exists. Return an EEXIST error code if there is =
an attempt to
> > > >>>> add the same migration blocker again. This way the same migratio=
n blocker will
> > > >>>> not get added twice.
> > > >>>
> > > >>> Could you help explain why it will inject two identical errors in=
 the first
> > > >>> place, and why the caller cannot make sure it won't be injected t=
wice?
> > > >>
> > > >> Likely due to a bug in the code. For example if the init function =
that
> > > >> adds the blocker is called again and the caller does not handle th=
e
> > > >> second init call properly.  This came up as a part of the coco res=
et work
> > > >> where migration blockers are added in init methods. They need not =
be
> > > >> added again when init methods are again called during the reset
> > > >> process. The caller can handle it of course but adding a check fur=
ther
> > > >> down the call stack makes things more robust.
> > > >
> > > > IMHO if we want to make it more robust, we shouldn't return an erro=
r
> > > > because the caller may not always check for errors.
> > > >
> > > > Would assertion suites more here?  Because migration blockers are n=
ot
> > > > something the user can manipulate, so it's a solid bug to fix when
> > > > triggered.
> > >
> > > If Prasad agrees, I will send something.
> >
> > * The majority of the places I see constructs like:
> > =3D=3D=3D
> >         if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
> > OR
> >         ret =3D migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, &loc=
al_err);
> >         if (ret < 0) {
> >             error_report_err(local_err);
> > =3D=3D=3D
> >
> > * So setting **errp and returning a negative value is consistent with
> > that. Aborting (assert(3)) for trying to add a duplicate blocker
> > object seems like a harsh punishment, considering that'll happen at
> > run time and the user won't be able to do much then.
>
> If it's a programming error, then it shouldn't happen at runtime.  The
> current paths to fail this API was not for programming errors.
>
> If this patch isn't required, IMHO we can at least drop it in this series
> and make it separate.
>

Yes this patch is dropped.

> Thanks,
>
> --
> Peter Xu
>


