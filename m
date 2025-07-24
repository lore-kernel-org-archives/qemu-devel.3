Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uerdP-0007AD-Cf; Thu, 24 Jul 2025 04:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uerdN-00078F-4G
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:49:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uerdK-0003yJ-GJ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:49:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so588012f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753346936; x=1753951736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gI0lIzYMnzT0FK8ryv2cLbnKY1SrFeu4IVfMLkbQGkU=;
 b=RHbt64899HHOqphnc8nCrXl25lZi/axAqZyuHEj53MemVBV8fSF2/CzFFkJAEzL7Q/
 kkHAUNPMSzIitaqkWhNi/sfwV4i/iCbspiQ3NJOLC5N6R1LcuxN3MbuOc15XA8sGOkrA
 Uq7vAGHDcdkfxKcd97FpHG6G4kw679fPoAfU/mcdu4hWglawT8oizn1FuuA0q+mLDSpy
 ehG/SRR6uGzS4+IpxNIUYEoXMVLEom3SG/L7tgI9EbBekA37nRvMLXlDXvdiZqgRyVaZ
 CI5eue0LHoOgx02I+wkCql0Eq9uzixos4iS/lx9BbPRnjSyCRFS1OF6r4GpTFf8jz018
 Xsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753346936; x=1753951736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gI0lIzYMnzT0FK8ryv2cLbnKY1SrFeu4IVfMLkbQGkU=;
 b=JpWV+jEvLbARB6xvuSPgVusgu3tKtDYCckFCVISZpwO7KSWPECuTxaLJj/4nrscmvw
 AB5EdZuwnfsp2aU57YcZESWVNZv48LXDZLOMPBgRrj85imSh0SQ+wXyZTMQOdaLszdev
 CG8yqvt79sTTnsr0myP7tu4LvCkN4RBntC6AVfdJFe6qow2OeZ9DNprAuuhPk3lr3k0Q
 kC1XXWzjudmbQQ3ApNRR9tI4oH+T5eSVw39icjgF1VdVAWO566YSkypHZLJGENwdLK7F
 A4q7ivdzpFGGrcIOHWeT1ljpwB6Mc03Uz/Uw/1vnv0wv+3Io1wsg5iN8FXqrA76L+exU
 64Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAB/qxQHn+jdLeTxwf/GNK/7COCD2byUHThvPS0NkzcWZKh4WzZ+hZYQiVA8lMYnWbC5kuXwn08La2@nongnu.org
X-Gm-Message-State: AOJu0YzKIIWqCFGB3q7O3fmC6JIbgX1MnEC06RZKO1B8E5S492iDk05D
 6HdPB+0j341Yxsg5qNTbG+QC5N4A287cVXhqTcBsztAKFXCsHWakmHQPlFyRyCAjkvk=
X-Gm-Gg: ASbGncvpW7BFwJVeKufhZQN2CwqC3/VKapsKlTXddU15DZ0c3yqBliupiX4l5IXcgzX
 B1xHwZpeGwZbLL/4jPah/A6oR0zpJ5Sstd1DJxHUjJYi/rme/4dZ0O0pMIavT/YVDrdU8kF+PcT
 Ls2ML+t0Let9qhWYTKFSzZzgJc7DgEe8JE04InF9dgrseSJPSBpLiwGYCVHJF0NczJPDhFFX6Rc
 p8BpJ5CgzbYZwm7TnqJd5Qwhaj/z9QZo+V8VfKuAvnxbW4Uhmn+zCQNI0wIm1FWy21R5KrLpUDe
 EjStM7L/2e0FpDuxrIOS9/Uih7+1bkWSiMg7sKqHJueitlNd9PsdGXjt2YE+fcVb6a24d5OPvwg
 S8yN2iGlLJYWQk7ruf46TGxeiOCCsw9q+SFLEQ4u/z/bIvdSL0gaEBBOBK4IxT0teNg==
X-Google-Smtp-Source: AGHT+IFgAAD7ZHGY7qVftZE/Lh75Cy67iYMFUKJ3EcWlWJVX0lLBiXIstSGGNYmPND0Qe9PuroGq2w==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:ea9a:1656 with SMTP id
 ffacd0b85a97d-3b768caa395mr4856750f8f.10.1753346935788; 
 Thu, 24 Jul 2025 01:48:55 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcbb21asm1483018f8f.70.2025.07.24.01.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:48:55 -0700 (PDT)
Message-ID: <050bd22a-0ac7-4f9d-be8d-8d86b712c410@linaro.org>
Date: Thu, 24 Jul 2025 10:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, vasant.hegde@amd.com
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-3-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724064745.4091-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi,

On 24/7/25 08:47, Sairaj Kodilkar wrote:
> The ats_enabled field is set using HTTUNEN, which is wrong.
> Fix this by removing the field as it is never used.
> 
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 3 ---
>   hw/i386/amd_iommu.h | 1 -
>   2 files changed, 4 deletions(-)
> 


> @@ -1626,7 +1624,6 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
>         /* Updated in  amdvi_handle_control_write() */
>         VMSTATE_BOOL(enabled, AMDVIState),
>         VMSTATE_BOOL(ga_enabled, AMDVIState),
> -      VMSTATE_BOOL(ats_enabled, AMDVIState),

Please have a look at the migration documentation:
https://www.qemu.org/docs/master/devel/migration/main.html#not-sending-existing-elements

>         VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
>         VMSTATE_BOOL(completion_wait_intr, AMDVIState),
>         VMSTATE_BOOL(evtlog_enabled, AMDVIState),
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 8b42913ed8da..67078c6f1e22 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -322,7 +322,6 @@ struct AMDVIState {
>       uint64_t mmio_addr;
>   
>       bool enabled;                /* IOMMU enabled                */
> -    bool ats_enabled;            /* address translation enabled  */
>       bool cmdbuf_enabled;         /* command buffer enabled       */
>       bool evtlog_enabled;         /* event log enabled            */
>       bool excl_enabled;


