Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070AFFD5313
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtlP-0004QA-5E; Fri, 27 Feb 2026 04:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvtlM-0004Pg-G9
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:03:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvtlL-0003Fb-26
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772183030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eZjefatMPBYvCwo9Cfd7kfJjCYRFgC1BdsZew8uxrj4=;
 b=bcismQFd1538vU4Mi53c0it8Je4FChJkbVzhiO1jdRdUDHqlRHVdJzkZ+wjBkNeqzmjvTJ
 ipjLLFKjc1ebxqNmD2/K/TXDWf0BrrmKntehEDngeQ5Pe0LZQmhpXg2rNN8+WkEWmCrCdQ
 X7eqntXDw33oagdhRrPZTkF7Mzlzu0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-PMDbed-IPl2ywsiE4RcQ7w-1; Fri,
 27 Feb 2026 04:03:45 -0500
X-MC-Unique: PMDbed-IPl2ywsiE4RcQ7w-1
X-Mimecast-MFC-AGG-ID: PMDbed-IPl2ywsiE4RcQ7w_1772183025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0971619560A7; Fri, 27 Feb 2026 09:03:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.85])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065531800465; Fri, 27 Feb 2026 09:03:43 +0000 (UTC)
Date: Fri, 27 Feb 2026 09:03:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Choon Keong Teo <ckeong.teo17@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [HELP] Issue running test cases in Qemu
Message-ID: <aaFd7GASyxLikTTC@redhat.com>
References: <CAOkKuiOpVZwn7ZwPDPxJWmQ2SovUUTf2eLwg9dWFgEEhi3_NFw@mail.gmail.com>
 <aaFRigrJ-uiYcmUi@redhat.com>
 <CAOkKuiN_RsOQTREhAvQT2aJf0XJ4Mxk8XRK6MrXrWcoNdGhr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOkKuiN_RsOQTREhAvQT2aJf0XJ4Mxk8XRK6MrXrWcoNdGhr4w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 27, 2026 at 04:34:23PM +0800, Choon Keong Teo wrote:
> Thanks for your reply. I would like to start by focusing on the unit
> tests and qtests. Is there any method for running a single test file?
> Thank you so much for your help!

Just directly execute the binary for the test you care about in both
those cases.

For qtests you need to also set an env variable

 QTEST_QEMU_BINARY=./build/qemu-system-XXXXX

for the target you're testing.

More guidance is in docs/devel/testing/

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


