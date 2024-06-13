Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHg7y-0002LG-O4; Thu, 13 Jun 2024 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHg7x-0002Ka-Fo
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHg7v-0007J0-SQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718268491;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=93ylkh3amxuY1ED6z+lzcYCkeppGFUlu183RpXkMdtY=;
 b=Bx+3ZRFdsS+fX0cOf1xThqVAcyrnKzufpvHYTZiXD4VVA4jP/+lllMJ+8IjhdqOEGVim0B
 nk8C8DumxS3fMA3IRESEfgKq43bDYj37qaBA4PF6tS3nOP2ryPvB6x7SJkBgw75RrXGKLU
 u7OMuKLPelLJCnqRxlf+BWowqah86Mw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-C48Z3ilTMiyUUESKWea_7A-1; Thu,
 13 Jun 2024 04:48:09 -0400
X-MC-Unique: C48Z3ilTMiyUUESKWea_7A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 294CD1955EF5; Thu, 13 Jun 2024 08:48:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 625C31955E72; Thu, 13 Jun 2024 08:48:01 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:47:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Peng Fan <peng.fan@nxp.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: Qemu License question
Message-ID: <ZmqyPje6_9I1YeTT@redhat.com>
References: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <f06ai.hy2gx5h8080@linaro.org> <87h6dxct8g.fsf@pond.sub.org>
 <2624ae07-f61d-4c07-9510-ebbd243670a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2624ae07-f61d-4c07-9510-ebbd243670a3@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 13, 2024 at 10:31:50AM +0200, Thomas Huth wrote:
> On 13/06/2024 07.22, Markus Armbruster wrote:
> > Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> > 
> > > On Thu, 13 Jun 2024 06:26, Peng Fan <peng.fan@nxp.com> wrote:
> > > > Hi All,
> > > > 
> > > > The following files are marked as GPL-3.0-or-later. Will these
> > > > Conflict with Qemu LICENSE?
> > > > 
> > > > Should we update the files to GPL-2.0?
> > > > 
> > > > ./tests/tcg/aarch64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/x86_64/system/boot.S:13: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/riscv64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/float_convs.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/float_helpers.h:6: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/libs/float_helpers.c:10: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/arm-compat-semi/semihosting.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/arm-compat-semi/semiconsole.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/float_convd.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/multiarch/float_madds.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/i386/system/boot.S:10: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > ./tests/tcg/arm/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
> > > > 
> > > > Thanks,
> > > > Peng.
> > > 
> > > Hello Peng,
> > > 
> > > These are all actually GPL-2.0-or-later, in fact I can't find the string GPL-3.0-or-later in the current master at all.
> > 
> > See commit 542b10bd148a (tests/tcg: update licenses to GPLv2 as intended).
> 
> Maybe it could be included in the stable releases before 9.0, too?
> CC:-ing qemu-stable for this now.

IMHO this is largely a non-issue from a licensing compatibility POV, and
thus not neccessary for stable.

This is self-contained test code that, IIUC, is not linking to the bits of
QEMU that are GPLv-2-only, so is valid to have any license. GPL-2.0+ is
just "nice to have" for consistency of the codebase.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


