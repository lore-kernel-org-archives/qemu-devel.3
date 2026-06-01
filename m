Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC14CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3XS-0004fb-5V; Mon, 01 Jun 2026 10:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU3XP-0004fK-I5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU3XN-0003Gy-RQ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780323760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nc1FGWRi33B4lX3wfu2SMmxgYqYKjd8FEy58P5ng868=;
 b=ECxKMXQHjvbeIOGDdQcwU+EDkM2nZTOVgLCwbAUZj1d7RDM6wGi9HdYXHLvVVUiQOJ/BCK
 Nqhx97cMTwgVC/PuLS+T31MIKlLKrzlHrGhSxEBra9uYKqOby1EvD5fS+J2tr/R5nF3FRa
 HUaNUEz31JJCosE6BgxIBt2GtfDF2Zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-F1Wmqs08NaOLRke6QFlFcQ-1; Mon, 01 Jun 2026 10:22:38 -0400
X-MC-Unique: F1Wmqs08NaOLRke6QFlFcQ-1
X-Mimecast-MFC-AGG-ID: F1Wmqs08NaOLRke6QFlFcQ_1780323757
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so81285925e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780323757; x=1780928557; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nc1FGWRi33B4lX3wfu2SMmxgYqYKjd8FEy58P5ng868=;
 b=pfVhbfB+ttId4rj5DIeSYVv2hxSuWDQXXmRO8cXiwr4pyp0qS+juQUmG/0LHBs1UqH
 2321AKCJtc4jlPACCmzZ7y9snk35eDdcrFkADwVblDu5R+TejqWlKopCe7ye0ElI7h2f
 J/WkN9fTvtL+usGogGBiF5FUbZywiSIaLjVZjCGQDXrwZeuhRvEwrhhQRUAq9L/aUdRu
 OZo9EUXnGW9rDrWkMV5hrYEl1mVVlfCwVJsMdmEH4BlP75iJcdy9t6uRda8+BnTfoFRU
 TP9Y+gtzN2fnbFAv578zloQCQtPS67p7xW8ayFtnXBXqdbpchCHQ/p/DOikyNzJ47Cby
 xnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780323757; x=1780928557;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nc1FGWRi33B4lX3wfu2SMmxgYqYKjd8FEy58P5ng868=;
 b=I3HtlNwox0os4HrEm4QyJmLx8DIZJkTb43+fI+E+lmBOKktMvv8IM8ddSdGHBJaH2q
 Q858tliGqBbo545Uek66H6Ewcs1r495bTH3FiaUKSpUynP8TrZ8huMsy8PgVelPDFK5e
 4Dz8gKvsrlqAy3fo4dUXBEcULP6d6L5ofusUvBygNKSt2ElWzweqt8ZPwlT0WWcFKiE/
 UsZ+Skx0JSgpH5SQE8JiLqKLsEhM6WbJQ5DOydYyVrFnnFnbHWNW1J0gkmtXR6YYSTZQ
 bvZeO+JRGYGwjoDg47fuBqSVHlJqcVApP67BxfYdUOSQN9PHpOz8V2Ud22s6HsiVdcCw
 zTvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U/utb7TNgnt5qd6A1GCN6G01R1EAiwpxgTtnFAu6PLgvi0DxkFFlChSWfm/4K6BtMFFERtjzFI269@nongnu.org
X-Gm-Message-State: AOJu0YxNtfXi2DX8nr6IweixqSkllYXLr4CGhzpPIQsvjYJe8odv5rmQ
 b/00lzAE1x5HvgbRp3NG0nTST28L0zjZm/cKin6pXdRNrYj6dRDzVZ5O/rxKqirm+GR5i7NqB+w
 Qx0mk7trVcvtMutrvWniJ26VEPXTXRN8yiwwiyQzDzLZAD17oaEmNHpxQ
X-Gm-Gg: Acq92OHvrBjt/6mhx0Bymgp7+PiE7IDNvJ4bDjXO4uao+ZQ1b2Fi138FcM8PuMfAqKj
 w+MAkIeEp9htYFMz/2Vzf9j7hJtzex1YGJoob66DRyVNabk4DsDOiqsYC0W5E2b7ZpDAsFOyfDY
 nlQdmqZlvvWNg0dCeEPNd4UCXtihyxYVSy3lV3Om5gK69QQn4YpAYvb+MqLd1LKy12XwfMIAbsB
 c9vc3MZTQMkRAzRkzG5VaQ9Csvx5v6Z6gvo8iMfaTufQh2xTYxGR0p4e+y/Mo8jf+4uUZ6hrBBA
 3+Sn6vmGVwmK1MOGEXVK/DBjkjOEvIaodGS7/eTnlUb+sYPDG3V4+g07Iv1W+I6PSxAysAhzs+J
 zjgEyzHQQshTcDa6YpZN16oXrIWwnUIdjJg7EeRU05BJwlH3OIObYpg==
X-Received: by 2002:a05:600c:4e08:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-490a293624dmr199682695e9.10.1780323757204; 
 Mon, 01 Jun 2026 07:22:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-490a293624dmr199681955e9.10.1780323756675; 
 Mon, 01 Jun 2026 07:22:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0d5dc2sm109707855e9.2.2026.06.01.07.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:22:36 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:22:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Albert Esteve <aesteve@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601102216-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 01, 2026 at 09:51:40AM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 1, 2026 at 9:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > On Mon, Jun 1, 2026 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > > >  But also because, in my opinion, separating
> > > > > the specification would improve development agility by decoupling
> > > > > specification development from QEMU's review and release cycles.
> > > >
> > > > Generally for QEMU this will be less agility, unless I misunderstand
> > > > what is proposed)
> > > >
> > > > Because presumably there will need to be spec releases then?
> > > >
> > > > So
> > > >         new feature -> spec tree -> spec release -> qemu implementation -> qemu release
> > > >
> > > > is surely longer that what we have now.
> > >
> > > I see your point.
> > >
> > > However, we do not really need to introduce a heavy release management
> > > layer. We could just operate it as a living document, where the main
> > > branch is the authoritative source of truth.
> > >
> > > For the workflow, development doesn't have to be strictly sequential
> > > either. A contributor can propose the spec update while working on the
> > > implementation, much like we do for VirtIO updates. Actually, this way
> > > one update/change supports the other.
> > >
> > > I guess my point is that a dedicated repository could lower the
> > > barrier for new changes AND keep QEMU's own development speed mostly
> > > unaffected.
> > >
> > > BR,
> > > Albert
> >
> > Something something submodule? Possibly. If you want to make progress
> > on this, pls think of the process, try it out.
> 
> If I understand correctly, the motivation for moving the spec
> somewhere else is to replace the email patch review process with a git
> forge review process?

wait who said that?

-- 
MST


