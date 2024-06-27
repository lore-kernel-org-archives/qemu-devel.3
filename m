Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46115C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsn4-0005NS-TR; Thu, 27 Jun 2024 13:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsmw-0005JY-8I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:20:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsmq-0003n9-Ts
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:19:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so36669215e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508794; x=1720113594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIeJQMBIbFdmpl+1EUgY4RQm7DCZxSl6Njw9Cejf0zQ=;
 b=lbYgA8emK8wff66zO/KRBwIjj95p5EoaGqXFArqTSDo4zCODIAOwC1VODuTX/nhRa6
 eSrGOHij8ITDWXFjReNT3vcncmAN+yFNRYZIY2CVZY+sNbECDEcSPE6zxNcEGZVmRvLL
 f8aZRuN3JjvG7bOI+KtkRPDEZ0nqrLIFYXHPoSSOWhFDGuDjKAGgH/DY3CnfBh9rtspS
 kvJ4iHLRHbxu0vqb2gh82Jcq0Dh9covkPuAMZ+v9wjOk7NwMDxrhcGdDxbIeWHz89TpR
 PMAi4yeWS3QTG1n95/BUoEm82HQQ1hNmYh2PjW3e0AWt4ue3GgXESjwxt30iheATD+2h
 QTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508794; x=1720113594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIeJQMBIbFdmpl+1EUgY4RQm7DCZxSl6Njw9Cejf0zQ=;
 b=KxNM3STCVCsb1bxIjylkC9ENfZYnFboW0uc5N2G/wxuHDrcjiameshIEzNCQCmdMvz
 hnzJA2fIsABKZgKFhnCCLPZ34/QdcaBV8PnewGzDMaHlo2X/AGfWzxefGQHGyF5y6G3X
 fzgxo0Vv9UgYNUe9L53JdbVxNyyTnUMN+2S9Eu1sppa/ILD/bPr/mJR4NRNsEXR21sEj
 /Fjv/Kdcc4nQF+iVl9ph+u3nSd8HIOnLhC3Rf5V5RCd8AQ0lr1ivZ9pJCs8LrF4afH3U
 Ff3bpjofo9JYt/oGfqCqUmJ9BQe2FeESl04tZkvLFfthH2sfCzWEcucFMjE827SO6/8Y
 4STg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ngRNvKncfQ9ANaC2djxiu1NKAj4NfwC4QZAOUEar6ymUjce7/tvIHBCxvZrdEeq4uNACM5lAG9sDs9B2hK/B8PgEogc=
X-Gm-Message-State: AOJu0YzwtrWAZM/4t0g6FtJbxhOJtvf4Q0m6kn1xrl+s5acjg8V1eAtt
 +w91T1hPqi8ThPRtq1A1xuFDCN3ItATDUQXlDYcKhOhPU8WfRZQZRMgVCy3jfSA=
X-Google-Smtp-Source: AGHT+IERyr4Y8d2vBI27vgoiryllOt77OSwg71Q76OyH8ns0P/OyeXkw/tEQJVsDChV+u9NQ08iQ4g==
X-Received: by 2002:a05:600c:4baa:b0:424:a66a:ed46 with SMTP id
 5b1f17b1804b1-424a66af0ddmr57783515e9.33.1719508794286; 
 Thu, 27 Jun 2024 10:19:54 -0700 (PDT)
Received: from [192.168.23.175] (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af38a0asm1460895e9.1.2024.06.27.10.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 10:19:53 -0700 (PDT)
Message-ID: <484dce48-286a-4a2b-9040-98c45bcfb563@linaro.org>
Date: Thu, 27 Jun 2024 19:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] tests/qtest: Disable npcm7xx_sdhci tests using
 hardcoded RCA
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 Shengtan Mao <stmao@google.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-16-philmd@linaro.org>
 <c11ff772-2b85-40ec-b577-a6d996be015d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c11ff772-2b85-40ec-b577-a6d996be015d@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/6/24 18:47, Thomas Huth wrote:
> On 27/06/2024 18.22, Philippe Mathieu-Daudé wrote:
>> Disable tests using 0x4567 hardcoded RCA otherwise when
>> using random RCA we get:
>>
>>    ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: 
>> assertion failed: (ret == len)
>>    not ok /arm/npcm7xx_sdhci/read_sd - 
>> ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: 
>> assertion failed: (ret == len)
>>    Bail out!
>>
>> See 
>> https://lore.kernel.org/qemu-devel/37f83be9-deb5-42a1-b704-14984351d803@linaro.org/
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Cc: Hao Wu <wuhaotsh@google.com>
>> Cc: Shengtan Mao <stmao@google.com>
>> Cc: Tyrone Ting <kfting@nuvoton.com>
>> ---
>>   tests/qtest/npcm7xx_sdhci-test.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/qtest/npcm7xx_sdhci-test.c 
>> b/tests/qtest/npcm7xx_sdhci-test.c
>> index 5d68540e52..6a42b142ad 100644
>> --- a/tests/qtest/npcm7xx_sdhci-test.c
>> +++ b/tests/qtest/npcm7xx_sdhci-test.c
>> @@ -44,6 +44,7 @@ static QTestState *setup_sd_card(void)
>>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 
>> 8));
>>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
>>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, 
>> SDHC_SEND_RELATIVE_ADDR);
>> +    g_test_skip("hardcoded 0x4567 card address");
> 
> This g_test_skip here does not make too much sense (since you're doing 
> it in the caller site, too) ... could you please replace it with a 
> proper comment why this code needs to be reworked? Thanks!

Sorry I forgot to tag "NOTFORMERGE". Ideally I'd wait Google
maintainers to fix the test so we don't need this patch. If
they don't I'll update as you suggested.
(An alternative I haven't investigated is to run the test
using the -seed argument to force deterministic mode).

Thanks!

> 
>   Thomas
> 
> 
>>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
>>                      SDHC_SELECT_DESELECT_CARD);
>> @@ -76,6 +77,9 @@ static void test_read_sd(void)
>>   {
>>       QTestState *qts = setup_sd_card();
>> +    g_test_skip("hardcoded 0x4567 card address used in 
>> setup_sd_card()");
>> +    return;


