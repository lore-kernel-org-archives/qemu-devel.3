Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3049E10A62C1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kAT-00018S-Vg; Thu, 26 Mar 2026 08:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w5kAR-00017v-US
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w5kAQ-0003Qu-Hj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774529429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbjUqL6GqDk5msE4RzJz0CxKgq6X5Uct3bzJSZajMO4=;
 b=K4oWBj24fWlpPw7ejvtj8Ux5t+bRchwKFX/7ryCuLWeXO4WLQcbojOUAiA1FxjYn4p9ZUJ
 5doXDlV7tHxdaMDhRHCP298Yu+jhbnH7kVK2bW9HAe9mRFlj1dmpBNaw386XtJ5LzWnI9X
 FckWawh7X96F+vorxTBn5FiNrUcf/oo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-J48L9_uLNNSATjNzSkVkFw-1; Thu,
 26 Mar 2026 08:50:26 -0400
X-MC-Unique: J48L9_uLNNSATjNzSkVkFw-1
X-Mimecast-MFC-AGG-ID: J48L9_uLNNSATjNzSkVkFw_1774529425
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3472919560B9; Thu, 26 Mar 2026 12:50:24 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 131F91955D84; Thu, 26 Mar 2026 12:50:20 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:50:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PULL 0/4] Block layer patches
Message-ID: <acUripAsWiW-YOR9@redhat.com>
References: <20260324185619.296946-1-kwolf@redhat.com>
 <db795759-2751-4321-9315-c6840be7d030@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db795759-2751-4321-9315-c6840be7d030@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 26.03.2026 um 06:02 hat Michael Tokarev geschrieben:
> On 24.03.2026 21:56, Kevin Wolf wrote:
> 
> > ----------------------------------------------------------------
> > Block layer patches
> > 
> > - linux-aio/io-uring: Resubmit tails of short reads/writes
> > - curl: Fix memory leak
> > 
> > ----------------------------------------------------------------
> > GuoHan Zhao (1):
> >        block/curl: free s->password in cleanup paths
> > 
> > Hanna Czenczek (3):
> >        linux-aio: Put all parameters into qemu_laiocb
> >        linux-aio: Resubmit tails of short reads/writes
> >        io-uring: Resubmit tails of short writes
> 
> Shouldn't all of this pull req be picked up for the stable series?

I don't think any of these are very critical, but they are fixes (as
should be everything merged during freeze) and have existed in previous
releases, so yes, in that sense they are certainly suitable for stable.

Kevin


