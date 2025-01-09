Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED50E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVps8-000123-T3; Thu, 09 Jan 2025 05:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVps6-00011A-SO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:34:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVps5-0004uf-7A
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736418876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qdglpkuI6XfhuNtfsqPMGY2DPnwha9deNaLQflK/Vc=;
 b=DNJbaZ7ZCBu9bQHZvP01lC15Bb1GpCxcYxgndKhaowx7zMCgLCXUBSxUc21u3dWyHYpwvd
 aSQfKP792AW42DexVHDUJMeRlV8ZNDTW5K6h3C8BFrYtXvJ5JJov3SERfraLrnB35xZYfP
 t1iiRRy5K7eGQxutTyZzmN1PuyXisvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-VNnEKGiVMHmKKHbIkEozsQ-1; Thu,
 09 Jan 2025 05:34:33 -0500
X-MC-Unique: VNnEKGiVMHmKKHbIkEozsQ-1
X-Mimecast-MFC-AGG-ID: VNnEKGiVMHmKKHbIkEozsQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 359DE19560BB; Thu,  9 Jan 2025 10:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D105019560BC; Thu,  9 Jan 2025 10:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C091F21E6924; Thu, 09 Jan 2025 11:34:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
In-Reply-To: <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
 (John Snow's message of "Wed, 8 Jan 2025 17:58:03 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
 <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
Date: Thu, 09 Jan 2025 11:34:28 +0100
Message-ID: <87sepss2bv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This method adds the options/preamble to each definition block. Notabl=
y,
>> > :since: and :ifcond: are added, as are any "special features" such as
>> > :deprecated: and :unstable:.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
>> >  1 file changed, 32 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index 6f8f69077b1..85c7ce94564 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -38,7 +38,7 @@
>> >  from qapi.error import QAPIError, QAPISemError
>> >  from qapi.gen import QAPISchemaVisitor
>> >  from qapi.parser import QAPIDoc
>> > -from qapi.schema import QAPISchema
>> > +from qapi.schema import QAPISchema, QAPISchemaEntity
>> >  from qapi.source import QAPISourceInfo
>> >
>> >  from sphinx import addnodes
>> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
>> >              # +2: correct for zero/one index, then increment by one.
>> >              self.add_line_raw("", fname, line + 2)
>> >
>> > +    # Transmogrification helpers
>> > +
>> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
>> > +        """
>> > +        Generate option lines for qapi entity directives.
>> > +        """
>> > +        if ent.doc and ent.doc.since:
>> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
>> > +            # Generated from the entity's docblock; info location is =
exact.
>> > +            self.add_line(f":since: {ent.doc.since.text}", ent.doc.si=
nce.info)
>> > +
>> > +        if ent.ifcond.is_present():
>> > +            doc =3D ent.ifcond.docgen()
>> > +            # Generated from entity definition; info location is appr=
oximate.
>> > +            self.add_line(f":ifcond: {doc}", ent.info)
>> > +
>> > +        # Hoist special features such as :deprecated: and :unstable:
>> > +        # into the options block for the entity. If, in the future, n=
ew
>> > +        # special features are added, qapi-domain will chirp about
>> > +        # unrecognized options and fail.
>> > +        for feat in ent.features:
>> > +            if feat.is_special():
>> > +                # We don't expect special features to have an ifcond =
property.
>> > +                # (Hello, intrepid developer in the future who change=
d that!)
>> > +                # ((With luck, you are not me.))
>> > +                assert not feat.ifcond.is_present()
>>
>> Nope :)
>>
>> The attempt to add a conditional special feature now fails with
>>
>>     Sphinx parallel build error:
>>     AssertionError
>>
>> If you want to outlaw conditional special features, reject them cleanly
>> in schema.py, document the restriction in docs/devel/qapi-code-gen.rst,
>> and explain why in the commit message.  Recommend a separate commit, to
>> make it stand out in git-log.
>
> Do you advocate this? I wasn't sure what it *meant* for a special feature
> to be conditional; I couldn't conceive of what it meant to have an ifcond
> for "deprecated" or "unstable", for instance. It sounds like it isn't well
> defined, but we happen to not expressly forbid it.

Semantics are clear enough to me.

"Conditional special feature" combines "conditional feature" (which is a
special case of conditional thing) with special feature (which is a
special case of feature).

The QAPI schema language supports compile-time conditionals for certain
things.  Generated code behaves as if the thing didn't exist unless its
condition is true.

QAPI schema features are strings exposed to clients in introspection.

Combine the two: a conditional feature is exposed if and only if its
condition is true.

Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if
CONFIG_BLKIO_VHOST_VDPA_FD.

A special feature is a feature that has special meaning to the
generator, i.e. we generate different code in places when it's present.

Combine: we enable different code for a conditional special feature only
when its condition is true.

No existing uses so far.

Implementation is straightforward, too.

Any code we generate for a conditional thing is guarded by #if
... #endif.

For features, we generate suitable data into qapi-introspect.c.

For special features, we generate a little additional code here and
there; look for .is_special() to find it.

Bug: this additional code lacks #if ... #endif.  Simple oversight,
should be easy enough to fix.

> I guard against it here because, similarly, I have no idea how to handle
> the case where it's true.
>
> I didn't realize we technically allow it, though ... would you like me to
> move to expressly forbid it in the parser? (Failing that, I have no idea
> how to display this information otherwise, so I'd need you to sketch
> something out for me; so my inclination is to forbid it as you suggest.
> Future developers can always lift the restriction once they have some
> use-case in mind and a plan for how to display that information.)

I think we should first make a reasonable effort at figuring out how to
handle conditional special features.  If we fail, we can add the
restriction instead.

How do you handle features in general, and special features in
particular?

How do you handle conditionals in general?

How do you combine feature and conditional?

How could you combine special feature and conditonal?

[...]


