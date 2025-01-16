Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCF2C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPAz-00005N-I5; Thu, 16 Jan 2025 07:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYPAl-0008UI-OW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYPAj-0003dH-UF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737031229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iBjPR3V1IWujIeNx1ikIVImipKb5BNuaOQax++1CYfs=;
 b=e28f3UR0a/mK7cj2L1EqsZHv8p4Ja2IG24oRUeDzj4reTinY6yYfzNMxeP52w1U9htMjDj
 y/7n67GBialr6IDiWHvRHs3G/j1sXTmm54gXM9eDuKuovsBwCXZ+wrGoyZayvMrvNo3KPR
 JHqdiqpjlFQNvMl3Gk7HId1laPaMYEQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-qEUoemckMjm6zTA1RVdfWQ-1; Thu,
 16 Jan 2025 07:40:27 -0500
X-MC-Unique: qEUoemckMjm6zTA1RVdfWQ-1
X-Mimecast-MFC-AGG-ID: qEUoemckMjm6zTA1RVdfWQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ECED1955DB9; Thu, 16 Jan 2025 12:40:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18C8019560A3; Thu, 16 Jan 2025 12:40:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1C9A21E6924; Thu, 16 Jan 2025 13:40:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Boyang <zhangboyang.id@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/ui: Fix documentation of upper bound value in
 InputMoveEvent
In-Reply-To: <20250116104433.12114-1-zhangboyang.id@gmail.com> (Zhang Boyang's
 message of "Thu, 16 Jan 2025 18:44:33 +0800")
References: <20250116104433.12114-1-zhangboyang.id@gmail.com>
Date: Thu, 16 Jan 2025 13:40:23 +0100
Message-ID: <87ed136ifc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Zhang Boyang <zhangboyang.id@gmail.com> writes:

> The upper bound of pointer position in InputMoveEvent should be 0x7fff,
> according to INPUT_EVENT_ABS_MAX.
>
> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
> ---
>  qapi/ui.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 460a26b981..7b18662018 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1133,7 +1133,7 @@
>  # @axis: Which axis is referenced by @value.
>  #
>  # @value: Pointer position.  For absolute coordinates the valid range
> -#     is 0 -> 0x7ffff
> +#     is 0 -> 0x7fff

Opportunity to replace "->" by "to" or "..".  If you agree, I'll squash
that into your patch in my tree.

>  #
>  # Since: 2.0
>  ##

Acked-by: Markus Armbruster <armbru@redhat.com>


