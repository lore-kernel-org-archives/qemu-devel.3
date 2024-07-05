Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4FC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfzf-00048g-6M; Fri, 05 Jul 2024 06:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfza-00046y-QU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfzZ-0002lz-7p
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720174596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Y0YlFV81d5OTdLoW2SsMsMncHgOH9zHgv6AT0ccuiA=;
 b=ggbHQaWPQXeihnz6LnAn07lIoQ7qcsuMDrgBD8gfWQ7/sSMquPjk6k46662mXUl2lyZBIA
 EymEFEldzAFJEA2RCQ/JUKxMEbBCBDU6BrEeLudaHxMweG6WTvr4dw7KBsZcY1FeGnP+Q5
 ANJuODSz1CYtGYdLyJC0x+3rsseQDC0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-ki-yvBk_MHmcjyMVUh9jNg-1; Fri, 05 Jul 2024 06:16:34 -0400
X-MC-Unique: ki-yvBk_MHmcjyMVUh9jNg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ee91034250so14315261fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720174593; x=1720779393;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Y0YlFV81d5OTdLoW2SsMsMncHgOH9zHgv6AT0ccuiA=;
 b=e5FzpmUdVG/Q5bWx7mv4yWjZzWxiI4NBm4mOmKIOb09GuDEkJpl7zJOdXXtwXwUEiT
 wTQqmxKrZcUucEhqxW7mOhgHRryG2Khc+R3+7VQdgPRGMHVXbHw+DqlL1EzwAw4ByHc7
 UNcwOlAIzvq12C0NsbAMk1JC8EpxLDgBNGHfnYk1jnwKfga3FpesBSDudLAsqu7o7Gob
 8QDZxZrOaVYhvBeCKvf2ITzC4JCj518uCvv0CO3m6g9jjYrkEfAVp5FCCZXcfzAqBzrI
 1qn6G6egXkey0obbv5L+xWM3YfRcPLcz431G/ihM/OWT3P68MOOECTEYHH0oIU33gi2Z
 YjSw==
X-Gm-Message-State: AOJu0Yy0eh12h8L6EYjDdVi5fNAXCy4wRKfRaD+gud1ZoNTPJ+rKWeDC
 lk7/70lLAD4UrAhSUjJIh4PXFNdEy/SZhmv+WosCgofLhieDRdbiey4p2f6513eBAD0Tgz55fRc
 ZLg6EtvYKTjLJvsaYPSmAs4EA1j0dOjrNPXfZ6Wb92tsB7qQ0MqfW
X-Received: by 2002:a2e:6e11:0:b0:2ee:8d05:db2 with SMTP id
 38308e7fff4ca-2ee8eda81b9mr31530511fa.29.1720174592821; 
 Fri, 05 Jul 2024 03:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+vIWSMhDhspsHn4+KXobyviuPL3GA/TKog3zK0q/wvuBZkuRYYb19ZQ/zCTL7eAey6E0RgQ==
X-Received: by 2002:a2e:6e11:0:b0:2ee:8d05:db2 with SMTP id
 38308e7fff4ca-2ee8eda81b9mr31530271fa.29.1720174592088; 
 Fri, 05 Jul 2024 03:16:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36799a54215sm4148585f8f.68.2024.07.05.03.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 03:16:31 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:16:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <20240705061549-mutt-send-email-mst@kernel.org>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
 <20240705045005-mutt-send-email-mst@kernel.org>
 <61d45a7e-adb2-4d45-9879-549e4a258d75@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d45a7e-adb2-4d45-9879-549e4a258d75@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Jul 05, 2024 at 09:52:48AM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 05/07/2024 10:51, Michael S. Tsirkin wrote:
> 
>     Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> 
> 
>     On Fri, Jul 05, 2024 at 05:03:17AM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
>         From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
>         VTDIOTLBPageInvInfo.mask might not fit in an uint8_t.
> 
>     I think what you mean is that is assigned values that might not
>     fit .... it's u8 ATM so of course it fits.
> 
> What about :
> "The mask stored into VTDIOTLBPageInvInfo.mask might not fit in an uint8_t. Use
> uint64_t to avoid overflows"

No, the mask stored there is u8.
You mean "that we are trying to store into ".

> 
> 
>         Moreover, this field is used in binary operations with 64-bit addresses.
> 
>     So what?
> 
> I thing the first part of the message is enough, the issue comes from the fact
> that the mask does not fit into the type
> 
> 
> 
>         Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>         ---
>          hw/i386/intel_iommu_internal.h | 2 +-
>          1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>         index cbc4030031..5fcbe2744f 100644
>         --- a/hw/i386/intel_iommu_internal.h
>         +++ b/hw/i386/intel_iommu_internal.h
>         @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>              uint16_t domain_id;
>              uint32_t pasid;
>              uint64_t addr;
>         -    uint8_t mask;
>         +    uint64_t mask;
>          };
>          typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
> 
>         --
>         2.45.2
> 
> 


