Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D4D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgiBn-0002hv-Fl; Fri, 16 Jan 2026 06:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vgiBl-0002gG-7c
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:40:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vgiBj-0001Ql-Mh
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:40:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so18667685e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768563622; x=1769168422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zBZCtMMSHGdzGkjLwfCIBNs4Zt6uPYpF65Piti3Q6Gc=;
 b=xWu9YdkFcOpmBKSiJmf0UqLZv9OPkDU943MJAo0CsAP9mlaFb/zYVSoe0Vm7p9sIIT
 2WkFkTkyLFqQd6FyzXFxonImXhvD+utKGhVEMNemj5SpUIlN/TkCRmL+TSy9HTTlgtXm
 GhHtaTN8EudZ1taKlPWah5b8dUvonAuJmdt57vLSu7xGgEtCFC3WTJ3kn3gPNflrIHv8
 /aqAIkalheYN3Ew4uI8x5xJZUZDqRuvYJzYSbqXXnv8dmAzK34Xfu38752FhAxLVPBH3
 x/NWjtrUGYnw4EsiUCjbUXlsm10N98iFQIjGwkq6Yax/FoEfOrUprahuWP3BHEAbKA+z
 F8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768563622; x=1769168422;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBZCtMMSHGdzGkjLwfCIBNs4Zt6uPYpF65Piti3Q6Gc=;
 b=TRc9IdWLaLX06pQvkRq4Kb8ZKou/TYghXJmqcsGmK9aJO+bYhCulMvG2m21girc3hD
 bAwPV/Q44wlmzIRBLfLI1ArJ9ymA8sImCExANKSOe3JIj+BovPFAksLgKidbG8pISJIz
 n0InZ6FPVnbcodoMEuRTWPiXn8hkEMfKnMNhYIcXe9wwKZoecgmCLdFRiqKZrdvG5Q+t
 iBRDdrpX5MqUie58K18aQGXdMEolXe8oXUStycjRSYaQuKz70F62H2NC0y1GE+3Pfe2h
 cLvs4O/5cWDu4TWRS58+ybG/BfrdJB8uJJKkNN+Rp6YzWLZFI19bj2ewAO9dNV9pRbFO
 9P9A==
X-Gm-Message-State: AOJu0Yzddj/ZAZbQKKvF23hFrMdAW7IXQ0Oj3iujwYrYDEMULoFnKFXK
 fNzYc7jlbBdnpau5tLXjz+/inI214FGYSlYBlkLgKCMvA32b+CvLxooqdeKZ3mG0DTW5x+AVEn/
 WM7j+
X-Gm-Gg: AY/fxX52Fq0vHxX2dv05MIMv7Q1N19zowS5RGiEX1PogsVRTAmF5P6xZwhVFipdMATP
 njWBJEQOAS/TBb5l3gTWdtH4HynqRYhVjbOW6l/WZz27L5sIjWiAsaIxe4HU3egngaasH9aGQB9
 ty4jrZ6iUy9oGcKKpmtGRH07uwXr9ji918dBCCX+l78x7H2JJzPBUEg+ZfLUs8YBfQJGN//SMdX
 sciLK9Xchy1nHfJLwQrn/zgFu3zJqqyVH3xOjR48FSLMlh8XhlDBVvR5s70Vw0rNPTsv7jdlb/+
 CmI8uNIrSKApbyvy0oGAvoa53DH2zxXtzaEKj+OUkQVeYeN+qCVlrESuVmsQxF7VQzfrCFeP8eh
 jSVNthpyQ+0u95YwFmJpU0V9KjP7Urb3aijY5aNDk8K0eRbfwj3wtBAPYdv8cxmRUzHeIGWpRks
 WsVo6lPLgSIecRfksj03ToH/maf6E09n3WlcLZMw/5XfwJBGglY6yARITF
X-Received: by 2002:a05:600c:3d8b:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-4801e30b205mr26870845e9.9.1768563622082; 
 Fri, 16 Jan 2026 03:40:22 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:bf4d:6c0b:c4a1:ca58?
 ([2a10:d582:31e:0:bf4d:6c0b:c4a1:ca58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921f6esm4845958f8f.4.2026.01.16.03.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 03:40:21 -0800 (PST)
Message-ID: <9b052ee4-1700-456b-96c6-7ae2af900d40@linaro.org>
Date: Fri, 16 Jan 2026 11:40:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: possibly convert deposit_z to shl+shr
To: qemu-devel@nongnu.org
References: <20260115135453.140870-1-pbonzini@redhat.com>
 <20260115135453.140870-3-pbonzini@redhat.com>
Content-Language: en-US
Cc: pbonzini@redhat.com
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260115135453.140870-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32d.google.com
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

On 1/15/26 13:54, Paolo Bonzini wrote:
>   
> @@ -2628,8 +2638,18 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
>               tcg_gen_extract_i64(ret, ret, 0, ofs + len);
>               return;
>           }
> -        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
> -        tcg_gen_shli_i64(ret, ret, ofs);
> +        /*
> +         * Use TCG_TARGET_extract_valid to check for 8-, 16- and 32-bit extension
> +         * opcodes, which tcg_gen_andi_i64 can produce.
> +         */
> +        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len) ||
> +	    tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, (1ull << len) - 1)) {
> +            tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
> +            tcg_gen_shli_i64(ret, ret, ofs);
> +        } else {
> +            tcg_gen_shli_i64(ret, arg, 64 - len);
> +            tcg_gen_shri_i64(ret, ret, 64 - len - ofs);
> +        }
>       }
>   }
>   

Also just a couple of coding standards issues - "Use 
TCG_TARGET_extract_valid" comment is over 80 characters and you have a 
tab at the start of the call to tcp_op_imm_match. Otherwise, looks good.

Jim


