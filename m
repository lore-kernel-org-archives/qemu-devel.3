Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2889CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoW0-0000F7-Q3; Thu, 27 Jun 2024 08:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoVp-0000CR-GQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoVm-0000le-BF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PEyXyjrz0uT0L56DM07tTAES+eOWE4OCv7rGSKUOWNM=;
 b=dD0kmReF62kfq0sEMlsRulWSSr3RU7StWwZlYb4AUjeCfGrrF9aXYC/ekjDe0kiAgYerIa
 ARRIhNOY353Drv/HTSDEx+XVoHmZ7ERhFkY5ugpWJrS7bSXfm2QNXj6hGO563o1fvAzWd5
 rAFs9/BonOmb1Cs6zFqfqrZNAI6njnA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-bgfAeF8KN8iLE5L7Rmk2Ww-1; Thu, 27 Jun 2024 08:45:59 -0400
X-MC-Unique: bgfAeF8KN8iLE5L7Rmk2Ww-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36740a84ad8so699322f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492359; x=1720097159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEyXyjrz0uT0L56DM07tTAES+eOWE4OCv7rGSKUOWNM=;
 b=q7rMIzxnXBbf4GZ8kZUS5h7RzX/kNPxI0Zb3XphlOvZfJ4BjCngSH0yYqoeS2sbT6y
 nPw+bNAps/fh8ch3jo9vAw14SKNtiAzrScVHM0zUbH3McP41AHAzwWK+oLU6Pw49rUwN
 FwxMx0xmZ4Rhjv8dWGidE70FrFj2WpaVINHAJ8RJHst2hhc976LGaDZVcWVcZMUJ/h0T
 urJAd/H5GGE98+f7lQd1NoV1ZhUU7cdf0aGZqOi8x2T58yrfjD4jp8h0xndB55InbaQc
 18aPpGJak4cd5Hm6Fahiy3mgETCF71J5WrDqIU+jM9+CxuH+ejfur/U/rhJZ62ubrsHt
 Zmrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/AtzCeGJqyQzTn0HZH0cOgGWSGDXw+qdbIFBa1FhU1pMwsVLiiZxUkzFDQfp2BVUu0nHFPRCUD/Hs+0NOBz4QD+sLFYU=
X-Gm-Message-State: AOJu0Yxs/dwns5pWqWoE1r3WxAWbYkxPYmuNFiI4LmkrdOsHZWc3uXWv
 uj8t7JLiJzFNOCBRhRNBd1wrAPr/Rbxox9nI5N4cSkrwcLMe2JJ1C47Gl0t/mzNHyxj3DlnrX5y
 8PjsON+8bvm094VuBOD7hir1a4aaj1m8VrSweBk7DCSiG2x+IEUzo
X-Received: by 2002:adf:f1c8:0:b0:367:42c1:516 with SMTP id
 ffacd0b85a97d-36742c10599mr1706655f8f.18.1719492358876; 
 Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYnJOYQggJiXKXxSMzsFo4hr4SuN8taJsLKh778dY6XPRmMVE7b1+mR57fG/XpIGlW9KYXiA==
X-Received: by 2002:adf:f1c8:0:b0:367:42c1:516 with SMTP id
 ffacd0b85a97d-36742c10599mr1706633f8f.18.1719492358497; 
 Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ec7asm1741891f8f.112.2024.06.27.05.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:45:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, ankita@nvidia.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, Richard Henderson
 <richard.henderson@linaro.org>, linuxarm@huawei.com, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, eduardo@habkost.net, linux-cxl@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627144557.237e3ab7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627084356-mutt-send-email-mst@kernel.org>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
 <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
 <20240627084356-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Thu, 27 Jun 2024 08:44:14 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jun 27, 2024 at 02:42:44PM +0200, Igor Mammedov wrote:
> > On Thu, 20 Jun 2024 17:03:11 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Rather than attempting to create a generic function with mess of the two
> > > different device handle types, use a PCI handle specific variant.  If the
> > > ACPI handle form is needed then that can be introduced alongside this
> > > with little duplicated code.
> > > 
> > > Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> > > and segment directly.  devfn kept as a single byte because ARI means
> > > that in cases this is just an 8 bit function number.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > with typo fixed  
> 
> typo being "in cases"?
> 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >   
> 

nope, I highlighted it the patch
  > +void build_srat_pci_generic_initiator(GArray * table_date, int node,  
  s/table_date/table_data/


