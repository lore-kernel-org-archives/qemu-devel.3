Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC071CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFtA-0004A9-EU; Mon, 30 Sep 2024 08:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svFt9-00049f-1b
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svFt6-0006UQ-VX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727700748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pBR+kzAXH63igHm5HSiqwHXMiueFs+Oy34wjuPFF8zo=;
 b=Wfp6q8q0iserEIPZrRK8MzvZTUlt4mG4UMQzbHkYr5uGhNVDB4bjl/nkUmKrYH5AMxHhXn
 y4YsxyozLRcJC8dVtrzS39WqmOLxN9yJmSbnVj/U9BiisaN8h+xeYYTppGbuDNWUdGrxzk
 2eT5WaNCPCJpy6tmOEoZoGPSRWUK42s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-S9QJIC06NoGr8nTCazt4tA-1; Mon,
 30 Sep 2024 08:52:24 -0400
X-MC-Unique: S9QJIC06NoGr8nTCazt4tA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A992F19373D9; Mon, 30 Sep 2024 12:52:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31EAA1955DCB; Mon, 30 Sep 2024 12:52:18 +0000 (UTC)
Date: Mon, 30 Sep 2024 13:52:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, devel@lists.libvirt.org,
 integration@gluster.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] docs: Mark "gluster" support in QEMU as deprecated
Message-ID: <Zvqe-Dyu8ma58Tef@redhat.com>
References: <20240925071514.13728-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925071514.13728-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 25, 2024 at 09:15:14AM +0200, Thomas Huth wrote:
> According to https://marc.info/?l=fedora-devel-list&m=171934833215726
> the GlusterFS development effectively ended. Thus mark it as deprecated
> in QEMU, so we can remove it in a future release if the project does
> not gain momentum again.
> 
> Acked-by: Niels de Vos <ndevos@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Mark it as deprecated in the QAPI and print a warning once, too
> 
>  docs/about/deprecated.rst | 9 +++++++++
>  qapi/block-core.json      | 7 ++++++-
>  block/gluster.c           | 2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ed31d4b0b2..b231aa3948 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -395,6 +395,15 @@ Specifying the iSCSI password in plain text on the command line using the
>  used instead, to refer to a ``--object secret...`` instance that provides
>  a password via a file, or encrypted.
>  
> +``gluster`` backend (since 9.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +According to https://marc.info/?l=fedora-devel-list&m=171934833215726
> +the GlusterFS development effectively ended. Unless the development
> +gains momentum again, the QEMU project might remove the gluster backend
> +in a future release.

I'd suggest the second half of the sentance can be simplified:

   ", the QEMU project will remove the gluster backend/"

since marking something as deprecated is a stronger than "might".
We /will/ remove it, unless new informaton comes to light that
makes us re-evaluate the plans.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


