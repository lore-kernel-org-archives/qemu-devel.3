Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF497C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIM8-0000XK-2E; Thu, 20 Jun 2024 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKIM5-0000To-AW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:01:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKIM3-0001JQ-Fj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:01:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso7659665ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718892094; x=1719496894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F3dbBBmH2YFdoOS786B3xdr58XyDez6lNiChGf5Hv70=;
 b=liWYmUwDp/yqhFqVxXWrNriNcijinY/18sJo+9Gny8V8ynBd/R2+KZhxyQSRhppFLR
 CkKF5RgegGZo5V5+8GIKneQqHKzlwVTp8tvTXOuDykdmnqIZFXQ0PBCC4dx8Xfkdo9u8
 8bzWvb5QGKCDEuTBklTxyCePeermjLcNJoYSaTf4AQCFH6VdUBeHzrUZmbypVqWjj/k0
 HB0VOvIAFPZtYILgDlWPxScbPclFgxiTIbF19eEK1cK0kWd27No9zoMrLScBuUX479Fk
 79EPhI6hw4D8ceirYvjEF9UCro3INR2r5y5cYq7ctw02UqAcbNmWEGiOrJSPmky+aq7X
 TU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718892094; x=1719496894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3dbBBmH2YFdoOS786B3xdr58XyDez6lNiChGf5Hv70=;
 b=NAjvCiP7m6ySi2ymXIKsVEYBLJg2AoBeeompTPb0k7u4YNRwpW0ojteCsXI6VjeEg9
 NJ3EFt6FgkptgelYAE2Ejq+IJDvriRyPrWWRfb6IRwzjtCwVwq6cX69S2IfCpaKJThT9
 X+4ZVbIoGkvYyxSF8pLTxeWz5K8om9DvYK6NZoby9mRqe95I8wk2GyADylZkkIu6amH2
 qGvItoSd+dNQNymRwo2EVDYacDUAqnKIrF315UvSew8pIJayWsnyIlL1hjzKP23SH33B
 wueN8fsNrge7dHj3yKOlaLuDLbW9DP3tZ+BYF+/aO5D7OHqW4bCWJCQ7qA8YYP8Rt3ef
 x41A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjoUWXiJ9ZJ1K6r5hxIdvnNdNr55mGBb/MmkUK4pWWpSBPa1DpjVU7h5fH7hdpQtwmDCVky3PmHYDUsFwoF59Qi9HAF9w=
X-Gm-Message-State: AOJu0YzvyzK1X6jkUyy9cUqCKOhTsx4eIdlaHNsinp13Ho1gx0JiB+v2
 PWdscifKey4BonR8ZKoubG/dNUocp8j9yLwPohNvktQb9pszryG7GAGInwH1wm8=
X-Google-Smtp-Source: AGHT+IFJvAC3lZrD9sjz0PdaY5NYEiae+eLUR6H/xtCCIPkcD3F3I9kSX/HQV7f7GYTnQi+uwr3X2g==
X-Received: by 2002:a17:903:32d1:b0:1f9:c52f:d9b5 with SMTP id
 d9443c01a7336-1f9c52fdcefmr26776605ad.66.1718892093474; 
 Thu, 20 Jun 2024 07:01:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9d551ca45sm11605085ad.116.2024.06.20.07.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 07:01:33 -0700 (PDT)
Message-ID: <d32a653f-f741-4c59-8a6e-c2094e972009@linaro.org>
Date: Thu, 20 Jun 2024 07:01:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/19/24 13:13, Manos Pitsidianakis wrote:
> +# FIXME: These are the latest stable versions, refine to actual minimum ones.
> +msrv = {
> +  'rustc': '1.79.0',
> +  'cargo': '1.79.0',
> +  'bindgen': '0.69.4',
> +}

A note for other rust newbies:

These versions are pretty darn close to actual minima.  Ubuntu 24.04 packages rust 1.77, 
which does not support (but has a warning reserving syntax for)

> +    println!("cargo::rerun-if-env-changed=MESON_BUILD_DIR");

Since even the newest distros will not have current enough rust versions, we must rely on 
'rustup'.  This may be available even on older distros; for instance Ubuntu 22.04 has 
rustup via 'snap'.

I think this is good enough for rust development within qemu, but it may require that the 
configure switch be opt-in: default no rather than default auto.


r~

