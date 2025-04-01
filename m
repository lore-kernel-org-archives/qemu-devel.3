Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC9FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbn1-0002se-Mq; Tue, 01 Apr 2025 09:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzbn0-0002sH-JY
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tzbmz-0005o6-1a
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743514582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MSKYI/QuJnno4ev30uAYJ8aAdNUornLUeYeD20Q4EYY=;
 b=TptCZ+Eb7Qj0du9I/53PTsjSNg+d9Dm1pMvkYaKjLR83zYqfHBIngHhE4Y7ellHWUdKryf
 ikUFUpBOHFHDG7Ub+wDvJd3dLNTrvxKt+xInQ1Z+b/dWIYZdCbPlgSkkBU9Ej6raLk482I
 +heysVjscK+ZF9762lmn5bVQKYf/4jM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-sg-JbnOENiqZIJbie8D3Wg-1; Tue,
 01 Apr 2025 09:36:19 -0400
X-MC-Unique: sg-JbnOENiqZIJbie8D3Wg-1
X-Mimecast-MFC-AGG-ID: sg-JbnOENiqZIJbie8D3Wg_1743514578
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A370E19560A1; Tue,  1 Apr 2025 13:36:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.88])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA98F180B492; Tue,  1 Apr 2025 13:36:14 +0000 (UTC)
Date: Tue, 1 Apr 2025 08:36:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2] Revert "iotests: Stop NBD server in test 162 before
 starting the next one"
Message-ID: <7t4y74r752exqwppjlcowmlkqbegpufhmcvi4wpnjjhtfoogyu@oo6hvgvvzda2>
References: <20250326143533.932899-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326143533.932899-1-thuth@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 26, 2025 at 03:35:33PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> This reverts commit e2668ba1ed44ad56f2f1653ff5f53b277d534fac.
> 
> This commit made test 162 fail occasionally with:
> 
>  162   fail      [13:06:40] [13:06:40]   0.2s   (last: 0.2s)  output mismatch
>  --- tests/qemu-iotests/162.out
>  +++ tests/qemu-iotests/scratch/qcow2-file-162/162.out.bad
>  @@ -3,6 +3,7 @@
>   === NBD ===
>   qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address
>    resolution failed for -1:10809: Name or service not known
>   image: nbd://localhost:PORT
>  +./common.rc: line 371: kill: (891116) - No such process
>   image: nbd+unix://?socket=42
> 
> The nbd server should normally terminate automatically, so trying to
> kill it here now seems to cause a race that will cause a test failure
> when the server terminated before the kill command has been executed.
> 
> The "Stop NBD server" patch has originally been written to solve another
> problem with a hanging nbd server, but since that problem has been properly
> solved by commit 3e1683485656, we now don't need the "_stop_nbd_server" here
> anymore.
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Added to the NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


