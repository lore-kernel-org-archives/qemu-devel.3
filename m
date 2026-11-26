Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E70606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fEI7e0JK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWVpN-0004TE-B3; Thu, 26 Nov 2026 04:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVpH-0004QO-VE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVpE-0005J4-LP
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795685491;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=celS4QWUyuqsbVM8Exezq6Du/0A6Als9BrIiHQX72Yc=;
 b=fEI7e0JKNtVzhnOdTM+dvsHPtlrHBCMQ28WhEA3NMN/ffyFb1c1r3FOlTY4GVuEj8eGPiJ
 7KVBhCYuxSOKrbrm363nL9+lnX9iUmZpaB+h54RS30jMvgCPCcaq/7ViFYPmNCBDxtWteB
 9uGEmfIleuctt/71wZ/bazuygNy7yxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-cB87N5IOMsCjrm2eSoGdhg-1; Thu,
 26 Nov 2026 09:31:27 +0000
X-MC-Unique: cB87N5IOMsCjrm2eSoGdhg-1
X-Mimecast-MFC-AGG-ID: cB87N5IOMsCjrm2eSoGdhg_1795685487
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0790180044D; Thu, 26 Nov 2026 09:31:26 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DBD51956087; Thu, 26 Nov 2026 09:31:24 +0000 (UTC)
Date: Thu, 26 Nov 2026 09:31:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 01/10] iotests: use gsed when necessary
Message-ID: <awf8atJJ3A_8caLc@redhat.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
 <20261125191701.93931-2-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125191701.93931-2-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, Nov 25, 2026 at 08:16:51PM +0100, Roman Bogorodskiy wrote:
> Some iotests fail on FreeBSD because the tests call sed
> directly, and BSD sed is not always compatible with GNU sed.
> As common.rc already provides the gsed() wrapper, use it
> instead if needed.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  tests/qemu-iotests/115           | 2 +-
>  tests/qemu-iotests/common.filter | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)


We use plain 'sed' across countless test files, and only call
'gsed' in one test file and common.filter. It feels like a
loosing battle to keep fixing things to use gsed when they
hit an incompatibility.

How about we rename the 'gsed()' wrapper function to simply
'sed()', and thus make GNU sed a mandatory dependency for
all tests.


> 
> diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
> index 5c8a12f85a..e3ff91de7a 100755
> --- a/tests/qemu-iotests/115
> +++ b/tests/qemu-iotests/115
> @@ -78,7 +78,7 @@ _make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256
>  # qemu-img check for that purpose, too.
>  
>  $QEMU_IMG check "$TEST_IMG" | \
> -    sed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
> +    gsed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
>          -e '/^Image end offset/d'
>  
>  # (Note that we cannot use _check_test_img because that function filters out the
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index ce4213cb97..f7211a0a29 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -130,7 +130,7 @@ _filter_actual_image_size()
>  # Filename filters for qemu-img create
>  _filter_img_create_filenames()
>  {
> -    sed \
> +    gsed \
>          -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
> @@ -296,7 +296,7 @@ _filter_qemu_img_map()
>          data_file_filter=(-e "s#$data_file_pattern#\\1#")
>      fi
>  
> -    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
> +    gsed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>          -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
>          -e 's/Mapped to *//' \
>          "${data_file_filter[@]}" \
> @@ -310,7 +310,7 @@ _filter_nbd()
>      # receive callbacks sometimes, making them unreliable.
>      #
>      # Filter out the TCP port number since this changes between runs.
> -    sed -e '/nbd\/.*\.c:/d' \
> +    gsed -e '/nbd\/.*\.c:/d' \
>          -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
>          -e 's#localhost:[0-9]*#localhost:PORT#g' \
>          -e 's#host=127\.0\.0\.1,port=[0-9]*#host=127.0.0.1,port=PORT#g' \
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


