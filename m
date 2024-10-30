Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED9D5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6AzQ-0002V9-O0; Wed, 30 Oct 2024 11:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6AzO-0002UX-BM
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6AzK-0006pY-85
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuDlJAzEslG9MvUvzLNf1dA1mxqp43Ep/GdqMLfEnaU=;
 b=PfSJtfZWvk+mWbpOJci+NJpUH9dL3ASfnajhJ0gA3vu81lifZ2YWodjK8iDD/LCKxIfYBx
 Mftg+mesfpHekulZzIOpkjS4nCItlevjpmuA/FIHu43ox/K8JsBxbN+uB3t899eM1X6eXX
 HSKG4aCd+olLv0EHaPGJiHJbqfSXIBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-6XNUdUdaObCCBTlAi_q_3g-1; Wed,
 30 Oct 2024 11:51:58 -0400
X-MC-Unique: 6XNUdUdaObCCBTlAi_q_3g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 693991956080
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 15:51:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C35B419560A2; Wed, 30 Oct 2024 15:51:55 +0000 (UTC)
Date: Wed, 30 Oct 2024 15:51:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [qemu-web PATCH] mention DigitalOcean sponsorship
Message-ID: <ZyJWFw6RvMMFgN1y@redhat.com>
References: <20241030152218.16084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030152218.16084-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 30, 2024 at 04:22:18PM +0100, Paolo Bonzini wrote:
> We have received a sponsorship from DigitalOcean, so add it next to Azure (in
> alphabetical order) on the sponsors page of QEMU's website
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  sponsors.md | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

though qemu-web page changes are normally done via merge requests on
gitlab, aren't they ?

> 
> diff --git a/sponsors.md b/sponsors.md
> index efbec97..d30c3d7 100644
> --- a/sponsors.md
> +++ b/sponsors.md
> @@ -5,9 +5,12 @@ permalink: /sponsors/
>  
>  QEMU has sponsors!
>  
> -The [Azure credits for open source projects](https://opensource.microsoft.com/azure-credits/)
> -program provides QEMU and [Patchew](https://patchew.org) with virtual machines and
> -other cloud resources.
> +[Azure](https://azure.microsoft.com/) and [DigitalOcean](https://www.digitalocean.com/)
> +provide QEMU and [Patchew](https://patchew.org) with virtual machines and
> +other cloud resources through the [Azure credits for open source
> +projects](https://opensource.microsoft.com/azure-credits/) and [DigitalOcean
> +Open Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
> +programs.
>  
>  [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
>  [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


