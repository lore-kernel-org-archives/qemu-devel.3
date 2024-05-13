Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24BFC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 02:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Lon-0000lw-Ax; Sun, 12 May 2024 22:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Loj-0000ky-FM; Sun, 12 May 2024 22:53:33 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6Log-00061U-RT; Sun, 12 May 2024 22:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715568803; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=IvwrjlNqbEIbHVRrWk8yzGCUF91i/LnAbjGbjP9Zr2I=;
 b=XPMJt8QeaN7xqkdqXHKWq97I9WHM2EjDVPIQr57145nakf446YSzf9GkRDXDvi2tMvrR8XcerprDkbVtzapAfR8lkfDuUL9XiZvlU1LToDrWqezylFBdzllQceuENkmSn3O4lW9QL3243+kDtX8Uy2v7dCeGLhs0t5LwkNKJdvU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R241e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0W6H4u7X_1715568801; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6H4u7X_1715568801) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 10:53:22 +0800
Message-ID: <6192e64f-c254-4635-a41b-af1f56370221@linux.alibaba.com>
Date: Mon, 13 May 2024 10:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/riscv: Support the version for ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-3-fea.wang@sifive.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240510065856.2436870-3-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/10 14:58, Fea.Wang wrote:
> Add RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/cpu.c         | 6 +++++-
>   target/riscv/cpu.h         | 4 +++-
>   target/riscv/cpu_cfg.h     | 1 +
>   target/riscv/tcg/tcg-cpu.c | 4 ++++
>   4 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b6b48e5620..a6298c3298 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1773,7 +1773,9 @@ int priv_spec_from_str(const char *priv_spec_str)
>   {
>       int priv_version = -1;
>   
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> +        priv_version = PRIV_VERSION_1_13_0;
> +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
>           priv_version = PRIV_VERSION_1_12_0;
>       } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
>           priv_version = PRIV_VERSION_1_11_0;
> @@ -1793,6 +1795,8 @@ const char *priv_spec_to_str(int priv_version)
>           return PRIV_VER_1_11_0_STR;
>       case PRIV_VERSION_1_12_0:
>           return PRIV_VER_1_12_0_STR;
> +    case PRIV_VERSION_1_13_0:
> +        return PRIV_VER_1_13_0_STR;
>       default:
>           return NULL;
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7696102697..776939b56b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
>   #define PRIV_VER_1_10_0_STR "v1.10.0"
>   #define PRIV_VER_1_11_0_STR "v1.11.0"
>   #define PRIV_VER_1_12_0_STR "v1.12.0"
> +#define PRIV_VER_1_13_0_STR "v1.13.0"
>   enum {
>       PRIV_VERSION_1_10_0 = 0,
>       PRIV_VERSION_1_11_0,
>       PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_1_13_0,
>   
> -    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
>   };
>   
>   #define VEXT_VERSION_1_00_0 0x00010000
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..fb7eebde52 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>        * TCG always implement/can't be user disabled,
>        * based on spec version.
>        */
> +    bool has_priv_1_13;
>       bool has_priv_1_12;
>       bool has_priv_1_11;
>   
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index faa8de9b83..a9d188a9fd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -320,6 +320,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>           cpu->cfg.has_priv_1_12 = true;
>       }
>   
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
> +        cpu->cfg.has_priv_1_13 = true;
> +    }
> +
>       /* zic64b is 1.12 or later */
>       cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
>                             cpu->cfg.cbop_blocksize == 64 &&

