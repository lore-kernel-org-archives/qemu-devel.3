Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB4C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shU4m-0001EK-Ls; Fri, 23 Aug 2024 09:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shU4i-0001CZ-2L
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:11:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shU4f-00081a-7I
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:11:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so15083185e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724418687; x=1725023487; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lVGOgOzktMb5RnFaf9kIgY6hEZ8amRY7ke8GleKQBFQ=;
 b=Cjik/VxxIZMESTXF92FbJsZhM1CRk/FEVD1HW8zIiOIAmluwGhFgYqZovtWGLCVqOI
 3XEYbe6AEE9ZleL74Cxk9DQjt/xz5RE90lX41fO5nvL2fVfgFS+e2GlKNLzTj02Mqdwh
 7RLAitC/KjeMW/BORspwbsOUP/Tb5GntTNQu6Pqv3p6Sf5klVIV5gNEJwtuLKJTSvGBN
 WG4kncjZ1MTMcH+WSqBCt7ilAmERBQZdneztjzN/IdSeF+9MjsphhrFS6tGBDX9RsIvE
 R7FpSO1utYmJj3NOY6nI1W90B5r76K3CTwb0Su0caJSADi8GX2RghzbFBAnYcCDJ7dcD
 AFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724418687; x=1725023487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVGOgOzktMb5RnFaf9kIgY6hEZ8amRY7ke8GleKQBFQ=;
 b=vW7Zk677PHaPdnOD4/NAgdjtvD5OcfwkIiMFnVG2TxV3b1oTkH3J9eERef5PnEYiEG
 6MpWV+mTQ0qoHrnCmTce8gMpozy9uLrUX7bcJtRc65/j9IcRjcn7RPHhveoqrRbc8xB2
 THfLn+FEf9lS43fY9odSvkJTwGLNy9KeaPjqr/BysPvxkXn38xgxf5cEWRCb59sTo+ck
 nQAzbSKuXKihZ5z5Fp7rkaZc3enJlnG6Sya0KjSZbMZi+s9ZmfpfsgxRWzdjkdgFh+OU
 slPAQW3u7i94OOg97tw2WuoZ18VsxWB/AhGgBcu5MY4ZaBxCpOFm7pRorFfHwlJZW8y2
 bszw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdmjTy8AnafnWhqc//Yj+rlS504clyl3L8qGMxYbmUrRVZQH5Z/s3GZH/g3fPAZWjCXWnMGmAE5mYR@nongnu.org
X-Gm-Message-State: AOJu0Yz+AK59ptOx1+B6zD0+Lyrsd1xwYrcJcEWhiRW6jVCWGowh7TYW
 T6GLIGuVaACzDVdKXAwofxfDVFuO7ygnRyRh/6qTxYqrlwn+us7ScOxl6Z8PBV0=
X-Google-Smtp-Source: AGHT+IF8rklRyGnUYKhfj50MBxNmQIPYRJOXQKJh1uS1k7OytvYVRvW6/rmqwq85VsTvPZV6ANkaPA==
X-Received: by 2002:a05:600c:4ec6:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-42acc8dd87amr15279815e9.19.1724418686980; 
 Fri, 23 Aug 2024 06:11:26 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e071sm60228325e9.4.2024.08.23.06.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:11:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 18:41:15 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RESEND v4 1/3] qtest: allow SPCR acpi table changes
Message-ID: <ZsiKc9TqxDp-GVCR@sunil-laptop>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <20240823113142.161727-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823113142.161727-2-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-wm1-x32b.google.com
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

On Fri, Aug 23, 2024 at 04:31:40AM -0700, Sia Jee Heng wrote:
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..aae973048a 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SPCR",

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

