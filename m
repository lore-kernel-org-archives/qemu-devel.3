Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A217DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 02:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJlJ4-0002Ej-OU; Tue, 18 Jun 2024 22:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlJ3-0002EW-SH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:44:17 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlJ2-0005Ct-5M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:44:17 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c7b167fa12so602672a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718765054; x=1719369854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7NJ7PHOAaBt8nNBYNxvfdSRtZUjaIR6UPq0Upiq8y9Q=;
 b=BYLOtAUW1ZI1lOQ4rpifMuSk+GLYbDh7qA4BUNewgBESdPuM3A9f/cpb63YE5fSVN0
 qKboV2Ph4J73Z0+bO+Yw6HxqFKsSO8z3bsPBzm6kdP7khXTsTs9++74YTEl5bAkiDq5v
 m5M02JOvs9v3DenaPD9x7EJ65apxi8lp+r+hIP9fCtnTjZgyrA6tTZO1dLjIFemIV4Af
 KZBsdCoBhf1XuBFuLiVGUmfHGCMaTL3fEvVBbZFSw0Y/DDqKjvFV2IrZq/l27CthSs6T
 8yVyjcb/qsUy+osFwikolBv12aVRlhwdWKd3NQqk8icIvdQZa2eZtIXS5X1yrkOnOAEk
 TLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718765054; x=1719369854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7NJ7PHOAaBt8nNBYNxvfdSRtZUjaIR6UPq0Upiq8y9Q=;
 b=eR/wpN+/5f6O4CCGuV8btSRNjDdhlAiTxiB/9AvTTTY9776zoKnVStha2eFJwm/4dc
 us3KGzSWSbKeI/dvejEzltVfv3dpge+r9TQW/ktzKhy9q0BSfhBIkBa0dZcM8MiMcVAs
 BIXZbh9t0yJxuECTnLm+6qiKFgPDasV2jTnB2xU15+WShkHTUbCfbV62X9kWe8DcZJLi
 JNfVHOv7AGxHJ5M4XAgjtJNf13dSiImqMeSTRHpVanY5mu+eQ34MfIEot0s+Dn1/4xKM
 zoDpBNNJ8w2Qv5msNbmDm9I+T/bob/WRhcFiaj+TCOa+aSX97vSWGCA6ebhTc1UMyVtF
 Np7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSq0q3Tj6i39b1ac5AQxc9p0U0tBPYSo1ZJnSZ0er67USxzdlxXS8zUzpZd/XpyMRnZT6BQoaPofcIWHBA6V6OIzKjQK0=
X-Gm-Message-State: AOJu0YyoWHFJ9XLiEi1ARtTgPWc4JGP6isHwRJjcDt7k1hvHPAvpOG9E
 eR481lOS+WDhx4x+K8UsOVbFL+2r6sMY2qSxYXmxQ5YPoJ1O+sibKXuoUUhxfUo=
X-Google-Smtp-Source: AGHT+IG+WjjQvy/BL/s7nju3Pq0Olyd7Ad8S3TsgmqTeTzIhgOGLFLFwCM2Jg2R1OrLuriLuRu2EgA==
X-Received: by 2002:a17:902:b695:b0:1f2:fd49:9fcc with SMTP id
 d9443c01a7336-1f9aa400e65mr11259365ad.34.1718765054530; 
 Tue, 18 Jun 2024 19:44:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8988c2e97sm29300595ad.170.2024.06.18.19.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 19:44:14 -0700 (PDT)
Message-ID: <7e51b3a2-ec3b-41b3-ae85-d70b04179b5f@linaro.org>
Date: Tue, 18 Jun 2024 19:44:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 0/3] Xilinx DMA/Ethernet updates
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20240618154935.203544-1-edgar.iglesias@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618154935.203544-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 6/18/24 08:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@amd.com>
> 
> The following changes since commit 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
> 
>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' ofhttps://github.com/newfriday/qemu  into staging (2024-06-17 11:40:24 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/edgar.iglesias/qemu.git  tags/edgar/xilinx-queue-2024-06-17.for-upstream
> 
> for you to fetch changes up to 3a6d374b754b4b345195ff6846eeaffedc96a7c5:
> 
>    hw/net: Fix the transmission return size (2024-06-18 14:52:05 +0200)
> 
> ----------------------------------------------------------------
> Xilinx queue:
> 
> hw/dma: Add error handling for loading descriptions failing (Fea Wang)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


