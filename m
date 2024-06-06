Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF9AC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 17:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFGov-00053R-9B; Thu, 06 Jun 2024 13:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sFGou-00052a-79
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sFGor-0000fM-00
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717694550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0RTHHnju26spaZXOce0lBekp84iL4wxEGEEh6iDvus=;
 b=Dmy7JslJpz6c5gxBkdB1Ni95cYKdw7iJNqP+CFLKnNvu54MP8lBA8ARovWzw8rYurVrkTL
 ip4AIS/TuWRA9+Nda+lw1i77m9S0fNVsGXvB8+ps19L7vQjNvLjmIwQ33rwCWyj8g2RhZ+
 35MXSisaLa/+dROMXaJKA4claoGLibc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-rgl2fXLdMDK02X6kalqLIw-1; Thu, 06 Jun 2024 13:22:29 -0400
X-MC-Unique: rgl2fXLdMDK02X6kalqLIw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c1aa8d19bbso1092176a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 10:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717694547; x=1718299347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d0RTHHnju26spaZXOce0lBekp84iL4wxEGEEh6iDvus=;
 b=RMZduUDOjM875Nn+guRg/740f5XYCQE9dMqM3PrTGR6kpQSxKd5uJMLiDw/S7/C7aB
 gMr58XEYg5YPbAIAkYNIjYRVZyh8GqScIlcXOh7019mkldp/uWdgE1vBvbobFzJGzp1I
 W97LH6/xFE+fjWOAOykSqyk6LqFn57VvPI92hNalHjxQZGO7z6UkcH2H0oBt35IzaiL+
 1r7PzomPPctF1kOuJ2RRZnjMiLUdNDZOdAaH3iqtZibi1R8aigNxOcw6xEWIZM9fNUDh
 MVchHds5DIpnVIX0AtzloENPs4lkOSmHxoicg0VsNwYlr9jWErS9KqD4ED+CHV72Dr8w
 2YBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZl3w2w4j+/sv57361h8j5M14ljIBq/t46uWXaHljQR8hPBr70QwB0YfK9HEl6ynqkYc2FzuqUh86vDx/lzJL6MkoYjZ0=
X-Gm-Message-State: AOJu0YyJT9N5aATqYClKTzz7EtKsmQIfUnvXkuDeDnnfKs5okY/gTeNH
 GVw6RwjJevTJYIjNrhNEBgmeJdx5p93lNkUEvcWJZFZ4C4a0Y1YUuHc5lJOYw/WLQ3Zn7y5X/sf
 xuF/awldPLfjkfdqdaJxh5OXVX5Z56ulNQrv5ySPGInr5JCEzilWeI30wKsHCuf1fhHsK75eu0i
 GVHwcWRllfdxYWePGcikPeLU8dLXPdwXjhtYX45w==
X-Received: by 2002:a17:90a:bb97:b0:2ab:87c3:d12c with SMTP id
 98e67ed59e1d1-2c2bcac3ba6mr178382a91.2.1717694547145; 
 Thu, 06 Jun 2024 10:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXiJpdMvvcfIbVd8O/MqSAmNqzVw+5+FLZNBLQ3aUJIXWB/8Q2Jmw/nSfJ33kFLQEPMUbpvq+Ph+GDAj97QVA=
X-Received: by 2002:a17:90a:bb97:b0:2ab:87c3:d12c with SMTP id
 98e67ed59e1d1-2c2bcac3ba6mr178359a91.2.1717694546674; Thu, 06 Jun 2024
 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-bdoi1yDQTNhpzM=MP5s8Zm9zxuxbD-zPs_h_iA8C=mGg@mail.gmail.com>
 <ipebw5yv4l5joa54vk42rb2fmuykzvmjar7blcwiwstj5fwyuq@ycl4du6sb724>
