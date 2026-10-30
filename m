Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17048606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+SzCbY8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkU7-0006AE-Iv; Fri, 30 Oct 2026 07:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkU3-00069L-Oz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkU2-0001aR-8B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793358557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UsGqqy+GOUUC87KFMnOYKbX9GI3WsDaJiGexWBcZXc4=;
 b=F+SzCbY8KNnFgXtSWiYdTr6MldgmwoE/7L4F2MSDizz+Bo3JArOMsNa8q2xsI0TDXMq7Pp
 9uoUWFgFQakoqzKPGoqLEK2kO1Xgj5VWvh0hXWT3kHXN9+R2KdK+TbalS8+sBXLDXkVDIE
 KoSIDAA0rB3O9bwbWjOHfJQXyOtKLOo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-d8kfCAkVPzePA1Z6ThdeBw-1; Fri,
 30 Oct 2026 07:09:07 -0400
X-MC-Unique: d8kfCAkVPzePA1Z6ThdeBw-1
X-Mimecast-MFC-AGG-ID: d8kfCAkVPzePA1Z6ThdeBw_1793358546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 489301800366; Fri, 30 Oct 2026 11:09:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2A2218004D2; Fri, 30 Oct 2026 11:09:04 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:09:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests/108: probe loop device setup
Message-ID: <auR6zsGQ0ahG9Mn3@redhat.com>
References: <20261013182804.103882-1-iii@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013182804.103882-1-iii@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.10.2026 um 20:28 hat Ilya Leoshkevich geschrieben:
> Running iotests/108 in a Docker container, that has passwordless sudo
> configured, fails with:
> 
>     losetup: /home/user/src/qemu/build/scratch/qcow2-file-108/t.qcow2: failed to set up loop device: No such file or directory
> 
> because it incorrectly assumes losetup is allowed to do loop device
> setup, when in reality it can only list devices.
> 
> Fix by probing loop device setup, using the test script as a backing
> file. With this, the test is correctly skipped.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Won't loop-create-file and fuse-truncate need the same fix?

Maybe we could have a _require_losetup() helper function in common.rc
for the shell-based tests? (Only two at the moment, though I also have a
patch on the list that would add a third one.)

Kevin


