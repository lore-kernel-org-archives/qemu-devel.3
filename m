Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E43C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 19:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04Vs-00040Q-JE; Thu, 25 Apr 2024 15:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04Vp-0003vE-WF
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:12:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04Vc-00087J-3i
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:12:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572229f196cso1706658a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714072308; x=1714677108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yoQyYTnOJnBUKrJHgoUZoANUhMpyJxSfXj5RF6dki+0=;
 b=yuqu49OCL1O4IQ5Nnk1r/YbaDDTevMAhYou8Z1eeoP/2hVuvDUs7b5w+EZXXqaIW5G
 JeHpy0nM7ZHLw0WZr0HmipgFd3lDtwx3RWICDjoueOOFmk9z3Z8GT8WXPlEaC6G1TK7C
 xg8JdYayEe68DcsSaE5N4NJ+jYyXKZs0Rm6Eqcx7hXZLsbS3LS+V0Hi4tWjo/65ywDO9
 ia22sMpTkQYdJNfAnDa4GfXilVXPcdlR2nPUSaXL5fFqcCbwdoHut/jUnRNhZ2KEAsbQ
 DJVf1KXs7NaDhLxiBCLOmgAzgtE6jQRdR5wOb/3PgBVUMpOmJRmmq5AFsD7cXXZDkcWs
 TSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714072308; x=1714677108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoQyYTnOJnBUKrJHgoUZoANUhMpyJxSfXj5RF6dki+0=;
 b=Q+YWdI227FA6LwD3TtVpyHDM9U/dT0eIacuAFE1bUDzeG0bYtZNFu2XOnqeVzOc1Mw
 7bAbv/n9uufhaKrpn2yt/aKPmrDCw3ZUlA0aF5ppTFpqmxDbkXmmN4MTDfpnK5g83BmT
 DL1V29P9oD45pXbqL+Rgt2vLG+BNi1LCw/KADJQt1yzXaM4H49SSo9q1BCjwD1UgkDRP
 TGXjquFdkZ+XyamquO4CzoxFeNn5iMnt0nqlNqH3DRqQ/Rh+5iXVIGXZz9b8KpNfNxKi
 gv22sfhz1NDUonY9f6VF4PsdNAeJ7W2gskB0fHCUgp+gQVUwCbM2des/LTls0FbrXiti
 IPjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/JLH1eFBJMlB2aHDfz7HgWXmpPR2DElU8ioIAe8lqGRpfwVPvmH4UOH7xY5AYJuiHh9IPVU0LjI3CuiSpKA4DlZxGkuQ=
X-Gm-Message-State: AOJu0Yy3KS1RO3WDJer74wwd8etfpRlhUEvnX5TceZAxpTa6ww2+rNh9
 1CRXsrKJq9buHU5zArw+0W/hTchGMalNKyaLyBRtNS8DtDPjtcMR+9CnhJs5uxwlBjqX1R8QKcN
 eiH1Qy31VgFwnNNXxt8P1cAQstS8DD8Z0It2c9g==
X-Google-Smtp-Source: AGHT+IFFIUX9aSQjSwc82OpTXcWJgunHjh0AH1bbrn8kk9d5FVv1f/rehmJ/4qW56OVCq6Tej7Kzqa5ZuXgWl4IdR3Y=
X-Received: by 2002:a50:9f43:0:b0:572:3fe4:18b5 with SMTP id
 b61-20020a509f43000000b005723fe418b5mr286293edf.32.1714072308482; Thu, 25 Apr
 2024 12:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240422092715.71973-1-zenghui.yu@linux.dev>
In-Reply-To: <20240422092715.71973-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 20:11:37 +0100
Message-ID: <CAFEAcA-=tgsMbvtZw1F1Fxo9YQmBKvx2oXtD3rDFfZwMoGitRg@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Remove PL1_WRITE_MASK
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de, 
 wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 22 Apr 2024 at 10:27, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> As it had never been used since the first commit a1477da3ddeb ("hvf: Add
> Apple Silicon support").
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  target/arm/hvf/hvf.c | 1 -



Applied to target-arm.next, thanks.

-- PMM

