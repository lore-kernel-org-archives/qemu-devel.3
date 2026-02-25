Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938BBEFD23D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC9o-0004wT-8R; Wed, 25 Feb 2026 05:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvC9j-0004w6-Na
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:30:12 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvC9g-0005gs-Tm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:30:11 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65f9763e8d1so609138a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 02:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772015406; cv=none;
 d=google.com; s=arc-20240605;
 b=fMkbb1YDzEUhmiPNs9+ol5yYbi/dJXytyTvhXBGKIyNVvujK8192ovGwj4fFbMxMcM
 upSYZ2yIlmMsUPtp1+ES4Flts5UYvoxRf2pX2pMusiGKpsj6MojMk/r7Y9skDTooq1x0
 9iUYWqEH1Q7Zz+PP5ml6AO1bAaKxQFSHJkkd0EUTtT9o6IgjDV/lgHpMj+ErnMnETUR5
 LgiwEorQnR5WumIYr/Y+vGrqAlY3HBKb9qOlnRs5WAgQZAzHzZoAZTDTXCBKVSEZiSvX
 IuS+R7BqK1F4tYtPUh4b04kSCd7SmnvzI31SDMQay2dyfcJ4uanISstxL1GjHqdnR4tY
 7/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HmUlcPqJ4uFcugL1VGJLkBtZ1beUWYRRPD+6ddWzR1I=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=aR6svPFgT/xhVHjM2RArGelXfFK5/th+884/HnPqW8OiJRTgrJv2VqkkQzbpdqlLVC
 yfQ2SzCtHYxRYocIGc43Quydkn7V4J+bxG9I9ZW2uUyQ2x6nu8pO1/atSiWjgpV+jtMj
 oASpTDizvXZXpY94L+jVRUCMTc2Ez+Ba9/Kjog7mEHXzbWM+esQVbKLYIV7YEGF/OgOB
 bi8QUCgLB0Zgrfcpnx8XUhmZCnqH0GAd8abDyXPT+wKNdKkVaSNJOIJMjMpkJGYYwrOG
 PiQRn3sCQBoEg42zJjhaBHozggh85omj28PbdRb1rTCwR22JdBHb2RQcrLS4SOn8AYoT
 3D8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772015406; x=1772620206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmUlcPqJ4uFcugL1VGJLkBtZ1beUWYRRPD+6ddWzR1I=;
 b=coKqhCbwXQCEOLlbEpnzO2VUdnw9Pg8o1fYYGoKWjD6E/Q63pV8AiAEPbo8Jn/a4S6
 GhmCei7Elimomb8zXbC/we9PnNS1Z/7fe/0JQoTsY2d+tKM1RxGJH4J9J6A+u56b/lWL
 rJJC/uQTFhQe6lVcWb9ya5iIYruMMGD/fwAGTymQwhllll7BjMaS2BRf0CEPW8yHvyzW
 a8y0vwByAioP1CRFeSztrFcW7Ldn8IHTpewtCOkIiSp4tOnl1y7A3TYD/3mM05wuINUu
 g72jNy1Qc83aB9vdloAltqpVvhZh1ltyWG4fJRDuS29/lMNuvTZkTAcXo0mG6cYdbB0r
 P1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772015406; x=1772620206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmUlcPqJ4uFcugL1VGJLkBtZ1beUWYRRPD+6ddWzR1I=;
 b=udAM0XAvhzy6yDrDLuGO5BkDdddDGYr3g9aKD67wagqzQNfzofLS00om0NZqFHhAUN
 FbjoMhl51+x6p75vPAMo2oIfqKgaOddeDp4+jzdJSQVKet/lsuBfsEhCLbkQ5jrAdK5E
 hU0QpFD+67F8n86+qY7BLTuXxyU1jwuZolcMmW1B3s92a1r9m+YUH8E2ZP827JMGf2Vo
 LwiBQrVumMDVZrycEOsht/m+GBoE3ZYR6e9q5CO3w+GGagxbNgMHxI7Cl0AVzDsi8qdh
 ZeXnQo0YKq1xq2yLWzrUOmU/LAb4wDl1q4dT/6lX1Zhliu92ivflMqWrjOGUehk99maX
 WXrg==
X-Gm-Message-State: AOJu0YzeRg4KZSO1nvt/mpKjzd/QRo/Q14eCV+mBuy7giIu50gqb+0rr
 t8nsAIPRRC5K88f4d6G8KICXF6X2PKZqgcXeCSni3uiJPF+ScCmKKRJVGKfOdqeqatfMU0EFGOi
 qgnm38ofOSOzeH86uhCYamS5srw0e8JU=
