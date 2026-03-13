Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B0A105F79C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10vY-0000G0-MR; Fri, 13 Mar 2026 07:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w10vU-0000Fg-IQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w10vR-00055M-Lw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773402207;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUG4BVd9CB+lNmY+V+OJiP0LhFcE/LtL/7Ib1xDR0o8=;
 b=McKCD57bJGAfz3s/rIBXlBNRedFJw9AljYWtOaHGPP+dq6IgpBOadJ0XVaYD1uiodaqoQi
 MyEMpoiaJ1glwMpDdLL6FBs+Z3D7KJiwngH3OdCAi5jcP0lVYMrUhaVIkMGKSeVYHmZXgk
 1EU63n2dCsKcAChVfVEW1S1YdZRTCPU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-C07Mow1RP6y1HlxYqqn_mw-1; Fri,
 13 Mar 2026 07:43:26 -0400
X-MC-Unique: C07Mow1RP6y1HlxYqqn_mw-1
X-Mimecast-MFC-AGG-ID: C07Mow1RP6y1HlxYqqn_mw_1773402204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC3BF197703F; Fri, 13 Mar 2026 11:42:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47FAC18002A6; Fri, 13 Mar 2026 11:42:52 +0000 (UTC)
Date: Fri, 13 Mar 2026 11:42:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 4/4] MAINTAINERS: Downgrade the functional testing
 section to "Odd Fixes"
Message-ID: <abP4OfQX5n1erZne@redhat.com>
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313113424.15583-5-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Fri, Mar 13, 2026 at 12:34:22PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I won't have that much time for QEMU anymore in the future, so downgrade
> the status of the "functional testing framework" section to "Odd Fixes"
> to avoid wrong expectations. While we're at it, also switch to my other
> e-mail address here that I'm already using for the other sections where
> I am still listed as maintainer / reviewer.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


FYI, this section only applies to the core framework itself. The
individual test files are all distributed across the arch target
maintainers.

I was in two minds as to whether to declare myself a replacement
maintainer for Thomas. I'll try to collect & review any patches
to the core framework in the absence of anyone else wanting to
step up, but I didn't want to guarantee I'd be able to spend
regular time on it as a formal maintainer assignment.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c7dfab39d3..18e4223de1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4514,10 +4514,10 @@ F: tests/vm/freebsd
>  W: https://cirrus-ci.com/github/qemu/qemu
>  
>  Functional testing framework
> -M: Thomas Huth <thuth@redhat.com>
> +M: Thomas Huth <th.huth+qemu@posteo.eu>
>  R: Philippe Mathieu-Daudé <philmd@linaro.org>
>  R: Daniel P. Berrange <berrange@redhat.com>
> -S: Maintained
> +S: Odd Fixes
>  F: docs/devel/testing/functional.rst
>  F: scripts/clean_functional_cache.py
>  F: tests/functional/meson.build
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


