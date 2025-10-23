Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB51CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzSb-0006KI-4W; Thu, 23 Oct 2025 13:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzSW-0006JA-4e
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzSQ-00036o-78
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761241834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2Xy/+J4MGKi6ph6WZINudEs0IEPjiru4uhOqqrvWTY=;
 b=EEFojARAlNWULWF7oCc1v2rvjS/NaLHmSDx53v1q2V3a6ZFUWmRLz0tGaBrqtnJUGJpEt/
 ylL79M2lGWwkOlNCQofcztBtN/v8vfNfpolJpL5UH4uZXxOBAyTn9T931QyW1EElKmQoDo
 06gXQJ8oLMsEjtffomypTjDFBE3ZY7M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-XjyowSRgNQ2Ec_VEFLAImA-1; Thu,
 23 Oct 2025 13:50:32 -0400
X-MC-Unique: XjyowSRgNQ2Ec_VEFLAImA-1
X-Mimecast-MFC-AGG-ID: XjyowSRgNQ2Ec_VEFLAImA_1761241831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C8841956096; Thu, 23 Oct 2025 17:50:31 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F9EB30002DB; Thu, 23 Oct 2025 17:50:29 +0000 (UTC)
Date: Thu, 23 Oct 2025 19:50:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests: Adjust fuse-allow-other expected output
Message-ID: <aPpq4kpo9q1lDd4x@redhat.com>
References: <20251021205843.2585624-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021205843.2585624-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 21.10.2025 um 22:58 hat Eric Blake geschrieben:
> The iotest fuse-allow-other has been broken since commit effd60c8 in
> v9.0.0; but as Dan Berrange's efforts to improve CI have proven, we
> haven't been reliably running it to notice.  The change in that commit
> was good (moving coroutine commands to run in the right context), but
> it meant that "execute":"quit" now waits to complete until the
> coroutines tearing down fuse have first reported the SHUTDOWN event,
> in the opposite order of what happened pre-patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context",
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin


