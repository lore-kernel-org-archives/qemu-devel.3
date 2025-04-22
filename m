Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6290BC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 08:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78vj-0000M0-VO; Tue, 22 Apr 2025 04:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u78vi-0000Lc-6w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u78ve-0001j9-V5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745310268;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fV0A4qfNhSbA1Zrg5hjQWipuGhxJSNrUddZzCX8RqYw=;
 b=UavIkKThKr8AgWzRfjvMb6ok0xNCmRtDnuFEI0Jf8tILLhBr6KkC+yZV0Uoreg1QdMR8p2
 H5nOAg+q7uEquQhgcbdM+MVKU39IiLaHk0zR7R3mEgWdkqICe9ovmiwrR3w3sRIGcO6sh5
 sx9Dt+pLE8ypi+XrF2W5kD+kmRANezI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-_hX7J-osNHi8fSewQC4WUw-1; Tue,
 22 Apr 2025 04:24:25 -0400
X-MC-Unique: _hX7J-osNHi8fSewQC4WUw-1
X-Mimecast-MFC-AGG-ID: _hX7J-osNHi8fSewQC4WUw_1745310263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 547341800263; Tue, 22 Apr 2025 08:24:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A3D1800872; Tue, 22 Apr 2025 08:24:19 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:24:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 02/55] i386: Introduce tdx-guest object
Message-ID: <aAdSMExEAy45NIeB@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-3-xiaoyao.li@intel.com>
 <aAIYjpetyP9LKW6L@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAIYjpetyP9LKW6L@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 18, 2025 at 05:17:02PM +0800, Zhao Liu wrote:
> >  configs/devices/i386-softmmu/default.mak |  1 +
> >  hw/i386/Kconfig                          |  5 +++
> >  qapi/qom.json                            | 15 +++++++++
> >  target/i386/kvm/meson.build              |  2 ++
> >  target/i386/kvm/tdx.c                    | 43 ++++++++++++++++++++++++
> >  target/i386/kvm/tdx.h                    | 21 ++++++++++++
> 
> SEV.* and confidential-guest.* are all placed in target/i386/.
> It's best if all of these can be in the same place.
> 
> >  6 files changed, 87 insertions(+)
> >  create mode 100644 target/i386/kvm/tdx.c
> >  create mode 100644 target/i386/kvm/tdx.h
> 
> ...
> 
> > diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> > new file mode 100644
> > index 000000000000..f3b725336161
> > --- /dev/null
> > +++ b/target/i386/kvm/tdx.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#ifndef QEMU_I386_TDX_H
> > +#define QEMU_I386_TDX_H
> 
> I386_TDX_H is enough... the QEMU prefix is rarely seen in the whole
> project.

IMHO having a QEMU_ prefix here is "best practice", so don't remove it.

That lots of other QEMU code doesn't follow best practice is unfortunate.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


