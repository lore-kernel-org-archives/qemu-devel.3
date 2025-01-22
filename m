Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7283C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVpw-0001ms-Nb; Wed, 22 Jan 2025 03:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1taVpu-0001mL-5r
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:11:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1taVpr-0001dW-Sh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737533497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/QYQIb4aknzNTLMQruMyBGVHqyMgKb3Go2q7r3+eWY=;
 b=J+5GrmQbIv2ar1Ao3RdiNVHVYbyPgAsOEiIhMSwYsmKuAbl2pi9Cfo4q9madWcLdUA53qa
 dLprDG1hy7Z2jFde2p8PC61BvslxQbjHOwPxbduu61rhPbolSQrAoQg4axUQaMt6kX+Uuf
 Pbu9rwwZmUHu6WnQ16TtBqIkApliYps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-qPEBeY0kNTa2REy6yGqG9w-1; Wed,
 22 Jan 2025 03:11:33 -0500
X-MC-Unique: qPEBeY0kNTa2REy6yGqG9w-1
X-Mimecast-MFC-AGG-ID: qPEBeY0kNTa2REy6yGqG9w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF5001956083; Wed, 22 Jan 2025 08:11:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C84195608E; Wed, 22 Jan 2025 08:11:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABEED21E6A28; Wed, 22 Jan 2025 09:11:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  alex.bennee@linaro.org
Subject: Re: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-pci
In-Reply-To: <20250122065201.629601-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Wed, 22 Jan 2025 06:52:01 +0000")
References: <20250122065201.629601-1-gustavo.romero@linaro.org>
Date: Wed, 22 Jan 2025 09:11:28 +0100
Message-ID: <87msfj6zf3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add me as the maintainer for the ivshmem-pci device.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 846b81e3ec..c3e69ef3e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2789,11 +2789,14 @@ F: hw/hyperv/hv-balloon*.h
>  F: include/hw/hyperv/dynmem-proto.h
>  F: include/hw/hyperv/hv-balloon.h
>  
> -ivshmem-flat
> +ivshmem
>  M: Gustavo Romero <gustavo.romero@linaro.org>
>  S: Maintained
> +F: hw/misc/ivshmem-pci.c
>  F: hw/misc/ivshmem-flat.c
> +F: include/hw/misc/ivshmem.h
>  F: include/hw/misc/ivshmem-flat.h
> +F: docs/system/devices/ivshmem.rst
>  F: docs/system/devices/ivshmem-flat.rst
>  
>  Subsystems

Please add

    docs/specs/ivshmem-spec.rst
    tests/qtest/ivshmem-test.c

and ideally also

    contrib/ivshmem-client/
    contrib/ivshmem-server/


