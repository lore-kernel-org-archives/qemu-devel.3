Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E743DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskD8-00037E-I0; Thu, 13 Mar 2025 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tskD0-00036h-Qo
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tskCy-0007oQ-G5
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741878651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqfoeWKV95ziDrz8H0Vpz7WpHITBoSOT1o59TJXapgg=;
 b=c3TQmibjyBCZj7oOlzrL9vkpNYBiLmYl1aS6kJbr4Bn0udx5hs33rqVnyxOAma9hI1Eyv0
 p8ZvuEZOQoIrskehGHAwlBB3wAZyos4dQ0k2W/96c53co6xpWiEigradhmLqbXlz8djk+2
 ZXvwcT4HfX2JVxqKPrwhgq3Z0Pbpz7s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-b_dJCP-SMfq4RVxGe-3iDA-1; Thu, 13 Mar 2025 11:10:49 -0400
X-MC-Unique: b_dJCP-SMfq4RVxGe-3iDA-1
X-Mimecast-MFC-AGG-ID: b_dJCP-SMfq4RVxGe-3iDA_1741878648
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff58318acaso3011962a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741878648; x=1742483448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqfoeWKV95ziDrz8H0Vpz7WpHITBoSOT1o59TJXapgg=;
 b=CjS0nCSJ5fdFQJmu5CM40tWir9z+Gu98BG9Ya9ga1EBT88JyEEGS03WdLuXdmMamfc
 zLF3p4H+VHQR+kpNCSkSr50ImSnUGQU7Gm9HrIVw9EpVWQsCe5sFd+sDouvnf05cFPEC
 +W1/19er/kq1ALUTdMGQ97Ng2PLrdRf+l4bea2dRgIBxCTiA14JnOwGFSD+jdlkltSbz
 t7F/VtPmOuvQNplevCTbvMzyvmNTpkDhsgilP9M2rrUQjtbHQ78kbzB+UhpM7cPywGdV
 z2j8sbie1MKp1JYlVLbRJBmQDb3qQNrijAIH5LDFdDEaq+7kPV2rRANW5bKhsNnWP606
 p3+Q==
X-Gm-Message-State: AOJu0YyRLYiVmgxQKWfHs4PWwSvhypyNY3ifX1UQKXg1meBZz8T4rra2
 fH1kGsdYftq34Dv79Es4hPledLxMbMOMwWQE/XOQbhLfig228B/Ag3naQG2AYZBjDf0QGsm7nDa
 UfgKqoo1UKURjo7pyKZ6c7P4tjGgQDwEDfqsrUGtImS+Sxc28dN0q0zspwkBMPIUipSyfREmKMm
 E6OI3HxjpMuDLwCLC3deUhnSUlc9M=
X-Gm-Gg: ASbGncte9svElExMEZyn2U65yPcAbzxk36QnusjHFMj3735W+in39d4zkf73/I3G+un
 SSHpr2wpTsU/BK7NXach3HDYZVPjkpx3GWG50mCjCJWfo9vulXeVhjpwyve9ytAUuYQkUTc2YXG
 wcyAbbOjasTSicDrLve6+YHr0My3CK
X-Received: by 2002:a17:90b:350d:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-2ff7ce7ab5emr45538012a91.12.1741878647762; 
 Thu, 13 Mar 2025 08:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcF4ne5jfgypsy5XjRt04+qv46UWZnWlxalB3quB1EBVYVpnE1fG/aRhzKEnbgSUkt7Ars/yCJDEV9Wtgi9WA=
X-Received: by 2002:a17:90b:350d:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-2ff7ce7ab5emr45537964a91.12.1741878647356; Thu, 13 Mar 2025
 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-8-jsnow@redhat.com>
 <8734fhe8ag.fsf@pond.sub.org>
 <CAFn=p-b2LUBzn-JE6P41wCxnW-vAB1moHWcw66d9Ta=tt_H1gQ@mail.gmail.com>
 <87ikod56zf.fsf@pond.sub.org>
In-Reply-To: <87ikod56zf.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 11:10:33 -0400
X-Gm-Features: AQ5f1JptOiJoNiYEERQKwsA1dNONasq6q_Q9FYqAKnHDjGfdAXZkLNg-4pPhTXU
Message-ID: <CAFn=p-b8xsWJw4kROKFUDbBNuJU32_oyktUMB+F5gsE=M9S72w@mail.gmail.com>
Subject: Re: [PATCH 07/11] docs/qapi_domain: add namespace support to
 cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000004a49806303aba68"
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

--00000000000004a49806303aba68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:41=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > This patch does three things:
> >> >
> >> > 1. Record the current namespace context in pending_xrefs so it can b=
e
> >> >    used for link resolution later,
> >> > 2. Pass that recorded namespace context to find_obj() when resolving=
 a
