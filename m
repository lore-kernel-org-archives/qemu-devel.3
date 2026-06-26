Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5A5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdFf1-0005hX-VT; Fri, 26 Jun 2026 19:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFew-0005gm-RY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:08:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFev-0004HW-Bd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:08:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c821a50615so6283805ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782515307; x=1783120107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WIZfLLhWYb9SQTpBX6BM5UEofWXV62lx1mbCdmlDWU=;
 b=oVVepT/RxKZT8V2WcQrt62nHHJ3m4bQBVjGJZjdHzMJbr8GhdnlwxWP73s+vEu4Goo
 Ci6csWzrHZ88fTAaJ0ntwr2YSd3Cy1DkIdvNlibHs1CFRtxGIUe7gDQXIf16ypHb/+d8
 gaOwa1NpqBG48tPIoUSUMsGts3E9oeGq1Cqzml+qhhqP//RoV99XGLk0d0GULp3XKzac
 um5JfWKJyrtubS5BqMPCBuElvBrAz5VTfnPU34iqsSGpgMkph6dos2RhV6+DF3Dv/9HU
 uY9AcB/Zb9k+r+mEuIvqRGddua/J8zgccHEK5pbTOJXTT8wnyRudNrfT/9QUH6Dqwt5B
 f2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782515307; x=1783120107;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WIZfLLhWYb9SQTpBX6BM5UEofWXV62lx1mbCdmlDWU=;
 b=rm4M5uCH4+ywg/QwC2o6NAeHvEm5Q022FikivyR5yTh+NXE8ogH368S3QbaID6ef5I
 d7IMlPK+92Eb+25513W37YnP+Dr5t8PLwj7E7Fwb9iVUZD0lmLvohLsFwYr50XfeG9y6
 O2mHBH1R7dpeTuHRxBSaYDdH6X3dOSPwcR9ZwEo9cNOMeCW6nEPi6z8HX+pKjf36OTIf
 YfXNWzC2HJ32ooH1jparjCjyBQetrWH1FoT3AvlM19vZH87CsTTyeSfV8jgEs6i45MHm
 p+rcgKPBXtRNzw6GVdFRtB9o2eLEK76z2Io6E7FAjWGuTwtMugBH/9mPKE4HjmAvH3Xi
 H1Mw==
X-Gm-Message-State: AOJu0YyAXs5N6TaMMEy5FgITazWwhqj4nRUxlqRKGnISz96SoE4Itr4f
 xt6moaXbG10dFhxqPCF5m7P1X4hKw6wNL6kUXS2pWmiM46KNPb/3hj9uIlwhj+H8Jpo0crYawht
 PLRL2
X-Gm-Gg: AfdE7ckDgg6MonHc0Im+rA4rgaNJk9ZHA5Gr4qs8I0i16559OTNmzrXtgI4EniNYL5p
 F8RSfGZgism67ieVpCxBb7uPUqbF06cOWKdUXtWaoMg/0dw+ZloK4pd8loljGxa8A/AN/70pSMg
 GGub9LABJ2H5lbynLQjt0bQuI3P8ths/JXMQyAmlTBKTz3QgpcRJmgM6MdceToYu2tmxZgUFhfp
 EjNg+UtFSFbQEIQXKJWDn+QW7ET8P5cv1yGuffWJZRnfV+b8lyDj5psMNQMlhljAjNc3B7wJxv2
 lG6F5Om67vadJwBm/CNDyaD/oTbGwpidAQUGGHaNbpwokJK5kbjTdG81idRRnBpjUaZKgQQuJTj
 qTQvYq8G9SS7TVSyHD5LO0FUEYptO5h91JVWz+onpOV6apF7/5/TVxrvzbWMgUi/T61GEzr21Us
 Zwtdgx86KOOsbFCoGkFGsILyOlCfLQJ3vWOL+/fKgaNX28hYMEoAMxCjh0SIgIyQLruqd5
X-Received: by 2002:a17:903:943:b0:2c0:cb0e:ac3a with SMTP id
 d9443c01a7336-2c7fca1576amr82105865ad.23.1782515306372; 
 Fri, 26 Jun 2026 16:08:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9a93d5ebdsm2410235ad.74.2026.06.26.16.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 16:08:26 -0700 (PDT)
Message-ID: <7dddc0cf-afc1-4afd-9fb4-6d3f2349a0ec@linaro.org>
Date: Fri, 26 Jun 2026 16:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] target/arm: Implement FMOP4 (non-widening) for
 float32
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-2-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260625223200.763198-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/25/26 15:31, Richard Henderson wrote:
> +++ b/target/arm/tcg/vec_internal.h
> @@ -547,4 +547,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
>       clear_tail(d, oprsz, simd_maxsz(desc));                                \
>   }
>   
> +/*
> + * Perform SME2p2 quarter-tile outer product.
> + * Iterate over ZAtile[] for esize, calling fn for each element.
> + */
> +void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,

Nit: FEAT_SME_MOP4 requires SME2.1 not 2.2.
Alternately, drop the version number entirely.


r~

