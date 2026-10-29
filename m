Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E1606A334
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWVBtvCd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=o8UFLdAr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQbB-0002Jc-Rf; Thu, 29 Oct 2026 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMQbA-0002JK-4I
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMQb7-000360-74
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793282115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMo0fOzp+7I/bZUbfSN0P8MCJkRGxXtEQBQdCPdbkyE=;
 b=MWVBtvCdufdoF9ZHkFhYpKzu5RVD8FJiBmEasPG9AR4+GQ3z6g+gZIBPxRWxBzW9G8nfG+
 hnzCwgSsDzCC4q52FA14vzebUVD4Q1Vq1QMhlj/wU7nQfHajBGL7HoJ1WhxXjSjYuop4QX
 /+oAwog7ppVPrUyzrzDXgJ9wjw11D5c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-MN1K6aKgPZGacCe2fMQMjg-1; Thu, 29 Oct 2026 09:55:12 -0400
X-MC-Unique: MN1K6aKgPZGacCe2fMQMjg-1
X-Mimecast-MFC-AGG-ID: MN1K6aKgPZGacCe2fMQMjg_1793282112
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso2147175a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282112; cv=none;
 d=google.com; s=arc-20260327;
 b=HwVDPDJfiH8hgXNVA6r6uP3IsOAxdLdi9VaGVZGs3tjWA2soDsvRGC7/QV05BJCbii
 Q3z1VTeqFWhpg4i7lh0cVxwuTVTlsXZg5YJMMzLp6Q58u2V/ySN3Ir2Kvhp+sGMj//xw
 hbRXK6yVsnXoe9+Btuz1kj2LYzDFlfgTUG4ExWHC5/4EnMG1sym1UF54GPfAZGU/DIHw
 xf8jFtGPF5o7skP2zi/inaQOTQNQE9JRdjbbDkiG0BcaLkRZpsQVcv0zFQfyViMjvdYa
 O2ezZ4m12tmDPEP7vabfzPXg/n4h2/XyZVJdchGGWtX3GTGVUUV+oPXnu+44cstLu8O9
 DeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fMo0fOzp+7I/bZUbfSN0P8MCJkRGxXtEQBQdCPdbkyE=;
 fh=x4K5gk7xv7OXRecWWGnitIYUYxAMoMoRt5GQc/oAfM8=;
 b=bennITJeg1qNub3XG92URzmvnIMAmmMs1MYa4XpxzxqJGKGwM+KIk6u1+SZE0HIshG
 sKrvXo3bUfc0RQpf4GX9IzCy0Ft3anXoNzwUj1B1J9o4wNQ85yUZhwNipim2mGZHaSWb
 KMVw7sMSGob9SV6y2KjfaLbU2IdgIaPPiTVYj6DYo0xosUMpfn9IG7UEpDI4fjwhpmv7
 Ub6Siipr3yvGVT87D+8tQguVZGINAK1BXQ9P2rkj195nQWPmSKpwXi8KezZwHqzCA4LU
 6n24Zf2n/ZPD3mUUzF8teigbu8mI6tXzUiSiqmsek4pkb1vtLYN+VAw4ReN/zcaBS4Y3
 fGxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793282112; x=1793886912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fMo0fOzp+7I/bZUbfSN0P8MCJkRGxXtEQBQdCPdbkyE=;
 b=o8UFLdArqfklFQr4Vd6mZN/jOKZj41yXlam9J0tf/qzIMpXNsM4g3LlJLbyZnJBWPj
 J8320lEwW2O2EIJNhr6yTTSsTIKtXNmwcoa/DUJe5+qMbyWBBafVspb3sT71mPwQ6sjw
 QpJO+/b93yDxPFyRK9a5ataWRvs1nN1/JSdgQwvs72LRyrQJSk9tAZlZPKkn9kSGbywz
 vacDnlA5FvWS8vvdK7KyM87eTCiP2E0Rwb7iPO+fnRdxttKZIWfmLB2mriT4Am9rzb0k
 4P4Lb+y6cmwEPbVCEB3o0KwJJ9Qn48KrQ7RQ7r/b1r1A0YBX9x4SosBG0W5KtNGit/Xd
 FbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282112; x=1793886912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMo0fOzp+7I/bZUbfSN0P8MCJkRGxXtEQBQdCPdbkyE=;
 b=t+XgbYPW3B75YeddhqGg1vHrvjbCVCx6teLx72xZoJxt/ruEQPqUW3gvER+nVLiuFh
 0/3+OIRn9t8Dt91ahiinJVjEIEe4VcJXrFIQCmmuoZdFezS2AV84CRHK2ObM4ymOl2gr
 xjIqHxWYMSx+JJfrRFpIVP4X86naDmdRokE69j/RH9IOhpu7e5VZi1y0gW9XMh069A8L
 bpNZO2rBz3mTmTSeQNJuwCmKQXvyKdCxq1cHnAzfKijR1qrf0BQMrp8qJHGA9Ct38FGA
 hhw8f/k8fhI5r3WVUc20tRKp9zBFWQcro2OCWfEgs5nBYPpXSEAdIrd5ZVKklae+RAaV
 GiOQ==
