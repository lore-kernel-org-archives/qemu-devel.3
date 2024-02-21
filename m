Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58021C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgKD-00086e-90; Wed, 21 Feb 2024 01:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcgKB-00086L-2J
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:43:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcgK8-0001iT-AU
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 01:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708497798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/PM6D9tq35kldXsGaNiaWRtuIMHcq8jTBMZdxFoQbs=;
 b=CGRC5AP1PYMYOgqU0IFEYUNX0Ho1d0auZgUgzvD7v2F3Jnvo7VPrT3DM+Ps5tXqj6EKQbc
 WD0zYlp4CoY6Dt3HHM1QGrDU8nOPoGZj6zCQnUWeyHBpcb4oPibsrx+7BWlcapeycHgzN6
 dIyZg99U+fVpymo6aKM6kmyo2/LgrvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-DWpgrn1zMOykg4ylhPduHA-1; Wed, 21 Feb 2024 01:43:14 -0500
X-MC-Unique: DWpgrn1zMOykg4ylhPduHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E0D085A589;
 Wed, 21 Feb 2024 06:43:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 634EF40C1065;
 Wed, 21 Feb 2024 06:43:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F54521E66D5; Wed, 21 Feb 2024 07:43:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
In-Reply-To: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 21 Feb 2024 11:36:58 +0800")
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
Date: Wed, 21 Feb 2024 07:43:08 +0100
Message-ID: <874je22u83.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hyman Huang <yong.huang@smartx.com> writes:

> Add comment in detail for commit 433957bb7f (qapi:
> Make parameter 'file' optional for
> BlockdevCreateOptionsLUKS).
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  qapi/block-core.json | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab5a93a966..42b0840d43 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4973,7 +4973,25 @@
>  ##
>  # @BlockdevCreateOptionsLUKS:
>  #
> -# Driver specific image creation options for LUKS.
> +# Driver specific image creation options for LUKS. Note that
> +# @file is required if @preallocation is specified and equals
> +# PREALLOC_MODE_ON. The following three scenarios determine how
> +# creation logic behaves when @preallocation is either equal to
> +# PREALLOC_MODE_OFF or is not given:
> +#
> +#  1) When @file is given only, format the block device referenced
> +#     by @file as the LUKS specification and trunk it to the @size.

Do you mean "truncate it to @size"?

> +#     In this case, the @size should reflect amount of space made
> +#     available to the guest, so the trunk size must take account
> +#     of that which will be used by the crypto header.
> +#
> +#  2) When @header is given only, just format the block device
> +#     referenced by @header as the LUKS specification.
> +#
> +#  3) When both @file and @header are given, block device
> +#     referenced by @file should be trunked to @size, and block
> +#     device referenced by @header should be formatted as the LUKS
> +#     specification.
>  #
>  # @file: Node to create the image format on, mandatory except when
>  #        'preallocation' is not requested

Let's see whether I understand.

blockdev-create with "driver": "luks" can work in three different ways:

1. Create an image with a LUKS header

2. Create just a detached LUKS header

3. Create an image and a detached LUKS header

Correct?

@file and @header are BlockdevRef, which means they refer to existing
images with arbitrary driver.  Could be "file", "qcow2", or anything.

Correct?

To get 1., specify @file, but not @header.

To get 2., specify @header, but not @file.

To get 3., specify both.

Specifying neither is an error.

Correct?

In any case, @size is the logical size of the image (how much data it
can hold).

With 1., the actual image size is a bit larger due to the LUKS header.
The @file image is resized to that size: if it's shorter, it's grown, if
it's longer, it's truncated.

With 2., @size is merely recorded in the detached LUKS header.

With 3., @size is recorded in the detached LUKS header, and the @file
image is resized as with 1.

Correct?


