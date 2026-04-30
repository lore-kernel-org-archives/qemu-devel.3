Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D3BCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMLK-0002VC-RT; Thu, 30 Apr 2026 04:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMLH-0002To-8F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIMLD-0001yR-8I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777536103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jmtt5lto2u/K0oq9NhicdZHqihFsi/Fl8MNjB6MkTLc=;
 b=i8vq3ImmUJdDDwH6HgPAjolYysS64kDD3h2Wka1/CFxkvElOjC3SFnRXtITgMtMSWtIeWg
 quVH0Al/eSgk7IUSB9gRp/kER/YOcBZJA1CAdZh9kSfNI+RnTFk8zvfS1QN8lJF+Ivajxa
 htqUwaRvYLfZ4Nvi+TAeZZ8kuIIYPSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-FutSyGIxN7yr4WiEw-Qyzg-1; Thu,
 30 Apr 2026 04:01:39 -0400
X-MC-Unique: FutSyGIxN7yr4WiEw-Qyzg-1
X-Mimecast-MFC-AGG-ID: FutSyGIxN7yr4WiEw-Qyzg_1777536098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6BBD19560BD; Thu, 30 Apr 2026 08:01:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EEF91800347; Thu, 30 Apr 2026 08:01:35 +0000 (UTC)
Date: Thu, 30 Apr 2026 09:01:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, artem_mygaiev@epam.com, takahiro.nakata.wr@renesas.com
Subject: Re: Question on preferred location for QEMU sample projects
Message-ID: <afMMWz5dgkGJc0cI@redhat.com>
References: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
 <87v7dvgw58.fsf@pond.sub.org>
 <CAN-aV1ERB-vdvMyRuNo2tog9-EPPyCunXJkk-kC=DkX-kU6VCQ@mail.gmail.com>
 <CAN-aV1HDZfoJv3OCm9_f3epNtvvr5CrvB-1Fi4y7jGLwF3Xx7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-aV1HDZfoJv3OCm9_f3epNtvvr5CrvB-1Fi4y7jGLwF3Xx7g@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 29, 2026 at 09:25:21PM +0200, Ruslan Ruslichenko wrote:
> On Mon, Apr 13, 2026 at 4:04 PM Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
> >
> > On Mon, Apr 13, 2026 at 9:25 AM Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > > Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
> > >
> > > > Hi everyone,
> > > >
> > > > We are currently preparing the v2 patch series for the Remote-Port
> > > > Co-simulation protocol for interfacing with SystemC modules. The first
> > > > revision was here:
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg01760.html.
> > > >
> > > > As part of this submission, we would like to publish a sample project
> > > > serving as a demonstration of how to connect a QEMU Remote-Port
> > > > frontend to a SystemC backend.
> > > >
> > > > The sample project implements a standard SystemC IP core and uses
> > > > several external components such as:
> > > > - libsystemctlm-soc: https://github.com/Xilinx/libsystemctlm-soc
> > > > - VCML Library: https://github.com/machineware-gmbh/vcml
> > > > - SystemC Library: https://github.com/accellera-official/systemc
> > > >
> > > > We have a question regarding the location for this kind of project.
> > > > Could you please suggest if there is a preferred location or some
> > > > standard practice for hosting such a sample project?
> > >
> > > Location within the QEMU source tree?
> >
> > Yes, it would be good to include this project within the QEMU source tree.
> > To build the project, the mentioned SystemC, libsystemctlm-soc and
> > VCML libraries and their specific dependencies need to be built and
> > installed separately.
> > Would this approach be acceptable?
> >
> > Alternatively, is there an auxiliary repository within the QEMU
> > infrastructure that is better suited for these types of sample
> > projects,
> > perhaps somewhere under https://gitlab.com/qemu-project?
> 
> Do you have any thoughts on the preferred location for this sample project?

Why not just publish it under its own standalone git repo ? 

With regards,
Daniel


