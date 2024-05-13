Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FBEC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6TtD-0002Mi-Qx; Mon, 13 May 2024 07:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s6Tt4-0002Ew-Dn
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s6Tsz-0000Wu-Is
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715599826;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1vbbD8eyh+YapZ1tbyTXmaKMwlt/B2MBUfyCaE+HSw=;
 b=hb8hJm3fHtnf1ASXRk8cyyfTOSCgE+Pya8ZbtJ6NGsKh/Xl8zE2NWvYakFUHahQmxyYQqQ
 y5XP816bqBc2Su/XJJjO/AGBAKaTcln5HjN6e9bBkIFdGZbj35OEmdY+UbX1WOFTfDiKNI
 pcMMwGQnlmbu67XkMmGMk8l23WdLFM4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-kTyTmOu_NJ2uHWlhl7uvNA-1; Mon, 13 May 2024 07:30:24 -0400
X-MC-Unique: kTyTmOu_NJ2uHWlhl7uvNA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0c1aff9f5so52354346d6.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715599824; x=1716204624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1vbbD8eyh+YapZ1tbyTXmaKMwlt/B2MBUfyCaE+HSw=;
 b=ZuxQY3fK/BdPwB1BxTzSihJxUrmknCyT4tCHfIHJ+qkzjQ3ynlHEBMd8tHAOTAXArw
 62cqzkjsDU8/eCKsDc93xtvI8zv31Qa201lwJABOtw3bLnbBE7ZHLfPRJT03xz2SJEz5
 OJofQQqis/mZUMQXueFojbq6zdVqNtSS78D1qqtbzkjcvJzWFZJUXETHKkgH+mYIMPxa
 H66Bc3udDm6JNJzbinVdIlUGtWVh9TPVDeKCPPtzAQqKtnB9layQVdvaZZmThYwZOfWx
 79LkMjJT3chwR0nQL2M4CEeUduImxAtu0ASXQYV9qzkDPN5PF1GEZ4P2zwBheQ6dSdbW
 s15w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAyKgvh5Zern1tXtsI9OGDrc0V1u8ZbSJiHqrp5ZZRrGTRuq+6VUdBmgmHzY2Fsk3gO6z5f3oDELQnd6GvDpZhmn6+7Kg=
X-Gm-Message-State: AOJu0YyC05KOQASlJTdNq7z9JISpWtNaZAVmzPE4XLRzUGi6mAXEmmw6
 gPDEyo/b2FR5bkCJtrj21xxHEBOevm/zDer5g71EP7p968adT0dsIEZ38wi1zInK9QkSZElUS3a
 bqL/O1lfUcqmFSxRZn3Hsx6h2ohJlVtQEZ8QZzBWlVJ0I8Nc109gl
X-Received: by 2002:a05:6214:3bc4:b0:69b:1f75:e700 with SMTP id
 6a1803df08f44-6a168219c4cmr120015006d6.33.1715599824191; 
 Mon, 13 May 2024 04:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ82wfEGl4Jm1rNxQ9CJyAt8e/rrBFCNv8loBl4XFqtxKeoo4OnSFLeAwTqVmZzFpXZH6YxQ==
X-Received: by 2002:a05:6214:3bc4:b0:69b:1f75:e700 with SMTP id
 6a1803df08f44-6a168219c4cmr120014846d6.33.1715599823867; 
 Mon, 13 May 2024 04:30:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d73d3sm42602996d6.114.2024.05.13.04.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:30:23 -0700 (PDT)
Message-ID: <34258a31-5bfa-4005-ae04-6e56a2fab671@redhat.com>
Date: Mon, 13 May 2024 13:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/18] hw/arm/smmu-common: Add missing size check
 for stage-1
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-2-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 4/29/24 05:23, Mostafa Saleh wrote:
> According to the SMMU architecture specification (ARM IHI 0070 F.b),
> in “3.4 Address sizes”
>     The address output from the translation causes a stage 1 Address Size
>     fault if it exceeds the range of the effective IPA size for the given CD.
>
> However, this check was missing.
>
> There is already a similar check for stage-2 against effective PA.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 1ce706bf94..eb2356bc35 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -381,6 +381,16 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>              goto error;
>          }
>  
> +        /*
> +         * The address output from the translation causes a stage 1 Address
> +         * Size fault if it exceeds the range of the effective IPA size for
> +         * the given CD.
> +         */
> +        if (gpa >= (1ULL << cfg->oas)) {
> +            info->type = SMMU_PTW_ERR_ADDR_SIZE;
> +            goto error;
> +        }
> +
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;


