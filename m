Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hSKgeZHq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQV2L-0004w0-W6; Mon, 09 Nov 2026 14:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQV2G-0004sA-6Y
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQV2E-0000zV-HX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794252485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uikcY1Qs1f3Y/k4WZUgBYeTi3DF6mKuPyJVczaojFjU=;
 b=hSKgeZHqSRt2Y8GphNzO4BShwDBtyNza8jyiN2Ppb4UegZDMqcLi86F2+zBbVrpvHmMhLW
 AlKDLU7e5GAkn7ghgGQP62x9xZeHQ3p1t928XWzuqJaLENQmIsCIqlRenLbt1vOz7hir7/
 RNbYJT3nMcuFl5wyYptYGZshVA92eQQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-tVNHmQ9jNn2S1M3n-ffccQ-1; Mon,
 09 Nov 2026 14:28:01 -0500
X-MC-Unique: tVNHmQ9jNn2S1M3n-ffccQ-1
X-Mimecast-MFC-AGG-ID: tVNHmQ9jNn2S1M3n-ffccQ_1794252480
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6A5118005BF; Mon,  9 Nov 2026 19:27:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C8DB30001A2; Mon,  9 Nov 2026 19:27:57 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:27:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] build: Add "-d keeprsp" to Ninja flags
Message-ID: <avIeunGVydLiZ9O8@redhat.com>
References: <20261109183605.3210043-1-jsnow@redhat.com>
 <20261109183605.3210043-4-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109183605.3210043-4-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 01:36:05PM -0500, John Snow wrote:
> When auditing compilation, it is helpful to be able to see all of the
> object files passed during the linking step, which ninja can obscure
> behind temporary .rsp "response files". Normally, these are deleted
> immediately afterwards - but for debugging purposes, it is helpful to
> leave them behind to understand what went wrong.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/Makefile b/Makefile
> index 54547a37b1a..9dda1b3c89a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -151,7 +151,7 @@ NINJAFLAGS = \
>          $(filter-out -j, \
>            $(or $(filter -l% -j%, $(MAKEFLAGS)), \
>                 $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1))) \
> -        -d keepdepfile
> +        -d keepdepfile $(if $(DEBUG),-d keeprsp)
>  ninja-cmd-goals += $(or $(MAKECMDGOALS), all)
>  ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))

Alternatively we hardcode our makefile to raise meson's
annoyingly pessimistic defaults

  export MESON_RSP_THRESHOLD=126976

provided we detect we're not running a build inside Wine, or just
blindly assume no one is quite that crazy :-)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


