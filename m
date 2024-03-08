Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rick8-00038y-5d; Fri, 08 Mar 2024 11:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rick0-0002xM-Jp
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:06:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ricjy-000739-B3
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:06:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4130ff11782so7249645e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913992; x=1710518792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1asEl1O5NRuq7BRNuytOhqZUbr+LzuSsHUkCznxMCfA=;
 b=Lv7/1NRY/mvPoCPuWU7zgO+HTMpQ4OBPHNnKuM+YvkVHNGL3fP2jlmdEzARMPJ2bFS
 KYa1JquDPG1JP4yoBR0ZUMj0lkHi81Z7rBuWxWZXtzPMfAozN01RT63oMZswd/6q0oBy
 dJ16sFgGC21b8aF3e4G6trTPDOoDrD5T3+cByPsKD8kT6H5V3sWN+T61VnwugG5L8EF+
 oi5OWxHV8zRUT3kykhO0fveB2cZyv50E/3+8p3I04hKSsygS5gHmGu7u+MAONL3epumX
 pWI47EEdjRZEqKe6LGLWSlDYVTQEEBRmaq+u1Hi0ZJVvY3OUXeqgNP1kmkcVGvS8TTjR
 L+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913992; x=1710518792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1asEl1O5NRuq7BRNuytOhqZUbr+LzuSsHUkCznxMCfA=;
 b=vh78DTkKsj5vnCscJ7YB/JPbjct4AikCLQnpq42s/BG9Ih8EMzEzPoAVSBmrtwxk1w
 pgp3eLGzAmKJ9fGM3SdTZBpcY+TP68oVjeYILc8GG/nPaBo0VbPTsHM1RtItSpbw6rh0
 ddXSCh3lppRC7AF4pca0/NeiZpkQIGSOao6Kq3osVj3vxYD9p0l5/9uE20uXs+wouXAM
 oTV1GnSwj2dTEJOtg6A3OJb0JxHiVVQUKegl7RgIWdBNkuS0GXtSUVRN+8z8eKlppPvX
 i0+ifwv2iLIy7SQTOOYbRuzCEVTYN/jI96oRkoR5IA/Pp68E5d0Iq1WZKHmyHDF+1VX7
 FQeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAmmFTawTDsvPiq3hmMqUKhG/4fNv8znpQHOwB2/RVGTtyFfrh+z/8WeyULtrIr5qVyS7oiM4nFNIk24P8bqswo/ji4gM=
X-Gm-Message-State: AOJu0YxmzahxSRBdkfmQE1wgd5dHtYOKdb4xV2D9LphqXqYtsb2yWYUb
 CqU2dQJSJCoBiKzLgPZmJ5GmSZf3pWy0DDBPy3npztkhAjWhFSGVtaW3EoF1CZA=
X-Google-Smtp-Source: AGHT+IGRvIXuo4wrIs77IAb+1VHdabCyOExjQq5+w+q6Pk9o1pGYrGyZv93RdwqId5gp9ULsfKCH5w==
X-Received: by 2002:a05:600c:4f07:b0:412:eae9:38df with SMTP id
 l7-20020a05600c4f0700b00412eae938dfmr7674425wmq.40.1709913992437; 
 Fri, 08 Mar 2024 08:06:32 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 bo16-20020a056000069000b0033e422d0963sm12986710wrb.41.2024.03.08.08.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:06:32 -0800 (PST)
Message-ID: <2d0bc502-b684-4b0c-ae88-085276c1b593@linaro.org>
Date: Fri, 8 Mar 2024 17:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/grlib_irqmp: abort realize when ncpus value is
 out of range
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: konrad.frederic@yahoo.fr, peter.maydell@linaro.org
References: <20240308152719.591232-1-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240308152719.591232-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/3/24 16:27, Clément Chigot wrote:
> Even if the error is set, the build is not aborted when the ncpus value
> is wrong, the return is missing.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c | 1 +
>   1 file changed, 1 insertion(+)

Fixes: 6bf1478543 ("hw/intc/grlib_irqmp: add ncpus property")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Patch queued, thanks!


