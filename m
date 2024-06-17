Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFF5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGEP-0000A9-G9; Mon, 17 Jun 2024 13:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGEN-00009d-Tt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGEK-0007kd-5v
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718645597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1WDpKU7kvcymiCp9rDXw74SzlTQTDFJwJX0usluKGw=;
 b=KZ1r+REbfoRSAz85PotIqryBgEfMYINd8Hq9aHmlxV3URufky2PRDGoYJs2dWNrca1YOy/
 6iFQP3AvKBeivtFOJ8RLC8dh8QfTYwBpkBzh6Y5NTgt4+A4sMuXwl5oeZWEGpOoLYHGuZb
 sCURORdMc+BRuvHD61GOLhmy6wgfOcM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9yZOTYxdMQGgN6_WzVggIA-1; Mon, 17 Jun 2024 13:33:16 -0400
X-MC-Unique: 9yZOTYxdMQGgN6_WzVggIA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7051baf0519so1563887a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718645595; x=1719250395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R1WDpKU7kvcymiCp9rDXw74SzlTQTDFJwJX0usluKGw=;
 b=FwS9LQScCoPkUOtE1T7onNh4mSni51YA4dSXz63enWGvryioSRyfm0sA+cxJENwP/1
 9ENF0GOGk43jczrEBWHBa2AILZk1BIwd7c0waOWtdQpzKq25QG5NZP2sPDNnqT/+1LUT
 Gs0oA1NiBYCfwI+XikwlM6HLLk/3L4Id2di+JbkOpFQbOp7bt83sO+q8qhMh7fkkaY8b
 SVTzAaKogfn6Bw9QwxMNfPIblFcAe83AVmAMeueSFuIpJP8y6NmU/7iB1lCzBUXEdwYF
 r1m6XsGlBsWN1AJVf50E2J7QQ7TaAEX3TPl4X1jGZtGsmCuTBXFzXP1ulPhYFTrSiAPV
 uVtA==
X-Gm-Message-State: AOJu0Yxdb5XUL1X3ZHvuGu4vCGltFQ80isIn2znQ8ocv8jqEM6x1rae0
 yA9qT79/bEF+HqISgq1P+q4LTjW9nB4WqCZ7Ki6qbuoaX+JcWWrwbURVgBjEAlREQ72G/S4PIn3
 XbhiIjgsnyF1SkyibighzCl5QmYw09imhTr3N2w6ZZ8ETx12kygnOeD2uSl2vTy9Bu8ep1OKCaP
 IRyYgaDCHuV5gkam7RLhWXgtgCilw=
X-Received: by 2002:a17:902:c401:b0:1f6:f0fe:6cc9 with SMTP id
 d9443c01a7336-1f8629f9d2amr116017205ad.54.1718645594881; 
 Mon, 17 Jun 2024 10:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6mlkgjP7WS4QkhhXeAt0ZM1en2Hd9CSoVqdRgi7EoTUsPu7GVcUPw7vL0Llt3IaP+ZE0BWPk+Pke0Ynlp/HQ=
X-Received: by 2002:a17:902:c401:b0:1f6:f0fe:6cc9 with SMTP id
 d9443c01a7336-1f8629f9d2amr116016825ad.54.1718645594357; Mon, 17 Jun 2024
 10:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-12-jsnow@redhat.com>
 <878qz750cp.fsf@pond.sub.org>
In-Reply-To: <878qz750cp.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 13:33:02 -0400
Message-ID: <CAFn=p-Z=c_BTkBSj4-cQsMSee5o+t==bzmmuSWev5xrgi21Cdg@mail.gmail.com>
Subject: Re: [PATCH 11/20] qapi/schema: add doc_visible property to
 QAPISchemaDefinition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000259799061b195c7b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000259799061b195c7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, 5:40=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The intent here is to mark only certain definitions as visible in the
