Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BBEC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfal-0001mI-Hx; Tue, 19 Mar 2024 15:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfai-0001lp-W9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:57:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfag-00037f-S1
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:57:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dff837d674so27198855ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710878261; x=1711483061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DrF0Hi+4fGNFB1tZ191Iyd8pAROhM69lDy8Rj41/7NM=;
 b=ssH1P4tCtEWh0TJ3A/bPJ9ZK10i21kNhYDyTu6xguz9P9PUWa8gi/vhwxWmltg1J+c
 XDNsQ2HGsK21rvPz761nsGMrcerK8gzAHvaJ1HK+Ah95Wuar5seq6ws3AbguJIzv0hO+
 pFPwTy12nduYbrSQOOHCJnJXQfD5RBWfAKy8Z/ttHQ8i7vmOO/pfU6qjlf/p1felJa4w
 BJmUxQAsP6KriWhOaMZFBItAGoQY/F2ys960tBh9ThPp/Y0GuLSISuzDbtaem7BC2feT
 dZ5uhAqZ4rDBOlrlU0A/GIJP+Rh8lQya7em5UP3Dt0hYD/2orc6T1wdvsGHvZLIoKphM
 WD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710878261; x=1711483061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrF0Hi+4fGNFB1tZ191Iyd8pAROhM69lDy8Rj41/7NM=;
 b=MQs9JEgtdVT0AtvhxmXTn+ZfPThN7/SOT4YvNlWEM+E6n6gbELsJyRyUHNGzi6O3/b
 RdOG3QZ2GqnYJVlvvrE7lcPAvTVMHyxKzzmaAb3up0ZjGmjf0c9uVilrCG1NvexqJBVm
 2/qpWzglvcJL2DGjFe/FqsxDZvmxfoynRqbCQxmK2DGtCsWPxt2ZTn/9E4+DEfUHas+d
 /x3D3IA8JNauC/cOLYiX+8e8BAuyBFQmR5hyMrmoJz7oE+43swP2zTlltt+cxY1HWLhe
 1Xqia6TGeLtAdXMixVbanCDtOv95SnKdCkdNKcVh3fh03WKIdrZVnpUYFxKrpSf95A7P
 hFWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX27AX1Xt9P8nSsZDXXWc0p6rOPq/vHnf+TLGasiwunjzzPilp3kYf6vgpig1az1yyhdT0ZAFEk4lRR1P9O4pSsIGknGC0=
X-Gm-Message-State: AOJu0Yzu3JpDGY7vktJ7AzAbPJ8JGuXSyIf5gVA+16rOu8yHNOJNOcZR
 4Dl7sv1QcZHKhr2jC2LjllBJy/17y01tam8vNi0WM9R6k/TeX9fRM3Vjmpp0tWnzC0NBGf70f92
 f
X-Google-Smtp-Source: AGHT+IHI159PJr1XaQQXKB+hbTxvygB6Bk7aO4SADkHsREPlicRTm4FYLGgbytrDMUUtTrc9m/j0Xg==
X-Received: by 2002:a17:903:1108:b0:1de:f95a:2677 with SMTP id
 n8-20020a170903110800b001def95a2677mr221838plh.52.1710878261428; 
 Tue, 19 Mar 2024 12:57:41 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 j14-20020a170903024e00b001dd66e6ec91sm11816048plh.140.2024.03.19.12.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 12:57:40 -0700 (PDT)
Message-ID: <565ccdaa-f90b-4d69-bbfa-8563cf7b5ac9@linaro.org>
Date: Tue, 19 Mar 2024 09:57:37 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-9-richard.henderson@linaro.org>
 <199426d0-deea-4bfc-b2cd-8150fc5f21d2@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <199426d0-deea-4bfc-b2cd-8150fc5f21d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/19/24 03:22, Pierrick Bouvier wrote:
>> @@ -798,6 +816,25 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>>                   assert(insn != NULL);
>>                   gen_disable_mem_helper(plugin_tb, insn);
>>                   break;
>> +
>> +            case PLUGIN_GEN_FROM_TB:
>> +                assert(insn == NULL);
>> +
>> +                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
>> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>> +                    struct qemu_plugin_dyn_cb *cb =
>> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
>> +                    gen_udata_cb(cb);
>> +                }
>> +
>> +                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
>> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>> +                    struct qemu_plugin_dyn_cb *cb =
>> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
>> +                    gen_inline_cb(cb);
>> +                }
>> +                break;
>> +
> 
> Maybe I am missing something, but couldn't we simply mix all cbs possible. This way, the 
> order mentioned by user when registering is the only one that matters, and he can select 
> to mix callbacks and inline ops freely.
> Just checking the type of callback would be needed to know which gen_* fn should be used.

See patch 15.  :-)


r~