X-Gm-Gg: ATEYQzyWCD1xCFU1CDzfRQ5c7OWT/cgxK2sCH2VqSR6RAtoZMVVutuUzxZN0jrMpwK/
 bNyYdfgphM+NGu9s+shhymdP38llA7xjna+C6nNaaNrSnc4VUTWnz4b0I5lkEGK40p4N5MNd2cn
 y945hPMOb2a2mK6afbvq6cmwiU+ly8LjDCJ0Lm9F5a26GLIlODpONwCEEngXNnNhUoxrfH4xvC8
 pX1r8Ff53yzbUtWX5XUnL9qT4nDP5hvHkg0t0njZCrSTZ2+eTLh6o9bs+6sIGGGjAM1c6M3BjAB
 UY0gj0M=
X-Received: by 2002:a05:6402:2746:b0:659:428f:a6c0 with SMTP id
 4fb4d7f45d1cf-65ea4ef601fmr9088335a12.20.1772015406199; Wed, 25 Feb 2026
 02:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
 <87wm0bq047.fsf@pond.sub.org>
 <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
 <874in65y7r.fsf@pond.sub.org>
In-Reply-To: <874in65y7r.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 25 Feb 2026 18:29:29 +0800
X-Gm-Features: AaiRm52_hsq_gsRdZw9HbuyqFywfKSZQtAgh7YKWHFNFAwRUci7FigD6i7ciSBQ
Message-ID: <CAK3tnvJ=_rp-JjkrgMA6cf+WXc0oHFJeQ5CsQsLf-fEd1ikGgw@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Feb 24, 2026 at 4:42=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Tue, Feb 17, 2026 at 3:51=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Extend the 'IOThreadInfo' structure to include attachment metrics.
> >> > This allows users to monitor how many devices are associated with
> >> > a specific IOThread and identify them by their QOM paths.
> >> >
> >> > New fields added to IOThreadInfo:
> >> > - @attached-cnt: An integer representing the number of devices
> >> >   currently using this IOThread's AioContext.
> >> > - @attached-dev: A string containing a delimited list ("|") of
> >> >   QOM paths for the attached devices.
> >> >
> >> > These fields are also exposed via the Human Monitor Interface (HMP)
> >> > command 'info iothreads' to assist with manual debugging and
> >> > performance tuning.
> >> >
> >> > Example QMP output:
> >> > {
> >> >     "id": "iothread0",
> >> >     "thread-id": 3134,
> >> >     "attached-cnt": 2,
> >> >     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /mach=
ine/peripheral/blk0/virtio-backend",
> >> >     ...
> >> > }
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/misc.json b/qapi/misc.json
> >> > index 1f5062df2a..ca53638684 100644
> >> > --- a/qapi/misc.json
> >> > +++ b/qapi/misc.json
> >> > @@ -76,6 +76,19 @@
> >> >  #
> >> >  # @thread-id: ID of the underlying host thread
> >> >  #
> >> > +# @attached-cnt: The parameter is a counter indicating how many
> >> > +#     active devices are currently associated with this iothread
> >> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> >> > +#     pre-allocate multiple iothread objects to serve as a persiste=
nt
> >> > +#     thread pool.  When a device is hot-unplugged, the correspondi=
ng
> >> > +#     IOThread is released but remains available, allowing subseque=
nt
> >> > +#     hot-plugged devices to attach to and reuse the existing threa=
d.
> >> > +#     (since 11.0)
> >> > +#
> >> > +# @attached-dev: A list of QOM paths for the devices currently
> >> > +#     associated with this IOThread, delimited by " | ".
> >> > +#     Returns "none" if no devices are attached. (since 11.0)
>
> Does not compile:
>
>     In file included from ../qapi/qapi-schema.json:66:
>     ../qapi/misc.json:90:49: Use two spaces between sentences
>     If this not the end of a sentence, please report a bug.
>
> This error has been in master for almost three months.  Is your tree
> that far behind?
>

Oh, my mistake, this version has undergone some minor description
improvements after testing.
Will cleanup it for full test.

