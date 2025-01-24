Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90844C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGUb-0005My-6O; Fri, 24 Jan 2025 05:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tbGUY-0005G7-2B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:00:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tbGUV-0005tI-OH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737712842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yE569OnDH1Z1D2oEpYdhj8kp3tNfvP2paBZM1IJKUNA=;
 b=T2wh2fgjCaEMltbRRq03QwCxKKYdX0T1pf6rRKbAPQqgCPaILIduL7p0eGnN3ooLPtHIce
 Y14aK9/Z1Pn02OuX1CG5c1nsiH9vfzQwFhdVV7H3pVlTgIAxNHR9ZuyRhppZCIgMY9wGT7
 m4tzf5//1T3wOqzbZeqYHcMvgwD3Dqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-WnBiM-lzOFaBBwnPR1SZwg-1; Fri,
 24 Jan 2025 05:00:40 -0500
X-MC-Unique: WnBiM-lzOFaBBwnPR1SZwg-1
X-Mimecast-MFC-AGG-ID: WnBiM-lzOFaBBwnPR1SZwg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92AD71801330
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 10:00:38 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.142])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCF1F19560B7; Fri, 24 Jan 2025 10:00:36 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 50E772E070B; Fri, 24 Jan 2025 11:00:33 +0100 (CET)
Date: Fri, 24 Jan 2025 11:00:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 0/6] RFC: hw/display/virtio-gpu: problems with coloured
 cursors
Message-ID: <zde3tzhqrwc66txzl6ydp3xeipg5ohvj7saankjq2ri7p3ofhl@l6aoobdmfrz3>
References: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123191536.142753-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi,

>    The cursor data virtio-gpu is receiving from the guest has
>    had the alpha channel pre-multiplied into the RGB components.

The kernel driver simply passes through whatever it gets from userspace.

Not sure what userspace passes to the kernel, I suspect it is whatever
typical GPUs can use unmodified as cursor sprite.

>    The cursor data virtio-gpu is receiving from the guest appears
>    to be in BGRA8888 format, while GTK/VNC both expect the data to
>    be in RGBA8888 format.

The format used by virtio-gpu is DRM_FORMAT_ARGB8888
(VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM) on little endian guests.  Byteswapped
(DRM_FORMAT_BGRA8888 / VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM) on bigendian
guests.

> This series has patches to virtio-gpu which reverse the RGB
> components and un-multiply the alpha channel.

I'd tend to simply pass the cursor format information to the ui and
leave it to the ui to convert if needed, or just use the data as-is if
possible (like SDL does).  Same approach we are using for the
framebuffer data.

IIRC the cursor code predates the adoption of pixman in qemu, maybe it
makes sense to redesign this around pixman images.

> I'm unclear whether its reference to "ARGB" here implies that
> seeing BGRA8888 data is intentional, or a guest kernel bug ?

Intentional.

> The spec says nothing at all about alpha pre-multiplication.
> I kind of think this is more likely to be a guest kernel bug,
> but its possible the spec just forgot to mention this ?

Not sure, missing in the spec I'd guess.

> Meanwhile I've absolutely no clue what impact endianness will
> have on this mess. All my testing thus far has been x86_64
> host (QEMU git HEAD) with x86_64 guest (Fedora 41).

Looking at virtio_gpu_update_cursor_data() my guess would be it's
broken (or working by pure luck and bug compatibility).  The
function goes lookup the resource containing the cursor data,
checks size, but doesn't even look at the format.

HTH & take care,
  Gerd


