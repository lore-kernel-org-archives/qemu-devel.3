Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A171C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtPM-0007yi-Bx; Fri, 01 Aug 2025 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uhrzX-00070R-QR
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uhrzV-0000DU-1c
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754063295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QtjNqjSqohQk02vTWTf3xiuxAmdlFI2bUVdUvRR9nBk=;
 b=KTU52wKfziTkfGrDEJvwQaWozRkdaT3etKB40Lr0g+/AGfSZSrCVGl+g2yMfrWdQ3dSd7R
 /35HOBOHWqtu3H3oeaqJP64tHDUR60zq8u56padx/IqV7UWGRYtmLUn1D75DgndTJB86Jm
 ZgJWuQjDC8Jj1uFTyOqTYG96aknxwE0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-qDu5W3EOOdCBMKIlh3XzkQ-1; Fri,
 01 Aug 2025 11:48:13 -0400
X-MC-Unique: qDu5W3EOOdCBMKIlh3XzkQ-1
X-Mimecast-MFC-AGG-ID: qDu5W3EOOdCBMKIlh3XzkQ_1754063292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B4C819541B2; Fri,  1 Aug 2025 15:48:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B0491955E89; Fri,  1 Aug 2025 15:48:08 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:48:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Message-ID: <aIzhtcg-TNZE0zH8@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
> From: Martin Kletzander <mkletzan@redhat.com>
> 
> When running all tests the expected "killed" messages are indented
> differently than the actual ones, by three more spaces.  Change it so
> that the messages match and tests pass.

This would break the tests on my system and CI too.

What distro are you seeing this on ?

I'm guessing this is a different in either valgrind or C library ?

> 
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> ---
>  tests/qemu-iotests/039.out | 10 +++++-----
>  tests/qemu-iotests/061.out |  4 ++--
>  tests/qemu-iotests/137.out |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index e52484d4be1b..87809c534ba3 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -11,7 +11,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     [0]
>  ERROR cluster 5 refcount=0 reference=1
>  ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
> @@ -46,7 +46,7 @@ read 512/512 bytes at offset 0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     [0]
>  ERROR cluster 5 refcount=0 reference=1
>  Rebuilding refcount structure
> @@ -60,7 +60,7 @@ incompatible_features     []
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     []
>  No errors were found on the image.
>  
> @@ -79,7 +79,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     [0]
>  ERROR cluster 5 refcount=0 reference=1
>  ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
> @@ -89,7 +89,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     []
>  No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 24c33add7ce6..ae4c0d37bbbe 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -118,7 +118,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> @@ -304,7 +304,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 86377c80cde6..f3b12fbb04b0 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -35,7 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> +./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  OK: Dirty bit not set
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
> -- 
> 2.50.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


