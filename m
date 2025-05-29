Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8218EC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 17:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgzR-0008Eb-05; Thu, 29 May 2025 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKgzE-0008BS-EI
 for qemu-devel@nongnu.org; Thu, 29 May 2025 13:24:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uKgzA-0003Fi-4b
 for qemu-devel@nongnu.org; Thu, 29 May 2025 13:24:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234e48b736aso15249905ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748539447; x=1749144247; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEyH62zNAebqEqtp3fTh4mOcudMflb/GkOdJm5SLEDk=;
 b=MZ7apDHEV+cVOAUWn2ksXEsgdlWFdNhPJMLZk4UTVDpNk6A8f6AZQviruv0xtC/f3E
 BirGJNSvdYF5N658TwKluvuraSh1Q7Vet+5b5POYhL6iYL7Exzgj42e2U9b4ICDjf56B
 j9RNvcDiAYpunmGrPxpNsRfuinGgymVTiSSEYDPjrysFBP5OlK5feq3gg2vUr/O8ette
 fgRuyqL5LBh2tCN6/xgvxIurvg+vIFL79G9748H9XBby2rBU/KBsLsdQRc/VYMoVR9aJ
 mxA09sH3Ez0T22361d4eyVOcS9M8a0+m7wYBzIWMj8PMgR5ia9pa9tasxly3wdCGBzM8
 48iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748539447; x=1749144247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEyH62zNAebqEqtp3fTh4mOcudMflb/GkOdJm5SLEDk=;
 b=CRKbGtLk16EmhyjuKePj+I5gmybJKWkZZ1Radp0VUH5wwajIcDd23dBFKb254QKQnk
 Nxh9DQwPYqmPctZ04qP+GBXsbrJa/SuFMuEzY42GdzjyNt3jK0gnSOpJdmDkigsv7sIg
 MBS0rdH4UD0L+ItNys2FAwd819mk6DYzFiggKkdfp7cKvtF/kuUv5AGb+7cbsUx0vLB9
 XGloEICdqiqcpHcHwynAyS2sj66pakRS9XKhWAMeZwnDB6zUDAhNjDX0t1o1Xj3bwGFc
 h2BtUD083iYkhIG8FVQbl1nEpblKRsNW3pAs4KY8INgOjure6+DI04F4Y+eGSMyU/3hV
 p3vw==
X-Gm-Message-State: AOJu0YwU0wQTjgqY1l6K8bhS1IO6px5ozEoK1cDSRxXaLAa+15SVAxY4
 OlXoATUbWUtAsklksTwT753I/QuST2KBK8T6apJUNSD+ciHpXd/1CCDm
X-Gm-Gg: ASbGncs5LadpXe15R3Q5WSwIr0cJPa8/+Nw+fIPdKzz1L+nMTKiN4rdVGP2pXOLBwmn
 4ZjyfcQ3cUx0Frm2RZRB2rF5QjMrFG/tQuVFwH3rhJiGX503LTf7XAh4kiEZrhwGoqbiOvCtwn0
 6EtUD+5b9R7J3AogbAuqOnC+o3sV+/5abJTrOunPWci3nBtgHYqFiSAXupUv85EI7O7Lg81zhGf
 b3TXFjmImocT71Vo1jtM+XcqB60nXn3alaDZEX5ami26S/Aa9Nyh/Eg/hkJ9Qs5oSNs0okKQh9x
 MnRqc/myXu1S56PAT0yH9jDxyZaQKUVW/cS8WG49JttmsJ04mivbkmE=
X-Google-Smtp-Source: AGHT+IGi5cGGCBmBiq+PkmtAJs3wjt1VsFTAILjcCXfRmlpkbOd8nC8FKlVdDZKj1HMFeYrFw5JuzQ==
X-Received: by 2002:a17:902:c952:b0:235:779:edfe with SMTP id
 d9443c01a7336-23529a11512mr5031775ad.43.1748539446636; 
 Thu, 29 May 2025 10:24:06 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bc8863sm14826385ad.19.2025.05.29.10.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:24:06 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 29 May 2025 17:24:04 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, linux-cxl@vger.kernel.org,
 linuxarm@huawei.com
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Message-ID: <aDiYNDGscGVVz6BB@smc-140338-bm01>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
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

On Thu, May 29, 2025 at 02:48:28PM +0100, Jonathan Cameron wrote:
> This has been wrong from day 1.  For now we only have
> two entries (component and device registers).
> 
> The wrong size could lead to arbitrary data off the stack being presented
> in PCIe config space.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index d0855ed78b..3bb882ce89 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -31,7 +31,7 @@
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
>  
> -#define REG_LOC_DVSEC_LENGTH 0x24
> +#define REG_LOC_DVSEC_LENGTH 0x1C
>  #define REG_LOC_DVSEC_REVID  0
>  
>  enum {
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)

