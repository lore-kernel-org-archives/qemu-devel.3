Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4057D41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTd1e-00048B-2m; Thu, 11 Dec 2025 04:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTd1c-00047h-E2
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTd1a-0003VO-2L
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765445507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zNECEns/9LezG5SzZPgSICvGc6eGD54YvF/KTVWKT4=;
 b=i4UnwPCXOCr1/VE5Nf967j4h+GGqv0sai2hihfTJzuZf+n2qWcUgITFYtRF2HBugK0df9r
 QYTJ7qPh9ScvsIsiHFNoq7/QxUISDn8KTOFTb9iFIM9oIcNdU8q76iuk4NwvYDWjxSBasC
 eO3HyvjFu5SiM1fNGre1IO/Nz9sT9Lo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-gIpm0hWkPqWZGLO1hl0V9w-1; Thu,
 11 Dec 2025 04:31:43 -0500
X-MC-Unique: gIpm0hWkPqWZGLO1hl0V9w-1
X-Mimecast-MFC-AGG-ID: gIpm0hWkPqWZGLO1hl0V9w_1765445502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C13A180057E; Thu, 11 Dec 2025 09:31:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AAB130001A2; Thu, 11 Dec 2025 09:31:39 +0000 (UTC)
Date: Thu, 11 Dec 2025 09:31:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Vishnu Pajjuri OS <vishnu@os.amperecomputing.com>,
 Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
Subject: Re: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing
 making communication unreliable
Message-ID: <aTqPeGHQBhmyFxXF@redhat.com>
References: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
 <20251209022028-mutt-send-email-mst@kernel.org>
 <aTfpQO14axEvcOIT@redhat.com>
 <CAJ7pxeYbd+yq9VXob2zTShBd5Ph598kmjLJTsKdKzFikCbVLLA@mail.gmail.com>
 <aTmlzlAWK8BcGaEp@redhat.com>
 <CAJ7pxebQnOYkMyFUwucn+VL-xasJ559SjcONtAYw+NvfZkd-fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ7pxebQnOYkMyFUwucn+VL-xasJ559SjcONtAYw+NvfZkd-fQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUBJ_ATTENTION=0.5 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 10, 2025 at 05:58:40PM +0000, Salil Mehta wrote:
> Hi Daniel,
> 
> Many thanks for your reply.
> 
> On Wed, Dec 10, 2025 at 4:54 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 01:20:26AM +0000, Salil Mehta wrote:
> > > If there are SPF/DKIM/DMARC logs on the list side, would it be
> > > possible to see whether DKIM validation is failing for my messages?
> >
> > We have no access to anything in the mailman service - we're just
> > using the nongnu.org service for QEMU, run by the GNU project.
> 
> Understood, thanks for clarifying.
> 
> If you happen to know who maintains the nongnu.org Mailman service,
> or where I should direct questions about mail logs and DMARC handling,
> a pointer would be very helpful.

I'm afraid I don't know any contact there, but someone else on
CC might.


> I am following up with our IT/mail team about DKIM and the correct
> SMTP relay configuration for mailing lists. If it is easy to see
> from the list side whether my recent missing patch mails were
> rejected or filtered due to SPF/DMARC (as opposed to never
> arriving at all), that information would be very helpful for that
> discussion.

FWIW, when I first investigated DMARC/DKIM/SPF in the context of
mailing lists years ago, the following blog was a good explainer
to refer people to:

  https://begriffs.com/posts/2018-09-18-dmarc-mailing-list.html

TL;DR: if DMARC is used by a sender's domain, then the best
situation is for the sender domain to have DMARC + DKIM enabled,
AND for mailing lists to NOT modify the message text, nor any of
the headers covered by DKIM.

We believe qemu-devel does the latter part correctly, as we
turned off modification of the Subject header, and stopped
appending a footer to the message text.

Unfortunately I don't know any way to trace the cause of your
problems without info from the mail system logs on the mailing
list server, which only the sysadmins have access to :-(

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


