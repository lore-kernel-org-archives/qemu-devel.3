Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAEAC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmYGx-0007sW-4V; Mon, 24 Feb 2025 08:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tmYGv-0007s1-ME
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tmYGu-00044c-3E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740402795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tsIeLMF4fzW7ay8dgEC9ffQipAGeVFxpSEZUSQzcVo=;
 b=hTRfM+Au9oMltTUHqUt7MW4O2mRuVKQ5ooabZ0vDtb5mRdSd7SbIKYI7iyg1R2fJgQd9Bt
 FgTvFIuNHIS3jMk089f9Bs1kmZ4v8k4ASDmzGfnm9h+zBMTlQw/0WzvK3bamh9LH6MLwgR
 tJOSrUk9fDOVYxO2TT+0rRbj8LQSEqs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-NoJazeGZOUeUKmHXGqc1jw-1; Mon,
 24 Feb 2025 08:13:11 -0500
X-MC-Unique: NoJazeGZOUeUKmHXGqc1jw-1
X-Mimecast-MFC-AGG-ID: NoJazeGZOUeUKmHXGqc1jw_1740402790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A42F19783B8; Mon, 24 Feb 2025 13:13:09 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64D2F1800368; Mon, 24 Feb 2025 13:13:05 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:13:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 15/16] iotests: Add qsd-migrate case
Message-ID: <Z7xwXk_pNjOWXuAF@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
 <20250204211407.381505-16-kwolf@redhat.com>
 <b74180f8-f892-450e-9327-87a47bd0a8ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74180f8-f892-450e-9327-87a47bd0a8ab@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24.02.2025 um 11:23 hat Thomas Huth geschrieben:
> On 04/02/2025 22.14, Kevin Wolf wrote:
> > Test that it's possible to migrate a VM that uses an image on shared
> > storage through qemu-storage-daemon.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Acked-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >   tests/qemu-iotests/tests/qsd-migrate     | 140 +++++++++++++++++++++++
> >   tests/qemu-iotests/tests/qsd-migrate.out |  59 ++++++++++
> >   2 files changed, 199 insertions(+)
> >   create mode 100755 tests/qemu-iotests/tests/qsd-migrate
> >   create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out
> 
>  Hi Kevin,
> 
> this test is failing for me in vmdk mode (discovered with "make check
> SPEED=thorough"):
> 
> $ ./check -vmdk qsd-migrate
> [...]
> qsd-migrate   fail       [11:20:25] [11:20:25]   0.5s                 output
> mismatch (see /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/vmdk-file-qsd-migrate/qsd-migrate.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/tests/qsd-migrate.out
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/vmdk-file-qsd-migrate/qsd-migrate.out.bad
> @@ -51,6 +51,7 @@
>  --- vm_dst log ---
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Pattern verification failed at offset 0, 4096 bytes
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 4096/4096 bytes at offset 0
> Failures: qsd-migrate
> Failed 1 of 1 iotests
> 
> Is that working for you?

No, and it can't work currently. vmdk and some other formats don't
support migration. If the image were attached directly to QEMU, the
migration block would take effect and make the migration fail.

So we should probably just change supported_fmts in the test case from
'generic' to a list of actually supported image formats. Without
checking, I'm not sure what can be enabled, but at least raw, qcow2 and
qed work.

The other option would be implementing .bdrv_co_invalidate_cache for the
currently unsupported image formats so that they actually can support
migration.

Kevin


