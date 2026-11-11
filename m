Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD9606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O/Lfn/zb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7qJ-0004y7-V9; Wed, 11 Nov 2026 07:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7pq-0004wN-0B
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7po-00056H-1L
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794401631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28gQz4NiPvHaUVzbO45T2ApCIn+/HsD6o/R6FjfdvwM=;
 b=O/Lfn/zbZUDxea3p6xiS1CTLs6HvPkK/hQsmXG9nAZgIu2sB9FNl0mWG/h2ejrRUpjH/gZ
 rRbdOCjLXzuXkashW9636DXmvYV1gJKL52BzFLnJ+of/O4ZKq7vJO8hpIefv2U4h9l9307
 W9rSmMNK7v9Ur7vGTyIkXaJ4ttn8Zss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-HHBdr0DJPoK93pvP1VFFzw-1; Wed,
 11 Nov 2026 07:53:47 -0500
X-MC-Unique: HHBdr0DJPoK93pvP1VFFzw-1
X-Mimecast-MFC-AGG-ID: HHBdr0DJPoK93pvP1VFFzw_1794401626
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3EB01955DA6; Wed, 11 Nov 2026 12:53:45 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B16E436; Wed, 11 Nov 2026 12:53:44 +0000 (UTC)
Date: Wed, 11 Nov 2026 12:53:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 4/7] backends/hostmem-epc: Register QOM type
 unconditionally
Message-ID: <avRlVZZ5L7n1IzyD@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-5-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111122342.634370-5-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Nov 11, 2026 at 01:23:39PM +0100, Markus Armbruster wrote:
> The example from docs/system/i386/sgx.rst section "Launching a guest"
> fails for me like this:
> 
>     $ qemu-system-x86_64 -cpu host,+sgx-provisionkey -object memory-backend-epc,id=mem1,size=64M,prealloc=on -M sgx-epc.0.memdev=mem1,sgx-epc.0.node=0
>     qemu-system-x86_64: invalid object type: memory-backend-epc
> 
> Device "sgx-epc" has a link property to a "memory-backend-epc" (SgxEPC
> member memdev).  It's not optional, so we must create a
> "memory-backend-epc" to be able to create an "sgx-epc".  In the test
> shown above, "sgx-epc" exists, but "memory-backend-epc" does not.
> 
> The latter doesn't exist for me, because we register QOM type
> "memory-backend-epc" only when we can open /dev/sgx_vepc read/write,
> which fails for me.  Such conditional registration is unusual and
> problematic:
> 
> 1. Management applications use introspection interfaces to find out
> what a certain QEMU can do.  Conditional type registration makes QOM
> introspection results depend on the condition, which generally makes
> them valid only for the process that produced them.  Undesirable.
> 
> 2. For user-creatable objects like "memory-backend-epc", it also makes
> QAPI introspection unreliable: query-qmp-schema claims the type
> exists (object-add argument @qom-type accepts "memory-backend-epc")
> even when it doesn't.
> 
> Conditional registration actually serves no purpose here, because we
> still have to open /dev/sgx_vepc for real when we create the object,
> and need and do handle errors then.
> 
> Register unconditionally.  The example now fails to create the object,
> like this:
> 
>     qemu-system-x86_64: can't create 'memory-backend-epc': Could not open '/dev/sgx_vepc': No such file or directory

Bonus points - this error message is orders of magnitude
more useful to users than

  qemu-system-x86_64: invalid object type: memory-backend-epc

which makes them think their QEMU is built wrong or outdated.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/hostmem-epc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
> index e1c784249ff..bf5aecdfd45 100644
> --- a/backends/hostmem-epc.c
> +++ b/backends/hostmem-epc.c
> @@ -62,12 +62,7 @@ static const TypeInfo sgx_epc_backed_info = {
>  
>  static void register_types(void)
>  {
> -    int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
> -    if (fd >= 0) {
> -        close(fd);
> -
> -        type_register_static(&sgx_epc_backed_info);
> -    }
> +    type_register_static(&sgx_epc_backed_info);
>  }
>  
>  type_init(register_types);
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


