Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaDR-0000Hf-As; Fri, 23 Feb 2024 13:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZis-0002ih-4Y
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:52:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZip-0005mV-DU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:52:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4129833e069so1935085e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710749; x=1709315549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dc0dCMziFbBR5ys92M7RMKGPfrVHJeCpcr0ldbOMoew=;
 b=RqzkwfcOoFaUSjGgynYmxS0OFI/tbU05RbmelXtJ00/2YzOFA57w54DGhINX4CHDrN
 8bzdFBDHndApvfbFTcisf1UWlwIqctU94yIAFjPt6qe8mbs8c9jZkRqk81saRbZQlwld
 zidQL/W96Fr+O4GK2CbOffqInJGj+jd0X8sd/EGga0g8mxFm0s/3+aUaaXNUKicVSo8l
 +mEJy3Bso8xw1y3Qssx/7bAcZIAZkIADueVDhcu7Q/amwNUydlVKU1BqUC9ZK1PA4+z3
 E1ujH/kmfHrsUKwg/i0hZIxQNvobbgazDmgIFSXA8WayyqKOI6yFrg4sjEHrYRFEs4u8
 zbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710749; x=1709315549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc0dCMziFbBR5ys92M7RMKGPfrVHJeCpcr0ldbOMoew=;
 b=XaqBuLILnjgdxzP+ejsJInyJXgbcdmizH5IkraquXE/xj0/QHiMGkkGuf3j/QKoOw4
 alx2CkfSq1gXLu0pcg/v7UFbbIVSY0I3I0Cg2HUNK7NWY+Iyh4heTUd+S0M9utr5Pb0q
 OTOdHLx/hPGSEDziQNhSXPClpKn3k60/lzGMbU8d1wFmhv8H/kiCzSHnaRdm72bWBJLj
 ZQ5TlAooOFeSYKRA2M4whIIAP7rI6MTZHhngGnSL7j7cm3wSkbIqyzEelDGRc3F7xvrz
 awfcYLwJlYCn09ZIpJa1A5U2qV6uWq0/qXWAZbNB5mPrTYWtXVttGLZPxzrDXcJxbrG3
 UMrA==
X-Gm-Message-State: AOJu0Yx1WRRhUOPHe7m2ZaZkdPwErigfYmSSzHa67Lk3EG4TEn+qd5z8
 ZpCHx4Jp3mzrjPXJaFZji9TUm6iWciWfGyHcjM+X9nnOqD1EQQdaGmt1IWd+WzE=
X-Google-Smtp-Source: AGHT+IEiUm6Bgi2hDv727QEWx3GfWDftJrDQ5CFDN9u45DLKGu6SZf6UcSbXSmZuslo4ow2GDLlWHA==
X-Received: by 2002:a05:600c:548a:b0:412:84d0:6a71 with SMTP id
 iv10-20020a05600c548a00b0041284d06a71mr382393wmb.18.1708710749234; 
 Fri, 23 Feb 2024 09:52:29 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a05600c0c1700b00412952d3cc6sm2858181wmb.7.2024.02.23.09.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:52:28 -0800 (PST)
Message-ID: <26daecfd-4216-4a70-a680-22fe69b42f9b@linaro.org>
Date: Fri, 23 Feb 2024 18:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/intc: Check @errp to handle the error of
 IOAPICCommonClass.realize()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
 <20240223085653.1255438-8-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223085653.1255438-8-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/2/24 09:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> IOAPICCommonClass implements its own private realize(), and this private
> realize() allows error.
> 
> Since IOAPICCommonClass.realize() returns void, to check the error,
> dereference @errp with ERRP_GUARD().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v2:
>   * Add the missing ERRP_GUARD(). (Markus)
>   * Move this single patch into @errp fixing series. (Micheal)
> ---
>   hw/intc/ioapic_common.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


