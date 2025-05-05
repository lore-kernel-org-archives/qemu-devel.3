Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36499C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrj4-0002D2-PF; Mon, 05 May 2025 05:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBrj2-0002CV-Tk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBrj1-0005Lr-5f
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BuPbnYE0FLPwtJq6riuApzLaf4b7OYwymv9y5EioLZY=;
 b=W0GL8W1j5blsjMHVcXtB+ZFlS1CkvbOgcXKITFe1RzHJWHm/ulTqokHWu4IK/24XfvWrCD
 xoRRA15jiYOs0lypMd4ctleZIJM9sWhsDTxYcnYMqAsJLTo7VdNubmBOnSnIz47ZwAM+w1
 x7ZWXp9UB6ipoMTOqK1p+Ic5iaid1sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-JEK67e8sMHKw_bN-UOKvMw-1; Mon,
 05 May 2025 05:02:55 -0400
X-MC-Unique: JEK67e8sMHKw_bN-UOKvMw-1
X-Mimecast-MFC-AGG-ID: JEK67e8sMHKw_bN-UOKvMw_1746435772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D275118001D5; Mon,  5 May 2025 09:02:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E703430001A2; Mon,  5 May 2025 09:02:47 +0000 (UTC)
Date: Mon, 5 May 2025 11:02:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 00/22] usb/xhci and usb/msd improvements and tests
Message-ID: <aBh-tXqR6RqXvx9D@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <D9NUVWSVJKHN.3T7M6OPALIGYC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9NUVWSVJKHN.3T7M6OPALIGYC@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 05.05.2025 um 04:03 hat Nicholas Piggin geschrieben:
> On Fri May 2, 2025 at 1:30 PM AEST, Nicholas Piggin wrote:
> > This is merged from two series now because code especially the test
> > cases have started to depend on one another.
> 
> Question for the list, hw/usb/* is marked orphan. I don't have the
> bandwidth to take it on. There's one or two other little things that
> need to be taken, e.g.,
> 
> https://lore.kernel.org/qemu-devel/20250405140002.3537411-1-linux@roeck-us.net/
> 
> Bernhard and Phil Dennis-Jordan have been doing some good work and
> reviews on host controllers and Kevin on usb-storage. Any interest
> to maintain it or do odd fixes? I suppose most are in the same boat
> as me.

The changes I made (or merged) were mostly for the external interfaces
of the device. Initialising the qdev device, setting properties, passing
them to the SCSI device etc. It's been a while since I last looked at
some actual USB stuff (and not in the context of QEMU), so I'm not
necessarily the natural reviewer/maintainer for this part of it. (On the
other hand, who is if Gerd doesn't have the time for it any more?)

> I would like to get this series merged, but I realize the mass storage
> change to relax packet ordering of a command particularly is quite
> complicated and under-reviewed.

I can try to find the time to have a look at the series, but given that
I'll have to familiarise myself with the specs again, it might take a
while.

> Would there be objection if I made a pull request for Guenter's
> patches, the hcd stuff, the qtests, and some of the easier / reviewed
> bits of msd?

That makes sense to me. I suppose I can also give a quick review for the
initial part of the msd patches, at lot of which seems to be more or
less just refactoring.

Kevin


