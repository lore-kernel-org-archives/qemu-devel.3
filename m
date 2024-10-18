Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E127AD30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n7U-0004ne-Ok; Fri, 18 Oct 2024 09:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1n7R-0004mD-7t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1n7O-0000IJ-PQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io+ggkxIPwCoOF52BTebbnwKuui9DQCBbc3iCviBYag=;
 b=EcOfKFiB/TbsKfaJnVNkRbrKnaKvObfFg8PMgkLw5RWruFplVoR7qNqkOJaS185fSCG8K0
 bNjAHwbgMOa1ODkTFBadgrPelhLlgqAc7dXaH+/Eweau6aYmFtKyw69J0ojTL1NwX8HUD/
 RFjxICax+PeTvisixR+5uWXEhotH4tg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9UOrbd1aOAW7-_8DrWFESA-1; Fri,
 18 Oct 2024 09:34:10 -0400
X-MC-Unique: 9UOrbd1aOAW7-_8DrWFESA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00FDB1955D9D; Fri, 18 Oct 2024 13:34:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B13619560A3; Fri, 18 Oct 2024 13:34:06 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:34:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 31/31] system: remove unused qerror.h header
Message-ID: <ZxJjy84YC2xgkZpS@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-32-berrange@redhat.com>
 <ZxI1q0ucLSSo0Ijc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxI1q0ucLSSo0Ijc@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 18, 2024 at 06:17:15PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> On Thu, Oct 17, 2024 at 12:33:43PM +0100, Daniel P. Berrangé wrote:
> > Date: Thu, 17 Oct 2024 12:33:43 +0100
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: [PATCH v2 31/31] system: remove unused qerror.h header
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  system/rtc.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/system/rtc.c b/system/rtc.c
> > index e3bc2095f9..216d2aee3a 100644
> > --- a/system/rtc.c
> > +++ b/system/rtc.c
> > @@ -25,7 +25,6 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> >  #include "qapi/error.h"
> > -#include "qapi/qmp/qerror.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/option.h"
> >  #include "qemu/timer.h"
> > -- 
> > 2.46.0
> > 
> 
> Ah, this qerror.h is added by patch 23 accidentally.

Doh, fixing my own mistake :-)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


