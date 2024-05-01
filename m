Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD22C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 15:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Bvd-0004nv-IN; Wed, 01 May 2024 11:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Bvb-0004nC-PB
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2BvY-0006jx-VT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 11:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714577484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8I1pXtNVMXZEnkfUkGuLlM13+ZNpmPrabuifJA8ZARQ=;
 b=icyqS7DelnrV8qxoUnbCjiRjrVoxdn3uqJXKATs2ZebN8O34x5YxKEO6+T0XgDvJWm1Hyu
 qcWWakS0DqUeaX8J2kCDXhINLFKIZKwvgamcP3Th+oRfCpEj3fuDH4onBOwWLDI0ZH1AAx
 SSV83tXmcy64btf8It2h7Dztli/355A=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-_j2E_FUqM-y3uFKUnh8IRA-1; Wed, 01 May 2024 11:31:22 -0400
X-MC-Unique: _j2E_FUqM-y3uFKUnh8IRA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6ecfaccf30aso730835b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 08:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714577481; x=1715182281;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8I1pXtNVMXZEnkfUkGuLlM13+ZNpmPrabuifJA8ZARQ=;
 b=SarhrUKt93yxOhjZ5nZXc2+zbW+ERgrzT/SP2QRKzvOPzrhne+frrssZz4591APPRl
 sPYAQUzPyHIfIDzQO9o/qNGbw3ER+xT42T0tKiOIMBmaBvDdE9q5MIX0R/jthfuFDlxz
 to88EaZ6Vi+TGjGC5VwIigSqOqeCKNMsnH9l1rj3NsodpzVzIPIyubkb7bmXHlzItBL9
 WdET4TM0OB9YGiydD1+EZRc3PtowcAhU8dNXSueWV/s7CjccBCoFSpC+r6qvg595gGUJ
 ydzyItr6VdWtJXHq6ik2TuSA9sIufBVJRKAQ7FA+FpD3LX/u4UZFX/0ZgT60vnF9kiFk
 YyAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFbeeFIwGRa0Bs2tbSbtW35L/wlwtlysVkfowzZK0uBSWIuIncAMITkeHTYhcxQ4EX4Uv0/mzBIJni+l79bdBEDzcEuBs=
X-Gm-Message-State: AOJu0Yyuf6vaDdq2AdgYCibAAD9fj8JQyeEK4jMV9nJXGdXOyatQ9Ibp
 h6Zb9PVKCooS9tUiCCVk8gOyMis0BImOKeo3znDq7O+NT2lJG+SsW5jKbkLZHovL8SIWaN2Gass
 vv18UEP4EXQux3byczLZ2WrEMqNKWuOvtTTO9A3ERZXkjxTtWANtB
X-Received: by 2002:a05:6a21:6da2:b0:1aa:aa2f:a511 with SMTP id
 wl34-20020a056a216da200b001aaaa2fa511mr3862716pzb.6.1714577481005; 
 Wed, 01 May 2024 08:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPV9xzFooVVSs2G8RFKS9iZDGIrL97sgqstK/M/yzzj2lbTIotpKxnk5f6V2uEs4FuSUr2cA==
X-Received: by 2002:a05:6a21:6da2:b0:1aa:aa2f:a511 with SMTP id
 wl34-20020a056a216da200b001aaaa2fa511mr3862653pzb.6.1714577480221; 
 Wed, 01 May 2024 08:31:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j14-20020a62e90e000000b006edec30bbc2sm22743730pfh.49.2024.05.01.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 08:31:19 -0700 (PDT)
