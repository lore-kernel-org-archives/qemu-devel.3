Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A3C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb1Sa-0007cd-8W; Thu, 23 Jan 2025 12:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb1SY-0007cS-9X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 12:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb1SW-0004jp-J1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 12:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737655057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY01VtmAdO32s2Ht8I5yPcJwMlOdP3aUvOdz2d4Igf0=;
 b=Fv4iC+giSB8carTV6/nEQgzHjwD3PgH6ENTvFGpJWZC4ATZkXrdjC7n66Z6mYqwp96D0lV
 +/uPviMGf6yyUB9tsPI92+MF1tm18n1rfIV74ibKpwXCxDs2va+Cu/m7jECRLI7Yhx59Pw
 rS5L5RR+9aX7u3T0bM5D57FB5dmzNy8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-SnTIMwCXO-u1DnKPU8kIbA-1; Thu, 23 Jan 2025 12:57:34 -0500
X-MC-Unique: SnTIMwCXO-u1DnKPU8kIbA-1
X-Mimecast-MFC-AGG-ID: SnTIMwCXO-u1DnKPU8kIbA
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46dd46d759eso21008141cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 09:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737655054; x=1738259854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jY01VtmAdO32s2Ht8I5yPcJwMlOdP3aUvOdz2d4Igf0=;
 b=HzZEKPC6GiJ51YviCreYf30zdoAmzeGa+a6/8Yy2sRsS4onuq8yv0EOGtQigZS8FQZ
 eCkKq735Y9fz/B20bcv37tfhXWJMOGMAPUkds9oK3CPOtiKJ6EX0llMToG16K+HU9yob
 BrRfr3NAi4I7oyRkOjwsC8VdioLn7avDzFXa9JoLdm4vJceJbG4W7Q/WNYKiVciJvZAz
 j1W3WMXu3RYDfjzXmx2135XJUt3CAtx/dLaBpQFQkxVlXMD9+ZpJS13Bp+eoFROLcDG5
 lCSFbDf7ue+bmZeqgl1ZuhGyr0SQLVehEJMELNan7kCmwWXtHz3eACFxj6gy6vRu6FTj
 pt/A==
X-Gm-Message-State: AOJu0YwDpnbL3esqtx8LyVKsLntHUMeSI7AWCbtNmp5B8ijSomiA3moK
 zBb1GbemGqWMpeZXaNkG7S8tYbxiVZ+ZCzvKDkXik5gJn+QkGabY405cPWKTxMdRBgMnL77WnyN
 B8QVSvpDKDxcS8RclMqosHW5m2OgPTjHExg4vlSTdpiVsOh+COddj
X-Gm-Gg: ASbGncshxpMzQa7437xA1m/SpCjKy4kbpcgFpkCb12SmuU+5+Ht/cZRzgXIp+lcogXY
 eWmjNfIJZGHCQZ48DGYxdZgYGUl5qEr/Zay7HgT9BZufeM+CcGZB0lr34nAck+buSOohYtPduFU
 KH0HcG2Pa6UfzPc3YyFVFW/gnsdnyEAiKE86z1kZoiN5oOEzoAgVLAfDaiIhABfwE/+K4VeL0TI
 GgiIRJwCenjijKZCpsBu6YF7NtThVzSIbIvGDEX4kpFAIBgB1QXRGPnqNnzKvWHPrFOmhH5jFch
 7VLa6X4paZfko8MabarCBiJxjAXx/i4=
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id
 6a1803df08f44-6e1b2235c9fmr438416926d6.42.1737655054289; 
 Thu, 23 Jan 2025 09:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq2KQ3U/xZsO/bVZWDxgYtp9EjjR3KSplTQx1lN/9OYFembhmd8z3FMUNd2CD5PJ+KwgfLMA==
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id
 6a1803df08f44-6e1b2235c9fmr438416516d6.42.1737655053999; 
 Thu, 23 Jan 2025 09:57:33 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c304dsm753926d6.110.2025.01.23.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 09:57:33 -0800 (PST)
Date: Thu, 23 Jan 2025 12:57:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Cedric Le Goater <clegoate@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Message-ID: <Z5KDC4RiimTBmb-g@x1n>
References: <20240117091559.144730-1-peterx@redhat.com>
 <79e908f3-3f93-4245-9e5e-25b8a1026322@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79e908f3-3f93-4245-9e5e-25b8a1026322@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 23, 2025 at 10:16:23AM +0100, Eric Auger wrote:
> I haven't seen any follow-up on this series. Is anyone still looking at
> this issue? Peter gave some guidance about the way to rework the reset
> chain. Is it still up to date?

I didn't continue looking at this issue since that time (and also stopped
working on vIOMMU stuff).  No plan to continue from my side..  I suppose
nobody else has either, or I should have got some email like this. :)

It may not be uptodate indeed, so may worth rechecking its validity.

Thanks,

-- 
Peter Xu


