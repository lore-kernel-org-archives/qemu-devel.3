Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58397FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJKD-0003VZ-7t; Thu, 30 Apr 2026 00:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wIJK9-0003Uw-FN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wIJK7-0000Vr-Ld
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777524505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlHbAtFYGFhAjMeDY9uflk6XcTBIpL2UuyGmQMU07HY=;
 b=aVLOTetAWpFKBoF+FsT1yBhSja7ykRAzlriRUyLFSCea3kyJ7r/aEyYISCJLOTYwqYSlYZ
 4tk7f1iJtoGaSrWHAFPJnWEMb0L3cdNy3qfJ79qZ8FUkuVy3esmM+ZmZLdsp6Fy9nccbbJ
 yyMOrgRi8dUL5HfmfENm2DuyuUHzzYM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-E75EfKS0OWe73Sm8r6MnMA-1; Thu,
 30 Apr 2026 00:48:21 -0400
X-MC-Unique: E75EfKS0OWe73Sm8r6MnMA-1
X-Mimecast-MFC-AGG-ID: E75EfKS0OWe73Sm8r6MnMA_1777524500
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A699193530E; Thu, 30 Apr 2026 04:48:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C0C195608E; Thu, 30 Apr 2026 04:48:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 588EF21E6A28; Thu, 30 Apr 2026 06:48:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  artem_mygaiev@epam.com,
 takahiro.nakata.wr@renesas.com, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Question on preferred location for QEMU sample projects
In-Reply-To: <CAN-aV1HDZfoJv3OCm9_f3epNtvvr5CrvB-1Fi4y7jGLwF3Xx7g@mail.gmail.com>
 (Ruslan Ruslichenko's message of "Wed, 29 Apr 2026 21:25:21 +0200")
References: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
 <87v7dvgw58.fsf@pond.sub.org>
 <CAN-aV1ERB-vdvMyRuNo2tog9-EPPyCunXJkk-kC=DkX-kU6VCQ@mail.gmail.com>
 <CAN-aV1HDZfoJv3OCm9_f3epNtvvr5CrvB-1Fi4y7jGLwF3Xx7g@mail.gmail.com>
Date: Thu, 30 Apr 2026 06:48:17 +0200
Message-ID: <875x59vysu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:

> On Mon, Apr 13, 2026 at 4:04=E2=80=AFPM Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
>>
>> On Mon, Apr 13, 2026 at 9:25=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> >
>> > Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>> >
>> > > Hi everyone,
>> > >
>> > > We are currently preparing the v2 patch series for the Remote-Port
>> > > Co-simulation protocol for interfacing with SystemC modules. The fir=
st
>> > > revision was here:
>> > > https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg01760.ht=
ml.
>> > >
>> > > As part of this submission, we would like to publish a sample project
>> > > serving as a demonstration of how to connect a QEMU Remote-Port
>> > > frontend to a SystemC backend.
>> > >
>> > > The sample project implements a standard SystemC IP core and uses
>> > > several external components such as:
>> > > - libsystemctlm-soc: https://github.com/Xilinx/libsystemctlm-soc
>> > > - VCML Library: https://github.com/machineware-gmbh/vcml
>> > > - SystemC Library: https://github.com/accellera-official/systemc
>> > >
>> > > We have a question regarding the location for this kind of project.
>> > > Could you please suggest if there is a preferred location or some
>> > > standard practice for hosting such a sample project?
>> >
>> > Location within the QEMU source tree?
>> >
>>
>> Hello Markus,
>>
>> Yes, it would be good to include this project within the QEMU source tre=
e.
>> To build the project, the mentioned SystemC, libsystemctlm-soc and
>> VCML libraries and their specific dependencies need to be built and
>> installed separately.
>> Would this approach be acceptable?

We have a few (small) examples under contrib/.  However, Peter (cc'ed)
has been trying to clean out that directory.

>>
>> Alternatively, is there an auxiliary repository within the QEMU
>> infrastructure that is better suited for these types of sample
>> projects,
>> perhaps somewhere under https://gitlab.com/qemu-project?
>>
>> --
>> BR,
>> Ruslan
>
> Hello Markus,
>
> Do you have any thoughts on the preferred location for this sample projec=
t?
>
> Best regards,
> Ruslan

Peter, what about you?


