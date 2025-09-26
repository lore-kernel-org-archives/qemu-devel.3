Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1112BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2AcE-0007i8-Ne; Fri, 26 Sep 2025 11:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Ac5-0007bd-IH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:44:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2Abz-0001JM-Vv
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:44:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-330469eb750so2638888a91.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758901431; x=1759506231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ra8QnQqfsGiXDpU/ZxfE1BAu0nMnF2EF83yfvogVFvA=;
 b=UHpZlT+fFsmZlA4VYX6qgjCq64WHVyAYwAbZiocgsr31guYxSSy5LXn/ffAug0XP5F
 qcjfsPG+NiYSdgkWxZo++TMGvNkCt1QWpE4TRiBTH3jXz33Flq2hPbWKrOVhbuGDtu28
 eeEwtX771ErUeTd6pwKn1HnjLB7eM04+RwKDxQaGI4s/bP/oReNw7rXXk6L7dSCKarZX
 0OAVH03wb/E+g8mkwghTdM98bpt/dHS+gvkg3imGutw40qx4QpSwZ6rtDsOlahiwZg3n
 MtyunEhaq+0xqwpVXuce8gw+IPotlHrm2bZbzfn8dSLsnZsAtPE3IKFhD8t/+XwX/bKU
 haDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901431; x=1759506231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ra8QnQqfsGiXDpU/ZxfE1BAu0nMnF2EF83yfvogVFvA=;
 b=AU/A0g0IKdaMZHHBbBre+jQKVocsodRqzAUvPqFxlOnAmgD3fJZizhFmHN0Typ10qE
 T8eYloiqHnFmwhXx653nwWPr4OMqpUUdn8HmSbvGZngf3dSzapYQYSkJnqC5wZ50MWGS
 LpDEDhYVlmPhRJ8jEqoAXj5qpW7RkTcvbXXADSHKDCbce6Wvl2jfEP6oSiD/W3EZnNSs
 aBStrPmaXmUbBAG9/H/XbB4sAiA/tZOJ2eAwcL+eEM2k7iHXSPuFGgm/fsh4rvSl+0Mg
 GNNLqf8B+49qZfjOzpfZwvDvNe2P/vehci+wm9Jqjrphj695+jWyxcmCQsen8kX4XN/u
 dAew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX++WJWdlNk1rIWiK6T62ShsTIZ19lvY1UuH6nJ0SK8+wE6oadP17SzPsiW/70swsg/a6aKB0GY2hCi@nongnu.org
X-Gm-Message-State: AOJu0Yyl4i+LirwPRkZmNSBuiiMO2+CJU02vFMmL37n55oVYKgFaB9CC
 QH/ttvpjuUwRTOJ69omgjTFvnX65BtiCbBUGxCFJcRamXy3xrQUin/Wk5tTuPSutBnmu1AHd6yZ
 aBPmb
X-Gm-Gg: ASbGncuIakb+2SZfz6EBqr1WnEbRCCmL4gNXNKBrdwqbng8uYwspTmfkRFyVinzxKJg
 A552mrR/BSAnb+kV5OnDnnsU2wRLDyiPuatc007IgTk5lmQGbORufS8x5zIMhVqeE0gbqMCX3sb
 T5+69Tjo5q14tfL7j9WaK8YKyJqeS6rP5lvsfljxBVierzOpRhXz7B+kNPujujnbwhd+Xd/5eny
 AP3fqCSRrx/b7oGTpH9avVLt8XVfAZhg7L5hkOqKbHHWGT/HKrMGa6hG9wYKSo5CHtYOAz2pG9s
 Fv7YtvmGorQghlO4oZrkZ2nPU3jS7tyGJz4gUt8YjjQ8tFODcuukjmUET8tru90hfLQKXXgJxqw
 aUBB7v52AbcEolFp82VS7CT/m33HqR2fvBNkvxFi1K6bvYp8zjyavrPqk+BcwOn/f
X-Google-Smtp-Source: AGHT+IHpFjC/RMYj3TNX/sp9pXx1G3WZDdGpu+fHlbsiZOoatyS9S50j+gvIAWMWwEGx4OSudIRAZQ==
X-Received: by 2002:a17:90b:1c91:b0:32d:f352:f75c with SMTP id
 98e67ed59e1d1-3342a26b46bmr6856273a91.13.1758901430797; 
 Fri, 26 Sep 2025 08:43:50 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33471d711a6sm5777985a91.6.2025.09.26.08.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 08:43:50 -0700 (PDT)
Message-ID: <34599995-fe56-436d-82c2-3837037a58a8@linaro.org>
Date: Fri, 26 Sep 2025 12:43:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102a.google.com
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

Hi Thomas!

On 9/26/25 05:34, Thomas Huth wrote:
> On 26/09/2025 07.15, Gustavo Romero wrote:
>> Add check-venv target as a dependency for the functional tests. This
>> causes Python modules listed in pythondeps.toml, under the testdeps
>> group, to be installed when 'make check-functional' is executed to
>> prepare and run the functional tests.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/Makefile.include | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 3538c0c740..d012a9b25d 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
>>       @$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>>   .PHONY: check-functional
>> -check-functional:
>> +check-functional: check-venv
> 
> I just noticed that there's still a problem: If you run "make check-functional-aarch64" immediately after configuring + compiling QEMU in a fresh folder for the first time, the functional tests fail with:
> 
> ModuleNotFoundError: No module named 'pygdbmi'
> 
> We either need to add dependencies to the check-functional-<arch> targets, too, or we have to make sure that tests still get properly skipped in the case that pygdbmi has not been installed into the venv yet.

Isn't it inconsistent that check-functional runs the test and
check-functional-<arch> doesn't? I think it's a good idea to
skip if the module is not available, yeah, I'll add it in v6,
but would it be ok to add check-venv to the check-functional-<arch>
targets too? That solution feels a tad cumbersome to me to make
them consistent but really I don't have any better idea...


Cheers,
Gustavo

