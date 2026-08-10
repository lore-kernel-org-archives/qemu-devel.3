Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB189C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSNQ-00075o-Nx; Mon, 10 Aug 2026 11:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtSNH-000756-0b
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtSNE-0000lY-TL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786377430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsDWxrMzrzfFX1q56A/jjr193GNqNRJmbeTSnFD6+3E=;
 b=AMv+bC9D3bkiuyDkzFf94BRG9Xe//sAgUO519+m4ubk6PAgWHRwm3A7ROCIXGAw1tut6G7
 sr/TKSROWJVoey08SoUMQxiilrOfY70ez2QaZbHg8X1V/04ZLr8TK7fLbEqjK8inYN77vb
 zxzpfT1U1XqliVeIkQBfMzE51SswUYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-M66wDsAtOrO7kr3DJbWUHg-1; Mon,
 10 Aug 2026 11:57:04 -0400
X-MC-Unique: M66wDsAtOrO7kr3DJbWUHg-1
X-Mimecast-MFC-AGG-ID: M66wDsAtOrO7kr3DJbWUHg_1786377423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7B39195608F; Mon, 10 Aug 2026 15:57:02 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B55518005BB; Mon, 10 Aug 2026 15:57:00 +0000 (UTC)
Date: Mon, 10 Aug 2026 16:56:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Message-ID: <ann0yXUsspvKffH2@redhat.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <anS7uRcg2IkGxR-4@redhat.com>
 <328caf32-d011-40e5-aa05-dac3273fa203@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <328caf32-d011-40e5-aa05-dac3273fa203@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 06, 2026 at 01:21:13PM -0700, Pierrick Bouvier wrote:
> On 8/6/2026 9:52 AM, Daniel P. Berrangé wrote:
> > 
> > What machines you could see when doing "qemu-system --machine help"
> > would depend on which/how many "--target NAME" args you enable.
> > 
> >  qemu-system -target x86_64 -machine help
> >    -> x86_64 machines
> >    (equiv of qemu-system-x86_64)
> > 
> >  qemu-system -target aarch64
> >    -> aarch64 machines
> >    (equiv of qemu-system-aarch64)
> > 
> >  qemu-system -target x86_64,aarch64
> >    -> aarch64 machines
> >    -> x86_64 machines
> >    -> aarch64+x86_64 machines
> >    (equiv of qemu-system-aarch64 plus qemu-system-x86_64 plus new heterogenous machines)
> > 
> >  qemu-system -target x86_64,aarch64,riscv64
> >    -> aarch64 machines
> >    -> x86_64 machines
> >    -> riscv64 machines
> >    -> aarch64+x86_64 machines
> >    -> aarch64+riscv64 machines
> >    -> riscv64+x86_64 machines
> >    -> aarch64+riscv64+x86_64 machines
> >    (equiv of qemu-system-aarch64 plus qemu-system-x86_64
> >     plus qemu-system-riscv64 plus new heterogenous machines
> >     for any combo of x86_64, aarch64 and riscv64)
> >
> 
> This is where we have a gap in our understanding.
> The goal is not to enable multiple targets, not in this way at least.
> 
> I give you a simple example about why it's a bad design:
> What is the semantic of such a line?
> $ qemu-system -target x86_64,aarch64,riscv64 -M virt -cpu max
> We now created an ambiguous command line, is virt the virt riscv64 or
> aarch64? How about cpu?

The ambiguity needs fixing before we can have multiple different
targets in the same binary. I would expect you're going to hit a
failure before QEMU even tries to process that command line, as
QOM class names must be unique and you'll have two separate
classes called 'virt-machine' AFAICT.

> Someone with over engineering tendencies will come with the idea:
> "Ok let's prefix machine and cpu with target".
> $ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
> aarch64:max
> 
> And then, someone will say:
> $ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
> riscv64:max
> And then, we will all go to hell for creating such a thing.

I wouldn't suggest we need to prefix an arch name for *everything*,
as most type names will not clash.  "virt" and "max" are two
exceptions but most machine names and CPU names will be unique
across architectures.

IOW, just those clashing names need fixing, 'aarch64-virt'
and 'aarch64-max', but not the rest.

Saying this is "going to hell" is overly dramatic. It is just
an expected result of fixing a handful of cases where we got
away without having properly unique naming today.

> The only sane solution is to restrict to a single -target, and have the
> exact same behavior than current binaries. No change, no breakage.

I think we're going to need to have changes this area.

To deal with the transition we'll need to support aliases
like "virt" that resolve to either "aarch64_virt" or "riscv64_virt"
depending on target specific context, or raise an error if it is
ambiguous in a fully heterogenous context.

> For heterogeneous machines, we want to propose a very different
> approach, that requires all QOM types to be registered. Once again, it's
> not the time to present/solve that, but it's why we implemented this
> runtime filtering instead of exposing only some types.

AFAIK, QEMU won't be able to register all QOM types, as it will have
multiple different classes called 'virt-machine' and will (should)
trigger an assert until they're given unique names.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


