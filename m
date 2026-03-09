Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D08F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdCM-0003Js-8w; Mon, 09 Mar 2026 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdCK-0003He-12
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:11:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdCG-0002va-O0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:11:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-829a9c03780so2839606b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773072666; x=1773677466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kX/1yxRtsbALEMCdceiycv5xNUWnyfCojgu+7lZZ/gY=;
 b=b3AHga2WnKUiY119FDfR54nZalUQQYQGuec4G6/CxbmmUHyERHRShrhfOiwUqsLc6j
 UgwAVu0BB+ZQPdCjbtHmUX9QModsIR6rrQFRJULPXXzCB3nQX9OAP0N/VyQHSnJapbE8
 RJPqqy6W9VDlk2Q+r9WgnT5eLz8GLn2wVwput0Ge2rNp4iA9fLRouOPR9joOGnFmBd11
 3xJ89yQME065UEBjRMcHjVcQq239ELuzUW6vJLIeMUUF62TFiFH/y586mCyPTSfDPjyO
 aEi4Uy0R8ZK/b4ZtwIFU/Sh/B6ScX00Rh3VWfkEUYeKAwIUy6JDUIAbhZctZdKQMrqy5
 qFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072666; x=1773677466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kX/1yxRtsbALEMCdceiycv5xNUWnyfCojgu+7lZZ/gY=;
 b=cgrZAGfrFUGMFMfa/eoaN9h9EMIadVdS0rpUXEsjbOfnFtbUq0VWe1sXufDGoEi/oI
 806TGzSi6543H2EexircWHuMA4CHq2vnE6SiuhXnFgfJ5qZbZYjTAFbcpIhovr7oUvDn
 Vh/IuVPd2I0P2zYk8srlBKcI/YZ8sb+sOtl1/37iipu7VucyWym+mx0AUKxh2m19Jzla
 spLreh0j84ZAA4JgqO3QsGQnc5Rl6OqD4l+29N+5HLPZjdksx60GxGvP6noyirvXZdOo
 T3C19nvWYDML6AWC3QyyWd4f1LNzFIwOsCmtq4kD3OkC/Yf6MymOakwF5syenbC2K7vA
 RN0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8K8ZZGk6fHcNWXWX7A1QjHl/oiahUWOf1qsmDkKXKqR1QiYeQLXmSyVtdS66o5OHyh0kYI8RJ0tAX@nongnu.org
X-Gm-Message-State: AOJu0YzLYUF4jqJjQhL2HSXAkwFp9SWst8NFQG9q8s9HDOKORnYsUmOZ
 UVJIP6zqVM8cFe0qA97/+KFVT19mPP2R2hGZpcol+D4xMhrLI4v9oVHvee6u6JUGyKc=
X-Gm-Gg: ATEYQzzbsuK2Vg2Hlt7owtYMP2FTc1ahPk7uUPD/XXn8OYOsy4SmIi4IldEA9zzMB+W
 hgw0YsmM+zclYw79w5oZKgPlmy+5QZC/gPbKLKiPHJOoGUCrvhhoml/t94fNeN9sY10Yt5pcmyM
 ikvpWv+WJ4flIQF3MAe8IAFLlY86yM5PRw3GoDT/ir3pf3KoomMo6qgYSRNoq4qZxCNhoDWifkz
 xk3XPcKPiBdQ85fUi8QnnsLt2d04VnORdPDD3UJVNT1HVVPKtf9tHhiWTfMwCO/eYrrfyQvWvFI
 4YhLorFRcm18CTMdfyoeFIjI82zjEZllEqzj7aBlf4zIVa2IN2Kck6h/idrlcw4bguCuXt4DRJJ
 C06HydEjtxHMZkqVp+HUAc5PBgXx7LZsSgDlc7xyAiRlo1mUOxXCl0U0RgCooOBfcLp21z+5mEi
 q3Ak4G38zvRaM4DIdqMUX7mlNM39RAlq3FG8s7auQTpQ8c67RFK2xVPBVMJ8hb0UTZr3W8
X-Received: by 2002:a05:6a00:4c95:b0:823:b1f:893c with SMTP id
 d2e1a72fcca58-829a2f126f8mr9849102b3a.33.1773072665606; 
 Mon, 09 Mar 2026 09:11:05 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a465b702sm10687724b3a.20.2026.03.09.09.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:11:05 -0700 (PDT)
Message-ID: <7b555373-fc33-456d-a96d-a6ac46f5de5f@linaro.org>
Date: Mon, 9 Mar 2026 09:11:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Disable memlock test for asan
 builds
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20260309104545.1550888-1-peter.maydell@linaro.org>
 <5203acfa-7de3-411e-afe7-343dacbaa7f6@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <5203acfa-7de3-411e-afe7-343dacbaa7f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 3/9/26 4:39 AM, Thomas Huth wrote:
> On 09/03/2026 11.45, Peter Maydell wrote:
>> The address-sanitizer intercepts mlock() and makes it a no-op,
>> because it interacts badly with the sanitizer's own use of large
>> amounts of memory.  This means that our 'memlock' test will always
>> fail, because it checks via /proc for whether the QEMU process really
>> locked some pages.  Don't add the test when QEMU is built with asan.
>>
>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>    tests/functional/x86_64/meson.build | 9 ++++++++-
>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