> >> >    reference, and
> >> > 3. Wildly and completely rewrite find_obj().
> >> >
> >> > cross-reference support is expanded to tolerate the presence or
> absence
> >> > of either namespace or module, and to cope with the presence or
> absence
> >> > of contextual information for either.
> >> >
> >> > References now work like this:
> >> >
> >> > 1. If the explicit reference target is recorded in the domain's obje=
ct
> >> >    registry, we link to that target and stop looking. We do this
> lookup
> >> >    regardless of how fully qualified the target is, which allows
> direct
> >> >    references to modules (which don't have a module component to the=
ir
> >> >    names) or direct references to definitions that may or may not
> belong
> >> >    to a namespace or module.
> >> >
> >> > 2. If contextual information is available from qapi:namespace or
> >> >    qapi:module directives, try using those components to find a dire=
ct
> >> >    match to the implied target name.
> >> >
> >> > 3. If both prior lookups fail, generate a series of regular
> expressions
> >> >    looking for wildcard matches in order from most to least
> >> >    specific. Any explicitly provided components (namespace, module)
> >> >    *must* match exactly, but both contextual and entirely omitted
> >> >    components are allowed to differ from the search result. Note tha=
t
> if
> >> >    more than one result is found, Sphinx will emit a warning (a buil=
d
> >> >    error for QEMU) and list all of the candidate references.
> >> >
> >> > The practical upshot is that in the large majority of cases, namespa=
ce
> >> > and module information is not required when creating simple
> `references`
> >> > to definitions from within the same context -- even when identical
> >> > definitions exist in other contexts.
> >>
> >> Can you illustrate this this examples?
> >>
> >
> > do wha?
>
> Sorry, I went into the curve too fast.
>
> The stuff under "References now work like this" confuses me.  I guess it
> describes a series of lookups to try one after the other.
>
> I understand a cross-reference consists of namespace (optional), module
> (optional), name, and role.
>
> Let's assume role is "any" for simplicity's sake.
>
> Regarding "1. If the explicit ...":
>
>     What is a reference's "explicit reference target"?  Examples might
>     help me understand.
>

explicit lookup: `QMP:block-core:block-dirty-bitmap-add`

If that explicit target matches an object in the object database
*directly*, we match immediately and don't consider other potential
targets. This also applies to things like modules, e.g. `QMP:block-core`
even though the "module" is absent (it IS the module)

We always search for the explicit target no matter how un/fully qualified
it is.


>
>     What is "recorded in the domain's object registry"?
>

domain.objects{} - essentially a record of every ObjectDefinition's
"fullname" - the return value from QAPIDefinition._get_fqn().


>
>     Can you show me a reference where this lookup succeeds?
>

`QMP:block-core`
`QMP:block-core.block-dirty-bitmap-add`


>
> Regarding "2. If contextual information ...":
>
>     I guess "contextual information" is the context established by
>     qapi:namespace and qapi:module directives, i.e. the current
>     namespace and module, if any.
>

Yep!


>
>     If the cross reference lacks a namespace, we substitute the current
>     namespace.  Same for module.
>
>     We then use that "to find a direct match to the implied target
>     name".  Sounds greek to me.  Example(s) might help.
>

If namespace or module is missing from the link target, we try to fill in
the blanks with the contextual information if present.

Example, we are in the block-core section of the QEMU QMP reference manual
document and we reference `block-dirty-bitmap-add`. With context, we are
able to assemble a fully qualified name:
"QMP:block-core.block-dirty-bitmap-add`. This matches an item in the
registry directly, so it matches and no further search is performed.


>
> Regarding "3. If both prior lookups fail ...":
>
>     I guess we get here when namespace or module are absent, and
>     substituting the current namespace or module doesn't resolve.  We
>     then substitute a wildcard, so to speak, i.e. look in all namespaces
>     / modules, and succeed if we find exactly one resolution.  Fair?
>

More or less, though the mechanics are quite a bit more complex than your
overview (and what I wrote in qapi-domain.rst.) We can get here for a few
reasons:

(1) We didn't provide a fully qualified target, and we don't have full
context to construct one. For example, we are not "in" a namespace and/or
not "in" a module. This is quite likely to happen when writing simple
references to a definition name from outside of the transmogfrified QAPI
documentation, e.g. from qapi-domain.rst itself, or dirty-bitmaps.rst, etc.

(2) We didn't provide a fully qualified target, and we are referencing
something from outside of the local context. For example, we are "in" a
module but we are trying to link to a different module's definition. e.g.
we are in QMP:transaction and we reference `block-dirty-bitmap-add`. The
implied FQN will be QMP:transaction.block-dirty-bitmap.add, which will not
resolve.

