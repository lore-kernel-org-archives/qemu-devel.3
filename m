Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A60C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdFr-0006JQ-M8; Tue, 14 Jan 2025 04:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXdFp-0006JB-2I
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXdFm-00048H-Cp
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736847028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fybRQRYLQ7VSRlo8k67QjTReNzXJscC7ZnEfdCJwCmo=;
 b=Oq9xT3QKqVUvmglO680ui8cDHT7mUcMTVN+VNocq2l6CkPtUjd3au3CAwZ750wpNXIxSsI
 2B0+B4O607U64laMpNPNPGL8crhVQ/hBgTDYFHaweCuSyvu0ieiuu7xkTRfrGtFkXxcKma
 EjE/RqKg1YS80hOS9MwbiJoPf0vq3JQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-M2XpTINeNHi3rZz8QrHuqg-1; Tue,
 14 Jan 2025 04:30:22 -0500
X-MC-Unique: M2XpTINeNHi3rZz8QrHuqg-1
X-Mimecast-MFC-AGG-ID: M2XpTINeNHi3rZz8QrHuqg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EE8E195605E; Tue, 14 Jan 2025 09:30:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BDA195608E; Tue, 14 Jan 2025 09:30:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7534C21E6924; Tue, 14 Jan 2025 10:30:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
In-Reply-To: <CAFn=p-Z2xsGO6MHzHiVMF9tTPSrtFytwdhbY=ipJpY8VUGYZ0w@mail.gmail.com>
 (John Snow's message of "Mon, 13 Jan 2025 15:53:19 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
 <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
 <87sepss2bv.fsf@pond.sub.org>
 <CAFn=p-bum9NvZNEYRKCD6Wh_GucSmT33YT9aEqK80u+2d7cUQQ@mail.gmail.com>
 <87v7um2760.fsf@pond.sub.org>
 <CAFn=p-Z2xsGO6MHzHiVMF9tTPSrtFytwdhbY=ipJpY8VUGYZ0w@mail.gmail.com>
Date: Tue, 14 Jan 2025 10:30:18 +0100
Message-ID: <87y0zdivyt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Fri, Jan 10, 2025 at 7:19=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Thu, Jan 9, 2025, 5:34=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@r=
edhat.com> wrote:
>> >> >
>> >> >> John Snow <jsnow@redhat.com> writes:
>> >> >>
>> >> >> > This method adds the options/preamble to each definition block. =
Notably,
>> >> >> > :since: and :ifcond: are added, as are any "special features" su=
ch as
>> >> >> > :deprecated: and :unstable:.
>> >> >> >
>> >> >> > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> >> > ---
>> >> >> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
>> >> >> >  1 file changed, 32 insertions(+), 1 deletion(-)
>> >> >> >
>> >> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> >> >> > index 6f8f69077b1..85c7ce94564 100644
>> >> >> > --- a/docs/sphinx/qapidoc.py
>> >> >> > +++ b/docs/sphinx/qapidoc.py
>> >> >> > @@ -38,7 +38,7 @@
>> >> >> >  from qapi.error import QAPIError, QAPISemError
>> >> >> >  from qapi.gen import QAPISchemaVisitor
>> >> >> >  from qapi.parser import QAPIDoc
>> >> >> > -from qapi.schema import QAPISchema
>> >> >> > +from qapi.schema import QAPISchema, QAPISchemaEntity
>> >> >> >  from qapi.source import QAPISourceInfo
>> >> >> >
>> >> >> >  from sphinx import addnodes
>> >> >> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
>> >> >> >              # +2: correct for zero/one index, then increment by=
 one.
>> >> >> >              self.add_line_raw("", fname, line + 2)
>> >> >> >
>> >> >> > +    # Transmogrification helpers
>> >> >> > +
>> >> >> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
>> >> >> > +        """
>> >> >> > +        Generate option lines for qapi entity directives.
>> >> >> > +        """
>> >> >> > +        if ent.doc and ent.doc.since:
>> >> >> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
>> >> >> > +            # Generated from the entity's docblock; info locati=
on is exact.
>> >> >> > +            self.add_line(f":since: {ent.doc.since.text}", ent.=
doc.since.info)
>> >> >> > +
>> >> >> > +        if ent.ifcond.is_present():
>> >> >> > +            doc =3D ent.ifcond.docgen()
>> >> >> > +            # Generated from entity definition; info location i=
s approximate.
>> >> >> > +            self.add_line(f":ifcond: {doc}", ent.info)
>> >> >> > +
>> >> >> > +        # Hoist special features such as :deprecated: and :unst=
able:
>> >> >> > +        # into the options block for the entity. If, in the fut=
ure, new
>> >> >> > +        # special features are added, qapi-domain will chirp ab=
out
>> >> >> > +        # unrecognized options and fail.
>> >> >> > +        for feat in ent.features:
>> >> >> > +            if feat.is_special():
>> >> >> > +                # We don't expect special features to have an i=
fcond property.
>> >> >> > +                # (Hello, intrepid developer in the future who =
changed that!)
>> >> >> > +                # ((With luck, you are not me.))
>> >> >> > +                assert not feat.ifcond.is_present()
>> >> >>
>> >> >> Nope :)
>> >> >>
>> >> >> The attempt to add a conditional special feature now fails with
>> >> >>
>> >> >>     Sphinx parallel build error:
>> >> >>     AssertionError
>> >> >>
>> >> >> If you want to outlaw conditional special features, reject them cl=
eanly
>> >> >> in schema.py, document the restriction in docs/devel/qapi-code-gen=
.rst,
>> >> >> and explain why in the commit message.  Recommend a separate commi=
t, to
>> >> >> make it stand out in git-log.
>> >> >
>> >> > Do you advocate this? I wasn't sure what it *meant* for a special f=
eature
>> >> > to be conditional; I couldn't conceive of what it meant to have an =
ifcond
>> >> > for "deprecated" or "unstable", for instance. It sounds like it isn=
't well
>> >> > defined, but we happen to not expressly forbid it.

