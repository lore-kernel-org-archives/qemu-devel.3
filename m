Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A71606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw2R+ZAH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWVTL-0004Iv-MM; Thu, 26 Nov 2026 04:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVTG-0004Fa-8p
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWVTD-0004ed-Rk
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795684126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MXK2+fmbQkWtDeqrh7aYAb5IlAYlbWYpasEaMPxOfs=;
 b=Zw2R+ZAHwUpiZOW40olUJff7ybAyECGaGllSObHmv708iBTCgPt/+R3w2/qn7TO+yaeCAK
 6FMNegcb47zWE4DZB+OSvkukLBC5eRSUXRJhPBRRxAeE2HxiFMSA0SPvXFm/KG4xm5h1aI
 M/w8CBtOqS3YyoUucOiunpHHRvtcC6E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163--4bmZi6UMzG_ZJ7-CiOhxg-1; Thu,
 26 Nov 2026 09:08:44 +0000
X-MC-Unique: -4bmZi6UMzG_ZJ7-CiOhxg-1
X-Mimecast-MFC-AGG-ID: -4bmZi6UMzG_ZJ7-CiOhxg_1795684123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F6FA1944B17
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 09:08:43 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABE4E18011D3; Thu, 26 Nov 2026 09:08:41 +0000 (UTC)
Date: Thu, 26 Nov 2026 09:08:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/1] qom: Really add 'confidential-guest-reset' feature
Message-ID: <awf3FjPHmzBe4saL@redhat.com>
References: <20261124154310.2569390-1-armbru@redhat.com>
 <20261124154310.2569390-2-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124154310.2569390-2-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Nov 24, 2026 at 04:43:10PM +0100, Markus Armbruster wrote:
> Commit a9b328611143 added feature 'confidential-guest-reset' to
> SevCommonProperties and to TdxGuestProperties.  The commit message
> states the intent as "control plane should be able to detect if the
> hypervisor supports x86 confidential guest resets."
> 
> Management applications ("control plane") would check whether the
> relevant argument type of QMP command object-add has the feature.  The
> relevant types are SevGuestProperties, SevSnpGuestProperties, and
> TdxGuestProperties.
> 
> Only TdxGuestProperties has the feature.  The other two have base type
> SevCommonProperties, but a type only inherits its base's members, and
> not its features or conditions.
> 
> Fix by moving the feature from SevCommonProperties to
> SevGuestProperties and SevSnpGuestProperties.
> 
> Fixes: a9b328611143 ("qom: add 'confidential-guest-reset' property for x86 confidential vms")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qom.json | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


I presume that we ultimately either want to fix the generator,
or at least have it emit a warning if a feature is set on
something that is used as a base struct, but obviously not
for 11.2 freeze.

> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 32a59269361..b8237a94be0 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1004,11 +1004,6 @@
>  #     only supported on SEV-ES and SEV-SNP guests
>  #     (default: false) (since 11.1)
>  #
> -# Features:
> -#
> -# @confidential-guest-reset: If present, the hypervisor supports
> -#     confidential guest resets (since 11.0).
> -#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevCommonProperties',
> @@ -1016,8 +1011,7 @@
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',
>              '*kernel-hashes': 'bool',
> -            '*debug-swap': 'bool' },
> -  'features': ['confidential-guest-reset']}
> +            '*debug-swap': 'bool' } }
>  
>  ##
>  # @SevGuestProperties:
> @@ -1042,6 +1036,11 @@
>  #    that require it.  If set to 'off', QEMU will require
>  #    KVM_SEV_INIT2 unconditionally.  (default: off) (since 9.1)
>  #
> +# Features:
> +#
> +# @confidential-guest-reset: If present, the hypervisor supports
> +#     confidential guest resets (since 11.0).
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'SevGuestProperties',
> @@ -1050,7 +1049,8 @@
>              '*session-file': 'str',
>              '*policy': 'uint32',
>              '*handle': 'uint32',
> -            '*legacy-vm-type': 'OnOffAuto' } }
> +            '*legacy-vm-type': 'OnOffAuto' },
> +  'features': [ 'confidential-guest-reset' ] }
>  
>  ##
>  # @SevSnpGuestProperties:
> @@ -1101,6 +1101,11 @@
>  # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
>  #     is enabled (default: zero) (since 11.1)
>  #
> +# Features:
> +#
> +# @confidential-guest-reset: If present, the hypervisor supports
> +#     confidential guest resets (since 11.0).
> +#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1114,7 +1119,8 @@
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
>              '*secure-tsc': 'bool',
> -            '*tsc-frequency': 'uint32' } }
> +            '*tsc-frequency': 'uint32' },
> +  'features': [ 'confidential-guest-reset' ] }
>  
>  ##
>  # @TdxGuestProperties:
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


