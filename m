Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB07C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcBX-0002I6-9d; Tue, 15 Jul 2025 05:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcBS-00029t-Es
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:42:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcBQ-0001dl-N7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:42:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3675069f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572563; x=1753177363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8mIFJLmwS/8Kxq9dIURsDQR9ZY+idIH1oOZCni9frdo=;
 b=SBbwsQb8LxZFxqFHTXj/FmmmqknHBvGGOOtdEa5JLJ81jZ+0oF0nolRKIn8upZThuW
 XDGJsoH0ofsuteetYKR1slndX24T4VXgfh5R/VEKFdWzBBfofb0sczEApw4xaVG2qvsj
 RQc5g5dDbnHwy4P8Az0hWSImJdA/EfNd6GcUvzQhqI4X2kKbdlbsBkw5kq5+78Ly6Agj
 3EecGr1jXpf/KkMvWBEb3HLaqd4WkTNS6/1bSoR+//p/JuTgcPIgSPMFz9nrvjTloscn
 bqkbiH+KPtqP1Na58LzuO0PFo54XN3w38CcrobrlQSvltpK64l/SuqiblQQVEOG3uFCY
 3hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572563; x=1753177363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mIFJLmwS/8Kxq9dIURsDQR9ZY+idIH1oOZCni9frdo=;
 b=Wh8QlnE7FvoIdTYHYCWAqaADA4twquSqR4kpNu1RKGOKk6gM2z9PaFQm95JuRL2Ndh
 WoW3bQ+sKpGW+83zpkoVsaiFiQFeQqizwQ7DxfCsSoMhGaXXCunVMb/4Hb9qE+6drUDn
 OSSQ5JGhYDlaCqEE6GQH53P3Tkgy76ZNvtHZesI88PBg96mXkOpu6E89V28kAX67gvAR
 4jMm8szTDd3m7M6L8Et5gyRkzctoH/BR+8hQBbeS6l5Dwg31LRXclP0yxcLcG122RdLU
 XxE1pDgqirJRPD4fxeJ/IZ103y6bqyzVhZpqsRr9F6ty7QOC3XfRyN1aQF0W5iVHpLqk
 YFFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK24L8ezHB9V1d9rUhAfY2U8WG8Y6EPazBJqu30nD+KTp13ISmL8x092ffjsWBfee78lNuLEUCe34v@nongnu.org
X-Gm-Message-State: AOJu0YzreCJ8z+WVyZSppT0e57oh5Hz0+IeTyJm0xM+RxWNeXrwkDZWc
 xtdU6yFZHRi3mRvxG3SKPBQD/McNcM53y/AXbYXEAkHnOiKy76GlHjBb3mD/yBlat1Q=
X-Gm-Gg: ASbGncsEeNnSoRCSavH7l9Ln44F3dGrRTIqBmiTrLKyNjip+TL6wdn9/mUtvGzEG59U
 yLCL24gIuoeW8Ne/N0vtSQNEPTFaXptcat2EYCZ+sL0FeywBUnyzO4zck5q1HSL/LHGcda5iAT7
 I4UR3yI51pGeL7A3Ss16yEG6nurtZelUjlqskBOoKYRqOUaH346vTKRW5x2/Y5Khxyl95wD6hLY
 7dhI2c0ar2YuXk4FUJ8HWrK/uIhy0EoI3pDuze/fMM30JaGxcnuBqFjfFkbGfPIB5KYIkY0cnGV
 0LhQCw7wM20ZjffULepIDVFtA+xtf5QTtMrmZDeUs6wDNlCaOvcXM/G2IWlAQeWZzve5H+wpBqY
 4Ia7xcbRrwAgsgk5XqYbSfzwqDcup5da0RcSsUUB0rvOlDyshTJNmy8D4zn8pAYVs4+TQfnI=
X-Google-Smtp-Source: AGHT+IEXUNNN+kHdMAgQRjl0MwxIWvcxVofzsaafOT8dUKD5wKfLp7WuDT7IuOjbgbkG3//EtcEj1Q==
X-Received: by 2002:a05:6000:2dc6:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b609526044mr1956558f8f.10.1752572562643; 
 Tue, 15 Jul 2025 02:42:42 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14ce6sm14887420f8f.68.2025.07.15.02.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:42:42 -0700 (PDT)
Message-ID: <8da6ab84-dcea-4bf0-ac83-f91df165e1ed@linaro.org>
Date: Tue, 15 Jul 2025 11:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] vfio-user/pci.c: rename VFIOUserPCIDevice device
 field to parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-14-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-14-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Now that nothing accesses the device field directly, rename device to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index e23a941605..9380766548 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -20,7 +20,7 @@
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>   
>   struct VFIOUserPCIDevice {
> -    VFIOPCIDevice device;
> +    VFIOPCIDevice parent_obj;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


