Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FCFC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 18:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzghF-00065L-1u; Tue, 01 Apr 2025 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzghB-00064k-72
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 14:50:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzgh9-0000wI-B3
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 14:50:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso42203965e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743533441; x=1744138241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VHqokpx1vIQYgxOWg50Ci4We9wDar49ny6vi8XyG34=;
 b=TlKttE5dVSmTkRWzFvKaIlxAc9ZAaNGEvitSJt+oSJpN3CZH41p/q8I1N8scffQseR
 eVAIJrpzoMJ8Zyosd3wqAPdFCMEgvKZEFCSbTB2ZmU00ptOzzrfKhj/zkdo3zqkn3TH+
 sRr5Pc+IRFqR9E1f3YkdJVCMgqlSkqfgDQfP1LLkRn/FGZHHpPH1i0tpRODPWsrL24dw
 e8OQ3pHZxNc2Q8yLfHbECRnyZJokZvXc8jyJjqkRCU9rNsjGmIlqpa6FUiRvflZyUZGS
 UfyuMbtMWtAiGaZothbS1qvrjGjrJmsPIGqn1AZS8dlXJr4WfFpFfZtoLYnma7GSPhg9
 2mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743533441; x=1744138241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VHqokpx1vIQYgxOWg50Ci4We9wDar49ny6vi8XyG34=;
 b=rTNDiZ3tSfWl5GJ0GAvIdOLXVGUfGtH86kkwo5PX2NpRd4xpTWCZjM4bB28/QAryON
 Ec+8ZJuuDKu6RdqvJ6WCYm5drl0cRH0z+oD3u63pLLn+NjcJELc+zr33pf+9b15zOS3B
 S71H8LsJ4iAcbUwVvfQLTLzDgd9Doa5rOy86q5+L2MnlHQo7ybBMzKWoLoQelFt32kcL
 i+X2jTGmVPMaU5WQyHIiydTwdhUYy4I5rfubdIHiFiFNGGLnL96VkQC+9nvtG0bGwREN
 ijq1d/xRJ0LQXtx0vrNKktjaJ2vK8O+24tLm3qTfEXJ6MGjA9ZcRlsM3DGz/ux2m0vgD
 iiFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMNtJFKkLWADsAZRF24rwAopg0Qif4OMZEVjxAcWcrlzjLCCajLms8SiIt1kX7hWnuogof2ZK/SlDE@nongnu.org
X-Gm-Message-State: AOJu0Yy5jc9GhoEd2xibdTp5F1vm7iFWcWn6uZPzWiBSnl0O6w16Q8xk
 Jb4jzLFByOOa+kLti/g/BoStfaSX2sNFM/ylwMezZHK7axmWg2Ov6HmKuKrUdtM=
X-Gm-Gg: ASbGncscLjikWtfixeXMtYwS69f7iht5OxDNPL/4UVA+LFFMKAHDLYDJkDQyJ7nj5/V
 P1nnh4nLDPkAZEyDJ/qZKXARQNyzM/E3HMPZ8XOp9jXeeWFsVCozz9CzXgihiujnfEp+Pkh2z+N
 54tGUfJFQNmUgYyBDG1Y8AZCh/nfCGLWHbXTY6UT1kk51gubrMcB8kbsFBgUF0TKps42pVG3brY
 1hJ38inWQ4+UBlkdyYmwdUqb2XvRwF2Xck+OKqSiVInBLZk4JDq/1X5P85I7FLytA+nBdl0EWzU
 7pR/EL17vVjtoOFnLVUBT+UuA2UJUzdkR8d8wL66wPenZXjTpcaue2SJNkfrsGPN+pvcU4fkVpw
 6Arv4FrQjUiOPfxvMav7Cma0=
X-Google-Smtp-Source: AGHT+IEFdcVan1Ual+1jUQV0IpPKM4MCpGCqkzK2zO+YaD0GIf8Rlb+PxQTullc4FUL28Q+4u+iVKg==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43db6228049mr110128375e9.12.1743533441499; 
 Tue, 01 Apr 2025 11:50:41 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbbfebasm163422815e9.10.2025.04.01.11.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 11:50:40 -0700 (PDT)
Message-ID: <44720e82-808c-4749-917b-bcc0d1c92d1d@linaro.org>
Date: Tue, 1 Apr 2025 20:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
 <c474f845-3d3b-4060-94c2-0d7b5f044d82@linaro.org>
 <5f5f280c-34a5-4961-a9c0-74df5e0b0387@linaro.org>
 <0c042bd1-7ff9-4ac9-8c75-0f0c63d43132@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c042bd1-7ff9-4ac9-8c75-0f0c63d43132@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/4/25 16:59, Pierrick Bouvier wrote:
> On 4/1/25 07:44, Philippe Mathieu-Daudé wrote:
>> On 1/4/25 16:33, Pierrick Bouvier wrote:
>>> On 3/31/25 23:15, Philippe Mathieu-Daudé wrote:
>>>> Hi Pierrick,
>>>>
>>>> On 1/4/25 01:42, Pierrick Bouvier wrote:
>>>>> Nothing prevent plugins to be enabled on this platform for user
>>>>> binaries, only the option in the driver is missing.
>>>>
>>>> Per commit 903e870f245 ("plugins/api: split out binary
>>>> path/start/end/entry code") this is deliberate:
>>>>
>>>>        The BSD user-mode command line is still missing -plugin.
>>>>        This can be enabled once we have reliable check-tcg tests
>>>>        working for the BSDs.
>>>>
>>>> Should we enable this without test harnessing?
>>>>
>>>
>>> Thanks for pointing this.
>>>
>>> However, I don't get the argument, as the same could be said about
>>> system mode, which runs on BSD also, and already has plugins enabled.
>>> The coupling between user related code and plugins is very low (just
>>> options parsing and init code), so I don't see why we could have a bug
>>> related to a specific platform only for user binaries.
>>>
>>> So either we deactivate plugins completely for bsd binaries, or we take
>>> a leap of faith that it works for them.
>>>
>>> @Alex, any further insight on this?
>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>     bsd-user/main.c | 12 ++++++++++++
>>>>>     1 file changed, 12 insertions(+)
>>>>
>>>> Ideally we'd have helpers for common user code in common-user/...
>>>>
>>>
>>> Everything is already common for plugins, except adding the call to
>>> plugin command line option parsing function.
>>
>> Yeah, I mean the rest of main() ;)
>>
> 
> It's not a priority at the moment, and not blocking anything on our 
> path, but yes, it would be nice to share more ideally.

Just to be clear, I was not asking you to do that suggestion.

>>>> Anyway, since this patch does what it says:
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>
>>> Thanks,
>>> Pierrick
>>>
>>
> 


