Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F038BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq28k-0005bJ-D9; Wed, 05 Mar 2025 22:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq28i-0005b1-8x
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 22:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq28e-0004WX-P8
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 22:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741232588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUJnuDA/oiSsgEYw1Q+y7xvuM378DifWDXmS0En8APE=;
 b=WqAj6bu4/bNZE+hvQC0s5dK5wUMpwHnKob0RdmtD7a6SvqY691KalwVGoJNptF/3g9KapA
 U92zhT+blDbovY/RhaxL0A4eblXuNNWQQngDITEM6hHpm1fBunpZdQ/AFhbya6dN8QNttY
 +vP7jlZ7Ta9hM72TQE1UK+742ZYNDRI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-_WCq2ehuPka3S-YJ_LHW-w-1; Wed, 05 Mar 2025 22:42:52 -0500
X-MC-Unique: _WCq2ehuPka3S-YJ_LHW-w-1
X-Mimecast-MFC-AGG-ID: _WCq2ehuPka3S-YJ_LHW-w_1741232571
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f5cso584311a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 19:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741232571; x=1741837371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUJnuDA/oiSsgEYw1Q+y7xvuM378DifWDXmS0En8APE=;
 b=WdV3wlCR97T7D/ZSnUHxXtdV+Ppp3KUNasseoK9MUcPErzg5BKE7s5MxppVMhDBGSd
 6GAZnYAHprmEqVD4+IxQn1SdWncsWE2qfQYRkVMkldZptfSYhnCZ9uu/hBR/G5nkGElm
 VNDrz+x9a+rwZY9KDl46CywExSoQhOxX6sRHFI2Z+iFDGysHtgBu/dpUaa5GFMj3QeQz
 8qdENhguDHUdeLUVPYKS45Y9xelak3+HdS2vXNRtRyxcamGNkBS2cqMwcRYg2HCwSUU8
 KbkcnTKeMNY7YRYunq64Cd/R3IbAdWNYyBUDaeCMQbzv3uhBI+X98+MlsW0ajBvF00I5
 bt1Q==
X-Gm-Message-State: AOJu0YwenEpFFOAG3XnfgN2XfKEEP92nl2+6I8r4gZNiD3KHx+VhM1d3
 g6m8xHfLHL9HsKLevUouYRRtHFDUQCJzbFrX5CKdnPBnDw58emWbpgOZ5Ybj4wSXsSP7g3baBPb
 MRxUUam127m0vzXYBXxGm668KYGdSF5zpoj7a2F/fC5nSEy/HWT5JG7yMt6GIztvABvXnPAp9bO
 rA7zpY8/GhZDF2cDE6S39XBErQbMc=
X-Gm-Gg: ASbGncvoVs84u7FjNRdfkkpNHocI4qjnctcU4J2FGSL2yCpfKpn4fAjYvRCRY+C/xxI
 Fnr++fd4sggJxGLOkZ5vyddKt1XHls2pInkn4D2V4nZ/iQ/PaBx2haSgLCKnonzHqvDitfXReks
 9ZmtbPhI9FryiJg8qTntSl4Rz8ombG
X-Received: by 2002:a17:90b:2e42:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2ff49717407mr8582107a91.1.1741232571006; 
 Wed, 05 Mar 2025 19:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7VMod3J9E98Yv6vrWY5ZqUQbAn1MqbTE+h7+OqwA5ZtZv+ISO0p8Jkdj9+xVZNKr1OfOxflHiSRwmxOtR3JU=
X-Received: by 2002:a17:90b:2e42:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2ff49717407mr8582082a91.1.1741232570597; Wed, 05 Mar 2025
 19:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-31-jsnow@redhat.com>
 <87bjufokj7.fsf@pond.sub.org>
In-Reply-To: <87bjufokj7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 22:42:37 -0500
X-Gm-Features: AQ5f1JrcA2YRrbZ0NhyNI85RcDFj3boL1_tP5wxVnassWhDsRYN4KBsqCqq4XEM
Message-ID: <CAFn=p-YwnFRZwZVL+NmYNs5MZePf9Rwc_To=BCTejuHMiBazzg@mail.gmail.com>
Subject: Re: [PATCH 30/57] qapi/parser: adjust info location for doc body
 section
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d7a2ba062fa44ccb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000d7a2ba062fa44ccb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:10=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Instead of using the info object for the doc block as a whole (which
> > always points to the very first line of the block), update the info
> > pointer for each call to ensure_untagged_section when the existing
> > section is otherwise empty. This way, Sphinx error information will
> > match precisely to where the text actually starts.
> >
> > For example, this patch will move the info pointer for the "Hello!"
> > untagged section ...
> >
> >> ##       <-- from here ...
> >> # Hello! <-- ... to here.
> >> ##
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> This patch would be easier to accept with a test case where it improves
> the error location.  I tried to construct one quickly, but failed.  Can
> you help?
>
> Possible substitute: point to a patch later in this series where things
> become worse without this patch.


Maybe we can use the "if build_docs" section of the qapi schema testing to
run things through Sphinx and harvest the error messages for negative
cases...? I gotta sit down and figure out how.

In the meantime, if I unapply my series, then edit block-core to look like
this:

##
# @SnapshotInfo:
#
# rST syntax error: *ahh!
#

(Lines 13-17, error is on line 16)

Building, I get this error:

