Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8DAC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJqr-0000S0-SI; Tue, 23 Jul 2024 14:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWJqj-0000NI-3C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:03:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWJqd-000052-RR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:02:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso42703435e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721757770; x=1722362570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KU7KQGW3OuMSTClUN1NVXHxnAT8lo13heKpJy62Rrgk=;
 b=KKadmDrdZAr0O+EXxfJEDNEXZVakkvp1FfxTNzyKvwTMtGhlzz+L0gvFxvzznzzSYr
 tXZeVhjQTPBIwNfamspiips/U3E/nu2h6YMDfF6JfGGlnmkIAuXBhhO62LzmkbUW6N/z
 ZrMeld0ARh/VWl7lRCqcD3Xuku3m/X+VBKgOVueuNpWsunpNrhGtBlyl+YMCsWh9wflU
 9Kqg5tQ3ze5GdfybQRt4iF9hsUDVb4u/Zu8iKDXTP8g7y6+Feiv2KwpBb3fAuUqPcDMj
 noun3iokiUj96oj9wBZVNNzSW7Ib9g6v0V1iXeD3XoWS73ID0eZsvblkbpvKSh77EnJm
 f2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721757770; x=1722362570;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KU7KQGW3OuMSTClUN1NVXHxnAT8lo13heKpJy62Rrgk=;
 b=uOAjNcFwju58fByfA5gCyv4940I2MMAkNWX44iFOFxfxUhzhjeE9fvjm0+kkFb5kBP
 LInUjn9b7nt7juHAiOJMfucl2+wWoUpW5rcVePu05pY3RVD+TvoACGQDbr8aBpkzQydu
 w0H4IqCaH5AAORhBr7qVtbx0DPZ8+A+kPE+/veSkj7/ZyGitair+XoFUJN7jd19heXZT
 jgNTD3i4rdvKqYSL2NSdJrYC04Sy/U3SjHVJldhCj6QHwFYrs3DgtBdOkR9xy5lH4bQE
 tlBE+p3lxyTR9Lq5YAWCNOfWnhVdyQAwGjeNc2Q8UUK5typV5H4lyv2Lemu6tbVIaNSV
 X+7g==
X-Gm-Message-State: AOJu0YwRpc4uFHFeOq+w2jgPaDFi6yWn0sqLZp3p5w+DZ6nAwEQBngf+
 S55JJPbuntTP7Rm2ptPrReU7EaqqyLNZZUNK0SCSrYFyw2pSpnMDXioeLohcJvlLv4NRolqebPU
 xIcM=
X-Google-Smtp-Source: AGHT+IGjPRbNR6It4eNPwxvaJkD9k2rK+i2B9HRkLLOCVITUp+ZJgGg/VaZ0hjAXeLA+R8/hFy4Dlg==
X-Received: by 2002:a05:600c:1ca2:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-427f7a151cdmr2250995e9.2.1721757770237; 
 Tue, 23 Jul 2024 11:02:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm184118385e9.6.2024.07.23.11.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 11:02:49 -0700 (PDT)
Message-ID: <4cceedd7-6ee8-4ebf-b027-9894a1b9b270@linaro.org>
Date: Tue, 23 Jul 2024 20:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of machine core
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org
References: <20240722164412.1163414-1-zhao1.liu@intel.com>
 <a194f976-aff7-4aea-989e-0aff693d6dbd@linaro.org>
Content-Language: en-US
In-Reply-To: <a194f976-aff7-4aea-989e-0aff693d6dbd@linaro.org>
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

On 22/7/24 18:43, Philippe Mathieu-Daudé wrote:
> On 22/7/24 18:44, Zhao Liu wrote:
>> While working on a series of CPU/cache topology work, I became
>> interested in the machine core component and would like to help to
>> review more related patches.
> 
> Thanks!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
Now queued!

