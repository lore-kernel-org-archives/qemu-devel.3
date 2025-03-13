Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B96C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslsC-0006ZA-7s; Thu, 13 Mar 2025 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsls2-0006Wd-9I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tslry-0002Xt-SQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741885038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0bKs7ABUtjvI7WF3fX7BbFUY4XA0fHkgO3pwNWV7Ps=;
 b=SP3L1nNDVWm5KOxru85udqtqtdjeJZJnGS+0uPTvNwp4MBcVSMnsqVZBUkgv665ls882LA
 DCMl1sOX5iT8ndLHwE2sWvPKsCKf2EOWDCoXvZHEKAqD6Wj4+BbiiSCK56YNHKEPAEvKVE
 LT/w7CkGU7FdXQ7wikucdX+er5xQGE4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-wpAc9o1nOAC_-Vi_bsGuUg-1; Thu, 13 Mar 2025 12:57:16 -0400
X-MC-Unique: wpAc9o1nOAC_-Vi_bsGuUg-1
X-Mimecast-MFC-AGG-ID: wpAc9o1nOAC_-Vi_bsGuUg_1741885035
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c3bso2122283a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885034; x=1742489834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0bKs7ABUtjvI7WF3fX7BbFUY4XA0fHkgO3pwNWV7Ps=;
 b=aGu9VYyBv21QU7NGVSHwKjJL12o60jl2WdT9KbJ3hlpYz8U/jo5zp3tO/w91g1pNzg
 fTIqr/9IJJLwej2uNgtnWIcOyMuBgUI3yMe5E3s7AIYkNmA3iI2RK/Pqf2uIRqe59vIj
 mOlzzUojq/6Ia8oDFo/gcJHrbT6koAxh9tzra7wcLbaaymZtLf5qVbdazK+YteaCXi41
 kFrdaFqvOphSGAUC8x9yNo9CR0P2yX+FJuNgcTtqVrVhCPFXLhuM7b94DWVEl4hRkavK
 O6wnnlH9CsjZtE/uGBURg0CUkmiArQQAMqQ6N6NgvSrslCAM5IXGbs+uNDKjawu+hWA2
 rnCw==
X-Gm-Message-State: AOJu0YxY9T4vVTtuYlpTINDuvjJkZdSssCLL/+P5ZiZ9HZmwJmC3IQvI
 N/dK4jtbAJHo0LbaBaeQw17TcOxY03IFHsfvvlOIwz4ogE4aSSK37AuzhIi6CXuXgDVi+E3/VmZ
 iIrchhFoqhI/O8UPamQMsp2lnvA+R5SRnkvLzy633raxt9/XhHIrBtnv4Xwvtxfa3sJ+wR5haEh
 7FYdd32xsLCmiZ2jdyfVVZ5/9RKUDEyUCH9Sg=
X-Gm-Gg: ASbGncuAP3IIXaGxIqSjjlqmo+WCsicR7gNp3PIVZhh/Ss7IVZywzxzosx1nieLe/CA
 l7uPbJgxRaFAxcxVz2Wl9E7CtJ0uxNWRnSW0xzuap351V7ayHlMQ3sly9k9i3LzWd10zbfSllqa
 jJQXitOK2Jzv1f1Lv8DcM10btAyJg+
X-Received: by 2002:a17:90b:3ccf:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-3014ea2396dmr249261a91.26.1741885034293; 
 Thu, 13 Mar 2025 09:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/GK3y0ysX/m88p5SvudnGYWwvzovmTBXTRgfzZPOS4nXygUQ9vFGxayBjfFGQOMNh7Cv4m7e3yGWcgw7y5Qg=
X-Received: by 2002:a17:90b:3ccf:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-3014ea2396dmr249239a91.26.1741885033946; Thu, 13 Mar 2025
 09:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
 <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
 <87o6y43our.fsf@pond.sub.org>
