Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724FDC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZgH-0007TB-IJ; Tue, 19 Mar 2024 09:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZgE-0007SG-Qo
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:39:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZgB-0002j2-1I
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:39:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-414633f7a52so8583725e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710855537; x=1711460337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p10IT2dEiJDNmetNsX1HEPbxwuymKt0UA3QUZ2RMpmE=;
 b=pMSX+BS2ZVj+Dhlyc91ef7fxYWv0b91urMwWJpwp/zBrrR3ZUE7dtaxlCGdDoWmEZq
 9wfo6+Mq5omAWP6zYAWF9ODyczGj4Q9idrJsw1mhau+7DWg82EWSGFASes1lOqAtIht/
 mm0Nxy9TA3SwBfKY79RoGlJ20mvhu6X7KDktuWJjE6GUo+xJZd6aHnAL4fXGY+J6a1BC
 CbmC6+Fw59Ph5OAwJ2/ZPy5AjFc+B3C9HVEDKc9SNDkjtheH4bTxd1V1ZTMf64y9OI0v
 v4V4BSXgCHC3MJQ6W5oTRrbflatOCkvoQbidzwCTPEtVTTZPUGNEkBiyXVyaO/lwCAGH
 D65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710855537; x=1711460337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p10IT2dEiJDNmetNsX1HEPbxwuymKt0UA3QUZ2RMpmE=;
 b=rqm2bresZy8Eq7XZelkiGB/vYhlTVNeyk0NJPg6OxvNgDgVzvaXfLuFHqmbI6apeMu
 NiBr3IaRCRtuDFOq9hZ4v/gEFPQuCqpiPuyDRD4sKs1yYl7dmq5yUSmuOsECqZiqvvOC
 gU4Xfqp7ZhmylFM27Cgom9dq3IGvJvvogp+1Lhv0AYaf3Vb7SvAcrOWOnerr/3iaFR1o
 nagl2zBDo+Gypd5aj0z00c6+6sMrPNWq8jq7G77pTtIqqKBH0pvtnhTmh0ntsncA6Ygl
 d4WJ3KyM6TGJg0txyI7nFbWVB9SAJzW0psnrP4SbfB72sjv5tX8dpJbEREp5bhcK3nEG
 QNWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5vROB8mJKRy5NEN2rlk+NyYLx79ES29xYBw88EKDH0ZIJlxAot9212TpIUWcpvyk/9PJGelGbnOxaEV6JXIiDTZLu4qM=
X-Gm-Message-State: AOJu0YzianZkz+vvVBqLMYB0Dm7uRCBMym4VXPAiCr6wsFOAaFA/MJ3d
 K+Fw7VmS78Ih5US55JC72VElGMZTW+4RFUbxN+bvyPzYh9su6zp2qWS0yCG9C9U=
X-Google-Smtp-Source: AGHT+IFoT573erizKNN3z3mN2uwbyuyFW4AhrhgBYH4oZACij2VDWwr+nI6aL8S7W5/souAcoTnQ5w==
X-Received: by 2002:a05:600c:a0b:b0:414:21b:9a92 with SMTP id
 z11-20020a05600c0a0b00b00414021b9a92mr8736708wmp.8.1710855537400; 
 Tue, 19 Mar 2024 06:38:57 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c45c900b00412e3717ae6sm21850169wmo.36.2024.03.19.06.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:38:57 -0700 (PDT)
Message-ID: <4ce855b4-3b8f-4888-adea-21f0ca47e1f5@linaro.org>
Date: Tue, 19 Mar 2024 17:38:53 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] plugins: Rewrite plugin code generation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/16/24 05:56, Richard Henderson wrote:
> As I mooted with Pierrick earlier this week:
> 
> (1) Add a (trivial) mechanism for emitting code into
> the middle of the opcode sequence: tcg_ctx->emit_before_op.
> 
> (2) Rip out all of the "empty" generation and "copy"
> to modify those sequences.  Replace with regular code
> generation once we know what values to place.
> 
> There's probably still more cleanup that could be done:
> 
> There seems to be a lot of artificial separation between
> plugins and the rest of the code base, even between
> plugins/api.c and plugins/core.c.
> 
> I suspect that all of plugins could be moved into the
> build-once buckets.
> 
> 
> r~
> 
> 
> Richard Henderson (22):
>    tcg: Add TCGContext.emit_before_op
>    tcg: Make tcg/helper-info.h self-contained
>    tcg: Pass function pointer to tcg_gen_call*
>    plugins: Zero new qemu_plugin_dyn_cb entries
>    plugins: Move function pointer in qemu_plugin_dyn_cb
>    plugins: Create TCGHelperInfo for all out-of-line callbacks
>    plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
>    plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
>    plugins: Add PLUGIN_GEN_AFTER_TB
>    plugins: Use emit_before_op for PLUGIN_GEN_FROM_INSN
>    plugins: Use emit_before_op for PLUGIN_GEN_FROM_MEM
>    plugins: Remove plugin helpers
>    tcg: Remove TCG_CALL_PLUGIN
>    tcg: Remove INDEX_op_plugin_cb_{start,end}
>    plugins: Simplify callback queues
>    plugins: Introduce PLUGIN_CB_MEM_REGULAR
>    plugins: Replace pr_ops with a proper debug dump flag
>    plugins: Split out common cb expanders
>    plugins: Merge qemu_plugin_tb_insn_get to plugin-gen.c
>    plugins: Move qemu_plugin_insn_cleanup_fn to tcg.c
>    plugins: Inline plugin_gen_empty_callback
>    plugins: Update the documentation block for plugin-gen.c
> 
>   accel/tcg/plugin-helpers.h         |    5 -
>   include/exec/helper-gen-common.h   |    4 -
>   include/exec/helper-proto-common.h |    4 -
>   include/exec/plugin-gen.h          |    4 -
>   include/qemu/log.h                 |    1 +
>   include/qemu/plugin.h              |   79 +--
>   include/tcg/helper-info.h          |    3 +
>   include/tcg/tcg-op-common.h        |    4 +-
>   include/tcg/tcg-opc.h              |    4 +-
>   include/tcg/tcg.h                  |   27 +-
>   include/exec/helper-gen.h.inc      |   24 +-
>   accel/tcg/plugin-gen.c             | 1008 +++++++---------------------
>   plugins/api.c                      |   26 +-
>   plugins/core.c                     |   61 +-
>   tcg/tcg-op-ldst.c                  |    6 +-
>   tcg/tcg-op.c                       |    8 +-
>   tcg/tcg.c                          |  104 ++-
>   util/log.c                         |    4 +
>   18 files changed, 424 insertions(+), 952 deletions(-)
>   delete mode 100644 accel/tcg/plugin-helpers.h
> 

Really great series. Not only the final code is much simpler, but it's 
faster as well (from the few tests I ran).

