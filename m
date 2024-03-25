Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CEBC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohNN-0006Pu-Vk; Mon, 25 Mar 2024 06:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rohNK-00065m-0A
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:16:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rohND-00051G-QS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:16:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4148bc73069so1612095e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711361768; x=1711966568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EdLilOB2BheJAUJyVHlW4eP38wPt2isAu7kNsji37T8=;
 b=k0wHUjdzg6lLIRyasdltzbIWZ6yuy2MjAohDvuIZXjdv/GIdyTTx6b97yJMEfYlqDO
 uFAi9q0WMSpxwpuFpy4r20z7KZbaYfhxNzunOBKuxrvsjnxyPKakkRya34E3ihoWI4Yq
 XY/88cWMBL85bm3CWqE9Qn6Shf/BImG6JzQtZroaObsscg6cAjIxY6a+8UL/BjYNn/Y1
 KEKwIQvyf26gJMfize6vdlXymmzf3EIPhY8ggjjiWbtVA8bXUKO6QySQAKm5W0Nf2IR9
 RMqldT1SVyUSot+WlfI8nhN3FzivZIiQ334LRew+im6Fa8xkpNtRcvr6AOpSR/Dteimm
 J7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361768; x=1711966568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EdLilOB2BheJAUJyVHlW4eP38wPt2isAu7kNsji37T8=;
 b=petBusY4N96pl9UNvE2WlCgOv+aeurP0xfGTwUWcnltlH85ggmkZX2THoE5DZ1TY/c
 EtEiltRi+G6Lo+8pMWuAFZA1ud6HcEa55Iuy1Q3aOA4D7WpU83DBYkIqxFyjcscDCFAp
 wlcooBgM6/ZlKusDPatLqnpnNcfBa5D0fSGx3cMoy/nQweQAPSDoHwc10Z27oomv2zJV
 HQA0PZIOPC9lPCpcCuBVqViY2aN1AnrKr5KoF/edng8Hr8O9pWQQS7Mr337eiVxncDyg
 Q7oF/xaZsbGlogu2HGAp393xOTqyy5IiEunEqdC+QF1M6CI4Eeb9xBaUHBbgEzcvO/dm
 VcPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmZryrkF8oD0xqp8LTfgskB17mFY7u0y9hnfDLPjXAraLvTbnJBr7NW6sih6bW9c6Bl7R68/bwm14SKPoNm7YPaaFrrxA=
X-Gm-Message-State: AOJu0YyHpR2NF9sEhI0L0q6KCdtIH9g6hK+fsWozbg0vlxnzFFgZeKlM
 9fmjRu/WLa6CnEATdczlKFqTCfm0r52JM2/djxTsDVM9zfF1w4bueJmlTbWvCo0=
X-Google-Smtp-Source: AGHT+IG4NNmx2jEwV4/Fb5TmrGwsfZ/84a9kkYmYQY/vnSktxrGBCJaFH5jYrdO8WRTB5nZGThjpAg==
X-Received: by 2002:a05:6000:1863:b0:341:c9a8:7cb1 with SMTP id
 d3-20020a056000186300b00341c9a87cb1mr4348122wri.29.1711361768162; 
 Mon, 25 Mar 2024 03:16:08 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 r25-20020adfa159000000b00341b69e9162sm8509741wrr.90.2024.03.25.03.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:16:07 -0700 (PDT)
Message-ID: <3e202821-7f78-4b4c-9b16-ee47c51e2a62@linaro.org>
Date: Mon, 25 Mar 2024 14:16:03 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins/execlog: Fix compiler warning
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240325060657.3934-1-yaoxt.fnst@fujitsu.com>
 <3afbc002-1077-4bcd-a4e2-582b0c7de88c@linaro.org>
 <CAFEAcA8AhymqyzF5aPWMKA_R64tFHbyJuQhpPbAuoabHdh0e=A@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8AhymqyzF5aPWMKA_R64tFHbyJuQhpPbAuoabHdh0e=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/25/24 13:58, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 06:41, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/25/24 10:06, Yao Xingtao wrote:
>>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>>> index a1dfd59ab7..09654910ee 100644
>>> --- a/contrib/plugins/execlog.c
>>> +++ b/contrib/plugins/execlog.c
>>> @@ -327,8 +327,13 @@ static GPtrArray *registers_init(int vcpu_index)
>>>                for (int p = 0; p < rmatches->len; p++) {
>>>                    g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
>>>                    g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
>>> +#if GLIB_CHECK_VERSION(2, 70, 0)
>>> +                if (g_pattern_spec_match_string(pat, rd->name) ||
>>> +                    g_pattern_spec_match_string(pat, rd_lower)) {
>>> +#else
>>>                    if (g_pattern_match_string(pat, rd->name) ||
>>>                        g_pattern_match_string(pat, rd_lower)) {
>>> +#endif
>>>                        Register *reg = init_vcpu_register(rd);
>>>                        g_ptr_array_add(registers, reg);
>>>
>>
>> As suggested by Peter on previous version, you can declare a new
>> function `g_pattern_match_string_qemu` in include/glib-compat.h which
>> abstract this.
> 
> We should have an abstraction function, but it should *not*
> be in glib-compat.h, but local to this plugin's .c file. This is
> because the plugins are deliberately standalone binaries which do not
> rely on any of QEMU's include files or build process (you'll
> see they don't use osdep.h, for example).
> 

Sorry, I misunderstood that, as it was discussed with Alex that maybe 
plugins should be able to access glib-compat.h.

> thanks
> -- PMM

