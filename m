Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4454CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHpj-0003gq-6j; Wed, 24 Jun 2026 03:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcHph-0003ZN-Eb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcHpf-0004WG-QZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782285334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gC8varPPugrJv42WtwiXs7eU3AN4FnnXELP2ubcVNBM=;
 b=N/BkFU7vBf24kxxSAplTRknyvG/daumLyrmsCbRUs27wjTWNPuy99YnHp5XY9CX7DutkvM
 AjK7hB/LRnNXP2QFQhOf6hmiCG9fWBOp8Rnfkv6uPIxjmnwNuPxp162pJ0lXRFMaZ2Zk6H
 gWaJzRb08z8c4yqq7SJc7NzsNYh4pb0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-TjSYg2CiNsaskIXEIss4HQ-1; Wed,
 24 Jun 2026 03:15:30 -0400
X-MC-Unique: TjSYg2CiNsaskIXEIss4HQ-1
X-Mimecast-MFC-AGG-ID: TjSYg2CiNsaskIXEIss4HQ_1782285329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 380A21956056; Wed, 24 Jun 2026 07:15:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.57])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 999C3180034F; Wed, 24 Jun 2026 07:15:25 +0000 (UTC)
Date: Wed, 24 Jun 2026 08:15:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Linisha <linisha232@gmail.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Subject: Re: [PATCH] docs/system: clarify pflash0 and pflash1 are virt-only
 options
Message-ID: <ajuD4L_ZDEg8TI2R@redhat.com>
References: <20260623205839.1294-1-linisha232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623205839.1294-1-linisha232@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, Jun 24, 2026 at 02:28:39AM +0530, Linisha wrote:
> The pflash0 and pflash1 machine options shown in the Aarch64 virt example are only available for virt machine types on Arm, RISC-V, and LoongArch architectures. Add a note to clarify this for users who may try these options on x86 machines and be confused when they are not available.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3254
> Signed-off-by: Linisha <linisha232@gmail.com>
> ---
>  docs/system/introduction.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index bec7291e47..0c400aefb6 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -158,6 +158,12 @@ virtualisation so we can use KVM inside the emulated guest. As the
>  ``virt`` machine comes with some built in pflash devices we give them
>  names so we can override the defaults later.
>  
> +.. note::
> +   The ``pflash0`` and ``pflash1`` machine options are specific to the
> +   ``virt`` machine type on Arm, RISC-V, and LoongArch architectures.
> +   They are not available on x86 machines, which use ``-bios`` or
> +   ``-pflash`` for firmware instead.

No this is wrong.

The pflash0 and pflash1 properties apply to x86 pc & q35 machines too.

-pflash is a legacy syntax which remaps to pflash0 and pflash1 internally,
but also applies to other machines which don't use the new pflash0/pflash1
properties.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