In-Reply-To: <87o6y43our.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 12:57:01 -0400
X-Gm-Features: AQ5f1Jrw6EX3evdqi-RcGVP6LfSkDfz3-CZcUDMiV5tah50eon6uEFws0mJPYl0
Message-ID: <CAFn=p-a90ujkHX5abhrW9SoGLp08vPt2W_EE3M3=4c6mTZJVJg@mail.gmail.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b041e306303c3628"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000b041e306303c3628
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025, 11:57=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com>
> > wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com>
> wrote:
> >> >
> >> >> John Snow <jsnow@redhat.com> writes:
> >> >>
> >> >> > This patch does three things:
> >> >> >
> >> >> > 1. Record the current namespace context in pending_xrefs so it ca=
n
> be
> >> >> >    used for link resolution later,
> >> >> > 2. Pass that recorded namespace context to find_obj() when
> resolving a
> >> >> >    reference, and
> >> >> > 3. Wildly and completely rewrite find_obj().
> >> >> >
> >> >> > cross-reference support is expanded to tolerate the presence or
> absence
> >> >> > of either namespace or module, and to cope with the presence or
> absence
> >> >> > of contextual information for either.
> >> >> >
> >> >> > References now work like this:
> >> >> >
> >> >> > 1. If the explicit reference target is recorded in the domain's
> object
> >> >> >    registry, we link to that target and stop looking. We do this
> lookup
> >> >> >    regardless of how fully qualified the target is, which allows
> direct
> >> >> >    references to modules (which don't have a module component to
> their
> >> >> >    names) or direct references to definitions that may or may not
> belong
> >> >> >    to a namespace or module.
> >> >> >
> >> >> > 2. If contextual information is available from qapi:namespace or
> >> >> >    qapi:module directives, try using those components to find a
> direct
> >> >> >    match to the implied target name.
> >> >> >
> >> >> > 3. If both prior lookups fail, generate a series of regular
> expressions
> >> >> >    looking for wildcard matches in order from most to least
> >> >> >    specific. Any explicitly provided components (namespace, modul=
e)
> >> >> >    *must* match exactly, but both contextual and entirely omitted
> >> >> >    components are allowed to differ from the search result. Note
> that if
> >> >> >    more than one result is found, Sphinx will emit a warning (a
> build
> >> >> >    error for QEMU) and list all of the candidate references.
> >> >> >
> >> >> > The practical upshot is that in the large majority of cases,
> namespace
> >> >> > and module information is not required when creating simple
> `references`
> >> >> > to definitions from within the same context -- even when identica=
l
> >> >> > definitions exist in other contexts.
> >> >>
> >> >> Can you illustrate this this examples?
> >> >>
> >> >
> >> > do wha?
> >>
> >> Sorry, I went into the curve too fast.
> >>
> >> The stuff under "References now work like this" confuses me.  I guess =
it
> >> describes a series of lookups to try one after the other.
> >>
> >> I understand a cross-reference consists of namespace (optional), modul=
e
> >> (optional), name, and role.
> >>
> >> Let's assume role is "any" for simplicity's sake.
> >>
> >> Regarding "1. If the explicit ...":
> >>
> >>     What is a reference's "explicit reference target"?  Examples might
> >>     help me understand.
> >>
> >
> > explicit lookup: `QMP:block-core:block-dirty-bitmap-add`
> >
> > If that explicit target matches an object in the object database
> > *directly*, we match immediately and don't consider other potential
> > targets. This also applies to things like modules, e.g. `QMP:block-core=
`
> > even though the "module" is absent (it IS the module)
> >
> > We always search for the explicit target no matter how un/fully qualifi=
ed
> > it is.
> >
> >
> >>
> >>     What is "recorded in the domain's object registry"?
> >>
> >
> > domain.objects{} - essentially a record of every ObjectDefinition's
> > "fullname" - the return value from QAPIDefinition._get_fqn().
> >
> >
> >>
> >>     Can you show me a reference where this lookup succeeds?
> >>
> >
> > `QMP:block-core`
> > `QMP:block-core.block-dirty-bitmap-add`
>
> So, for this lookup to work, the reference must either be of the form
> NAMESPACE:MODULE and resolve to that module in that namespace, or of the
> form NAMESPACE:MODULE:DEFN and resolve to that definition in that module
> in that namespace.  Correct?
>

Yes.


> These a "fully qualified names (FQN)" in your parlance, right?
>

More or less, though as you found below...


> Note that the first form is syntactically indistinguishable from
> NAMESPACE:DEFN, i.e. a reference to a definition that specifies the
> namespace, but not the module.
>
> If the NAMESPACE:MODULE interpretation resolves, we never try the
> NAMESPACE:DEFN interpretation, because that happens in later steps.
> Correct?
>
> The first form is fully qualified only if it resolves as FQN.  So,
> whether such a reference is fully qualified is not syntactically
> decidable.  Hmm.
>

