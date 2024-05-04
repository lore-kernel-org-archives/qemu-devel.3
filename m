Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44ADC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 14:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3GRf-0004gC-1R; Sat, 04 May 2024 10:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3GRd-0004fz-GD
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:32:57 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3GRa-0003Ug-5G
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:32:56 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso428009a12.3
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714833171; x=1715437971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYOn5XI4TmMG4xq9q1rS47FLba5V3BJLGhlysxtkrAg=;
 b=o6THBbV9+opra5RmNz1llryySf8oK6pMo7hpF3aufDHfo+BK9Nm6vDn2rc7VP/TxzH
 6TQDqgB/SQ0n7bRAXaIMZyR+rVtV9btdDXO1NdZUaIGafxBsGdoA1zsNgV+YfA6JU0R3
 rP4nTCPDc/nJeNZTphVqtfoZj+T6/ZQvsJgUsoWoOIdCECG/e3rQMhvH8GAjpIo7hhot
 Ov+FwO8HfAaNVQijSM5cDc1wRbfClwEGYpCL4vo7W2GOVMOgnA8xkbmXUesKFFcZ0ofe
 x5elvsj9RQj0kM5h5ztCMSjg1xMaU8ArtP0ki9AFHzVPp+OM+jK3czob5Sv9OSbgaViB
 JHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714833171; x=1715437971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qYOn5XI4TmMG4xq9q1rS47FLba5V3BJLGhlysxtkrAg=;
 b=N/Z0tuUAcKMTPxxvWeGa5sQMRb2X9atGocccTnGRGQJ5XmXa+7xZ1sWEw2rIrCpTg2
 CMOsDEMwR9PBUA08NwnucFppl5dydZ9jctjCVQPIAlSClUdZkDA9kvU/VJT+CgP+c3aJ
 /G/pHPgDQW5ilZoh+YB22soQNBqtPB2pv8zgoNn6xDyZLvAkZmGQXX18mLAqAF6W5UR8
 7cGbpgsDLz3L9ctKcinbNMjBFp5dyuCTgiHuYretZDo0yflS6MfWGBJu7zneaEI+XAWP
 Xq3X9YLcxbwy4nrbH9t2+iTg6B9yJjHURQSej4XUDSp3b+CnBXSmWGEBZWMD9T5CXWWe
 Lo0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vKb3dK+ZRTJ0dn0X9SmJC0GJ841lckMr6ZPR1rZE3h7jwX3k86b8IcoM2aORRhv9fnw+AXne+u2U8EPlxWeCRSsTJ+8=
X-Gm-Message-State: AOJu0Yx89Mv9K/Wi+PeZXeUHpvu47Wdq85r9rzexQGAn6SacAZrv8+zH
 QeWyeTaPYGMrmOkNW0VAJqKNdpB2tQioU9NbmYqTguJBbE4Es2FRNJcY6Fqz80CuwIOOfc0okUy
 k
X-Google-Smtp-Source: AGHT+IG/yluUTX9LivSNXz38RL8SxNIBeA/p28plF7TZ3fKJAvArXVozT83fDntQ1zQJ4r7RH2J+bA==
X-Received: by 2002:a17:90b:1e0c:b0:2b3:28df:92bb with SMTP id
 pg12-20020a17090b1e0c00b002b328df92bbmr5415595pjb.13.1714833170926; 
 Sat, 04 May 2024 07:32:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lt10-20020a17090b354a00b002a2f6da006csm4981295pjb.52.2024.05.04.07.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 May 2024 07:32:50 -0700 (PDT)
Message-ID: <de22b9fc-6d8c-47aa-a192-878904efd3db@linaro.org>
Date: Sat, 4 May 2024 07:32:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/npcm7xx: remove setting of mp-affinity
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kfting@nuvoton.com, wuhaotsh@google.com
References: <20240504141733.14813-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240504141733.14813-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/4/24 07:17, Dorjoy Chowdhury wrote:
> The value of the mp-affinity property being set in npcm7xx_realize is
> always the same as the default value it would have when arm_cpu_realizefn
> is called if the property is not set here. So there is no need to set
> the property value in npcm7xx_realize function.
> 
> Signed-off-by: Dorjoy Chowdhury<dorjoychy111@gmail.com>
> ---
>   hw/arm/npcm7xx.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

