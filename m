Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A710BC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNvK-0007SN-Pc; Mon, 29 Jan 2024 04:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUNvA-0007Rd-Qb
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rUNv6-0007HI-JY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706520429;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4rBKjYoq2OHKWxux/xqgcQp7u8QdtmguCttHiRkjus=;
 b=SKmuGPJQtgNkhkzkydDqtf3vb0e9KlBatM9qMADnvddy/TnfFFODt34l7ctp0/kwp8LtFS
 hzukp2UmdGuGaCeICSvNDl4Wn1mlW5QkBkE70+bHROs8C8LB2oXEGgxPhA44Ht+XZwtKes
 NT2qldeDl+tFlZGNguv71BZcDCge1E0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-VEHwfChmMOGYcMJ3uLyzLQ-1; Mon, 29 Jan 2024 04:27:08 -0500
X-MC-Unique: VEHwfChmMOGYcMJ3uLyzLQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c4f4411f8so10805996d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 01:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706520427; x=1707125227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4rBKjYoq2OHKWxux/xqgcQp7u8QdtmguCttHiRkjus=;
 b=Cx10JqWAkk5Ad7OghBwRs5xIGP1uZntGVaQRqSEfjHeNeBGNaqs4lML5XDsseS5dtp
 trzELMcPFCkPgTtP8RMquGykeyRhejcjdA4zTFmt1vFaC2C2wtDhJZPLGCjb7Hmvsoi7
 SJibreI+kUln6+NIS6qYOTprY8nGBfTxRr0Zp3jAOPkTQ/KrVZMwvAkX97dRQ3I97W/N
 JDXyGbuZCzyEHiCSN7qNlOOyyiF4bNGeXBfwgqdaJKFKh46FwHVzRjk7X4SHkDC/eyjl
 82A2hTTUjnJSU2gcRRpow4Zxa0x85ePrz4BsehKKL9Wdwb2k9Oiu1ompdw777WejIS89
 y+MA==
X-Gm-Message-State: AOJu0YyRYB5YQHSyWosYS0k2TxHnoF7bxz+XbVyge7fowgQibuEhjf7Z
 l0aKsTtnPhYdpGfkCS2ZqELNg35GbpLcjR+fCJQgaVvb4DWT0S/0VBtw6Pvdo6Yu/HuRHD9JtPl
 cZsYuhdVVCoXirlHtAYptaFnMAbF+4Hn5+vWc0O5DKSXrWTs3aQal
X-Received: by 2002:ad4:5d6c:0:b0:685:a5d2:b4f2 with SMTP id
 fn12-20020ad45d6c000000b00685a5d2b4f2mr6857595qvb.1.1706520427620; 
 Mon, 29 Jan 2024 01:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6RxMwHaGv/FSR1RYxtAb8lqsc9gqbc/EUCZMw4LGZL9d7oCQGYQYd/hVQE2x1V6zxrogT+A==
X-Received: by 2002:ad4:5d6c:0:b0:685:a5d2:b4f2 with SMTP id
 fn12-20020ad45d6c000000b00685a5d2b4f2mr6857578qvb.1.1706520427407; 
 Mon, 29 Jan 2024 01:27:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 oj15-20020a056214440f00b0068c38fd4582sm2601504qvb.10.2024.01.29.01.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 01:27:06 -0800 (PST)
Message-ID: <ee99d75b-705e-4ba3-adac-f4798b0a0d6c@redhat.com>
Date: Mon, 29 Jan 2024 10:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Two minor fixes on virtio-iommu and smmu
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: jean-philippe@linaro.org, alex.williamson@redhat.com, clg@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240125073706.339369-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240125073706.339369-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 1/25/24 08:37, Zhenzhong Duan wrote:
> Hi,
>
> PATCH1 fixes a potential issue with vfio devices when reboot to a
> different OS which set bus number differently from previous OS.
> I didn't reproduce the issue in reality, but it's still possible
> in theory. VTD doesn't have same issue as it use some verify logic
> to ensure right iommu MR is picked.
>
> PATCH2 does same thing for smmu.
>
> v2:
> - Remove redundant memset in realize (Cédric)
> - Add a patch for smmu (Eric)
> - Drop the patch to support PCI device alias for now, as it's tricky in
>   using two different IOMMU MRs and Eric already sent a smarter fix.

For the series:

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>
>
> Thanks
> Zhenzhong
>
> Zhenzhong Duan (2):
>   virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
>   smmu: Clear SMMUPciBus pointer cache when system reset
>
>  hw/arm/smmu-common.c     | 2 ++
>  hw/virtio/virtio-iommu.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>


