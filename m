Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D59CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVeM-0006lK-Vn; Mon, 11 May 2026 14:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVe9-0006kU-HK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:46:30 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVe6-0001eC-Od
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:46:29 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dca00c1591so1581393a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778525185; x=1779129985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MsRtXsr2acqXGr/nj5ascymdXoHkUn8mmAufmXxiU5A=;
 b=O6wIVIgXq02JDqmzfpKbC9zI9/NmOPBvQT9c/0+4yiWcqjHdRJbnHGYGRUDfIEHPtG
 1iK6JygBzS3XsP6PD9x1x/lsf2aamDE3RVolNbJ+NkdxadNqiQpHsHCwAL3w8jwBd4OK
 pjyTsKGqRdZrMPzNgzGRLSOwu1IKMQ1Fuzlp9vi3M/kiOhONQc1cbgTnhbibVOwJ43G/
 Jk1lBhI0ttu9fZ5vA67k1Xlu0I+FKOzeEedwrWycy1bqQ+hIIKsM+NiEhqlIoljK3Bk3
 lxOEvzAccXzo6SmI31momso/I4koKzI+YQb0gKPSSK3LEfLMkHo/qU7wysdD/rPFybec
 lR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778525185; x=1779129985;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MsRtXsr2acqXGr/nj5ascymdXoHkUn8mmAufmXxiU5A=;
 b=ahUzlZeuXwPAW0eaqkIOu/cryYPnEdgDlGVWAaqIOdVwTG9rqPSy2Pxmwc7xiWiA00
 9bBGmQ5reZxu+u3CfkME6m76QmWDXMfj/w5TSEyXow0egHYsvyARDPNrebpCijA8Q6t8
 Jb1Jtr/JWbon9rIH+M1O4ChPE+pWLyE2SpsCynn/hpOo4K+okDhtA/2yW0ksg4DZqBB3
 oRryaM831mQR3jbhBJYSvAolyjFJQDxk3ByEGgHx1tGAHNhjZEIgUiaTfj5qnxLtXE30
 jsP808cbyT5ZEzfM3o0oZQ3CT4ZI3JJiZ34W8koadMwdhUhKQTRdEDgh4N01Ba6EWcGE
 dPjg==
X-Gm-Message-State: AOJu0YwZe/5gVb8ZBjSGcfH5wy8MVq4GVL6d2l5/4yJYelw4rQRszXyO
 AqW2qdLW9uRQGAk/6kQ7NE9JYOO2dAnm5Cu+8+ID7NNqkeV1NeMiduEKWe/q1IjR5A76vSEMqRC
 JYC6l
X-Gm-Gg: Acq92OGIPhD22I0TxgTxgsXowd6mc2CqRQ4eGA2kfoK6xs6c3Hd5AyJZ1qWZfnotlV+
 l+fACAVl+vyVW7NZX7qI5dulV3ifRUNRRxuZxHZgVnSgz1h6Bc2BAIRxxf7U/zeMsZaAWP0M/oU
 eoYfLKuzxdroat80AYsTxQMluVyMAdmpvY/+/EXn1IA9jZ88SL9KLYJI8/LEHvBO/jKFdHNPDK9
 qQsi/Hwv3EGdv6BA1NICgaWhoLX+Yz2nzoAtl9o5P4+RIDMXRihbEy8S4HpsOKXzzboiXUyHGq/
 N+77RoFCMvlJkJpjeGIFeU3tdO4Mggjtv1Ng0c3d7tK6s9UpmzGfoAR2QjBP5PAaKD8dmsoYN+x
 Jp4/4pKp4DAPidRlQST3agwWZwRUDg2StFXPW2Kp+kU1u0PfgpzOt0VV/JNJCtmIQjIdKpBAgsh
 UFxCN/Q8HDHXqvhJrsiK/tAKz1en+2a0Gq2ib+YmigW55lRI05Ac51FR2fUtfxi6n/MM+C39uuD
 kEOBBdsSk54sZrp3XRH
X-Received: by 2002:a05:6830:82d3:b0:7d7:faef:fa0 with SMTP id
 46e09a7af769-7e1dee30c64mr15133536a34.3.1778525184931; 
 Mon, 11 May 2026 11:46:24 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367df2fc5sm7386445a34.25.2026.05.11.11.46.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:46:24 -0700 (PDT)
Message-ID: <0071f563-ba94-4c9a-ba4a-7999a0881084@linaro.org>
Date: Mon, 11 May 2026 13:46:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/35] target/mips: add Octeon MTP0 instruction
To: qemu-devel@nongnu.org
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-16-5062889c4d3c@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-16-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 5/11/26 13:22, James Hilliard wrote:
> +static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    /*
> +     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
> +     * from rt.  Legacy one-source forms encode rt as $zero.
> +     */
> +    gen_load_gpr(value, a->rs);
> +    octeon_store_p(index, value);
> +    gen_load_gpr(value, a->rt);
> +    octeon_store_p(index + 3, value);
> +    if (index == 0) {
> +        /*
> +         * The hardware description and register-state table define P1 as zero;
> +         * model P2/P4/P5 as zero for deterministic emulation.
> +         */
> +        TCGv_i64 zero = tcg_constant_i64(0);
> +
> +        octeon_store_p(1, zero);
> +        octeon_store_p(2, zero);
> +        octeon_store_p(4, zero);
> +        octeon_store_p(5, zero);

Likewise, where does this come from?

The octeon2 manual for MTP* are quite simple, writing to just the one register.


r~