The fuzzy search portion has an order of precedence for how it searches -
and not all searches are tried universally, they are conditional to what
was provided in the reference target and what context is available.

1. match against the explicitly provided namespace (module was not
explicitly provided)
2. match against the explicitly provided module (namespace was not
explicitly provided)
3. match against the implied namespace (neither namespace/module was
explicitly provided)
4. match against the implied module (neither namespace/module was
explicitly provided)
5. match against the definition name only, from anywhere (neither
namespace/module was explicitly provided)

The searches are performed in order: if a search returns zero results, the
next search is tried. If any search returns one or more results, those
results are returned and we stop searching down the list. The priority
order ensures that any explicitly provided information is *always* used to
find a match, but contextually provided information is merely a "hint" and
can be ignored for the sake of a match.

If find_obj() as a whole returns zero results, Sphinx emits a warning for a
dangling reference. if find_obj() as a whole returns multiple results,
Sphinx emits a warning for the ambiguous cross-reference.

QEMU errors out on any such warnings under our normal build settings.

Clear as mud?
--js


> [...]
>
>

--00000000000004a49806303aba68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13,=
 2025 at 10:41=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@re=
dhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; This patch does three things:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. Record the current namespace context in pending_xrefs so i=
t can be<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 used for link resolution later,<br>
&gt;&gt; &gt; 2. Pass that recorded namespace context to find_obj() when re=
solving a<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 reference, and<br>
&gt;&gt; &gt; 3. Wildly and completely rewrite find_obj().<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; cross-reference support is expanded to tolerate the presence =
or absence<br>
&gt;&gt; &gt; of either namespace or module, and to cope with the presence =
or absence<br>
&gt;&gt; &gt; of contextual information for either.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; References now work like this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. If the explicit reference target is recorded in the domain=
&#39;s object<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 registry, we link to that target and stop lookin=
g. We do this lookup<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 regardless of how fully qualified the target is,=
 which allows direct<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 references to modules (which don&#39;t have a mo=
dule component to their<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 names) or direct references to definitions that =
may or may not belong<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 to a namespace or module.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 2. If contextual information is available from qapi:namespace=
 or<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 qapi:module directives, try using those componen=
ts to find a direct<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 match to the implied target name.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 3. If both prior lookups fail, generate a series of regular e=
xpressions<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 looking for wildcard matches in order from most =
to least<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 specific. Any explicitly provided components (na=
mespace, module)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 *must* match exactly, but both contextual and en=
tirely omitted<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 components are allowed to differ from the search=
 result. Note that if<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 more than one result is found, Sphinx will emit =
a warning (a build<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 error for QEMU) and list all of the candidate re=
ferences.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The practical upshot is that in the large majority of cases, =
namespace<br>
&gt;&gt; &gt; and module information is not required when creating simple `=
references`<br>
&gt;&gt; &gt; to definitions from within the same context -- even when iden=
tical<br>
&gt;&gt; &gt; definitions exist in other contexts.<br>
&gt;&gt;<br>
&gt;&gt; Can you illustrate this this examples?<br>
&gt;&gt;<br>
&gt;<br>
&gt; do wha?<br>
<br>
Sorry, I went into the curve too fast.<br>
<br>
The stuff under &quot;References now work like this&quot; confuses me.=C2=
=A0 I guess it<br>
describes a series of lookups to try one after the other.<br>
<br>
I understand a cross-reference consists of namespace (optional), module<br>
(optional), name, and role.<br>
<br>
Let&#39;s assume role is &quot;any&quot; for simplicity&#39;s sake.<br>
<br>
Regarding &quot;1. If the explicit ...&quot;:<br>
<br>
=C2=A0 =C2=A0 What is a reference&#39;s &quot;explicit reference target&quo=
t;?=C2=A0 Examples might<br>
=C2=A0 =C2=A0 help me understand.<br></blockquote><div><br></div><div>expli=
cit lookup: `QMP:block-core:block-dirty-bitmap-add`</div><div><br></div><di=
v>If that explicit target matches an object in the object database *directl=
y*, we match immediately and don&#39;t consider other potential targets. Th=
is also applies to things like modules, e.g. `QMP:block-core` even though t=
he &quot;module&quot; is absent (it IS the module)</div><div><br></div><div=
>We always search for the explicit target no matter how un/fully qualified =
it is.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
=C2=A0 =C2=A0 What is &quot;recorded in the domain&#39;s object registry&qu=
ot;?<br></blockquote><div><br></div><div>domain.objects{} - essentially a r=
ecord of every ObjectDefinition&#39;s &quot;fullname&quot; - the return val=
ue from QAPIDefinition._get_fqn().</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 Can you show me a reference where this lookup succeeds?<br></=
blockquote><div><br></div><div>`QMP:block-core`</div><div>`QMP:block-core.b=
lock-dirty-bitmap-add`</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
Regarding &quot;2. If contextual information ...&quot;:<br>
<br>
=C2=A0 =C2=A0 I guess &quot;contextual information&quot; is the context est=
ablished by<br>
=C2=A0 =C2=A0 qapi:namespace and qapi:module directives, i.e. the current<b=
r>
=C2=A0 =C2=A0 namespace and module, if any.<br></blockquote><div><br></div>=
<div>Yep!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
=C2=A0 =C2=A0 If the cross reference lacks a namespace, we substitute the c=
urrent<br>
=C2=A0 =C2=A0 namespace.=C2=A0 Same for module.<br>
<br>
=C2=A0 =C2=A0 We then use that &quot;to find a direct match to the implied =
target<br>
=C2=A0 =C2=A0 name&quot;.=C2=A0 Sounds greek to me.=C2=A0 Example(s) might =
help.<br></blockquote><div><br></div><div>If namespace or module is missing=
 from the link target, we try to fill in the blanks with the contextual inf=