X-Gm-Message-State: AFq9FYJuoiR9JMHPrJQsYzRAd8uQcA/RA1PwGJ/grzoyIxCiOjs6t2gp
 63+qqkRWxK+WyXgCBZ2q3eMepgGnbMU9v+Vvcr67dyEUHmGnYkGbHY/KSyAHsDwgN1m6yA+uOyW
 zdkuWsN4sLMEJMHeUfd6rn0zmy06zsh3+uwrwWpO/zxgPYcqFEy0s83wyJAtIuSZXKV3X5Wo1Zw
 d+adQYPI0x6zZqblykgajRhkYNjFjK2tQ=
X-Gm-Gg: AYBFou0gqNu60AbRmisASsA116vJwV5zodCU33e93TCjkGKasrb3fBbhfMBetw6QiNr
 7wGB2ynb9wRmbB2D5dgW9lJkI/j8r1BQaKT6lUw4y4WwWQOvm1AaHCZNrP1lSDLbUSASuTnFV3D
 tSPt15AlL3yvUyX/sblcEGpTuV+BCloGf+gIEhx51zA0uXdNRD0+HHO3vS3MKHW1WRn6BWwRNOo
 jVIkQuC5uYT9od6nkzEWH2O3KMcruU5bq0NfIFnOdDMkq44IvnwUMxyOa80F90klz8zej+QvCKx
 Ng==
X-Received: by 2002:a17:90b:57c4:b0:3ac:a521:95c with SMTP id
 98e67ed59e1d1-3ae583203d6mr4489576a91.58.1793282111610; 
 Thu, 29 Oct 2026 06:55:11 -0700 (PDT)
X-Received: by 2002:a17:90b:57c4:b0:3ac:a521:95c with SMTP id
 98e67ed59e1d1-3ae583203d6mr4489555a91.58.1793282111063; Thu, 29 Oct 2026
 06:55:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87ik2tj0g3.fsf@pond.sub.org>
 <CAMxuvazmyYb4d7neLQP4v4ZoKZfQfD1iDqA4gtC+QV5nBCging@mail.gmail.com>
 <87pkwujbhf.fsf@pond.sub.org> <871p98d3jf.fsf@pond.sub.org>
In-Reply-To: <871p98d3jf.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Oct 2026 17:54:58 +0400
X-Gm-Features: AclHuK9K7xyP9DFiVzsbNKYB3_92sw1KwfVdH0aUEiKGlBxXcP6X0cO7mDksmWc
Message-ID: <CAMxuvaykdbHxWmxhg1OXpLDv6pxP2EKA7z3O0OYW69BoEBu7SQ@mail.gmail.com>
Subject: Re: ObjectPropertyInfo design
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 29, 2026 at 5:45=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> > [Possible improvement to the QAPI/QMP QOM introspection interface...]
> >
> >>> Thoughts?
> >>
> >> I like it overall.
> >>
> >> But this goes beyond the intended scope of the series.
> >> Blending/merging QOM type & QAPI type would warrant more design
> >> research. So covering child<> & link<> are out of scope of the current
> >> qom-qapi series. I think the addition of qapi-type shouldn't be
> >> incompatible with a future proposal, after all all properties should
> >> have some 'wire' type (link/child are paths). But we can drop it for
> >> now or just rename it x-qapi-type until we agree on the new
> >> introspection.
> >>
> >> my2c
> >
> > Adding @qapi-type with feature unstable means we don't have to worry
> > about the external interface now.  One less hurdle for merging.  I like
> > it.
> >
> > Whether changing the @type values is safe remains somewhat unclear.  Se=
e
> >
> >     Subject: Property types changed in this series (was: [PATCH v7 00/6=
5] Hi)
> >     Date: Wed, 21 Oct 2026 18:29:40 +0200
> >     Message-ID: <87tsmfkoej.fsf@pond.sub.org>
>
> We're about to miss the soft freeze.  Not your fault; I've been awfully
> slow reviewing this.
>
> The series is quite big.  If we can't get it merged, we'll have to
> rebase and update it.  Not good.
>
> Here's a possible way forward:
>
> 1. We tweak this series to retain the existing @type values.
>
>    As is, the series changes @type to the QAPI type where applicable.
>    This is an improvement, and *probably* safe enough, but I'm reluctant
>    to accept the risk this late in the development cycle.
>
>    I can do the tweaking.  It'll be mildly icky, but should go away
>    fairly soon.

Tbh, I don't think changing @type is going to hurt, and if it
effectively does, we still have the rc period or backports as
necessary.

>
> 2. We mark @qapi-type unstable for now.

yes

>
> 3. Try hard to get it merged in time for 11.2.
>
> We can then improve on top at our leisure:
>
> * If we convince ourselves that changing @type values is worthwhile and
>   safe enough, do so early in a development cycle.
>
> * Hunt down the remaining properties that don't use a QAPI type.
>
> * Explore more comprehensive improvements to QOM introspection.
>
> * Settle on a new QOM introspection interface, deprecate the old crap.

I think we should flush the queue, because it's natural to stop
working on a "topic" when it reaches >50 pending patches. And it
prevents other people from joining the effort too. If it takes >6
months to get 50 patches accepted, the QOM-QAPI dilemna is going to
stay for a long time :)


