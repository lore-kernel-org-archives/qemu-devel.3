Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F11CCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz3Q-0003Ji-JW; Fri, 12 Sep 2025 04:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwz3N-0003Ii-JL
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwz3G-0002cw-0a
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757665351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U8KYadglfP31o9vbs9wAW2zRJbQ+x0qSuyH2HdF/aLE=;
 b=Z4YkxSJh4LPqo1+e014gGb3/e/bsh5uEyW+hlJ6FrqQXk8RWRF2A5JUwNqtSJs3J49DL1o
 N4NIgbNqiqB47hjTl+e98UUMIKjcItanp2NmyxBGUNnTdJamsYe34dVPqayLxyCqmCO1lh
 3nVt8xgNKgLEBnjHQopaZpjrJkUZM6w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-FMPyE2cGMy2nVzFNDsnCoQ-1; Fri,
 12 Sep 2025 04:22:29 -0400
X-MC-Unique: FMPyE2cGMy2nVzFNDsnCoQ-1
X-Mimecast-MFC-AGG-ID: FMPyE2cGMy2nVzFNDsnCoQ_1757665348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EE9E1955E7E; Fri, 12 Sep 2025 08:22:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7056F1800452; Fri, 12 Sep 2025 08:22:26 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:22:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] qemu-options: Add description of tdx-guest object
Message-ID: <aMPYPuyKCMPKcPSh@redhat.com>
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
 <20250714091953.448226-6-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714091953.448226-6-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 14, 2025 at 05:19:53PM +0800, Xiaoyao Li wrote:
> Add description of tdx-guest object so that QEMU doc page can have the
> description.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  qemu-options.hx | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5c400114c2e5..50c7874bbce9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5994,6 +5994,46 @@ SRST
>                   -machine ...,confidential-guest-support=sev0 \\
>                   .....
>  
> +    ``-object tdx-guest,id=id,[attributes=attrs,sept-ve-disable=on|off,mrconfigid=sha384_digest,mrowner=sha384_digest,mrownerconfig=sha384_digest,quote-generation-socket=socketaddr]``
> +        Create an Intel Trusted Domain eXtensions (TDX) guest object, which is
> +        the type of ``confidentiala-guest-support`` object. When pass the object
> +        ID to machine's ``confidentiala-guest-support`` property, it can create

Typo  in 'confidentiala' (both lines)

> +        a TDX guest.
> +
> +        The ``attributes`` is a 64-bit integer, which specifies the TD

"The ``attributes`` property is..."

> +        attributes of the TD.
> +
> +        The ``sept-ve-disable`` controls the bit 28 of TD attributes

"Ths ``sept-ve-disable`` property controls..."

> +        specifically. When it's on, the EPT violation conversion to #VE on
> +        guest access of PENDING pages is disabled. Some guest OS (e.g., Linux
> +        TD guest) may require this to be set, otherwise they refuse to boot.
> +        The default value is on.
> +
> +        The ``mrconfigid`` is base64 encoded SHA384 digest, which provides the

...add the word 'property' after the property name, and again in
the lines below

> +        ID for non-owner-defined configuration of the guest TD, e.g., run-time
> +        or OS configuration. The default value is all zeros.
> +
> +        The ``mrowner`` is base64 encoded SHA384 digest, which provides the ID
> +        for guest TD's owner. The default value is all zeros.
> +
> +        The ``mrownerconfig`` is base64 encoded SHA384 digest, which provides
> +        the ID for owner-defined configuration of the guest TD, e.g., the
> +        configuration specific to the workload rather than the run-time of OS.
> +        The default value is all zeros.
> +
> +        The ``quote-generation-socket`` specifies the socket address of the
> +        Quote Generation Service (QGS). QGS is a daemon running on the host.
> +        QEMU forwards the <GetQuote> request from TD guest to QGS and sents the
> +        reply (which contains generated QUOTE on success) from QGS to guest TD.
> +
> +        .. parsed-literal::
> +
> +             # |qemu_system_x86| \\
> +                 ... \\
> +                 -object tdx-guest,id=tdx0, \\
> +                 -machine ...,confidential-guest-support=tdx0 \\
> +                 ...

I'd suggest making the example include 'quote-generation-socket'
too as that usage is non-obvious to users unless familiar with
QMP.

> +
>      ``-object authz-simple,id=id,identity=string``
>          Create an authorization object that will control access to
>          network services.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


