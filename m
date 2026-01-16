Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBCD4A60A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeZE-0006GK-JL; Fri, 16 Jan 2026 02:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgeZA-0006Fy-9b
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:48:20 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgeZ8-0001Dg-IE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:48:20 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b874c00a39fso298711466b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768549696; x=1769154496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afPyihMdTruL96J/E4ziM6bzr1Luco6IaZJxSaDFve4=;
 b=P4Xf/QvLOl8/QX1wiW0T5SJmdvMcZWc16fuqN/T1ugOfjsq38HLUSWQ/DahF0sHgae
 RySSJSd05l9xXVVuZ2rniYYEA5nlNWPTiYcozsS9C1zFiBm5PUEasNZ3RpOR+95DarVw
 hhtDWwXQyc5T/91OU09OVQkCBeoUCqwmou9KOgIUQW+VGltsbHKoJFmdoCowWKKxJ6y3
 cxGWsDWGmklAXcthCyj7rTFivZs+NNb6Agi+78dKNH9TN+ROalEQS2AYgaOQHrLu12b/
 BK5+KJ/DUoVuffJjbWSBDpSbgYjcVs10xca7AVw1/f9Nk8+ZQxUFkUHrrE3HybYHrVpW
 PmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768549696; x=1769154496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=afPyihMdTruL96J/E4ziM6bzr1Luco6IaZJxSaDFve4=;
 b=UwmWjk8xAgA+5dUD9tyoum9FtAwOmQckn/X0HHN6zx1RckBBcXIvNfV/5bNpYr/Gml
 z0Lfzh7SX5YNR65lQKmjdNHt6UuMqY5a4Z8+xdXo0IqPwGLFx8uZ4hFVhY2m+IZUkdAL
 4Uo6AbkZP1/3gUoo1sATvcbU+3y+LRX4syD1RmxOWxds1V/hsf7IlWMpTN2ftJGVwJIo
 R8F/HNHtmab1Z1Kd5OOnNbWZ16hOuiuQ2ZD7bn3mSFa7kj7o33vZFgwqvR7MguHkEz9B
 lhXb9zlLjooCgmQVp89UEpjLRFpvOVD7r+Rh8c5i43cjPRpWx37YDwQ3XrQ6qj4Yw4aK
 DXyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULsj2MPgCXD6vSEV3Q6+nN1p+dfz8ByxXZWa95h6ElK4xI4+sfSB2av7V2FcEjspHHcR9lDitxJF26@nongnu.org
X-Gm-Message-State: AOJu0YxavlUzWhpA5pRgSomvz8i+1pvI3kzC9lUtRmqBRIh4g12lBPW7
 k5EY6DM67QJNYoHJwpcgegNat216Bp34zI3NH66FzY93HhyliRqvCYcrBS7ouEgoNtnECR03adx
 R6CbvMI/A5RIU/kYp15WBS5bg2LD71hY=
X-Gm-Gg: AY/fxX41zwgCPNIqpp+1+dbig9SdXoCWOTLhOxtv+jYxk4Z+HpnHTeyF2HfO2KlFY5O
 tuVJ39HPgpU97MGhmJ1EpSaAWYSfgCQ8Nxc3vIkOYjca4tEOleLzzCz6cKuY3EQYPQ+lxOSBMj0
 z/SNF+a/gmQS7qjMfmKwtTr+YpX3RCRnf6iEAv6qPVoWh3cK7QMI2PSo55bFxw5TSyDZzIeGo/j
 Qp6Ne2sbxH9uvQpsB8rw5/HOfdzPPlY3slHO8dEPjI0MfiMHRz+sPhBORhtT87ZOgMUg0Xp
X-Received: by 2002:a17:907:9496:b0:b76:3472:52df with SMTP id
 a640c23a62f3a-b879388d7c0mr213323066b.10.1768549696108; Thu, 15 Jan 2026
 23:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local>
In-Reply-To: <aWl6ixQpHaMJhV_E@x1.local>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 15:47:38 +0800
X-Gm-Features: AZwV_QiS7VWGu9nSLRwmv62ZUqzbJSF2Fdynn4a-te-YGZ_OgjtAT_Xar7KipOs
Message-ID: <CAK3tnvLBuVj5b_A9EnORvazSf_YuM9grgk+7nfA0AGcGdDeDUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 Juan Quintela <quintela@trasno.org>, zhanghailiang@xfusion.com, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, Jan 16, 2026 at 7:39=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > > Nack.
> > > >
> > > > This code has users, as explained in my other email:
> > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/=
T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > >
> > > Please then rework that series and consider include the following (I
> > > believe I pointed out a long time ago somewhere..):
> > >
> >
> > > - Some form of justification of why multifd needs to be enabled for C=
OLO.
> > >   For example, in your cluster deployment, using multifd can improve =
XXX
> > >   by YYY.  Please describe the use case and improvements.
> >
> > That one is pretty easy; since COLO is regularly taking snapshots, the =
faster
> > the snapshoting the less overhead there is.
>
> Thanks for chiming in, Dave.  I can explain why I want to request for som=
e
> numbers.
>
> Firstly, numbers normally proves it's used in a real system.  It's at lea=
st
> being used and seriously tested.
>

Agree.

> Secondly, per my very limited understanding to COLO... the two VMs in mos=
t
> cases should be in-sync state already when both sides generate the same
> network packets.

In most cases, you are right. But all the FT/HA system design for the
rare cases.

>
> Another sync (where multifd can start to take effect) is only needed when
> there're packets misalignments, but IIUC it should be rare.  I don't know
> how rare it is, it would be good if Lukas could introduce some of those
> numbers in his deployment to help us understand COLO better if we'll need
> to keep it.

I haven't tested multifd part yet. But let me introduce the background.
COLO system including 2 ways for live migration, network compare triggered
and periodic execution(maybe 10s). It means COLO VM performance
depends on live migration VM stop time, maybe the multifd can help for
this, Lukas?


>
> IIUC, the critical path of COLO shouldn't be migration on its own?  It
> should be when heartbeat gets lost; that normally should happen when two
> VMs are in sync.  In this path, I don't see how multifd helps..  because
> there's no migration happening, only the src recording what has changed.
> Hence I think some number with description of the measurements may help u=
s
> understand how important multifd is to COLO.
>

Yes, after failover, the secondary VM running without migration.

> Supporting multifd will cause new COLO functions to inject into core
> migration code paths (even if not much..). I want to make sure such (new)
> complexity is justified. I also want to avoid introducing a feature only
> because "we have XXX, then let's support XXX in COLO too, maybe some day
> it'll be useful".
>
> After these days, I found removing code is sometimes harder than writting
> new..

Agree, as Lukas said, some customers not follow upstream code(or 2
versions ago) for COLO.
Because FT/HA users focus on system availibility, upgrade is a high
risk for them.
I think the main reason of COLO broken for QEMU release 10.0/10.1 is
lack of test case(Lukas WIP on this).

Thanks
Chen


>
> Thanks,
>
> >
> > Lukas: Given COLO has a bunch of different features (i.e. the block
> > replication, the clever network comparison etc) do you know which ones
> > are used in the setups you are aware of?
> >
> > I'd guess the tricky part of a test would be the network side; I'm
> > not too sure how you'd set that in a test.
>
> --
> Peter Xu
>

