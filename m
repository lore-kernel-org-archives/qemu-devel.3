Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CFEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCCT-0005t9-SR; Fri, 12 Jul 2024 05:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSCCS-0005sc-FN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:04:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSCCQ-0008By-JA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:04:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so10785885e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720775057; x=1721379857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hk+O1Cw8Ggk9NOA3AKQGToRG8Lz/Zu+OpmWhpaGqlZQ=;
 b=Nyzn5W39+LGeE9hMf1Ax/yDiCz8sRIBI9yKMGugxdWYJD1Z9ggRH34MIdMnayAOI/2
 o9QjyXifSdNNaETe6oGeG0oadSGv1s3lOV1lrETTq3ITbPSlJM5nRQXUwWaIJYqyHNj1
 KGYoVYU49m9/kSZ2HEB6U1DpeXa8Vugyv4y/yoRsLcowO/8G14QnGurSIKAMpfSQ1NCu
 qmKxO+nEOwSTh4V0JJvQ4pMPnWLtDb1y4DOxlOgll3w7SrYXLpgRSUELWytXIHdC3C4I
 YxMjLtu2lW1ZCx7BXVvVQMIAV+F0VJ0x/5Kf2UT9uLc/BbUMeItDkusNRrx2qaLzN4Xz
 WV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775057; x=1721379857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk+O1Cw8Ggk9NOA3AKQGToRG8Lz/Zu+OpmWhpaGqlZQ=;
 b=ngF7GXfm0FIwzT7PV1wQ1zapV6KsUX+IOz3062S2pB7ELlsmTvljPbHxoLZ3DQQ3tX
 3y3ywLLfhvGBIXJVgxSBcIpFpmqoYNWIMCZdybzKb+ePp5wT3Yhk5o29QWFaBH/Ofsgy
 gtVxiUJDG8Ir6Z5JnhKK8KXxeOoBXNR4GIeG2TmEljrg+KxKj1qny9K47Y/IkpCyTOnw
 be+yCo3XC2kpi4uSdQ95WtG9tm/okcWQuS6A087UxtAWdpfpRIIHXJ3b32yzJav90tg8
 Nt0Brzmo3MoDXTk01Dko1AAo16HRUxUa/C8A5X3sNGesJcF3oZy0iJMwHUVVsgnY49Co
 nDdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCSdWxTxqadz08keJhmH+OyWUCpMyUZa0XuvYC20yhM050USBKfIJVw/FYdE671h8FWar2QE1j9Bi8pZXLdm31+i2L40=
X-Gm-Message-State: AOJu0Yy9SmfxHSYmZepJaLusPj5KAWanmtMfwMIqEwGMF5i660FFoIxU
 5HH1TQkwGWJYVPR+dnrLVLjU/0UvGF3nXKbEmOoJPkQpbJ953aXfquOBNiYSa8I=
X-Google-Smtp-Source: AGHT+IGm8n//O+By9t2cauZpEtBRVsg438wuWm5R7aOSD5PhaSdr+zjqoVeQyawtWBW2OvEiRRDrCw==
X-Received: by 2002:a05:600c:68b:b0:426:5fa7:b495 with SMTP id
 5b1f17b1804b1-4279daf4724mr18203395e9.15.1720775056834; 
 Fri, 12 Jul 2024 02:04:16 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89133sm9711305f8f.54.2024.07.12.02.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 02:04:16 -0700 (PDT)
Message-ID: <bf2bcaa2-47e8-4cfd-b08f-44ea9ef64a7a@linaro.org>
Date: Fri, 12 Jul 2024 11:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] loongarch-to-apply queue
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240711074829.3338879-1-gaosong@loongson.cn>
 <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
 <629d1223-087b-0ae6-81c7-cec885d11d77@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <629d1223-087b-0ae6-81c7-cec885d11d77@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 12/7/24 03:35, gaosong wrote:
> 在 2024/7/11 下午5:57, Philippe Mathieu-Daudé 写道:

>>> Xianglai Li (2):
>>>        hw/loongarch: Change the tpm support by default
>>>        hw/loongarch: Modify flash block size to 256K
>>
>> Please hold on before merging, I'd like to check with
>> the author for migration issue regarding the flash block size
>> change.
>>
> I'll drop this patch on v2, and push it next time.

Thanks!


