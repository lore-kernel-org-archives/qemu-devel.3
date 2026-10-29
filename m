Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hhZKkSGb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E6UL+Ewk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUuh-0004ua-Ll; Thu, 29 Oct 2026 14:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMUue-0004sg-76
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMUuc-0000R2-GY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793298701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIUkxXySNM6Ih39jeb3ILP6PAzVyi8Mogeq8NqCVZ58=;
 b=hhZKkSGbvg0qOrBI2rn4LeuMQmsdz3F7WKqYWFo+vXxy9IakzML7AdYdwqHdPPnjWnyipZ
 LCGdnilafVDTTs0ee+VM5gKO/qXWTnHqTO7XoTxiZ7wb34qt+QN87FWykKtYKlh4P2Kr8w
 J/zGD1jIZR56uftF3RpdNEmLPiLCoLs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-pBSuSGE3PPGv6u-YTq0gUg-1; Thu, 29 Oct 2026 14:31:38 -0400
X-MC-Unique: pBSuSGE3PPGv6u-YTq0gUg-1
X-Mimecast-MFC-AGG-ID: pBSuSGE3PPGv6u-YTq0gUg_1793298697
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a70b42bab0so11163345e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793298697; x=1793903497; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rIUkxXySNM6Ih39jeb3ILP6PAzVyi8Mogeq8NqCVZ58=;
 b=E6UL+EwkyQQZZOeTSLE0ZZmmIi7zPVavHVnux12s5UeD+85j6ux6bwU8d7Fj1Y5JkN
 P53kIAzVTbOUAl8GJ9NFyaqZYt+p5CaIY+W35QUMeY212fzagsPmPSazbz/BpuCGusug
 03gDDE4hE8Sa03TLEiAqNkzQ9E/FjRgmoY0PXuKXhJGgkitJ+6k84QuT47ko610rgEYo
 iNPbkF1LfISyHp/hIINJw0ZKYHWNBYP2TFAyzRD4u/pxqAXoLvC8fau6FWSqmndPU24i
 Yx4hucFO7kBgP8cai1KrogM5my+PXbRaOIr8rD/JsM+ssn5ZeVrTJYzrAaSiCTOWXY72
 HYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793298697; x=1793903497;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rIUkxXySNM6Ih39jeb3ILP6PAzVyi8Mogeq8NqCVZ58=;
 b=Dn7mRyH0V+wKJ79L+thTdpj7popzfKGK2p5nOZo1pQnOtJlArhRLqrrxyOrnIoqh1J
 zSUA7iFnbq4H1VnQaUwn4n7e1UFEVqZ8rYOHRK10LulpMGpUu/60SO1zX6iobXvoaqy6
 t+kNjjGS5gJHr4ZpjojZeJVfR0iEgROvUgmL7adXP0HGRAWDNjHFYMH/qOCeWzc6jSiF
 AdPx8KIvLM546pkk02hf3UhKlrZcmJShVuM8vjylwCvHvpWcJFlK7I21fIWu4oXOF4xq
 lC8nFbV88cPiQIKG940oSvMUf2TzAGgw165wyJr4lxe8UMbOMOrXaoU64rc6LJgJGXns
 bfnQ==
X-Gm-Message-State: AFq9FYIDp/4RFk54FOqMg8ahwEkMzHlaM3HQC2dYWSDopPcoctveRKoX
 WZXPoPMetUL9SeblrtsKte7qQEGRC2GDnf9rw8J8Lpbw5eHnqpBe2LEhlDbWFA/+CPFQfb0lRpx
 UrMf2PI+z20ASvu7LQujT4iZBQ7h4k7G8bZ9zRIp3wdWFKynjQx41vXx1
X-Gm-Gg: AYBFou3glTxm0mA6c+Z+AXqRHZ7+XEVVaWqYm7xpdSKpMa8z7H0lOEG0HathAixk2vi
 bl8xkaWsf6BPLtuyculNYKLRZaJJlY4DKkJAQzI4Y8kaEwMygSQlmPol4I5/avoIK7cP4wqLL4w
 ilSN3I+m/Nl6YXi64WwvgfHUIjLyyGUpgjBiKVCtuurcJe++xr+AHs4wDMQU2mIUIL6+rFJhgU/
 yTK/OAptm0/kMerUiLPdXNHijbiA5rESNk00LvcXYYyelxRBQsUtk+rcZjLJTayekHBvw7fL33T
 5Gbwph+AqJLhvsvMxy3AL+mHYKjmxrpT89EUaFCducDPz1FshcXLV4aIj5SZaKOz234dtyrC+fx
 lYhq3Bhvvw228410EO46m/sy2FxOV2UkAmYJLL3tR6aGu
X-Received: by 2002:a05:600c:6cf:b0:4a2:c41:d85b with SMTP id
 5b1f17b1804b1-4aa8b060ac7mr67655025e9.17.1793298697194; 
 Thu, 29 Oct 2026 11:31:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6cf:b0:4a2:c41:d85b with SMTP id
 5b1f17b1804b1-4aa8b060ac7mr67654385e9.17.1793298696692; 
 Thu, 29 Oct 2026 11:31:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eb82419sm105601f8f.29.2026.10.29.11.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:31:35 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL 00/78] pci, vhost, virtio, iommu, acpi: features, fixes
Message-ID: <20261029142810-mutt-send-email-mst@kernel.org>
References: <cover.1793207602.git.mst@redhat.com>
 <16d3c4db-6548-4c68-acd3-2eddb59cab5b@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d3c4db-6548-4c68-acd3-2eddb59cab5b@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:45:59AM -0500, Richard Henderson wrote:
> On 10/28/26 12:13, Michael S. Tsirkin wrote:
> > The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:
> > 
> >    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to c155e7e9e025b60ce17e26a7c382d86f3f9c9fee:
> > 
> >    virtio-net: add mtu-from-tap property for automatic MTU detection (2026-10-28 13:11:16 -0400)
> > 
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu, acpi: features, fixes
> > 
> > multiboot can again load 64 bit images
> > vdpa-dev now implements guest_notifier_mask/pending
> > pci bridge can now configure the negotiated bandwidth
> > tap can now auto-detect host mtu and expose to guest
> > amd iommu can now attach on non system bus
> > vhost-user spec now has its own mailing list
> > 
> > Fixes, cleanups all over the place.
> 
> New failures:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17577211343#L867
> https://gitlab.com/qemu-project/qemu/-/jobs/17576922092#L185
> 
> Use of sudo in containers where it is not installed
> (functional-system-centos, functional-system-opensuse).
> 
> 
> r~

I dropped the test patch, thanks!
head at 592bb52d87a1a07172656a91cf5c38f63b5f6c60 now.

Vladimir, pls look into fixing all this up.


-- 
MST


