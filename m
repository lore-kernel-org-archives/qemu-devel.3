Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72AEC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyJg-00034B-Os; Wed, 06 Mar 2024 15:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyJe-00033z-Oy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:56:42 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyJd-0001Ku-Ax
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:56:42 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d3f4fef377so1120711fa.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709758599; x=1710363399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHbwU2HRXntGLyOsLMl5iC2LPtKiWekG3p/lykF1u2o=;
 b=JrnA9mwg1SRPp/OFGhXuSgDNxK2THxAww95avBdD8tNGqd5XOYKMSUrK3zbhaLa02P
 JF6sIuFymOWgQxoFuPNl4zziiG567LDO0YhUdTz0ZeMNCJxSyzrN1epSMBrS+DRBW3p0
 IJmA6ko1Kj6UJtHQn0KGO/Hzr6vORJj898IohLfEZoUj1JNxQcs5eWX+jA65sOEfJUYn
 y0Up2GO6nr8qGEtnVT3r+b8UIttFOZQVBT0u1nGOTsn3BgMTcXIkFz6Ih9W+wC4Eprt6
 Myksi3zZg/aXxCH+NY2ZpPFJJu1pyoM32OtZr57mdoGR7RdyrWFPrdeXi2hovCDq7EHn
 mkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709758599; x=1710363399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHbwU2HRXntGLyOsLMl5iC2LPtKiWekG3p/lykF1u2o=;
 b=r19ciGud9SwQtbTMK3+WugrQ3ntN/3lBtuUCRMV4lsm5jQa1SPjdXj00lMQkJ3Y/+2
 rt6it0ot3yU9lSWi32nIMqh5vjR/mjvKjM0ceQctzgevSmQ/TOiFRFyq7k4UQ35hdBSl
 aBJ6gXEZKXMk/52TnjTZNTcs1X1uxzV98OHxwDOMoPtELDzmW+hycsCeEUWOxVLjZ6yS
 Wd/pJp7MkEtmL5U3sCMZ7feiQyOIh48F2XipknkjVFWrjnyyh8qxQygNUiUsbJdmGe39
 ZXKIkHif/TWU+nv9WeflNcSCYs8n1kf+SVQY6n4nnKIdYIqOuQshZ0BlB3YvK6i/7C8P
 5S0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUtuvyrzevv6k6C0/b1FAMjJD58kqrSuvgT+FBnw6Ns/+RFyfwdITC1lPqlFaxCu7wcA1Bk8AUmmx+qq1Xc8Fl3Lcl0dA=
X-Gm-Message-State: AOJu0Ywft0iCiOdBkMIHQO2GxoOqziKb0xbTVBfj3ytWav6vDul6A8NV
 H6F21pWkHhYnET9ZqKfQWuUN9CbK6kwfY2n4hcAj3zs/a/xULtEt+BDL6OGlP7M=
X-Google-Smtp-Source: AGHT+IFCgA9OsNEws2mp6ug7lTiQtcgqeXqbrLSlfjHslSFoNcrkYoHjywRe7/SHxofVssCqQdpSDw==
X-Received: by 2002:a05:6512:61c:b0:513:7:fc3c with SMTP id
 b28-20020a056512061c00b005130007fc3cmr122735lfe.55.1709758598862; 
 Wed, 06 Mar 2024 12:56:38 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 i27-20020a170906265b00b00a441c8c56d0sm7502525ejc.218.2024.03.06.12.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:56:38 -0800 (PST)
Message-ID: <a875237e-1026-41d1-99a2-87e3d2ec7196@linaro.org>
Date: Wed, 6 Mar 2024 21:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hw/core/machine-smp: Calculate total CPUs once in
 machine_parse_smp_config()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-5-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306095407.3058909-5-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/3/24 10:53, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In machine_parse_smp_config(), the number of total CPUs is calculated
> by:
> 
>      drawers * books * sockets * dies * clusters * cores * threads
> 
> To avoid missing the future new topology level, use a local variable to
> cache the calculation result so that total CPUs are only calculated
> once.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/machine-smp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


