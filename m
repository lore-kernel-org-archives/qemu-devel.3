Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969C7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM89r-0004zb-O0; Tue, 25 Jun 2024 11:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM89q-0004yt-Mi
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:32:34 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM89p-0003HH-54
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:32:34 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cdf579dd2so3151619e87.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719329551; x=1719934351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5w2hZHPjsYS9W0LbTQroH61N3EurTUr73WCxji6PEkU=;
 b=Yo39ixLGLgv22V67/+I5/vRzEal5iNy0LsEIkUCgrrRW/UZX8AmlLdcpZfJtIhww63
 e9mb7hixBkITgvVYQ86SKSXwGk3omslYGtMuyk8kpd7IOiQOHomVCY6UwghsbXdl/ckv
 M60TZF2NCOI9pxsADMo4tJEl6ftNjDb4lpbLeZBliu4AFau1sqmd1pASSqqvpcYUKNgQ
 DPC1hf1rxXzaTIBV1ZqAqlMRb/iiNNk9vva6kOJzYKIzQxp0r/73aRfmDaBYMNc748LE
 nWgIA3mQrin5DoyYTBx8UpUjliY0frLYh/xefLM3nqevJkNmj0SKpenGzzZmJPoTFaRS
 dvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719329551; x=1719934351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5w2hZHPjsYS9W0LbTQroH61N3EurTUr73WCxji6PEkU=;
 b=vLuXA0MwSt2D1EOnLyhRIZ0Tn0jUr9rBg+NKsK4nq0il+sE7sgTmcoYsY9lz+mwBXV
 p+kX3oiw05emizzTZY56LhcT6Au5BICdRaR9Tmzw2eBVoAIvet0jWtMp21bYGjNXybFs
 eXOmnnfmmjhUHoFKfqN9oS16/RNr/p5wOjBje6DxHrE4l8Jlbr+AZ5x6WMqNDnCybuB2
 jCPBqtJ5qqJg+vq3J95zNmePAZvSPnO5DfM4bAp2Yq4WC1fUx7LoTXp2QMPvXkHo64ss
 qgJUvsHEYsnaO2PT49f5I5QhsZakPYoMXsFJMZPIF6+CxyhXLPoZafbB66KrelhfIKND
 mKgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEINdu48yeUlJ4gxH1Canslnsw9g/vgLgxZwUwPJCWHL3sBE/H5Iv1BQwbzTO8cDeDZ+dZtk7N7PQE+u47JNoi4Qx6l/s=
X-Gm-Message-State: AOJu0YzJqns9rWMv4nLzRHSLgpTilDVZHdHchx0rULrm+uo5slMkyACW
 X+GXGJY8fJSl1noq8jXi5PwkjSZhWGz8PzB92Hu7PK2L0EZGP3LAFtx6trj/z1vnHwQ7isYcr1K
 v
X-Google-Smtp-Source: AGHT+IHOMOSI9qdjWniyZihikEo9xYcNE7FxX8VpLqqB9dEe3Vh0OrQCBxCGex+UxzPoKNI0z84Ifg==
X-Received: by 2002:ac2:46e3:0:b0:52c:8fba:e2a1 with SMTP id
 2adb3069b0e04-52cdf7f1657mr5469430e87.18.1719329550691; 
 Tue, 25 Jun 2024 08:32:30 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366f466979dsm5526946f8f.7.2024.06.25.08.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 08:32:30 -0700 (PDT)
Message-ID: <d2cb478d-d12e-4684-91d2-3e0d0d8265c5@linaro.org>
Date: Tue, 25 Jun 2024 17:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/32] hw/sd: Add emmc_cmd_APP_CMD() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-19-clg@kaod.org>
 <1dd454c4-d7cd-4e8f-a824-e7743360b853@linaro.org>
 <4c336e09-910c-4452-becf-54f10718017f@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4c336e09-910c-4452-becf-54f10718017f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 25/6/24 17:13, Cédric Le Goater wrote:
> On 6/25/24 5:04 PM, Philippe Mathieu-Daudé wrote:
>> Hi Cédric,
>>
>> On 3/7/23 15:24, Cédric Le Goater wrote:
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/sd/sd.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 5ff132139ea9..95cb46b87519 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -2207,6 +2207,11 @@ static sd_rsp_type_t 
>>> emmc_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>>>       return sd_r2_i;
>>>   }
>>> +static sd_rsp_type_t emmc_cmd_APP_CMD(SDState *sd, SDRequest req)
>>> +{
>>> +    return sd_r0;
>>
>> Why are you returning R0? This is invalid, only R1 can be
>> returned by APP_CMD.
> 
> Probably a typo. This is old ... 4/5 years at least.

Well, a smart typo, because it hides unimplemented features
(and probably some bugs). Maybe someone clever used R0 on
purpose :)

> Thanks,
> 
> C.




