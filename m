Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517BCC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVWi-00037m-Ge; Fri, 08 Mar 2024 03:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVWg-00037I-PS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:24:22 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVWf-0000m6-3O
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:24:22 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e695d0614so348023f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709886258; x=1710491058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cP/7zi5aZT7PRRFJlFAMOl6R1BPyQi6hPQ7rPylzosQ=;
 b=LYSgkTC7lCBRZr54JKoWtLzPCneD+NR2SoYzGy+PLV3JBkH8ETYoUkNqZXgsST1xR+
 vtXg6bEtpIn40XKkYfdkxBzJ5RkbDRX9rtSsDAzjlXDjw6MiWKmVG+zM2v49nzD0sdTC
 3ltzawr3zsaw9uv6N2fpt0/R+m4lLvCC+osVEnPc6x7zKAk4zXaqrh+mXUNvs1I8lDAb
 FsAh75D9UBHNNhrI1hi3y/QIBU+sE3hwfJRHpyh6VnPYsApZHVY8h28uO7AWXesaon7p
 8i1TTwU+qau5l8S5IhdvZPdXQXPW4M63WIE2oMyG5SHhNDB0ai0FKyq0aT8tC/UXGf1l
 O85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886258; x=1710491058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cP/7zi5aZT7PRRFJlFAMOl6R1BPyQi6hPQ7rPylzosQ=;
 b=JGsNOsLIHQhKioGJHUkAZAbByprAjfKDH3LQofetAgS+PrXR2+3/ofTaY+rvzM4SPZ
 LJgVHKcVVoDffEZx7LnS3VX1Y1k/nrfaZixepJUbFvhs3lHQW4hFCFluEvKSRZ4ZZjva
 OeuBRXj6kFtm6TE1Y5/UI6IlJnM5mFbVmC72cmenVeakz7cIu/Z2kKoz+J9GVoTw4NaV
 3dbnczKOEWVMo+WhgYX1buCnFnAw1/I8oV5HsNVm9U55hg2UBWv0c+pYVAVG3QC/5nwe
 dRsqyoh+rOl2pkl4HGY39HicO5a3Ulffu5sb2B7Yc09CLcL+1t4XAdLx5X8i0gNLk2dY
 b+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhJ00/zClH9HBCuxRV1OSNHXdlTrwEF82JA4Pn6X8m1TY/eQnk6K6LI/bGALtQEzj3giGLlT3YpMVqYvAGgr5XkTRY4A8=
X-Gm-Message-State: AOJu0Yx0alp6E9mScNYaI/zlkGXxwzq7aTYohD8X1iq0rVH/tRRgKLg9
 /OgzQsjDRqcMNuC7DNq7Vaj6l+PKxUKgNvY1fF1ioonN374+/Iamr6AwRBLTR58=
X-Google-Smtp-Source: AGHT+IEvyDbgmp4Xa0IiK1bvnUblWowE77pTDa3Rp0HD/WjSpOTAHPRlJekIqZRQVYl7wpykNex+4g==
X-Received: by 2002:a05:6000:1972:b0:33e:5fb9:af21 with SMTP id
 da18-20020a056000197200b0033e5fb9af21mr3415175wrb.56.1709886258297; 
 Fri, 08 Mar 2024 00:24:18 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 f15-20020adffccf000000b0033dedd63382sm22328095wrs.101.2024.03.08.00.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:24:17 -0800 (PST)
Message-ID: <9fc9084b-28ae-49ce-b4cb-887872b527c9@linaro.org>
Date: Fri, 8 Mar 2024 09:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] qemu-options.hx: Document the virtio-iommu-pci
 granule option
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, imammedo@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240307134445.92296-1-eric.auger@redhat.com>
 <20240307134445.92296-5-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307134445.92296-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/24 14:43, Eric Auger wrote:
> We are missing an entry for the virtio-iommu-pci device. Add the
> information on which machine it is currently supported and document
> the new granule option.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v7 -> v8
> - precise x86_64 and ARM
> ---
>   qemu-options.hx | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

