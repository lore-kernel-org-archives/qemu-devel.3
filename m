Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B2DC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU57-0005Ye-3C; Mon, 27 May 2024 02:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBU4b-000580-05
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBU4N-0007VK-NF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716792173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kg+7wWixHG69BvIsG4P11ne4+1bCs7tUtbDUEmth8/Y=;
 b=jVS5ploLbdw9uOMbwOnjtynbsn843q0fERJOvzAfzAxOBIMkOZG3c9KMgZC3h16LhIhRq5
 90S2fq7J4Rtl3lzOJ+tPGkIT6q2Men40IcY4b30ln9UVPSnVaDv5NrYI0gwcol/yrqyNx9
 mHCJS4Ve2iOpIuiMaWOZJLe9rcoLSEw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-aOgoKyvxP0SfPIQ86CvAaw-1; Mon, 27 May 2024 02:42:51 -0400
X-MC-Unique: aOgoKyvxP0SfPIQ86CvAaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso13136975e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 23:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716792170; x=1717396970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg+7wWixHG69BvIsG4P11ne4+1bCs7tUtbDUEmth8/Y=;
 b=ATPNiYSIfz8kUQQQ8RdnX76DhOEmR+iUcZFzfox5enTVbPUeD0hv7IHKhp0ZKyZT/7
 IPWWafsbewU1zbHF4px76HDNlwJ/UAwMs77hOTGPXFLNDfyzr8cG5Sz/OvrTbJWzCD7v
 tNmgBeMhWURZ7PkJknHzl1NHuB7tpmddZjl064hhmgHGfCWELQIT0B3rSa3Zr88IbN+2
 Dxt0Ek2xutTlVMraQhDOHQYl/wAXaAX2WsBRlDNXVvbo29DYZTp5LabhFiOriqJZz3Wf
 +IiIVDVNaYbw5ztNf2N/dxxTxbZochoZxSUc5D0XgT6woTYoWqfAHZ64gGirK+XVIpZA
 kpOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMUDLRRr29OWbRuUrM8afORJfmhPciuQRMkkwEkVgE5SmwD1do0AQyYWrmZuTQydvpezN4LdtHcJ1F/VQ/jXoFXGa9l+I=
X-Gm-Message-State: AOJu0YzFe13ibwyEOwmtXsDVMlLTiGNpSmdOdjlxVm2bseo5WBAS1E9+
 fCcE1UV3SjhoQUTyomosJnRjwdlam7z8z2EMDs2IiuxpO9ZodtmMWKK/jt1W6h0cR7K/WuXzoIt
 GG0SL2Dsy8qmQN0YPS+TkSlSKpMEuItDn1xbTiaCIaXw6rVPIdffM
X-Received: by 2002:adf:f0d0:0:b0:354:fb97:1365 with SMTP id
 ffacd0b85a97d-3552fe19723mr5087101f8f.52.1716792170439; 
 Sun, 26 May 2024 23:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1nCeGFoOUAUJMXfeMZPihvDjluesUZbDmRAUZZmeoRVeKmm1Grr2N+8UiAPUh172XW27OLw==
X-Received: by 2002:adf:f0d0:0:b0:354:fb97:1365 with SMTP id
 ffacd0b85a97d-3552fe19723mr5087069f8f.52.1716792169866; 
 Sun, 26 May 2024 23:42:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a090366sm7998831f8f.56.2024.05.26.23.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:42:49 -0700 (PDT)
Date: Mon, 27 May 2024 02:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Message-ID: <20240527024200-mutt-send-email-mst@kernel.org>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 27, 2024 at 06:04:42AM +0000, Duan, Zhenzhong wrote:
> But I'm not sure if there is a real scenario migrating to old qemu,
> why not just update qemu on destination?

Because you can not just update a huge cluster atomically.

-- 
MST


