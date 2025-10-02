Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD635CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Jy9-00070k-2i; Thu, 02 Oct 2025 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jy5-0006zd-Qm
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v4Jxr-0006nX-W5
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759414036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtf9YV9BRlgkwczkSqVAyScuQ/cWmObreww11fav380=;
 b=flSD8LK3G5joJhhstmHX5VfykJKv5hZw0y1OGfFxE+iwY7bKkmYg280nd/OHmXgyJxN0LP
 VVrUqfrIIJknv+aBXoXrUGirYwDWCe2f3LDbskM/pTjzF8115wa6WH9WpfIog27za7ZOsq
 iMjjmRtVwdqzfWkN5m3Kk2w8AJyjWKk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-fRoXnDkINPiAeNIrZQmlBQ-1; Thu,
 02 Oct 2025 10:07:15 -0400
X-MC-Unique: fRoXnDkINPiAeNIrZQmlBQ-1
X-Mimecast-MFC-AGG-ID: fRoXnDkINPiAeNIrZQmlBQ_1759414034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDADC18002C8; Thu,  2 Oct 2025 14:07:13 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.182])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F5A1300018D; Thu,  2 Oct 2025 14:07:12 +0000 (UTC)
Date: Thu, 2 Oct 2025 16:07:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/qemu-iotest: Add more image formats to the
 thorough testing
Message-ID: <aN6HDXKHBsRJD0qw@redhat.com>
References: <20250910153727.226217-1-thuth@redhat.com>
 <20250910153727.226217-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153727.226217-4-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 10.09.2025 um 17:37 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that the "check" script is a little bit smarter with providing
> a list of tests that are supported for an image format, we can also
> add more image formats that can be used for generic block layer
> testing. (Note: qcow1 and luks are not added because some tests
> there currently fail, and other formats like bochs, cloop, dmg and
> vvfat do not work with the generic tests and thus would only get
> skipped if we'd tried to add them here)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


