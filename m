Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207FEC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzJyR-0007V1-K5; Mon, 31 Mar 2025 14:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzJyM-0007TU-Mc
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzJyK-0008PA-4R
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743446094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZ8QpW04OdjqRF2XGvsLyKwffiHBSQmFVYDVj2o031w=;
 b=h5VgvNM+H/STif2XLxGIKvGA5Z3aAVdnIdMkRsNMq9B4jqnAcy9Bvx62c4L4LNhj45IWB0
 jmd0gGt9pXTdwwyKDCF6RUkoW2B8OHkP57OsRQRo70xj0pgvHW+XE4j4GmvWvV6QmD9TdF
 xs+CRwcWYzh6+xXyX2ZaeS9jg6UIDx8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-G2-8cCgYPC--GKIRICJmMw-1; Mon, 31 Mar 2025 14:34:53 -0400
X-MC-Unique: G2-8cCgYPC--GKIRICJmMw-1
X-Mimecast-MFC-AGG-ID: G2-8cCgYPC--GKIRICJmMw_1743446092
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3011bee1751so7870934a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446091; x=1744050891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZ8QpW04OdjqRF2XGvsLyKwffiHBSQmFVYDVj2o031w=;
 b=Cc5UOb3G4uwX8NVcon39+dd4I/NoGYm8EksXoUmnR3IHn2oA8RD4lMZslPfeCS9MRo
 /8lNcK7GMEO3uiDybA+cT7VzXi8JbRb4KE9KL22sP7DWW+SlY6WZG1JbBVUroO8nls/P
 5YLLR4GDxu0yAE1f0PBk1Gk5dUUz+GLobWFntUn7b6crfk3DlbgqvN4kXUpHdl2MTqzL
 QzDhc8cyR/HP3yqld/5cwPIhUMBCBpE8JZzBmb2Y/tNdKJhjJmFrqG/jLlZpZOzXUaB0
 xtB9H+uVW5nil6OfaruR/OuA5C55k5Knjx/bZIutxizjSaZlp1HwBd9pjKFMgPhmZBnB
 T2GA==
X-Gm-Message-State: AOJu0Yz3xCEdQup04WWYEaeYd8DoDA8LhBvLNF8UjGlQGGRQa440zjN8
 echPKhXALNmPj2m5AcxbGWTVA+wKmV0lPoLT/uqfmhpJzOTeIiBYPB5v5TSM1qSP1MZY9t/HfE4
 cFjU+DYyRA+cGa5qRq7JhyF5w0+X8EQNoD6uHK0PJcdiExduDigoHzEyChhEpQ/by46XDS0/fyV
 xx8aQz/9zpZOAohvMiosSU7qLRUvpF8wBL+Pg=
X-Gm-Gg: ASbGncuhQXp4Q1/WmUh/xVCDE/ziZTHc6RugMJ0Hx1/DYO6cXETLvvzoY7VCLhfTmnw
 HqLbsPp4SLoc+VtUIQSYaKcd4TGy2k4/0vAx4cIrdxahLMv2rnSQjJX8aljCvOwvM96BUH6Mbi/
 REwP3fFKNNlx9oT9RHDl61syytrDeA
X-Received: by 2002:a17:90a:e185:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-305320b180bmr14262784a91.20.1743446091101; 
 Mon, 31 Mar 2025 11:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZPxtbg3bNiPpc4DcF6saWBxBbvSaiJysy7I6VBk2Hu3dugKZ4SwxCizDFewRacbN+Iy9GPCltUhO4APchLQg=
X-Received: by 2002:a17:90a:e185:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-305320b180bmr14262734a91.20.1743446090827; Mon, 31 Mar 2025
 11:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250326195756.330817-1-jsnow@redhat.com>
 <20250326195756.330817-5-jsnow@redhat.com>
 <87jz89mu0m.fsf@pond.sub.org>
