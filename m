Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D8C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQBp-0000YB-BH; Thu, 16 Jan 2025 08:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYQBo-0000Xy-4c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYQBm-0004B9-Km
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737035136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwgpN6DDOqWs+rEQ8j/WTxRboXSBmmR3o7o0MPgNNTo=;
 b=GeTiwiNPBvN6mOq8HjTZsSjZgSMRoO/465JfhixaUL/dycdnGo02Kw98g4MwOWTSquH0F0
 AHrGRKrTA7AUi/tm4Y8wnNTurhyYItRwVXUN5WGRWujLV063WDyHVgEPoaC0UbSY7HgVQa
 AllNx59YLHOFWiTpOkRoc6cGesUe46k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-73IcjZh9N7a4ksUmeqb0oA-1; Thu,
 16 Jan 2025 08:45:31 -0500
X-MC-Unique: 73IcjZh9N7a4ksUmeqb0oA-1
X-Mimecast-MFC-AGG-ID: 73IcjZh9N7a4ksUmeqb0oA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 718691955D81; Thu, 16 Jan 2025 13:45:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DCE71955F1B; Thu, 16 Jan 2025 13:45:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69C7721E6924; Thu, 16 Jan 2025 14:45:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  alex.bennee@linaro.org
Subject: Re: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-flat
In-Reply-To: <20250107015639.27648-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Tue, 7 Jan 2025 01:56:39 +0000")
References: <20250107015639.27648-1-gustavo.romero@linaro.org>
Date: Thu, 16 Jan 2025 14:45:24 +0100
Message-ID: <875xme27pn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add me as the maintainer for the ivshmem-flat device.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2101b51217..461f98525b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2785,6 +2785,13 @@ F: hw/hyperv/hv-balloon*.h
>  F: include/hw/hyperv/dynmem-proto.h
>  F: include/hw/hyperv/hv-balloon.h
>  
> +ivshmem-flat
> +M: Gustavo Romero <gustavo.romero@linaro.org>
> +S: Maintained
> +F: hw/misc/ivshmem-flat.c
> +F: include/hw/misc/ivshmem-flat.h
> +F: docs/system/devices/ivshmem-flat.rst
> +
>  Subsystems
>  ----------
>  Overall Audio backends

I missed this, and it's been merged already, but I'll ask anyway: would
you be willing to maintain all of ivshmem-pci.c, too?