> > end-user docs.
> >
> > All commands and events are inherently visible. Everything else is
> > visible only if it is a member (or a branch member) of a type that is
> > visible, or if it is named as a return type for a command.
> >
> > Notably, this excludes arg_type for commands and events, and any
> > base_types specified for structures/unions. Those objects may still be
> > marked visible if they are named as members from a visible type.
>
> Why?  I figure the answer is "because the transmogrifier inlines the
> things excluded".  Correct?
>

Yes. If a type is only ever used as a branch type or a base type and never
named as a field type, it can be safely omitted from the rendered docs.

(If a type is not named in any fashion by and command or event or recursive
structure therein, it's an internal type not used in QMP at all and can
also be excluded safely.)


> > This does not necessarily match the data revealed by introspection: in
> > this case, we want anything that we are cross-referencing in generated
> > documentation to be available to target.
>
> I don't get the part after the colon.
>

What I mean to say is that anywhere in the generated documentation where we
need to cross-reference a type name should be "doc visible".

This means, currently:

- All commands
- All events
- All member field types (including branch field types) of commands/events
or nested fields therein (i.e. CommandA takes an arg "foo" of type "FooA"
which in turn has a field "bar" of type "BarB"; CommandA, FooA and BarB are
all doc visible types.)
- All return types and nested types therein; identical to the input rules
above (You've expressed a desire to change this. Future work.)
- All alternate types (which are never inlined but instead are referenced.
This can be changed later but it's just not how it works currently.)

but excludes:

- Arg types for events/commands
- Inherited object types
- Any data type that does not appear as a field/member type for a
command/event input/output
- Array/List types: only the primitive types are documented with a section,
not the List/Array container. This is in contrast to Alternates, where we
do not perform a similar destructuring.

So, if you look at the WIP render on gitlab.io, any (type) parenthetical
links to a "qapi object" (Sphinx parlance: an indexable qapi domain
*thingie*) that exists as its own section with a name and docs attached.

Those are the ones that are "doc visible".

This differs from introspection in that some (but not all) of the shared
types get sections in the HTML output, but these are not API and not
inherently stable with regards to their name(s) or factorings.

Introspection by contrast strips more of the names out than we do here.


> > Some internal and built-in types may be marked visible with this
> > approach, but if they do not have a documentation block, they'll be
> > skipped by the generator anyway. This includes array types and built-in
> > primitives which do not get their own documentation objects.
> >
> > This information is not yet used by qapidoc, which continues to render
> > documentation exactly as it has. This information will be used by the
> > new qapidoc (the "transmogrifier"), to be introduced later. The new
> > generator verifies that all of the objects that should be rendered *are=
*
> > by failing if any cross-references are missing, verifying everything is
> > in place.
>
> So... we decide "doc should be visible" here, and then the
> transmogrifier decides again, and we check the two decisions match?
>

Not quite; in the generator, we visit only entities that *have docs*, so
the true visibility check is (pseudocode):

ent.doc_visible() && ent.has_docs()

but we guarantee this does not cull anything inappropriate because any
hanging reference is a warning that will cause a build failure. This should
not be possible to trigger in the doc builder under normal circumstances.

I just mean to say: "I believe the algorithm in this patch is correct
because the build would not tolerate a hanging reference, and the doc
generator does in fact succeed."

Notably, the doc_visible algorithm may mark some built-in types as
"visible", but they're still excluded from the html render because they
simply have no docs to show. (The reference checker will not yelp for these
built-in types.)


> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000259799061b195c7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 14, 2024, 5:40=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; The intent here is to mark only certain definitions as visible in the<=
br>
&gt; end-user docs.<br>
&gt;<br>
&gt; All commands and events are inherently visible. Everything else is<br>
&gt; visible only if it is a member (or a branch member) of a type that is<=
br>
&gt; visible, or if it is named as a return type for a command.<br>
&gt;<br>
&gt; Notably, this excludes arg_type for commands and events, and any<br>
&gt; base_types specified for structures/unions. Those objects may still be=
<br>
&gt; marked visible if they are named as members from a visible type.<br>
<br>
Why?=C2=A0 I figure the answer is &quot;because the transmogrifier inlines =
the<br>
things excluded&quot;.=C2=A0 Correct?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Yes. If a type is only ever used as a=
 branch type or a base type and never named as a field type, it can be safe=
ly omitted from the rendered docs.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">(If a type is not named in any fashion by and command or event o=
r recursive structure therein, it&#39;s an internal type not used in QMP at=
 all and can also be excluded safely.)</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; This does not necessarily match the data revealed by introspection: in=
<br>
&gt; this case, we want anything that we are cross-referencing in generated=
<br>
&gt; documentation to be available to target.<br>
<br>
I don&#39;t get the part after the colon.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">What I mean to say is that anywher=
e in the generated documentation where we need to cross-reference a type na=
me should be &quot;doc visible&quot;.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">This means, currently:</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">- All commands</div><div dir=3D"auto">- All events</div><div d=
ir=3D"auto">- All member field types (including branch field types) of comm=
ands/events or nested fields therein (i.e. CommandA takes an arg &quot;foo&=
quot; of type &quot;FooA&quot; which in turn has a field &quot;bar&quot; of=
 type &quot;BarB&quot;; CommandA, FooA and BarB are all doc visible types.)=
</div><div dir=3D"auto">- All return types and nested types therein; identi=
cal to the input rules above (You&#39;ve expressed a desire to change this.=
 Future work.)</div><div dir=3D"auto">- All alternate types (which are neve=
r inlined but instead are referenced. This can be changed later but it&#39;=
s just not how it works currently.)</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">but excludes:</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">- Arg types for events/commands</div><div dir=3D"auto">- Inherited object=
 types</div><div dir=3D"auto">- Any data type that does not appear as a fie=
ld/member type for a command/event input/output</div><div dir=3D"auto">- Ar=
ray/List types: only the primitive types are documented with a section, not=
 the List/Array container. This is in contrast to Alternates, where we do n=
ot perform a similar destructuring.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">So, if you look at the WIP render on <a href=3D"http://gitlab.i=
o">gitlab.io</a>, any (type) parenthetical links to a &quot;qapi object&quo=
t; (Sphinx parlance: an indexable qapi domain *thingie*) that exists as its=
 own section with a name and docs attached.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Those are the ones that are &quot;doc visible&quot;.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">This differs from introspe=
ction in that some (but not all) of the shared types get sections in the HT=
ML output, but these are not API and not inherently stable with regards to =
their name(s) or factorings.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Introspection by contrast strips more of the names out than we d=
o here.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Some internal and built-in types may be marked visible with this<br>
&gt; approach, but if they do not have a documentation block, they&#39;ll b=
e<br>
&gt; skipped by the generator anyway. This includes array types and built-i=
n<br>
&gt; primitives which do not get their own documentation objects.<br>
&gt;<br>
&gt; This information is not yet used by qapidoc, which continues to render=
<br>
&gt; documentation exactly as it has. This information will be used by the<=
br>
&gt; new qapidoc (the &quot;transmogrifier&quot;), to be introduced later. =
The new<br>
&gt; generator verifies that all of the objects that should be rendered *ar=
e*<br>
&gt; by failing if any cross-references are missing, verifying everything i=
s<br>
&gt; in place.<br>
<br>
So... we decide &quot;doc should be visible&quot; here, and then the<br>
transmogrifier decides again, and we check the two decisions match?<br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Not quit=
e; in the generator, we visit only entities that *have docs*, so the true v=
isibility check is (pseudocode):</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">ent.doc_visible() &amp;&amp; ent.has_docs()</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">but we guarantee this does not cull anything =
inappropriate because any hanging reference is a warning that will cause a =
build failure. This should not be possible to trigger in the doc builder un=
der normal circumstances.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I just mean to say: &quot;I believe the algorithm in this patch is correc=
t because the build would not tolerate a hanging reference, and the doc gen=
erator does in fact succeed.&quot;</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Notably, the doc_visible algorithm may mark some built-in types =
as &quot;visible&quot;, but they&#39;re still excluded from the html render=
 because they simply have no docs to show. (The reference checker will not =
yelp for these built-in types.)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000259799061b195c7b--


