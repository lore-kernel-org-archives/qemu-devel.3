Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C6DC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVEpP-0003rG-Ld; Sat, 20 Jul 2024 14:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEpO-0003qS-61
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEpM-0001YH-Lc
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721500143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9Bui12bHVwVUpuaw6ICP67/S/kEmSjKUpygxm3n0R8=;
 b=E9wjIfCEevXOn0m4mKbzM2gpwaXQ/Gt1lYQr1Rcaih82rESLFxmE2t+iKxKLrbLtZdZDTy
 bnWzeDO5kY9Nqjgl3b0dtHWagtB9071QOjF1iMSDTcdHmdiyBR/gaZ153vxW3C9aheYWC2
 nyCw4YqM7DxBTOvjh9olOEFQiehtVoE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-spfRd9iXMFWYSJICjhfbMQ-1; Sat, 20 Jul 2024 14:29:01 -0400
X-MC-Unique: spfRd9iXMFWYSJICjhfbMQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4279b07cd45so18687435e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721500140; x=1722104940;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9Bui12bHVwVUpuaw6ICP67/S/kEmSjKUpygxm3n0R8=;
 b=Apt1izmrIHntm10ezKvDRMQAuJMeDYZyYLIM3R582Spj1nz0lg6o0RssnqhC70R1DR
 L64qO8CaaVkQV+cW+b8BnCpxy4LSYS8zBNYrRv334L/6aasGXBOZH9XIyOCSVu+A+7yq
 ezgPfnMyrpb4Xo7gRVDy5ycLlTt+3Xr0slCK2VMZLOD5pBTAVkLmHAOd6VA3UgMXwSFu
 2rbiWA/4mst4S0LCgAOO7FiFjD1EZmCA8+1+lQGvSVb813AVjbuwx5mKQu6jdyOpMJmr
 /W5smjZ2VE5R2CR+jawrV86Tun2wAfTPgJHq9gY1DxuzDy4QpVJ1Nlel+DxqJdaRFhDB
 KAOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwh1lAUkcgcaqTLKomQuUYXs1SFpwg/PQPt9tv475jKD6M3RiFmRjpFnrxMjSq0weJ8S2NLxP4AT3+S0Toydyw+UZx11g=
X-Gm-Message-State: AOJu0YzlohOosKY9nCilX9BXnpJpyhwbEhtirEetQ95TLFp5gJ6nlKOf
 RmKeQhc8TgS4Mi9XjEiJgRGV87DKoJKe/QwhGUHa1YeJQ/Wv5l2nwgc9fU+dmDNNTFe4VwWT47o
 +u6lAns4NmsFKYVQjHeCoP1UbJLwsE3PE/Hpn2wkJJENIm39VHuFi
X-Received: by 2002:a05:600c:3b0a:b0:426:67df:31e6 with SMTP id
 5b1f17b1804b1-427dc524c85mr12504925e9.17.1721500140164; 
 Sat, 20 Jul 2024 11:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvaEoRPH7rBO1/CytUR5YesZH0zj/Jf20R9aZMgoOKpZ5ptTTXWhz+1W7lcE9Wl9YAM3y0zA==
X-Received: by 2002:a05:600c:3b0a:b0:426:67df:31e6 with SMTP id
 5b1f17b1804b1-427dc524c85mr12504785e9.17.1721500139628; 
 Sat, 20 Jul 2024 11:28:59 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c0fasm93608845e9.7.2024.07.20.11.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:28:59 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:28:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yee Li <seven.yi.lee@gmail.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, qemu-devel@nongnu.org
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
Message-ID: <20240720142728-mutt-send-email-mst@kernel.org>
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
 <CALX8JfT5ecx4qQTsBMdFAqS-r4FoBd0T5WQFGr0MwYnAMo+Meg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALX8JfT5ecx4qQTsBMdFAqS-r4FoBd0T5WQFGr0MwYnAMo+Meg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 04, 2024 at 02:54:00PM +0800, Yee Li wrote:
> Sorry, the patch missing "((  ))"
> Replace "& VTD_IQA_QS" with "& (VTD_IQA_QS | VTD_IQA_DW_MASK))" is correct.
> Revised patch as follows,
> 

So submit it properly.
Also, how did you test the patch?

> Signed-off-by: yeeli <seven.yi.lee@gmail.com>




> ---
>  hw/i386/intel_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..23562ba26b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque,
> hwaddr addr, unsigned size)
> 
>      /* Invalidation Queue Address Register, 64-bit */
>      case DMAR_IQA_REG:
> -        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
> +        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & (VTD_IQA_QS
> +                    | VTD_IQA_DW_MASK));


This is a very messy way to write this.
Align things properly pls.

>          if (size == 4) {
>              val = val & ((1ULL << 32) - 1);
>          }
> -- 
> 2.34.1
> 
> YeeLi <seven.yi.lee@gmail.com> 于2024年7月4日周四 11:53写道：
> >
> > From: yeeli <seven.yi.lee@gmail.com>
> >
> > When dmar_readq or devmem2 read the DW of IQA always 0UL because
> > "& VTD_IQA_QS". So, try to fix it.
> >
> > case:
> > after vtd_mem_write
> > IQA val: 0x100206801
> >
> > after vtd_mem_read
> > IQA val: 0x100206001
> >
> > Signed-off-by: yeeli <seven.yi.lee@gmail.com>
> > ---
> >  hw/i386/intel_iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 37c21a0aec..e230a45940 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
> >
> >      /* Invalidation Queue Address Register, 64-bit */
> >      case DMAR_IQA_REG:
> > -        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
> > +        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS
> > +                | VTD_IQA_DW_MASK);
> >          if (size == 4) {
> >              val = val & ((1ULL << 32) - 1);
> >          }
> > --
> > 2.34.1
> >


