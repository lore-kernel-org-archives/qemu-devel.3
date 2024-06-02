Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E572C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsh-00015n-RK; Sun, 02 Jun 2024 22:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxsd-0000uk-Sb
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDqpN-0005PH-Tt
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 15:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717356312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pYw2EH0ataK0bb5mgQgyo7GMtT3yQ/uN5Gk2Sx5SY7c=;
 b=U5RPDn5N/qt2Brym8a8QWwJTLG7TbAM+u7j7laxWMp4/19m7cFadDasyCVJOQ8Wodxu8Vc
 qfY0x/Y/efclLKt1OSMrR1Rday/tNeWjR63sCCbSDwLli9GFLb24wiFj1sDwUYAm6AIAOt
 rFYzEKNaHmkbtvrFhum8J6qSiWK28WU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-VFNQhDjnNmu4Lyi5a5fGCw-1; Sun, 02 Jun 2024 15:25:10 -0400
X-MC-Unique: VFNQhDjnNmu4Lyi5a5fGCw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dcf7d4014so1565798f8f.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 12:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717356309; x=1717961109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYw2EH0ataK0bb5mgQgyo7GMtT3yQ/uN5Gk2Sx5SY7c=;
 b=tQcZ6RkV2gET1JYABr2qbbtl3BQqnrYTivynJigd24MMJriGUZQfsM7/9lYn62sO7T
 POAA144JckNJrIVLRubOA7B4voqBLyG/pdQqyjYLJVs7YGHps19Alw6nQzTpL3/Fu8pA
 6F+wvyqQ40xjALZKxkQIy2WKAKboQRQkwg7gEFrA9tM8uYxqt1W7YTNH+2dnGtED57TE
 w7HOU2t2PCXruk9HE750KFGcbHJaofWg/LWt823HQnbDXDbeTEtHP33WfH8sjpd85RMX
 pCMdZLJqe0S0zAZ+jI9dmdSblTfssyD1UlEcOixsrVc2LJihooZenQ++jYpX+Zsi0LRI
 eXkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxmfEWYZ2sXH4/P/bj6FqvbDyt8qX9lFNuH08mLZ92G9+JAVks1f1M4keBTieA4kTdH71g42pjvLfFReVe5ufKSfsMigA=
X-Gm-Message-State: AOJu0YxVJ50DKOxC8OgcY2aGKUkzyw0lIOlRK/nwrE2XiXmK/L149JpX
 o1sdt0VKQppJ7D5MrssEZ4Mtee77queKnUrGTLwx3JqYPk0LnavVC6+WfpjzN9bJxPcy+0GWON5
 GBQsWb715y7M2nhih8ejaPeapUUoZ2/Ks5n5iRG/X5Oesdk/1gwfS
X-Received: by 2002:adf:ce91:0:b0:355:161:b7e3 with SMTP id
 ffacd0b85a97d-35e0f316a57mr4970410f8f.48.1717356309360; 
 Sun, 02 Jun 2024 12:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXlrJxfSMWporena43/yel9GfnVa6qXRhzG7vs5Yf7QPvk2H1McS/vnnnwlk5uNlvedM8jEA==
X-Received: by 2002:adf:ce91:0:b0:355:161:b7e3 with SMTP id
 ffacd0b85a97d-35e0f316a57mr4970401f8f.48.1717356308797; 
 Sun, 02 Jun 2024 12:25:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caea8sm6823543f8f.28.2024.06.02.12.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 12:25:08 -0700 (PDT)
Date: Sun, 2 Jun 2024 15:25:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
Message-ID: <20240602152439-mutt-send-email-mst@kernel.org>
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, May 31, 2024 at 11:22:05AM -0500, Ira Weiny wrote:
> Peter and coverity report:
> 
> 	We've passed '&data' to address_space_write(), which means "read
> 	from the address on the stack where the function argument 'data'
> 	lives", so instead of writing 64 bytes of data to the guest ,
> 	we'll write 64 bytes which start with a host pointer value and
> 	then continue with whatever happens to be on the host stack
> 	after that.
> 
> Indeed the intention was to write 64 bytes of data at the address given.
> 
> Fix the parameter to address_space_write().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
> Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I'll queue it for the next pull which should go out soonish.

> ---
> Compile tested only.  Jonathan please double check me.
> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e42490b6ce8..582412d9925f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1025,7 +1025,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>          as = &ct3d->hostpmem_as;
>      }
>  
> -    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
>                          CXL_CACHE_LINE_SIZE);
>      return true;
>  }
> 
> ---
> base-commit: 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80
> change-id: 20240531-fix-poison-set-cacheline-e32bc1e74b27
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>


