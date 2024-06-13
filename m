Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00310C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 06:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHdiN-0004LH-4A; Thu, 13 Jun 2024 02:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHdiL-0004KC-TA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHdiI-0005AK-RY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718259213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=P98GOJ4F1R9GbOTitSuY03rMVvIwbXQsLcigRv1jhsk=;
 b=MM1KwWBLIeFo/wDpAa7BJamfVutKMK1geZBGtWyITQUYlae6rP30tV9rInbHFtJ3yR9XtB
 aQcboNfE4DpHaF85E8UatxyCne1DJ94Y0OuS4LxvRqtTky9rvWYaY/BL+XEPwwTsHYWIUd
 P3qAIwyzARQRgv9geyLrwFJfCc9go1s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-ePuHVrYzOKG8158vMnEtXA-1; Thu, 13 Jun 2024 02:13:30 -0400
X-MC-Unique: ePuHVrYzOKG8158vMnEtXA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-649731dd35bso504027a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 23:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718259209; x=1718864009;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P98GOJ4F1R9GbOTitSuY03rMVvIwbXQsLcigRv1jhsk=;
 b=N9O1J5jMrXYehxdhqSzzdns20RDv4YodseegS9tQqRlAaHydsQOIB58gJBsbYzAQ//
 JEWJmV9BECKVQlnPMUyDMIoG4tTT/vroVws4Wt6AtaXTRLJuJyQwOpWw8SsR8bEpz5Fz
 NPDyxQb/OlOB8ep2YkIuCXy3LBg1NAhtq4xW8rCQrxPxeb05DYDcNH3bjng/0CF51o78
 hcMX9JsL8ezVJmCJM+2QO2ZoeGeo/0QWzVHIsAe2IxqM09CDKtSL8xk/mF8L3yeq2iAY
 Mdm0Gs2QutPhD0/7DiOga+7l9eZGVxTHWA8rYyM9/hnyOE/qSByxYTwRa9gHpYKjSa4j
 V29Q==
X-Gm-Message-State: AOJu0YxMu8zu2KC64C9FwZoprk2xh+XzXTUC64ERap43MYivoHe6BtMG
 M6dtCwEGyV07qlRzp+MPUvv7jaMHRtg1Mao+1t1BV4i0S0HmYEwE024XYuwFbq3BlNRmxMGAvHl
 eJGme7jqBK7WXzBio4rvfcENhOci6wRaq+Y0Kgsevsv20xj1kzpV1skBQvF2yhiR27n++TOce6P
 PLl6TrDd4iA1/7fSnNk79ziedaSu8=
X-Received: by 2002:a05:6a20:3953:b0:1b8:4107:ce4f with SMTP id
 adf61e73a8af0-1b8a9c73b76mr4858688637.49.1718259209120; 
 Wed, 12 Jun 2024 23:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4maRorEX+zES+bUgqgbTTohZYpC7O/SRYtbRXapvgB2s6VtaXxlE/sPyAR9qHlNXX8PZiGZOSgSlf31Lv9m8=
X-Received: by 2002:a05:6a20:3953:b0:1b8:4107:ce4f with SMTP id
 adf61e73a8af0-1b8a9c73b76mr4858677637.49.1718259208577; Wed, 12 Jun 2024
 23:13:28 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Jun 2024 02:13:15 -0400
Message-ID: <CAFn=p-ZmjLKRN1kKo1iM_tiijYbOEqt5=vRg7WoAXuQ6E8Rm+A@mail.gmail.com>
Subject: Historical QAPI schema parser, "compiled schema", and qapi-schema-diff
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c27e2a061abf652c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

--000000000000c27e2a061abf652c
Content-Type: text/plain; charset="UTF-8"

Hi, recently I've been working on overhauling our QMP documentation; see
https://jsnow.gitlab.io/qemu/qapi/index.html for a recent work-in-progress
page showcasing this.

As part of this project, Markus and I decided it'd be nice to be able to
auto-generate "Since" information. The short reason for 'why' is because
since info hard-coded into doc comments may not be accurate with regards to
the wire protocol availability for a given field when a QAPI definition is
shared or inherited by multiple sources. If we can generate it, it should
always be accurate.