[...]

>> I believe what you need isn't so much an explanation of semantics, it's
>> use cases.  And that's fair!
>>
>> Let me offer two.
>>
>> 1. Imagine we're trying to develop something big & complex enough to
>>    make keeping it out of tree until done impractical.  We feel even an
>>    in-tree branch would be impractical.  Instead, we commit it to
>>    master, default off, configure --enable-complex-thing to get it.  Not
>>    exactly something we do all the time, but not outlandish, either.
>>
>>    Further imagine that the big & complex thing will involve some new
>>    QMP commands replacing existing ones.  As usual, we want to mark the
>>    ones being replaced deprecated, so we can remove them after a grace
>>    period.
>>
>>    But simply deprecating them in the schema would be premature!  The
>>    big & complex thing may fail, and if it does, we rip it out.  If it
>>    succeeds, we enable it unconditionally.
>>
>>    We can express what we're doing by making feature deprecated
>>    conditional on CONFIG_COMPLEX_THING, which is defined by
>>    --enable-complex-thing.
>>
>>    That way, the complex thing doesn't affect the QMP interface unless
>>    we enable it.  Good.  And if we enable it, we do get the deprecation,
>>    and can test management applications cope with it.
>>
>> 2. Imagine we turned allow-preconfig into a special feature.  Further
>>    imagine some whole-stack feature requires a certain command to have
>>    allow-preconfig, and you got tasked with implementing it.  Which you
>>    duly did, to everybody's satisfaction.  It is now days to the
>>    release, rc4 has sailed, and some dude comes out of the woodwork to
>>    report the command crashes in preconfig state.  Weird!  It worked
>>    *fine* in your meticulous testing.  After some back and forth, you
>>    discover that the reporter builds with --enable-exotic-crap, which
>>    you didn't test, because you weren't even aware it exists.  You
>>    enable it, and now the command crashes for you, too.  Fixing this
>>    after rc4 is out of the question, too much churn.  You could,
>>    however, make feature allow-preconfig conditional on not
>>    CONFIG_EXOTIC_CRAP.
>>
>> >> [...]
>>
>>
> Hm, alright. I think I'll just stub out conditionals with a TODO and circ=
le
> back to how I'll handle them; I need to do a pass on ifcond handling in
> general, so I guess I'll get to it then.

Makes sense (although I'd use FIXME rather than TODO).

If resolving them turns out to be hard, we can talk about adding
restrictions to help you over the hump.

>                                          I still think it's a little weir=
d,
> but you don't, and you're the QAPI guy ;)

I admit constructing believable use cases took a bit of thought.
Calling them a little weird can't offend me :)


