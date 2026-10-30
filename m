Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y+MvYiSX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkMZ-00044q-KU; Fri, 30 Oct 2026 07:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkMQ-000438-Bj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkMO-0000b0-9F
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793358083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXgfJXm1IGrrcaPVtwjB67/PAVrpq+Xws9rt2vloxX8=;
 b=Y+MvYiSXBRTGInQRjeagPawwEBeVIpRIY94Cs1IGuleME72cempn4juNzBl4LOmoBioyej
 lA60dPM59EBAMx38UFqjBlCLN5n5eI0uM1r5zPhk2nkc3YK3uH+7K41q6tmiq02BDWe9RH
 TTOI8eDKgnzjKYQYEyf+QGoPL9lW5js=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Wi2cP8tpP3mMInTZV-IV-g-1; Fri,
 30 Oct 2026 07:01:19 -0400
X-MC-Unique: Wi2cP8tpP3mMInTZV-IV-g-1
X-Mimecast-MFC-AGG-ID: Wi2cP8tpP3mMInTZV-IV-g_1793358078
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49A551956064; Fri, 30 Oct 2026 11:01:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F354B1956088; Fri, 30 Oct 2026 11:01:15 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:01:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Add --all-bitmaps option
Message-ID: <auR4-ZcQRpwKkSbW@redhat.com>
References: <20261019222205.2028202-2-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019222205.2028202-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 20.10.2026 um 00:22 hat Eric Blake geschrieben:
> When exporting bitmaps over NBD, we previously required a user to pass
> one '-B name' per bitmap, which they would have to use 'qemu-img info'
> to learn the list of names to pass.  More convenient is an option to
> export all possible bitmaps at once, as discussed here [1].
> 
> Implementation-wise, mixing --all-bitmaps and -B is harmless (grabbing
> all bitmap names already requires crawling the backing chain and
> deduplicating, so either the -B name is already detected as a
> duplicate from adding the name again, or it is an invalid name that
> will still cause a later error about bitmap not found). I also tested
> that mixing -s and --all-bitmaps still works (the temporary overlay
> image to make -s work has no bitmaps of its own, so starting the crawl
> for bitmap names at the original bs is just fine).
> 
> Also, now that parallels can have bitmaps (and not just qcow2), a
> slight doc wording change for -B is warranted.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01234.html
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: Denis V. Lunev <den@openvz.org>

Thanks, applied to the block branch.

One thing I noticed is that you check for duplicates in the new
--all-bitmaps path, but in the existing -B path, nothing ever checks if
the user specified the same bitmap twice.

It seems to work fine even with adding the same bitmap twice, so I'm not
really sure if making things consistent would mean dropping the checks
for --all-bitmaps resulting in smaller code, or adding the check for -B
resulting in less surprising state. But I think there is room for a
cleanup patch on top of this.

Kevin


