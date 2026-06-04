Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E8ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7uJ-0003mF-Nj; Thu, 04 Jun 2026 09:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7uC-0003li-2v
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7u9-0003SQ-FA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780578875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzdeMkmRR6u+Xki1DBAyFenxguxAzmukRmAQ237gPDo=;
 b=XJR4LYJSfEVLvsesmeMjZX8rykuqI3R/r6y37uWTmLql6wy4qZvJCU823YFDgLfrKcI3kb
 RgTn46kTY6HKO2vUuEzKWcRC3cuT6Mk9hx4yeFCIbCi9K9YoYnnCpoz8CPYobYhDdatxyM
 FI1rmaBce5FMAIigV4jdCZZiafx0yFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ozOL5YGsNdqqs7AeY2RXwQ-1; Thu, 04 Jun 2026 09:14:32 -0400
X-MC-Unique: ozOL5YGsNdqqs7AeY2RXwQ-1
X-Mimecast-MFC-AGG-ID: ozOL5YGsNdqqs7AeY2RXwQ_1780578871
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so5222885e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780578871; x=1781183671; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JzdeMkmRR6u+Xki1DBAyFenxguxAzmukRmAQ237gPDo=;
 b=dhnQAbDqi8IEbzF+/7nJehNa7p/he8UfrScSMQz+did2mKr8mKt9rw+cuuIcIbM3Y2
 uZ/kxAtfbbQjrTmuHSO0/XJjv4HJaUfjAs5o7/9botwi4yun8LBsxfiNsNFUah4NoqWt
 ZhF0ooiTk65z3HdksRH03wjJjrsZX2oM9nxUKpohNJqb7czb8z9gV5qV9X6Ob5q4fzRY
 OWLTDfu5nIgsCiP/9mtTZrVHAGeXRwsoPHYjMzu9nWpMjhvZtAHJZvbb7m1NvbuGisj+
 MbK96OJ7FG9rZhAyzF2zxWLFx3MDO5L0GVePS0Hzljooeq26LMQQ1K4Ovj7l9lM5QtrH
 Pqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780578871; x=1781183671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzdeMkmRR6u+Xki1DBAyFenxguxAzmukRmAQ237gPDo=;
 b=XUCU65c99JfzOfHMDUW0EXSvBwJ/ug/3j8IBXZfCBp+QWBbTh1X+tTLKH0LEXssxpM
 kvORThVv7wxRfLpfGX0/pUIx0fiygYNKgXmLYUXX4dY5jgfLb6P2mcECeZHNkS0GlFnO
 sTcJDcF3MxovYrqELec9nDEdrxi8flP6nOvGU+Jf5CuCHmNFHEjkU8deCaI5/mKv+Sle
 QVpe9JjnuTs4fdpyKYFHPJSTnmu3X0mRhhD84RT6oV4JyJoQJkasZQoX8VYK3d75QPnk
 AzA2g4/OTlAhsvTGbCn74mbKMxOf8Jt5SVE7T9xzbgjN/fIO1mG5eZAlUcz3i3xiZihT
 xvxg==
X-Gm-Message-State: AOJu0YyI9DEfr2lZMoJlQeSDnn/y3l8RYbuFDjbH4ShHhYqphffQUiBO
 kYOeVJCCJ3fUJVlhWeUO1g4hbjgbALESNpWki7m8DkafcK6RZm6nrDuJfZF3S+xPjkoOOeTkHDq
 4u85ocf4TDMq1E91+Hp/0XhHNiIoak5SI7WaGF0r4Byg1/3g2biQo7iAI
X-Gm-Gg: Acq92OGdi53O/an2nX/nwG7uV+iD6tRWs7M29uQfz9gA5BKRnz6Hsilpzse4LKcdpv6
 p0+vhc4gl17ZR7kMvq+kkNYt6IGJakNQ1RSzfjqAiUTdt37NwVXGEY7r3Oog9OYZW6LFA+mRCnc
 yT50vd6ZjBCOgrxVpTeAP8slHX2NHRHlPian5Pv0a3NMlhnSQvSBX5FZC64KCTyYIpqUtmNRGzK
 TM4GrpuHTq6qAjXPu5zFXauXj497ScwVhIdNbiAT1utP/NAKtP6hpLpNO+vEh9Gk/QtD75K8RD3
 UMEqbmWmqIBbsTLZ/rh/YFzh1pIz6cDR8GZAkArvdHgQ1HdoeBrRLRy1+0qRAMsRNrkpxF/PYYq
 ZIk2mxYf0Cmq7yH1ay6sZS1FUjFzgyVYoOGCQnBl0T4CRXBoUF1AJHqDcm5HKu2EvwDOb8B8LJ9
 pRGAYxYg==
X-Received: by 2002:a05:600c:a306:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-490b5e9629emr101407035e9.6.1780578871526; 
 Thu, 04 Jun 2026 06:14:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a306:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-490b5e9629emr101406565e9.6.1780578870998; 
 Thu, 04 Jun 2026 06:14:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e5a00sm73410145e9.15.2026.06.04.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:14:29 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:14:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, 
 pierrick.bouvier@oss.qualcomm.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 20/38] MAINTAINERS: Fix F: in "vhost"
Message-ID: <aiF6Kjl4hzxaP6sZ@sgarzare-redhat>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-21-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260603064032.3733394-21-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 03, 2026 at 08:40:14AM +0200, Markus Armbruster wrote:
>We neglected to update MAINTAINERS when we moved files from rename
>from docs/system/devices/ to docs/system/devices/virtio/.  Update it now.
>
>Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-10-16)
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 0c952b710b..f421a3ecdf 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2397,7 +2397,7 @@ R: Stefano Garzarella <sgarzare@redhat.com>
> S: Supported
> F: hw/*/*vhost*
> F: docs/interop/vhost-user*
>-F: docs/system/devices/vhost-user*
>+F: docs/system/devices/virtio/vhost-user*
> F: contrib/vhost-user-*/
> F: backends/*vhost*
> F: include/system/vhost-user-backend.h
>-- 
>2.54.0
>


