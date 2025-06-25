Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B310AC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUMMH-00028f-BR; Wed, 25 Jun 2025 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUMMF-00028W-9Q
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUMMA-0000lc-5S
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750843427;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bZ+XYuox0wC95cywpvr8h67ROsM30izGhUHLxDsrux8=;
 b=EbAlDXl84z+ilfUPAc2V8escLTLxP81D9jk05dVxfYxl+V9ffb8JHTfMIDiSWHZWaMi3Jk
 0zg+OEZbbr7v7VE4OAR3uCtFPi75pHYHZ2H7127tNkS6nm8z+uAidMhKZBmdqWMR3b1a2B
 01J6nvO+ZSaWqTw2zZVm90xZXFyO2h0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-pPsRU3IcO_eApNH12hmkAQ-1; Wed,
 25 Jun 2025 05:23:43 -0400
X-MC-Unique: pPsRU3IcO_eApNH12hmkAQ-1
X-Mimecast-MFC-AGG-ID: pPsRU3IcO_eApNH12hmkAQ_1750843422
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E331809C89; Wed, 25 Jun 2025 09:23:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91DCC19560A3; Wed, 25 Jun 2025 09:23:33 +0000 (UTC)
Date: Wed, 25 Jun 2025 10:23:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v8 12/14] arm/cpu: Add sysreg generation scripts
Message-ID: <aFvAEXWi7PUbVAud@redhat.com>
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-13-cohuck@redhat.com>
 <87h60e1ies.fsf@redhat.com>
 <de402ecb-8d45-4e42-a805-cd3aaef8dc93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de402ecb-8d45-4e42-a805-cd3aaef8dc93@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 25, 2025 at 11:16:22AM +0200, Eric Auger wrote:
> Hi Connie,
> 
> On 6/17/25 5:45 PM, Cornelia Huck wrote:
> > On Tue, Jun 17 2025, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> >> diff --git a/scripts/arm-gen-cpu-sysregs-header.awk b/scripts/arm-gen-cpu-sysregs-header.awk
> >> new file mode 100755
> >> index 000000000000..f92bbbafa727
> >> --- /dev/null
> >> +++ b/scripts/arm-gen-cpu-sysregs-header.awk
> >> @@ -0,0 +1,37 @@
> >> +#!/bin/awk -f
> >> +# SPDX-License-Identifier: GPL-2.0-or-later
> >> +# arm-gen-cpu-sysregs-header.awk: arm64 sysreg header include generator
> >> +#
> >> +# Usage: awk -f arm-gen-cpu-sysregs-header.awk $LINUX_PATH/arch/arm64/tools/sysreg
> >> +
> >> +BEGIN {
> >> +    print "/* SPDX-License-Identifier: GPL-2.0-or-later */"
> > FWIW, checkpatch.pl chokes on this:
> >
> > ^* matches null string many times in regex; marked by <-- HERE in m/^* <-- HERE /"$/ at scripts/checkpatch.pl line 1389.
> > ERROR: Saw unacceptable licenses '*/"', valid choices for QEMU are:
> > GPL-2.0-or-later
> > GPL-2.0-only
> > LGPL-2.1-only
> > LGPL-2.1-or-later
> > BSD-2-Clause
> > BSD-3-Clause
> > MIT
> > total: 1 errors, 0 warnings, 76 lines checked
> 
> so don't we need to improve checkpatch.pl to silence this error?

Its regex gets confused by the trailing " after the comment end. We
could fix it, but ignoring the error is also valid as this is a
highly unusual file that's not likely to be common through our
source tree.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


