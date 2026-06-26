Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B4ECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3VG-00044y-45; Fri, 26 Jun 2026 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3VE-00044j-CU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3VC-00037T-Ko
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxY0mA/o/ZGwwE7APAmWHi51Q/8ktVoNuiIDq6GZ4Dc=;
 b=fB/UO2w9ulhCK8IhmzLKAYnJUaHPT/xAjzcMd9Ww8Q2JU8OZJaXV59avwt6lsDhUdNh7i9
 1kG2Z8Z8H9wMp9I4Glww8YkpeLKytjq2Pv3j0UpiUjmriHWqqJjwvqh4nbsjVVJBcZdJWz
 OWZxEZKjuACZxKUTiFihmzXqDhkg6+E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-m-CMi4XqMdeabwBeLF-TJg-1; Fri,
 26 Jun 2026 06:09:32 -0400
X-MC-Unique: m-CMi4XqMdeabwBeLF-TJg-1
X-Mimecast-MFC-AGG-ID: m-CMi4XqMdeabwBeLF-TJg_1782468571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E881955DBF; Fri, 26 Jun 2026 10:09:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FB2A1800661; Fri, 26 Jun 2026 10:09:25 +0000 (UTC)
Date: Fri, 26 Jun 2026 11:09:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Linisha <linisha232@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
Message-ID: <aj5P0n03aKv93uci@redhat.com>
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625192121.1887-1-linisha232@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

CC Pierrick as docs maintainer.

On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.

Please ensure commit messages are line wrapped.

> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> Signed-off-by: Linisha <linisha232@gmail.com>
> ---
> 
> v2: Take a different approach based on review feedback from Daniel
>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>     machines too), add a general note near the start of the introduction
>     about how options, properties, and command lines may differ between
>     target architectures and machine types.
> 
> 
>  docs/system/introduction.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index bec7291e47..8d9ef61d26 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -1,6 +1,15 @@
>  Introduction
>  ============
>  
> +.. note::
> +   QEMU supports many different target CPU architectures and many
> +   different machine types for each architecture. Options, properties,
> +   and command lines that work for one architecture or machine type
> +   will not necessarily work on another. The examples shown in this
> +   manual are specific to the architecture and machine type being
> +   demonstrated. When in doubt, consult the documentation for your
> +   specific target architecture and machine type.
> +

Not convinced many people will read this, but I gues it doesn't
hurt.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


>  .. _Accelerators:
>  
>  Virtualisation Accelerators
> -- 
> 2.47.0.windows.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


