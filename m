Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D2606A698
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KXK5IrN2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWpr-0006Vu-Id; Fri, 20 Nov 2026 17:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWpj-0006VI-5S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:11:54 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWpg-0007Yn-HV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:11:49 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3b40d23e1adso1148506a91.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795212706; x=1795817506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EULMrh7YhhBGHxx5L4yQa07ygg8Vf55jzhOtWHUT4ns=;
 b=KXK5IrN2e6YvFJgF8T5qkbXBFEX4iS51pLjh1BuMMbr77RUxjBWPTpaXO0CVzK0ew+
 mHpzVdSdz690XO8iX3K8EiOqlKOywX94Z5wR1ZDzRXLk6j/M8Ajf/Gu/q/1PNmIeHXRG
 JW9QgflhIFRtU6p58UZkLXim5TLIBLRvRBuiHJrAMxhXYLu0VxGZ8Wr7X83mqm3/b6mn
 TeNN7Ac7xtU4BnxpAeG0d/1jwI9tbUfuBSzL14T2DwTUF9DqO8n/vIYhlaCJYxWoi/A4
 gqDtaka7cEZdH4mMMk+yFrI9yjVUtoglzKkzFCnsn7DmP348sTrXafq9ZSH5aAUdCedZ
 bHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212706; x=1795817506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EULMrh7YhhBGHxx5L4yQa07ygg8Vf55jzhOtWHUT4ns=;
 b=ONDFK1+QbyoEzFVP/wmYf21+8tWuipBD0MRa6MxgW/HSyEC7hcRZ8rtIRmq4v8vC1h
 eWKJVhbraoOFFcpu7KUX3tfBWmk/UiMd5U/Yljpm37zyeYOqBHCleoXJOcQ/jP6JqOGb
 P9wB6KnKUD8hwvsnofG7rn1Ck1tRTM/z51VDXRSizaC8tV4a0qWQyZzif/ZNweogcu/7
 a9+NiIL/5k80v5K6YUQHNk+sv4CdiYjO/Z0bj7TlukQHbBxcvUACzlLf696EAhv/vjFl
 BNeVKeWfsxQrd0EJX5n+xBYVp0+acJExmVhZEBcoKNJOqkxQcCb5HTbRX12jz0G5ImX5
 afSw==
X-Forwarded-Encrypted: i=1;
 AL+hErHCc0ApVuVhF/uDSze95sPKFEePiaaRZcT4npNd5u80oB8JHVPB1A4SDDjWWlMj1Ssaf7nGZAzAuUNz@nongnu.org
X-Gm-Message-State: APuU4Z+ivQxTuu8F0S/JiPXa3j9ZqgqLOpkBi53B3E38iHDHdETtJ/ZC
 Miu99zgzxdTCZg2/8m/r482h+1gaxkF/UxrV/G3pmUMFBC169NPm9xO53XAKMePs/gbx8kG4112
 6QMfc
X-Gm-Gg: AZFdTZfSvYeNrnXIXbbZiTvB5I4zABamDJyhFY5MNm0vvY18tndMvvNAhjvhtPBQwr6
 +OZpEkj/iVpHDC0TLy8eYVrjqthgDOa6HTCEilolrIv2mm4M3CjU9TrKl7/nTJvJ2oAJPibqy+A
 QBN4bFud4NbaScKlst+7P0MIv8csHN9vVc1LlzQxyEErxEcVcT5xp0CDk6TZxs+ZB6G0dkskYz4
 fZBdU3j903halUtScmdUJVbqlG1t6GcHa20zn7QT3yMSrNVpfbvrgVu58OS0VHvj9R/qTjur2xr
 ItmhsW5YXfCUqkQLybBszn1gk3qm40UQwVHr7JdbFxGI5PsTku0OqAuIgLwmxClqSZhsuslYwqd
 DFqBzIWhHLCjC8g+zQ9zggvXLQhDU9GzBBbFKJ4mHy6Ibv6Nf/RwqZ5OQcwGDFfBhL+ItAKItQq
 qv+5Bl+siZuW5hqbXwcPUrzGdXX2y3EpzIscV1BHd1Pi0vV93gTNF6WtK9cthS+vqWcoYXg31SU
 VAmHH/BES6iu1DqGsoc1AMQt7NVGbYSUvHtIqwBv0JS9fBWD9jI+TuHQsLMCqrac4Mmh327JVG7
 zo2vbd93jgy/xZHPNt0nBBURnhXFnYkA6mTOSoIcb25zIL4T4StYJC0ag5yKcp+2BCoQSwY=
X-Received: by 2002:a17:90a:e70c:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3b41c92a182mr4307790a91.28.1795212705520; 
 Fri, 20 Nov 2026 14:11:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b409330ae8sm8583057a91.7.2026.11.20.14.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 14:11:45 -0800 (PST)
Message-ID: <1b6ea899-8793-4170-8cc4-4147fe53c4c5@linaro.org>
Date: Fri, 20 Nov 2026 14:11:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] hw/nvme fixes
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20261120122949.1044-1-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261120122949.1044-1-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 04:29, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 08ed97c33c3818ef51a7c852347a28e9f66807b5:
> 
>    tests/tcg/i386: compile test-i386-blendv.c with -msse4.1 (2026-11-19 13:54:13 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20261120
> 
> for you to fetch changes up to 7e203726411b7a28b2d020339d6267c7c7d4134e:
> 
>    hw/nvme: advance zone write pointer only once the write is committed (2026-11-20 11:32:57 +0100)
> 
> ----------------------------------------------------------------
> nvme queue

Applied, thanks.

r~

