Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E59C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzJuU-0005Kk-Vo; Mon, 31 Mar 2025 14:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzJuT-0005KF-C3
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzJuP-000883-EV
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743445852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C3u1cHXKkExuMwyU70l0R5xgWufruLBnWMbqq+LErEg=;
 b=io+L6xrFcmrFq/RsnNFWLzpYLEZznggVyo2INbChvs8Jgt06WvDEmqDfsXNjZt6K+eBax1
 L6mFLaiKigyY2rxTjLKK9li/VBiBoxB8O9Pc2yNDUOft7J5NEtTPVqMPYVLF2hv1jsjOkl
 G2bLA2vpqHqdFPkcb8w+sHVqNezcvgM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-JkzdpHV1MfCxAaIyO44jFQ-1; Mon, 31 Mar 2025 14:30:50 -0400
X-MC-Unique: JkzdpHV1MfCxAaIyO44jFQ-1
X-Mimecast-MFC-AGG-ID: JkzdpHV1MfCxAaIyO44jFQ_1743445849
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff62f96b10so8864261a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743445849; x=1744050649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C3u1cHXKkExuMwyU70l0R5xgWufruLBnWMbqq+LErEg=;
 b=Y3xciG8uAM/M621s55gE9rwI98kO5vzNlXdKS3BEGw9iO48mHQ3gmpEs//zE0FI/Zy
 bGe/w7In9+msQaTPzlkCBIluw6574eXEFtlkWefWnK6kVu3g/WKB7qQyJkb4akoBqthg
 kJeQ52uA67rUlcIPX4faDyC5uVT1QuvKEAKVUk/yL3d4QViUtvdZRRfzzhDAsEBc+3Eb
 HEXC9FhDjihTg36jdnFuKyRsx6m4GgSo44sf714v/Re1uNQauP9dp5VVjZbh4wcpUc+d
 yMRUFvHOL/855fknE53ydQ4/oJcIs7aO9ISZ1GhacA+DTcXxgfhqt1exbenQkBDos37V
 uBQg==
X-Gm-Message-State: AOJu0YwMJJZ5s6nLNtrLWC4ts/gPD6diAnBhc+nD1SrjH1W2e7SSkCSC
 hVE/vHnEbmYeUYIRunIaEKQWkUEGbdt3imckXlN7sYEGMylzsKnuwMiEilhpehAeuKz+MaZ70S5
 tbZhIQ11k2XfQJEjCzGJgk14xC35hBwEIpKapv57bNwRxyktjBjXwLBTpH9AZ4tnIzWwF9OIk86
 QvRtmfnfDFhm+PY9ttWmFId41DxUE=
X-Gm-Gg: ASbGncs6KORBxQuUZRtkEBCTbTtQmn4PHJ1N8zyI+DG5sqaN4CkGM+rbTKnqF8Aw6AO
 e/PA5f1v/EPA5/D0tyENUgy1lZcKMOi/rsJNLnGHnx3RsLCiFmGvvPkMon+xwsISI3RIJWsU3Ww
 eoyBffF+DOvHGui+SM7eXCTDYgoT/w
X-Received: by 2002:a17:90b:2784:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-305318abda7mr15283030a91.10.1743445849239; 
 Mon, 31 Mar 2025 11:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNx9o+cgD0gS+hTsEYMsQk0h/kK/oP8Oho9m1gB/Hav5oNH+od8C6imJZoNjVuzdShkvPMO0kxYJLmYC4bYAg=
X-Received: by 2002:a17:90b:2784:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-305318abda7mr15282979a91.10.1743445848905; Mon, 31 Mar 2025
 11:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250326195756.330817-1-jsnow@redhat.com>
 <20250326195756.330817-3-jsnow@redhat.com>
 <87zfh6yh1o.fsf@pond.sub.org>
