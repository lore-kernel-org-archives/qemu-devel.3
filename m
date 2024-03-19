Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA7BC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfV6-0007ud-Dl; Tue, 19 Mar 2024 15:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfV0-0007uJ-PG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:51:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfUz-0002Qf-8p
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:51:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1de0f92e649so39704845ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710877908; x=1711482708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFWn8xjzdB8RMGcs1dLr3d4PQyFulxs+SbFDMauYGAk=;
 b=zSdyh7S+yu0kSzNBL3yP0j0M+KoVxICk55YzdHMXnCSGAq1jao23ZY5tiUJCkl5dNP
 a9nyUscKiFPV9rvKAycVodTDrAiRMHmAgbz9PfRLnrGiU2xd4UjwPO+9FAtAN2Pt3EQy
 QgWzuCHbPVdgTjZlElyx2xoItWHkzGxKxPo4x6SHLwth5yf1l3CCdr82+Agomd6m38qI
 CmBnI91KUrxzcQu0mwkljokfdvrBVWJql0TIsdv8AE+M8R8pDsDiyLOCcIBENSjdleym
 6t4INuAj4sy3mVYtn7BL7F56MDunevUgAt8/geYl0l/glWBDs5Hkvpg9UKaEA+NQybzT
 n9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710877908; x=1711482708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFWn8xjzdB8RMGcs1dLr3d4PQyFulxs+SbFDMauYGAk=;
 b=sfuJre8FTnKyzN0Tx1miSBU29Ngu5ou+x+6p42jeIQMigjDYXIsg9weILBY6zP/5O+
 634P5xvf57PycM0CxdqebPZ5lZOTpcYb5qZewCbUsoqL5QNOhkn8kS384cy0EAjb8wax
 hqjW9UOzCfrJymqwY6WqiX3ZRWaX8XdmhjpuTM0+3JJdN0r21l2EVCw9EXwd4NrxcuHp
 szopjfg1wUqt85dKma736l0yoOzrciT0iONdbJ6eEMY3T7re0Ts6fMcWP1+EZ5roFwAg
 myP5FfdsqEIqFg/qsNXkRSRUXEH/b1MC2ead6/y+bdlR5LFHNjtyZLRNrLfFY+ShyI9b
 XcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc1+gW2Jn0knraCG23oullORJaIfUlTiRcEshJ6RA/7cUCaY4rYk11/n5Aq+26V6MN0hjk20FsrhiiitRo4FAU/ewLD2o=
X-Gm-Message-State: AOJu0Yy7IroML9SUI51XufLsWVOLgs29oxZthvBMCwuHc56wxnD45Nyd
 0XBvxf5m/PuW9L8BPrq0BcR2ZvFdi1qRZVUXuwGQ9xXJpkdPh4Lo1HnMIbw3yTQeQloZlG5bOYe
 Q
X-Google-Smtp-Source: AGHT+IF2Xj8ba3nTjDQj75j6m850823qxsBhTbLpQIFpzYQzPqc0LZxdj2hX/Z1PZ3SdQP4EWy2jhw==
X-Received: by 2002:a17:902:e5c5:b0:1de:ff9f:aee9 with SMTP id
 u5-20020a170902e5c500b001deff9faee9mr14478184plf.11.1710877907783; 
 Tue, 19 Mar 2024 12:51:47 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170902748100b001dd4d0082c8sm11843301pll.216.2024.03.19.12.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 12:51:47 -0700 (PDT)
Message-ID: <baa46f6d-52df-41fa-92f5-2767884746d1@linaro.org>
Date: Tue, 19 Mar 2024 09:51:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-7-richard.henderson@linaro.org>
 <9eec79a8-6ebd-4d41-af8f-459c1a83499f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9eec79a8-6ebd-4d41-af8f-459c1a83499f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/19/24 03:12, Pierrick Bouvier wrote:
> On 3/16/24 05:57, Richard Henderson wrote:
>> TCGHelperInfo includes the ABI for every function call.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/qemu/plugin.h |  1 +
>>   plugins/core.c        | 51 ++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index 143262dca8..793c44f1f2 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -92,6 +92,7 @@ struct qemu_plugin_dyn_cb {
>>       union {
>>           struct {
>>               union qemu_plugin_cb_sig f;
>> +            TCGHelperInfo *info;
>>           } regular;
>>           struct {
>>               qemu_plugin_u64 entry;
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 837c373690..b0a2e80874 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -338,12 +338,26 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>>                                      enum qemu_plugin_cb_flags flags,
>>                                      void *udata)
>>   {
>> -    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
>> +    static TCGHelperInfo info[3] = {
>> +        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
>> +        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
>> +        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
>> +        /*
>> +         * Match qemu_plugin_vcpu_udata_cb_t:
>> +         *   void (*)(uint32_t, void *)
>> +
> 
> Any chance we could have a static assert ensuring this?
> I know it's possible in C11, but I don't know if glib offers something for this.

I don't see how.  While you could ask questions about the pointer type 
qemu_plugin_vcpu_udata_cb_t, you can't ask questions about the function arguments.


r~

