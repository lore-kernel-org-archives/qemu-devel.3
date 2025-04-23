Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AC5C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZOP-00051u-7i; Wed, 23 Apr 2025 08:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ZON-00051b-BE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ZOL-0004ds-IS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745411988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFrh4gmsxB0SpTSV5WD8Oi7IcntQYtEU6m51pM1pSik=;
 b=fK/fmqbInH3liKD4MYIWiZbH6KXmChvxocxaDCUpTQ2LkDcZK6/6NJBEb8eYFPNGYtSkAT
 Eef7hu/CwKiNCUatvRY1cXpNS51Du20cugyqH2C4lNjVNXQB5YSOJKiXMseIkUZvDrjEz8
 ZKJmd1iA5ikD8BpTycZD3LJfjutZCZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-u5LA6LArMuSWbdYdMJwJeQ-1; Wed, 23 Apr 2025 08:39:45 -0400
X-MC-Unique: u5LA6LArMuSWbdYdMJwJeQ-1
X-Mimecast-MFC-AGG-ID: u5LA6LArMuSWbdYdMJwJeQ_1745411984
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so2034464f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411984; x=1746016784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFrh4gmsxB0SpTSV5WD8Oi7IcntQYtEU6m51pM1pSik=;
 b=eVJ2m895UmwQb3/mbW9Nx4/baUM149KHSptdlJ9mdqCZLDxZVw8TSJLA6+81dGakv5
 PYyi1/UlzJKsqGCK5FbvaIXSci/I+S5MLNkEYqffTMLp/j7PUYAfrEh+LjQHVw0T67z8
 cmBGLchMs9CSXqo6Moszb90PvFft41aiBTpL1uZTGTu7QNAkETzdao1CVo16phkIFj1c
 K8CG/EvAFWB2O2i4VeU5tF21uFp5OndKVuZCGZSn5OqptKj9SNF1FnHdgtMx7IlaSm+c
 JQ4bmJnOz2tSSsLRa5dvD1yY3/HSXAZm3kEh5QMAQpjMnIKlj+KuIyvAdNFooLKJl41G
 gA/Q==
X-Gm-Message-State: AOJu0YzZDvEzZ9oPUHalj2rMCJe699R8bJAHXAJcPOHSqZwNLsc6a1Iv
 u4IJKQLWMuPy2pifAN2w3JF4ypwaL/4DEq2O2vEoeWHY3Zyz4Wht9COo/1ONgbMWwYx5DQgXeQy
 jXWtOsZ32PbTJ658eN9DpLZsma21sBN93LFaPP9Vex6nAHeqJ3Bqk
X-Gm-Gg: ASbGncuvHJ7hQ8weWYuM4N5Bxf6xA54xxDaqontVqxCIIk4cWhRRmMqu1wbANbL4UqA
 Uzit1RWMWPw+kBdHFUmFmfD8PfWlMPaiicqLpTct+cYJ2Z9ZY9dFi9IlNt3jXosOxmICeZ/sCND
 mRxMPEhjyUkJiJpU8mcC5HrK7b1ICwFivQ0GLYK0rjMfMG9s0xlQn47AG2xAsNb6dE9rivkh9M3
 yO+Ecl9dnFCUhFjLLHSDJQ3z2kV/5HAp5iZKhyfb31i0BFwc4BM/WUgEhRYnYOzFQItHyFpIzEf
 2DWLSw==
X-Received: by 2002:a05:6000:40dd:b0:39c:27cc:7ba3 with SMTP id
 ffacd0b85a97d-39efba6d50bmr17143747f8f.33.1745411984148; 
 Wed, 23 Apr 2025 05:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYN2YECv0zERYXDHUjTvn2lYnSyErTBbmSgN2yJTHEXrFiy9P4hqTgUYtI5GTE6+RUVD7d9g==
X-Received: by 2002:a05:6000:40dd:b0:39c:27cc:7ba3 with SMTP id
 ffacd0b85a97d-39efba6d50bmr17143730f8f.33.1745411983825; 
 Wed, 23 Apr 2025 05:39:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4f38sm19016508f8f.97.2025.04.23.05.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:39:43 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com
Subject: Re: [PATCH v3 4/5] hw/acpi/aml-build: Update the revision of PPTT
 table
Message-ID: <20250423083909-mutt-send-email-mst@kernel.org>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-5-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423114130.902-5-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Wed, Apr 23, 2025 at 12:41:29PM +0100, Alireza Sanaee wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The lastest ACPI spec 6.5 support PPTT revision 3. Update it
> by handy. This is compatible with previous revision.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>


I don't get it. Why are you updating it? Which features
from the new one are you using?

> ---
>  hw/acpi/aml-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 3010325ca423..e5401dfdb1a8 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2155,7 +2155,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>      uint32_t pptt_start = table_data->len;
>      uint32_t root_offset;
>      int n;
> -    AcpiTable table = { .sig = "PPTT", .rev = 2,
> +    AcpiTable table = { .sig = "PPTT", .rev = 3,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
>      acpi_table_begin(&table, table_data);
> -- 
> 2.34.1


