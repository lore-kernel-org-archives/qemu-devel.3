Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD99C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHU50-000607-9Q; Wed, 12 Jun 2024 15:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU4w-0005tO-4q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:56:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU4u-0002HM-Kf
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:56:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70436048c25so183324b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718222175; x=1718826975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7j4aJiYaenW5TseFWsiQZqieKrZydWs0ulUBvDuWEU=;
 b=TaXMx2KAbjXXYJqQZqzuavaGGH14ZWsmtX21TSC5Hydv0l9/5Sp6BKedpfk/NZzpuN
 WDApb70HNcYX4p5M9y0YtR39BsUpiFQGK3GxOHgWSgk9mXSsj8Jv384YPgr6w6Un1L+L
 N8HcgTvUAetI7LkoZDW/vwRtaQgpCzBbou+ZPsy75E72jrVy/NhHTN1BaCC/QZigg3ni
 SuRd3A54QKrscRbMLZSzmbIYqGmQPf5jE5cTG4+G2CFresc+qrtYkya5irC/W2kbEvoA
 WLTPoDFwppvLG94jlQBImGjUaRJdpzosD7GMIxALblty62WJRoflRxetsGeIYExGNRmP
 hqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718222175; x=1718826975;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7j4aJiYaenW5TseFWsiQZqieKrZydWs0ulUBvDuWEU=;
 b=gcahyQ/lYXZOBSk3gDIgYEkJs9ckXVqZObJhkgUIoukb9oppgmYRXqCabd5pP8wqK1
 WMN36A82NWyAjOscm/k/dWWSC68ohpDfbGfKDv94qDrPngCJwVvLfx8BMonSO1Jqg5LY
 667HQZuJpu+jl4O6GYMB3s/F/Q0KRCTa2n+w4RRNdOcCaPj+tJziOm9ePxXGnQhy8UhM
 l7AnM6AvH4s4R+D5pxAKyWeeBf/aESinSp+R3BkLdhqSYZ7yjG7UJg8L5sSecVSfgk84
 1lokm6881nFt4fpGoPBhtvLs3U9PUzMiTvtd2IPaDudhBPxKhL3+DbO6RZwuIqpkIzAL
 DnBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQi+oMst/6C3bor6SKP29ZU5dLTXof5X3Meirr5lwJVegM60eiq0RV0LUXIfviu+9/qE13fCaB8PcYahjSMDClQWKZcf0=
X-Gm-Message-State: AOJu0Yy90Il8XNZv+YT1MggcnqdEbRIZgz3rwBDhyNmCjczrMfJj/K9M
 cflFDo83qsfWY5j0JB0sZ1Iia9Dj+gzVGbz36N7AUb84RDoU8i1v2vLOQhZujzU=
X-Google-Smtp-Source: AGHT+IE/e7Ocy8xrrIAl/6QXzStgds4hfJNvk4pLF3i5jEGL7HgXrAP/QQNj6yAxEdrJqvdep4y/fg==
X-Received: by 2002:a05:6a21:6da7:b0:1b5:4c70:d688 with SMTP id
 adf61e73a8af0-1b8a9bff8f0mr3141681637.3.1718222174782; 
 Wed, 12 Jun 2024 12:56:14 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704229f26b7sm8088872b3a.116.2024.06.12.12.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 12:56:14 -0700 (PDT)
Message-ID: <c634ad67-7bfc-498d-b834-54c521301b9e@linaro.org>
Date: Wed, 12 Jun 2024 12:56:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg/plugin: Fix inject_mem_cb rw masking
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240605222531.28399-1-richard.henderson@linaro.org>
 <b9826606-3952-417b-8a08-f1db31a2cf7b@linaro.org>
In-Reply-To: <b9826606-3952-417b-8a08-f1db31a2cf7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/5/24 15:39, Pierrick Bouvier wrote:
> Thanks for catching this Richard.
> 
> I did the same mistake in plugins/core.c as well, could you fix it as
> well as part of this patch?
> 
> For complement, rw are enums,
> R is 0b01, W is 0b10, and RW is 0b11, thus it work as expected with &.
> 
> Thanks,
> Pierrick
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> On 6/5/24 15:25, Richard Henderson wrote:
>> These are not booleans, but masks.
>>
>> Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>    accel/tcg/plugin-gen.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
>> index cc1634e7a6..b6bae32b99 100644
>> --- a/accel/tcg/plugin-gen.c
>> +++ b/accel/tcg/plugin-gen.c
>> @@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
>>    {
>>        switch (cb->type) {
>>        case PLUGIN_CB_MEM_REGULAR:
>> -        if (rw && cb->regular.rw) {
>> +        if (rw & cb->regular.rw) {
>>                gen_mem_cb(&cb->regular, meminfo, addr);
>>            }
>>            break;
>>        case PLUGIN_CB_INLINE_ADD_U64:
>>        case PLUGIN_CB_INLINE_STORE_U64:
>> -        if (rw && cb->inline_insn.rw) {
>> +        if (rw & cb->inline_insn.rw) {
>>                inject_cb(cb);
>>            }
>>            break;

I sent a new series with your fix + other in plugins/core.c, so no 
action is needed from you.
(20240612195147.93121-1-pierrick.bouvier@linaro.org)

Thanks,
Pierrick

