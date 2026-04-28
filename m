Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793ABFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbdh-00022U-UA; Tue, 28 Apr 2026 02:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdS-0001mp-QQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdQ-0007js-5f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so5814767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356566; x=1777961366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rtYH4PQyyJnj1p7aRo0kfTr9/95pcoWQx2j9Q6QiHf4=;
 b=chYpD3vm9pQsPR26pyplkHBeRsyltt9rEQJsFrNMzXYKFLE4nXwKVIOxFJw3aDfH48
 rmUX8/czfs4m4fe+mtn9pzccxCSrAYcVnRg7ltNVTPpMNS9tn7KkfcRFCrYVx2awBNqO
 VtfkeIhPLtvXh6VWtaKKfKg+NqML1vcJ2OdS9tPFtjR1bxFRxslM8ONx/SrmhNcTK6YQ
 XVrRtjVDBAco48GbNFB6XfQf3dv3o2TrcGiT0DuuPF4qhjxxiNsSiO6FTK8k3zCJylhh
 aHSJHCUR472N2XSIKx/qvDHfWwcWaFOD6pYrU+BLyQQwzIf5XvfuFNGt1Er4R7+Np4oI
 jsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356566; x=1777961366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtYH4PQyyJnj1p7aRo0kfTr9/95pcoWQx2j9Q6QiHf4=;
 b=Q7FuLFv1nxnlEmOzaXGctLuGRc5z+SMKVmmbeHzlf4WL7LXKez5Ssgd3K1QO7Qz+YJ
 RTB2KDCNNIP6fgQPaLqhQlkZJYcbzr3uPlPsROexgvXDJyDZ1FtII8rcbrlG52g5VQ0H
 2qozw9lFqN5bOHOvsXoGqnZdg9yXryFytQy/6xtyQ27pDwgpUlFruaMdZpdgQp5nkdSQ
 lhikXfrYcvdUaSoUOdhDmCNhWIDOqKQceDJQoFvg2KD5Tw4rAY4zVbUPSZvk3QSv9vaC
 8fSG8glce8ZXu2OZ1GmE2b0r0euMqSFMgKjlYC6S6DJHKNVeSo8L13FUo2YwjC5RM7jS
 ZDiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+N5cddAN3xGjLsuow4xXK1O+4QQ5hRL/m+e2AlHrHZgV7yRTFAWUDQCfs5C1xS1eiD05D1obSfVVgo@nongnu.org
X-Gm-Message-State: AOJu0YzP72/q38aMbPgS84BdtjzMVRdZ2EKb12cwqv60Mdg6/+YLZjHq
 f5EfVjwwAOBD/U07ykuoKBMQ6s9IlnfJrGWqEheQeSvjMmxpnQRVVKcoawxyZyIp+e8=
X-Gm-Gg: AeBDieukFM2UP7//AwkXB+VZs6VPYdGozimP4H8gnRrgl34GBEqsS3YHOfLJOQuNsq9
 nFjude/23ZohuUe+I4gyNDtVHutidwZHrPtisOTKulaaExHewNqCj517vABCJo64jif0zq8T6Rs
 W/xLfriyo79NxYS58qgvt2TmQ07lmunkf/OOJqJfiSm1KTJtttIN887+gLVp0MkRLDpBvYgXMXz
 g80+OnMde201IGny7pDJDJUi2OylrmHm/PBJrxbyogmc8V3WNeepQWrztybTV6Nd4w3+bja7Md5
 kqnyEseK87D8cDmXk57Wp44aMiQaW0paIiwhlR1Eact0GmwsAMw0Xk3HjPloxiYyEM5nJhwTan9
 8MPgNaoFKJ3LoknC1Ggru0jSTa5g5T5tJRHJ+kLY2jxdjkGbbWKMtSrSbAHetItuBqIn/130YA5
 XP8nhWbq81gfZ1T2D/FHjkC2HpRLRMmumZ7v++xL11/HcrkR+YkCiRhP6BcbzzCMcTg27xXITwl
 C/c
X-Received: by 2002:a05:6000:4e4:b0:446:96b1:f51 with SMTP id
 ffacd0b85a97d-44696b1113fmr1119854f8f.22.1777356566434; 
 Mon, 27 Apr 2026 23:09:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4464004ed80sm4141211f8f.34.2026.04.27.23.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:09:24 -0700 (PDT)
Message-ID: <54742395-8d3c-4e5d-97f9-0a06a8fe7c6b@linaro.org>
Date: Tue, 28 Apr 2026 08:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/84] fpu: Inline float8_e5m2_pack_raw into single caller
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-51-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

