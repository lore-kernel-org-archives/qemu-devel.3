Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB5C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 00:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmNiq-0004g8-Ag; Mon, 18 Mar 2024 20:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmNio-0004fD-4A; Mon, 18 Mar 2024 20:52:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmNil-0001Ei-IH; Mon, 18 Mar 2024 20:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710809557; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=BMaHHbxrTCFCk4vOqtbSScP9fSZVwnAalOaMGv6IpIE=;
 b=sOBhumAjg/czSz7Kqcz5y84nbn2l4arsL3zPfohji6WChbIydpmTtvhqiso1FSRsWbG1/G6AsGek9hgVEiN7CCi9Vcm7LuhYePHDkQDtHB9CO+g22g9WPwl17L0oWPhNo50W0mezPpPP+6OHCV1hG48YNXpmi8324Ha9MX2y1F8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2qi2FK_1710809555; 
Received: from 30.198.0.148(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2qi2FK_1710809555) by smtp.aliyun-inc.com;
 Tue, 19 Mar 2024 08:52:36 +0800
Message-ID: <503b024f-1c7b-4eb4-991a-0cfb17cc448a@linux.alibaba.com>
Date: Tue, 19 Mar 2024 08:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 01/10] target/riscv/vector_helper.c: set
 vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, max.chou@sifive.com,
 richard.henderson@linaro.org
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240314175704.478276-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/3/15 1:56, Daniel Henrique Barboza wrote:
> The helper isn't setting env->vstart = 0 after its execution, as it is
> expected from every vector instruction that completes successfully.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/vector_helper.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index fe56c007d5..ca79571ae2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>           }                                                                 \
>           *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
>       }                                                                     \
> +    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
>       vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
>   }

