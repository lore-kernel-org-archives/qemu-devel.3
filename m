Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E13C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPefo-0007I2-TL; Fri, 05 Jul 2024 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPefn-0007HL-0I
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPefl-0000bS-Lh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720169525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXgte17EvLlkzv+Evn3u/2Hw3vaBARiEo1c4cOUu3+o=;
 b=cmXjWCkptHrW3xnnNJiThsdC1FoaiXU+/aejcBBNt5iYb5aahF6xqZ9rHWPLFX/Og1enr7
 /lZvwWFXNRdtbgiKOlDZJqchJfm3IffRRSnFFizUtfeKSyE7nrWXqFOjBCkMWcRM9IIrlg
 TA7+i6l00A1iwDAiMwH7tktClolsMWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-YQiq6RfjOJqoa4XHmRq1kQ-1; Fri, 05 Jul 2024 04:52:03 -0400
X-MC-Unique: YQiq6RfjOJqoa4XHmRq1kQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4246cf4c87dso9774575e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169522; x=1720774322;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXgte17EvLlkzv+Evn3u/2Hw3vaBARiEo1c4cOUu3+o=;
 b=VyNzPxx1QV/N05E9kdfrMpq2ibmWQjZilPA48IJc69MnIG/0DvmYRw5H0D9lPFUbFu
 6KQw4DVNVImB1Vs3KadFTDwhgTX+vnAnCRupXHmKWR10bw8j/DGrvJpwBdRmb5W33kBr
 bJibI0FswUCHNueFT8N0FopFC9PyaHLL4QVwcKbMNtVg13YybwNg6/pmascI2iOabtg1
 KibNcXrcE0zy7ksp372oCDmYb3ZFZaHcJQVlalId0RQ7yDOUBF02cGvQ3wrOtJTm4x9C
 GxkSBji4uKWU6RJD9hvKnRGAAohctMXTuozocFmvgMaodFc74SsLCJzSy14tPTTtqgJU
 f6uA==
X-Gm-Message-State: AOJu0Yw+cisOpE/ib2jQ+C5pjt5Y+IcBTZg8tJkGrXmwnnI6VaB77TQD
 LDeZpqNqL253kyoo+cOJRTZyFGHVG2JADoar7g0BQi6qzEvXT0teW8/Bh55bYbzNktctg7eo1Ip
 vyEqnGSXHW6vu14xxBv9E7h2c20VPl+PkZv7ZgthfkytQaV9K8GPf
X-Received: by 2002:a05:600c:ad5:b0:425:65fd:449 with SMTP id
 5b1f17b1804b1-4264a444030mr27184995e9.28.1720169521939; 
 Fri, 05 Jul 2024 01:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4DnbVACHslplTAJkLhh9SB7Rz9B/WXSTeMp5O+qtXXefIE84XD4P0UIj/0Q6WDaghhn0t+w==
X-Received: by 2002:a05:600c:ad5:b0:425:65fd:449 with SMTP id
 5b1f17b1804b1-4264a444030mr27184835e9.28.1720169521278; 
 Fri, 05 Jul 2024 01:52:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a0b09da7sm3020262f8f.69.2024.07.05.01.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:52:00 -0700 (PDT)
Date: Fri, 5 Jul 2024 04:51:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH  v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <20240705045005-mutt-send-email-mst@kernel.org>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jul 05, 2024 at 05:03:17AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> VTDIOTLBPageInvInfo.mask might not fit in an uint8_t.

I think what you mean is that is assigned values that might not
fit .... it's u8 ATM so of course it fits.

> Moreover, this field is used in binary operations with 64-bit addresses.

So what?

> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/i386/intel_iommu_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index cbc4030031..5fcbe2744f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
>      uint32_t pasid;
>      uint64_t addr;
> -    uint8_t mask;
> +    uint64_t mask;
>  };
>  typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>  
> -- 
> 2.45.2


