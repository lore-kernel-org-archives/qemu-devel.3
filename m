Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9353C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 05:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucdNk-0007b1-MV; Fri, 18 Jul 2025 01:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucdNh-0007Vw-OJ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 01:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucdNe-0008SJ-R5
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 01:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752815489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARMmysfTEBbBzJJOL2kfmLEK5nKGR4pGLcHEJdAoCeA=;
 b=K0F0BtBHb1kiNUDq1GztWu97lF/FleSu0KGxe3oV/ga0Rkx8yZVDXFwaqSMhdusRXW76nH
 VkiJsRFGVSz7sI0O1r/vRy9iCi9QZOLwSrTk+ELW0VojyItwxwFJNd1cN7hsZ/O3nMkJ7x
 9B+VtaSMtPoR0rwIIDGt6nyW3YWaVoQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-rthEhHQROt6pdPOwe-EMCw-1; Fri,
 18 Jul 2025 01:11:23 -0400
X-MC-Unique: rthEhHQROt6pdPOwe-EMCw-1
X-Mimecast-MFC-AGG-ID: rthEhHQROt6pdPOwe-EMCw_1752815482
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB1EC18001DA; Fri, 18 Jul 2025 05:11:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC15830001B1; Fri, 18 Jul 2025 05:11:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A9AF21E6A27; Fri, 18 Jul 2025 07:11:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Adam Williamson <awilliam@redhat.com>
Cc: qemu-devel@nongnu.org,  Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org,  Stefano Stabellini
 <sstabellini@kernel.org>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
In-Reply-To: <20250717220207.171040-1-awilliam@redhat.com> (Adam Williamson's
 message of "Thu, 17 Jul 2025 15:02:07 -0700")
References: <20250717220207.171040-1-awilliam@redhat.com>
Date: Fri, 18 Jul 2025 07:11:18 +0200
Message-ID: <87v7nqgk21.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adam Williamson <awilliam@redhat.com> writes:

> In cfcacba an `error_report` was added to this file, but the
> corresponding include of `qemu/error-report.h` was missed. This
> only becomes apparent when building against Xen 4.20+.
>
> Signed-off-by: Adam Williamson <awilliam@redhat.com>
> ---
>  hw/xen/xen_pt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 9d16644d82..006b5b55f2 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -54,6 +54,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include <sys/ioctl.h>
>  
>  #include "hw/pci/pci.h"

Uh, error-report.h is included without this for me.  To see, build with
-H:

. /work/armbru/qemu/hw/xen/xen_pt.h
.. /work/armbru/qemu/include/hw/xen/xen_native.h
... /work/armbru/qemu/hw/xen/trace.h
.... ./trace/trace-hw_xen.h
..... /work/armbru/qemu/include/qemu/error-report.h

Code smell: header in include/... includes header from hw/.  Not this
patch's concern.


