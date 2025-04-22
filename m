Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66429C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Kbb-0007Qj-Nj; Tue, 22 Apr 2025 16:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KbU-0007Og-LK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:52:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KbR-0006tx-OA
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:52:27 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so267416a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355144; x=1745959944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBDuSsebM5n/DP2WveNgWoEj0bxGDV3kkGz0iuwbohQ=;
 b=URZUt+rdIqPpX0Xu2zspz5xiYnvx62Jx+mITaiMPaI49OP9K5jgZgDwkjgKUnuTahW
 NV5hSjhKjufF0QTIpspBrgh/H6rxRMG2u5yfQAmDoWwbr9Qt6gqn7MS1EZn7hEzD0YwL
 IEOiP6bNYOow7tW+jgWeztaHevf++nkHxAGGx9iMmW1UW2SCkyciV5xfbcIYiTzEvckL
 iQsuAmzisvUm21eaNw/oc2/o5MkIJYC5pNohm2MOO0f3zDA2/fe6NkW8t1Pjq7UeLTtG
 GO6ruR/R57c5ImjHoXmRvu0ZhXnL6o7N3rMhopMCeA9LYZxOZEIanzE/ScvLEv8/k/vK
 PmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355144; x=1745959944;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBDuSsebM5n/DP2WveNgWoEj0bxGDV3kkGz0iuwbohQ=;
 b=lW3uwgVwVlqV8g36C8EtvzbEN1EqaoiAkFbHGMb5/FuvqSWGr4tDl8m7tB3DrVZBtY
 VGGzRd70iXRtV2wgp4vqSMgSe6dXVWkFwsCkWfr2pCJq8XgQPi4Yd0C29/z2g3EqEW+y
 yoKrko1aHNZXzyCTchxjnIshuBpwk1OY4pmcbt9eaWFQ4l4RAwKX0ZJ+spgJ+MiIsJrt
 lrFvxVwFiSqc83PW9NBW21oChkucHaSWCYtPQN2yfjiIrb1w/ijH4PR7wPWiyE/fYRCi
 DKDjUoDYQG2AxjGCK6px6y1JcNPBQYygjWUVtbaLywZr5wMYurSa/p4e1My8nlUQM/9T
 /Mfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTObONy/d8fk84p7MvlNaFT2lGWb+Ev7VtJzw160U71HzZqjgCB1b7C03o69Z0mHBMZS8hV24WhAvF@nongnu.org
X-Gm-Message-State: AOJu0YyAB0dLWkqzV6gnJ0yWpW+9pnrynjXvg19WjzE6umv1akI+qCwj
 cQ49JCCpTeMus3BGuwEAVhDq5ioF72ExlKOvaskIZq1OoSUYOwam2x1yrj8+9t6vvijgxrvojZ9
 W
X-Gm-Gg: ASbGncvQFUXnWwggvN7dA6L2P7J4HXlfY9+hPYI5/lcR9E+hyLgw/rVju67uNxEDW4n
 5zXYuDxbeKRcFrCoszinilRXeNODXxO0nCd8ZMTI1GVCEmZlpgCCZyA9w538uXt2mJx8vbFKy9/
 5Hy1DuXWiHTc8uXHiws7WQjijPVbAVMsjzya+GPxvgxYV5KTNxOjVpQTdC/R0wgkoKajGqk0qAF
 NiCXRgtYzoqF+fgNn3Qjn6D5x+gckpu8T8Vk4LUr5J2tCm2QZCfbX5Df9TtXcgWdJiGMvjfNwdC
 dt9mmS7bZSELxn8ispT8feHFU4m1LcL9OOEMlpse+MP9JV59neRY6DWj6inPcToN
X-Google-Smtp-Source: AGHT+IG/YfDER5ZQ4xSGpeazfT72wn/Zn+nUpHBa2swY2bGPfcEf48tno+tgvU2naeeoXDGWvA0qsg==
X-Received: by 2002:a17:90b:5750:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-309df162eaamr516399a91.17.1745355144170; 
 Tue, 22 Apr 2025 13:52:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22d86ad7ff5sm46054405ad.136.2025.04.22.13.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:52:23 -0700 (PDT)
Message-ID: <79589aca-cb3e-4713-9361-f4ee9fd3ccc6@linaro.org>
Date: Tue, 22 Apr 2025 13:52:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 065/147] accel/tcg: Rebuild full flags in
 tlb_reset_dirty_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-66-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-66-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> Undo the split between inline and slow flags before masking.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


