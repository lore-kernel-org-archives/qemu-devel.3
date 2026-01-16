Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FADD4A60E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfPB-0000Sf-QS; Fri, 16 Jan 2026 03:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgfPA-0000ML-8A
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:42:04 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgfP8-0005Iy-AB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:42:03 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so298649566b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768552920; x=1769157720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/i01022pn4b0W1Z6FMgVQtu2p36TiA9XoXPxQazvEU=;
 b=JHu/fKpfyWwuYyvCsGnJ1UvKDpNChHRQ8WssiAC5XZ0pAY1XArMlSWsjZzwx4iBZ48
 nGS1u8r4sVdBhW/niCUV5M1mXJWy0Li14WYrsDANtaZ5gyxgIc9H8+QBuect3xuOAkiV
 Fc/ybkAs60P9CxPThbnDhQUHF26E7g3FeGUUx4EdRg4cZx2RFrZtIK6FxDyMO1+gzgbO
 dmzj3lKUkdLdMskuX0/GbTon/2Pm3dIkJiv08e2hK9uuTK3YTvH0PXz74jZDcKqDpHyE
 FGtNmp+AbM2pPSCxwndp0O7HpqQQEjOfJQFhz8TLJZjg3c6wzXBFHIqWWB68wL+Gb5ef
 c25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768552920; x=1769157720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/i01022pn4b0W1Z6FMgVQtu2p36TiA9XoXPxQazvEU=;
 b=ZCZ5dSpY8ZoWd0HWoKrOu3bH2dWs81NlbuxgD/VwraqRGVEXwJziwjRgiZy6QYehVL
 kIuTsMAI92cYfp97ihAqo1+Jjf/oA5519US0qvpU+uxdOZfwyDK0rY4CXbHf84x6Wekb
 DNmAaYl69kywllBnQioCnqEjDqZ2vO/2Wpid5RyWq+PQ29/4xdnCjcG6OlHL3vGxGG29
 f8z/Ohvw766fWkfnRuMsNhyRRmvINpWqQMBKzy8WGaeVRIE1i18lvEsOdghOzLriWyeZ
 Mzy2Q+/w/F9Ri8C/+EIMAhk2jN0Iwe9FHGEH0Ony6R1ZlQivbtXYtQCBvfbwzXaoh2YE
 JuQA==
X-Gm-Message-State: AOJu0YxYdeEJ23y7KQYd+yzmdrvshqcb/Gas3R1mzDFkG/6M0eUv6LxU
 mEqJGCy9d0xvaWefW2Cl9pem2PDqllti2rPeEhZk/JPTwycnmx8LGCzlDaQLFsouey56GJ0qyUd
 H9cNVFyAaQTek+rcYWEoq6UQH/NBVVdTDTU5ftLI=
X-Gm-Gg: AY/fxX7tL0a2bXp59sZRh9S615GpiGxic5WhBTNnv8fQnKar7y7h7pPIV6hZAFEVlpY
 BeXA3NfsiopR+rXbkaNgkJPNbnQurG/aZaZhq68WECbeZ/mwAqmZK1Btfwvr3QvjEsoALey7XO0
 a1gOH2Hgz1cbd0dwOicPR+A3QgJ6neLGu7PZ/8Oy1gYUFH8B34HQXZIcqWk4a7Ikkvi7OC8iEiH
 gqmkqkTPdh6a0g3G+6VvNylzoq6aehu+kruL3h5BJXH75sCsrcKk8zQMvkEH/9DMztKQKdpM/T6
 yRzLU/Y=
X-Received: by 2002:a17:907:948d:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b879389056fmr232052666b.14.1768552919442; Fri, 16 Jan 2026
 00:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <20251229103859.98777-3-zhangckid@gmail.com>
 <877bts8fsa.fsf@pond.sub.org>
 <CAK3tnvJuoin17F9FDnYJA+vXeUeGpMv3R=2vrOBFUotjRCymfQ@mail.gmail.com>
 <87wm1irmvw.fsf@pond.sub.org>
