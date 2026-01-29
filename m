Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08DBD6100C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQRN-0001Ua-RG; Thu, 29 Jan 2026 06:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQRL-0001TX-T4
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:44:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQRK-0001tf-Cj
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:43:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so772889f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769687036; x=1770291836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EG1b2E25uPPycRnSDZlttadmeC7xMOmaZm7E/W9cq3A=;
 b=lw8TIoFoqhMnrkOwLDyxfM0p3RoMEoQ0WSrMZWLUn8yUp14FRxYA2S+YRbQnbpq0+r
 /ZveWqJSQSIV3Sg25Secny97oC6+IfrKCKkSnLf9cqPl3rdVfdReOuKwubLLZL6Bpx8k
 gZqOi3+GjIIZCATM7cYTjG6A1MNwcGOm00+sVKuLoYTNNVHZN4PSyWyKWRyKqT8u7ynK
 3FFIxPjEYcnOdsL79PYw0OBbmelUaVNL90tbuBrgrDbxfJ+N7Vd2r2d9kunGD3xsJRP/
 ZelGsUjpg4Uuofp8umLHj0k15lbvACF/VS+3Xy0hL0R389hgI36hGnWbFaQMCGkPO+JA
 4D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769687036; x=1770291836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EG1b2E25uPPycRnSDZlttadmeC7xMOmaZm7E/W9cq3A=;
 b=GF99jUnbyWpJvpuyoYCFME2alaUak5s0pc10UaKr9hEm2zdXvF/seMAF/zL1oRIdu2
 9dzgGjd2T1TXgNyoZUC7PtLj2qf8QgINA+1CyKmalcb+nt49TydSrBKLaLoSEyTp86Pz
 V/ohkReAEoj5u2zBWHLpTcROLQiggwH5HNO2rmpXrxUPbjYslzOTGN6R+HBsZF0fhKvk
 O+oqFrvbTSbNu0CUqWgaMkYMBzCrilZsdspf0oGXg75R+BzjDRA6lrmHGGwB+2sR1bdw
 GomH+ZSCc2moZ2AHzONhwHBi/cHaNfthLc4CJGdq9eXbYHqXBUrc1KgExdTBIzVbKjOH
 UhdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxEXWZKpynSHL9E/KM6m80GLOJgF3mnxUk23zXGwxSYb6bkV/K1YmazRgNHhzMEPE0hwTlq9Eeaxaj@nongnu.org
X-Gm-Message-State: AOJu0YzrTCLUHcn3FIq1KrUJQaKHdBLdmO3CjgQeBHs8VNFvUMzL/a4U
 gId6aGUCoZapX6Ohiw9Ts9rZlS1R0mt0l4aAcMxd7nIasB+xdlonTGpYZTaDkchhsYM=
X-Gm-Gg: AZuq6aL0hZ5a2TDGXBP7pVdoqivriFCQwUwwe36tkOXFfubbaGZ87kxvd/OLXKxctOz
 BZl2fv9STYXtGRh/7T8Ca/hM9hj9OsozOEM2SrxHlX3HwwhbMOUnE2lHcVpwY8uwaXQAGXRacrV
 kF1YH6y3JPk0VztPF0SgrkviMlaJrNSbtAChbsbK6JYA3dA6iUAUW/YASL9pfjf0SOs2bTtAgmq
 86MzlgeJwn/dnRmBpFwZbnROnBbcOukcDmqxsVlf0mJbMi9tkQXp5CAJmabr9usQSXgOcI8sQnB
 NYhUbrDEXK5xzVUfyj3+eY2VqHUTKr8+wTinuEqzWM3jK0zU1Ew1OEfaCdge+9hy++abbHuZwv8
 rwutry1MaD5DS5JOGYXVeWsTVFlk9QZjKdkydrViNJyItCAiPfrFL1LMxu19fWBmXdEf/YFuF+h
 Z1F/ux3MpEK+uPAWNne5UMTZLgrwomjA2oiHSNXcfJ1koxNRCuUVN2Ig==
X-Received: by 2002:a05:6000:2511:b0:435:a464:f468 with SMTP id
 ffacd0b85a97d-435dd1cd4ffmr11976243f8f.47.1769687036214; 
 Thu, 29 Jan 2026 03:43:56 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132368csm12824998f8f.31.2026.01.29.03.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 03:43:55 -0800 (PST)
Message-ID: <70fc96ff-a9f3-4c09-a557-aab1ae17c705@linaro.org>
Date: Thu, 29 Jan 2026 12:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/arm: Account for SME in
 aarch64_sve_narrow_vq() assertion
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260129113455.1283266-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 29/1/26 12:34, Peter Maydell wrote:
> In aarch64_sve_narrow_vq() we assert that the new VQ is within
> the maximum supported range for the CPU. We forgot to update
> this to account for SME, which might have a different maximum.
> 
> Update the assert to permit any VQ which is valid for either
> SVE or SME.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> CC stable on this one, because it might also be a problem for
> a CPU with both SME and SVE but where the SVE max VL is less
> than the SME max VL.
> ---
>   target/arm/helper.c    | 2 +-
>   target/arm/internals.h | 9 +++++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