You're right. There is a weirdness here. I might need to do some more
thinking to make sure it isn't theoretically a problem, but in practice,
right now, it isn't.

Stay tuned, I guess.


> >> Regarding "2. If contextual information ...":
> >>
> >>     I guess "contextual information" is the context established by
> >>     qapi:namespace and qapi:module directives, i.e. the current
> >>     namespace and module, if any.
> >>
> >
> > Yep!
> >
> >
> >>
> >>     If the cross reference lacks a namespace, we substitute the curren=
t
> >>     namespace.  Same for module.
> >>
> >>     We then use that "to find a direct match to the implied target
> >>     name".  Sounds greek to me.  Example(s) might help.
> >>
> >
> > If namespace or module is missing from the link target, we try to fill =
in
> > the blanks with the contextual information if present.
> >
> > Example, we are in the block-core section of the QEMU QMP reference
> manual
> > document and we reference `block-dirty-bitmap-add`. With context, we ar=
e
> > able to assemble a fully qualified name:
> > "QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
> > registry directly, so it matches and no further search is performed.
>
> We try this lookup only when the reference lacks a namespace and we are
> "in" a namespace, or when it lacks a module and we are "in" a module.
> Correct?
>

or both: if we provided only a name but the context has both a namespace
and module.

essentially the algorithm splits the explicit target into (ns, mod, name)
and for any that are blank, we try to fill in those blanks with context
info where available. Sometimes you have neither explicit nor contextual
info for a component.

Then we do a lookup for an exact match, in order;

1. explicit target name, whatever it was
2. FQN using contextual info

and we stop after the first hit - no chance for multiple results here, just
zero-or-one each step.

i.e. any explicitly provided information is never "overwritten" with
context, context only fills in the blanks where that info was not provided.

If neither of these work, we move on to fuzzy searching.


> We then subsitute current namespace / module for the lacking one(s), and
> try the same lookup as in 1.  Correct?
>

Yes!


> If we have a reference of the form MYSTERY, it could either be a
> reference to module MYSTERY in the current namespace, or to definition
> MYSTERY in the current namespace and module.  How do we decide?
>

fqn a: NS:MYSTERY
fqn b: NS:MOD:MYSTERY

Given we have a current ns/mod context, it's going to pick the second one.

Hm. Maybe it ought to be ambiguous in this case... I'll have to revise
this. (question is: how soon do we need it?)


> >> Regarding "3. If both prior lookups fail ...":
> >>
> >>     I guess we get here when namespace or module are absent, and
> >>     substituting the current namespace or module doesn't resolve.  We
> >>     then substitute a wildcard, so to speak, i.e. look in all namespac=
es
> >>     / modules, and succeed if we find exactly one resolution.  Fair?
> >>
> >
> > More or less, though the mechanics are quite a bit more complex than yo=
ur
> > overview (and what I wrote in qapi-domain.rst.) We can get here for a f=
ew
> > reasons:
> >
> > (1) We didn't provide a fully qualified target, and we don't have full
> > context to construct one. For example, we are not "in" a namespace and/=
or
> > not "in" a module. This is quite likely to happen when writing simple
> > references to a definition name from outside of the transmogfrified QAP=
I
> > documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.rst,
> etc.
> >
> > (2) We didn't provide a fully qualified target, and we are referencing
> > something from outside of the local context. For example, we are "in" a
> > module but we are trying to link to a different module's definition. e.=
g.
> > we are in QMP:transaction and we reference `block-dirty-bitmap-add`. Th=
e
> > implied FQN will be QMP:transaction.block-dirty-bitmap.add, which will
> not
> > resolve.
> >
> > The fuzzy search portion has an order of precedence for how it searches=
 -
> > and not all searches are tried universally, they are conditional to wha=
t
> > was provided in the reference target and what context is available.
> >
> > 1. match against the explicitly provided namespace (module was not
> > explicitly provided)
>
> Look for the name in all of the namespace's modules?
>

Yeah. search for "ns:*.name" and "ns:name" basically.


> > 2. match against the explicitly provided module (namespace was not
> > explicitly provided)
>
> Look for the name in all modules so named in all namespaces?
>

Yes.


> > 3. match against the implied namespace (neither namespace/module was
> > explicitly provided)
>
> ?
>

