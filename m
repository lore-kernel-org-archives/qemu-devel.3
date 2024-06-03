Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CEDC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6mU-0003eu-6S; Mon, 03 Jun 2024 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6mJ-0003dy-Ps
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:27:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6mH-00052J-PB
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:27:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42139c66027so9923225e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417624; x=1718022424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q7AbmcmkvcPKQ31udeuo69/LiFjoejdsygjCD7UbqKk=;
 b=H0ro8bhTpJi//vtWaja1fSKm3IddUQEpGFxkp7y23jmHunMe/E1h2GrDEU8TRTCXpK
 9vEwcnoFM6EydZs91cZ2zEOLXPcBjbsgdgtgYCVaMNk6xGsxqERjLR9d5nRU8dHhy900
 T2NLxwN3mQkCso8gJifO1DxBA13FX9MKFKNDcmccDPf8oihhc8kyX70ixsZn0Zw0p6QP
 C3R/hn2KXeZBGg7+9hF3zTWGMhTGfCc8237leCEl+fEUKgP/jKQgLxMoSffDpfxwdt+v
 s3WytUyVMfevNYfeITlRmjbwy2WpOmB4SpIb3bWbyeua7/GxU0OhKJBG/PC1piOmEJeg
 MuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417624; x=1718022424;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q7AbmcmkvcPKQ31udeuo69/LiFjoejdsygjCD7UbqKk=;
 b=eaK0pOeRTT5v9bvfLefsRwI56x7S+Q4t6Fgry4QaMdXUUXNC+66dcctR5bTBQaP0xm
 K6seFLLOfctBmSUoa5cEUzj+KPdJN6QdmG7TB6Xh88d0mkaI0Op/bPLnuLJDqotj0cpX
 LbYklVJUKTCoTTM3vAz2LAf9O2hMdIXS4rpWXMIWXCsyZGG+RFdgbq1rEBGblmnGS/Iz
 hqbxtQW7TaI5P52BTx4fqwNc1kawXBexjTMwvJwlGslYepSKcJ+ludyy1fvo2UsqU2Tg
 C9bXXoj9gpQGxDbKNxkZDZn4dIc/CqGNa1eP4FMZ5C65wkogwSlM7NSVrFNTcRaLfA5V
 SHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAAZrRDelKS0ctZYKZEbwN+ArGhRXcQmjs4EArNNMcO1oZn2IZF3rW+qpi29ntV6bsBXLFlehiwdQU75/SM9gKj2GtTEg=
X-Gm-Message-State: AOJu0YzOuba+k55Cn39wwHG7+EpV+2WIiTdipPRR6ZB6M+g9pwdV3O0P
 o6tI3u+dCGqN8keUT0Tyr524ljbHf3F+kJ6OfRoqKJ8oc8PgNzdvrYfmFb5bs0s=
X-Google-Smtp-Source: AGHT+IGxjm0KCbuzxzXjapB2vICDoJGM2u/cQ9PdhtOu3BDx6jm/qLzfs4VJyBWNei31XyLRcCeeHQ==
X-Received: by 2002:a05:600c:a43:b0:41b:147a:36dc with SMTP id
 5b1f17b1804b1-4212e049801mr63230225e9.15.1717417624055; 
 Mon, 03 Jun 2024 05:27:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42127069305sm146480025e9.22.2024.06.03.05.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:27:03 -0700 (PDT)
Message-ID: <dc9b8839-9799-4704-9b5b-51f901993da2@linaro.org>
Date: Mon, 3 Jun 2024 14:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/32] hw/sd: Add emmc_cmd_SEND_OP_CMD() handler
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-16-clg@kaod.org>
 <38b8ba4a-437b-4ab3-abab-25c7af203dfa@linaro.org>
Content-Language: en-US
In-Reply-To: <38b8ba4a-437b-4ab3-abab-25c7af203dfa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/6/24 14:25, Philippe Mathieu-Daudé wrote:
> On 3/7/23 15:24, Cédric Le Goater wrote:
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 409fbbcbd8d7..f846440b737a 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2171,10 +2171,17 @@ static const SDProto sd_proto_sd = {
>>       },
>>   };
>> +static sd_rsp_type_t emmc_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
> 
> "emmc_cmd_SEND_OP_COND" I suppose?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> +{
>> +    sd->state = sd_ready_state;
>> +    return sd_r3;
>> +}
>> +
>>   static const SDProto sd_proto_emmc = {
>>       .name = "eMMC",
>>       .cmd = {
>>           [0]         = sd_cmd_GO_IDLE_STATE,
>> +        [1]         = emmc_cmd_SEND_OP_CMD,
>>           [5]         = sd_cmd_illegal,
>>           [19]        = sd_cmd_SEND_TUNING_BLOCK,
>>           [23]        = sd_cmd_SET_BLOCK_COUNT,
> 


