Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B855CEBF7A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 07:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4zs-0008SH-IF; Fri, 27 Sep 2024 03:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1su4zr-0008QP-Dz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1su4zp-0000lJ-AT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727420551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=si8jE26eS6bBhAwYH20lWaqdoXxLxsxsl2yCtn0zlK8=;
 b=f0Z3tEkru6RJm0XrOjtz8hrCIlmeatFWniSLQs65EjGWEv3vwjoZqD8QcLpF84bxg2v3JV
 c9GCFN46c2sAFTYilFCLk7XHLbA5LdCbD78vuehIZv8vmmkQul7c31MCpw8ZiDWoZ0GLi8
 NAgrz2UfBq/1s9eDF1FRcSPyQfWBxlU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-GPcyofXZNbOaY0-EZKYTtQ-1; Fri,
 27 Sep 2024 03:02:27 -0400
X-MC-Unique: GPcyofXZNbOaY0-EZKYTtQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B611B18B05CE; Fri, 27 Sep 2024 07:02:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8505A1955D57; Fri, 27 Sep 2024 07:02:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96E3A21E6A28; Fri, 27 Sep 2024 09:02:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  devel@lists.libvirt.org,  integration@gluster.org,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] docs: Mark "gluster" support in QEMU as deprecated
In-Reply-To: <20240925071514.13728-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 25 Sep 2024 09:15:14 +0200")
References: <20240925071514.13728-1-thuth@redhat.com>
Date: Fri, 27 Sep 2024 09:02:06 +0200
Message-ID: <87jzex4m1d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

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
> +
> +
>  Character device options
>  ''''''''''''''''''''''''
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9f6dd59298..cb7cb1c0ed 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3187,12 +3187,17 @@
>  #
>  # @snapshot-access: Since 7.0
>  #
> +# Features:
> +#
> +# @deprecated: Member @gluster is deprecated since GlusterFS ceased development

End the sentence with full stop, and wrap the line.  Suggest:

   # @deprecated: Member @gluster is deprecated because GlusterFS
   #     development ceased.

> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevDriver',
>    'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
>              'cloop', 'compress', 'copy-before-write', 'copy-on-read', 'dmg',
> -            'file', 'snapshot-access', 'ftp', 'ftps', 'gluster',
> +            'file', 'snapshot-access', 'ftp', 'ftps',
> +            {'name': 'gluster', 'features': [ 'deprecated' ] },
>              {'name': 'host_cdrom', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
>              {'name': 'host_device', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
>              'http', 'https',

I wonder why it's not 'if': 'CONFIG_GLUSTERFS'.  Probably not worth
exploring now.

With the doc comment tidied up:
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


