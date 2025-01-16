Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3535BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNBt-0003p1-2Z; Thu, 16 Jan 2025 05:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYNBo-0003oV-3Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYNBk-00041n-Fv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737023602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Khoi+SamrUS7P2PV5mgVUv5JKyLuDxSA77teos3Swvg=;
 b=fInOhSgRbfUFonmI9oxO7bBmTKrUXKEVZ+G6fDWoPaeUM89U2wFM5afQcOxmhQ0V9t29Dx
 KJ/euM63clbZFeCduMi/UafG1k1IHZXeHYHXcG0PM4NTdwG6iD6Z7LOC41BbP12M6KeLg3
 gn7dBDKfKWqOFSiL1WKDFAOwbnfiCWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-BkdeQ9ASMcah8Vg65lq9xA-1; Thu,
 16 Jan 2025 05:33:18 -0500
X-MC-Unique: BkdeQ9ASMcah8Vg65lq9xA-1
X-Mimecast-MFC-AGG-ID: BkdeQ9ASMcah8Vg65lq9xA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7393F1955DD0; Thu, 16 Jan 2025 10:33:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EAE119560A3; Thu, 16 Jan 2025 10:33:09 +0000 (UTC)
Date: Thu, 16 Jan 2025 10:33:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 02/21] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Message-ID: <Z4jgX1LTnn6z0-fz@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115232247.30364-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Thu, Jan 16, 2025 at 12:22:28AM +0100, Philippe Mathieu-Daudé wrote:
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/removed-features.rst |  4 ++++
>  hw/i386/pc_piix.c               | 13 -------------
>  hw/i386/pc_q35.c                | 13 -------------
>  3 files changed, 4 insertions(+), 26 deletions(-)

I'll give this:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

on the basis that this patch series isn't added to a PULL until
the 10.1.0 dev cycle opens.

> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index c6616ce05e5..e4bdb385a25 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1012,6 +1012,10 @@ This machine has been renamed ``fuloong2e``.
>  These machine types were very old and likely could not be used for live
>  migration from old QEMU versions anymore. Use a newer machine type instead.
>  
> +``pc-q35-2.4`` and `pc-i440fx-2.4` (removed in 10.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''
> +This versioned machine has been supported for a period of more than 6 years.
> +
>  Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>

We might be able to drop chunk this depending on discussion around
Thomas' general docs patch


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


