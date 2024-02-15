Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61108C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raby9-0007WI-CB; Thu, 15 Feb 2024 08:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raby4-0007VN-GU
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raby2-0007Vy-9C
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708004395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JwEKdMYEpj6fK5lDYvN6urpWzhaFZHhAxUCu7YQgX8Q=;
 b=BGkw17jp7ozcyNiEfITBcHbgxNVBHyFIFNd11Wl07Ud+uvwDJVZHtuNWjdgt95Wb8Lhqi/
 XWPCHD1K3/Ib8WaznulWDw03Gyq4nTawj6uZZKbGmIQarsMtYMWhQO4Dwh7Qz6zi2xblVj
 yt4tKJVYUnRLhrgOP/dCtbwhSZB+zSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-G4BbYrRcM_Wn_1sXgpi_Kg-1; Thu, 15 Feb 2024 08:39:53 -0500
X-MC-Unique: G4BbYrRcM_Wn_1sXgpi_Kg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-410e6b59df4so5565945e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708004392; x=1708609192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwEKdMYEpj6fK5lDYvN6urpWzhaFZHhAxUCu7YQgX8Q=;
 b=gf1jJ4iACGVaKCLha7UFbf3d5NnB/nMF6Zmm4lWU6G47JXacS/Cou/kaiYkxhpoFRE
 Q1ewYL02xNd4RyA2avKtB9wGKoGD7oFf570wrEAx7On6p/g76lAowu34Xm3ER3jBm+88
 OJZJFj/Al8WQekRc4/bSNGfED/wQsUVJidNrfEa2QXtQFo+HmD4R65b0pyHrAZlwz70W
 gd1a/6CdFz8ZvyBig8nGp+VMqUHWen9iQ5MDKukrJ6uMBmvMXrkvEpax03ddOLcrNvLk
 lQXywN8g1yPPTnIv2Pq68YEKLr98hdx19I+dMdDA8dfKfnilqnTujGqPgHRVdDzwpMNG
 9qdw==
X-Gm-Message-State: AOJu0YztoLvfcDQbBIV2aecM3UN276M/TRqd8sXyTOfITJZU69THzFWa
 K3NUllLBLx+HGI7MZ1NN4fpkCLY1TWHypmdhvT0IogXC/EPKR/pTtibJCmYzVHf94NOibarU91/
 4mwB3MqLh+vo1t506cJV4QRNJuMgUYgpoUVKnkRn3eaqJo99RmgGW
X-Received: by 2002:a05:600c:4f06:b0:411:dd82:a27a with SMTP id
 l6-20020a05600c4f0600b00411dd82a27amr1457372wmq.39.1708004392254; 
 Thu, 15 Feb 2024 05:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2Q9wqapP0RdX4IUpJg4ArkGh1Bz8wDuKSwukBfh0wP9SgWfSTwnJCppFs5GVp5Hdlges+PA==
X-Received: by 2002:a05:600c:4f06:b0:411:dd82:a27a with SMTP id
 l6-20020a05600c4f0600b00411dd82a27amr1457358wmq.39.1708004391959; 
 Thu, 15 Feb 2024 05:39:51 -0800 (PST)
Received: from redhat.com ([2.52.14.124]) by smtp.gmail.com with ESMTPSA id
 bd27-20020a05600c1f1b00b0040fdf5e6d40sm2173810wmb.20.2024.02.15.05.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 05:39:51 -0800 (PST)
Date: Thu, 15 Feb 2024 08:39:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PULL 00/60] virtio,pc,pci: features, cleanups, fixes
Message-ID: <20240215083907-mutt-send-email-mst@kernel.org>
References: <cover.1707909001.git.mst@redhat.com>
 <39efcede-002c-49e6-be36-6637f3cb16fa@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39efcede-002c-49e6-be36-6637f3cb16fa@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Maybe add

On Thu, Feb 15, 2024 at 12:20:53PM +0300, Michael Tokarev wrote:
> > Akihiko Odaki (2):
> >        hw/smbios: Fix OEM strings table option validation
> >        hw/smbios: Fix port connector option validation

this

> > Dmitry Osipenko (1):
> >        virtio-gpu: Correct virgl_renderer_resource_get_info() error check

and this


