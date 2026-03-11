Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01265104951C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0G4f-0001Ec-Vu; Wed, 11 Mar 2026 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0G4e-0001EU-Li
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0G4W-0004WI-D0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773222103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSan74KEyl6KEfaXzxhiR1mv1JlLuRA7008o5bHBM3Y=;
 b=CCFgqSRqzcJfDOf2hLsrIn6bulJ/JCVVMjhiXDJazNAAC0gC61DNl/5r/21ItoIFUJ/qld
 Z34SggnSW3hUbD8mSwiqhhYqvv5gr6vjcvoIYCRpgopyj8yi0bI8IjokJioJLQhqa+jaeg
 uvj3AqkQ2+XJUip0p+y+trd13UBWCG4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-LxFPAlEIN5Cn4npR7emuhQ-1; Wed,
 11 Mar 2026 05:41:40 -0400
X-MC-Unique: LxFPAlEIN5Cn4npR7emuhQ-1
X-Mimecast-MFC-AGG-ID: LxFPAlEIN5Cn4npR7emuhQ_1773222099
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B88195608F; Wed, 11 Mar 2026 09:41:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.160])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 203C5180075F; Wed, 11 Mar 2026 09:41:35 +0000 (UTC)
Date: Wed, 11 Mar 2026 09:41:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Nia Alarie <nia@netbsd.org>
Subject: Re: [PATCH] meson.build: Bump the minimum GCC version to v10.4
Message-ID: <abE4zGr6hSXo6lio@redhat.com>
References: <20260310155331.320066-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310155331.320066-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 04:53:31PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Our minimum supported version of GCC used to be v7.4 since we still
> wanted to support NetBSD 9.x in the past:
> 
>  https://gitlab.com/qemu-project/qemu/-/issues/614
>  https://gitlab.com/qemu-project/qemu/-/commit/3830df5f83b9b52d949676
> 
> However, NetBSD 10 has already been released since two years ago
> (see https://www.netbsd.org/releases/formal-10/NetBSD-10.0.html),
> so according to our support policy, starting with QEMU v11.0, we
> don't have to take care of the previous major release of NetBSD
> anymore.
> 
> Looking at the various distros that we take care of (see e.g.
> https://repology.org/project/gcc/versions), and the NetBSD 10.0
> 3rd party package information:
> 
>  https://cvsweb.netbsd.org/bsdweb.cgi/src/doc/3RDPARTY?rev=1.1905.2.14;content-type=text%2Fplain;only_with_tag=netbsd-10-0-RELEASE
> 
> ... it seems like NetBSD 10 has the lowest version of GCC again,
> but at least it's GCC 10.4 now. Thus bump our GCC requirement to
> this version now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


AFAICT,  GCC 10.4  ships with gnu17 as its default C standard.

CLang 10.x also seems to support gnu17.

So separate from this patch, we could likely bump our C stndard
from gnu11 to gnu17. Though C17 doesn't seem to have any big
ticket items that help us compared  C11, it makes sense to
track the newer standard versions as they become available to
us.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