> >>
> >> QAPI schema design maxim: do not encode structured data as strings.
> >> @attached-devs should be an array of QOM paths instead.
> >
> > OK, will fix in next version.
>
> Thanks!
>
> >> Unless I misunderstand your docs, @attached-cnt is the number of QOM
> >> paths in @attached-dev, i.e. @attached-dev is redundant.  If this is t=
he
> >> case, drop it.  If it isn't, educate me :)
> >
> > As Stefan's comments, I try to address more specific needs:
> > https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01892.html
>
> As far as I can tell, Stefan asked for the QOM paths of attached
> devices.  @attached-dev provides it.  Good.  Why have @attached-cnt as
> well?
>

Users can obtain the quantity more conveniently, avoiding the need to
count the number of @attached-dev.
If you think the @attached-cnt is redundant, I will remove it in next versi=
on.


> >> We generally avoid abbreviations in the QAPI schema: @attached-count,
> >> @attached-devices.
> >>
> >> > +#
> >> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >> >  #     disabled (since 2.9)
> >> >  #
> >> > @@ -93,6 +106,8 @@
> >> >  { 'struct': 'IOThreadInfo',
> >> >    'data': {'id': 'str',
> >> >             'thread-id': 'int',
> >> > +           'attached-cnt': 'int',
> >> > +           'attached-dev': 'str',
> >> >             'poll-max-ns': 'int',
> >> >             'poll-grow': 'int',
> >> >             'poll-shrink': 'int',
> >> > @@ -118,6 +133,8 @@
> >> >  #              {
> >> >  #                 "id":"iothread0",
> >> >  #                 "thread-id":3134,
> >> > +#                 "attached-cnt":2,
> >> > +#                 "attached-dev":/machine/peripheral/blk1/virtio-ba=
ckend | /machine/peripheral/blk0/virtio-backend,
> >>
> >> Once again, the example is syntactically incorrect (the value lacks
> >> double quotes), and once again I recommend to create example I/O by
> >> actually running a test.  Getting tired of this, to be frank.
> >
> > Sorry for that again. Will fix in next version.
> > And I tested this series before send the mail like this:
> >
> > (qemu) info iothreads
> > iothread2:
> >   thread_id=3D434428
> >   attached-cnt=3D0
> >   attached-dev=3Dnone
> >   poll-max-ns=3D32768
> >   poll-grow=3D0
> >   poll-shrink=3D0
> >   aio-max-batch=3D0
> > iothread1:
> >   thread_id=3D434427
> >   attached-cnt=3D2
> >   attached-dev=3D/machine/peripheral/blk1/virtio-backend |
> > /machine/peripheral/blk0/virtio-backend
> >   poll-max-ns=3D32768
> >   poll-grow=3D0
> >   poll-shrink=3D0
> >   aio-max-batch=3D0
>
> You can manually test QMP like this:
>
>     $ qemu-system-x86_64 -S -display none -chardev socket,id=3Dqmp,path=
=3Dtest-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,chardev=3Dqmp -objec=
t iothread,id=3Diot0
>
> In another terminal:
>
>     $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP> " UNIX-C=
ONNECT:test-qmp
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, =
"package": "v10.2.0-1533-g627cf8d1ed-dirty"}, "capabilities": ["oob"]}}
>     QMP> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}=
}
>     {"return": {}}
>     QMP> {"execute": "query-iothreads"}
>     {"return": [{"poll-shrink": 0, "thread-id": 2140323, "aio-max-batch":=
 0, "attached-dev": "none", "poll-grow": 0, "attached-cnt": 0, "poll-max-ns=
": 32768, "id": "iot0"}]}
>     QMP> {"execute": "quit"}
>     {"timestamp": {"seconds": 1771922506, "microseconds": 801687}, "event=
": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>     {"return": {}}
>

Got it, will double check the QMP.
Thank you for the detailed description.


Thanks
Chen

>
> >> >  #                 "poll-max-ns":32768,
> >> >  #                 "poll-grow":0,
> >> >  #                 "poll-shrink":0,
> >> > @@ -126,6 +143,8 @@
> >> >  #              {
> >> >  #                 "id":"iothread1",
> >> >  #                 "thread-id":3135,
> >> > +#                 "attached-cnt":1,
> >> > +#                 "attached-dev":/machine/peripheral/blk3/virtio-ba=
ckend,
> >>
> >> Likewise.
> >
> > Thanks
> > Chen
> >
> >>
> >> >  #                 "poll-max-ns":32768,
> >> >  #                 "poll-grow":0,
> >> >  #                 "poll-shrink":0,
> >>
>

