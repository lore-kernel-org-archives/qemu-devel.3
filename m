Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B3CEDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRgp-0004hG-Ve; Thu, 12 Feb 2026 03:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqRgo-0004h8-AB
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqRgm-0007px-HS
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770883479;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4H4KAuRcb/xwCExt8j0v5UOYOjw9rnY4BeRAcXPCeI=;
 b=QPwQgdyQxHFzjgLqH1j3OsEhzH6+PHPdybHflpBGY8fVwMAQsEgHtgLUDZmlcAzQ1csaqz
 qZ6wOFrXA4AarNPx0RCJmffQs2u38fbbqZ5FOqSCD84lzA3p12xVGC+3bWUyq3+Hjhop9P
 p3YEGwHCxQ8IRllpfoUeRWTDQQv+U3g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-NiLdvgC2PtODxVXTWYgxHA-1; Thu,
 12 Feb 2026 03:04:36 -0500
X-MC-Unique: NiLdvgC2PtODxVXTWYgxHA-1
X-Mimecast-MFC-AGG-ID: NiLdvgC2PtODxVXTWYgxHA_1770883475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC9DE1955D8F; Thu, 12 Feb 2026 08:04:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.206])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BF2C19560B7; Thu, 12 Feb 2026 08:04:32 +0000 (UTC)
Date: Thu, 12 Feb 2026 08:04:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs: simplify DiamondRapids CPU docs
Message-ID: <aY2JfT-1TYbPqo8Y@redhat.com>
References: <20260211180021.1057478-1-berrange@redhat.com>
 <aY07YNr9/RvKn3nF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY07YNr9/RvKn3nF@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 12, 2026 at 10:30:56AM +0800, Zhao Liu wrote:
> On Wed, Feb 11, 2026 at 06:00:21PM +0000, Daniel P. Berrangé wrote:
> > Date: Wed, 11 Feb 2026 18:00:21 +0000
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: [PATCH] docs: simplify DiamondRapids CPU docs
> > 
> > This aligns the first line of the docs with the style used for previous
> > CPU models, and simplifies the text in the remaining docs.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/system/cpu-models-x86.rst.inc | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> > index 3605d05a8c..9d4486c978 100644
> > --- a/docs/system/cpu-models-x86.rst.inc
> > +++ b/docs/system/cpu-models-x86.rst.inc
> > @@ -72,17 +72,13 @@ compatibility is required, use the newest CPU model that is compatible
> >  across all desired hosts.
> >  
> >  ``DiamondRapids``
> > -    Intel Xeon Processor.
> > +    Intel Xeon Processor (DiamondRapids, 2025)
> 
> Maybe 2026? I think the year should be the release data instead of patch
> data.

Yes, its supposed to be CPU release date.

> 
> > -    Diamond Rapids product has a topology which differs from previous Xeon
> > -    products. It does not support SMT, but instead features a dual core
> > -    module (DCM) architecture. It also has core building blocks (CBB - die
> > -    level in CPU topology). The cache hierarchy is organized as follows:
> > -    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> > -    CBB. This cache topology can be emulated for DiamondRapids CPU model
> > -    using the smp-cache configuration as shown below:
> > -
> > -    Example:
> > +    This does not include SMT but allows the module (dual core module
> > +    - DCM) and die (core building block - CBB) topology levels. The
> > +    cache hierarchy is L1 i/d cache per thread, L2 cache per module,
> > +    and L3 cache per die, which can be emulated using the smp-cache
> > +    option:
> 
> Otherwise, look good to me, and thanks!
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Regards,
> Zhao
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


