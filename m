Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D32BC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53u7-0006nA-71; Thu, 09 May 2024 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53u3-0006mf-8p
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53u1-0002Bs-MH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iua3JdzIdw6O78cVg2+naiEHVSXA0r4DgbdGeYZsn6Y=;
 b=i/qEU0n6Bz3GvQbQ96pLzXmCRSz57T0Ygo2CUt+44hw3IZ6ympr9KfO/NOSi32RY0/cHgw
 ZWUzVtQuhE4wm6Sw7hffs1I8P3SrO6fE4sgW8+bpAVugbBuOBGXwvI9fSZeZkcVtM4pvHS
 Pni2Xdoe2VrkSz1l1lHbTRL8rPgTvzo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nTVHSEcbNeK6ND00tCukGA-1; Thu, 09 May 2024 09:33:38 -0400
X-MC-Unique: nTVHSEcbNeK6ND00tCukGA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a0e61203ecso3444116d6.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261618; x=1715866418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iua3JdzIdw6O78cVg2+naiEHVSXA0r4DgbdGeYZsn6Y=;
 b=qqNS0VB6nDcGCSfSNeKHM7gZP0VV1mrO0cAE4ddtQSIV6zc0XywI+Z5NPmyucmRzYF
 b1cfQTYyzxBoS9v13WUP3Hwai3xGQOHhfdPoNzSkiaKT7LRSd8yMFzAl30+uQtC9M0Bc
 i1mQf/0JXh/MNHhvvmojoO7eqJ6d1SVn+qRtRnp80EI0IdlqNvEDc7drvydg2b/4YP9u
 pUizjUgapRMqXpyBHDXTDrgYKHhGLytHzmPvuY9TTTvlcWMDFLUohnmSnWC/hI/HnsOY
 8mE16Ij00eQd7xzo/BpCp6VOioZsokfKqBJWw8jGZlNmUrnl6xl+RyUtRHgcIIQw2DAJ
 2n4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2hgC1HsHwRPdp0kT2BRBPJz1VFrYoU0zaWfCRRjn+ON6rTDcEtzutaX8yvQ7tMvMiPYi/aaYHkxNOPUMpThKCV3jHvGk=
X-Gm-Message-State: AOJu0YzoulLYBeIcNAB8+kekmkLfiH7nVWJHcUB2nMQgipZbHvBk6uIS
 6ioGX/F0QcuWaa0yTxX/UHZmu/x5JHo+7cz8M75PKmzxmBfnagj3F2EXaBR2lGJ78m+vI63Yh3u
 dJOMavrHuDRPnRCZSYWPPgtVfXFkENv/ZApNzADBhQPY05vAOjxqi
X-Received: by 2002:a05:6214:3006:b0:699:dfe:6015 with SMTP id
 6a1803df08f44-6a1515b3f56mr60734816d6.5.1715261618032; 
 Thu, 09 May 2024 06:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW19Jowy3dm41Og4T6ZT+F1w2MWElYS00AJSb8so8sFhM/brA3Us8citCEiYb7I7zJHZDPHA==
X-Received: by 2002:a05:6214:3006:b0:699:dfe:6015 with SMTP id
 6a1803df08f44-6a1515b3f56mr60734526d6.5.1715261617420; 
 Thu, 09 May 2024 06:33:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d73c8sm6969486d6.118.2024.05.09.06.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:33:36 -0700 (PDT)
Date: Thu, 9 May 2024 09:33:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>
Subject: Re: [PATCH 1/3] migration/colo: Minor fix for colo error message
Message-ID: <ZjzQsNf3nntf_t_C@x1n>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509033106.1321880-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 09, 2024 at 11:31:04AM +0800, Li Zhijian wrote:
> - Explicitly show the missing module name: replication
> - Fix capability name to x-colo
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


