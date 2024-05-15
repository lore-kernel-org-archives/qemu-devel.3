Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515FEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EEN-0006iF-59; Wed, 15 May 2024 08:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7EEL-0006hz-OW
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:59:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7EEJ-0003Zi-SV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:59:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420157ee56cso25594745e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777972; x=1716382772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Pyzkis5NEj1XifpvXqdusqWEdlqFSHqTdfJjsMZUlM=;
 b=k2VGd3KHcjWOXdJlpqNbB2r2VLEIHaUruJFztVB8VHEHraWZaaNNExhRWsTYbnb2Ue
 FQyfhu5qoUs/m/X59Z+e6/H8te+Oqlus6KrfqYE0EBHAszS4LbbQaP7nbyYA+orsUMxF
 vEs5xdZSWzjoA8oT8xDrpw/L6/irhUC5uj/jqK8xRnYi+oNG+dumyDfJLXGPCNjSgUTB
 ouEWGEDC0KNNzJ7kggZHEl4CtrjSNmaofvyvQBrkWrz78eui6R3T3rWbNdPth5VO1RkI
 TVnJpn+4CpUH48QVe7F8LSajxpehgjU+yJOVUMeZoHP2jmHxla+QxcoWi+TlDYA/0frV
 X19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777972; x=1716382772;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Pyzkis5NEj1XifpvXqdusqWEdlqFSHqTdfJjsMZUlM=;
 b=k0z3EK9L34cUFlptgkuYQeAyr8jha+22+9AAoitbLFveTVi2F+mboQiMbEx6Sak/7a
 A5oSGSr9KSgoYeG0suPIYL6H03rg6wWOTBVTWmPT+LRO2O+l4UUkpuJZquuF69IXLyG5
 iSIXFSubEZPJiMV8X4Xz7u5cEBkOy1CdvfestdUEiTRCxWAf7aqeqZSMKHjB2zyP4FQD
 ztqhTqgW5ocVXSQkrrZjzCbGAIVtUa46Q7F7q2IEGO3jnZb/yE+/Fu/OpwJk2OdtndzJ
 gUC8U7G75JN8Vnd6tTSVGriEOXchd8w/VsgzKT382cTapfE4AQEVF+IQZPDryc+IUJQ4
 FjFQ==
X-Gm-Message-State: AOJu0Yy/2Y7ghWOIR2lK0MHTiDM1vpDjEK4jySAV/j3N1ceHcxktxY+/
 mCbVL0m22+y2q6i1Ufb5K8CxdscQBsz3NPlw8cNwb19vmp+BuRa/Kd9ZYFvHZ6oHDR12D5Kdh3n
 WFXo=
X-Google-Smtp-Source: AGHT+IF5wOYEX8LO1N2Rseh7cQDeHu8CMfG8BVSkchj2c0f1UVvY6Uvk9F0sQG/kYtYEXT/gyX6SAw==
X-Received: by 2002:a05:600c:4ed4:b0:41c:f64:2f5 with SMTP id
 5b1f17b1804b1-41fead65a50mr126484105e9.36.1715777972457; 
 Wed, 15 May 2024 05:59:32 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87b2648fsm267844405e9.7.2024.05.15.05.59.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:59:32 -0700 (PDT)
Message-ID: <9ab078b8-b9c3-42a6-bdbd-3eddda1d1c60@linaro.org>
Date: Wed, 15 May 2024 14:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/34] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240515075247.68024-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/15/24 09:52, Richard Henderson wrote:
> The following changes since commit 3d48b6b687c558a042d91370633b91c6e29e0e05:
> 
>    Merge tag 'pull-request-2024-05-14' ofhttps://gitlab.com/thuth/qemu  into staging (2024-05-14 17:24:04 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240515
> 
> for you to fetch changes up to c9290dfebfdba5c13baa5e1f10e13a1c876b0643:
> 
>    tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs (2024-05-15 08:57:39 +0200)
> 
> ----------------------------------------------------------------
> tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
> accel/tcg: Improve disassembly for target and plugin

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