User gave `foo`, but we have a namespace from context, so we look for
ns:*.foo or ns:foo.


> > 4. match against the implied module (neither namespace/module was
> > explicitly provided)
>
> ?
>

User gave `foo`, but we have a module from context, so we search for
*:mod.foo and mod.foo


> > 5. match against the definition name only, from anywhere (neither
> > namespace/module was explicitly provided)
>
> Look for the name anywhere?
>
> I need examples :)
>

user gave `foo`. search for any qapi definition in all modules and
namespaces for anything with the name "foo". The broadest possible search.

Doesn't search for stuff outside of the QAPI domain directly, but be aware
when using `references` that all domains are consulted, so it may in fact
match something else from somewhere else, though not by any doing of the
qapi domain.

i.e. :qapi:any:`foo` will definitely only search using the rules laid out
in this patch/thread, but `foo` will consult all domains (and whine if more
than one result between all domains is identified.)


> > The searches are performed in order: if a search returns zero results,
> the
> > next search is tried. If any search returns one or more results, those
> > results are returned and we stop searching down the list. The priority
> > order ensures that any explicitly provided information is *always* used
> to
> > find a match, but contextually provided information is merely a "hint"
> and
> > can be ignored for the sake of a match.
> >
> > If find_obj() as a whole returns zero results, Sphinx emits a warning
> for a
> > dangling reference. if find_obj() as a whole returns multiple results,
> > Sphinx emits a warning for the ambiguous cross-reference.
> >
> > QEMU errors out on any such warnings under our normal build settings.
> >
> > Clear as mud?
>
> Clearer, but not quite mud, yet.
>

Ultimately, Search in this order and stop at any point any of these
searches return at least one result:

1. Explicitly provided name, whatever it is
2. FQN using contextual info
3. Explicitly provided NS; any module
4. Explicitly provided module; any NS
5. Contextual NS; any module
6. Contextual module; any NS
7. any NS/module.

with searches 3-7 being conditional only when the criteria are met:

3. Must have explicit NS (and no explicit module)
4. Must have explicit module (and no explicit NS)
5. Must have contextual NS (must not have explicit NS nor module)
6. Must have contextual module (must not have explicit NS nor module)
7. Must have neither explicit NS nor module.

In summary:

* Anything explicitly provided *must* match. This information is *never*
ignored.
* Anything implicitly provided through context will never overwrite
anything explicitly provided. This is used as a *hint* in the event
multiple candidates are found, but results are allowed to deviate when
stronger matches are not located.

i.e. contextual information is used to *prefer* a result from that context,
but is not used to *limit* you to that context.

by contrast, explicit info is used to directly filter and restrict search.


(With maybe a bug or two for trying to find module names in some
circumstances. Will have to check that over...)


> > --js
> >
> >
> >> [...]
> >>
> >>
>
>

--000000000000b041e306303c3628
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13, 2025, 11:57=E2=
=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Sno=
w &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferr=
er">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
armbru@redhat.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; This patch does three things:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 1. Record the current namespace context in pending_x=
refs so it can be<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 used for link resolution later,<br>
&gt;&gt; &gt;&gt; &gt; 2. Pass that recorded namespace context to find_obj(=
) when resolving a<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 reference, and<br>
&gt;&gt; &gt;&gt; &gt; 3. Wildly and completely rewrite find_obj().<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; cross-reference support is expanded to tolerate the =
presence or absence<br>
&gt;&gt; &gt;&gt; &gt; of either namespace or module, and to cope with the =
presence or absence<br>
&gt;&gt; &gt;&gt; &gt; of contextual information for either.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; References now work like this:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 1. If the explicit reference target is recorded in t=
he domain&#39;s object<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 registry, we link to that target and st=
op looking. We do this lookup<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 regardless of how fully qualified the t=
arget is, which allows direct<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 references to modules (which don&#39;t =
have a module component to their<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 names) or direct references to definiti=
ons that may or may not belong<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 to a namespace or module.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 2. If contextual information is available from qapi:=
namespace or<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 qapi:module directives, try using those=
 components to find a direct<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 match to the implied target name.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; 3. If both prior lookups fail, generate a series of =
