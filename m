Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E69CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 08:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrZuQ-00049i-9e; Tue, 02 Apr 2024 04:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rrZuP-00049W-AH
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rrZuN-0007O2-1o
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712048041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdSCXe1MhWvi5Rs4y3pmZsWeu2DuM4zXK8C+4ayDdac=;
 b=W4ERuIZvqCvZ90M7oO2Lq7U7+aiSuD5B3DEr8MeWTQfvWrBKF8dMAnMvwJJUQiaqB8Hk+p
 LDLFego14P+wuyQGY7blbQDK39ksp1A+eZKV91O+CMYv+46eNYNecWmRHpNgb58rNpSswt
 GTDHub0a4zLuxdSTHjqCarGOqNt+Mxw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-_TjxPVoaP66mw0t-P30bBg-1; Tue,
 02 Apr 2024 04:53:55 -0400
X-MC-Unique: _TjxPVoaP66mw0t-P30bBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 396BA29AC031;
 Tue,  2 Apr 2024 08:53:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41E8D1C060A6;
 Tue,  2 Apr 2024 08:53:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C70C1800D54; Tue,  2 Apr 2024 10:53:49 +0200 (CEST)
Date: Tue, 2 Apr 2024 10:53:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, 
 devel@lists.libvirt.org, richard.henderson@linaro.org, mst@redhat.com,
 thuth@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <al5k7rzebkfmpfrc7fbe6yaqsnwod5rjfpm6f2elshy2e7olze@43fqzednk3dn>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
 <vyepknhyulwvmyypt74i7gvu4nqqqzhgdj2fxi66rgdnipi2co@ildhvlycqf2v>
 <2dbf45c6-33a3-4ebc-a78a-75305836022e@ilande.co.uk>
 <2BB514FB-47D6-4B1E-9463-4F4811015F29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2BB514FB-47D6-4B1E-9463-4F4811015F29@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Mar 29, 2024 at 10:19:09AM +0000, Bernhard Beschow wrote:
> 
> In theory you could pass `-M acpi=off` to not instantiate the PIIX4
> ACPI function, essentially turning the Frankenstein-PIIX4 SB into a
> PIIX3. However, this also removes SMI registers used by SeaBIOS to
> handle SMM setup which may create unwanted side effects.

SeaBIOS will simply not use SMM in that case.

> On a real PIIX3, these registers are located in the ISA function. I
> wonder if it made sense to implement that for greater compatibility.
> 
> What do you think? Gerd, what do you think w.r.t. SeaBIOS?

Well, SMM support isn't that important I think.  It was introduced to
make switches to 32-bit mode more robust.  Entering SMM mode stores the
*complete* x86 processor state (which is impossible to do in other
ways), so with SMM it's possible to switch back into whatever state the
processor has been before entering 32-bit mode.

Some storage drivers (virtio, ahci) switch into 32-bit mode so they can
reach the mmio registers they need.  Some storage drivers (ide) don't,
in that case SMM doesn't change anything.

I'm not aware of any problems actually fixed by adding SMM support in
seabios.  I suspect the guest OS-es new enough to support ahci or virtio
are also new enough to not not call BIOS interfaces from non-standard
processor modes.

take care,
  Gerd