In-Reply-To: <ipebw5yv4l5joa54vk42rb2fmuykzvmjar7blcwiwstj5fwyuq@ycl4du6sb724>
From: John Snow <jsnow@redhat.com>
Date: Thu, 6 Jun 2024 13:22:14 -0400
Message-ID: <CAFn=p-b9gLmAwLAjzf2RWA4JZuxVM-nnwETwQ44c8F0kOkReVg@mail.gmail.com>
Subject: Re: Historical QMP schema
To: Victor Toso <victortoso@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000049a237061a3bedec"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--00000000000049a237061a3bedec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding upstream because I think there's little reason to keep this
discussion off-list.

The context of this mailing thread is that we are discussing how we might
want to store and record historical QMP API interface information such that
we can programmatically answer questions like "when was X command
introduced?", but possibly also to generate changelog QMP reports for
auditing QMP changes for each version during the release candidate window.

On Thu, Jun 6, 2024 at 6:25=E2=80=AFAM Victor Toso <victortoso@redhat.com> =
wrote:

> Hi John!
>
> On Wed, Jun 05, 2024 at 11:47:53AM GMT, John Snow wrote:
> > Hi,
> >
> > as part of my project to modernize QMP documentation I recently
> > forked the QAPI generator and modded it to be able to read
> > historical QAPI schema going all the way back to v1.0.
> >
> > We want to be able to use this ability to generate accurate
> > "since:" data for the docs.
>
> :)
>
> > My question for you is: do you have any input or preferences
> > for the format of "output" or "compiled" schemata?
>
> Not sure if I understand 'output' & 'compiled' reference here.
>

The idea is that even though I can modify the schema parser to cope with
historical versions of the schema, we should re-save the schema into a
unified format so that the gross hacks and kludges made to support old
versions in my forked QAPI parser don't need to be kept in-tree. In theory,
we only need to parse each historical schema precisely once.

