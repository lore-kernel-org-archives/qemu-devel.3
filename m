Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB49CCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVsm-0001Sl-Vp; Fri, 19 Jun 2026 05:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waVsj-0001SO-Ff
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waVsg-0000C2-Fu
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781862680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mEVtJz7H9t+nOxELny5clyRxDZa4RQAWySWdtlX0yF0=;
 b=YOUYW1KFyvnMYoU3cG06G07RCdiMyjThIOeKOZFVZRi425tUcd14y+GN8XDqKyMGkHVAmZ
 AysBn3SFztjze99bzdqKGqx0EzESYeNG/S9+DFy6vWjOKkciQnY2GS7L6DpMEucO7VXBX+
 qy+/Ihmqgb+OiTDS4qZmNnkYrWKdq3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-di94uPLKP8OPaKfRYW1GpQ-1; Fri,
 19 Jun 2026 05:51:17 -0400
X-MC-Unique: di94uPLKP8OPaKfRYW1GpQ-1
X-Mimecast-MFC-AGG-ID: di94uPLKP8OPaKfRYW1GpQ_1781862675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24CBC1955F74; Fri, 19 Jun 2026 09:51:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.122])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55A8A1956041; Fri, 19 Jun 2026 09:51:08 +0000 (UTC)
Date: Fri, 19 Jun 2026 10:51:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Andrea Bolognani <abologna@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Sebastian Ott <sebott@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jinqian Yang <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [RFC PATCH v2 23/29] target/arm/qmp: add query-arm-cpu-props-info
Message-ID: <ajURCGaS94gwV_px@redhat.com>
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
 <20260605083358.1320563-24-khushit.shah@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605083358.1320563-24-khushit.shah@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 08:33:52AM +0000, Khushit Shah wrote:
> Introduce 'query-arm-cpu-props-info' QMP command. This command returns
> information about ARM CPU model properties, including their name, type,
> supported values on the given host, and composite parent if any.

Do we have to make this ARM only ?

x86 has named CPU properties too. They are all basically
booleans so this API offers a superset of functionality
needed for x86, and thus I'd expect x86 to be folded into
this new API too.

> This provides management layer necessary information to determine
> migration compatibility off a VM on different host.
> 
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  qapi/misc-arm.json              | 41 ++++++++++++++++
>  stubs/qmp-arm-gic.c             |  6 +++
>  target/arm/arm-cpu-props-stub.c | 13 +++++
>  target/arm/arm-cpu-props.c      | 85 +++++++++++++++++++++++++++++++++
>  target/arm/arm-cpu-props.h      |  5 ++
>  target/arm/arm-qmp-cmds.c       | 44 +++++++++++++++++
>  target/arm/cpu-idregs.c         | 71 +++++++++++++++++++++++++++
>  target/arm/cpu-idregs.h         |  8 ++++
>  8 files changed, 273 insertions(+)
> 
> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index 4dc66d00e5..1a3fb140c4 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -46,6 +46,47 @@
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
>  
> +##
> +# @CpuPropInfo:
> +#
> +# Information about a specific ARM CPU model property.
> +#
> +# @name: the name of the property
> +#
> +# @type: the type of the property, any of ('string', 'boolean',
> +#     'number').
> +#
> +# @supported-values: the set of values the host hardware supports
> +#     for the property, a list of strings.
> +#
> +# @composite: name of the encapsulating composite property if any.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'CpuPropInfo',
> +  'data': { 'name': 'str',
> +            'type': 'str',

This should be an enumerated type, not a string.

> +            'supported-values': 'any',

If these values vary based on @type, then this should
be a discriminated union.

> +            '*composite': 'str' } }
> +

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


