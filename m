Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED94C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 04:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrVSs-0006oA-Vw; Tue, 02 Apr 2024 00:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rrVSn-0006ne-Cr
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:09:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rrVSk-000807-Sg
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:09:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ea838bf357so3656860b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712030969; x=1712635769; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XfWw02OPa7fokHICEIRe3VuQLMcc+2bOKElq3Tdxllw=;
 b=Ed58tU3wZDopV1VCHCuFe2MK4dR/7LNjaFqRB/eErOWxniW28R3aR3ZCzBg6utXsgi
 VLt0YUr92j7TFKWFXnemIg+aINvqMUgrOhA0GUpJu+0tc/72WCMEhA+8fJMHMN/9XDFy
 kv781GABzVClXwu8w3ZCURn5fUmafOOIsmOszAUIFAG/1l4RaxkFIvcexZfXb2vhUOCJ
 RvQUmMNAkS19l9kcqO0GAsUSdOwyOoRm9+lvDwd8ROZYXh4GMF5pMhFn8zO7UXwDLg77
 tJzwhSueeuDQnayzrlsk1Jxk3zGfCrrjeLalePgwPQ3JqcjC79j7ihsWOHgAMzPmrB2p
 VMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712030969; x=1712635769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfWw02OPa7fokHICEIRe3VuQLMcc+2bOKElq3Tdxllw=;
 b=vvz5e6H9/gMzhZ3rhqZoCkb3TbyH0dWv5NrLJf1d8eYWrkJwTDUmc0hMd8CHFdoNcc
 chbbXDAlzIBcd8SMx/k+jHkx1Q1kMTgkmAR+Bm5vEFx2aAogUg1KfeFVr4CaWCpSdIEX
 dW5LOnHXbRYvk1cOMS7tFljQpfkQGDBTwbkoO76gZ81dwzW8uQvbKlEE/v0Vxuuz9UEx
 hq1FrgnHqZd6vje76kWsqxEb3fB3Pdg8rlp97F3cEIXDRAnS5OLe1y1vga0eVwHbgx0D
 ZI4H0eNKKBsKqPVJ2HfPcKm0O7JR6tBS/z2SzIL3NSRZVTzx1dliFxdc0cXo0tN5nXRu
 qtGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg5CJ32hecwwUuwehZqQhcxpZJng7R24k5QzY92DyC+8/KFQaEVqYuxUsiJG2qpW579ZvGF64E4XIm6BshIyIrdsQrbyQ=
X-Gm-Message-State: AOJu0Yx1+DioXOZzbdgCVhtqc0gQhRXb3DVTTVXDdnhrZZ+18Y6DfZXn
 pHqHegNtSEkmE7Xs0bzKdCLQUXK/kWGVtvCvRH+VsgO2uULPx8ba
X-Google-Smtp-Source: AGHT+IG1OGdsJU64bQ+nT9yIBVKXTKyZflztUqevTyGo74WDu5tg1ZGeSVNTW2Kl6+KypsVdN73btQ==
X-Received: by 2002:a05:6a20:6722:b0:1a1:878d:d3f6 with SMTP id
 q34-20020a056a20672200b001a1878dd3f6mr8423530pzh.26.1712030968794; 
 Mon, 01 Apr 2024 21:09:28 -0700 (PDT)
Received: from debian ([2601:641:300:14de:e03c:ca3b:b4d9:5a70])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a170902d48c00b001e0b5d49fc7sm9827346plg.161.2024.04.01.21.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 21:09:28 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 1 Apr 2024 21:09:03 -0700
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] CXL/cxl_type3: add first_dvsec_offset() helper
Message-ID: <ZguE3-oGTzMPlFyE@debian>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402014647.3733839-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 02, 2024 at 09:46:46AM +0800, Li Zhijian via wrote:
> It helps to figure out where the first dvsec register is located. In
> addition, replace offset and size hardcore with existing macros.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b64..ad2fe7d463fb 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -643,6 +643,16 @@ static DOEProtocol doe_cdat_prot[] = {
>      { }
>  };
>  
> +static uint16_t first_dvsec_offset(CXLType3Dev *ct3d)
> +{
> +    uint16_t offset = PCI_CONFIG_SPACE_SIZE;
> +
> +    if (ct3d->sn != UI64_NULL)
> +        offset += PCI_EXT_CAP_DSN_SIZEOF;
> +
> +    return offset;
> +}
> +
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -663,13 +673,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_prog_interface(pci_conf, 0x10);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> -    if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> -    }
> +    if (ct3d->sn != UI64_NULL)
> +        pcie_dev_ser_num_init(pci_dev, PCI_CONFIG_SPACE_SIZE, ct3d->sn);
>  
> +    cxl_cstate->dvsec_offset = first_dvsec_offset(ct3d);
>      ct3d->cxl_cstate.pdev = pci_dev;
>      build_dvsecs(ct3d);
>  
> -- 
> 2.29.2
> 
> 
Hi Zhijian,

Please use Qemu's checkpatch tool to make sure the patches meet the
qemu code format requirement.
Also, please cc linux-cxl@vger.kernel.org if the code is cxl related.

Fan

