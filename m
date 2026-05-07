Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF3CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKu6b-0000fA-9V; Thu, 07 May 2026 04:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKu6Z-0000bO-S9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKu6Y-000324-3q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778142548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpYbc4gD+vjYCe5HT+0CYrHX1w3gmYRi/ca5jND5y64=;
 b=PSxlYtg7BT6BKgT+8z5H2cCCJn8H2KR5cP17IJ73WPeF2CcSxTOJHWyUQWQb8xcJW9Hhkk
 OOmOu923D+UakULsAYY6sZZ3xW0lU/mZb6ZDRKKksRENG7YjLTWYKtPRxKLBSyu99SLyEd
 2nRm7W/UyOxxQSd6ErfhJ3Ix6vllBqY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-p-8I4P5eMLe_VCQGfPWrlw-1; Thu,
 07 May 2026 04:29:03 -0400
X-MC-Unique: p-8I4P5eMLe_VCQGfPWrlw-1
X-Mimecast-MFC-AGG-ID: p-8I4P5eMLe_VCQGfPWrlw_1778142542
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABED818002CF; Thu,  7 May 2026 08:29:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978661953947; Thu,  7 May 2026 08:28:58 +0000 (UTC)
Date: Thu, 7 May 2026 09:28:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?utf-8?Q?Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Doru =?utf-8?Q?Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: Re: [PATCH] MAINTAINERS: Add =?utf-8?Q?Dor?=
 =?utf-8?Q?u_Bl=C3=A2nzeanu?= as MSHV reviewer
Message-ID: <afxNRhpeEOYTldCX@redhat.com>
References: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 06, 2026 at 12:21:56PM +0200, Magnus Kulke wrote:
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Given this will result in Doru being automatically CC'd on patch
mails, it ought to have either a signed-off-by, or at least a
reviewed-by, from Doru to indicate they are happy with this.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index afa178c5cc..c6c0e1b4ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -587,6 +587,7 @@ F: docs/system/whpx.rst
>  MSHV
>  M: Magnus Kulke <magnuskulke@linux.microsoft.com>
>  R: Wei Liu <wei.liu@kernel.org>
> +R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
>  S: Supported
>  F: accel/mshv/
>  F: include/system/mshv.h
> @@ -602,6 +603,7 @@ F: include/system/nitro-accel.h
>  X86 MSHV CPUs
>  M: Magnus Kulke <magnuskulke@linux.microsoft.com>
>  R: Wei Liu <wei.liu@kernel.org>
> +R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
>  S: Supported
>  F: target/i386/mshv/
>  
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


