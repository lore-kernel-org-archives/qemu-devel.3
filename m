Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF24CC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 21:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRHDd-0002Tr-44; Mon, 16 Jun 2025 17:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uRHDW-0002Sk-Dn
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uRHDT-0005Kz-KM
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 17:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750108686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0krcWH+oX1VPWcxsC+mPFwkaqla2v62qu06n2N8lzIA=;
 b=EeMaxtEJ7P2YFB4a5nfCsSu7nV0hTPFuKas94bL1HUwVsxIJv2bb2eINMuC4mO1JH9GKso
 hded8bNjEZMdI4I4omcyztLHcoDhnvtp/23W0HYAaoL+1zL/7t9Ij8EFq/giQGilWYn8vc
 Ypet/KFhQ1uD7H7tj0tFx6qXI1TEICM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-ikDIXzl2MrOwlvJlH5ArGQ-1; Mon, 16 Jun 2025 17:18:05 -0400
X-MC-Unique: ikDIXzl2MrOwlvJlH5ArGQ-1
X-Mimecast-MFC-AGG-ID: ikDIXzl2MrOwlvJlH5ArGQ_1750108685
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fabd295d12so80838426d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 14:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750108684; x=1750713484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0krcWH+oX1VPWcxsC+mPFwkaqla2v62qu06n2N8lzIA=;
 b=uOCmpq8qja6CYXHxWBzPktLXKuqVoKmQlqfw3hYu/7AoHXAiM7WL6C+prXdBTQan+t
 JFdFOswPyYELEusoaK4DgOcsXpYVEUzkllDT+DgokoqGD88LsznyDu5bQq+20Wd9nnVT
 NyZlKc4c+wsT9V3Q75eRue3GEfWwSpt7AXo1zt8ec5efG/uCZ3B9FcryX3SOqKRVgd7A
 2UuIwPqBJapMjKFzEPCIkrBPTt3CSCH77/uT1/wn7D11tfdHs9nMA67H6EwDYqjQ1CsZ
 BdzwL4om2gszFxJPSjxdCXZzu1L4c0UDaE+tlxpoeGLdS70DJRBWc3vtDGjmgnEV5xT9
 NGAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9a37PyxugVGRG32PNM/xmTuRLw+9Rw5CxVgUm1UcllCPbTKM4x8H+LrUdai2b84HiMjif/XyRm4D7@nongnu.org
X-Gm-Message-State: AOJu0YwmG5S3gNH6b3Y9dwvd95pcLBIEpJ9xk+W/mL3T6nC/jsSnPnSV
 XRtmqtsxj5F2XyCDzRqYcJsZA8gnEN1vVWAT3ypTSyJF+kz/LsdO3iZFjRFTYJqzASCY/PSTfIB
 ylsRbBfbwObGS34aFFvOVRCSwvmGjhR3J3bSZ8AY0yJLiRceAVyonzkda
X-Gm-Gg: ASbGncurITV5kOoeMkROJBwSrB77buAzk6A/DvJlw1BUw9jQFUfRlKRUzfZjaHCnn5y
 cuBanP1IUSKK8Zo8lFUvqDC4wgTv3fLB43QvMND6YgMVdbjwWqJzuf2qSFS8tx8+5Y772kyf1ee
 Ry51aHqtl7CVIoQHIJGEEXUaWQ/utlF/mxVb13UOggH/s/TMg0Wj2kzGXCKA3GLXuBl1ZDAWoRs
 ciBhG6n7m5/yOxRYT+otSf0/3n3uqhjdkRfU+hn+9YgOSx+OrfawXREec0XMavrRP5bga9fQ2yh
 JsYBvcmkwhLNuw==
X-Received: by 2002:a05:6214:4a06:b0:6fb:f10:60e with SMTP id
 6a1803df08f44-6fb4779a23dmr188133786d6.40.1750108684643; 
 Mon, 16 Jun 2025 14:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+7jv0HQYzV3711aI6P/V275dMFO3cJtzMATkmktGjjbfK9w1gUlxgSRFnlJv062lyLQAEOA==
X-Received: by 2002:a05:6214:4a06:b0:6fb:f10:60e with SMTP id
 6a1803df08f44-6fb4779a23dmr188133346d6.40.1750108684324; 
 Mon, 16 Jun 2025 14:18:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35b20f08sm56156146d6.22.2025.06.16.14.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 14:18:03 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:18:00 -0400
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [Patch v2] Don't sync volatile memory
Message-ID: <aFCKCILrNyfwmWL1@x1.local>
References: <1CC43F59-336F-4A12-84AD-DB89E0A17A95@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1CC43F59-336F-4A12-84AD-DB89E0A17A95@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On Mon, Jun 16, 2025 at 08:56:50PM +0000, Chaney, Ben wrote:
> Not all pmem regions are backed by non-volatile memory. Syncing volatile
> memory provides no benefit, but can cause performance issues is some
> cases. Only sync memory that is marked as non-volatile.
> 
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> Fixes: bd108a44bc29 (migration: ram: Switch to ram block writeback)

I've queued it with an update on the subject and commit message, as
following:

    migration: Don't sync volatile memory after migration completes
    
    Syncing volatile memory provides no benefit, instead it can cause
    performance issues in some cases.  Only sync memory that is marked as
    non-volatile after migration completes on destination.

Thanks,

> ---
> migration/ram.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index d26dbd37c4..e857b579d6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3672,7 +3672,9 @@ static int ram_load_cleanup(void *opaque)
>      RAMBlock *rb;
> 
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        qemu_ram_block_writeback(rb);
> +        if (memory_region_is_nonvolatile(rb->mr)) {
> +            qemu_ram_block_writeback(rb);
> +        }
>      }
> 
>      xbzrle_load_cleanup();
> --
> 2.40.1
> 

-- 
Peter Xu


