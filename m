Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE30FF4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeIZ-00059x-92; Mon, 09 Mar 2026 13:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeHh-0004ap-Vo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:20:50 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeHe-0006Vi-Cq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:20:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-358ed696623so4954406a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076845; x=1773681645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDtI8B4BXa4IrZHwA4N+PDicZHttowlBxqy6GOozqNE=;
 b=KOie64QAy012WcRvMuSKNhFlVFibzSfwkPqpaem/fN8joExQe7zDyK3LYff6Nd08D0
 eVZQZk+IPBQ6efUkpwXWwKqZ3GrValwhu4fYYbfHvfUlQqbcW+kcR1Pa8V7HCzpl5vfo
 Tsp++yt3ahHyne/fLtxwmY3stALQn4ol+bKcySsUTTIyWuGc5xpaRwTQI+MLFKuValCn
 vfnQyo/c+16IPTg2U0Uzx2xrqyplN1SATveUTlJI1D2QSBl4N4ZoTebS3YVgMK/rlqJl
 FXGGoosYKWuwWhKTv0zc83Z7MmupQ/A4ocE96A8/S/rMTtl8AD2h54fzPiLpCOlgzjI4
 SGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076845; x=1773681645;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDtI8B4BXa4IrZHwA4N+PDicZHttowlBxqy6GOozqNE=;
 b=HIhAu1s1XmDH5qr9LZCdY9q5psgU9/+EXvb9g6kLlaHiZckYHL7F6zuFlsNkYIIpXs
 /krDstIKBasKU6VQgTTNLCTDJhJCHNJeoES1cxtsKF5KUsbc59Czlx7ua85j/d7D955V
 YpAbf6LybIw0YnTb1vUkTReF+r0bg/IpyN2w9yFK/xW988CRwNyV/DTcAztAu2xKGpt6
 BXf0chx0QslBzBCeHMo0o2/3O1b+ncyT54iZrptcseVgQDjsKLsNOyDnK8VHjyV4zSNI
 0UfiLW7idAAIORbWV68LmBmZZXK5U2B4WE9A0RtMx+ez/AvSwJP+tgF0o6igRrF6kjo6
 iiHg==
X-Gm-Message-State: AOJu0YzXQl6X1bAJZx02/xQkC/KxEyek8Et9+C7xnGXH7fumCgJqTAZB
 vIjhQvyY1re11ZlAiQPTu0FhFS4HkcfQ5pxG8Nramj/Z6ub9vp3CUzNkae5LmSbgw9I=
X-Gm-Gg: ATEYQzwudwy0V8RB8546/Q/G1r0GQKRt7joSTWKsScIAGpiFAWLxlapdT1KzDHBO9Xr
 tBblcw22IFxxkBG5INRasYZBT+N5zBAS1VM2DoYbWRHfJLm2Txo7d6hDChmH62l7ZTYVzcji7lg
 XmQco6YWg6j0BB8q6sjcHAuaEIOZCi543PPVKo/cmEKTmxfovo2ZY69ZeFB+sIqCm+QPr7X0Bpy
 d5D6KCX19j6jlaQ29PLb4aJ8iVHy0+AvvnClKxnP53txIIXf90E3H1wgFzGqSdXW9Y4qu7cJmI3
 fK7cn5davJ+ME5LuCen+f7jvR4ZNoK5/myrcry5a989Tp0krcLovAKAuxsR7bgqY7JdLKSRJpWt
 FM6PcWu4DaerM9xmwQNo4S5Fq3bN923YoWJWfzivRkLhYu79TE5XwmuP2EidK+45i3lmJ9I1g6I
 Mu6yk0jdd1JztEKrNcjUmVf7DBPKrS4e9/aJMSk6YaRQrhMRSQQ5TgqRaJPrwInTxgUz1rI/Tox
 Ro5DNQ=
X-Received: by 2002:a17:902:ce83:b0:2ae:4e2b:f565 with SMTP id
 d9443c01a7336-2ae823062f1mr119515925ad.0.1773076844749; 
 Mon, 09 Mar 2026 10:20:44 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f759fdsm163952165ad.57.2026.03.09.10.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:20:44 -0700 (PDT)
Message-ID: <64ff115b-83d4-489f-a826-dfc6028a37d0@linaro.org>
Date: Mon, 9 Mar 2026 10:20:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
 <CAFEAcA_WAnfxtCgfhX4oGa7eJhvs9aWgsU46CGGzgqNfBX28Dg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_WAnfxtCgfhX4oGa7eJhvs9aWgsU46CGGzgqNfBX28Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/9/26 9:35 AM, Peter Maydell wrote:
> On Mon, 9 Mar 2026 at 16:22, Florian Hofhammer
> <florian.hofhammer@epfl.ch> wrote:
>>
>> This patch adds docstrings for typedefs and function declarations in
>> include/plugins/qemu-plugin.h that were previously missing. This
>> resolves inconsistencies in the docs, e.g., the description for
>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
>> but code cache flush callbacks not being documented themselves.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> 
> I don't know this API either, so a couple of questions below
> for those who do:
> 
>> +/**
>> + * enum qemu_plugin_mem_rw - type of memory access
>> + *
>> + * @QEMU_PLUGIN_MEM_R: memory read access only
>> + * @QEMU_PLUGIN_MEM_W: memory write access only
>> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
>> + */
>>   enum qemu_plugin_mem_rw {
>>       QEMU_PLUGIN_MEM_R = 1,
>>       QEMU_PLUGIN_MEM_W,
>>       QEMU_PLUGIN_MEM_RW,
>>   };
> 
> This define sets up the values such that you can use
> the _R and _W values as bit checks (i.e. _RW == _R | _W).
> Is that intentional and can code using the API rely on it,
> or must it strictly check against _R and _RW separately?
>

It's intentional, but if people explicitely check both, there is nothing 
wrong with it.


