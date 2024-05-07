Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D81C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Nfz-0007y3-KU; Tue, 07 May 2024 12:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Nfx-0007xQ-Km
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4Nfv-0004fo-Hb
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715099298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FexGU1JIdjYxpurIK1Zea34T+rkXy+iMm0Y82JZzEoE=;
 b=MEoQnpBTknKhtWVc5afPd8Ejw0au+Kegr0rykg+pTJE6oTwEaT31DcLazJFGtqSjhfy4D/
 QSLT2rBxwaIwwDoNVG/ITK+f1wCv6rxuZSla1BKksdLE8RmaGKSvjAT5DtVkBngQnD9fDX
 GJKJNEOniJ8atfR2rSvpAeixymiT6bM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-dU5kYVGbP5epahm0fZ8CLw-1; Tue, 07 May 2024 12:28:16 -0400
X-MC-Unique: dU5kYVGbP5epahm0fZ8CLw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b22d772714so315850eaf.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715099296; x=1715704096;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FexGU1JIdjYxpurIK1Zea34T+rkXy+iMm0Y82JZzEoE=;
 b=byCq3efx4l4wC9Bcg6Lg7szIpaC6QpbU6tN0U3teFcqxwHyfjNek0dllWW70rDCuVN
 efyQsONXrBUTqYemjy/VcEmZ+X/Ony3fnVPCdD6kTenodtjbMM4Z1BZhGBaMFh3AROPz
 739uQ18Xqw/zzx9mZlkGpque+wlz1feugBOJ9c4qxTxqqzgCai8HEPMk9nImpBlDjN9y
 rySSA66prBmfbcXBmgpY9ghUptaj2z3zOi3ie/2t+OeWIFIpr7m+utyOxb0mVMEBUZYk
 eUBx4m9Lae4JysFX0OzKyPFOAX+hyCpg5DekrCKFzBY9WUQFGva9RbR8pHBievZ3v044
 XwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG82ssZumQ94NFGj+D/5XPgYZ9Yd2/2+a7rnaD2F7G8lD25JDC98XNhdFw0OfBq3Rkb0TGhAjgoJn13NbKPBdWDxdlMSc=
X-Gm-Message-State: AOJu0YyWCgWETDSEPEkIF0/pO/ia7jKy1/wI3rypLaxEojGiwV+m/+WR
 nVQkxeyWxtYZP56bT702jvvtHJpEcShBesL8xWjqEtlKEI0Ua82LfCw7UYa+NkqA82fhvRIkkXM
 b0XBLQVYMS/oyCt+/tLBtwpkw0QvId+bE2pwBFSNNbDo+DyL/yFYB
X-Received: by 2002:a05:6358:5289:b0:192:89b7:b4b5 with SMTP id
 e5c5f4694b2df-192d397385bmr19925355d.3.1715099295707; 
 Tue, 07 May 2024 09:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3RyE9qwPw0GhTVfKphG9z33nVzR/cYVfPeGZFapoUHEWLC//1Gp5OlKCqOUJi4AGXw5ctiA==
X-Received: by 2002:a05:6358:5289:b0:192:89b7:b4b5 with SMTP id
 e5c5f4694b2df-192d397385bmr19920655d.3.1715099295060; 
 Tue, 07 May 2024 09:28:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o3-20020a655203000000b005f750f36968sm8702087pgp.42.2024.05.07.09.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 09:28:14 -0700 (PDT)
Date: Tue, 7 May 2024 12:28:08 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
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
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>, zhengchuan <zhengchuan@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjpWmG2aUJLkYxJm@x1n>
References: <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <addaa8d094904315a466533763689ead@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 01:50:43AM +0000, Gonglei (Arei) wrote:
> Hello,
> 
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Monday, May 6, 2024 11:18 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>; Markus Armbruster
> > <armbru@redhat.com>; Michael Galaxy <mgalaxy@akamai.com>; Yu Zhang
> > <yu.zhang@ionos.com>; Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>; Jinpu Wang
> > <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
> > qemu-devel@nongnu.org; Yuval Shaia <yuval.shaia.ml@gmail.com>; Kevin Wolf
> > <kwolf@redhat.com>; Prasanna Kumar Kalever
> > <prasanna.kalever@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> > Michael Roth <michael.roth@amd.com>; Prasanna Kumar Kalever
> > <prasanna4324@gmail.com>; integration@gluster.org; Paolo Bonzini
> > <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
> > Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
> > Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
> > Gao <gaosong@loongson.cn>; Marc-André Lureau
> > <marcandre.lureau@redhat.com>; Alex Bennée <alex.bennee@linaro.org>;
> > Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
> > <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
> > Xiexiangyou <xiexiangyou@huawei.com>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
> > 
> > On Mon, May 06, 2024 at 02:06:28AM +0000, Gonglei (Arei) wrote:
> > > Hi, Peter
> > 
> > Hey, Lei,
> > 
> > Happy to see you around again after years.
> > 
> Haha, me too.
> 
> > > RDMA features high bandwidth, low latency (in non-blocking lossless
> > > network), and direct remote memory access by bypassing the CPU (As you
> > > know, CPU resources are expensive for cloud vendors, which is one of
> > > the reasons why we introduced offload cards.), which TCP does not have.
> > 
> > It's another cost to use offload cards, v.s. preparing more cpu resources?
> > 
> Software and hardware offload converged architecture is the way to go for all cloud vendors 
> (Including comprehensive benefits in terms of performance, cost, security, and innovation speed), 
> it's not just a matter of adding the resource of a DPU card.
> 
> > > In some scenarios where fast live migration is needed (extremely short
> > > interruption duration and migration duration) is very useful. To this
> > > end, we have also developed RDMA support for multifd.
> > 
> > Will any of you upstream that work?  I'm curious how intrusive would it be
> > when adding it to multifd, if it can keep only 5 exported functions like what
> > rdma.h does right now it'll be pretty nice.  We also want to make sure it works
> > with arbitrary sized loads and buffers, e.g. vfio is considering to add IO loads to
> > multifd channels too.
> > 
> 
> In fact, we sent the patchset to the community in 2021. Pls see:
> https://lore.kernel.org/all/20210203185906.GT2950@work-vm/T/

I wasn't aware of that for sure in the past..

Multifd has changed quite a bit in the last 9.0 release, that may not apply
anymore.  One thing to mention is please look at Dan's comment on possible
use of rsocket.h:

https://lore.kernel.org/all/ZjJm6rcqS5EhoKgK@redhat.com/

And Jinpu did help provide an initial test result over the library:

https://lore.kernel.org/qemu-devel/CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com/

It looks like we have a chance to apply that in QEMU.

> 
> 
> > One thing to note that the question here is not about a pure performance
> > comparison between rdma and nics only.  It's about help us make a decision
> > on whether to drop rdma, iow, even if rdma performs well, the community still
> > has the right to drop it if nobody can actively work and maintain it.
> > It's just that if nics can perform as good it's more a reason to drop, unless
> > companies can help to provide good support and work together.
> > 
> 
> We are happy to provide the necessary review and maintenance work for RDMA
> if the community needs it.
> 
> CC'ing Chuan Zheng.

I'm not sure whether you and Jinpu's team would like to work together and
provide a final solution for rdma over multifd.  It could be much simpler
than the original 2021 proposal if the rsocket API will work out.

Thanks,

-- 
Peter Xu


