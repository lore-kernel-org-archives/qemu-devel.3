Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BFFC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXTx-0005Wc-JJ; Tue, 01 Jul 2025 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWXTv-0005TQ-BU
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWXTr-0005LZ-Ay
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751362845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8QE3TUKn4LiaPz7GO1zqfh2EPKsp5U7NDfnEk+Z14Uw=;
 b=YHvEvzEt6kfNVF2FS7nhRr2CGLGCO86FSgGJ4HpLhU6Z71TxGAHhW4Dj+Tu+gGPJvhnLyG
 N3HhCOh8F+Ahp+A3gAU5ZrDXGwN6M/7fSkh2o4uCqN38Ji0pYPYbfdttcBktfYl4D+gN2o
 Z4XjFBFdvVgNX7b1TaUr5Jj1IJLJoj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-AQoHvsNiPF-4M15urogqNQ-1; Tue,
 01 Jul 2025 05:40:42 -0400
X-MC-Unique: AQoHvsNiPF-4M15urogqNQ-1
X-Mimecast-MFC-AGG-ID: AQoHvsNiPF-4M15urogqNQ_1751362841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40A9018001D6; Tue,  1 Jul 2025 09:40:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3A8D30001B1; Tue,  1 Jul 2025 09:40:39 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:40:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] hw/display: Allow injection of virtio-gpu EDID name
Message-ID: <aGOtE2d3r4RvMfOX@redhat.com>
References: <20250630151757.2553891-1-ankeesler@google.com>
 <20250630151757.2553891-2-ankeesler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630151757.2553891-2-ankeesler@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 30, 2025 at 03:17:57PM +0000, Andrew Keesler wrote:
> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> Identification Data) is propagated by QEMU such that a virtual display
> presents legitimate metadata (e.g., name, serial number, preferred
> resolutions, etc.) to its connected guest.
> 
> This change adds the ability to specify the EDID name for a particular
> virtio-vga display. Previously, every virtual display would have the same
> name: "QEMU Monitor". Now, we can inject names of displays in order to test
> guest behavior that is specific to display names. We provide the ability to
> inject the display name from the frontend since this is guest visible
> data. Furthermore, this makes it clear where N potential display outputs
> would get their name from (which will be added in a future change).
> 
> Note that we have elected to use a struct here for output data for
> extensibility - we intend to add per-output fields like resolution in a
> future change.
> 
> It should be noted that EDID names longer than 12 bytes will be truncated
> per spec (I think?).

IMHO, we should report  an error at realize time if the user specified
a name that is too long to be honoured.

> 
> Testing: verified that when I specified 2 outputs for a virtio-gpu with
> edid_name set, the names matched those that I configured with my vnc
> display.
> 
>   -display vnc=localhost:0,id=aaa,display=vga,head=0 \
>   -display vnc=localhost:1,id=bbb,display=vga,head=1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>               },
>               {
>                  "name":"BBB",
>               },
>             ]}'
> 
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> ---
>  hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
>  hw/display/virtio-gpu-base.c        | 20 +++++++++++++
>  include/hw/qdev-properties-system.h |  5 ++++
>  include/hw/virtio/virtio-gpu.h      |  3 ++
>  qapi/virtio.json                    | 18 ++++++++++--
>  5 files changed, 88 insertions(+), 2 deletions(-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