/home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
emphasis start-string without end-string. [docutils]
/home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.json=
:14:
WARNING: Inline emphasis start-string without end-string. [docutils]

Mmm, nope. Not quite.

If I re-push my series and try again with the same edit ...

/home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
emphasis start-string without end-string. [docutils]
/home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.json=
:14:
WARNING: Inline emphasis start-string without end-string. [docutils]
/home/jsnow/src/qemu/docs/../qapi/block-core.json:16: WARNING: Inline
emphasis start-string without end-string. [docutils]

The two inclusions from the old qapidoc are still wrong, but the inclusion
through the new transmogrifier is correct.

(I'm going to be honest with you, I don't know why the error location
didn't change at all for the old qapidoc. I think one of the many error
location bugs I fixed when writing the new transmogrifier that just never
got applied to the old system...)

If I undo this fix but keep the rest of my series, I get these errors:

/home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline
emphasis start-string without end-string. [docutils]
/home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-core.json=
:14:
WARNING: Inline emphasis start-string without end-string. [docutils]
/home/jsnow/src/qemu/docs/../qapi/block-core.json:13: WARNING: Inline
emphasis start-string without end-string. [docutils]

Two are from the old qapidoc, one is from the new one. They're all wrong.

--js

--000000000000d7a2ba062fa44ccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, =
2025 at 5:10=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Instead of using the info object for the doc block as a whole (which<b=
r>
&gt; always points to the very first line of the block), update the info<br=
>
&gt; pointer for each call to ensure_untagged_section when the existing<br>
&gt; section is otherwise empty. This way, Sphinx error information will<br=
>
&gt; match precisely to where the text actually starts.<br>
&gt;<br>
&gt; For example, this patch will move the info pointer for the &quot;Hello=
!&quot;<br>
&gt; untagged section ...<br>
&gt;<br>
&gt;&gt; ##=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;-- from here ...<br>
&gt;&gt; # Hello! &lt;-- ... to here.<br>
&gt;&gt; ##<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
This patch would be easier to accept with a test case where it improves<br>
the error location.=C2=A0 I tried to construct one quickly, but failed.=C2=
=A0 Can<br>
you help?<br>
<br>
Possible substitute: point to a patch later in this series where things<br>
become worse without this patch.</blockquote><div><br></div><div>Maybe we c=
an use the &quot;if build_docs&quot; section of the qapi schema testing to =
run things through Sphinx and harvest the error messages for negative cases=
...? I gotta sit down and figure out how.</div><div><br></div><div>In the m=
eantime, if I unapply my series, then edit block-core to look like this:</d=
iv><div><br></div><div>##<br># @SnapshotInfo:<br>#<br># rST syntax error: *=
ahh!<br>#</div><div><br></div><div>(Lines 13-17, error is on line 16)</div>=
</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div class=
=3D"gmail_quote gmail_quote_container">Building, I get this error:</div><di=
v class=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail=
_quote gmail_quote_container">/home/jsnow/src/qemu/docs/../qapi/block-core.=
json:14: WARNING: Inline emphasis start-string without end-string. [docutil=
s]<br>/home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/block-cor=
e.json:14: WARNING: Inline emphasis start-string without end-string. [docut=
ils]</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div c=
lass=3D"gmail_quote gmail_quote_container">Mmm, nope. Not quite.</div><div =
class=3D"gmail_quote gmail_quote_container"><div><br></div><div>If I re-pus=
h my series and try again with the same edit ...</div><div><br></div><div>/=
home/jsnow/src/qemu/docs/../qapi/block-core.json:14: WARNING: Inline emphas=
is start-string without end-string. [docutils]<br>/home/jsnow/src/qemu/docs=
/../storage-daemon/qapi/../../qapi/block-core.json:14: WARNING: Inline emph=
asis start-string without end-string. [docutils]<br>/home/jsnow/src/qemu/do=
cs/../qapi/block-core.json:16: WARNING: Inline emphasis start-string withou=
t end-string. [docutils]<br></div><div><br></div><div>The two inclusions fr=
om the old qapidoc are still wrong, but the inclusion through the new trans=
mogrifier is correct.</div></div><div class=3D"gmail_quote gmail_quote_cont=
ainer"><br></div><div class=3D"gmail_quote gmail_quote_container">(I&#39;m =
going to be honest with you, I don&#39;t know why the error location didn&#=
39;t change at all for the old qapidoc. I think one of the many error locat=
ion bugs I fixed when writing the new transmogrifier that just never got ap=
plied to the old system...)</div><div class=3D"gmail_quote gmail_quote_cont=
ainer"><br><div>If I undo this fix but keep the rest of my series, I get th=
ese errors:</div><div><br></div><div>/home/jsnow/src/qemu/docs/../qapi/bloc=
k-core.json:14: WARNING: Inline emphasis start-string without end-string. [=
docutils]<br>/home/jsnow/src/qemu/docs/../storage-daemon/qapi/../../qapi/bl=
ock-core.json:14: WARNING: Inline emphasis start-string without end-string.=
 [docutils]<br>/home/jsnow/src/qemu/docs/../qapi/block-core.json:13: WARNIN=
G: Inline emphasis start-string without end-string. [docutils]<br></div><di=
v><br></div><div>Two are from the old qapidoc, one is from the new one. The=
y&#39;re all wrong.</div><div><br></div><div>--js</div></div></div>

--000000000000d7a2ba062fa44ccb--