So, I've prototyped three things:

(1) An out-of-tree fork of the QAPI generator that is capable of parsing
qemu-commands.hx, qmp-commands.hx, and all versions of our qapi-schema.json
files going all the way back to v0.12.0.

It accomplishes this with some fairly brutish hacks that I never expect to
need to check in to qemu.git.

(2) A schema "compiler", a QAPI generator module that takes a parsed Schema
and produces a single-file JSON Schema document that describes every
command and event as it exists on the wire without using type names or any
information not considered to be "API".

This part *would* need to be checked in to qemu.git (if we go in this
direction.)
The compiled historical schema would also get checked in, for the QAPI
parser to reference against to generate the since information.

(Or, some kind of meta-compiled document with just the since information.
Either way; the idea is that we'll catalog the output without needing to
commit the parser compatibility hacks.)

(3) A script that can diff two compiled schema, showing a change report
between two versions. (I sent an email earlier today/yesterday showing
example output of this script.) This one was more for "fun", but it helped
prove all the other parts were working correctly, and it might be useful in
the future when auditing changes during the RC phase. We may well decide to
commit this script upstream, or one like it.

All of those things are here: https://gitlab.com/jsnow/externalized-qapi

I'm sharing this in its out-of-tree form mostly for Markus's sake as we
debate the pros/cons of various choices I've made in this prototype, but
you're welcome to peep the early discussions if you'd like, too.

Notes:

1. If you want to try "compiling" schema yourself, clone the git repo and
install it with "pip install .". Navigate to your qemu.git root and check
out a release tag (such as v0.12.0 or v1.0 or v9.0.0) and then run
"qapi-compile".

(If your git tags are "weird", this might break. Sorry about that, it's a
prototype... the hacky code that uses "git describe" is in qapi/compat.py
if you run into troubles and wanna mess around with it.)

2. The "qapi compiler" makes use of schema addendum files for some old
versions to produce correct output. You can browse them on gitlab here:
https://gitlab.com/jsnow/externalized-qapi/-/tree/main/qapi/schemata?ref_type=heads

There are addendum files for v0.12.0 through v2.0.0. Other "errata" are
handled in code; no errata of any kind are needed in v2.8.0 or later.

3. If you don't wanna run the compiler yourself (or it broke because it's a
real hackjob), I compiled all of the historical QAPI schema myself and
checked them into the repo here:
https://gitlab.com/jsnow/externalized-qapi/-/tree/main/compiled?ref_type=heads

4. You can diff any two compiled schema with "qapi-schema-diff A.json
B.json". Put the earlier version first.

5.  qapi-compile and qapi-schema-diff don't yet support "if" and "features"
everywhere they should, but everything else should work correctly.

6. The commit history for this repo is actually pretty well factored; each
compatibility hack for the QAPI parser has its own commit, so it's easy to
suss out what work was required to make this work.

I'm about to head off on a long weekend, I'll be back Tuesday.

Have fun,
--js

--000000000000c27e2a061abf652c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, recently I&#39;ve been working on overhauling our=
 QMP documentation; see <a href=3D"https://jsnow.gitlab.io/qemu/qapi/index.=
html">https://jsnow.gitlab.io/qemu/qapi/index.html</a> for a recent work-in=
-progress page showcasing this.<br></div><div><br></div><div>As part of thi=
s project, Markus and I decided it&#39;d be nice to be able to auto-generat=
e &quot;Since&quot; information. The short reason for &#39;why&#39; is beca=
use since info hard-coded into doc comments may not be accurate with regard=
s to the wire protocol availability for a given field when a QAPI definitio=
n is shared or inherited by multiple sources. If we can generate it, it sho=
uld always be accurate.<br></div><div><br></div><div>So, I&#39;ve prototype=
d three things:</div><div><br></div><div>(1) An out-of-tree fork of the QAP=
I generator that is capable of parsing qemu-commands.hx, qmp-commands.hx, a=
nd all versions of our qapi-schema.json files going all the way back to v0.=
12.0.</div><div><br></div><div>It accomplishes this with some fairly brutis=
h hacks that I never expect to need to check in to qemu.git.<br></div><div>=
<br></div><div>(2) A schema &quot;compiler&quot;, a QAPI generator module t=
hat takes a parsed Schema and produces a single-file JSON Schema document t=
hat describes every command and event as it exists on the wire without usin=
g type names or any information not considered to be &quot;API&quot;.</div>=
<div><br></div><div>This part *would* need to be checked in to qemu.git (if=
 we go in this direction.)</div><div>The compiled historical schema would a=
