Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36319CFA74F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMMm8-0000A2-VR; Fri, 21 Nov 2025 03:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMMm1-00008j-6I
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMMlz-00023l-9N
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763714741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6rIhnXTGKZ1U5QbNhc3t1qxyrEnC23C5fhuQq/uSkY=;
 b=FrQVRQpNgEp0GNhcmpR0GwIMhlB9vROqjBK2DXjxc9GFY+6l4z12xCBegmAbGrB72QnH+k
 gWzkJHlrIRM+AmgAv8Uuslbs0lRQ2T+LgqbKCG2xCNNRWnR8Ps1WpIPcNDxjGRT65jObtd
 l0KQkxbz/DunbJVMndO7XtswxWpzbSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Tf5YfYh5PeC8nJgLoQUzgg-1; Fri,
 21 Nov 2025 03:45:38 -0500
X-MC-Unique: Tf5YfYh5PeC8nJgLoQUzgg-1
X-Mimecast-MFC-AGG-ID: Tf5YfYh5PeC8nJgLoQUzgg_1763714737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0E3618001D1; Fri, 21 Nov 2025 08:45:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F1FD180049F; Fri, 21 Nov 2025 08:45:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD7F421E6A27; Fri, 21 Nov 2025 09:45:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  devel@lists.libvirt.org
Subject: Re: [PATCH] docs/deprecated: Remove undeprecated SMP description
In-Reply-To: <20251121084416.1031466-1-zhao1.liu@intel.com> (Zhao Liu's
 message of "Fri, 21 Nov 2025 16:44:16 +0800")
References: <20251121084416.1031466-1-zhao1.liu@intel.com>
Date: Fri, 21 Nov 2025 09:45:33 +0100
Message-ID: <87ikf3ojte.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:

> "Unsupported 'parameter=1' SMP configuration" was proposed to be
> deprecated in the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate
> unsupported "parameter=1" SMP configurations").
>
> But the related code was reverted later in the commit 9d7950edb0cd
> ("hw/core: allow parameter=1 for SMP topology on any machine").
>
> Thus, this SMP behavior is still valid and is not actually deprecated.
>
> Remove outdated document descriptions.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  docs/about/deprecated.rst | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 03e29915f0aa..bbfcce4a1ab3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -54,20 +54,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
>  However, short-form booleans are deprecated and full explicit ``arg_name=on``
>  form is preferred.
>  
> -``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -Specified CPU topology parameters must be supported by the machine.
> -
> -In the SMP configuration, users should provide the CPU topology parameters that
> -are supported by the target machine.
> -
> -However, historically it was allowed for users to specify the unsupported
> -topology parameter as "1", which is meaningless. So support for this kind of
> -configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
> -marked deprecated since 9.0, users have to ensure that all the topology members
> -described with -smp are supported by the target machine.
> -
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------

Reviewed-by: Markus Armbruster <armbru@redhat.com>