Date: Wed, 1 May 2024 11:31:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
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
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjJgQcPQ29HJsTpY@x1n>
References: <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjClMb-6MddpvHqQ@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 30, 2024 at 09:00:49AM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 30, 2024 at 09:15:03AM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, Apr 29, 2024 at 08:08:10AM -0500, Michael Galaxy wrote:
> > >> Hi All (and Peter),
> > >
> > > Hi, Michael,
> > >
> > >> 
> > >> My name is Michael Galaxy (formerly Hines). Yes, I changed my last name
> > >> (highly irregular for a male) and yes, that's my real last name:
> > >> https://www.linkedin.com/in/mrgalaxy/)
> > >> 
> > >> I'm the original author of the RDMA implementation. I've been discussing
> > >> with Yu Zhang for a little bit about potentially handing over maintainership
> > >> of the codebase to his team.
> > >> 
> > >> I simply have zero access to RoCE or Infiniband hardware at all,
> > >> unfortunately. so I've never been able to run tests or use what I wrote at
> > >> work, and as all of you know, if you don't have a way to test something,
> > >> then you can't maintain it.
> > >> 
> > >> Yu Zhang put a (very kind) proposal forward to me to ask the community if
> > >> they feel comfortable training his team to maintain the codebase (and run
> > >> tests) while they learn about it.
> > >
> > > The "while learning" part is fine at least to me.  IMHO the "ownership" to
> > > the code, or say, taking over the responsibility, may or may not need 100%
> > > mastering the code base first.  There should still be some fundamental
> > > confidence to work on the code though as a starting point, then it's about
> > > serious use case to back this up, and careful testings while getting more
> > > familiar with it.
> > 
> > How much experience we expect of maintainers depends on the subsystem
> > and other circumstances.  The hard requirement isn't experience, it's
> > trust.  See the recent attack on xz.
> > 
> > I do not mean to express any doubts whatsoever on Yu Zhang's integrity!
> > I'm merely reminding y'all what's at stake.
> 
> I think we shouldn't overly obsess[1] about 'xz', because the overwhealmingly
> common scenario is that volunteer maintainers are honest people. QEMU is
> in a massively better peer review situation. With xz there was basically no
> oversight of the new maintainer. With QEMU, we have oversight from 1000's
> of people on the list, a huge pool of general maintainers, the specific
> migration maintainers, and the release manager merging code.
> 
> With a lack of historical experiance with QEMU maintainership, I'd suggest
> that new RDMA volunteers would start by adding themselves to the "MAINTAINERS"
> file with only the 'Reviewer' classification. The main migration maintainers
> would still handle pull requests, but wait for a R-b from one of the RMDA
> volunteers. After some period of time the RDMA folks could graduate to full
> maintainer status if the migration maintainers needed to reduce their load.
> I suspect that might prove unneccesary though, given RDMA isn't an area of
> code with a high turnover of patches.

Right, and we can do that as a start, it also follows our normal rules of
starting from Reviewers to maintain something.  I even considered Zhijian
to be the previous rdma goto guy / maintainer no matter what role he used
to have in the MAINTAINERS file.

Here IMHO it's more about whether any company would like to stand up and
provide help, without yet binding that to be able to send pull requests in
the near future or even longer term.

What I worry more is whether this is really what we want to keep rdma in
qemu, and that's also why I was trying to request for some serious
performance measurements comparing rdma v.s. nics.  And here when I said
"we" I mean both QEMU community and any company that will support keeping
rdma around.

The problem is if NICs now are fast enough to perform at least equally
against rdma, and if it has a lower cost of overall maintenance, does it
mean that rdma migration will only be used by whoever wants to keep them in
the products and existed already?  In that case we should simply ask new
users to stick with tcp, and rdma users should only drop but not increase.

It seems also destined that most new migration features will not support
rdma: see how much we drop old features in migration now (which rdma
_might_ still leverage, but maybe not), and how much we add mostly multifd
relevant which will probably not apply to rdma at all.  So in general what
I am worrying is a both-loss condition, if the company might be easier to
either stick with an old qemu (depending on whether other new features are
requested to be used besides RDMA alone), or do periodic rebase with RDMA
downstream only.

So even if we want to keep RDMA around I hope with this chance we can at
least have clear picture on when we should still suggest any new user to
use RDMA (with the reasons behind).  Or we simply shouldn't suggest any new
user to use RDMA at all (because at least it'll lose many new migration
features).

Thanks,

-- 
Peter Xu


