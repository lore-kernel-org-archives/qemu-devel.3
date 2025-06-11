Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C70C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPPlx-0001eE-Ec; Wed, 11 Jun 2025 14:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPPlt-0001dz-Kq
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPPlr-000707-UM
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749664914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JZB6WRVgYCJnP+Q3YXQPDngdfWjbf2s7t8wypQSOBU0=;
 b=DjfGWvjcG3jFHnA8nzBzRtrIeBLAwPmpO6xcmm4S+lfjqErzWrfkRCBfXXufLXanKxnOt/
 Sh9A8atdP1H0HOQ7Lv8kO1UiTrCexsWXJGMHFMIIam4F8zQxjSkgQEazGtYECjyECQH3TT
 HKTrtmiah4xv4cXUAavkNRtSUqp0lE8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-vr5-2He2P8KreWSepP5YNw-1; Wed,
 11 Jun 2025 14:01:52 -0400
X-MC-Unique: vr5-2He2P8KreWSepP5YNw-1
X-Mimecast-MFC-AGG-ID: vr5-2He2P8KreWSepP5YNw_1749664912
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B605E19560B0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 18:01:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.140])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84D0519560A3; Wed, 11 Jun 2025 18:01:50 +0000 (UTC)
Date: Wed, 11 Jun 2025 19:01:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
Message-ID: <aEnEiqfa57eH53Gf@redhat.com>
References: <20250611075037.659610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075037.659610-1-kraxel@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

FYI, this seabios 1.17.0 release appears to have broken the
ability to use virtio-pci with libguestfs+QEMU:

  https://bugzilla.redhat.com/show_bug.cgi?id=2372329

so I'd suggest we hold off on this pull request until
the regression is diagnosed.

On Wed, Jun 11, 2025 at 09:50:35AM +0200, Gerd Hoffmann wrote:
> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:
> 
>   Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull-request
> 
> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1:
> 
>   seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> 
> ----------------------------------------------------------------
> seabios: update to 1.17.0 release
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (2):
>   seabios: update submodule to 1.17.0
>   seabios: update binaries to 1.17.0
> 
>  pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
>  pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
>  pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
>  pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
>  pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
>  pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 39424 bytes
>  pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
>  pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
>  pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
>  pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
>  pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
>  pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
>  roms/seabios                      |   2 +-
>  13 files changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


