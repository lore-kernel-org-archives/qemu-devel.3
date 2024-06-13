Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C6BC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHcur-0006jw-Nz; Thu, 13 Jun 2024 01:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHcuf-0006dy-Fp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHcud-0004gb-QW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718256135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4tJD6nEmLUQ+lgmoW5qwufxAYUow4uw42ZLFyMQboc=;
 b=ai7tvn7nQiQZ2N0TJ5lZOc87VaPyktpAJM+99YkREjT8xeud/4hsysMhi4ozpSesvGTe8m
 RdMOElDeeG+Rg/JUi8ZB/BsWtLeOc4epGAkNvwxSGNO7zdLrcn3d2Zs9pzKYPCEiYQoDB9
 z1EJsu6BDj3jx1YsxhzioS11iGtMBPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-q1M3J26wOFuXKljLX6Kvug-1; Thu,
 13 Jun 2024 01:22:11 -0400
X-MC-Unique: q1M3J26wOFuXKljLX6Kvug-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68B0719560A5; Thu, 13 Jun 2024 05:22:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B199919560AB; Thu, 13 Jun 2024 05:22:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9440121E6687; Thu, 13 Jun 2024 07:22:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Peng Fan <peng.fan@nxp.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Subject: Re: Qemu License question
In-Reply-To: <f06ai.hy2gx5h8080@linaro.org> (Manos Pitsidianakis's message of
 "Thu, 13 Jun 2024 08:06:09 +0300")
References: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <f06ai.hy2gx5h8080@linaro.org>
Date: Thu, 13 Jun 2024 07:22:07 +0200
Message-ID: <87h6dxct8g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, 13 Jun 2024 06:26, Peng Fan <peng.fan@nxp.com> wrote:
>>Hi All,
>>
>>The following files are marked as GPL-3.0-or-later. Will these
>>Conflict with Qemu LICENSE?
>>
>>Should we update the files to GPL-2.0?
>>
>>./tests/tcg/aarch64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/x86_64/system/boot.S:13: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/riscv64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/float_convs.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/float_helpers.h:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/libs/float_helpers.c:10: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/arm-compat-semi/semihosting.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/arm-compat-semi/semiconsole.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/float_convd.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/multiarch/float_madds.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/i386/system/boot.S:10: * SPDX-License-Identifier: GPL-3.0-or-later
>>./tests/tcg/arm/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>>
>>Thanks,
>>Peng.
>
>
> Hello Peng,
>
> These are all actually GPL-2.0-or-later, in fact I can't find the string GPL-3.0-or-later in the current master at all.

See commit 542b10bd148a (tests/tcg: update licenses to GPLv2 as intended).


