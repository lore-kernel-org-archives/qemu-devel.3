Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C204DE68151
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHOx-000541-8Y; Tue, 17 Feb 2026 04:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vsHOw-00053r-Bb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vsHOu-0000QB-Ir
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771320586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWnLOumvXChJ8qUwuFTOLRbhAQhlQonilJRGS/PF7Dk=;
 b=NWr/fhn/WUmUtQ8qRQEIqNxLxrAu9wMUO3LnW4jpaz1TglDiSAvYSsH4HDsHViZXHn9PVB
 n/5Un1c9ibKJEtZ4fWGqsoU7t80SZ5R//NAu7xki0rb0d9zFn+LAu1u/p8vOhfrBnce1fb
 AaAHAnB11TIah4BKxZQx8JZhQS10RAs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-9O8-kSYvMhmr2zw6RwI1-g-1; Tue,
 17 Feb 2026 04:29:45 -0500
X-MC-Unique: 9O8-kSYvMhmr2zw6RwI1-g-1
X-Mimecast-MFC-AGG-ID: 9O8-kSYvMhmr2zw6RwI1-g_1771320584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04DCA19560A7; Tue, 17 Feb 2026 09:29:44 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.34.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 118071800351; Tue, 17 Feb 2026 09:29:41 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:29:38 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZQ0q2r6w3OkSP2f@angien.pipo.sk>
References: <20260115225503.3083355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115225503.3083355-1-peterx@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
> v2:
> - Added R-bs
> - Updated description for removing zero-blocks [Markus]
> - Squashed the "fd: to file" test removal into the 2nd patch
> - I dropped the COLO patch, I have a local patch to remove colo migration
>   completely, but looks like we won't do it..  Let's leave it for later but
>   do the rest first
> 
> This series removes two deprecated features for 11.0.
> 
> Please review, thanks.
> 
> Peter Xu (2):
>   migration: Remove zero-blocks capability
>   migration: Remove fd: support on files
> 
>  docs/about/deprecated.rst             | 20 -------------

Note that per the 'MAINTAINERS' file, changes to any deprecations ought
to be CC'd to the libvirt list for visibility.

In this case we've forgotten about the deprecation and didn't fix it
before the qemu cahnge was pushed. I'll send out patches soon, but keep
in mind to *always* CC the libvirt list with deprecations.


