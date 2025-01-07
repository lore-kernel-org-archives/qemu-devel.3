Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFE4E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9BJ-0003Ak-2j; Tue, 07 Jan 2025 07:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tV9BG-00038X-Oq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tV9BE-0005sD-UJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736254771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xw8EKJF7rOh7cbcukS5ZR0Gloqp7Xv8oV0bwJfrIZnw=;
 b=Nflb6CTBiqSUi7aLji4Rf2r8MEX0tuu0ijghZjOhXwUgWwaKZIS2UfH2/8FD2ZaSKmlGK9
 9rfjL5IJmFhqTxj/opw63OiCHEfY2eqqZZXqOr8rQvPISB7tXWoN+TR19b7uvCTDQ+F3SJ
 LUUZDiVsMfsR8ZGfC1NWQydJiztGLsw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-xOG0e_d6ORCbDUOBDGPhww-1; Tue,
 07 Jan 2025 07:59:28 -0500
X-MC-Unique: xOG0e_d6ORCbDUOBDGPhww-1
X-Mimecast-MFC-AGG-ID: xOG0e_d6ORCbDUOBDGPhww
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D06819560AA; Tue,  7 Jan 2025 12:59:27 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7000195606B; Tue,  7 Jan 2025 12:59:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH 01/10] hw/s390x/s390-virtio-ccw: Remove the deprecated
 2.4 and 2.5 machine types
In-Reply-To: <20250103144232.520383-2-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-2-thuth@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 07 Jan 2025 13:59:23 +0100
Message-ID: <874j2abx04.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 03 2025, Thomas Huth <thuth@redhat.com> wrote:

> They are older than 6 years, so according to our machine support
> policy, they can be removed now.
>
> This removes the requirements for the storage keys "migration-enabled"
> property which will be removed in the next patch. It also removes
> the code that sets "max_revision" to 0 for some CCW devices, but
> the relating code in virtio-ccw.c indicates that 0 could have also
> been in use for other machines types < 5.1, so further clean-up for
> code related to "max_revision" won't be done yet.

These are two different issues:
- QEMU 2.4 and earlier _defaulted_ to legacy virtio devices (enforced by
  setting max_revision to 0)
- QEMU 5.0 and earlier _allowed_ virtio device types to be configured as
  legacy devices that did not actually support legacy (e.g. virtio-gpu),
  there's a compat value to allow a max_revision of 0 for those old
  machine types

So that's not a problem -- but I wonder whether we had missed the boat
elsewhere, when we introduced revisions > 1 (nothing much we can do now
if that is the case, though.)

I also don't think we actually want to remove max_revision anyway, as it
could also be used for non-compat related things (e.g. to accommodate a
known buggy driver.)

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)

The patch itself LGTM.


