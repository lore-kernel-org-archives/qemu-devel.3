Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F978EBFD0A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBfd-0004Ub-4d; Mon, 13 Apr 2026 03:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wCBfN-0004Lg-3W
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wCBfL-000230-3e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776065100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+utsl4mJD2ZW/eILKQS+iemd0eSSuzZ0R8Gs50lRirE=;
 b=N1SPWPPf4y7GcdHR4Co80Z4LXu9ANfj8BxTgkua/Ct1EE32q0CHyQYanUiGdCaiHPfuQuw
 N1rzZ7ZqtzPGVVDnF31QPstLd0GsrdVVlsdcr+l5bbSyXEn6YPI6IUdHP9wSX1mGJ9jjgX
 bowVtSqcjmbw1MhjowNquQDYe3yZM7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-EzY4kTi6PIWySAoYgJbCqQ-1; Mon,
 13 Apr 2026 03:24:56 -0400
X-MC-Unique: EzY4kTi6PIWySAoYgJbCqQ-1
X-Mimecast-MFC-AGG-ID: EzY4kTi6PIWySAoYgJbCqQ_1776065095
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6EFA1955DDB; Mon, 13 Apr 2026 07:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B1001800451; Mon, 13 Apr 2026 07:24:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C7B2621E6A28; Mon, 13 Apr 2026 09:24:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  artem_mygaiev@epam.com,
 takahiro.nakata.wr@renesas.com
Subject: Re: Question on preferred location for QEMU sample projects
In-Reply-To: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
 (Ruslan Ruslichenko's message of "Fri, 3 Apr 2026 16:39:32 +0200")
References: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
Date: Mon, 13 Apr 2026 09:24:51 +0200
Message-ID: <87v7dvgw58.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:

> Hi everyone,
>
> We are currently preparing the v2 patch series for the Remote-Port
> Co-simulation protocol for interfacing with SystemC modules. The first
> revision was here:
> https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg01760.html.
>
> As part of this submission, we would like to publish a sample project
> serving as a demonstration of how to connect a QEMU Remote-Port
> frontend to a SystemC backend.
>
> The sample project implements a standard SystemC IP core and uses
> several external components such as:
> - libsystemctlm-soc: https://github.com/Xilinx/libsystemctlm-soc
> - VCML Library: https://github.com/machineware-gmbh/vcml
> - SystemC Library: https://github.com/accellera-official/systemc
>
> We have a question regarding the location for this kind of project.
> Could you please suggest if there is a preferred location or some
> standard practice for hosting such a sample project?

Location within the QEMU source tree?


