Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED3C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYxS-0004VP-A5; Mon, 26 May 2025 10:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uJYxO-0004Tr-RK
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uJYxM-0000k6-RF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748270254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6vT7plzL8+eh/pmrbveZn6s7JnfNWGZRNE3WQFB1rM=;
 b=Qqz7zm1diVDrfiEz0ALNXz+fk2kHplpOwP2fcE/J/brKjFeU1641YCkaCd37AeRnN1Q/eb
 lNLoQfQFdJ2YBXNwagBeGqY8z/SnsMQCLTE9TSoKNr7AYV1Fa2aFUl28mN+4wHSt5Inuij
 n68NaWRQAHV9ZxSzNKB1Z77+P/39SeE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-eBCQjo5VOO-Ehm4tSxwszQ-1; Mon, 26 May 2025 10:37:33 -0400
X-MC-Unique: eBCQjo5VOO-Ehm4tSxwszQ-1
X-Mimecast-MFC-AGG-ID: eBCQjo5VOO-Ehm4tSxwszQ_1748270252
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so13953835e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748270252; x=1748875052;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6vT7plzL8+eh/pmrbveZn6s7JnfNWGZRNE3WQFB1rM=;
 b=NQl0XT8S81khuxxFlkkqE6iXm0xUwww1G0vQkjJszBlREjc/MMCLyBDFHSlb31qq5Q
 B4KLbbQbtgxDrM80llgaX+0mmgWMLAgh1PR44q5jmoJj6GypIJsp3fAExY8oZW1RwcRa
 qMydPnJDdYR6ptfkbkIrV0eXs7j2Ij4BO+GfV/2F0PplJ6PCmAmVvVxBp/FI205847PX
 FuLRn/sbHbYxGzmCScu9pEDqiYQgZA77mxQsiPy0HIfcK7EykQr1W+wEcsSxj81zbd0V
 ryXU++uQAE5WVwIG9inb+C1NZnTxlDuymD9tdTAO5Xog5X2byjQ5xSjGIzjZoX2AFsf5
 u4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+YHq+mSqZfMJqUR4xG2O7IpZ5zzz1ZZIuwvyvIBcwc2uYRMduSBOPeOggS9aDAn791bT5gGm1ogbk@nongnu.org
X-Gm-Message-State: AOJu0YyNIMLq8kkuYhI2P2BlmJkx5KDU14bCQBNOByLZesJFDaVX0jHw
 XVR0lb2p3d2jdmq1yxZhvpy2W9oXv2Af6ZrGBgsq2dpm1D2N6fONWmr4EVh1J2qhB3wIv4DQ7OS
 MIXpehTLv5ts3Wi1duDxeld9gMd8s3/WFKsOc/eLPiotzqzNyHC/7yT22
X-Gm-Gg: ASbGncugVzGIfqLPLo6wmNev/s4+UpG5UmuCo1n5MqjOJHLf51LOzfPIHrKQ8uIAvHG
 WlLD5l9GvQVqvR8AKQcnN75YNzbx6OI6Pb5xhyIoMs6pccG9HbWVTnBhQm1EvblWU+I0IJsithH
 0zZp//hoKjMVLnxDFt/zlQyJi7t+xn+mLFrgmEebDcQpkMraxJtT82sDpMiRi8vr2GLaZGfnE7l
 0uGXzPI4znIxS7SZ/G2Y19iNYJoJfj4mpITM5FK6KmOaqEXkkwKDUqOpuF2PKoDn9fZ8sz5EzTB
 wBQ3gw==
X-Received: by 2002:a05:600c:35d3:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-44c93016587mr72338955e9.7.1748270251674; 
 Mon, 26 May 2025 07:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGakDjVkauGgQhNuw5iQP276znKcv7ouVrJOGb/8Nk5T7CZv8cSsqSFNysHVElKXQX4MqQrXQ==
X-Received: by 2002:a05:600c:35d3:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-44c93016587mr72338745e9.7.1748270251256; 
 Mon, 26 May 2025 07:37:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251c7sm239475825e9.3.2025.05.26.07.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:37:30 -0700 (PDT)
Date: Mon, 26 May 2025 10:37:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
Message-ID: <20250526103712-mutt-send-email-mst@kernel.org>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
 <bad3129a-8470-415e-8e85-0238b3ef1b26@redhat.com>
 <ef48d347-b36e-4442-b97e-bea284eab1ac@oracle.com>
 <304064d5-7211-443a-8ded-43f704a7ab1f@redhat.com>
 <bc0d41f3-752a-4797-ac61-6716d78a2aea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc0d41f3-752a-4797-ac61-6716d78a2aea@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 25, 2025 at 11:23:57PM +0200, Cédric Le Goater wrote:
> Michael,
> 
> On 5/20/25 15:46, Cédric Le Goater wrote:
> > 
> > > > > @@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > > > >       ram_addr_t translated_addr;
> > > > >       Error *local_err = NULL;
> > > > >       int ret = -EINVAL;
> > > > > +    MemoryRegion *mr;
> > > > > +    ram_addr_t xlat;
> > > > 
> > > > xlat should be :
> > > > 
> > > >      hwaddr xlat;
> > > 
> > > Will you make that change when you pull, or do you want me to submit a V6
> > > with this and the RB's?
> > 
> > I can handle it.
> > 
> > An ack from Michael (vhost) is needed for the PR.
> 
> Are you okay with us merging this patch via the vfio queue ?
> 
> This would facilitate the progress of 2 larges series : live update
> and vfio-user
> 
> Thanks,
> 
> C.

sure, thanks!
Acked-by: Michael S. Tsirkin <mst@redhat.com>