In-Reply-To: <87jz89mu0m.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Mar 2025 14:34:38 -0400
X-Gm-Features: AQ5f1JqE_tXIti4PWWhPlSmAg5_JWHyR7ZHkTMAgN_cw7Am4RnFexzmALZsQyJM
Message-ID: <CAFn=p-aUUHE+d1s2KjV6WF1FNwHAjrJEEG3LqB8F+5d3d4p5Gg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] qapi: rephrase return docs to avoid type name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Hanna Reitz <hreitz@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org, 
 Lukas Straub <lukasstraub2@web.de>, Jiri Pirko <jiri@resnulli.us>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Zhenwei Pi <pizhenwei@bytedance.com>, 
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000ede35e0631a7ac1b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000ede35e0631a7ac1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 4:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Well, I tried. Maybe not very hard. Sorry!
>
> No need to be sorry!  Kick-starting discussion with limited effort is
> better than a big effort going into a direction that turns out to be
> unwanted once we discuss it.
>
> Instead of just rephrasing Returns descriptions, I'd like us to consider
> both Returns and intro.  See below for why.
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json     | 6 +++---
> >  qapi/block-export.json   | 2 +-
> >  qapi/block.json          | 2 +-
> >  qapi/control.json        | 5 ++---
> >  qapi/dump.json           | 5 ++---
> >  qapi/introspect.json     | 6 +++---
> >  qapi/job.json            | 2 +-
> >  qapi/machine-target.json | 7 +++----
> >  qapi/misc-target.json    | 2 +-
> >  qapi/misc.json           | 5 ++---
> >  qapi/net.json            | 2 +-
> >  qapi/pci.json            | 2 +-
> >  qapi/qdev.json           | 3 +--
> >  qapi/qom.json            | 8 +++-----
> >  qapi/stats.json          | 2 +-
> >  qapi/trace.json          | 2 +-
> >  qapi/ui.json             | 2 +-
> >  qapi/virtio.json         | 6 +++---
> >  18 files changed, 31 insertions(+), 38 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 92b2e368b72..eb97b70cd80 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -763,7 +763,7 @@
>    ##
>    # @query-block:
> >  #
> >  # Get a list of BlockInfo for all virtual block devices.
> >  #
> > -# Returns: a list of @BlockInfo describing each virtual block device.
> > +# Returns: a list describing each virtual block device.
> >  #     Filter nodes that were created implicitly are skipped over.
> >  #
> >  # Since: 0.14
> > @@ -1168,7 +1168,7 @@
>    ##
>    # @query-blockstats:
>    #
>    # Query the @BlockStats for all virtual block devices.
>    #
>    # @query-nodes: If true, the command will query all the block nodes
>    #     that have a node name, in a list which will include "parent"
>    #     information, but not "backing".  If false or omitted, the
>    #     behavior is as before - query all the device backends,
>    #     recursively including their "parent" and "backing".  Filter
> >  #     nodes that were created implicitly are skipped over in this
> >  #     mode.  (Since 2.3)
> >  #
> > -# Returns: A list of @BlockStats for each virtual block devices.
> > +# Returns: A list of statistics for each virtual block device.
> >  #
> >  # Since: 0.14
> >  #
> > @@ -1440,7 +1440,7 @@
>    ##
>    # @query-block-jobs:
> >  #
> >  # Return information about long-running block device operations.
> >  #
> > -# Returns: a list of @BlockJobInfo for each active block job
> > +# Returns: a list of job info for each active block job
> >  #
> >  # Since: 1.1
> >  ##
>
> Stopping here, because I believe this is already enough to make a useful
> observation.
>
> There's overlap between query-FOO's intro and Returns.  The intro
> describes the command's purpose, and the purpose of a query-FOO is to
> return certain information.  Returns describes the value returned.  Both
> talk about the same thing, namely the value returned.
>
> Why two prose descriptions of the value returned?  Wouldn't one be
> better?
>
> Let's try.  We need to choose where to put it, intro or Returns.
>
> When Returns comes right after intro, putting it into Returns can work
> fine, because the command's purpose still comes first.  For instance:
>
>    ##
>    # @query-block:
>    #
>    # Return information about all virtual block devices.  Filter nodes
>    # that were created implicitly are skipped over.
>
> renders like
>
>     Command query-block (Since: 0.14)
>
>        Return information about all virtual block devices. Filter nodes
>        that were created implicitly are skipped over.
>
>        Return:
>           ["BlockInfo"]
>
> and
>
>    ##
>    # @query-block:
>    #
>    # Returns: Information about all virtual block devices.
>    #     Filter nodes that were created implicitly are skipped over.
>
> renders like
>
>     Command query-block (Since: 0.14)
>
>        Return:
>           ["BlockInfo"] -- Information about all virtual block
>           devices. Filter nodes that were created implicitly are skipped
>           over.
>
> Both work.
>
> But when there's something in between, intro is preferable.  For
> instance:
>
>    ##
>    # @query-blockstats:
>    #
>    # Return statistics for all virtual block devices.
>    #
>    # @query-nodes: If true, the command will query all the block nodes
>    #     that have a node name, in a list which will include "parent"
>    #     information, but not "backing".  If false or omitted, the
>    #     behavior is as before - query all the device backends,
>    #     recursively including their "parent" and "backing".  Filter
>    #     nodes that were created implicitly are skipped over in this
>    #     mode.  (Since 2.3)
>
> renders like
>
>     Command query-blockstats (Since: 0.14)
>
>        Return statistics for all virtual block devices.
>
>        Arguments:
>           * **query-nodes** ("boolean", *optional*) -- If true, the
>             command will query all the block nodes that have a node name,
>             in a list which will include "parent" information, but not
>             "backing".  If false or omitted, the behavior is as before -
>             query all the device backends, recursively including their
>             "parent" and "backing".  Filter nodes that were created
>             implicitly are skipped over in this mode.  (Since 2.3)
>
>        Return:
>           ["BlockStats"]
>
> while
>
>    ##
>    # @query-blockstats:
>    #
>    # @query-nodes: If true, the command will query all the block nodes
>    #     that have a node name, in a list which will include "parent"
>    #     information, but not "backing".  If false or omitted, the
>    #     behavior is as before - query all the device backends,
>    #     recursively including their "parent" and "backing".  Filter
>    #     nodes that were created implicitly are skipped over in this
>    #     mode.  (Since 2.3)
>    #
>    # Returns: Statistics for all virtual block devices
>
> renders like
>
>     Command query-blockstats (Since: 0.14)
>
>        Arguments:
>           * **query-nodes** ("boolean", *optional*) -- If true, the
>             command will query all the block nodes that have a node name,
>             in a list which will include "parent" information, but not
>             "backing".  If false or omitted, the behavior is as before -
>             query all the device backends, recursively including their
>             "parent" and "backing".  Filter nodes that were created
>             implicitly are skipped over in this mode.  (Since 2.3)
>
>        Return:
>           ["BlockStats"] -- Statistics for all virtual block devices
>
> I much prefer the former, because it puts the command's purpose where it
> belongs: first.
>
> Perhaps we should simply use the intro always.
>

