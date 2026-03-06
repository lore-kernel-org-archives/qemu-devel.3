Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26645F0181F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVvM-0001rk-DR; Fri, 06 Mar 2026 09:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyVvH-0001rE-LJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyVvF-0003c1-00
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772806371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dzpQYFBj+jiKRhG4ukKywl9h3r9zAzE/SmwWyF39E4=;
 b=goZcTOe2jWp9J4sYiOUrCWNbTbOrj1vU39oSgb3FJxkDqEQ4XY+VXaARNeuRbTPQ2NGuAB
 WM/yBSWmLM4Ahj8Al+myDt0+s7pIwWQzDoBbayF0Cr/72Y0xCdDgOZSam+BOayRIYPNbaw
 qgRLqwmlvRaAFkNU5OxE+E624pTVgPA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-6h5tTk4gMC2fdEh9Wzf0DQ-1; Fri,
 06 Mar 2026 09:12:45 -0500
X-MC-Unique: 6h5tTk4gMC2fdEh9Wzf0DQ-1
X-Mimecast-MFC-AGG-ID: 6h5tTk4gMC2fdEh9Wzf0DQ_1772806364
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1672195605C; Fri,  6 Mar 2026 14:12:43 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.197])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ABB11958DC7; Fri,  6 Mar 2026 14:12:39 +0000 (UTC)
Date: Fri, 6 Mar 2026 14:12:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 =?utf-8?Q?Mika=C3=ABl?= Urankar <mikael.urankar@gmail.com>,
 Guy Yur <guyyur@gmail.com>, Alexander Kabaev <kan@freebsd.org>,
 Michal Meloun <mmel@freebsd.org>, Ed Schouten <ed@nuxi.nl>
Subject: Re: [PATCH v2] bsd-user: Switch to SPDX-License-Expression
Message-ID: <aarg1MVnbcnxLMEL@redhat.com>
References: <20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On Wed, Mar 04, 2026 at 09:05:33AM -0700, Warner Losh wrote:
> Two minor changes to the copyright and license marking for these files:
> (1) Stacey D Son is used instead of variations of his name.
> (2) The GPL boilerplate is replaced by SPDX markings. No change to the
> terms of the license are intended, and this matches current QEMU practice.
> 
> There's no changes to the license or additional claims to any IP that
> others may hold in these files. All the S-o-bs in this commit have given
> me permission to do this to the extent they may hold rights. git blame
> over multiple repos and branches suggests that only minimal other
> material is present (much of it likely not subject to copyright
> protection). The project's long and complex history as well as tooling
> limitations make it hard to be 100% sure. Any omissions are
> unintentional and I will correct them as they come to light.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Guy Yur <guyyur@gmail.com>
> Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
> Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> Signed-off-by: Ed Schouten <ed@nuxi.nl>
> Signed-off-by: Warner Losh <imp@bsdimp.com>

Thanks, I used that set of emails to filter out commits 

Out of the remaining commits/files with other authors, most were a
case of  trivial function renames, code deletion, or trivial syntax
fixes to deal with external cleanups which can be exluded.

The only files where I saw any non-trivial code from other contributors
are
 
bsd-user/bsd-mem.h: 8
bsd-user/elfload.c: 36
bsd-user/freebsd/os-misc.h: 1
bsd-user/freebsd/os-proc.c: 3
bsd-user/freebsd/os-proc.h: 3
bsd-user/qemu.h: 58
bsd-user/strace.c: 7

There are way too many historic authors for elfload.c, qemu.h and
strace.c to make it worth chasing those down, so I'd suggest just
dropping those three files from the commit.

For bsd-mem.h, and freebsd/os* Karim Taha <kariem.taha2.7@gmail.com>
is the only notable omission I saw. Up to you whether to check with
them or just drop those files from the cleanup.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


