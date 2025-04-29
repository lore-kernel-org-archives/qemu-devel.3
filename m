Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E5C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9q8s-0006X5-6L; Tue, 29 Apr 2025 14:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9q8n-0006SM-JM; Tue, 29 Apr 2025 14:57:15 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9q8k-0007Kr-3D; Tue, 29 Apr 2025 14:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745953012; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hj8bY+8qWDtVD0ThbUrV5Mp/C7T2oaIhDhOu5MbWyeyBAbDezvN/NBkHaV6jADADTVf0LHivRLlbIiVq1oOHDnY7I9vgqPAnGbcZhWf/jEYsgWpbA+rHpT3yW8WgAyUGB1R5HRerura7VA4J2Fr8J63h3fdEeSEYO3DdHJAq0pQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745953012;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xknWTEB7yvoubiG4cKQIwcY0VebPt0mmtLezT0eqyFs=; 
 b=FZff2QoX2yUQ6qZW2uizJwmPmnpPgeEAkQ1828RUXzF2p+p9Ub0QnczKWSpEsZy+ZARCMrLxj3m+3m+Mn8Z5B7aYBdEnNeOA0/0CW3G0/gzlFbwqKZnXm7/V2z2NSWCqr3Ip4hHEEvvVvL3sqPzqWvgYKYv8uyJcFXsNzHkBcCo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745953012; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xknWTEB7yvoubiG4cKQIwcY0VebPt0mmtLezT0eqyFs=;
 b=YLztQpros48pfl3txC8rwjdPcI6+b7BOOD7bOHdGrWVxfOABUgmV/NSq/o1FZ+5e
 pIcBwidk2EhGS7lMA6vNB/7NjvQqVsB6NaXpwTmB03TPB4kgNN+QZQZiWI+FqJejrTE
 CUjdFL6+gMsXbv9m6jSRCcQ1Tma/PpHlZe0e/1bI=
Received: by mx.zohomail.com with SMTPS id 1745953009629739.3299186013759;
 Tue, 29 Apr 2025 11:56:49 -0700 (PDT)
Message-ID: <9115fa7c-ed94-449d-816b-a13125275dac@collabora.com>
Date: Tue, 29 Apr 2025 21:56:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-7-alex.bennee@linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250428125918.449346-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/28/25 15:59, Alex BennÃ©e wrote:
> Seeing as I've taken a few patches to here now I might as well put
> myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
> it's not my core focus. If someone with more GPU experience comes
> forward we can always update again.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 661a47db5a..f67c8edcf6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2636,7 +2636,8 @@ F: hw/display/ramfb*.c
>  F: include/hw/display/ramfb.h
>  
>  virtio-gpu
> -S: Orphan
> +M: Alex Bennée <alex.bennee@linaro.org>
> +M: Odd Fixes
>  F: hw/display/virtio-gpu*
>  F: hw/display/virtio-vga.*
>  F: include/hw/virtio/virtio-gpu.h

Thanks a lot for stepping up!

This reminded me that I wanted to propose myself as reviewer for the
virtio-gpu patches. Will do it soon.

Akihiko Odaki is also good at reviewing virtio-gpu patches. Wondering if
Akihiko would want to be added as reviewer or co-maintainer of virtio-gpu?

-- 
Best regards,
Dmitry