lso get checked in, for the QAPI parser to reference against to generate th=
e since information.</div><div><br></div><div>(Or, some kind of meta-compil=
ed document with just the since information. Either way; the idea is that w=
e&#39;ll catalog the output without needing to commit the parser compatibil=
ity hacks.)<br></div><div><br></div><div>(3) A script that can diff two com=
piled schema, showing a change report between two versions. (I sent an emai=
l earlier today/yesterday showing example output of this script.) This one =
was more for &quot;fun&quot;, but it helped prove all the other parts were =
working correctly, and it might be useful in the future when auditing chang=
es during the RC phase. We may well decide to commit this script upstream, =
or one like it.<br></div><div><br></div><div>All of those things are here: =
<a href=3D"https://gitlab.com/jsnow/externalized-qapi">https://gitlab.com/j=
snow/externalized-qapi</a></div><div><br></div><div>I&#39;m sharing this in=
 its out-of-tree form mostly for Markus&#39;s sake as we debate the pros/co=
ns of various choices I&#39;ve made in this prototype, but you&#39;re welco=
me to peep the early discussions if you&#39;d like, too.</div><div><br></di=
v><div>Notes:</div><div><br></div><div>1. If you want to try &quot;compilin=
g&quot; schema yourself, clone the git repo and install it with &quot;pip i=
nstall .&quot;. Navigate to your qemu.git root and check out a release tag =
(such as v0.12.0 or v1.0 or v9.0.0) and then run &quot;qapi-compile&quot;.<=
/div><div><br></div><div>(If your git tags are &quot;weird&quot;, this migh=
t break. Sorry about that, it&#39;s a prototype... the hacky code that uses=
 &quot;git describe&quot; is in qapi/compat.py if you run into troubles and=
 wanna mess around with it.)<br></div><div><br></div><div>2. The &quot;qapi=
 compiler&quot; makes use of schema addendum files for some old versions to=
 produce correct output. You can browse them on gitlab here: <a href=3D"htt=
ps://gitlab.com/jsnow/externalized-qapi/-/tree/main/qapi/schemata?ref_type=
=3Dheads">https://gitlab.com/jsnow/externalized-qapi/-/tree/main/qapi/schem=
ata?ref_type=3Dheads</a></div><div><br></div><div>There are addendum files =
for v0.12.0 through v2.0.0. Other &quot;errata&quot; are handled in code; n=
o errata of any kind are needed in v2.8.0 or later.<br></div><div><br></div=
><div>3. If you don&#39;t wanna run the compiler yourself (or it broke beca=
use it&#39;s a real hackjob), I compiled all of the historical QAPI schema =
myself and checked them into the repo here: <a href=3D"https://gitlab.com/j=
snow/externalized-qapi/-/tree/main/compiled?ref_type=3Dheads">https://gitla=
b.com/jsnow/externalized-qapi/-/tree/main/compiled?ref_type=3Dheads</a></di=
v><div><br></div><div>4. You can diff any two compiled schema with &quot;qa=
pi-schema-diff A.json B.json&quot;. Put the earlier version first.</div><di=
v><br></div><div>5.=C2=A0 qapi-compile and qapi-schema-diff don&#39;t yet s=
upport &quot;if&quot; and &quot;features&quot; everywhere they should, but =
everything else should work correctly.</div><div><br></div><div>6. The comm=
it history for this repo is actually pretty well factored; each compatibili=
ty hack for the QAPI parser has its own commit, so it&#39;s easy to suss ou=
t what work was required to make this work.<br></div><div><br></div><div>I&=
#39;m about to head off on a long weekend, I&#39;ll be back Tuesday.</div><=
div><br></div><div>Have fun,</div><div>--js<br></div></div>

--000000000000c27e2a061abf652c--


