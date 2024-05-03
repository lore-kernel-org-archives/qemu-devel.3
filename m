Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE69C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 06:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2mao-0004r3-7f; Fri, 03 May 2024 02:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2mai-0004qE-65
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:40:21 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2maf-0002Fg-BZ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:40:19 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5894c1d954so385411466b.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714718415; x=1715323215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sj+GA1zYtQp4fFTqGR5vZIGd2AeshcfO5BrmoknVWY=;
 b=hhZYPsAYos73nn59z/jDRjIWar9red7D3g++Rln/BeY/C4IhI7IfG2W5pc8ELeb1Zg
 B4zFyj2vEpkkQMEl/k05NF/Hx2FesJGEGlqHrIYBNWYBi5fsU2oScHGPJVJ/yIS00vL7
 LmSjZZLfFQ6zaJUekUT+Pg/rfQQ05Obgzzxs7cxShI5GyXHSnEZDJ6HbbsWzG/oBTybe
 qOWC41zE4YTrbFmmdX7hAfcXZbiN2Wtk2yqO904qLchpw66su2yhjNW0zZ9QlGAHlNNw
 SOgn4LDXIIbj3JZADlE/ubCs+x/vNkI5nTOXWav2R87ozD9i5Qvq1wcjR7CkBCzrgOVc
 BjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714718415; x=1715323215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sj+GA1zYtQp4fFTqGR5vZIGd2AeshcfO5BrmoknVWY=;
 b=fquVNlP5Z1q8mLCPYUDw2cQ2P6GxD/XnZgQnF1xO1sxOEsMZ8H8oyX6OBmkCNl9ERd
 nrhHgpoiQJs+6//N1OhGRcMlS91kXorXslUvc2GtXsi+rGydpVpVwpQmJXVBSra2QFci
 b2o2PfzEt01ARotMRnNpl1kEp4AAO+Qf6vff468Mne7pPXAzyFP2P5fNyDs+5tVlUry1
 aOjVfjZVz6c5o6PtIOWDJJ/8QWgYPYZajPAKYzfbAeivd5GCg6BlfehZf4hQNKCvBE6z
 edMXn0i+Av0WRNmEbL3MokswIhgviwyYxWc1ooxBjiahOtpu4k2Q+iUsiTplWQZq03Ki
 ns1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3Vh7EH7+Bo0zvYOt5DAO5GqM9aN7ejtVLaaDCcad4YQk07cE/ECBNSkZdWUFruX29BmZiS/6kKC0BTwYxcZiU80HeUQ=
X-Gm-Message-State: AOJu0YyVi3ik0K9awgmLkF+nZYvlQiZqjOZS2H5HKMrPf7EXOBw0DcFQ
 aacwVTKigihScja8NbsVWXdaosNJD3VPHn4cemSpXUpyZJNM5vGxa1bff6hk4ynjXo/oR9tcvKf
 uljC2pdDr+cwZx0QMIaep2ykOkHLhA/CXLu9H6g==
X-Google-Smtp-Source: AGHT+IEW/FzR1sO7iiktKo+si8Pdnx1op06cCH8kxdJOaJdgxHgsmd5bQt7971PlcewksAsRd/wi7ejSmRAjFqfMpJA=
X-Received: by 2002:a50:d601:0:b0:572:47be:831d with SMTP id
 x1-20020a50d601000000b0057247be831dmr1131595edi.20.1714718414906; Thu, 02 May
 2024 23:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com>
In-Reply-To: <ZjJm6rcqS5EhoKgK@redhat.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 3 May 2024 08:40:03 +0200
Message-ID: <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62b;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Wed, May 1, 2024 at 6:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
> > What I worry more is whether this is really what we want to keep rdma i=
n
> > qemu, and that's also why I was trying to request for some serious
> > performance measurements comparing rdma v.s. nics.  And here when I sai=
d
> > "we" I mean both QEMU community and any company that will support keepi=
ng
> > rdma around.
> >
> > The problem is if NICs now are fast enough to perform at least equally
> > against rdma, and if it has a lower cost of overall maintenance, does i=
t
> > mean that rdma migration will only be used by whoever wants to keep the=
m in
> > the products and existed already?  In that case we should simply ask ne=
w
> > users to stick with tcp, and rdma users should only drop but not increa=
se.
> >
> > It seems also destined that most new migration features will not suppor=
t
> > rdma: see how much we drop old features in migration now (which rdma
> > _might_ still leverage, but maybe not), and how much we add mostly mult=
ifd
> > relevant which will probably not apply to rdma at all.  So in general w=
hat
> > I am worrying is a both-loss condition, if the company might be easier =
to
> > either stick with an old qemu (depending on whether other new features =
are
> > requested to be used besides RDMA alone), or do periodic rebase with RD=
MA
> > downstream only.
>
> I don't know much about the originals of RDMA support in QEMU and why
> this particular design was taken. It is indeed a huge maint burden to
> have a completely different code flow for RDMA with 4000+ lines of
> custom protocol signalling which is barely understandable.
>
> I would note that /usr/include/rdma/rsocket.h provides a higher level
> API that is a 1-1 match of the normal kernel 'sockets' API. If we had
> leveraged that, then QIOChannelSocket class and the QAPI SocketAddress
> type could almost[1] trivially have supported RDMA. There would have
> been almost no RDMA code required in the migration subsystem, and all
> the modern features like compression, multifd, post-copy, etc would
> "just work".
I guess at the time rsocket is less mature, and less performant
compared to using uverbs directly.



>
> I guess the 'rsocket.h' shim may well limit some of the possible
> performance gains, but it might still have been a better tradeoff
> to have not quite so good peak performance, but with massively
> less maint burden.
I had a brief check in the rsocket changelog, there seems some
improvement over time,
 might be worth revisiting this. due to socket abstraction, we can't
use some feature like
 ODP, it won't be a small and easy task.
> With regards,
> Daniel
Thanks for the suggestion.
>
> [1] "almost" trivially, because the poll() integration for rsockets
>     requires a bit more magic sauce since rsockets FDs are not
>     really FDs from the kernel's POV. Still, QIOCHannel likely can
>     abstract that probme.
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