In-Reply-To: <87zfh6yh1o.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Mar 2025 14:30:36 -0400
X-Gm-Features: AQ5f1JqNYvEcpHfbBO42TwkNdq2Pj4tVfJiquN1VDNp-IwR_Nd0-yZJ9r4fRNgs
Message-ID: <CAFn=p-bwhzosvS8v7q1sKhYaa39LkPKAoYkog14jEg_S_s0jHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs, qapi: generate undocumented return sections
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
Content-Type: multipart/alternative; boundary="0000000000008271000631a79e9f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000008271000631a79e9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 5:11=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch changes the qapidoc transmogrifier to generate Return value
> > documentation for any command that has a return value but hasn't
> > explicitly documented that return value.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Might want to briefly explain placement of the auto-generated return
> value documentation.  But before we discuss that any further, let's
> review the actual changes the the generated docs.
>
> This patch adds auto-generated return value documentation where we have
> none.
>
> The next patch replaces handwritten by auto-generated return value
> documentation where these are at least as good.  Moves the return value
> docs in some cases.
>
> First the additions:
>
> * x-debug-query-block-graph
>
>   Title, intro, features, return
>
> * query-tpm
>
>   Title, intro, return, example
>
> * query-dirty-rate
>
>   Title, intro, arguments, return, examples
>
> * query-vcpu-dirty-limit
>
>   Title, intro, return, example
>
> * query-vm-generation-id
>
>   Title, return
>
> * query-memory-size-summary
>
>   Title, intro, example, return
>
> * query-memory-devices
>
>   Title, intro, return, example
>
> * query-acpi-ospm-status
>
>   Title, intro, return, example
>
> * query-stats-schemas
>
>   Title, intro, arguments, note, return
>
> Undesirable:
>
> * query-memory-size-summary has returns after the example instead of
>   before.  I figure it needs the TODO hack to separate intro and example
>   (see announce-self).
>

Yes


>
> * query-stats-schemas has a note between arguments and return.  I think
>   this demonstrates that the placement algorithm is too simplistic.
>

Yeah ... It's just that *glances at length of email* it's been a sensitive
topic without a lot of certainty in desire, so I've tried to keep things on
the stupid/simple side ...


>
> Debatable:
>
> * x-debug-query-block-graph has returns after features.  I'd prefer
>   returns before features.  No need to debate this now.
>

Willing to do this for you if you'd like to enforce it globally. I'd be
happy with any mandated order of sections, really.


>
> Next the movements:
>
> * x-debug-block-dirty-bitmap-sha256
>
>   From right before errors to right after
>
> * blockdev-snapshot-delete-internal-sync
>
>   From right before errors to right after
>
> * query-xen-replication-status
>
>   From between intro and example to the end
>
> * query-colo-status
>
>   From between intro and example to the end
>
> * query-balloon
>
>   From right before errors to right after
>
> * query-hv-balloon-status-report
>
>   From right before errors to right after
>
> * query-yank
>
>   From between intro and example to the end
>
> * add-fd
>
>   From between arguments and errors to between last note and example
>
> I don't like any of these :)
>

So it goes ...


>
> Undesirable:
>
> * query-xen-replication-status, query-yank, and query-colo-status now
>   have return after the example instead of before.  I figure they now
>   need the TODO hack to separate intro and example.
>

Yes


>
> * add-fd now has a note between arguments and return.  Same placement
>   weakness as for query-stats above.
>
> Debatable:
>
> * x-debug-block-dirty-bitmap-sha256,
>   blockdev-snapshot-delete-internal-sync, query-colo-status, and
>   query-hv-balloon-status-report now have return after errors instead of
>   before.  I'd prefer before.
>
> What's the stupidest acceptable placement algorithm?  Maybe this one:
>
> 1. If we have arguments, return goes right after them.
>
> 2. Else if we have errors, return goes right before them.
>
> 3. Else if we have features, return goes right before them.
>
> 4. Else return goes right after the intro (to make this work, we need
>    a few more TODO hacks).
>
> Would you be willing to give this a try?
>

Probably ...

So this algorithm seems to imply a preference for this ordering:

1. Intro
2. Arguments
3. Return
4. Errors
5. Features
6. Details

Do I have that correct?

--0000000000008271000631a79e9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 27,=
 2025 at 5:11=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch changes the qapidoc transmogrifier to generate Return value=
