Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1F606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=br/DKky4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSRs-00012K-Vz; Mon, 09 Nov 2026 11:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQSRr-000128-UW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQSRq-0000XM-DI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rehp/lSs6P683LCctNTw1lrfiuZ0Iezse+6F8YwMkMo=;
 b=br/DKky4F1/hNR5XykNwX+XqHFdGuiCzyoi0OZw5cLLxphk9gvfJ5p7ClqAiH3fM9kcgMI
 VijLlLtfkAdEZr6YA+7tkZ9t2Qv56bAcU3b7Iy1HC2bFuGG5lU5x1TMfGSFXhPuYbLmDpY
 LZSzq7D7x3fmiX3KW01SY1vtvEcqyGo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-N1KIG6RzNB6GdchF1eRJsw-1; Mon,
 09 Nov 2026 11:42:16 -0500
X-MC-Unique: N1KIG6RzNB6GdchF1eRJsw-1
X-Mimecast-MFC-AGG-ID: N1KIG6RzNB6GdchF1eRJsw_1794242533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D0821955EA9; Mon,  9 Nov 2026 16:42:13 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC5D18004E9; Mon,  9 Nov 2026 16:42:11 +0000 (UTC)
Date: Mon, 9 Nov 2026 16:42:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH for-12] qed: deprecate the block driver
Message-ID: <avH34P2rgELLqa4b@redhat.com>
References: <20261109163431.443983-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109163431.443983-1-stefanha@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 09:34:31AM -0700, Stefan Hajnoczi wrote:
> It has been unofficially deprecated on the wiki for many years:
> https://wiki.qemu.org/Features/QED
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

How about bdrv_qed_open also adding

  warn_report_once("QED is deprecated, please switch to qcow2");

for the part of the user population who never reads the docs.

> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0891bbc44de..ab83626af0b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -526,3 +526,16 @@ If the user requests a modern x86 CPU model (i.e. not one of ``486``,
>  ``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
>  a warning will be displayed until a future QEMU version when such CPUs will
>  be rejected.
> +
> +Block drivers
> +-------------
> +
> +QED (since 12.0)
> +''''''''''''''''
> +
> +The QED disk image format is not actively maintained and qcow2 has exceeded its
> +features and performance for many years. Since QED was never widely deployed,
> +the format is not required for compatibility reasons. It is unlikely that
> +qemu-img users still need to convert images to or from QED.
> +
> +Use qcow2 instead of QED.
> -- 
> 2.56.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


