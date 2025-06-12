Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A2C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 10:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPezH-0004jW-61; Thu, 12 Jun 2025 06:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPezF-0004jG-34
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPez7-0006HV-EM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 06:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749723395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOgXUdbL82gnOhjSLwzcjPZxSpnddvg2hIBOzaCHeAE=;
 b=DdmE6gARkPoLYsR4dz+LTQuHtLrI82lcyCANR2HXXJU5d3G13rRx1jf0pDz//ih7Q6MdCp
 Sda1NGdTQ7tHn6ae0PpPxS6kRsfXrioAIoVfln+bPQUktisyGxZFt1nWzxg5KBOeLnOK87
 dTxpS8wZuw7PNsXNoqfyh3Wvm3XNdI0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-GNNomrzTN2mJgHLcoli2aA-1; Thu,
 12 Jun 2025 06:16:33 -0400
X-MC-Unique: GNNomrzTN2mJgHLcoli2aA-1
X-Mimecast-MFC-AGG-ID: GNNomrzTN2mJgHLcoli2aA_1749723393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD77F18089B5; Thu, 12 Jun 2025 10:16:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4786A180045B; Thu, 12 Jun 2025 10:16:31 +0000 (UTC)
Date: Thu, 12 Jun 2025 11:16:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
Message-ID: <aEqo-1g4gL0QXKWe@redhat.com>
References: <20250611075037.659610-1-kraxel@redhat.com>
 <aEnEiqfa57eH53Gf@redhat.com>
 <CAJSP0QX7pcNTz_uSdMBzDhTRbUkrmmSPziBs82-GscRHM-xiug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QX7pcNTz_uSdMBzDhTRbUkrmmSPziBs82-GscRHM-xiug@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 11, 2025 at 03:21:38PM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 11, 2025 at 2:03 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > FYI, this seabios 1.17.0 release appears to have broken the
> > ability to use virtio-pci with libguestfs+QEMU:
> >
> >   https://bugzilla.redhat.com/show_bug.cgi?id=2372329
> >
> > so I'd suggest we hold off on this pull request until
> > the regression is diagnosed.
> 
> Thanks, Daniel. I have pushed a revert to staging.

This has been diagnosed now.

Old SeaBIOS would unconditionally add ACPI tables, even when QEMU
machine type had acpi=off. libguestfs forgot to ask for ACPI in
its libvirt XML, so was getting acpi=off as far as QEMU was
concerned, but SeaBIOS was none the less creating ACPI tables.

It was a miracle this worked because the ACPI tables were
designed for i440fx, but somehow Linux still booted with
them under q35.

So, the SeaBIOS update has a functional change, but that
was intentional & desirable, and the root bug was the lack
of request for ACPI in libguestfs.

So no need to revert anything

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


