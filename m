Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D4CC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGUy-0001Gd-MS; Fri, 12 Jul 2024 09:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGUw-00017V-Ei
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGUt-0000SQ-75
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720791576;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qhiafc0n/aHKsK3+/E4evBoBO1Ro70y/lQUVyFjpcws=;
 b=RJUFPvJS9JUacqWneUMm9nvAnU0ryJ24wBnFuCxTy2sfm2ZIp8VjueHgMt2fmF+P7N1yH4
 N0iMTOqED0iZBcmLOhyroAn+k7vcezzD5SyKHBv7PAmY+D5oPkIUHQOOOf/hf70FZQogXe
 R0lS62TKgz8OmC4b8vYMsBScZsZr2Qc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-Pf5zDevFO7ihs-HPMDdubw-1; Fri,
 12 Jul 2024 09:39:34 -0400
X-MC-Unique: Pf5zDevFO7ihs-HPMDdubw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA97196E08E; Fri, 12 Jul 2024 13:39:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 752953000181; Fri, 12 Jul 2024 13:39:29 +0000 (UTC)
Date: Fri, 12 Jul 2024 14:39:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] docs/devel: Add introduction to LUKS volume with
 detached header
Message-ID: <ZpEyDiffBIcWoGZU@redhat.com>
References: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 20, 2024 at 12:04:42AM +0800, Hyman Huang wrote:
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  MAINTAINERS                         |   1 +
>  docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 docs/devel/luks-detached-header.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24c2b51b6..e8b03032ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3422,6 +3422,7 @@ Detached LUKS header
>  M: Hyman Huang <yong.huang@smartx.com>
>  S: Maintained
>  F: tests/qemu-iotests/tests/luks-detached-header
> +F: docs/devel/luks-detached-header.rst
>  
>  D-Bus
>  M: Marc-André Lureau <marcandre.lureau@redhat.com>
> diff --git a/docs/devel/luks-detached-header.rst b/docs/devel/luks-detached-header.rst
> new file mode 100644
> index 0000000000..15e9ccde1d
> --- /dev/null
> +++ b/docs/devel/luks-detached-header.rst

The new file neeeds adding to an index. We don't have anywhere for crypto
yet, so I'm starting a crypto section thus:

    diff --git a/docs/devel/crypto.rst b/docs/devel/crypto.rst
    new file mode 100644
    index 0000000000..39b1c910e7
    --- /dev/null
    +++ b/docs/devel/crypto.rst
    @@ -0,0 +1,10 @@
    +.. _crypto-ref:
    +
    +====================
    +Cryptography in QEMU
    +====================
    +
    +.. toctree::
    +   :maxdepth: 2
    +
    +   luks-detached-header
    diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
    index 5636e9cf1d..4ac7725d72 100644
    --- a/docs/devel/index-internals.rst
    +++ b/docs/devel/index-internals.rst
    @@ -20,3 +20,4 @@ Details about QEMU's various subsystems including how to add features to them.
        vfio-iommufd
        writing-monitor-commands
        virtio-backends
    +   crypto


> @@ -0,0 +1,182 @@
> +================================
> +LUKS volume with detached header
> +================================
> +
> +Introduction
> +============
> +
> +This document gives an overview of the design of LUKS volume with detached
> +header and how to use it.
> +
> +Background
> +==========
> +
> +The LUKS format has ability to store the header in a separate volume from
> +the payload. We could extend the LUKS driver in QEMU to support this use
> +case.
> +
> +Normally a LUKS volume has a layout:
> +
> +::
> +
> +         +-----------------------------------------------+
> +         |         |                |                    |
> + disk    | header  |  key material  |  disk payload data |
> +         |         |                |                    |
> +         +-----------------------------------------------+
> +
> +With a detached LUKS header, you need 2 disks so getting:
> +
> +::
> +
> +         +--------------------------+
> + disk1   |   header  | key material |
> +         +--------------------------+
> +         +---------------------+
> + disk2   |  disk payload data  |
> +         +---------------------+
> +
> +There are a variety of benefits to doing this:
> +
> + * Secrecy - the disk2 cannot be identified as containing LUKS
> +             volume since there's no header
> + * Control - if access to the disk1 is restricted, then even
> +             if someone has access to disk2 they can't unlock
> +             it. Might be useful if you have disks on NFS but
> +             want to restrict which host can launch a VM
> +             instance from it, by dynamically providing access
> +             to the header to a designated host
> + * Flexibility - your application data volume may be a given
> +                 size and it is inconvenient to resize it to
> +                 add encryption.You can store the LUKS header
> +                 separately and use the existing storage
> +                 volume for payload
> + * Recovery - corruption of a bit in the header may make the
> +              entire payload inaccessible. It might be
> +              convenient to take backups of the header. If
> +              your primary disk header becomes corrupt, you
> +              can unlock the data still by pointing to the
> +              backup detached header
> +
> +Architecture
> +============
> +
> +Take the qcow2 encryption, for example. The architecture of the
> +LUKS volume with detached header is shown in the diagram below.
> +
> +There are two children of the root node: a file and a header.
> +Data from the disk payload is stored in the file node. The
> +LUKS header and key material are located in the header node,
> +as previously mentioned.
> +
> +::
> +
> +                       +-----------------------------+
> +  Root node            |          foo[luks]          |
> +                       +-----------------------------+
> +                          |                       |
> +                     file |                header |
> +                          |                       |
> +               +---------------------+    +------------------+
> +  Child node   |payload-format[qcow2]|    |header-format[raw]|
> +               +---------------------+    +------------------+
> +                          |                       |
> +                     file |                 file  |
> +                          |                       |
> +               +----------------------+  +---------------------+
> +  Child node   |payload-protocol[file]|  |header-protocol[file]|
> +               +----------------------+  +---------------------+
> +                          |                       |
> +                          |                       |
> +                          |                       |
> +                     Host storage            Host storage
> +
> +Usage
> +=====
> +
> +Create a LUKS disk with a detached header using qemu-img
> +--------------------------------------------------------
> +
> +Shell commandline::
> +
> +# qemu-img create --object secret,id=sec0,data=abc123 -f luks \
> +> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0 \
> +> -o detached-header=true test-header.img
> +# qemu-img create -f qcow2 test-payload.qcow2 200G
> +# qemu-img info 'json:{"driver":"luks","file":{"filename": \
> +> "test-payload.img"},"header":{"filename":"test-header.img"}}'

This needs indentation by 2 spaces, and the ">" can be dropped.
The same for all examples that follow.

I'm going to make those changes and queue this patch, since
they're trivial.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