<br>
&gt; documentation for any command that has a return value but hasn&#39;t<b=
r>
&gt; explicitly documented that return value.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Might want to briefly explain placement of the auto-generated return<br>
value documentation.=C2=A0 But before we discuss that any further, let&#39;=
s<br>
review the actual changes the the generated docs.<br>
<br>
This patch adds auto-generated return value documentation where we have<br>
none.<br>
<br>
The next patch replaces handwritten by auto-generated return value<br>
documentation where these are at least as good.=C2=A0 Moves the return valu=
e<br>
docs in some cases.<br>
<br>
First the additions:<br>
<br>
* x-debug-query-block-graph<br>
<br>
=C2=A0 Title, intro, features, return<br>
<br>
* query-tpm<br>
<br>
=C2=A0 Title, intro, return, example<br>
<br>
* query-dirty-rate<br>
<br>
=C2=A0 Title, intro, arguments, return, examples<br>
<br>
* query-vcpu-dirty-limit<br>
<br>
=C2=A0 Title, intro, return, example<br>
<br>
* query-vm-generation-id<br>
<br>
=C2=A0 Title, return<br>
<br>
* query-memory-size-summary<br>
<br>
=C2=A0 Title, intro, example, return<br>
<br>
* query-memory-devices<br>
<br>
=C2=A0 Title, intro, return, example<br>
<br>
* query-acpi-ospm-status<br>
<br>
=C2=A0 Title, intro, return, example<br>
<br>
* query-stats-schemas<br>
<br>
=C2=A0 Title, intro, arguments, note, return<br>
<br>
Undesirable:<br>
<br>
* query-memory-size-summary has returns after the example instead of<br>
=C2=A0 before.=C2=A0 I figure it needs the TODO hack to separate intro and =
example<br>
=C2=A0 (see announce-self).<br></blockquote><div><br></div><div>Yes</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
* query-stats-schemas has a note between arguments and return.=C2=A0 I thin=
k<br>
=C2=A0 this demonstrates that the placement algorithm is too simplistic.<br=
></blockquote><div><br></div><div>Yeah ... It&#39;s just that *glances at l=
ength of email* it&#39;s been a sensitive topic without a lot of certainty =
in desire, so I&#39;ve tried to keep things on the stupid/simple side ...</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Debatable:<br>
<br>
* x-debug-query-block-graph has returns after features.=C2=A0 I&#39;d prefe=
r<br>
=C2=A0 returns before features.=C2=A0 No need to debate this now.<br></bloc=
kquote><div><br></div><div>Willing to do this for you if you&#39;d like to =
enforce it globally. I&#39;d be happy with any mandated order of sections, =
really.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
Next the movements:<br>
<br>
* x-debug-block-dirty-bitmap-sha256<br>
<br>
=C2=A0 From right before errors to right after<br>
<br>
* blockdev-snapshot-delete-internal-sync<br>
<br>
=C2=A0 From right before errors to right after<br>
<br>
* query-xen-replication-status<br>
<br>
=C2=A0 From between intro and example to the end<br>
<br>
* query-colo-status<br>
<br>
=C2=A0 From between intro and example to the end<br>
<br>
* query-balloon<br>
<br>
=C2=A0 From right before errors to right after<br>
<br>
* query-hv-balloon-status-report<br>
<br>
=C2=A0 From right before errors to right after<br>
<br>
* query-yank<br>
<br>
=C2=A0 From between intro and example to the end<br>
<br>
* add-fd<br>
<br>
=C2=A0 From between arguments and errors to between last note and example<b=
r>
<br>
I don&#39;t like any of these :)<br></blockquote><div><br></div><div>So it =
goes ...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Undesirable:<br>
<br>
* query-xen-replication-status, query-yank, and query-colo-status now<br>
=C2=A0 have return after the example instead of before.=C2=A0 I figure they=
 now<br>
=C2=A0 need the TODO hack to separate intro and example.<br></blockquote><d=
iv><br></div><div>Yes</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
* add-fd now has a note between arguments and return.=C2=A0 Same placement<=
br>
=C2=A0 weakness as for query-stats above.<br>
<br>
Debatable:<br>
<br>
* x-debug-block-dirty-bitmap-sha256,<br>
=C2=A0 blockdev-snapshot-delete-internal-sync, query-colo-status, and<br>
=C2=A0 query-hv-balloon-status-report now have return after errors instead =
of<br>
=C2=A0 before.=C2=A0 I&#39;d prefer before.<br>
<br>
What&#39;s the stupidest acceptable placement algorithm?=C2=A0 Maybe this o=
ne:<br>
<br>
1. If we have arguments, return goes right after them.<br>
<br>
2. Else if we have errors, return goes right before them.<br>
<br>
3. Else if we have features, return goes right before them.<br>
<br>
4. Else return goes right after the intro (to make this work, we need<br>
=C2=A0 =C2=A0a few more TODO hacks).<br>
<br>
Would you be willing to give this a try?<br></blockquote><div><br></div><di=
v>Probably ...</div><div><br></div><div>So this algorithm seems to imply a =
preference for this ordering:</div><div><br></div><div>1. Intro</div><div>2=
. Arguments</div><div>3. Return</div><div>4. Errors</div><div>5. Features</=
div><div>6. Details</div><br><div>Do I have that correct?</div></div></div>

--0000000000008271000631a79e9f--