(And then we'll only need to parse each new schema going forward with the
version of the QAPI parser that's already in-tree.)

Importantly, old versions of the schema aren't contained *entirely* within
the schema. Here's a timeline:

v0.12.0: QMP first introduced. Events are hardcoded, commands are defined
in qemu-monitor.hx. query commands are hard-coded in monitor.c.
v0.14.0: qemu-monitor.hx is forked into qmp-commands.hx and hmp-commands.hx
v1.0: First version which features qapi-schema.json; all query commands are
qapified but most other commands are not.
v1.1.0: A very large chunk of commands are QAPIfied.
v1.3.0: Most commands are now QAPIfied, but there are 2-3 remaining.
v2.1.0: events are now fully qapified; most are now defined in
qapi/events.json
v2.8.0: The remaining commands are fully qapified; qmp-commands.hx is
removed.

So what I mean by "compiled" schema is parsing historical revisions of the
schema, including descriptive schema definitions for items not-yet-qapified
(but nonetheless remain available in that version), and writing that
curated information back out to disk (and checking into qemu.git) for later
reference.

There are multiple choices for this output format:

(A) Just output in native qapi-schema format, just choose the "latest
version".
(B) Choose some other arbitrary format.
(C) Some secret, third thing.

I don't like the native qapi schema idea, for a few reasons:
- It changes over time
- It does not support nested structures except by reference, but
- Type names are not meant to API visible
- Detecting data changes in nested, shared types is difficult

In my prototype thus far, I have used a JSON-Schema based format with a
type definition library that catalogues all of the command arg / command
return / event data types with *all fields* fully dereferenced and inlined,
except where impossible due to cyclical/recursive references (PCI and
BlockStats come to mind.)

A benefit of this "compilation" is that all commands have their arguments
and return values described solely by type (and for enums, values) and not
by type name - fully removing non-API information from the "compiled"
version.

A downside is that this is yet-another-format that differs from the
existing format that requires someone knowledgeable to manipulate in case
there are errors found in it, or worse - we decide to change or upgrade the
format in some way to support a new feature in the future and we must
yet-again revise our catalogue of historical schemata.


>
> My preference is for this metadata to be there when the generator
> parses the schema. It could another external metadata file, but
> available to the generator.
>

Yes, ideally...

I'm thinking that I'd like to include a qapi/history/ directory which
contains a record of all compiled historical schemata, and the generator
can parse the directory and load up them all up - and then compile a quick
lookup table that is able to answer basic questions about the data.

i.e. "when was X [command/event] first introduced?"

"when was Command.arguments.key first introduced / incompatibly modified?"

The syntax/API for how to ask the QAPISchema object these questions remains
unpondered, as does the question "how do we report 'since' information in
the rendered QMP documentation HTML for nested objects that we begrudgingly
refer to only by type?"

Even if QAPI type names are not API, and even if my new QMP documentation
project eliminates as many type names as it can by inlining inherited
structures, boxed arguments, and branches - there are still referenced
types for argument types. That might be a messy/unsolvable problem right
now.


>
> We can then identify all the cases where something might have
> changed, when it changed, and what proper outputs would we have
> due to that. (e.g: field added/removed)
>
> For a whole discussion of this between Markus, Daniel and Andrea
> with Go output (possibilities) in mind, see the thread from
>
>     Date: Tue, 10 May 2022 13:51:05 +0100
>     From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>     Subject: Re: [RFC PATCH v1 0/8] qapi: add generator for Golang
> interface
>     Message-ID: <YnpfuYvBu56CCi7b@redhat.com>
>
> > I figured you might have some opinions because of your dbus and
> > other API work.  Possibly this historical record is useful to
> > you in some way.
>
> I'm thinking back on when I worked in the libvirt-go-module code
> generator.
>
> For the Go bindings itself, I'm inclined to a have its versions
> follow closely QEMU versions which brings each qapi-go tag to
> support to what QAPI itself supports for that QEMU version we
> generated that code. I think this is more or less close to what
> Go applications would expect. So, the Since version is not that
> impactful as it was for libvirt-go-module. Ah, based on what
> Marc-Andr=C3=A9 wrote, I think this is the same for qapi-rs.
>
> Cheers,
> Victor
>

As bonus context: here's output from a small utility I wrote called
schema-diff that compares the compiled v1.0 and v1.1.0 schema:

```
jsnow@scv ~/s/qemu ((v3.1.0))> ./schema-diff.py qapi-compiled-v1.0.json
qapi-compiled-v1.1.0.json
Added commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
block-job-cancel
block-job-set-speed
block-stream
block_set_io_throttle
change-vnc-password
qom-get
qom-list
qom-list-types
qom-set
query-block-jobs
system_wakeup
transaction
xen-save-devices-state

Removed commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Modified commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
add_client (x-qemu-arguments)
    ++ arguments.tls: Optional<boolean>
blockdev-snapshot-sync (x-qemu-arguments)
    -- arguments.snapshot-file: Optional<string>
    ++ arguments.mode: Optional<enum>
    ++ arguments.snapshot-file: string
memsave (x-qemu-arguments)
    ++ arguments.cpu-index: Optional<integer>
query-block (x-qemu-returns)
    ++ returns[].inserted.bps: integer
    ++ returns[].inserted.bps_rd: integer
    ++ returns[].inserted.bps_wr: integer
    ++ returns[].inserted.iops: integer
    ++ returns[].inserted.iops_rd: integer
    ++ returns[].inserted.iops_wr: integer
query-spice (x-qemu-returns)
    ++ returns.mouse-mode: enum
query-status (x-qemu-returns)
       returns.status: enum
        ++ suspended
```

It's possibly rough around the edges (branches, ifcond and features are not
yet supported; alternates are kinda-supported but do not yet diff
well/prettily, ignore the "x-qemu-" stuff), and the diff output uses an
arbitrary/invented "key path" and "field type" notation in order to
simplify the changelog summary, but you can hopefully see the utility of
such a report.

Helpfully, it shows *all levels* of changes, no matter how deeply nested,
so *all* potential changes to the API can be observed / audited /
documented. The only types it ever reports are fundamental JSON types and
"any" and "enum", so any refactoring we do in the QAPI schema with regards
to type names, inheritance, boxing, etc are fully transparent in this
analysis.