regular expressions<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 looking for wildcard matches in order f=
rom most to least<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 specific. Any explicitly provided compo=
nents (namespace, module)<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 *must* match exactly, but both contextu=
al and entirely omitted<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 components are allowed to differ from t=
he search result. Note that if<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 more than one result is found, Sphinx w=
ill emit a warning (a build<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 error for QEMU) and list all of the can=
didate references.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The practical upshot is that in the large majority o=
f cases, namespace<br>
&gt;&gt; &gt;&gt; &gt; and module information is not required when creating=
 simple `references`<br>
&gt;&gt; &gt;&gt; &gt; to definitions from within the same context -- even =
when identical<br>
&gt;&gt; &gt;&gt; &gt; definitions exist in other contexts.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Can you illustrate this this examples?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; do wha?<br>
&gt;&gt;<br>
&gt;&gt; Sorry, I went into the curve too fast.<br>
&gt;&gt;<br>
&gt;&gt; The stuff under &quot;References now work like this&quot; confuses=
 me.=C2=A0 I guess it<br>
&gt;&gt; describes a series of lookups to try one after the other.<br>
&gt;&gt;<br>
&gt;&gt; I understand a cross-reference consists of namespace (optional), m=
odule<br>
&gt;&gt; (optional), name, and role.<br>
&gt;&gt;<br>
&gt;&gt; Let&#39;s assume role is &quot;any&quot; for simplicity&#39;s sake=
.<br>
&gt;&gt;<br>
&gt;&gt; Regarding &quot;1. If the explicit ...&quot;:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0What is a reference&#39;s &quot;explicit refere=
nce target&quot;?=C2=A0 Examples might<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0help me understand.<br>
&gt;&gt;<br>
&gt;<br>
&gt; explicit lookup: `QMP:block-core:block-dirty-bitmap-add`<br>
&gt;<br>
&gt; If that explicit target matches an object in the object database<br>
&gt; *directly*, we match immediately and don&#39;t consider other potentia=
l<br>
&gt; targets. This also applies to things like modules, e.g. `QMP:block-cor=
e`<br>
&gt; even though the &quot;module&quot; is absent (it IS the module)<br>
&gt;<br>
&gt; We always search for the explicit target no matter how un/fully qualif=
ied<br>
&gt; it is.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0What is &quot;recorded in the domain&#39;s obje=
ct registry&quot;?<br>
&gt;&gt;<br>
&gt;<br>
&gt; domain.objects{} - essentially a record of every ObjectDefinition&#39;=
s<br>
&gt; &quot;fullname&quot; - the return value from QAPIDefinition._get_fqn()=
.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Can you show me a reference where this lookup s=
ucceeds?<br>
&gt;&gt;<br>
&gt;<br>
&gt; `QMP:block-core`<br>
&gt; `QMP:block-core.block-dirty-bitmap-add`<br>
<br>
So, for this lookup to work, the reference must either be of the form<br>
NAMESPACE:MODULE and resolve to that module in that namespace, or of the<br=
>
form NAMESPACE:MODULE:DEFN and resolve to that definition in that module<br=
>
in that namespace.=C2=A0 Correct?<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Yes.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
These a &quot;fully qualified names (FQN)&quot; in your parlance, right?<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Mor=
e or less, though as you found below...</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
Note that the first form is syntactically indistinguishable from<br>
NAMESPACE:DEFN, i.e. a reference to a definition that specifies the<br>
namespace, but not the module.<br>
<br>
If the NAMESPACE:MODULE interpretation resolves, we never try the<br>
NAMESPACE:DEFN interpretation, because that happens in later steps.<br>
Correct?<br>
<br>
The first form is fully qualified only if it resolves as FQN.=C2=A0 So,<br>
whether such a reference is fully qualified is not syntactically<br>
decidable.=C2=A0 Hmm.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">You&#39;re right. There is a weirdness here. I might n=
eed to do some more thinking to make sure it isn&#39;t theoretically a prob=
lem, but in practice, right now, it isn&#39;t.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Stay tuned, I guess.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt;&gt; Regarding &quot;2. If contextual information ...&quot;:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0I guess &quot;contextual information&quot; is t=
he context established by<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0qapi:namespace and qapi:module directives, i.e.=
 the current<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0namespace and module, if any.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yep!<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0If the cross reference lacks a namespace, we su=
