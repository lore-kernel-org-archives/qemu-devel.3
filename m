Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D3EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkWm-0004Rm-L3; Mon, 11 Mar 2024 14:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkWk-0004HT-QR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkWj-0002Pp-7g
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710182252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+cxNXS7Mto1olaj2QDHMkzYFAE2R4feCV5GrAb9DQ8=;
 b=dNVWIB9kP2FT6tK0UF7eg70yMytoTRCjX6wb6O7OB7+UNkX90F//LI0c5iiB2G+VZduBTO
 cbxYTeIbqOKjx/z1LRuPqzK/PrHaBPO0AM9rT5nydjoJxmLShtIgnAT+kUJ01BjEqljOln
 AfMqffy2PEYpJgYPHv9H/4KNRV74aRo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-RUhSfU2ZPGCGYVtNns8tdg-1; Mon, 11 Mar 2024 14:37:30 -0400
X-MC-Unique: RUhSfU2ZPGCGYVtNns8tdg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29bad31f920so3113729a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710182249; x=1710787049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+cxNXS7Mto1olaj2QDHMkzYFAE2R4feCV5GrAb9DQ8=;
 b=hnVNIBs4J1GBw6EafQGT17xkCjwVdnucoq62ZRKUGA0Fcir0lAJj/C8OgxXCwzMA67
 ZYoj2cvZ2jTxzDOAlo+4tHOrzOCZ02XaguJ4Mj7v50TaeCeXxDx/eAYFrjUdYflKw+O1
 zbh+sictUG4n1/15tWOiy6b3EJEwdc4QYzXbH68pq7fFdzdd0WQ2smI4uTV6u0frI+HJ
 EnhwJ5pPGuNNv4OMems/WUHIuY/Pr6xR/fA1WDPsjTyaKWDP9Peg8o5qn1eMdIW+mlTi
 1aUtBg8+xDjxvDEH+CD/cRu3HSJj/G3o2svDZ2dyq4r/HzRt0V5Ke6Rzug7USJbeEgcx
 JujA==
X-Gm-Message-State: AOJu0Yz2qMbya4fd0fenFKqoSUDAiMQ3iHfIZZelXMnr2taSJ4Stj29Q
 UQ389Tk03FYHM+V8tArOfHAIkCeb9IrlU57mtjUkmZQXm2598N7OgNxYj53pRm9aBXqxkPUJ9HW
 x1kj4/uRKEy3CAlC+Bk71/K6RryN/D9iCGLffWCk8lFgEK4CC1z4WfVwONsW2y2RKIcEL2mIpZp
 iN5ywH3pIV+XdlGN6ZDvc+bx7SElA=
X-Received: by 2002:a17:90a:6f03:b0:29a:795:a132 with SMTP id
 d3-20020a17090a6f0300b0029a0795a132mr5424537pjk.18.1710182249007; 
 Mon, 11 Mar 2024 11:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHva26hBlEobwulsOmjtndWe/aT5BapaCd9veyJCWC0XsIDaMArq69sd+y4yBw0ZMO0E9WihX8I4gKEh1XbX3w=
X-Received: by 2002:a17:90a:6f03:b0:29a:795:a132 with SMTP id
 d3-20020a17090a6f0300b0029a0795a132mr5424518pjk.18.1710182248726; Mon, 11 Mar
 2024 11:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-10-jsnow@redhat.com>
 <87v86jbee6.fsf@pond.sub.org>
In-Reply-To: <87v86jbee6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Mar 2024 14:37:17 -0400
Message-ID: <CAFn=p-aCvfk_6kjhn8W02_Wjn+nSjP1KmFQ7dfFgRAvqKx0j8A@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] qapi/schema: assert resolve_type has 'info' and
 'what' args on error
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 20, 2024 at 5:48=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > resolve_type() is generally used to resolve configuration-provided type
> > names into type objects, and generally requires valid 'info' and 'what'
> > parameters.
> >
> > In some cases, such as with QAPISchemaArrayType.check(), resolve_type
> > may be used to resolve built-in types and as such will not have an
> > 'info' argument, but also must not fail in this scenario.
> >
> > Use an assertion to sate mypy that we will indeed have 'info' and 'what=
'
> > parameters for the error pathway in resolve_type.
> >
> > Note: there are only three callsites to resolve_type at present where
> > "info" is perceived to be possibly None:
>
> Who is the perceiver?  mypy?

Deep.

Yes.

>
> >
> >     1) QAPISchemaArrayType.check()
> >     2) QAPISchemaObjectTypeMember.check()
> >     3) QAPISchemaEvent.check()
> >
> >     Of those three, only the first actually ever passes None; the other=
 two
> >     are limited by their base class initializers which accept info=3DNo=
ne, but
> >     neither subclass actually use a None value in practice, currently.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index e617abb03af..573be7275a6 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -1004,6 +1004,7 @@ def lookup_type(self, name):
> >      def resolve_type(self, name, info, what):
> >          typ =3D self.lookup_type(name)
> >          if not typ:
> > +            assert info and what  # built-in types must not fail looku=
p
> >              if callable(what):
> >                  what =3D what(info)
> >              raise QAPISemError(
> <
>


