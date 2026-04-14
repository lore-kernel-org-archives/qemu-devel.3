Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2202AF9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcnf-0004za-Da; Tue, 14 Apr 2026 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCcnd-0004yV-PJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCcnb-0006x3-1D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776169401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U725HS+zHH7jPW7TnYCH8cjGYZTWeS5a2Mo7Nkjq0CY=;
 b=KtALrJc2y5Ms8zftMIhWdiL1pTRLOm/N5nDbjhoJhI+MW4vB5uyy0384dzHc60LWEJVMZb
 kNP31bv3fWCqSfdxwUoOOI3qi5613lT/ylC6BGq+ohqWIon53rRKO72YNYho4epFWAzoYB
 jtV5kcCNOH7ld0oKTar5TZcyp0Nz0ug=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-Umz348M3OvqTwEzQMNStFQ-1; Tue,
 14 Apr 2026 08:23:17 -0400
X-MC-Unique: Umz348M3OvqTwEzQMNStFQ-1
X-Mimecast-MFC-AGG-ID: Umz348M3OvqTwEzQMNStFQ_1776169395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 956AE18007EA; Tue, 14 Apr 2026 12:23:14 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4075C3000C16; Tue, 14 Apr 2026 12:23:10 +0000 (UTC)
Date: Tue, 14 Apr 2026 13:23:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, qemu-arm@nongnu.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 6/7] tests: Add qtests for FlexCAN
Message-ID: <ad4xqiJnd8GoCrGu@redhat.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <33d03d96698eb7511321690d9b5a054f03aa8bc7.1773866323.git.matyas.bobek@gmail.com>
 <4244E4A0-CCE2-4E23-B32E-B6B9242FAA60@gmail.com>
 <adzuRHcb4BVIRAS8@redhat.com>
 <FB523542-A8A0-4B5D-B757-2C6F7F7AD981@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FB523542-A8A0-4B5D-B757-2C6F7F7AD981@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 14, 2026 at 12:11:58PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 13. April 2026 13:23:16 UTC schrieb "Daniel P. Berrangé" <berrange@redhat.com>:
> >On Mon, Apr 13, 2026 at 01:16:20PM +0000, Bernhard Beschow wrote:
> >> 
> >> 
> >> Am 19. März 2026 19:13:13 UTC schrieb "Matyáš Bobek" <matyas.bobek@gmail.com>:
> >> >The tests do not test all of the FlexCAN emulator functionality.
> >> >
> >> >Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
> >> >---
> >> > MAINTAINERS                |   1 +
> >> > tests/qtest/flexcan-test.c | 424 +++++++++++++++++++++++++++++++++++++
> >> > tests/qtest/meson.build    |   1 +
> >> > 3 files changed, 426 insertions(+)
> >> > create mode 100644 tests/qtest/flexcan-test.c
> >> >
> >> >diff --git a/MAINTAINERS b/MAINTAINERS
> >> >index e723863a6f..dbb159f031 100644
> >> >--- a/MAINTAINERS
> >> >+++ b/MAINTAINERS
> >> >@@ -2090,6 +2090,7 @@ S: Maintained
> >> > F: hw/net/can/flexcan.c
> >> > F: hw/net/can/flexcan_regs.h
> >> > F: include/hw/net/flexcan.h
> >> >+F: tests/qtest/flexcan-test.c
> >> > 
> >> > EDU
> >> > M: Jiri Slaby <jslaby@suse.cz>
> >> >diff --git a/tests/qtest/flexcan-test.c b/tests/qtest/flexcan-test.c
> >> >new file mode 100644
> >> >index 0000000000..b5880d4119
> >> >--- /dev/null
> >> >+++ b/tests/qtest/flexcan-test.c
> >> >@@ -0,0 +1,424 @@
> >> >+/*
> >> >+ * QTests for FlexCAN CAN controller device model
> >> >+ *
> >> >+ * Copyright (c) 2025 Matyas Bobek <matyas.bobek@gmail.com>
> >> >+ *
> >> >+ * This code is licensed under the GPL version 2 or later.  See
> >> >+ * the COPYING file in the top-level directory.
> >> 
> >> IIUC this license text is redundant to the specifier below, but again, IANAL. Daniel?
> >
> >checkpatch.pl  should complain about this.
> >
> >For *newly* written files, only the SPDX-License-Identifier should be
> >present.   Traditional license boilerplate is only permitted if we're
> >dealing with historical files where we're required to preserve existing
> >license text.
> 
> Thanks for the hint!
> 
> Though checkpatch.pl doesn't seem to catch this particular case. Is a patch needed here?

Yeah, it seems it is slightly different enough to miss our
checks. If you want, you can submit another addition to the
@LICENSE_BOILERPLATE list in checkpatch.pl


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