It's a useful tool for reviewing QAPI changes during the RC period to
ensure we did not accidentally create any breaking changes since the last
released version.

One more example for the road:

```
jsnow@scv ~/s/qemu ((v3.1.0))> ./schema-diff.py qapi-compiled-v1.1.0.json
qapi-compiled-v1.2.0.json
Added commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
add-fd
device-list-properties
dump-guest-memory
migrate-set-cache-size
migrate-set-capabilities
query-cpu-definitions
query-events
query-fdsets
query-machines
query-migrate-cache-size
query-migrate-capabilities
query-target
remove-fd

Removed commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Modified commands
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
query-block (x-qemu-returns)
    ++ returns[].inserted.backing_file_depth: integer
    ++ returns[].inserted.encryption_key_missing: boolean
query-migrate (x-qemu-returns)
    ++ returns.disk.duplicate: integer
    ++ returns.disk.normal: integer
    ++ returns.disk.normal-bytes: integer
    ++ returns.ram.duplicate: integer
    ++ returns.ram.normal: integer
    ++ returns.ram.normal-bytes: integer
    ++ returns.total-time: Optional<integer>
    ++ returns.xbzrle-cache: Optional<object>
    ++ returns.xbzrle-cache.bytes: integer
    ++ returns.xbzrle-cache.cache-miss: integer
    ++ returns.xbzrle-cache.cache-size: integer
    ++ returns.xbzrle-cache.overflow: integer
    ++ returns.xbzrle-cache.pages: integer
```

Here, you can see that although the "disk" and "ram" fields for
query-migrate's return type are very likely the same actual type, the
compiler has evaluated everything down to its constituent parts and
reported each difference independently for the report; preserving the
possibility to obtain wire-protocol accurate added/modified data for each
and every individual key.

I'll also point out that this diff view does not confuse "first version
qapified" with "first version introduced"; v1.2.0 actually qapified several
commands for the first time, but they remained available in earlier
versions. The diff output accurately reflects this.

--js

--00000000000049a237061a3bedec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Adding upstream because I think there&#39;s little re=
ason to keep this discussion off-list.</div><div><br></div><div>The context=
 of this mailing thread is that we are discussing how we might want to stor=