I think for cases where the doc block is short and we have a desire to
merge "returns" and "intro", the intro makes the most sense if there isn't
anything of particular value assigned to the return value to begin with.

So, more or less, yeah: if semantics are partially duplicated between
intro/returns, I'm in favor of putting it all in the intro and allowing
transmogrifier generate the return type info.

I don't think there's a good case to make for a doc block with no intro but
a healthy paragraph in the returns section, that looks goofy.

Of course: I think there are still circumstances where we'll want both the
intro and the returns info explicitly labeled, when we have some
information to document about the semantics of that return value.


>
> Thoughts?
>
>

--000000000000ede35e0631a7ac1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 28,=
 2025 at 4:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Well, I tried. Maybe not very hard. Sorry!<br>
<br>
No need to be sorry!=C2=A0 Kick-starting discussion with limited effort is<=
br>
better than a big effort going into a direction that turns out to be<br>
unwanted once we discuss it.<br>
<br>
Instead of just rephrasing Returns descriptions, I&#39;d like us to conside=
r<br>
both Returns and intro.=C2=A0 See below for why.<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
&gt;=C2=A0 qapi/block-export.json=C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 qapi/block.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/control.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 ++---<br>
&gt;=C2=A0 qapi/dump.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 ++---=
<br>
&gt;=C2=A0 qapi/introspect.json=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
&gt;=C2=A0 qapi/job.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br=
>
&gt;=C2=A0 qapi/machine-target.json | 7 +++----<br>
&gt;=C2=A0 qapi/misc-target.json=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/misc.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 ++---=
<br>
&gt;=C2=A0 qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br=
>
&gt;=C2=A0 qapi/pci.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br=
>
&gt;=C2=A0 qapi/qdev.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +--<b=
r>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 +++--=
---<br>
&gt;=C2=A0 qapi/stats.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/trace.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/ui.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 =
+-<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
&gt;=C2=A0 18 files changed, 31 insertions(+), 38 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index 92b2e368b72..eb97b70cd80 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -763,7 +763,7 @@<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-block:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Get a list of BlockInfo for all virtual block devices.<br>
&gt;=C2=A0 #<br>
&gt; -# Returns: a list of @BlockInfo describing each virtual block device.=
<br>
&gt; +# Returns: a list describing each virtual block device.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Filter nodes that were created implicitly a=
re skipped over.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt; @@ -1168,7 +1168,7 @@<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-blockstats:<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Query the @BlockStats for all virtual block devices.<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# @query-nodes: If true, the command will query all the block =
nodes<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0that have a node name, in a list which wi=
ll include &quot;parent&quot;<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0information, but not &quot;backing&quot;.=
=C2=A0 If false or omitted, the<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0behavior is as before - query all the dev=
ice backends,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0recursively including their &quot;parent&=
quot; and &quot;backing&quot;.=C2=A0 Filter<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0nodes that were created implicitly are skip=
ped over in this<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0mode.=C2=A0 (Since 2.3)<br>
&gt;=C2=A0 #<br>
&gt; -# Returns: A list of @BlockStats for each virtual block devices.<br>
&gt; +# Returns: A list of statistics for each virtual block device.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; @@ -1440,7 +1440,7 @@<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-block-jobs:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Return information about long-running block device operations.=
<br>
&gt;=C2=A0 #<br>
&gt; -# Returns: a list of @BlockJobInfo for each active block job<br>
&gt; +# Returns: a list of job info for each active block job<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.1<br>
&gt;=C2=A0 ##<br>
<br>
Stopping here, because I believe this is already enough to make a useful<br=
>
observation.<br>
<br>
There&#39;s overlap between query-FOO&#39;s intro and Returns.=C2=A0 The in=
tro<br>
describes the command&#39;s purpose, and the purpose of a query-FOO is to<b=
r>
return certain information.=C2=A0 Returns describes the value returned.=C2=
=A0 Both<br>
talk about the same thing, namely the value returned.<br>
<br>
Why two prose descriptions of the value returned?=C2=A0 Wouldn&#39;t one be=
<br>
better?<br>
<br>
Let&#39;s try.=C2=A0 We need to choose where to put it, intro or Returns.<b=
r>
<br>
When Returns comes right after intro, putting it into Returns can work<br>
fine, because the command&#39;s purpose still comes first.=C2=A0 For instan=
ce:<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-block:<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Return information about all virtual block devices.=C2=A0 Fi=
lter nodes<br>
=C2=A0 =C2=A0# that were created implicitly are skipped over.<br>
<br>
renders like<br>
<br>
=C2=A0 =C2=A0 Command query-block (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return information about all virtual block devic=
es. Filter nodes<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0that were created implicitly are skipped over.<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;BlockInfo&quot;]<br>
<br>
and<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-block:<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Returns: Information about all virtual block devices.<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0Filter nodes that were created implicitly=
 are skipped over.<br>
