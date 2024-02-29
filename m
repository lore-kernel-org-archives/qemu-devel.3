Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DDFC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfc2O-0003cf-7A; Thu, 29 Feb 2024 03:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfc2G-0003Ye-1y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rfc21-0007YO-SY
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8N+vi4pVlZhYS+tsXC7cG9HYMVN9rLJgu0lqX2rwglQ=;
 b=XQWxsGrfMnARKWmJ3x+dbMoUMuK7vnLkUP0nZFPDwEYWZ9cJkPi5V5Lj29fIyV6yqlBY6O
 klwEFBRp919NRfyPhDfWapwHj68io2SW38BqXeVTz6zzz+tmi+eKXfzITvnzqj+OiKfIOH
 +AHlj12sizC0JfW3bPbgInyApHKN1cY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-oOxpOqQVMPmUzGU36yuvEg-1; Thu, 29 Feb 2024 03:44:42 -0500
X-MC-Unique: oOxpOqQVMPmUzGU36yuvEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7DBE10A5CC3;
 Thu, 29 Feb 2024 08:44:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0EB61C060B1;
 Thu, 29 Feb 2024 08:44:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95F011801480; Thu, 29 Feb 2024 09:44:40 +0100 (CET)
Date: Thu, 29 Feb 2024 09:44:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dario Faggioli <dfaggioli@suse.com>
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Subject: Re: No virtio devices in SeaBIOS VMs
Message-ID: <u4qb33tato343tzjxsyvdwmtivbmy6mhqlutwdmlggeireajc2@zogkagsbqob5>
References: <88e2bebdbfa4a9e29cedcfdb08537f2eb9654ce3.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e2bebdbfa4a9e29cedcfdb08537f2eb9654ce3.camel@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

  Hi,

> UEFI guests seem not to be affected in any way, no matter amount of RAM
> or CPU model (well, of course, since it's a SeaBIOS commit! :-D What I
> mean is that there seems to be nothing in edk2 that induces the same
> behavior).

That used to be a problem with UEFI too.

> A way of working this around (beside switching to UEFI or to cpu=host)
> is to turn on host-phys-bits, e.g., with '<maxphysaddr
> mode="passthrough"/>' in the XML.

Sounds like the phys-bits of your vcpus is larger than the value the
host actually supports.  So if the firmware tries to use the whole
address space available things break.

Both UEFI and SeaBIOS have a similar heuristic to figure whenever they
can trust phys-bits or not, and those checks consider upstream qemu
behavior (use phys-bits=40 for all cpu types except 'host').

When this came up with UEFI the root cause turned out to be that suse
qemu derived from upstream qemu.  There have been phys-bits values other
than 40 which where not valid (i.e. larger than supported by the host).

I don't know how that was solved in the end.  But given that we see
similar problems again with SeaBIOS I suspect it was patched in suse
OVMF not suse qemu.

> It is, however, a bit impractical to have to do this for all the VMs
> that one may have... Especially if they're a lot! :-)

I'd actually recommend to run all VMs with host-phys-bits=on (and use
host-phys-bits-limit=value if you need phys-bits being equal on all
machines of a heterogeneous cluster for live migration compatibility).

phys-bits being too big never was a valid configuration.  It only
happened to work because the firmware was very conservative with address
space usage.  That strategy became increasingly problematic though.
These days GPUs and NPUs can have gigabytes of device memory and equally
large pci memory bars ...

take care,
  Gerd


