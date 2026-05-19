Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6453CD4F52
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPG1C-0000u5-Gm; Tue, 19 May 2026 04:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPG1B-0000tg-0A
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPG19-0002RP-CA
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779180093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dYQmFM12/lzjEV0iLJ+bZEnxAFR1hmYMAIQIiA4mzII=;
 b=bos8PjP6D84HhhpeQjvA9YcumTgaNA0kFnsdV8ZcuofwTwNveo3uLJjZYu+pvx+3uTw7WS
 HC6p0J/Rnk3vpHoq+FBTj0Ba/Xux2iZw++PeL8X52uEJE4TGiY/xfM/FxUSTU2h6mGsCPy
 iGkHIrtj/jACa9VXP94E11rEbwgfghc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-gE6ymQRHNY2XCg80u5LtIg-1; Tue,
 19 May 2026 04:41:31 -0400
X-MC-Unique: gE6ymQRHNY2XCg80u5LtIg-1
X-Mimecast-MFC-AGG-ID: gE6ymQRHNY2XCg80u5LtIg_1779180090
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 480C51956094; Tue, 19 May 2026 08:41:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4FDD1956053; Tue, 19 May 2026 08:41:28 +0000 (UTC)
Date: Tue, 19 May 2026 09:41:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: SignKirigami <prcups@krgm.moe>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] target/loongarch: add LVZ support for TCG
Message-ID: <agwiNNxUuvXkuft8@redhat.com>
References: <cover.1779171125.git.prcups@krgm.moe>
 <CE549524-76AA-4ACD-BA9A-89A288FECD27@krgm.moe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CE549524-76AA-4ACD-BA9A-89A288FECD27@krgm.moe>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 19, 2026 at 04:09:32PM +0800, SignKirigami wrote:
> Please disregard my previous patch series[1][2][3][4][5][6].
> This was my first time using git send-email and my provider
> messed up the threads (the cover letter also accidentally
> reused a previous Message-ID, causing it to be grouped into
> the wrong thread[7]).

FWIW, personally I can recommend using the "git-publish" tool
for sending patch series as it makes it (mostly) foolproof.

Assuming you've got your work on a branch and keep using the
same branch across multiple postings of a piece of work, then
running 'git-publish' with no arguments will "do the right
thing(tm)", includign:

 * Format a mail for every patch on that branch vs master
 * Add a cover letter automatically if there are 2+ patches
 * Use MAINTAINERS to automatically CC (mostly) the right people
 * Keep track of patch versions, incrementing after each posting
 * Remember the cover letter text across each posting
 * Send to qemu-devel by default

The only config task for git-publish is to have the global
git "sendemail.smtpserver" option set, which you'll have already
done for git send-email.

There is more guidance on submitting patches at:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches


> I sincerely apologize for the noise and confusion.

No problem.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


