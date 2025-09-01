Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54781CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1z4-0007XL-Gx; Mon, 01 Sep 2025 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut1z0-0007Pk-0F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut1yw-0007Cr-UJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756723307;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gTtIZk+m/iH3t1RTJQoqYI8hv01syqYwCSetwLDKdZI=;
 b=Wxqc4/RcExGGkTjCRBIbpJODIfRellY6yqULcvzBEcHHu+I7/arPFnX5yz8SQcEdHee/LA
 yUcVeeNAwOuRJuKt0fd6TI/RJeb270BOSFw8Wi17aVzJAe+Yd9Zoqs9XMHxMS/1aN7rSOz
 54Z7jYxb6/+oNKqCdBt3fsADGEyq7ec=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-Jhl57t4_PJWpoYSMws_SsQ-1; Mon,
 01 Sep 2025 06:41:42 -0400
X-MC-Unique: Jhl57t4_PJWpoYSMws_SsQ-1
X-Mimecast-MFC-AGG-ID: Jhl57t4_PJWpoYSMws_SsQ_1756723301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4C02195C277; Mon,  1 Sep 2025 10:41:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C9D130001A2; Mon,  1 Sep 2025 10:41:37 +0000 (UTC)
Date: Mon, 1 Sep 2025 11:41:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: Re: [PATCH v7 04/14] target/riscv: Add MIPS P8700 CSRs
Message-ID: <aLV4XVR6baQpZRD_@redhat.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
 <20250901102850.1172983-5-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901102850.1172983-5-djordje.todorovic@htecgroup.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 01, 2025 at 10:29:02AM +0000, Djordje Todorovic wrote:
> Define MIPS CSRs used for P8700 CPU.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c       |   3 +
>  target/riscv/cpu.h       |   3 +
>  target/riscv/meson.build |   1 +
>  target/riscv/mips_csr.c  | 228 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 235 insertions(+)
>  create mode 100644 target/riscv/mips_csr.c

> diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
> new file mode 100644
> index 0000000000..2fc10b8618
> --- /dev/null
> +++ b/target/riscv/mips_csr.c
> @@ -0,0 +1,228 @@
> +/*
> + * MIPS-specific CSRs.
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later

What is the reason for this choice ?

New files are expected to be GPL-2.0-or-later, with any divergence
from this explained in the commit message.


> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.

This should not be present on newly authored files - only pre-existing
code which predated our use of SPDX tags, because it creates the possible
problem of inconsistent license details - which is what you have here.

This is saying GPL-2.0-or-later, while the SDPX tag says LGPL-2.1-or-later

These points apply to multiple patches in this series.

Please make sure to run 'checkpatch.pl' on patches before submissions,
as it would have reported these problems.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


