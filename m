Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED710F3DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 12:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6SXs-0000ho-MS; Sat, 28 Mar 2026 08:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6SXr-0000cg-1r
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:13:39 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6SXp-0002Ck-DA
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 08:13:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so1092667a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774700016; x=1775304816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T1k0kNDwLozXkQgR+VPDw6QsH44Bqp5tmbMfg9N9nGc=;
 b=OmVqplPYT91bqa0bUfuktBMYP4AcfxQGUbB9do9fUXqaVH6p2RmBD2eZdN50jtRzzV
 8CvSy6K7gyH67yFi7hcCNV25v/KqKWobv5wZ0IsP5NwxJ1KAHXXDf5LOsdbHybbPc/Y0
 tpAHMz3rB5mKbf0U7zGqHSdqlTmvHfGhauOJWp4AinGxi1mJ5hd8Vyp2B3j+xmABbFX5
 LsCiIotMeHSsJ9YWE3czfqhNx8TXHXbFdpKgZlJhYeeOeCLj2WBWLxNTnuxGaQpaXH4k
 UMD7Q8MsHMKqgAmpMfLinUXau9e/PKsvgBXyVcgYxpBDSwMM3FKISEmcSO2jINDirCy8
 nn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774700016; x=1775304816;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1k0kNDwLozXkQgR+VPDw6QsH44Bqp5tmbMfg9N9nGc=;
 b=h+vhFhZ0dc53dp6SKPId9s2GE+fo269DHEZdiofjg+QC7L2wrVuU/qXK9ku9ONQnRM
 eVNutF1XvGjBC2SwQUDi4qqd7cnZ2Jt8E+51EBOvob3g+TTcnWMJoKdDhvZLN+QqORmr
 acTU08kE3CVHhkq6yubCivAV8aa791lAerHdV9+GReqYTm6gkM2/ZHZB0c90c7wgg247
 LB2DLKbnZJY5X6HHWrMyl+/uKPehe0sS5t2yfEOwfORn65b6xbfkcSvwFZEg991umsSq
 Xlw9b7IpybqHJdcw4tfkacnhjm7rWHSTNxmWzlKlvhY7AVWSKv060MqnacZcYXSfjZp4
 +m+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo737gL8rkrmGqwVbC3sefmfrmMYpoiH1827/aChlpKj3sMedpk6l8bX6O9JQBlhMXzjT0oaA6K+dV@nongnu.org
X-Gm-Message-State: AOJu0Ywh9iWjPWUAHyv3E2L0CjoUG3dL1bfkkANEeGeAtqzImFLQWR/d
 C1KZPYwT/ueYqCWiKzzHH4hBQ0lARI23P7RkTwF213Shb2mvA2zzIta+SmZQSQQoK6A=
X-Gm-Gg: ATEYQzwSf2X3vHOFCZloEUciHA1efL8IBlj7IJQAqHzhr8SpWIKn6gHUjzG3skzDqWv
 2cFcKX3rKQE5a1cpn6Dz1yhvGYumG1bEbxeJinI2NsAAyc0nruvW3LQGOMwKr9KRVT6Tsh5yDk7
 W668BDohblmEarcCpD2lMjqWdYzmfPgY88aTmFLFwqQx47xmunI4/CmPbiKdPUnn9by1q3DMIDc
 4P15YIpzU4rDvO+g1sFLTG/8nYsiJPobk0RcIdJRoqLUHqVWX6J1vFVlR8AkbtziSrntCW0qQOG
 SWA02ClbosUkfuNiF4H4jyy+u9DXWN5yjj4rxVupbyccBKyaf+Sc+f6cj6AM8Hv6ozhRqhuHhbT
 iFi357ACg44B24SdD3pqG4xvFfvse76RF4Wh3RfrXpPyhq5N3IoJbpTgE5bVJZ9IzC0nHSVwEOC
 81c5m1GXVOq0g/QnGlPcGkUR5qV5ezINFemxRKmSDq2j8JR4TFvFVbxv48z+bkZXbaqQ5a
X-Received: by 2002:a05:6a20:3d8e:b0:39c:2433:10df with SMTP id
 adf61e73a8af0-39c878b5aadmr6372928637.19.1774700015737; 
 Sat, 28 Mar 2026 05:13:35 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916ba75esm1674568a12.6.2026.03.28.05.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Mar 2026 05:13:34 -0700 (PDT)
Message-ID: <5a308cdd-0e0f-4670-9c02-ab367845db83@linaro.org>
Date: Sat, 28 Mar 2026 05:13:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] plugins: fix endianness for
 qemu_plugin_mem_get_value()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
 <63ca897c-9547-4ed9-b1a0-7a8d69aca7ca@tls.msk.ru>
 <334d78ed-51b3-43e3-add5-bc807a1e1f60@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <334d78ed-51b3-43e3-add5-bc807a1e1f60@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 3/27/26 11:24 PM, Michael Tokarev wrote:
> On 28.03.2026 09:22, Michael Tokarev wrote:
> 
>> Should this series be picked up for qemu-stable (10.2.x)?
>> (I'm not picking it up currently).
>

Yes :)

> Ah, n/m - it's already marked for-stable.
> 
> Thank you for remembering about stable!
> /mjt