e and record historical QMP API interface information such that we can prog=
rammatically answer questions like &quot;when was X command introduced?&quo=
t;, but possibly also to generate changelog QMP reports for auditing QMP ch=
anges for each version during the release candidate window.<br></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun =
6, 2024 at 6:25=E2=80=AFAM Victor Toso &lt;<a href=3D"mailto:victortoso@red=
hat.com">victortoso@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi John!<br>
<br>
On Wed, Jun 05, 2024 at 11:47:53AM GMT, John Snow wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; as part of my project to modernize QMP documentation I recently<br>
&gt; forked the QAPI generator and modded it to be able to read<br>
&gt; historical QAPI schema going all the way back to v1.0.<br>
&gt; <br>
&gt; We want to be able to use this ability to generate accurate<br>
&gt; &quot;since:&quot; data for the docs.<br>
<br>
:)<br>
<br>
&gt; My question for you is: do you have any input or preferences<br>
&gt; for the format of &quot;output&quot; or &quot;compiled&quot; schemata?=
<br>
<br>
Not sure if I understand &#39;output&#39; &amp; &#39;compiled&#39; referenc=
e here.<br></blockquote><div><br></div><div>The idea is that even though I =
can modify the schema parser to cope with historical versions of the schema=
, we should re-save the schema into a unified format so that the gross hack=
s and kludges made to support old versions in my forked QAPI parser don&#39=
;t need to be kept in-tree. In theory, we only need to parse each historica=
l schema precisely once.</div><div><br></div><div>(And then we&#39;ll only =
need to parse each new schema going forward with the version of the QAPI pa=
rser that&#39;s already in-tree.)<br></div><div><br></div><div>Importantly,=
 old versions of the schema aren&#39;t contained *entirely* within the sche=
ma. Here&#39;s a timeline:</div><div><br></div><div>v0.12.0: QMP first intr=
oduced. Events are hardcoded, commands are defined in qemu-monitor.hx. quer=
y commands are hard-coded in monitor.c.<br></div><div>v0.14.0: qemu-monitor=
.hx is forked into qmp-commands.hx and hmp-commands.hx</div><div>v1.0: Firs=
t version which features qapi-schema.json; all query commands are qapified =
but most other commands are not.</div><div>v1.1.0: A very large chunk of co=
mmands are QAPIfied.</div><div>v1.3.0: Most commands are now QAPIfied, but =
there are 2-3 remaining.</div><div>v2.1.0: events are now fully qapified; m=
ost are now defined in qapi/events.json<br></div><div>v2.8.0: The remaining=
 commands are fully qapified; qmp-commands.hx is removed.</div><div><br></d=
iv><div>So what I mean by &quot;compiled&quot; schema is parsing historical=
 revisions of the schema, including descriptive schema definitions for item=
s not-yet-qapified (but nonetheless remain available in that version), and =
writing that curated information back out to disk (and checking into qemu.g=
it) for later reference.<br></div><div><br></div><div>There are multiple ch=
oices for this output format:</div><div><br></div><div>(A) Just output in n=
ative qapi-schema format, just choose the &quot;latest version&quot;.</div>=
<div>(B) Choose some other arbitrary format.</div><div>(C) Some secret, thi=
rd thing.<br></div><div><br></div><div>I don&#39;t like the native qapi sch=
ema idea, for a few reasons:</div><div>- It changes over time</div><div>- I=
t does not support nested structures except by reference, but</div><div>- T=
ype names are not meant to API visible</div><div>- Detecting data changes i=
n nested, shared types is difficult<br></div><div><br></div><div>In my prot=
otype thus far, I have used a JSON-Schema based format with a type definiti=
on library that catalogues all of the command arg / command return / event =
data types with *all fields* fully dereferenced and inlined, except where i=
mpossible due to cyclical/recursive references (PCI and BlockStats come to =
mind.)</div><div><br></div><div>A benefit of this &quot;compilation&quot; i=
s that all commands have their arguments and return values described solely=
 by type (and for enums, values) and not by type name - fully removing non-=
API information from the &quot;compiled&quot; version.</div><div><br></div>=
<div>A downside is that this is yet-another-format that differs from the ex=
isting format that requires someone knowledgeable to manipulate in case the=
re are errors found in it, or worse - we decide to change or upgrade the fo=
rmat in some way to support a new feature in the future and we must yet-aga=
in revise our catalogue of historical schemata.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
My preference is for this metadata to be there when the generator<br>
parses the schema. It could another external metadata file, but<br>
available to the generator.<br></blockquote><div><br></div><div>Yes, ideall=
y...</div><div><br></div><div>I&#39;m thinking that I&#39;d like to include=
 a qapi/history/ directory which contains a record of all compiled historic=
al schemata, and the generator can parse the directory and load up them all=
 up - and then compile a quick lookup table that is able to answer basic qu=
estions about the data.</div><div><br></div><div>i.e. &quot;when was X [com=
mand/event] first introduced?&quot;</div><div><br></div><div>&quot;when was=
 Command.arguments.key first introduced / incompatibly modified?&quot;</div=
><div><br></div><div>The syntax/API for how to ask the QAPISchema object th=
ese questions remains unpondered, as does the question &quot;how do we repo=
rt &#39;since&#39; information in the rendered QMP documentation HTML for n=
ested objects that we begrudgingly refer to only by type?&quot;</div><div><=
br></div><div>Even if QAPI type names are not API, and even if my new QMP d=
ocumentation project eliminates as many type names as it can by inlining in=
herited structures, boxed arguments, and branches - there are still referen=
ced types for argument types. That might be a messy/unsolvable problem righ=
t now.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
We can then identify all the cases where something might have<br>
changed, when it changed, and what proper outputs would we have<br>
due to that. (e.g: field added/removed)<br>
<br>
For a whole discussion of this between Markus, Daniel and Andrea<br>
with Go output (possibilities) in mind, see the thread from<br>
<br>
=C2=A0 =C2=A0 Date: Tue, 10 May 2022 13:51:05 +0100<br>
=C2=A0 =C2=A0 From: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mail=
to:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 Subject: Re: [RFC PATCH v1 0/8] qapi: add generator for Golan=
g interface<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:YnpfuYvBu56CCi7b@redhat.com=
" target=3D"_blank">YnpfuYvBu56CCi7b@redhat.com</a>&gt;<br>
<br>
&gt; I figured you might have some opinions because of your dbus and<br>
&gt; other API work.=C2=A0 Possibly this historical record is useful to<br>
&gt; you in some way.<br>
<br>
I&#39;m thinking back on when I worked in the libvirt-go-module code<br>
generator.<br>
<br>
For the Go bindings itself, I&#39;m inclined to a have its versions<br>
follow closely QEMU versions which brings each qapi-go tag to<br>
support to what QAPI itself supports for that QEMU version we<br>
generated that code. I think this is more or less close to what<br>
Go applications would expect. So, the Since version is not that<br>
impactful as it was for libvirt-go-module. Ah, based on what<br>
Marc-Andr=C3=A9 wrote, I think this is the same for qapi-rs.<br>
<br>
Cheers,<br>
Victor<br></blockquote><div><br></div><div>As bonus context: here&#39;s out=
put from a small utility I wrote called schema-diff that compares the compi=
led v1.0 and v1.1.0 schema:</div><div><br></div><div>```<br>jsnow@scv ~/s/q=
emu ((v3.1.0))&gt; ./schema-diff.py qapi-compiled-v1.0.json qapi-compiled-v=
1.1.0.json<br>Added commands<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>block-job-cancel<br>block-job-set-speed<br>block-stream<br>block_set_io_=
throttle<br>change-vnc-password<br>qom-get<br>qom-list<br>qom-list-types<br=
>qom-set<br>query-block-jobs<br>system_wakeup<br>transaction<br>xen-save-de=
vices-state<br><br>Removed commands<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br><br>Modified commands<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>add_client (x-qemu-arguments)<br>=C2=A0 =C2=A0 ++ arg=
uments.tls: Optional&lt;boolean&gt;<br>blockdev-snapshot-sync (x-qemu-argum=
ents)<br>=C2=A0 =C2=A0 -- arguments.snapshot-file: Optional&lt;string&gt;<b=
r>=C2=A0 =C2=A0 ++ arguments.mode: Optional&lt;enum&gt;<br>=C2=A0 =C2=A0 ++=
 arguments.snapshot-file: string<br>memsave (x-qemu-arguments)<br>=C2=A0 =
=C2=A0 ++ arguments.cpu-index: Optional&lt;integer&gt;<br>query-block (x-qe=
mu-returns)<br>=C2=A0 =C2=A0 ++ returns[].inserted.bps: integer<br>=C2=A0 =
=C2=A0 ++ returns[].inserted.bps_rd: integer<br>=C2=A0 =C2=A0 ++ returns[].=
inserted.bps_wr: integer<br>=C2=A0 =C2=A0 ++ returns[].inserted.iops: integ=
er<br>=C2=A0 =C2=A0 ++ returns[].inserted.iops_rd: integer<br>=C2=A0 =C2=A0=
 ++ returns[].inserted.iops_wr: integer<br>query-spice (x-qemu-returns)<br>=
=C2=A0 =C2=A0 ++ returns.mouse-mode: enum<br>query-status (x-qemu-returns)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0returns.status: enum<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ++ suspended<br>```</div><div><br></div><div>It&#39;s possibly rough=
 around the edges (branches, ifcond and features are not yet supported; alt=
ernates are kinda-supported but do not yet diff well/prettily, ignore the &=
quot;x-qemu-&quot; stuff), and the diff output uses an arbitrary/invented &=
quot;key path&quot; and &quot;field type&quot; notation in order to simplif=
y the changelog summary, but you can hopefully see the utility of such a re=
port.</div><div><br></div><div>Helpfully, it shows *all levels* of changes,=
 no matter how deeply nested, so *all* potential changes to the API can be =
observed / audited / documented. The only types it ever reports are fundame=
ntal JSON types and &quot;any&quot; and &quot;enum&quot;, so any refactorin=
g we do in the QAPI schema with regards to type names, inheritance, boxing,=
 etc are fully transparent in this analysis.<br></div><div><br></div><div>I=
t&#39;s a useful tool for reviewing QAPI changes during the RC period to en=
sure we did not accidentally create any breaking changes since the last rel=
eased version.</div><div><br></div><div>One more example for the road:</div=
><div><br></div><div>```<br>jsnow@scv ~/s/qemu ((v3.1.0))&gt; ./schema-diff=
.py qapi-compiled-v1.1.0.json qapi-compiled-v1.2.0.json<br>Added commands<b=
r>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>add-fd<br>device-list-prope=
rties<br>dump-guest-memory<br>migrate-set-cache-size<br>migrate-set-capabil=
ities<br>query-cpu-definitions<br>query-events<br>query-fdsets<br>query-mac=
hines<br>query-migrate-cache-size<br>query-migrate-capabilities<br>query-ta=
rget<br>remove-fd<br><br>Removed commands<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br><br>Modified commands<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>query-block (x-qemu-returns)<br>=C2=A0 =C2=A0 +=
+ returns[].inserted.backing_file_depth: integer<br>=C2=A0 =C2=A0 ++ return=
s[].inserted.encryption_key_missing: boolean<br>query-migrate (x-qemu-retur=
ns)<br>=C2=A0 =C2=A0 ++ returns.disk.duplicate: integer<br>=C2=A0 =C2=A0 ++=
 returns.disk.normal: integer<br>=C2=A0 =C2=A0 ++ returns.disk.normal-bytes=
: integer<br>=C2=A0 =C2=A0 ++ returns.ram.duplicate: integer<br>=C2=A0 =C2=
=A0 ++ returns.ram.normal: integer<br>=C2=A0 =C2=A0 ++ returns.ram.normal-b=
ytes: integer<br>=C2=A0 =C2=A0 ++ returns.total-time: Optional&lt;integer&g=
t;<br>=C2=A0 =C2=A0 ++ returns.xbzrle-cache: Optional&lt;object&gt;<br>=C2=
=A0 =C2=A0 ++ returns.xbzrle-cache.bytes: integer<br>=C2=A0 =C2=A0 ++ retur=
ns.xbzrle-cache.cache-miss: integer<br>=C2=A0 =C2=A0 ++ returns.xbzrle-cach=
e.cache-size: integer<br>=C2=A0 =C2=A0 ++ returns.xbzrle-cache.overflow: in=
teger<br>=C2=A0 =C2=A0 ++ returns.xbzrle-cache.pages: integer<br>```</div><=
div><br></div><div>Here, you can see that although the &quot;disk&quot; and=
 &quot;ram&quot; fields for query-migrate&#39;s return type are very likely=
 the same actual type, the compiler has evaluated everything down to its co=
nstituent parts and reported each difference independently for the report; =
preserving the possibility to obtain wire-protocol accurate added/modified =
data for each and every individual key.</div><div><br></div><div>I&#39;ll a=
lso point out that this diff view does not confuse &quot;first version qapi=
fied&quot; with &quot;first version introduced&quot;; v1.2.0 actually qapif=
ied several commands for the first time, but they remained available in ear=
lier versions. The diff output accurately reflects this.</div><div><br></di=
v><div></div><div>--js<br></div></div></div>

--00000000000049a237061a3bedec--