<br>
renders like<br>
<br>
=C2=A0 =C2=A0 Command query-block (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;BlockInfo&quot;] -- Information a=
bout all virtual block<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devices. Filter nodes that were created =
implicitly are skipped<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over.<br>
<br>
Both work.<br>
<br>
But when there&#39;s something in between, intro is preferable.=C2=A0 For<b=
r>
instance:<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-blockstats:<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Return statistics for all virtual block devices.<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# @query-nodes: If true, the command will query all the block =
nodes<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0that have a node name, in a list which wi=
ll include &quot;parent&quot;<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0information, but not &quot;backing&quot;.=
=C2=A0 If false or omitted, the<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0behavior is as before - query all the dev=
ice backends,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0recursively including their &quot;parent&=
quot; and &quot;backing&quot;.=C2=A0 Filter<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0nodes that were created implicitly are sk=
ipped over in this<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0mode.=C2=A0 (Since 2.3)<br>
<br>
renders like<br>
<br>
=C2=A0 =C2=A0 Command query-blockstats (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return statistics for all virtual block devices.=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * **query-nodes** (&quot;boolean&quot;, =
*optional*) -- If true, the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command will query all the block =
nodes that have a node name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in a list which will include &quo=
t;parent&quot; information, but not<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backing&quot;.=C2=A0 If fal=
se or omitted, the behavior is as before -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query all the device backends, re=
cursively including their<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;parent&quot; and &quot;back=
ing&quot;.=C2=A0 Filter nodes that were created<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 implicitly are skipped over in th=
is mode.=C2=A0 (Since 2.3)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;BlockStats&quot;]<br>
<br>
while<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @query-blockstats:<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# @query-nodes: If true, the command will query all the block =
nodes<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0that have a node name, in a list which wi=
ll include &quot;parent&quot;<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0information, but not &quot;backing&quot;.=
=C2=A0 If false or omitted, the<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0behavior is as before - query all the dev=
ice backends,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0recursively including their &quot;parent&=
quot; and &quot;backing&quot;.=C2=A0 Filter<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0nodes that were created implicitly are sk=
ipped over in this<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0mode.=C2=A0 (Since 2.3)<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# Returns: Statistics for all virtual block devices<br>
<br>
renders like<br>
<br>
=C2=A0 =C2=A0 Command query-blockstats (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * **query-nodes** (&quot;boolean&quot;, =
*optional*) -- If true, the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command will query all the block =
nodes that have a node name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in a list which will include &quo=
t;parent&quot; information, but not<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backing&quot;.=C2=A0 If fal=
se or omitted, the behavior is as before -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query all the device backends, re=
cursively including their<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;parent&quot; and &quot;back=
ing&quot;.=C2=A0 Filter nodes that were created<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 implicitly are skipped over in th=
is mode.=C2=A0 (Since 2.3)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;BlockStats&quot;] -- Statistics f=
or all virtual block devices<br>
<br>
I much prefer the former, because it puts the command&#39;s purpose where i=
t<br>
belongs: first.<br>
<br>
Perhaps we should simply use the intro always.<br></blockquote><div><br></d=
iv><div>I think for cases where the doc block is short and we have a desire=
 to merge &quot;returns&quot; and &quot;intro&quot;, the intro makes the mo=
st sense if there isn&#39;t anything of particular value assigned to the re=
turn value to begin with.</div><div><br></div><div>So, more or less, yeah: =
if semantics are partially duplicated between intro/returns, I&#39;m in fav=
or of putting it all in the intro and allowing transmogrifier generate the =
return type info.</div><div><br></div><div>I don&#39;t think there&#39;s a =
good case to make for a doc block with no intro but a healthy paragraph in =
the returns section, that looks goofy.</div><div><br></div><div>Of course: =
I think there are still circumstances where we&#39;ll want both the intro a=
nd the returns info explicitly labeled, when we have some information to do=
cument about the semantics of that return value.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thoughts?<br>
<br>
</blockquote></div></div>

--000000000000ede35e0631a7ac1b--