ormation if present.</div><div><br></div><div>Example, we are in the block-=
core section of the QEMU QMP reference manual document and we reference `bl=
ock-dirty-bitmap-add`. With context, we are able to assemble a fully qualif=
ied name: &quot;QMP:block-core.block-dirty-bitmap-add`. This matches an ite=
m in the registry directly, so it matches and no further search is performe=
d.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regarding &quot;3. If both prior lookups fail ...&quot;:<br>
<br>
=C2=A0 =C2=A0 I guess we get here when namespace or module are absent, and<=
br>
=C2=A0 =C2=A0 substituting the current namespace or module doesn&#39;t reso=
lve.=C2=A0 We<br>
=C2=A0 =C2=A0 then substitute a wildcard, so to speak, i.e. look in all nam=
espaces<br>
=C2=A0 =C2=A0 / modules, and succeed if we find exactly one resolution.=C2=
=A0 Fair?<br></blockquote><div><br></div><div>More or less, though the mech=
anics are quite a bit more complex than your overview (and what I wrote in =
qapi-domain.rst.) We can get here for a few reasons:</div><div><br></div><d=
iv>(1) We didn&#39;t provide a fully qualified target, and we don&#39;t hav=
e full context to construct one. For example, we are not &quot;in&quot; a n=
amespace and/or not &quot;in&quot; a module. This is quite likely to happen=
 when writing simple references to a definition name from outside of the tr=
ansmogfrified QAPI documentation, e.g. from qapi-domain.rst itself, or dirt=
y-bitmaps.rst, etc.</div><div><br></div><div>(2) We didn&#39;t provide a fu=
lly qualified target, and we are referencing something from outside of the =
local context. For example, we are &quot;in&quot; a module but we are tryin=
g to link to a different module&#39;s definition. e.g. we are in QMP:transa=
ction and we reference `block-dirty-bitmap-add`. The implied FQN will be QM=
P:transaction.block-dirty-bitmap.add, which will not resolve.</div><div><br=
></div><div>The fuzzy search portion has an order of precedence for how it =
searches - and not all searches are tried universally, they are conditional=
 to what was provided in the reference target and what context is available=
.</div><div><br></div><div>1. match against the explicitly provided namespa=
ce (module was not explicitly provided)</div><div>2. match against the expl=
icitly provided module (namespace was not explicitly provided)</div><div>3.=
 match against the implied namespace (neither namespace/module was explicit=
ly provided)</div><div>4. match against the implied module (neither namespa=
ce/module was explicitly provided)</div><div>5. match against the definitio=
n name only, from anywhere (neither namespace/module was explicitly provide=
d)</div><div><br></div><div>The searches are performed in order: if a searc=
h returns zero results, the next search is tried. If any search returns one=
 or more results, those results are returned and we stop searching down the=
 list. The priority order ensures that any explicitly provided information =
is *always* used to find a match, but contextually provided information is =
merely a &quot;hint&quot; and can be ignored for the sake of a match.</div>=
<div><br></div><div>If find_obj() as a whole returns zero results, Sphinx e=
mits a warning for a dangling reference. if find_obj() as a whole returns m=
ultiple results, Sphinx emits a warning for the ambiguous cross-reference.<=
/div><div><br></div><div>QEMU errors out on any such warnings under our nor=
mal build settings.</div><div><br></div><div>Clear as mud?</div><div>--js</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div>

--00000000000004a49806303aba68--


