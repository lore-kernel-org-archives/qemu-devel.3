Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D71606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU5AZ-00060W-5U; Thu, 19 Nov 2026 11:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU5AD-0005xH-5Z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:39:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU5AA-0002GH-Rf
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:39:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F15D860E018;
 Thu, 19 Nov 2026 17:39:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JCusuOLjcl31; Thu, 19 Nov 2026 17:39:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EA14860CCE7; Thu, 19 Nov 2026 17:39:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7E1E13C28F;
 Thu, 19 Nov 2026 17:39:01 +0100 (CET)
Date: Thu, 19 Nov 2026 17:39:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, David Hildenbrand <david@kernel.org>, 
 Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 for-11.2] hostmem: allow building without KVM
 support
In-Reply-To: <20261119113309.1205353-1-mjt@tls.msk.ru>
Message-ID: <33fa13d6-5932-1fa8-70a6-8b35140f4da5@eik.bme.hu>
References: <20261119113309.1205353-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026, Michael Tokarev wrote:
> On architectures where KVM is not available and so including <linux/kvm.h>
> does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:

Typo: buildnig

Regards,
BALATON Zoltan