In-Reply-To: <87wm1irmvw.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 16:41:21 +0800
X-Gm-Features: AZwV_QhbkDpuqV2bJKG1sNZbf1t43Qm9NAv0nGmZRduZgICusq5CcIBjmjen--s
Message-ID: <CAK3tnvK=hyrVhwyEHfAOaDNStG=C9irPK39ua=g=Upep6f8g6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] qapi: Add thread_status flag for iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 16, 2026 at 4:18=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Thu, Jan 8, 2026 at 8:12=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > The thread_status depends on struct IOThreadInfo's
> >> > 'attached': 'bool'. Show in the qmp/hmp CMD with
> >> > 'attached' or 'detached'.
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > ---
> >> >  iothread.c         | 1 +
> >> >  monitor/hmp-cmds.c | 2 ++
> >> >  qapi/misc.json     | 6 ++++++
> >> >  3 files changed, 9 insertions(+)
> >> >
> >> > diff --git a/iothread.c b/iothread.c
> >> > index 38e38fb44d..fb4898e491 100644
> >> > --- a/iothread.c
> >> > +++ b/iothread.c
> >> > @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, vo=
id *opaque)
> >> >      info =3D g_new0(IOThreadInfo, 1);
> >> >      info->id =3D iothread_get_id(iothread);
> >> >      info->thread_id =3D iothread->thread_id;
> >> > +    info->attached =3D iothread->attached;
> >> >      info->poll_max_ns =3D iothread->poll_max_ns;
> >> >      info->poll_grow =3D iothread->poll_grow;
> >> >      info->poll_shrink =3D iothread->poll_shrink;
> >> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> >> > index 33a88ce205..84b01737cf 100644
> >> > --- a/monitor/hmp-cmds.c
> >> > +++ b/monitor/hmp-cmds.c
> >> > @@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDic=
t *qdict)
> >> >          value =3D info->value;
> >> >          monitor_printf(mon, "%s:\n", value->id);
> >> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->t=
hread_id);
> >> > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> >> > +                       value->attached ? "attached" : "detached");
> >> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value-=
>poll_max_ns);
> >> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->p=
oll_grow);
> >> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value-=
>poll_shrink);
> >> > diff --git a/qapi/misc.json b/qapi/misc.json
> >> > index 6153ed3d04..2eea920bd2 100644
> >> > --- a/qapi/misc.json
> >> > +++ b/qapi/misc.json
> >> > @@ -76,6 +76,9 @@
> >> >  #
> >> >  # @thread-id: ID of the underlying host thread
> >> >  #
> >> > +# @attached: flag to show current iothread attached status
> >>
> >> What does "attached status" actually mean?
> >
> > This flag means weather the "-object iothread" already been used by a
> > real device.
> > In hotplug scenario, user can add multiple "-object iothread" and
> > multiple devices (like virtio-blk).
> > When user hotunplug the devices can keep the iothreads as a thread
> > pool, following the new
> > hotplug devices can attach to the released iothread.
>
> Why would a management application or human user want to know this?

Because some usercases already been changed.
This demand comes from Cloud Native ecosystem.
User want to manage resources more flexible like containers (Kata container=
).
The real workload maybe changed(runc) in the VM without VM reboot,
It may need hotplug/unplug different multi disks with multi iothreads to me=
et
high level scheduler's needs(like K8s).


>
> The answer should lead us to better doc text.
>

OK, I will add it in next version.

> >>
> >> > +#            (since 10.3.0)
> >>
> >> (since 12.0)
> >
> > OK.
> >
> >>
> >> > +#
> >> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >> >  #     disabled (since 2.9)
> >> >  #
> >> > @@ -93,6 +96,7 @@
> >> >  { 'struct': 'IOThreadInfo',
> >> >    'data': {'id': 'str',
> >> >             'thread-id': 'int',
> >> > +           'attached': 'bool',
> >> >             'poll-max-ns': 'int',
> >> >             'poll-grow': 'int',
> >> >             'poll-shrink': 'int',
> >> > @@ -118,6 +122,7 @@
> >> >  #              {
> >> >  #                 "id":"iothread0",
> >> >  #                 "thread-id":3134,
> >> > +#                 'thread_status':"attached",
> >>
> >> I believe this is actually
> >>
> >>                      "attached": true
> >>
> >> and ...
> >
> > No, I changed it here for readability:
> >
> >> > +        monitor_printf(mon, "  thread_status=3D%s" "\n",
> >> > +                       value->attached ? "attached" : "detached");
> >
> > But if you think ""attached": true" is more direct way, I can change
> > it next version.
>
> The example in the doc comment shows QMP.  Here's what I see in QMP:
>
>     $ qemu-system-x86_64 -S -display none -qmp stdio -object iothread,id=
=3Diot0 -name debug-threads=3Don
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, =
"package": "v10.2.0-521-g05115811fa"}, "capabilities": ["oob"]}}
>     {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>     {"return": {}}
>     {"execute": "query-iothreads"}
>     {"return": [{"attached": false, "poll-shrink": 0, "thread-id": 403149=
4, "aio-max-batch": 0, "poll-grow": 0, "poll-max-ns": 32768, "id": "iot0"}]=
}
>
> This shows "attached": false, not 'thread_status': "attached".
>
> The code you showed applies to HMP:
>
>     $ qemu-system-x86_64 -S -display none -monitor stdio -object iothread=
,id=3Diot0 -name debug-threads=3Don
>     QEMU 10.2.50 monitor - type 'help' for more information
>     (qemu) info iothreads
>     iot0:
>       thread_id=3D4032011
>       thread_status=3Ddetached
>       poll-max-ns=3D32768
>       poll-grow=3D0
>       poll-shrink=3D0
>       aio-max-batch=3D0
>
> thread_status=3Ddetached might be slightly more readable than
> attached=3Dfalse, but it could also be confusing to people working with
> both HMP and QMP.  I'd avoid the difference between the two.

Make sense, I will change it to ""attached": false" style next version.

Thanks
Chen

>
> >>
> >> >  #                 'poll-max-ns':0,
> >> >  #                 "poll-grow":0,
> >> >  #                 "poll-shrink":0,
> >> > @@ -126,6 +131,7 @@
> >> >  #              {
> >> >  #                 "id":"iothread1",
> >> >  #                 "thread-id":3135,
> >> > +#                 'thread_status':"detached",
> >>
> >>                      "attached": false
> >>
> >> Recommend to create example output by running a test instead of making
> >> it up, because making it up likely screws it up :)
> >
> > Uh.... This output print is the real test in my machine, maybe you
> > missed the previous description.
>
> I can't see how QMP could possibly show 'thread_status':"detached:.
>
> >
> > Thanks
> > Chen
> >
> >>
> >> >  #                 'poll-max-ns':0,
> >> >  #                 "poll-grow":0,
> >> >  #                 "poll-shrink":0,
> >>
>

