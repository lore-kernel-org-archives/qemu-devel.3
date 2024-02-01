Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC02C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 21:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVeuZ-00033j-9Z; Thu, 01 Feb 2024 16:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVeuV-00033D-Ib
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVeuR-0000us-PY
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706824067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvtWI5QvqtWsp1AEdmEyrss5bMJq5HccmuhjTernLJs=;
 b=bsiYsJhtaqX0PTtZ4WxashjxFBWKActzqPiEACtSlCJ8BcP2WVEo2WSeIfMH8akENddwDT
 BEPLZlbCbtBNyJvJBqlB1okTDxv6FHjwzhOoJnir2t5CYqyls/0rX7zYLfkZj1zMqJWD0V
 N3jrWA8++Hwaw2b0durPknzOMoFDxF8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-hwGuOUR1O02nPpi0lqMMMA-1; Thu, 01 Feb 2024 16:47:45 -0500
X-MC-Unique: hwGuOUR1O02nPpi0lqMMMA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2961cb4f586so974453a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 13:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706824064; x=1707428864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvtWI5QvqtWsp1AEdmEyrss5bMJq5HccmuhjTernLJs=;
 b=P/W+GLDOcUAONHhvZR2rhYKtMLvLva6xVUyxYg07PZDZ7WiDz8A58J2JbglDt4WEHJ
 +5PSz4KHJjJleFI781jtlRlrHe7KOHh4br00XvDxlhsHAzdaCW9HaXq5k6WUN2hJkINf
 Dahbf344X1r42gwHaXqswssdAvPXicrdcWbH4nPDW9i/nfTP65LSieRoJl3LwGFGcdPt
 ah7EZHlebNcjl1KFUFqvFAjalxvW80Y09v3N3ZtYaJNsFd7UbHE1D18Tvy9r5FnpQNtu
 z91m/+Hqs+zjN1BPm8QdBvR2GIuZsbGJrQjYEdMLLG4C1fUPx+RXGngKj1MHhGW485Eh
 VBOQ==
X-Gm-Message-State: AOJu0YyVWNRFEUNC7XIVzNHiT1UuVB7VVXktE0loyA1J2AnhI26JCxsF
 gDn2gL6o1CEF//aEWMvy5vhAVlYNBCWdMvk9LS635yrVR0Jgf4/0LTAjswo9IpsRuW278ldc/o+
 LY28t1LEFCsv6FH4U/BJRyN3ox1CbnUVRc9Ybfld/isio77erZTcx1m67La/hyoLqicWYfJ3EuP
 96p9kd2CI1sT0WPsPOv3C/3iFp/AI=
X-Received: by 2002:a17:90b:1056:b0:295:eb30:fe55 with SMTP id
 gq22-20020a17090b105600b00295eb30fe55mr5495928pjb.18.1706824064289; 
 Thu, 01 Feb 2024 13:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcbNdCA7XPuFfj220LzvKXT8ZtaJb0G2Q/wTu230R4Uz1dVctGXNbf76+/zFwx9qbosgWV+xCNxp3ohtaz0zQ=
X-Received: by 2002:a17:90b:1056:b0:295:eb30:fe55 with SMTP id
 gq22-20020a17090b105600b00295eb30fe55mr5495916pjb.18.1706824064001; Thu, 01
 Feb 2024 13:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20240120095327.666239-1-armbru@redhat.com>
 <20240120095327.666239-5-armbru@redhat.com>
 <CAFn=p-aUAS7cxRsOm7DCtjYFxDgt82F3OnA5Kao-e8ujCvihww@mail.gmail.com>
In-Reply-To: <CAFn=p-aUAS7cxRsOm7DCtjYFxDgt82F3OnA5Kao-e8ujCvihww@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Feb 2024 16:47:33 -0500
Message-ID: <CAFn=p-Yd7Dwb5TaTL8ZU9Me=rwSz6PrP5JpTODFgEmxKUMqjtg@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs/interop/bitmaps: Clean up a reference to
 qemu-qmp-ref
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 1, 2024 at 4:45=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Sat, Jan 20, 2024 at 4:53=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > docs/interop/bitmaps.rst uses references like
> >
> >     `qemu-qmp-ref <qemu-qmp-ref.html>`_
> >     `query-block <qemu-qmp-ref.html#index-query_002dblock>`_
> >
> > to refer to and into docs/interop/qemu-qmp-ref.rst.
> >
> > Clean up the former: use :doc:`qemu-qmp-ref`.
> >
> > I don't know how to clean up the latter.
>
> It used to have anchors that seemed to have semi-stable names, but I
> guess that's not really true anymore.
>
> Now it's just stuff like `qapidoc-423`. Well, neat...
>
> No, I think this requires the Real Fix :tm: now...
>
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  docs/interop/bitmaps.rst | 4 ++--
> >  qapi/introspect.json     | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
> > index c731be2f01..ddf8947d54 100644
> > --- a/docs/interop/bitmaps.rst
> > +++ b/docs/interop/bitmaps.rst
> > @@ -167,8 +167,8 @@ Basic QMP Usage
> >
> >  The primary interface to manipulating bitmap objects is via the QMP
> >  interface. If you are not familiar, see the :doc:`qmp-spec` for the
> > -protocol, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full
> > -reference of all QMP commands.
> > +protocol, and :doc:`qemu-qmp-ref` for a full reference of all QMP
> > +commands.
> >
> >  Supported Commands
> >  ~~~~~~~~~~~~~~~~~~
> > diff --git a/qapi/introspect.json b/qapi/introspect.json
> > index ebc4e199d2..8df1ce85ed 100644
> > --- a/qapi/introspect.json
> > +++ b/qapi/introspect.json
> > @@ -260,8 +260,8 @@
> >  # Additional SchemaInfo members for meta-type 'alternate'.
> >  #
> >  # @members: the alternate type's members, in no particular order.  The
> > -#     members' wire encoding is distinct, see :doc:`qapi-code-gen`
> > -#     section Alternate types.
> > +#     members' wire encoding is distinct, see
> > +#     :doc:`/devel/qapi-code-gen` section Alternate types.
> >  #
> >  # On the wire, this can be any of the members.
> >  #
> > --
> > 2.43.0
> >

fyi/to whom it may concern:

"what cross-reference points are defined in our documentation?"

> wget https://www.qemu.org/docs/master/objects.inv
> python -m sphinx.ext.intersphinx objects.inv | less

nose around to your heart's content.

--js


