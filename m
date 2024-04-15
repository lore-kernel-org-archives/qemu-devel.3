Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B901BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwN8t-00009g-EX; Mon, 15 Apr 2024 10:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rwN8r-00009Q-2p
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rwN8m-0003DU-9o
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713190618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxcol1la9PzcZ/kgyAmMidRTLlKJKG+qZ5HbAazhlRk=;
 b=fT/Sd2op8jBo0OOBfL62mWeBk1SzMs6GUWpWXX6kOio5OQEN3qYCgpYChkBW1N9efvJr0C
 IQVwKq25V9TZj1oIwYTeYaqBPpyPTyL0DRRdJ4lBoB+ZToO12q6NDdNCdxgcGSum2henof
 QAEGvFg8szlLxfoRlJhw/egptED93S4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-UoOTM04wOSC44d4u9FN5_g-1; Mon,
 15 Apr 2024 10:16:54 -0400
X-MC-Unique: UoOTM04wOSC44d4u9FN5_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1E53C0F441;
 Mon, 15 Apr 2024 14:16:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03F131BDAA;
 Mon, 15 Apr 2024 14:16:51 +0000 (UTC)
Date: Mon, 15 Apr 2024 09:16:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Lieven <pl@dlhnet.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: MAINTAINERS tweak [was: [PATCH for-9.1 0/9] Switch to glib URI
 parsing code]
Message-ID: <vd2bfo3hvalu77sutxo7h3qjesagau6rugao4v6qala4rbn4xz@mn5wzjniftg3>
References: <20240328140607.2433889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140607.2433889-1-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[Trying Peter Lieven's alternate address...]

On Thu, Mar 28, 2024 at 03:05:57PM +0100, Thomas Huth wrote:
> In the QEMU 9.1 development cycle, we can drop the support for
> Ubuntu 20.04 and CentOS 8 since the following major versions of
> these distributions are available since 2 years already.

Every time I've replied to any message in this thread, I've gotten a
response:

| +Your message to pl@kamp.de couldn't be delivered.
| kamp.de couldn't confirm that your message was sent from a trusted location.
| eblake  Office 365      pl
| Action Required                 Recipient
| SPF validation error
| 
| How to Fix It
| Your organization's email admin will have to diagnose and fix your domain's email settings. Please forward this message to your
| +email admin.
| 
| ________________________________
| 
| More Info for Email Admins
| Status code: 550 5.7.23
| 
| This error occurs when Sender Policy Framework (SPF) validation for the sender's domain fails. If you're the sender's email
| +admin, make sure the SPF records for your domain at your domain registrar are set up correctly. Office 365 supports only one
| +SPF record (a TXT record that defines SPF) for your domain. Include the following domain name: spf.protection.outlook.com. If
| +you have a hybrid configuration (some mailboxes in the cloud, and some mailboxes on premises) or if you're an Exchange Online
| +Protection standalone customer, add the outbound IP address of your on-premises servers to the TXT record.

Red Hat IT says that it is unlikely to be Red Hat's SPF settings, and
suspects that it is instead something caused by whatever Peter is
using to bounce mail from his alias Peter Lieven <pl@kamp.de> to his
Office 365 account.  As I appear to be unable to contact Peter (even
my use of direct email, bypassing the list, and using a personal
account instead of my Red Hat email) about this issue, I'm wondering
if Peter is still an active contributor to the project.

But while typing this email, to see if RBD, iSCSI, and NFS need a new
entry in MAINTAINERS, I did a search through the list archives, where
the last email I found from Peter was
https://lists.gnu.org/archive/html/qemu-devel/2023-01/msg00574.html,
which asked to update MAINTAINERS to his new address, and that has not
made it in so far...

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


