Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F5E9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDbb-0005pU-BJ; Thu, 05 Feb 2026 23:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDbZ-0005mQ-CN
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:38:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDbX-0005UI-L0
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:38:05 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso10664635ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770352682; x=1770957482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RRwKY3nli2LljDPRvN/crfqQ8tzmZx2uALOIrej2j1E=;
 b=K71N5+ISONxVhHSCybU4F86QRqip84HIIMxxeVyf93vcdPMNmdi4mI4JNbHjyVQC2I
 /iEEHBfWOYYpW71a5kxDIjt/XuTEdmVZKFhd9/0xgMOAdjcSwpOiQuq2fmrxECD1zRij
 OkGI0M9pB5xavmUAstbVXo6QRPySnSb6Y1o7DU1n/EIVpzfYvSIE9f11BYc9kfeJcesa
 cisnxkgjueax+IeubkN/617tD/g1lHAkKOE/R8iBHnxGxJ2D4Nvby73Ffe77T220HwVO
 U4e58jY+kra5NTKl78LK6ae3ZutFpZP/ZWzoCh9op+4VxYX8SXDotvkshg4/rQ/I1Lh9
 msDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770352682; x=1770957482;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRwKY3nli2LljDPRvN/crfqQ8tzmZx2uALOIrej2j1E=;
 b=bNlNS1YjuFPVEXRrIZFcul5pjlEiEhnxOSkoP2i6U9IrmWNHJpXQ2yiY/XGDFTVGUv
 +k84Vg//cLVGAr0MkB4B/Kk9MDANLj18pEPdOUKdHIZneKlg39B88durQ6Mw7oz2JJKf
 PCi86s7vVs7yFWrA4b/sjuqUm6ZIIbi3ajCQbosQ9Zj7QsCraC7mVPjRL631XzdUlumD
 /RvmItQZ1510UpxvHUBlwi5kab2sOp4vwPH6rSYWcZMuuhoJR6x7DzOGwbUzKKwCXt4j
 CyITcQu0uUxR1tdH1fz08USvFN/JXbbb2DcTMZ7n+Cox4rmNciZLPjUK2jS8zkdTWbLq
 Z7Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYRMihIZYAR/n19GEWtVhuFLcN3tdUuJfVUTMoQleK5nLcegZsWgYCZUBI4SPAA6qJIqiv3vaxL3Tq@nongnu.org
X-Gm-Message-State: AOJu0YzQaYPgsanorQ94pUQ7dEx2eunx5SdjvzHwbL6ui5OnPdHqOj6/
 uBlKU0cjIzAUc0WKM22kvbCCYtX71xgaSiYQONiolIz6PeapBuwtywmCFkK9UzS8xLU=
X-Gm-Gg: AZuq6aLlKWJ1ftr9a1kh9FsliPrfbsXpE+Z/F7ix743F/SS1cIHmDJOR4OsOEj3Fgco
 egBxJMiG6tcfsbMHNwtybXM7pIylqMWcY/8mY+7No9Ph5WVVqbANlmcyUjQzhs5mE0PclgMfgRP
 BfcY21iHCrFoSODDkpVOi9Whe4ZWNXnQowmCE+Od/vLTayR4t7iVu7dHZTYd8t0P8EMCuj6aE+W
 GX/GA2du1c6vObSCNS+uIR6RvDSKI6GcyC2rPH+Eo42n41sbt08w3XvXY7ydESeUsW0NQbMpxGj
 63FRlVXox0x/YRnIakD2PhV+TEPGmICKQBc4h+diMUNF7pjJ2/i+mAytzknubiEqdHZLwk7E/BY
 dwvgE0STEPgA+eKoj7AbjK8XDAqu7H3pgV4VgQCEWP3gpbJu51XOdXOpoZOVi4DIFDd4pcF8s4M
 LeXcGYk31KZ6lsOCKNS3DdtLhxcFFOoCC+u6+hZX5dLHzLsL1tf7+YCw/M
X-Received: by 2002:a17:903:f84:b0:29d:9755:9bd8 with SMTP id
 d9443c01a7336-2a95164ede8mr15891895ad.22.1770352681946; 
 Thu, 05 Feb 2026 20:38:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c9d415sm9771745ad.42.2026.02.05.20.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 20:38:01 -0800 (PST)
Message-ID: <3af8310d-8a0e-424a-8f98-88a2889ed7f4@linaro.org>
Date: Thu, 5 Feb 2026 20:38:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] single-binary: hw/virtio
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <571ef1d1-88f1-4f4c-9800-00f114a85e02@linaro.org>
 <20260205014101-mutt-send-email-mst@kernel.org>
 <59bea9ee-d874-446e-9ec3-b14449d856e4@linaro.org>
 <20260205183849.GA50663@fedora>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260205183849.GA50663@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/5/26 10:38 AM, Stefan Hajnoczi wrote:
> On Thu, Feb 05, 2026 at 09:17:03AM -0800, Pierrick Bouvier wrote:
>> On 2/4/26 10:43 PM, Michael S. Tsirkin wrote:
>>> On Wed, Feb 04, 2026 at 09:27:10PM -0800, Pierrick Bouvier wrote:
>>>> On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
>>>>> This series eliminates target specifics in hw/virtio and replace them with
>>>>> runtime functions where needed.
>>>>>
>>>>> Performance has been measured with this automated fio benchmark, with
>>>>> original instructions from Stefan [1].
>>>>>
>>>>> $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_64_io_benchmark
>>>>> $ cd qemu-linux-stack
>>>>> $ ./build.sh
>>>>> $ ./run.sh /path/to/qemu-system-x86_64
>>>>>
>>>>> [1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
>>>>>
>>>>> Results are on 20 runs and expressed in kIOPS:
>>>>> reference: mean=239.2 std_dev=3.48
>>>>> with_series: mean=238.5 std_dev=3.46
>>>>>
>>>>> Performance is on par, and within standard deviation.
>>>>>
>>>>
>>>> Does it look better to you Michael?
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>>
>>> better for sure. is there a reason you dropped stefanha
>>> from CC? he suggested these tests...
>>>
>>
>> I didn't to that intentionally, it seems like he was not added by default
>> from the file set when I posted v4.
>>
>> Stefan, please see cover letter above and let us know if that sounds
>> acceptable to you.
> 
> Yes, the results you posted look fine. Thanks!
> 
> Stefan

Thanks for your answer.

Please don't pull this for now, I found issues with patch 3, which I 
didn't double check before including it in v4, sorry.
I'll find issue and post a v5.

Regards,
Pierrick

