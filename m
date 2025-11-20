Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57405CF884C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3fj-0005cB-Jx; Thu, 20 Nov 2025 07:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3fh-0005bj-K0
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:21:57 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3fe-0000Nm-CN
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:21:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c7634863a7so227300a34.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763641313; x=1764246113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gko722ZjvT5CvrOtyL+ov5rxK6NCsvJ7x0/i88tP9Q=;
 b=eS0Xm8aigjEceBisaPAZWYqb4XQd8d856XA2mWFklRo+2kwLzTaGRTtsZU+Pva/Zq/
 42QdD9MNjLdwXm4KzDprGbr063Uz5Vya9lpjkLOSjz1xsse0ElY5uV5rFya5LWTATocq
 J2PxTyPbkpm1jbwGShO5xVVKdsTyXZOIp1TJy7QytvXujqLy2haQz98p1oMYSoUkgr2C
 z6wfgFS3xUXC8DnJZenW3FlwIPoE0mhd8DtP7KHQHs8ontjFvvBV5qrGOYsdLvOiGtp6
 gt7Lud2IE+Y34AJ1hmSa+tYJmQzvio8B2xLfwQTkuh2dnaQT+njUw7m1G7LNN+jY1SNQ
 29dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763641313; x=1764246113;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gko722ZjvT5CvrOtyL+ov5rxK6NCsvJ7x0/i88tP9Q=;
 b=VsKQC385HSi6aAp6jV9rbhRBr+DfuhrehPdPESvbPqr9Fvxq4QJFkI1mOg8N6ouHtZ
 oW17PyeH2wh8Smd06wtXe0HMYJmBMIJ4kykH7F4Cqnq3v77Y5lUeMD6vEsIIvhgCVD0a
 prQ9iWmKkNKZ0GVkORkM/l2Mu8xhSWAHJjzshMXfwuzeBMsI18928WAkwpG2WmKkE6yC
 IbUUphhztaQz/dgqcDvI8mgtJkP+Ps8uUnBAqHZyTd7d+Bn/KSxUY9bwK3i805nKe+JH
 +bW+yFdq1jqxx5/94SAVI0/jTiX+cNoWRYXPtvd0q3hqWwNf+cEr1m1YTNU5vGMzNHaj
 fPjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjmGzKGvJzAqe82nwAtvZ9tGJ4mn7hVeFWftm5A9Nmf6vQQMnaqRK/j8eSyzvpWPw62GC6ZqtJ4l/@nongnu.org
X-Gm-Message-State: AOJu0Yy4feoMEi9cXgl3b3e6A6Aoq+u3fZq1HpKZOHHYnmFCB+Uf13NC
 rM8a4YOiPAtyNT9ef4b5LjVjp0cnxHZQ+yZbC4fsh9m7gTKrAezWto2Ms/weM6znEmE=
X-Gm-Gg: ASbGncv0TOCISJOht1b8UC2k/sDGu54M/I3tCikAGA95pjusCXg8ZIF+gicpL3EkovA
 DqKYMkebEUubCg4SobCnxZ4iQw83w1UCw3To7rc5UNhaVX4yJ0vAywETb7fAl07G3r40THHd6Jd
 riDjX24BfF/tsDP4SR0V1CFamwHHpdaxWRvu6EmjiBbF+fq4Xcst4wJTK/7A9W8mWUxRw4qq8RA
 hpt5Eff19sgbBvlEb2pMcFwLDl6jc7Ga8shpUag1IslI8ijJFG9qxwHl4qmwbudq1OU2R38kSe2
 OnutJomsoHVGpfgppwURyPI1ilC8LlhDXK7uq60D6zNK5EUCMexlaQcEiMQwyL8iT653SeTpCh/
 jGa1HWP8LZfmpNDd3eV0CehxGZHnWgC0zqsz4RRWqiSc6GMwS3xfUjATebrQ3bijtBdrVg2g25t
 gnxmX4WyhaDuH2PKDLk+ExeWnbcJw=
X-Google-Smtp-Source: AGHT+IG6B3xEX7cauIS3zxOIe78TPKEP6GmtQS98k8nskvoUphKkytREbyQHScCTtFQuhp2Q8HImKw==
X-Received: by 2002:a05:6830:440e:b0:7c6:8c73:aafb with SMTP id
 46e09a7af769-7c78d306650mr1575519a34.35.1763641312978; 
 Thu, 20 Nov 2025 04:21:52 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d3ff21fsm907108a34.20.2025.11.20.04.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 04:21:51 -0800 (PST)
Message-ID: <7d8e2ed4-3adf-4db6-aebd-7d6b9f695e48@ventanamicro.com>
Date: Thu, 20 Nov 2025 09:21:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/riscv: add support for RV64 THEAD C910 CPU
To: TravisYang <zhiyuan.plct@isrc.iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20251119112724.1342110-1-zhiyuan.plct@isrc.iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119112724.1342110-1-zhiyuan.plct@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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



On 11/19/25 8:27 AM, TravisYang wrote:
> From: 杨智源 <zhiyuan.plct@isrc.iscas.ac.cn>
> 
> Add a CPU entry for the RV64 THEAD C910 CPU which supports single-core
> and dual-core configurations.More details can be found at
> https://www.xrvm.cn/product/xuantie/C910?spm=a2d5.28054257.0.0.4a0f7a32qXoU1w
> 
> Signed-off-by: TravisYang <zhiyuan.plct@isrc.iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 47 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..1fc8140190 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -56,6 +56,7 @@
>   #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
>   #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
> +#define TYPE_RISCV_CPU_THEAD_C910       RISCV_CPU_TYPE_NAME("thead-c910")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ae8b721e55..f522bc856b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3281,6 +3281,53 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.max_satp_mode = VM_1_10_SV48,
>       ),
>   
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C910, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .misa_ext = RVG | RVC | RVS | RVU,
> +        .priv_spec = PRIV_VERSION_1_12_0,
> +
> +        .cfg.ext_zcf = true,
> +        .cfg.ext_zcd = true,
> +        .cfg.ext_zfa = true,
> +        .cfg.ext_zfh = true,
> +        .cfg.ext_zfhmin = true,
> +
> +        .cfg.mmu = true,
> +        .cfg.ext_xtheadba = true,
> +        .cfg.ext_xtheadbb = true,
> +        .cfg.ext_xtheadbs = true,
> +        .cfg.ext_xtheadcmo = true,
> +        .cfg.ext_xtheadcondmov = true,
> +        .cfg.ext_xtheadfmemidx = true,
> +        .cfg.ext_xtheadmac = true,
> +        .cfg.ext_xtheadmemidx = true,
> +        .cfg.ext_xtheadmempair = true,
> +        .cfg.ext_xtheadsync = true,
> +        .cfg.pmp = true,
> +
> +        .cfg.ext_svinval = true,
> +        .cfg.ext_svadu = true,
> +        .cfg.ext_zicbom = true,
> +        .cfg.ext_zicboz = true,
> +
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.ext_zbc = true,
> +        .cfg.ext_zbs = true,
> +
> +        .cfg.ext_zknd = true,
> +        .cfg.ext_zkne = true,
> +        .cfg.ext_zknh = true,
> +
> +        .cfg.mvendorid = THEAD_VENDOR_ID,
> +
> +        .cfg.max_satp_mode = VM_1_10_SV39,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs = th_csr_list,
> +#endif
> +    ),
> +
> +
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV57,


