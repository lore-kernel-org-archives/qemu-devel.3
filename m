Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA363CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rWB-0004XZ-I6; Thu, 09 Oct 2025 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6rW1-0004Rb-RX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6rVv-0001XB-7Q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760019658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHpQY8d+PEEuKX7a83b8wsBL6ksB0qKRa/QDofYROvg=;
 b=Nna576lXAlkgVheFlKz7Y5wxAVcTE+Ya2B0trgVX5t4IBnRXnGT2ocBFaghQeyVU5vpR2k
 OlxzHzfZxBSXcvmj3xUnkuioeYOTN48Cap6OTlRH2vKtyzJwSo04LvWLsvXqqVmRDj1ovK
 HKRex5RWXSVzXUAg5Bp7u/kQ85Uz3z8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-bSqZPPvsMD2ZyPLTG5O3uA-1; Thu,
 09 Oct 2025 10:20:56 -0400
X-MC-Unique: bSqZPPvsMD2ZyPLTG5O3uA-1
X-Mimecast-MFC-AGG-ID: bSqZPPvsMD2ZyPLTG5O3uA_1760019655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 695CC19560B1; Thu,  9 Oct 2025 14:20:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A972018004D8; Thu,  9 Oct 2025 14:20:51 +0000 (UTC)
Date: Thu, 9 Oct 2025 16:20:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/12] tests/unit: skip test-nested-aio-poll with
 io_uring
Message-ID: <aOfEwOXrPMDI3lQN@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> test-nested-aio-poll relies on internal details of how fdmon-poll.c
> handles AioContext polling. Skip it when other fdmon implementations are
> in use.
> 
> Note that this test is only built on POSIX systems so it is safe to
> include "util/aio-posix.h".
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Maybe give a specific example of what fails with other fdmon
implementations?

Could we change the test to downgrade to fdmon-poll instead of skipping
the test entirely?

Kevin


