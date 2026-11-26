Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fYmRVkHb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWVeX-0007XE-TK; Thu, 26 Nov 2026 04:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVeN-0007W0-Fh
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVeL-00079A-Fc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795684816;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WpRu0/Z8aCCdPHzmyYlyuDJGeF0FO/Cs5NNSfAdXWq4=;
 b=fYmRVkHbLrrm2v3ebtxtSumetKed7YjggkU3qu2GgVx+10ApCV1nPxbkq6Vh48iZTqzES8
 2XhSxGholfYvQzPVteqDbaRzh3HUo1UmWZ0d2hswfPEZx3qG4Oo1sTlRBLyJwa3goBpM+w
 imsIU+lo4X4W5rHFis9aP9znmQsNw+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-nqYHF6FSNu6obQ527j4y3Q-1; Thu,
 26 Nov 2026 09:20:12 +0000
X-MC-Unique: nqYHF6FSNu6obQ527j4y3Q-1
X-Mimecast-MFC-AGG-ID: nqYHF6FSNu6obQ527j4y3Q_1795684811
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 249B518005BA; Thu, 26 Nov 2026 09:20:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5ADD30001BE; Thu, 26 Nov 2026 09:20:09 +0000 (UTC)
Date: Thu, 26 Nov 2026 09:20:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 07/10] iotests: fix test 162
Message-ID: <awf5xhHOrEn-4gOy@redhat.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
 <20261125191701.93931-8-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125191701.93931-8-bogorodskiy@gmail.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 25, 2026 at 08:16:57PM +0100, Roman Bogorodskiy wrote:
> Test 162 expects Linux error messages. These messages could
> be different on other OSes, on FreeBSD for example.
> Add a _normalize_errors() helper to normalize these
> error messages.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  tests/qemu-iotests/162 | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
> index 4f01611886..73a0c43e2c 100755
> --- a/tests/qemu-iotests/162
> +++ b/tests/qemu-iotests/162
> @@ -33,6 +33,12 @@ _cleanup()
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> +_normalize_errors()
> +{
> +    sed -e "s/Name does not resolve/Name or service not known/" \
> +        -e "s/Can't assign requested address/Connection refused/"
> +}

Rather than attempt to re-map OS dependent messages, I'd be more
inclined to just cull the 'strerror()' strings from the expected
output file.

>  # get standard environment, filters and checks
>  . ./common.rc
>  . ./common.filter
> @@ -45,7 +51,7 @@ echo '=== NBD ==='
>  # NBD expects all of its arguments to be strings
>  
>  # So this should not crash
> -$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
> +$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}' 2>&1 | _normalize_errors

   | sed -E 's/(address resolution failed for -1:10809).*$/\1/'

>  
>  # And this should not treat @port as if it had not been specified
>  # (We need to set up a server here, because the error message for "Connection
> @@ -78,10 +84,12 @@ echo '=== SSH ==='
>  # expected to be an integer
>  
>  # So "0" should be converted to an integer here (instead of crashing)
> -$QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}'
> +$QEMU_IMG info \
> +    'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}' 2>&1 | \
> +        _normalize_errors
>  # The same, basically (all values for --image-opts are seen as strings in qemu)
>  $QEMU_IMG info --image-opts \
> -    driver=ssh,host=localhost,port=0,path=/foo
> +    driver=ssh,host=localhost,port=0,path=/foo 2>&1 | _normalize_errors

 | sed -e 's/(Failed to connect to 'localhost:0').*$/\1/'

>  
>  # This, however, should fail because of the wrong type
>  $QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}'
> -- 
> 2.56.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


