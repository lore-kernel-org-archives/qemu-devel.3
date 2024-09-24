Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6442CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 14:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st6HL-0000X6-KJ; Tue, 24 Sep 2024 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1st6HI-0000VG-I5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1st6HG-0007vB-H1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727187149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1Tfv/48fKxYueVzPi8mMlZRPaYcEcg+rQc2u9punLY=;
 b=LguwIN/xCDXPxLhtpKeV5X2K/55JnWRejfiDvVZZi7BdmHDmj1VEqRQaTm9fItTRJhwCk6
 PhGCZK5JjMCOa2G/9JWNbhU2PXIaOvridlXuW2UKz1ZsYQJvO1zMzSGptyB1cT+pSCIfRw
 +E4uaHySSEtkx5beSGjqyHlhplpwEOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-TSzcPgpENxuXf61WxcMEYQ-1; Tue,
 24 Sep 2024 10:12:26 -0400
X-MC-Unique: TSzcPgpENxuXf61WxcMEYQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24E0818E6A7A; Tue, 24 Sep 2024 14:12:24 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.224.126])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781CD19560AD; Tue, 24 Sep 2024 14:12:22 +0000 (UTC)
Date: Tue, 24 Sep 2024 16:12:19 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 integration@gluster.org
Subject: Re: [PATCH] docs: Mark "gluster" support in QEMU as deprecated
Message-ID: <ZvLIw9P1lsMz7Cff@angien.pipo.sk>
References: <20240924132451.47121-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924132451.47121-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 24, 2024 at 15:24:51 +0200, Thomas Huth wrote:
> According to https://marc.info/?l=fedora-devel-list&m=171934833215726
> the GlusterFS development effectively ended. Thus mark it as deprecated
> in QEMU, so we can remove it in a future release if the project does
> not gain momentum again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
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

Shouldn't also the 'gluster' enum entry of 'BlockdevDriver'
(qapi/block-core.json) be marked as deprecated?