bstitute the current<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0namespace.=C2=A0 Same for module.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0We then use that &quot;to find a direct match t=
o the implied target<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0name&quot;.=C2=A0 Sounds greek to me.=C2=A0 Exa=
mple(s) might help.<br>
&gt;&gt;<br>
&gt;<br>
&gt; If namespace or module is missing from the link target, we try to fill=
 in<br>
&gt; the blanks with the contextual information if present.<br>
&gt;<br>
&gt; Example, we are in the block-core section of the QEMU QMP reference ma=
nual<br>
&gt; document and we reference `block-dirty-bitmap-add`. With context, we a=
re<br>
&gt; able to assemble a fully qualified name:<br>
&gt; &quot;QMP:block-core.block-dirty-bitmap-add`. This matches an item in =
the<br>
&gt; registry directly, so it matches and no further search is performed.<b=
r>
<br>
We try this lookup only when the reference lacks a namespace and we are<br>
&quot;in&quot; a namespace, or when it lacks a module and we are &quot;in&q=
uot; a module.<br>
Correct?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">or both: if we provided only a name but the context has both a na=
mespace and module.</div><div dir=3D"auto"><br></div><div dir=3D"auto">esse=
ntially the algorithm splits the explicit target into (ns, mod, name) and f=
or any that are blank, we try to fill in those blanks with context info whe=
re available. Sometimes you have neither explicit nor contextual info for a=
 component.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Then we do a=
 lookup for an exact match, in order;</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">1. explicit target name, whatever it was</div><div dir=3D"aut=
o">2. FQN using contextual info</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">and we stop after the first hit - no chance for multiple results =
here, just zero-or-one each step.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">i.e. any explicitly provided information is never &quot;overwritt=
en&quot; with context, context only fills in the blanks where that info was=
 not provided.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If neithe=
r of these work, we move on to fuzzy searching.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
We then subsitute current namespace / module for the lacking one(s), and<br=
>
try the same lookup as in 1.=C2=A0 Correct?<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yes!</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
If we have a reference of the form MYSTERY, it could either be a<br>
reference to module MYSTERY in the current namespace, or to definition<br>
MYSTERY in the current namespace and module.=C2=A0 How do we decide?<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">fqn a: =
NS:MYSTERY</div><div dir=3D"auto">fqn b: NS:MOD:MYSTERY</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Given we have a current ns/mod context, it&=
#39;s going to pick the second one.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Hm. Maybe it ought to be ambiguous in this case... I&#39;ll hav=
e to revise this. (question is: how soon do we need it?)</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
&gt;&gt; Regarding &quot;3. If both prior lookups fail ...&quot;:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0I guess we get here when namespace or module ar=
e absent, and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0substituting the current namespace or module do=
esn&#39;t resolve.=C2=A0 We<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0then substitute a wildcard, so to speak, i.e. l=
ook in all namespaces<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0/ modules, and succeed if we find exactly one r=
esolution.=C2=A0 Fair?<br>
&gt;&gt;<br>
&gt;<br>
&gt; More or less, though the mechanics are quite a bit more complex than y=
our<br>
&gt; overview (and what I wrote in qapi-domain.rst.) We can get here for a =
few<br>
&gt; reasons:<br>
&gt;<br>
&gt; (1) We didn&#39;t provide a fully qualified target, and we don&#39;t h=
ave full<br>
&gt; context to construct one. For example, we are not &quot;in&quot; a nam=
espace and/or<br>
&gt; not &quot;in&quot; a module. This is quite likely to happen when writi=
ng simple<br>
&gt; references to a definition name from outside of the transmogfrified QA=
PI<br>
&gt; documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.rst,=
 etc.<br>
&gt;<br>
&gt; (2) We didn&#39;t provide a fully qualified target, and we are referen=
cing<br>
&gt; something from outside of the local context. For example, we are &quot=
;in&quot; a<br>
&gt; module but we are trying to link to a different module&#39;s definitio=
n. e.g.<br>
&gt; we are in QMP:transaction and we reference `block-dirty-bitmap-add`. T=
he<br>
&gt; implied FQN will be QMP:transaction.block-dirty-bitmap.add, which will=
 not<br>
&gt; resolve.<br>
&gt;<br>
&gt; The fuzzy search portion has an order of precedence for how it searche=
s -<br>
&gt; and not all searches are tried universally, they are conditional to wh=
at<br>
&gt; was provided in the reference target and what context is available.<br=
>
&gt;<br>
&gt; 1. match against the explicitly provided namespace (module was not<br>
&gt; explicitly provided)<br>
<br>
Look for the name in all of the namespace&#39;s modules?<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah. search for &q=
uot;ns:*.name&quot; and &quot;ns:name&quot; basically.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
&gt; 2. match against the explicitly provided module (namespace was not<br>
&gt; explicitly provided)<br>
<br>
Look for the name in all modules so named in all namespaces?<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; 3. match against the implied namespace (neither namespace/module was<b=
r>
&gt; explicitly provided)<br>
<br>
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>User gave `foo`, but we have a namespace from context, so we look for ns:*=
.foo or ns:foo.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; 4. match against the implied module (neither namespace/module was<br>
&gt; explicitly provided)<br>
<br>
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>User gave `foo`, but we have a module from context, so we search for *:mod=
.foo and mod.foo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; 5. match against the definition name only, from anywhere (neither<br>
&gt; namespace/module was explicitly provided)<br>
<br>
Look for the name anywhere?<br>
<br>
I need examples :)<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">user gave `foo`. search for any qapi definition in all mo=
dules and namespaces for anything with the name &quot;foo&quot;. The broade=
st possible search.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Does=
n&#39;t search for stuff outside of the QAPI domain directly, but be aware =
when using `references` that all domains are consulted, so it may in fact m=
atch something else from somewhere else, though not by any doing of the qap=
i domain.</div><div dir=3D"auto"><br></div><div dir=3D"auto">i.e. :qapi:any=
:`foo` will definitely only search using the rules laid out in this patch/t=
hread, but `foo` will consult all domains (and whine if more than one resul=
t between all domains is identified.)</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
&gt; The searches are performed in order: if a search returns zero results,=
 the<br>
&gt; next search is tried. If any search returns one or more results, those=
<br>
&gt; results are returned and we stop searching down the list. The priority=
<br>
&gt; order ensures that any explicitly provided information is *always* use=
d to<br>
&gt; find a match, but contextually provided information is merely a &quot;=
hint&quot; and<br>
&gt; can be ignored for the sake of a match.<br>
&gt;<br>
&gt; If find_obj() as a whole returns zero results, Sphinx emits a warning =
for a<br>
&gt; dangling reference. if find_obj() as a whole returns multiple results,=
<br>
&gt; Sphinx emits a warning for the ambiguous cross-reference.<br>
&gt;<br>
&gt; QEMU errors out on any such warnings under our normal build settings.<=
br>
&gt;<br>
&gt; Clear as mud?<br>
<br>
Clearer, but not quite mud, yet.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Ultimately, Search in this order and stop a=
t any point any of these searches return at least one result:</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">1. Explicitly provided name, whatever=
 it is</div><div dir=3D"auto">2. FQN using contextual info</div><div dir=3D=
"auto">3. Explicitly provided NS; any module</div><div dir=3D"auto">4. Expl=
icitly provided module; any NS</div><div dir=3D"auto">5. Contextual NS; any=
 module</div><div dir=3D"auto">6. Contextual module; any NS</div><div dir=
=3D"auto">7. any NS/module.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">with searches 3-7 being conditional only when the criteria are met:</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">3. Must have explicit NS (a=
nd no explicit module)</div><div dir=3D"auto">4. Must have explicit module =
(and no explicit NS)</div><div dir=3D"auto">5. Must have contextual NS (mus=
t not have explicit NS nor module)</div><div dir=3D"auto">6. Must have cont=
extual module (must not have explicit NS nor module)</div><div dir=3D"auto"=
>7. Must have neither explicit NS nor module.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">In summary:</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">* Anything explicitly provided *must* match. This information is =
*never* ignored.</div><div dir=3D"auto">* Anything implicitly provided thro=
ugh context will never overwrite anything explicitly provided. This is used=
 as a *hint* in the event multiple candidates are found, but results are al=
lowed to deviate when stronger matches are not located.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">i.e. contextual information is used to *pre=
fer* a result from that context, but is not used to *limit* you to that con=
text.</div><div dir=3D"auto"><br></div><div dir=3D"auto">by contrast, expli=
cit info is used to directly filter and restrict search.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">(With maybe a =
bug or two for trying to find module names in some circumstances. Will have=
 to check that over...)</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
&gt; --js<br>
&gt;<br>
&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000b041e306303c3628--


