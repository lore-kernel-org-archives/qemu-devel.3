Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB2FD46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 21:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlD6q-0007BD-Rk; Wed, 28 Jan 2026 16:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlD6p-0007Ab-EI
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:29:55 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlD6n-00077W-SO
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:29:55 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so134191b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769635792; x=1770240592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3varBDN25JeGMEdxxEdLBSU6L/EZ1nbWl3EwKVjDH4=;
 b=xpNP+lEM6btR02wGT7dNztPY2qwAKhPIp8QZgOMpja09bOBgrnBz84Nhcuyx/5ppzt
 0GhArUGaKTOo0TlvM5rmMlBYpWVfPiqFlgNNTzhIhjEvCs1xiKdCvEp0PajfnyWqT6gK
 8JCjfXbwZIxbAkNTN6+L1EvhIXLn/H94qiand1+Pra2iDZfZAytxQCghay03rqMawA07
 5tvGapk7hGBSBj1ZhAMPbA8m/MX3I3XR4EA+i+ffH7hnITpdKOkPtitN+wR/N81sYS4S
 QTikaUNCGUuxkGXMiMzxUyINa1R/6O0A+LY5O3y4yZRW8T8w3gFTyB5WQ5gZRBc7oTwR
 b8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769635792; x=1770240592;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3varBDN25JeGMEdxxEdLBSU6L/EZ1nbWl3EwKVjDH4=;
 b=Py0a3q88Yo1Ozm/DRwK8WTCaz/XgGnXKvfWeK6Ug7mfu2pm7ycLaQysksW5zkErys4
 cEYto8pqVPd/MbOXVbEIBsNqn9B2CiDWq5MYV0NhSZXW/U5gTHNJcv/d1SNshUYHWGvn
 y5VN4c3zski2ebjhPFYSAfl61LzmkqHhun2TNIV4R1Lnz34YEpWCIcEjTnaayzFFuFp8
 SC8+pEzIU4YrnYxdHRShpnQvfmWEEB3a0rjcDQ4YBZYMaYJT/ybAsIUm0OEuVnUPlcQV
 Bn+PgTS/fmsqtNFos8XOW/uF3c5+G7iBg4lT2VSC6Ffs3wxWFuxkpt4R/fApPgF3X+Ep
 QLXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5rdUOEKsGTOd4YSQcFZhmpaTQuuL/in9EiWT8eDy5yyLBWCelslKBu7XH/ZkWVZ1v2aIE55QdcnMb@nongnu.org
X-Gm-Message-State: AOJu0Yzl4oCDVlj/NTTXuUaolB+ZYGbG1cdjIPhNKKhDhEkMx5MjPmID
 rePJxpB6pibhiNFpsLjCOSuZkgcJA8Ek7PZ/OaQL15F6fVyVWu6kkF/+Afy5vRjLDkw=
X-Gm-Gg: AZuq6aJRx7iHruQYvUPwEjBZjbrr7BnX00ixxpIVTsw/cLO1zg08OZpvQtUZI8lZN/t
 v0vmkh0f9spzIpQY5PHd6SkSqH2mjiZpW5V9IkiMkq3/jH/G3CIH2Vb7spI12Xawfd8U/pTVN5B
 4xMShk2e5o4ReJvskh3xl9IXo5fIDYHlpT7xM1VVSfrM3tIZUuO/asFTZC/Iiez1es804jonYgd
 60Gqj5206CeoAzhKEOE+20tWA2PW+K7XPw0Wbxv/MlgyyYIK+suczkroKXOOc0YoehKqdtTUZaI
 TCklLoQK5vhvgxTVvOTHjhV8HOJhB7Dw96IQqXEDhBaz8uV//yo0i6eGoAPgckwjaJsLBHtV2PM
 7aAoWB3V8ZxF2iLLVwI/dg6ptvG7synLtfSw3HsjGVppkHVAp8fHwZWoC2zJJx6b3XHsW/4046A
 LN9SaoNzVhCuHI3doeZsRuMQ+VDg4kHMi+qj+eXd+3CZgDjIoHg2xGjxF9
X-Received: by 2002:a05:6a00:3408:b0:81f:be3c:37e4 with SMTP id
 d2e1a72fcca58-8236917ebecmr6231393b3a.27.1769635791646; 
 Wed, 28 Jan 2026 13:29:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c54febsm4116335b3a.59.2026.01.28.13.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 13:29:51 -0800 (PST)
Message-ID: <c7e4e8e7-eaa7-44e3-a3df-4b426ee400d0@linaro.org>
Date: Wed, 28 Jan 2026 13:29:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260128152348.2095427-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/28/26 7:23 AM, Jim Shu wrote:
> To let io_prepare() function use the multiple members in
> CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
> member as the argument.
> 
> It is the preliminary patch of next commit.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

