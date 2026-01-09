Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF5BD232D1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 03:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve2v4-0001PQ-FD; Thu, 08 Jan 2026 22:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ve2v1-000120-MK
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 22:12:07 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ve2uz-0003lW-TN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 22:12:07 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b8123c333so6187276a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 19:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767928324; x=1768533124; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83fCzw6A1q57lVn4iIynanc1Wd+SkGDLiJZF1qYIf8E=;
 b=BE59NGQuuaNuI+ysXfg0C9YfKnvjwBrReY+KQ2O1Mjyi8AreU8gYLPQICJh10GjkXk
 wFj1n2LqQVv5i+scBthrM/XsMYYtsdK/nfMMyJ2Clk+i3tgoCVeim4KmabCw+lkqfGlZ
 q/xr7KWcHzCjtQpjmSWhbMV6N5HFz99L9kHQMJp/TMrlEvFpypDxAeyww0u8EJ/fS+PM
 eivRB1Sj/BJQ+3BC+XckD/5SoKRt6x+ZLk5fFTm8hycv/S42CNt1geNFFMMktCdKr8az
 qmbvyb0mH3mIhqFmQ0y6cT4iKBd7zU/IU8BMk4Hr5ODDMRZhLb6B+NoF3VaFRNCg1K50
 Ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767928324; x=1768533124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83fCzw6A1q57lVn4iIynanc1Wd+SkGDLiJZF1qYIf8E=;
 b=wNxp2zH4+/i9xhn/TB9OAFk5fOPEDHUDmoHb7kEhqxbsSKqcWCJ02LMr1UU0NdpMdb
 ZARVwJln34amdpCvFDtHlVP9ewCgCGxS8CVD2JUJCoeTzlhFVPkgyOwHNTRfMKgrAPhR
 pm4Ja7J6fHoJryDsJSD5Ba5alAioI1Mb5bA0glCCZCtzWxKBf5i7mrO5V6jLct3QL+Fg
 lHFSR5AImaCgMOSQuLqYjlUpnAkGkgxmCCXSoyl8K+JXvmVavZyyaR1p+1DviS7DaqQu
 r7RpxEkdvuHc9Ovzd1ie+IT+b0RJXgrKI4Rp+8OKGD+bgmDk2mvtSBYlzAVmUvw7cJC9
 faeQ==
X-Gm-Message-State: AOJu0YwQXqIB6yJn+UOkZAmlgDwKqO33nrUES2iQGVTBN6g8yRjSJbU7
 FlAqPEaij6tji6VRQ/HPYZAF5koVvaCRogV9grn8IME+DOWKGN/4vFSJzYDdXgax6M376UfsW2k
 M3Nz29YtP7GQW1/ox6LelvDZvQtH30uQ=
X-Gm-Gg: AY/fxX7MmXrd2CUJFFkxi/Jedj4KqejDH1BJ4MsLgrNdCTblywzFGRi+RQ+N7LI3E5+
 XG2mID83aslofEsPWaaKUI2Vz1aqWdsspEeTPqp6/IHotRywRbYLB8itAs+cGEIk+g0y1zKLfW1
 HOrAgJhbetsys/hznu633ltGSXeoO+//Q0PbJ29iTeALmCBrHjYly8UaksTwkKXNn5j+QkyI6l7
 PEnnU4G05U26ug47/c2R5sWaWbyX8gzyvDHyrtFdRKhJTPHNkxZ5FE6YabpY0cuMEquwVq1ma+5
 qPt4Mw==
X-Google-Smtp-Source: AGHT+IF572c33GbB85X6QLIUbZ0AjxSjYjVCQyzZppLXSPwjRHpmwVYtHVRgX5FpfRFDC/XysZLYAVHNfGPkLbMGNko=
X-Received: by 2002:a17:907:3fa7:b0:b73:880a:fde8 with SMTP id
 a640c23a62f3a-b8444d4eb55mr914047466b.12.1767928324065; Thu, 08 Jan 2026
 19:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <20251229103859.98777-3-zhangckid@gmail.com>
 <877bts8fsa.fsf@pond.sub.org>
In-Reply-To: <877bts8fsa.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 9 Jan 2026 11:11:27 +0800
X-Gm-Features: AQt7F2oTJffNJ7C5x7Di4q3Eg5ujCP3sUa5kqwvJ64A9QJOJduQTemFtkWnVm7Y
Message-ID: <CAK3tnvJuoin17F9FDnYJA+vXeUeGpMv3R=2vrOBFUotjRCymfQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] qapi: Add thread_status flag for iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 8, 2026 at 8:12=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > The thread_status depends on struct IOThreadInfo's
> > 'attached': 'bool'. Show in the qmp/hmp CMD with
> > 'attached' or 'detached'.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  iothread.c         | 1 +
> >  monitor/hmp-cmds.c | 2 ++
> >  qapi/misc.json     | 6 ++++++
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/iothread.c b/iothread.c
> > index 38e38fb44d..fb4898e491 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, void =
*opaque)
> >      info =3D g_new0(IOThreadInfo, 1);
> >      info->id =3D iothread_get_id(iothread);
> >      info->thread_id =3D iothread->thread_id;
> > +    info->attached =3D iothread->attached;
> >      info->poll_max_ns =3D iothread->poll_max_ns;
> >      info->poll_grow =3D iothread->poll_grow;
> >      info->poll_shrink =3D iothread->poll_shrink;
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 33a88ce205..84b01737cf 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *=
qdict)
> >          value =3D info->value;
> >          monitor_printf(mon, "%s:\n", value->id);
> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thre=
ad_id);
> > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> > +                       value->attached ? "attached" : "detached");
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 6153ed3d04..2eea920bd2 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -76,6 +76,9 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @attached: flag to show current iothread attached status
>
> What does "attached status" actually mean?

This flag means weather the "-object iothread" already been used by a
real device.
In hotplug scenario, user can add multiple "-object iothread" and
multiple devices (like virtio-blk).
When user hotunplug the devices can keep the iothreads as a thread
pool, following the new
hotplug devices can attach to the released iothread.

>
> > +#            (since 10.3.0)
>
> (since 12.0)

OK.

>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -93,6 +96,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'attached': 'bool',
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -118,6 +122,7 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 'thread_status':"attached",
>
> I believe this is actually
>
>                      "attached": true
>
> and ...

No, I changed it here for readability:
> > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> > +                       value->attached ? "attached" : "detached");

But if you think ""attached": true" is more direct way, I can change
it next version.

>
> >  #                 'poll-max-ns':0,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -126,6 +131,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 'thread_status':"detached",
>
>                      "attached": false
>
> Recommend to create example output by running a test instead of making
> it up, because making it up likely screws it up :)

Uh.... This output print is the real test in my machine, maybe you
missed the previous description.

Thanks
Chen

>
> >  #                 'poll-max-ns':0,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>

