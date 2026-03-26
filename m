Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A1109E53E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5adm-0007aA-Rf; Wed, 25 Mar 2026 22:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5adi-0007Zu-Jw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:40:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5adh-0008NG-0G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:40:06 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso234980a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774492799; x=1775097599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPUupSoInTblWIDl+s9YUqmGGv2qr+0VOrRoWptHI6Q=;
 b=HVS0pbYxgh4n2jKJc7K/DNb2F7+3SFytOWJ2ve9B04SU49K1vXemoTEH/ITGqAL27Y
 AicTx9PpK3UMfY+OOk0ddl07U1y8gqRnVMz/An90V7J983woN0aSDoSfYwUgpg5wL/Lq
 W6vV/lBAAz2m+XfuL/OLdLk3FGUQv9C/abSm53Ap4Fz8hFzd4aREe6scgPKG/+URIuFk
 +7idHjC7usyRVpKfXH/jTfIUhv7kOwx3fhNUBcxrisNqWD5w04r8X+SW9wKNqUIsjR0+
 3T+EGFFd2PTuQ1iJrRrhCOD7AmdoIFm+7RxZwDosCNfVMcEN8I1bDCoWHGTdnmsMta8s
 zeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774492799; x=1775097599;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPUupSoInTblWIDl+s9YUqmGGv2qr+0VOrRoWptHI6Q=;
 b=KjvXa/JGKu8jaSGtD+gqYWXAk7MM3UvbTt5S/XValxE832X9UczAV9yqC+n1TJzTu0
 TiOJFdHtTM5QaWTkuD5Gb53ikdGX5A24pGJE5bI8ME/yWDbU2aZVM7fD5Br8Lqwe/I7P
 D7NnbZOad9pCErbIrAgELUe9UyWb2CxAJ9gN9Ji2D86t4OKJZfW6BoRzOioxXG7/MHt3
 nfcfGB7uQ2ImbJ9/9ObB/bbUuawSWEMoRN6jZmQbfEPYHrtersaVgxPai7gispnoZaBe
 WC9PfjEksCKGIOLebkjQXaolAo8PfZBMoe5a+xM34CAVY9P+vDBfGl0QUVYmBAtPS3gF
 JTvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs9VZVcEfgxHmg/A7XPBTB6gO5NjSK1PGtRNPgUpkUeIrfxrEdT0sxmGJSodWyMZgwepqwdCOCL5A7@nongnu.org
X-Gm-Message-State: AOJu0Yw9+lI9LdRe+CEDPWzTR5KegSEGIV8vqhJZhq4A1SxhaudwbSrB
 dH2nxdfLDihTXXkfsYLtptxNA6pBtrycZ/MkQyKPYqWojdtDHryg7D7xeYxLHd8sWkQ=
X-Gm-Gg: ATEYQzycURB8eK04zOPh6pvz0XUGEfW6Ip46VZhg9QnfIHWBkHVx/E1cCADOfZTPWFr
 4Z9yPlRj2PZdiBLCreqyd2M4IJiM0o+25T1JzUAdrXDMiUMJFhY88e7tqlFGo+ClCJOAdIiuyVz
 nMCAyZ270PTd/yUQ3tffBSlZCnV0tyCDoxE2nCXok6qLaNF70eaH2Yf8seVGjKRINPr7urBcQ61
 tq4gp/qi4Umsjp7PNBsznTpn9pYlKB2+FiULlsAQ3T0/PPUZOWSDWdUw8a1kzNaF1NAsh4K54Vx
 vvVyg+keOpATApuxaeS9UwuGifOhNG+HiLgDEArERRD9EddEVxKOJyd+J+NxJK7nIDxSBFZxyht
 XB9D9ljkTWQMMzmvWF7mr5KC4fJrhUH36oh1G7GhWTE8kjIsD9XyFPd+nCHa6tBt+FVgiwyc/4j
 je/AJ4TcaPBblhU8VAi4nsbkSA4SQrmb9jGYpEgJNZPQ==
X-Received: by 2002:a17:90b:5350:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-35c0d100146mr5084680a91.3.1774492799247; 
 Wed, 25 Mar 2026 19:39:59 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c1dd38118sm688167a91.3.2026.03.25.19.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 19:39:58 -0700 (PDT)
Message-ID: <c85ef3e0-d3c8-401f-b425-95a42bac17ef@linaro.org>
Date: Thu, 26 Mar 2026 12:39:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] target/arm/emulate: add ISV=0 emulation library
 with load/store immediate
To: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org
References: <20260317174740.31674-1-lucaaamaral@gmail.com>
 <20260317174740.31674-2-lucaaamaral@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260317174740.31674-2-lucaaamaral@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/18/26 03:47, Lucas Amaral wrote:
> +/* Memory access wrappers */
> +
> +static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int size)
> +{
> +    if (((va & ~TARGET_PAGE_MASK) + size) > TARGET_PAGE_SIZE) {
> +        ctx->result = ARM_EMUL_ERR_MEM;
> +        return -1;
> +    }
> +    int ret = cpu_memory_rw_debug(ctx->cpu, va, buf, size, false);
> +    if (ret != 0) {
> +        ctx->result = ARM_EMUL_ERR_MEM;
> +    }
> +    return ret;
> +}

This is not implementing access for a debugger, but emulating an insn.
Thus *_debug is the wrong interface to use.

There is no direct interface for you to use here, because the ones we have at present will 
raise an exception and jump back to an emulation loop that doesn't exist here.  You'd need 
to translate the virtual address manually, recognize any exception raised, perform the 
access to the physical address, and recognize any hw exception raised.

> +/* Sign/zero extension helpers */
> +
> +static uint64_t sign_extend(uint64_t val, int from_bits)
> +{
> +    int shift = 64 - from_bits;
> +    return (int64_t)(val << shift) >> shift;
> +}

This is sextract64.

> +/* PRFM, DC cache maintenance -- treated as NOP */
> +static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
> +{
> +    (void)ctx;
> +    (void)a;
> +    return true;
> +}

You don't need the (void) expressions.


r~

