Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD35C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElfq-0002P6-VL; Wed, 05 Jun 2024 04:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElfp-0002Od-6H
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:07:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElfn-0007g0-IB
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:07:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso4087585f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717574825; x=1718179625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0CLUxImJCNTyDOlarEDSgHWByXT0evwM1Rt3B5l7m8=;
 b=rrpOqjIbQCumOf64ZQBwP4z4v5cHrmqIWLP6Xk60fbcNa4Xvzio5ykfUB7r+S9C4DI
 J/n+x7K4abF50C+/WDgPxfTtBi/wO77ZDtV5RcElBzoHPNbgIKiqizkETVBKfPQ5l4ab
 0BvelwV01PgLHo46BYBKovfVWdK+BqxbjWb1RKjNrGGD/fAPxhSobHyme1PgRHVVc6iC
 NShEGGAWWySJVynmo5b7M/auwmV4dJVtOKG2fD2Sv7WmY9DzykBrJ4ZyluBPXgGdJ9zJ
 e3nXypa2zNsRJOgIJFzo/HJ81XphaEce1xz3zK12LE8iaX/2a6M6Gc4EcK9fqYIhUcqu
 UX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574825; x=1718179625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0CLUxImJCNTyDOlarEDSgHWByXT0evwM1Rt3B5l7m8=;
 b=Nn0A3kn5QBwEmAVh2C63GPjg4zUcQSVLGfwsraGI/umgSIZga+fzLvTbUCwKchDniS
 E4boSHpErTLRlUROAl/e5f9tZfMfZ1lZ/NtORTBRoApmELqhaW14rRVL6DTVNgqnvFpu
 mQ7/UzI5VpSQmQhImf9AZhu4AwwFPV19O0qpX0NFvblzQPFwdtwBNV5zh7AlalIrbkE7
 yVHeP0cj39tq6eGngQrBpTV/RYixhDBRisW5nHIijZdxPCkf1Xn/qtZetI8znpRgO/LQ
 qb+AnF3gWcNhEsVzG7vaY1raQ5xKsB/w8xlt/uFkQRpUWKccx7EpVwr37on2SJrV20u8
 mz2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXU/K5ccM++ssedXfUvVNKxzgtziQJpimqqbgZv3UeAzQjJKyjZ4F8eszVud/GLNOTEYp4Cap+Yp8LiLS+Bw4WNVqfdOk=
X-Gm-Message-State: AOJu0YzsQ2WzOE/eoW96RFhrRybzEA691dQOFZNZCNX7L9i+K13VA495
 6aNzh4xYMi9KJb2369jLVPbXNOEs2Sd5nR2PTh+xqGc60TdR4T3UvuB+IKOjrL8=
X-Google-Smtp-Source: AGHT+IEsX8S3b/azRTwZfl8u4Lch50VjSgD2+EsFJPhjXsA33EqHVS0wqTK5Id92GYNfRCbv/H55hg==
X-Received: by 2002:adf:cc85:0:b0:349:d810:9974 with SMTP id
 ffacd0b85a97d-35e84062f00mr1354424f8f.17.1717574825549; 
 Wed, 05 Jun 2024 01:07:05 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066ff17sm13534630f8f.116.2024.06.05.01.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 01:07:05 -0700 (PDT)
Message-ID: <b23238b7-1c71-46c6-8815-ffc619b70729@linaro.org>
Date: Wed, 5 Jun 2024 10:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/37] target/sparc: Implement FCHKSM16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  1 +
>   target/sparc/insns.decode |  1 +
>   target/sparc/translate.c  | 32 ++++++++++++++++++++++++++++++++
>   target/sparc/vis_helper.c | 23 +++++++++++++++++++++++
>   4 files changed, 57 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


