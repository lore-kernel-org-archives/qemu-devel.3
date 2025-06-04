Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF1C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkBT-0006xP-8g; Wed, 04 Jun 2025 05:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMkBR-0006xE-7F
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:13:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMkBO-00057U-BY
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:13:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so3801285f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749028391; x=1749633191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PC+8TVoNH4qOBsVoWPPUgGxgivazm60wSr9od3GxM30=;
 b=XQMBta35ZIE3HiFQIOmf56GglzOstX/Eoqy8RgQnHUvd1zFgMJVN2Uvd7NGMyaqvPp
 Y05K8hHeohBk1LmLri9+xyBAqJgfWAKv03Yq3QGlPogvj7tO75hh15C1xz1aJtDbsuCW
 df7qwDAnbYXP3PpDpb5Ulq5EvGRxshqJy9ZJ29xZ6K1CitRhHZJt1CR0P9UbgEdFGd9o
 TvqazbKfF6reuTCGReMn7mLYM3+2hWebZRe/bvIPaVe2MQJsJRcxDBlGOujbM+Qwvx4a
 t32yxZvEdDnCScoohvLvMC7JT+efjbIN7srwJt/h2lQuBoTqDkjK85ALMcM9A47e8PVB
 917w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749028391; x=1749633191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PC+8TVoNH4qOBsVoWPPUgGxgivazm60wSr9od3GxM30=;
 b=HMYIVAcw1PRwlVMwQcoisMA0Cr7zPxZiC5guKsQecC6+GZI+fu2byV0wz7El1tOvJV
 0LRreZur4XySsd9OUjWwXIn5DGxZSTWjnXiHLZ+X7YmF8HKliqZDufBuFMTAZmIoUdRr
 040K/OOGlrYjGm2edsxZ4XezWfsfDHb9WGtX6sIDSZm4hQo39qrmJU5PCn9a4IhMJ+oq
 9Sj1zu4nOH/3yxkzffQDGxxxX6zakByC7nXHelP/eP90Ijqz59+81LqkRjTnAcGg0Ev0
 NPvk6po5jHFjPNgACS+lgnk+3bgiwpaA1FkqxHtwzRNpcUTSia4iygh23+jSqa4oOuKi
 wBzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1nmFfQOd1xcmZXHJPUnW+f+UGi5+up0ZzUnb2ugSXp4Wkk8TfOP/TaqnjE+jCWE+fySw8cEd5u5CY@nongnu.org
X-Gm-Message-State: AOJu0YzbamI+W8tPBj7rXSEn3scwUcaniU7Z4ePZgCVJbAJPt5iSg0Sk
 EHCY3cBP+bCAJL4P9ASKo6LtGYCaAjaCML3oDVXaIQBxcXn2zaNqenKKvzReUN5R/AY=
X-Gm-Gg: ASbGnctjCU1hZ7uMrQy/7OkExfsq0YTqv0+zbxfUfqBxzRILFN5zq3tnO0WH3poKf4C
 lwBln1okqV0mCdtyPkFWQsHKrVOey9vLQAmZye7yQWz5v1Z5pKw/TX8x8PIYdpymIMe8BsZV8Ep
 cYPHsoobo3rr5NlF+JVn+0CvwUFDG2aj91tm6Z2Vvo2qnOzqRQYaVivre8XgVizkFRLVijAz+Ro
 aqjebGgEFf5iyMyH9QOC0ij0echkAvFk4zafimCjTrH+JUakuWkPsbRalTcWRnvsZ3miPLZYKq7
 u28EVVsDNIO6MRtt5nFUsbHsWUdN0MW2ypSV+3Ft3Kuqs5pT7kni1K+5C2e+u/a1Ux7tGa3jfB4
 0R/aLFKE8De8ZTB2rcng=
X-Google-Smtp-Source: AGHT+IEqnHUsrjVbLcXp4ysDAbMJ3fBKc8pLw/MKKVlMjDKLfJuAarajLappPjp97P+9wR9WY1goXA==
X-Received: by 2002:a05:6000:144e:b0:3a4:dbac:2db6 with SMTP id
 ffacd0b85a97d-3a51dc495dbmr1491533f8f.49.1749028391395; 
 Wed, 04 Jun 2025 02:13:11 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7a5sm21254411f8f.15.2025.06.04.02.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:13:10 -0700 (PDT)
Message-ID: <96a61e46-bc27-4546-bc52-7e5d294d41e1@linaro.org>
Date: Wed, 4 Jun 2025 11:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/6/25 10:47, Zhenzhong Duan wrote:
> Parent of VirtIOMEMClass is VirtioDeviceClass rather than VirtIODevice.
> 
> Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/virtio/virtio-mem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
> index bc4f787772..93fdf9e432 100644
> --- a/include/hw/virtio/virtio-mem.h
> +++ b/include/hw/virtio/virtio-mem.h
> @@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
>   
>   struct VirtIOMEMClass {
>       /* private */
> -    VirtIODevice parent;
> +    VirtioDeviceClass parent;

Ouch, nice catch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


