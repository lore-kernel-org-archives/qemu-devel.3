Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B68C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 08:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4FJf-0002qf-KD; Mon, 14 Apr 2025 04:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4FJe-0002qW-6f
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 04:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4FJb-0001M7-Ma
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 04:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744619829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clXfms0hMcngIHUh9hMc6jy0AMhEWH3gKFMs3m4gZ1k=;
 b=QpdqBYszftI9m9zzuHux1Ohrm/kv8dIbTTbiHEH9kQIjcMAw1Wad9rD+99PNk6OXX1Iem9
 t7gAIeVkq9gXZDhGXVlJU8fC1jGyJsLC3LLjOdgKjAPc3UjdMlUZxJXf70bwBDK5mphCTI
 Ocv4cRGv02isTwkgfzA9F4NLSo/LflI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-B4kvsl9yPNq6erXrx7JZdw-1; Mon,
 14 Apr 2025 04:37:04 -0400
X-MC-Unique: B4kvsl9yPNq6erXrx7JZdw-1
X-Mimecast-MFC-AGG-ID: B4kvsl9yPNq6erXrx7JZdw_1744619823
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59D041956048; Mon, 14 Apr 2025 08:37:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A22B1955BF6; Mon, 14 Apr 2025 08:37:01 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:36:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, philmd@linaro.org
Subject: Re: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit
 emulation
Message-ID: <Z_zJKWY8dxNtLMzq@redhat.com>
References: <20250412164315.36161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250412164315.36161-1-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Apr 12, 2025 at 09:43:15AM -0700, Richard Henderson wrote:
> With acce728cbc6c we disallowed configuring 64-bit guests on
> 32-bit hosts, but forgot to document that in removed-features.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/about/removed-features.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 2527a91795..790a5e481c 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -858,6 +858,15 @@ QEMU.  Since all recent x86 hardware from the past >10 years is
>  capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
>  be used instead.
>  
> +32-bit hosts for 64-bit guests (removed in 10.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In general, 32-bit hosts cannot support the memory space or atomicity
> +requirements of 64-bit guests.  Prior to 10.0, QEMU attempted to
> +work around the atomicity issues in system mode by running all vCPUs
> +in a single thread context; in user mode atomicity was simply broken.
> +From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
> +
>  Guest Emulator ISAs
>  -------------------

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


