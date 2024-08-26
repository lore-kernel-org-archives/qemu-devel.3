Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F34CC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWX8-0001NY-GL; Mon, 26 Aug 2024 06:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWX7-0001N4-8l
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWX5-00013N-Pu
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724666467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOWjkF7trN+Rh2/dfokXqnBfOqCkBra5qd8n1cjeZk4=;
 b=XobpoE7iYkdk76s7WgRV8M4TqspXcrhul1mEIxRVlIjnWXvNgvsgOS/sBHavCp1DqG5tp3
 TKOKyWJtF0xlGHUN6i5OKNrHhLqupm2aeEM4LFvCEkSiwWJxBSj1dkHZbey7pe4yPoj+nB
 rEU4xYcXYQnvQdjBCIOhJ7SJu01PDhU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-BepfEe7NOXSOXbJSy-zOZg-1; Mon, 26 Aug 2024 06:01:06 -0400
X-MC-Unique: BepfEe7NOXSOXbJSy-zOZg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42816aacabcso37534325e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724666464; x=1725271264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EOWjkF7trN+Rh2/dfokXqnBfOqCkBra5qd8n1cjeZk4=;
 b=M6pjy3YXb2gXWAFdbs/v+k54MuY1gsjx16voFoa3/hVzQOL7XYagSkhWviSvTNLoSQ
 G5/q9tyNy2c9VFrh7W7zmh2UvQgoYi28Ie52eMHhVFQC0uTx41Zwpaw8H0uWjQq8kKhG
 A+gcIjHw1t/xlCQ7Fox4IEn0jAZf7h+yTaJDhvr83O0X7T9pYRjn7QNW1tv9aQT8xABM
 IWQR//L7f9D+nhQN6z6Oa7pGSXj2wNiPJ/A5WLkUmngMK+tlDxoaO3WMS5TAaweX1gAN
 QwXpVtykt+nG7zLoUtjbp+5Llf/pRe5ZJb6b47MitEWO/oEoYmoTBWwHxygkaxzQjozE
 1iFQ==
X-Gm-Message-State: AOJu0YxwGBmvXnZ0HEVvU5XY9yG5qAQIwbcp434SC7h3SwbFKhuATREk
 EkuEpen7Af27JYEo4Qjg5dDfP5v01jygW978mn6zAvkkoL6Bo09kR1woDuhM56Dm8sam6C6CRv6
 uqFSF5j1DXT584KsxqqrN1tSX75bcaP1NkLDaA8/DP1eMWhAJgJ5CcOPSad5+
X-Received: by 2002:a05:600c:4fc8:b0:428:151b:e8e with SMTP id
 5b1f17b1804b1-42acc8dd28dmr73019205e9.10.1724666464142; 
 Mon, 26 Aug 2024 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJTO9Xgp804JmuAPu6bxs3u7ik2mpjC5bkFHvKh2R4wpMGOH/BN0tnID5TZoDAjlhoToFQ4A==
X-Received: by 2002:a05:600c:4fc8:b0:428:151b:e8e with SMTP id
 5b1f17b1804b1-42acc8dd28dmr73018965e9.10.1724666463632; 
 Mon, 26 Aug 2024 03:01:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373082697f8sm10302571f8f.110.2024.08.26.03.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 03:01:03 -0700 (PDT)
Message-ID: <4afd07f6-f59e-4f3e-bea1-85ed7ab5a0ea@redhat.com>
Date: Mon, 26 Aug 2024 12:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: ADU fix possible buffer overrun with invalid size
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806151322.284431-1-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240806151322.284431-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/6/24 17:13, Nicholas Piggin wrote:
> The ADU LPC transfer-size field is 7 bits, but the supported sizes for
> LPC access via ADU appear to be 1, 2, 4, 8. The data buffer could
> overrun if firmware set an invalid size field, so add checks to reject
> them with a message.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Resolves: Coverity CID 1558830
> Fixes: 24bd283bccb33 ("ppc/pnv: Implement ADU access to LPC space")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv_adu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> index 81b7d6e526..f636dedf79 100644
> --- a/hw/ppc/pnv_adu.c
> +++ b/hw/ppc/pnv_adu.c
> @@ -116,6 +116,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>               uint32_t lpc_size = lpc_cmd_size(adu);
>               uint64_t data = 0;
>   
> +            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
> +                                               "size:%" PRId32 "\n", lpc_size);
> +                break;
> +            }
> +
>               pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
>   
>               /*
> @@ -135,6 +141,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>               uint32_t lpc_size = lpc_cmd_size(adu);
>               uint64_t data;
>   
> +            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
> +                                               "size:%" PRId32 "\n", lpc_size);
> +                break;
> +            }
> +
>               data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
>               pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
>           }


