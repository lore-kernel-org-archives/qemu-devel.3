Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA81606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EZUE0Yqg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQ2a-0001wB-VX; Fri, 06 Nov 2026 14:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPQ2T-0001vr-98
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPQ2P-0004Be-ID
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793994946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6EHVb7lmEwNMf80CqTdj4Xrwvg25UmOAADQ3QejOT8=;
 b=EZUE0YqgcF6w6+uE7IROs/yoS1QglNwFXghZNX5p/+6AgaYxhUr5QIM0Uu9r1SuSmq7FpA
 YvlgHGaccXsDZxx/vIJyasrn7mB++k/OKhQLHIsNemnn5GWvMoJhuzdag4Y5Z8gf7u+ROa
 i905p98YJ88MpXSaVDPPrtgP3cPvI0w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-FeAzVVqNP7SD1h1pcgiXdQ-1; Fri,
 06 Nov 2026 14:55:45 -0500
X-MC-Unique: FeAzVVqNP7SD1h1pcgiXdQ-1
X-Mimecast-MFC-AGG-ID: FeAzVVqNP7SD1h1pcgiXdQ_1793994944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D336E180059B; Fri,  6 Nov 2026 19:55:43 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 118591955F19; Fri,  6 Nov 2026 19:55:41 +0000 (UTC)
Date: Fri, 6 Nov 2026 13:55:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 for-11.2] docs/devel/testing: iotests check script
 should be run via 'run'
Message-ID: <au4uyq1cntUoa7oO@redhat.com>
References: <20261106170158.3858169-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106170158.3858169-1-peter.maydell@linaro.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 05:01:57PM +0000, Peter Maydell wrote:
> The iotests section of the testing documentation suggests directly
> running the "./check" script.  However if you do this then the
> script complains:
> 
> WARNING: iotests is being run from outside of the configure-time python virtual environment
> [...]
> Please use the meson run script:
>         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check

Huh. I did a git checkout, mkdir build, cd build && ../configure, then:

$ build/run tests/qemu-iotests/check 5

WARNING: iotests is being run from outside of the configure-time python virtual environment

current python: /home/eblake/qemu/build/pyvenv/bin/python3
pyvenv python:  /home/pyvenv/bin/python3
...

but running directly from the configured directory:

$ cd build
$ ./run tets/qemu-iotests/check 5

does what this patch recommends.

> 
> Update the documentation to match this.  While we are here,
> standardize on "run from the root of the build tree", which is how we
> generally document running things under "run" (e.g.  the functional
> tests), since the iotests don't have a dependency on their current
> working directory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: Use "./run ./tests-qemu-iotests/check", for consistency

Typo in the notes - but those don't make it into git, so that one is
irrelevant.

> +++ b/docs/devel/testing/main.rst
> @@ -271,9 +271,13 @@ than "make check" tests and 99% of the code is written in bash or Python
>  scripts.  The testing success criteria is golden output comparison, and the
>  test files are named with numbers.
>  
> -To run iotests, make sure QEMU is built successfully, then switch to the
> -``tests/qemu-iotests`` directory under the build directory, and run ``./check``
> -with desired arguments from there.
> +To run iotests, make sure QEMU is built successfully, then switch to
> +the build tree and run the ``tests/qemu-iotests/check`` script via the
> +``run`` wrapper which sets up the environment:
> +
> +.. code::
> +
> +   ./run ./tests/qemu-iotests/check [args]
>  
>  By default, "raw" format and "file" protocol is used; all tests will be
>  executed, except the unsupported ones. You can override the format and protocol
> @@ -282,22 +286,22 @@ with arguments:
>  .. code::
>  
>    # test with qcow2 format
> -  ./check -qcow2
> +  ./run ./tests/qemu-iotests/check -qcow2
>    # or test a different protocol
> -  ./check -nbd
> +  .run ./tests/qemu-iotests/check -nbd

"./run", not ".run".

With that typo fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

Technically, "tests/qemu-iotests" and "./tests/qemu-iotests" will have
the same behavior to ./run, but while your variant is slightly longer
to type, I don't see a problem in spelling it that way.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


